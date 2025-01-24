import { HttpException, HttpStatus, Injectable } from '@nestjs/common';
import { PrismaClientKnownRequestError } from '@prisma/client/runtime/library';
import { PrismaService } from 'src/database/prisma/prisma.service';
import { CreateDto } from './dto/create.dto';

@Injectable()
export class ClientesService {
  constructor(private prismaService: PrismaService) {}

  async create(data: CreateDto) {
    try {
      const newClient = await this.prismaService.clientes.create({
        data: {
          ...data,
          numero_telefono:
            data.numero_telefono == '' ? null : data.numero_telefono,
          dni_ruc: data.dni_ruc == '' ? null : data.dni_ruc,
          email: data.email == '' ? null : data.email,
          direccion: data.direccion == '' ? null : data.direccion,
          observaciones: data.observaciones == '' ? null : data.observaciones,
        },
      });
      return newClient;
    } catch (error) {
      console.log(error);
      if (error instanceof HttpException) {
        throw error;
      } else if (error instanceof PrismaClientKnownRequestError) {
        throw new HttpException(
          'Error al registra el cliente.',
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

  async listaClientes() {
    try {
      const list = await this.prismaService.clientes.findMany();
      return list;
    } catch (error) {
      console.log(error);
      if (error instanceof HttpException) {
        throw error;
      } else if (error instanceof PrismaClientKnownRequestError) {
        throw new HttpException(
          'Error al listar los clientes.',
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
