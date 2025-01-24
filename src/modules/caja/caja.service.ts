import { HttpException, HttpStatus, Injectable } from '@nestjs/common';
import { PrismaService } from 'src/database/prisma/prisma.service';
import { CreateDto } from './dto/create.dto';
import { PrismaClientKnownRequestError } from '@prisma/client/runtime/library';
import { UpdateDTo } from './dto/update.dto';

@Injectable()
export class CajaService {
  constructor(private prismaService: PrismaService) {}

  async create(data: CreateDto) {
    try {
      const findCaja = await this.prismaService.caja.findFirst({
        where: {
          numero_caja: data.numero_caja,
        },
      });

      if (findCaja) {
        throw new HttpException(
          'El número de caja ya existe.',
          HttpStatus.BAD_REQUEST,
        );
      }

      const nuevaCaja = await this.prismaService.caja.create({
        data: {
          id_empleado: data.id_empleado,
          nombre: data.nombre,
          efectivo: data.efectivo,
          numero_caja: data.numero_caja,
        },
      });

      return nuevaCaja;
    } catch (error) {
      console.log(error);
      if (error instanceof HttpException) {
        throw error;
      } else if (error instanceof PrismaClientKnownRequestError) {
        throw new HttpException(
          'Error a crear la caja',
          HttpStatus.BAD_REQUEST,
        );
      } else {
        throw new HttpException(
          'Error interno del servidor',
          HttpStatus.INTERNAL_SERVER_ERROR,
        );
      }
    }
  }

  async getCajaWithUserId(id: string) {
    try {
      const caja = await this.prismaService.caja.findFirst({
        where: {
          id_empleado: id,
        },
      });
      return caja;
    } catch (error) {
      console.log(error);
      if (error instanceof HttpException) {
        throw error;
      } else if (error instanceof PrismaClientKnownRequestError) {
        throw new HttpException(
          'Error al buscar la caja del empleado',
          HttpStatus.BAD_REQUEST,
        );
      } else {
        throw new HttpException(
          'Error interno del servidor',
          HttpStatus.INTERNAL_SERVER_ERROR,
        );
      }
    }
  }

  async listaCajas() {
    try {
      const list = await this.prismaService.caja.findMany({
        include: {
          Empleados: {
            select: {
              id_empleado: true,
              nombre: true,
              apellido: true,
            },
          },
        },
      });
      return list;
    } catch (error) {
      console.log(error);
      if (error instanceof HttpException) {
        throw error;
      } else if (error instanceof PrismaClientKnownRequestError) {
        throw new HttpException(
          'Error al buscar las cajas',
          HttpStatus.BAD_REQUEST,
        );
      } else {
        throw new HttpException(
          'Error interno del servidor',
          HttpStatus.INTERNAL_SERVER_ERROR,
        );
      }
    }
  }

  async borrarCaja(id: string) {
    try {
      await this.prismaService.caja.delete({
        where: {
          id_caja: id,
        },
      });
    } catch (error) {
      console.log(error);
      if (error instanceof HttpException) {
        throw error;
      } else if (error instanceof PrismaClientKnownRequestError) {
        throw new HttpException(
          'Error al borrar la caja',
          HttpStatus.BAD_REQUEST,
        );
      } else {
        throw new HttpException(
          'Error interno del servidor',
          HttpStatus.INTERNAL_SERVER_ERROR,
        );
      }
    }
  }

  async actualizarCaja(data: UpdateDTo, id: string) {
    try {
      const updateCaja = await this.prismaService.caja.update({
        where: {
          id_caja: id,
        },
        data: {
          nombre: data.nombre,
          numero_caja: data.numero_caja,
          estado: data.estado,
        },
      });
      return updateCaja;
    } catch (error) {
      console.log(error);
      if (error instanceof HttpException) {
        throw error;
      } else if (error instanceof PrismaClientKnownRequestError) {
        throw new HttpException(
          'Error al actualizar la caja',
          HttpStatus.BAD_REQUEST,
        );
      } else {
        throw new HttpException(
          'Error interno del servidor',
          HttpStatus.INTERNAL_SERVER_ERROR,
        );
      }
    }
  }
}
