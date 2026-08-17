# NID — One ID. All Access

Production-oriented NID monorepo with:
- `mobile/` Flutter application implementing onboarding, home gestures, AI assistant UI, communication, app menu, notifications, conversations, search/maps, camera, gallery, reels, profile
- `backend/` NestJS API with Prisma/PostgreSQL schema, Redis/BullMQ queue wiring, auth fallback flows, AI proxy endpoint, and feature resources
- `.github/workflows/` CI for backend, Flutter, Prisma validation
- `docs/` architecture and setup docs including `docs/PRODUCTION_SETUP_CHECKLIST.md`

## Local Development

### Backend
```bash
cd backend
npm install
npm run prisma:generate
npm run build
npm run test:e2e
npm run start:dev
```

### Mobile
```bash
cd mobile
flutter pub get
flutter test
flutter run
```

### Infra (optional)
```bash
cd infrastructure
docker compose -f docker-compose.dev.yml up -d
```

## Security and credentials
- Never commit secrets.
- All production credentials are env-driven.
- Development fallbacks are implemented for missing provider credentials.

See `docs/PRODUCTION_SETUP_CHECKLIST.md` for complete production requirements.
