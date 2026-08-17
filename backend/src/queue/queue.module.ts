import { Global, Module } from '@nestjs/common';
import { Queue } from 'bullmq';

export const REMINDER_QUEUE = 'REMINDER_QUEUE';

@Global()
@Module({
  providers: [
    {
      provide: REMINDER_QUEUE,
      useFactory: () => {
        if (!process.env.REDIS_URL && process.env.NODE_ENV !== 'production') {
          return { add: async () => ({ id: 'dev-reminder-job' }) };
        }
        return new Queue('reminders', {
          connection: { url: process.env.REDIS_URL || 'redis://localhost:6379' },
        });
      },
    },
  ],
  exports: [REMINDER_QUEUE],
})
export class QueueModule {}
