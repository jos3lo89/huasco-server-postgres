import { HttpException, HttpStatus, Injectable } from '@nestjs/common';
import { PrismaClientKnownRequestError } from '@prisma/client/runtime/library';
import { PrismaService } from 'src/database/prisma/prisma.service';
import { CreateDto } from './dto/create.dto';
import { UpdateDto } from './dto/update.dto';

@Injectable()
export class CategoriasService {
  constructor(private prismaService: PrismaService) {}

  async listaCategoria() {
    try {
      const list = await this.prismaService.categorias.findMany();
      return list;
    } catch (error) {
      console.log(error);
      if (error instanceof HttpException) {
        throw error;
      } else if (error instanceof PrismaClientKnownRequestError) {
        throw new HttpException(
          'Error al listar las categorias.',
          HttpStatus.BAD_REQUEST,
        );
      } else {
        throw new HttpException(
          'Error interno del servidor.',
          HttpStatus.INTERNAL_SERVER_ERROR,
        );
      }
    }
  }

  async createCategoria(data: CreateDto) {
    try {
      const findCategoria = await this.prismaService.categorias.findFirst({
        where: {
          nombre: data.nombre,
        },
      });

      if (findCategoria) {
        throw new HttpException(
          'La categoría ya existe.',
          HttpStatus.BAD_REQUEST,
        );
      }

      const newCategoria = await this.prismaService.categorias.create({
        data: {
          nombre: data.nombre,
          estado: data.estado,
        },
      });

      return newCategoria;
    } catch (error) {
      console.log(error);
      if (error instanceof HttpException) {
        throw error;
      } else if (error instanceof PrismaClientKnownRequestError) {
        throw new HttpException(
          'Error al crear la categoria.',
          HttpStatus.BAD_REQUEST,
        );
      } else {
        throw new HttpException(
          'Error interno del servidor.',
          HttpStatus.INTERNAL_SERVER_ERROR,
        );
      }
    }
  }

  async borrarCategoria(id: string) {
    try {
      await this.prismaService.categorias.delete({
        where: {
          id_categoria: id,
        },
      });
    } catch (error) {
      console.log(error);
      if (error instanceof HttpException) {
        throw error;
      } else if (error instanceof PrismaClientKnownRequestError) {
        throw new HttpException(
          'Error al borrar la categoria.',
          HttpStatus.BAD_REQUEST,
        );
      } else {
        throw new HttpException(
          'Error interno del servidor.',
          HttpStatus.INTERNAL_SERVER_ERROR,
        );
      }
    }
  }

  async actualizarCategoria(data: UpdateDto, id: string) {
    try {
      const updateCategoria = await this.prismaService.categorias.update({
        where: {
          id_categoria: id,
        },
        data,
      });

      return updateCategoria;
    } catch (error) {
      console.log(error);
      if (error instanceof HttpException) {
        throw error;
      } else if (error instanceof PrismaClientKnownRequestError) {
        throw new HttpException(
          'Error al actualizar la categoria.',
          HttpStatus.BAD_REQUEST,
        );
      } else {
        throw new HttpException(
          'Error interno del servidor.',
          HttpStatus.INTERNAL_SERVER_ERROR,
        );
      }
    }
  }
}
