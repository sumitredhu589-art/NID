import { Injectable } from '@nestjs/common';
import { randomUUID } from 'crypto';

export type ResourceRecord = Record<string, unknown> & { id: string; createdAt: string };

@Injectable()
export class InMemoryResourceService {
  private readonly buckets = new Map<string, Map<string, ResourceRecord>>();

  private bucket(resource: string) {
    const existing = this.buckets.get(resource);
    if (existing) return existing;
    const next = new Map<string, ResourceRecord>();
    this.buckets.set(resource, next);
    return next;
  }

  list(resource: string) {
    return Array.from(this.bucket(resource).values());
  }

  create(resource: string, payload: Record<string, unknown>) {
    const item: ResourceRecord = { id: randomUUID(), createdAt: new Date().toISOString(), ...payload };
    this.bucket(resource).set(item.id, item);
    return item;
  }

  get(resource: string, id: string) {
    return this.bucket(resource).get(id) ?? null;
  }

  update(resource: string, id: string, payload: Record<string, unknown>) {
    const bucket = this.bucket(resource);
    const existing = bucket.get(id);
    if (!existing) return null;
    const next = { ...existing, ...payload };
    bucket.set(id, next);
    return next;
  }
}
