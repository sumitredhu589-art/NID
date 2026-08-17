import { Body, Controller, Post } from '@nestjs/common';
import { ApiTags } from '@nestjs/swagger';
import { IsString } from 'class-validator';
import { AiService } from './ai.service';

class PromptDto {
  @IsString()
  prompt!: string;
}

@ApiTags('ai')
@Controller('ai')
export class AiController {
  constructor(private readonly aiService: AiService) {}

  @Post('chat')
  async chat(@Body() dto: PromptDto) {
    return this.aiService.reply(dto.prompt);
  }
}
