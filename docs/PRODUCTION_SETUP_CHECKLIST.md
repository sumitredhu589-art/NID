# NID Production Setup Checklist

## Repository Production Integration Status (Codebase)
- [x] Backend env validation enforces required secrets in production mode
- [x] Backend auth supports production Firebase verification with development OTP fallback
- [x] Backend AI proxy supports OpenAI with development fallback handling
- [x] JWT refresh/session persistence wired with Prisma session records
- [x] Mobile onboarding wired to backend OTP send/verify APIs with fallback UX
- [x] Mobile AI screen wired to backend AI endpoint with fallback UX
- [x] Home shell navigation can return to home and reach profile/gallery/menu/reels/AI/communication paths
- [x] Backend lint/build/test/e2e pipelines pass locally
- [ ] Flutter analyze/test/build executed in this environment (Flutter SDK unavailable in sandbox)

## Core Infrastructure
- [ ] Production PostgreSQL instance provisioned and network-restricted
- [ ] Production Redis instance provisioned and network-restricted
- [ ] Object storage provisioned (AWS S3 bucket for media)
- [ ] CloudFront distribution configured for media delivery
- [ ] SMTP provider/account configured
- [ ] Domain + TLS certificates configured
- [ ] Secrets manager configured (AWS Secrets Manager / Vault / GCP Secret Manager)

## Backend Runtime Secrets / Environment Variables
- [ ] `NODE_ENV=production`
- [ ] `PORT`
- [ ] `ALLOWED_ORIGINS` (comma-separated production client origins)
- [ ] `DATABASE_URL`
- [ ] `REDIS_URL`
- [ ] `JWT_ACCESS_TOKEN_SECRET` (high entropy)
- [ ] `JWT_REFRESH_TOKEN_SECRET` (high entropy)
- [ ] `OPENAI_API_KEY`
- [ ] `OPENAI_API_BASE` (if non-default)
- [ ] `FIREBASE_PROJECT_ID`
- [ ] `FIREBASE_CLIENT_EMAIL`
- [ ] `FIREBASE_PRIVATE_KEY`
- [ ] `FIREBASE_API_KEY`
- [ ] `FIREBASE_AUTH_DOMAIN`
- [ ] `FIREBASE_STORAGE_BUCKET`
- [ ] `GOOGLE_MAPS_API_KEY`
- [ ] `GOOGLE_PLACES_API_KEY`
- [ ] `GOOGLE_DIRECTIONS_API_KEY`
- [ ] `GOOGLE_OAUTH_CLIENT_ID`
- [ ] `GOOGLE_OAUTH_CLIENT_SECRET`
- [ ] `AWS_ACCESS_KEY_ID`
- [ ] `AWS_SECRET_ACCESS_KEY`
- [ ] `AWS_REGION`
- [ ] `AWS_S3_BUCKET_NID_MEDIA`
- [ ] `AWS_CLOUDFRONT_DISTRIBUTION_ID`
- [ ] `SMTP_HOST`
- [ ] `SMTP_PORT`
- [ ] `SMTP_USER`
- [ ] `SMTP_PASS`
- [ ] `SMTP_FROM_ADDRESS`
- [ ] Optional `TWILIO_ACCOUNT_SID`
- [ ] Optional `TWILIO_AUTH_TOKEN`
- [ ] Optional `TWILIO_PHONE_NUMBER`
- [ ] `SENTRY_DSN` (recommended)

## Firebase Setup
- [ ] Create Firebase project
- [ ] Enable Phone Authentication
- [ ] Generate service account credentials
- [ ] Configure Android SHA certificates
- [ ] Configure iOS bundle/app settings
- [ ] Export Android `google-services.json`
- [ ] Export iOS `GoogleService-Info.plist`

## Google Maps / Places / Directions
- [ ] Create GCP project
- [ ] Enable Maps SDK + Places API + Directions API
- [ ] Create restricted API keys per platform/service
- [ ] Configure API key restrictions (bundle/package/IP/domain)

## AWS / Media
- [ ] S3 bucket policy for private upload and controlled read
- [ ] CloudFront origin access configured
- [ ] Signed URL/Cookie strategy configured
- [ ] Lifecycle policies for media retention and cost control

## OAuth Connectors
- [ ] Register each connector provider app
- [ ] Set redirect URIs
- [ ] Store client IDs/secrets in secret manager
- [ ] Implement connector consent screens and scopes review

## Mobile Signing and Release
- [ ] Android keystore generated and stored securely
- [ ] Android signing config + Play Console app configured
- [ ] iOS certificates/profiles in Apple Developer account
- [ ] App Store Connect app record configured
- [ ] Privacy policy and data safety declarations completed

## CI/CD and Quality Gates
- [ ] GitHub Actions secrets configured
- [ ] Backend lint/test/build workflow green
- [ ] Prisma validation/migration workflow green
- [ ] Flutter analyze/test/build workflow green
- [ ] Dependency/vulnerability scans enabled
- [ ] Backup and restore strategy validated

## Deployment Steps
- [ ] Run DB migrations on production database
- [ ] Deploy backend image/service
- [ ] Deploy mobile builds to stores/internal channels
- [ ] Smoke test onboarding, auth, home gestures, AI, communication, notifications, conversations, search/maps, camera, gallery, reels, profile
- [ ] Enable monitoring/alerts/log shipping
- [ ] Run security checks and incident response drill
