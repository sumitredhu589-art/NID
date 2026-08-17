import { IsOptional, IsString, IsUrl } from 'class-validator';

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
}
