import { AiService } from './ai.service';

describe('AiService', () => {
  it('returns development fallback when api key is missing', async () => {
    const originalApiKey = process.env.OPENAI_API_KEY;
    delete process.env.OPENAI_API_KEY;
    const service = new AiService();

    const response = await service.reply('hello');

    expect(response.fallback).toBe(true);
    expect(response.message).toContain('DEV_FALLBACK');
    process.env.OPENAI_API_KEY = originalApiKey;
  });
});
