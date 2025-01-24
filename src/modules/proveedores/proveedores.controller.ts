import {
  Body,
  Controller,
  Delete,
  Get,
  Param,
  Post,
  Put,
} from '@nestjs/common';
import { ProveedoresService } from './proveedores.service';
import { CreateDto } from './dto/create.dto';
import { UpdateDto } from './dto/update.dto';

@Controller('proveedores')
export class ProveedoresController {
  constructor(private proveedorService: ProveedoresService) {}

  @Get()
  listaProveedores() {
    return this.proveedorService.listaProveedores();
  }

  @Post()
  create(@Body() body: CreateDto) {
    return this.proveedorService.create(body);
  }

  @Delete(':id')
  borrarProveedores(@Param('id') param: string) {
    return this.proveedorService.borrarProveedor(param);
  }

  @Put(':id')
  update(@Body() body: UpdateDto, @Param('id') param: string) {
    console.log(body, param);

    return this.proveedorService.update(body, param);
  }
}
