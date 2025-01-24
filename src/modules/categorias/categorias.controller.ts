import {
  Body,
  Controller,
  Delete,
  Get,
  Param,
  Post,
  Put,
} from '@nestjs/common';
import { CategoriasService } from './categorias.service';
import { CreateDto } from './dto/create.dto';
import { UpdateDto } from './dto/update.dto';

@Controller('categorias')
export class CategoriasController {
  constructor(private categoriaService: CategoriasService) {}

  @Get()
  listaCategorias() {
    return this.categoriaService.listaCategoria();
  }

  @Post()
  createCategoria(@Body() body: CreateDto) {
    return this.categoriaService.createCategoria(body);
  }

  @Delete(':id')
  borrarCategoria(@Param('id') param: string) {
    return this.categoriaService.borrarCategoria(param);
  }

  @Put(':id')
  actualizarCategoria(@Body() body: UpdateDto, @Param('id') param: string) {
    return this.categoriaService.actualizarCategoria(body, param);
  }
}
