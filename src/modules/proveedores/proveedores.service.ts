import { HttpException, HttpStatus, Injectable } from '@nestjs/common';
import { PrismaClientKnownRequestError } from '@prisma/client/runtime/library';
import { PrismaService } from 'src/database/prisma/prisma.service';
import { CreateDto } from './dto/create.dto';
import { UpdateDto } from './dto/update.dto';

@Injectable()
export class ProveedoresService {
  constructor(private prismaService: PrismaService) {}

  async borrarProveedor(id: string) {
    try {
      await this.prismaService.proveedores.delete({
        where: {
          id_proveedor: id,
        },
      });
    } catch (error) {
      console.log(error);

      if (error instanceof HttpException) {
        throw error;
      } else if (error instanceof PrismaClientKnownRequestError) {
        throw new HttpException(
          'Error al borrar el proveedor',
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

  async listaProveedores() {
    try {
      const list = await this.prismaService.proveedores.findMany();
      return list;
    } catch (error) {
      console.log(error);
      if (error instanceof HttpException) {
        throw error;
      } else if (error instanceof PrismaClientKnownRequestError) {
        throw new HttpException(
          'Error al listar los proveedores.',
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

  async create(data: CreateDto) {
    try {
      const newProveedor = await this.prismaService.proveedores.create({
        data: {
          ...data,
        },
      });

      return newProveedor;
    } catch (error) {
      console.log(error);
      if (error instanceof HttpException) {
        throw error;
      } else if (error instanceof PrismaClientKnownRequestError) {
        throw new HttpException(
          'Error al crear el proveedores.',
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

  async update(data: UpdateDto, id: string) {
    try {
      const updateProveedor = await this.prismaService.proveedores.update({
        where: {
          id_proveedor: id,
        },
        data: {
          ...data,
        },
      });
      return updateProveedor;
    } catch (error) {
      console.log(error);

      if (error instanceof HttpException) {
        throw error;
      } else if (error instanceof PrismaClientKnownRequestError) {
        throw new HttpException(
          'Error al actualizar el proveedor.',
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
