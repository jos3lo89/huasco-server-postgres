import { Module } from '@nestjs/common';
import { CajaController } from './caja.controller';
import { CajaService } from './caja.service';
import { PrismaService } from 'src/database/prisma/prisma.service';

@Module({
  controllers: [CajaController],
  providers: [CajaService, PrismaService],
})
export class CajaModule {}
