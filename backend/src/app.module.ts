import { Module, Type } from '@nestjs/common';
import { ConfigModule } from '@nestjs/config';
import { JwtModule } from '@nestjs/jwt';
import { AuthModule } from './auth/auth.module';
import { AiModule } from './ai/ai.module';
import { InMemoryResourceService } from './common/in-memory-resource.service';
import { createResourceController } from './common/resource.factory';
import { PrismaModule } from './prisma/prisma.module';
import { QueueModule } from './queue/queue.module';
import { JwtAccessGuard } from './security/jwt-access.guard';

const resources = [
  'users',
  'identities',
  'profiles',
  'sessions',
  'devices',
  'notifications',
  'conversations',
  'messages',
  'contacts',
  'calls',
  'reminders',
  'reels',
  'comments',
  'likes',
  'saves',
  'follows',
  'places',
  'saved-places',
  'connected-accounts',
  'security-events',
  'permissions',
];

const securedResources = new Set(['users', 'sessions', 'security-events', 'devices', 'permissions']);

const controllers: Type[] = resources.map((resource) =>
  createResourceController(resource, resource.replaceAll('-', ' '), securedResources.has(resource)),
);

@Module({
  imports: [
    ConfigModule.forRoot({ isGlobal: true }),
    JwtModule.register({
      secret: process.env.JWT_ACCESS_TOKEN_SECRET || 'dev-secret',
    }),
    PrismaModule,
    QueueModule,
    AuthModule,
    AiModule,
  ],
  controllers,
  providers: [InMemoryResourceService, JwtAccessGuard],
})
export class AppModule {}
