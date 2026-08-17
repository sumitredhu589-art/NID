import { Body, Controller, Post } from '@nestjs/common';
import { ApiTags } from '@nestjs/swagger';
import { IsString, Length } from 'class-validator';
import { AuthService } from './auth.service';

class SendOtpDto {
  @IsString()
  @Length(7, 20)
  phoneNumber!: string;
}

class VerifyOtpDto {
  @IsString()
  phoneNumber!: string;

  @IsString()
  @Length(4, 8)
  otp!: string;
}

class RefreshDto {
  @IsString()
  refreshToken!: string;
}

@ApiTags('auth')
@Controller('auth')
export class AuthController {
  constructor(private readonly authService: AuthService) {}

  @Post('send-otp')
  sendOtp(@Body() dto: SendOtpDto) {
    return this.authService.sendOtp(dto.phoneNumber);
  }

  @Post('verify-otp')
  verifyOtp(@Body() dto: VerifyOtpDto) {
    return this.authService.verifyOtp(dto.phoneNumber, dto.otp);
  }

  @Post('refresh')
  async refresh(@Body() dto: RefreshDto) {
    return { accessToken: await this.authService.refresh(dto.refreshToken) };
  }

  @Post('logout')
  logout(@Body() dto: RefreshDto) {
    return this.authService.logout(dto.refreshToken);
  }
}
