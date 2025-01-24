import {
  Body,
  Controller,
  Delete,
  Get,
  Param,
  Post,
  Put,
} from '@nestjs/common';
import { CreateDto } from './dto/create.dto';
import { CajaService } from './caja.service';
import { UpdateDTo } from './dto/update.dto';

@Controller('caja')
export class CajaController {
  constructor(private cajaService: CajaService) {}

  @Post()
  create(@Body() body: CreateDto) {
    return this.cajaService.create(body);
  }

  @Get()
  listaCajas() {
    return this.cajaService.listaCajas();
  }

  @Get('user-id/:id')
  getCajaWithUserId(@Param('id') param: string) {
    return this.cajaService.getCajaWithUserId(param);
  }

  @Delete(':id')
  borrarCaja(@Param('id') param: string) {
    return this.cajaService.borrarCaja(param);
  }

  @Put(':id')
  actualizarCaja(@Body() body: UpdateDTo, @Param('id') param: string) {
    return this.cajaService.actualizarCaja(body, param);
  }
}
