import { Body, Controller, Get, Param, Patch, Post, UseGuards } from '@nestjs/common';
import { ApiTags } from '@nestjs/swagger';
import { InMemoryResourceService } from './in-memory-resource.service';
import { JwtAccessGuard } from '../security/jwt-access.guard';

function createController(route: string, tag: string, secure: boolean) {
  @ApiTags(tag)
  @Controller(route)
  @UseGuards(...(secure ? [JwtAccessGuard] : []))
  class GenericResourceController {
    constructor(readonly service: InMemoryResourceService) {}

    @Get()
    list() {
      return this.service.list(route);
    }

    @Post()
    create(@Body() payload: Record<string, unknown>) {
      return this.service.create(route, payload);
    }

    @Get(':id')
    get(@Param('id') id: string) {
      return this.service.get(route, id);
    }

    @Patch(':id')
    patch(@Param('id') id: string, @Body() payload: Record<string, unknown>) {
      return this.service.update(route, id, payload);
    }
  }

  return GenericResourceController;
}

export function createResourceController(route: string, tag: string, secure = false) {
  return createController(route, tag, secure);
}
