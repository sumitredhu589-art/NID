# NID — One ID. All Access

This repository contains the complete NID system: a production-oriented Flutter mobile application (iOS & Android), a NestJS backend, PostgreSQL database migrations, Redis sessions, AWS S3 media architecture, Google Maps, OpenAI integration, Firebase OTP authentication scaffolding, CI/CD workflows and full documentation.

This commit is an initial scaffold implementing the repository structure and core services. Follow the docs in /docs for full setup and development instructions.

Structure

NID/
├── mobile/                # Flutter application
├── backend/               # NestJS backend API
├── database/              # SQL migrations
├── infrastructure/        # Docker, Terraform (skeletons)
├── docs/                  # Architecture and setup documentation
├── scripts/               # Utility scripts for setup and deploy
├── .github/               # CI/CD workflows
├── .env.example           # Example environment variables
├── README.md
└── LICENSE

Important

- Never commit real secrets. Use environment variables and secret stores.
- The repository supports a development fallback mode so the app compiles and runs without production credentials.
- See docs/PRODUCTION_SETUP_CHECKLIST.md for the consolidated list of required production credentials and steps.

Next steps

- Read docs/getting-started.md to run the system locally using Docker and Firebase emulator or your Firebase project.
- Populate .env (copy from .env.example) and set required credentials for production.
