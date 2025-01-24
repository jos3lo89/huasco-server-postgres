import { Module } from '@nestjs/common';
import { VentaController } from './venta.controller';
import { VentaService } from './venta.service';
import { PrismaService } from 'src/database/prisma/prisma.service';

@Module({
  controllers: [VentaController],
  providers: [VentaService, PrismaService],
})
export class VentaModule {}
