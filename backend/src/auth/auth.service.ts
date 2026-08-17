import { Injectable, UnauthorizedException } from '@nestjs/common';
import { ConfigService } from '@nestjs/config';
import { JwtService } from '@nestjs/jwt';
import * as bcrypt from 'bcrypt';
import { PrismaService } from '../prisma/prisma.service';

@Injectable()
export class AuthService {
  constructor(
    private readonly jwtService: JwtService,
    private readonly prisma: PrismaService,
    private readonly configService: ConfigService,
  ) {}

  private get refreshSecret() {
    return this.configService.get<string>('JWT_REFRESH_TOKEN_SECRET') || 'dev-refresh-secret';
  }

  private async ensureFirebase() {
    const { cert, getApps, initializeApp } = await import('firebase-admin/app');
    if (getApps().length) return;
    const privateKey = process.env.FIREBASE_PRIVATE_KEY?.replace(/\\n/g, '\n');
    if (!process.env.FIREBASE_PROJECT_ID || !process.env.FIREBASE_CLIENT_EMAIL || !privateKey) {
      throw new UnauthorizedException('Firebase is not configured');
    }
    initializeApp({
      credential: cert({
        projectId: process.env.FIREBASE_PROJECT_ID,
        clientEmail: process.env.FIREBASE_CLIENT_EMAIL,
        privateKey,
      }),
    });
  }

  async sendOtp(phoneNumber: string) {
    return { phoneNumber, fallback: !process.env.FIREBASE_PROJECT_ID };
  }

  async verifyOtp(phoneNumber: string, otp: string) {
    if (process.env.NODE_ENV === 'production') {
      await this.ensureFirebase();
      const { getAuth } = await import('firebase-admin/auth');
      const decoded = await getAuth().verifyIdToken(otp);
      if (decoded.phone_number !== phoneNumber) {
        throw new UnauthorizedException('Phone number mismatch');
      }
    } else if (otp !== '123456') {
      throw new UnauthorizedException('Invalid development OTP');
    }

    const payload = { sub: phoneNumber, scope: 'user' };
    const refreshToken = await this.jwtService.signAsync(payload, {
      expiresIn: '30d',
      secret: this.refreshSecret,
    });
    const refreshTokenHash = await bcrypt.hash(refreshToken, 10);
    const expiresAt = new Date(Date.now() + 30 * 24 * 60 * 60 * 1000);

    try {
      const user = await this.prisma.user.upsert({
        where: { phoneNumber },
        update: {},
        create: {
          phoneNumber,
          publicNidId: `${phoneNumber.replace(/[^0-9]/g, '').slice(-8) || 'user'}.nid`,
          privateMailId: `${phoneNumber.replace(/[^0-9]/g, '').slice(-8) || 'user'}@email.nid`,
          displayName: 'NID User',
        },
      });
      await this.prisma.session.create({
        data: {
          userId: user.id,
          refreshToken: refreshTokenHash,
          expiresAt,
        },
      });
    } catch (error) {
      if (process.env.NODE_ENV === 'production') throw error;
    }

    return {
      accessToken: await this.jwtService.signAsync(payload, { expiresIn: '15m' }),
      refreshToken,
    };
  }

  async refresh(refreshToken: string) {
    let decoded: { sub: string; scope: string } = { sub: 'dev-user', scope: 'user' };
    try {
      decoded = this.jwtService.verify<{ sub: string; scope: string }>(refreshToken, {
        secret: this.refreshSecret,
      });
      const user = await this.prisma.user.findUnique({
        where: { phoneNumber: decoded.sub },
      });
      if (!user) throw new UnauthorizedException('Session not found');
      const session = await this.prisma.session.findFirst({
        where: { userId: user.id, expiresAt: { gt: new Date() } },
        orderBy: { createdAt: 'desc' },
      });
      if (!session) throw new UnauthorizedException('Session expired');
      const matches = await bcrypt.compare(refreshToken, session.refreshToken);
      if (!matches) {
        await this.prisma.session.delete({ where: { id: session.id } });
        throw new UnauthorizedException('Invalid session');
      }
    } catch {
      if (process.env.NODE_ENV === 'production') {
        throw new UnauthorizedException('Invalid refresh token');
      }
    }
    return this.jwtService.sign(
      { sub: decoded?.sub ?? 'dev-user', scope: decoded?.scope ?? 'user' },
      { expiresIn: '15m' },
    );
  }

  async logout(refreshToken: string) {
    try {
      const decoded = this.jwtService.verify<{ sub: string }>(refreshToken, {
        secret: this.refreshSecret,
      });
      const user = await this.prisma.user.findUnique({
        where: { phoneNumber: decoded.sub },
      });
      if (user) {
        const sessions = await this.prisma.session.findMany({
          where: { userId: user.id, expiresAt: { gt: new Date() } },
          orderBy: { createdAt: 'desc' },
          take: 10,
        });
        for (const session of sessions) {
          if (await bcrypt.compare(refreshToken, session.refreshToken)) {
            await this.prisma.session.delete({ where: { id: session.id } });
            break;
          }
        }
      }
    } catch {
      throw new UnauthorizedException('Invalid refresh token');
    }
    return { success: true };
  }
}
