import { Body, Controller, Get, Post } from '@nestjs/common';
import { VentaService } from './venta.service';
import { CreateVentaDto } from './dto/create.dto';

@Controller('venta')
export class VentaController {
  constructor(private ventaService: VentaService) {}

  @Post()
  create(@Body() body: CreateVentaDto) {
    return this.ventaService.create(body);
  }

  @Get()
  listAllVentas() {
    return this.ventaService.listAllVentas();
  }
}
