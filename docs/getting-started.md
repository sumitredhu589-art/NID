# Getting Started

## 1) Prerequisites
- Node.js 20+
- npm 10+
- Flutter SDK (for mobile)
- Docker

## 2) Local stack
```bash
cp .env.example .env
cd infrastructure
docker compose -f docker-compose.dev.yml up -d
```

## 3) Backend
```bash
cd backend
npm install
npm run prisma:generate
npm run build
npm test
npm run start:dev
```

## 4) Mobile
```bash
cd mobile
flutter pub get
flutter test
flutter run
```

> If external credentials are missing, app and API run in development fallback mode.
