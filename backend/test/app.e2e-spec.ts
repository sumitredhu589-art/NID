import { INestApplication } from '@nestjs/common';
import { Test } from '@nestjs/testing';
import request from 'supertest';
import { AppModule } from '../src/app.module';

describe('AppController (e2e)', () => {
  let app: INestApplication;

  beforeAll(async () => {
    const moduleFixture = await Test.createTestingModule({ imports: [AppModule] }).compile();
    app = moduleFixture.createNestApplication();
    app.setGlobalPrefix('api');
    await app.init();
  });

  afterAll(async () => {
    await app.close();
  });

  it('/api/auth/send-otp (POST)', async () => {
    const response = await request(app.getHttpServer())
      .post('/api/auth/send-otp')
      .send({ phoneNumber: '+910000000000' })
      .expect(201);
    expect(response.body.phoneNumber).toEqual('+910000000000');
  });

  it('/api/notifications (POST + GET)', async () => {
    const createRes = await request(app.getHttpServer())
      .post('/api/notifications')
      .send({ title: 'Welcome', body: 'NID Ready' })
      .expect(201);
    await request(app.getHttpServer()).get(`/api/notifications/${createRes.body.id}`).expect(200);
  });
});
