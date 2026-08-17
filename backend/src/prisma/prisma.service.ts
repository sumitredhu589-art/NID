import { Injectable, OnModuleInit } from '@nestjs/common';
import { PrismaClient } from '@prisma/client';

@Injectable()
export class PrismaService extends PrismaClient implements OnModuleInit {
  async onModuleInit() {
    try {
      await this.$connect();
    } catch (error) {
      if (process.env.NODE_ENV === 'production') {
        throw error;
      }
      // Development fallback allows API boot without a live database.
    }
  }
}
