import { HttpException, HttpStatus, Injectable } from '@nestjs/common';
import { PrismaService } from 'src/database/prisma/prisma.service';
import { CreateVentaDto } from './dto/create.dto';
import { PrismaClientKnownRequestError } from '@prisma/client/runtime/library';

@Injectable()
export class VentaService {
  constructor(private prismaService: PrismaService) {}

  async listAllVentas() {
    try {
      const list = await this.prismaService.ventas.findMany({
        include: {
          DetalleVentas: {
            include: {
              Productos: true,
            },
          },
          Empleados: true,
        },
      });
      return list;
    } catch (error) {
      console.log(error);
      if (error instanceof HttpException) {
        throw error;
      } else if (error instanceof PrismaClientKnownRequestError) {
        throw new HttpException(
          'Error al lista las ventas.',
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

  async create(data: CreateVentaDto) {
    try {
      const newSale = await this.prismaService.ventas.create({
        data: {
          ...data,
          // numero_proforma: data.numero_proforma,
          // id_empleado: data.id_empleado,
          // id_caja: data.id_caja,
          // tipo_venta: data.tipo_venta,
          // monto_total: data.monto_total,
          // venta_pagado: data.venta_pagado,
          // venta_vuelto: data.venta_vuelto,
          // estado: data.estado,
          // observaciones: data.observaciones,
          // hubo_devolucion: data.hubo_devolucion,
          DetalleVentas: {
            createMany: {
              data: data.DetalleVentas,
            },
          },
        },
      });

      for (const detalle of data.DetalleVentas) {
        await this.prismaService.productos.update({
          where: { id_producto: detalle.id_producto },
          data: {
            stock_actual: {
              decrement: detalle.cantidad,
            },
            cantidad_vendidos: {
              increment: detalle.cantidad,
            },
          },
        });
      }

      return newSale;
    } catch (error) {
      console.log(error);
      if (error instanceof HttpException) {
        throw error;
      } else if (error instanceof PrismaClientKnownRequestError) {
        throw new HttpException(
          'Error al registrar la venta.',
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
