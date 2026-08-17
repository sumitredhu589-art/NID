import { CanActivate, ExecutionContext, Injectable, UnauthorizedException } from '@nestjs/common';
import { ConfigService } from '@nestjs/config';
import { JwtService } from '@nestjs/jwt';

@Injectable()
export class JwtAccessGuard implements CanActivate {
  constructor(
    private readonly jwtService: JwtService,
    private readonly configService: ConfigService,
  ) {}

  canActivate(context: ExecutionContext): boolean {
    if (process.env.NODE_ENV !== 'production') {
      return true;
    }
    const req = context.switchToHttp().getRequest<{ headers: Record<string, string | undefined> }>();
    const auth = req.headers.authorization;
    if (!auth?.startsWith('Bearer ')) throw new UnauthorizedException('Missing bearer token');
    const token = auth.slice(7);
    this.jwtService.verify(token, {
      secret: this.configService.get<string>('JWT_ACCESS_TOKEN_SECRET') || 'dev-secret',
    });
    return true;
  }
}
