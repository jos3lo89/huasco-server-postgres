import { Body, Controller, Get, Param, Post } from '@nestjs/common';
import { ProductosService } from './productos.service';
import { CreateDto } from './dto/create.dto';

@Controller('productos')
export class ProductosController {
  constructor(private productoService: ProductosService) {}

  @Get()
  listaProductos() {
    return this.productoService.listaProductos();
  }

  @Post()
  create(@Body() body: CreateDto) {
    return this.productoService.create(body);
  }

  @Get('categoria/:id')
  getProductWithCategory(@Param('id') param: string) {
    return this.productoService.getProductsWithCategory(param);
  }
}
