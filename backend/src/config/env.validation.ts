import { plainToInstance } from 'class-transformer';
import { IsDefined, IsOptional, IsString, IsUrl, validateSync } from 'class-validator';

export class EnvironmentVariables {
  @IsOptional()
  @IsString()
  NODE_ENV?: string;

  @IsOptional()
  @IsString()
  DATABASE_URL?: string;

  @IsOptional()
  @IsUrl({ require_tld: false })
  REDIS_URL?: string;

  @IsOptional()
  @IsString()
  OPENAI_API_KEY?: string;

  @IsOptional()
  @IsString()
  JWT_ACCESS_TOKEN_SECRET?: string;

  @IsOptional()
  @IsString()
  JWT_REFRESH_TOKEN_SECRET?: string;

  @IsOptional()
  @IsString()
  FIREBASE_PROJECT_ID?: string;

  @IsOptional()
  @IsString()
  FIREBASE_CLIENT_EMAIL?: string;

  @IsOptional()
  @IsString()
  FIREBASE_PRIVATE_KEY?: string;
}

class ProductionEnvironmentVariables extends EnvironmentVariables {
  @IsDefined()
  @IsString()
  DATABASE_URL!: string;

  @IsDefined()
  @IsUrl({ require_tld: false })
  REDIS_URL!: string;

  @IsDefined()
  @IsString()
  JWT_ACCESS_TOKEN_SECRET!: string;

  @IsDefined()
  @IsString()
  JWT_REFRESH_TOKEN_SECRET!: string;
}

export function validateEnvironment(config: Record<string, unknown>) {
  const klass = config.NODE_ENV === 'production' ? ProductionEnvironmentVariables : EnvironmentVariables;
  const validated = plainToInstance(klass, config, { enableImplicitConversion: true });
  const errors = validateSync(validated, { skipMissingProperties: false });
  if (errors.length > 0) {
    throw new Error(errors.map((error) => Object.values(error.constraints ?? {}).join(', ')).join('; '));
  }
  return config;
}
