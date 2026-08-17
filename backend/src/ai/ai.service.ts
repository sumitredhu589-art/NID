import { Injectable } from '@nestjs/common';
import OpenAI from 'openai';

@Injectable()
export class AiService {
  private client: OpenAI | null = null;

  constructor() {
    if (process.env.OPENAI_API_KEY) {
      this.client = new OpenAI({
        apiKey: process.env.OPENAI_API_KEY,
        baseURL: process.env.OPENAI_API_BASE,
      });
    }
  }

  async reply(prompt: string) {
    if (!this.client) {
      return { message: `DEV_FALLBACK: ${prompt}`, fallback: true };
    }

    try {
      const completion = await this.client.chat.completions.create({
        model: 'gpt-4o-mini',
        messages: [{ role: 'user', content: prompt }],
      });
      return { message: completion.choices[0]?.message?.content ?? '', fallback: false };
    } catch (error) {
      if (process.env.NODE_ENV === 'production') throw error;
      return { message: `DEV_FALLBACK: ${prompt}`, fallback: true };
    }
  }
}
