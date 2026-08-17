# NID Architecture

- **Mobile:** Flutter clean architecture layout (`presentation`, `domain`, `data`, `services`) with dark-space NID visual language.
- **Backend:** NestJS + Prisma + PostgreSQL + Redis + BullMQ.
- **Auth:** Firebase phone auth verification path with development OTP fallback.
- **AI:** OpenAI via backend proxy when `OPENAI_API_KEY` exists, development fallback when absent.
- **Maps/Search:** Google APIs when configured, static/dev content fallback when missing.
- **Media/Reels:** S3 + CloudFront in production, MinIO fallback in development.
- **Security:** JWT sessions, device/session structures, strict DTO validation, secret handling through env vars.
