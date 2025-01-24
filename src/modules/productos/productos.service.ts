import { HttpException, HttpStatus, Injectable } from '@nestjs/common';
import { PrismaClientKnownRequestError } from '@prisma/client/runtime/library';
import { PrismaService } from 'src/database/prisma/prisma.service';
import { CreateDto } from './dto/create.dto';

@Injectable()
export class ProductosService {
  constructor(private prismaService: PrismaService) {}

  async listaProductos() {
    try {
      const lista = await this.prismaService.productos.findMany({
        include: {
          categoria: {
            select: {
              id_categoria: true,
              nombre: true,
            },
          },
        },
      });
      return lista;
    } catch (error) {
      console.log(error);

      if (error instanceof HttpException) {
        throw error;
      } else if (error instanceof PrismaClientKnownRequestError) {
        throw new HttpException(
          'Error al lista productos',
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

  async getProductsWithCategory(id: string) {
    try {
      const list = await this.prismaService.productos.findMany({
        where: {
          categoria: {
            id_categoria: id,
          },
        },
        include: {
          categoria: {
            select: {
              id_categoria: true,
              nombre: true,
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
          'Error al listar los productos por categoria',
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

  async create(data: CreateDto) {
    try {
      const categoriFind = await this.prismaService.categorias.findFirst({
        where: {
          id_categoria: data.id_categoria,
        },
      });

      if (!categoriFind) {
        throw new HttpException(
          `No se encontró la categoría con el id: ${data.id_categoria}`,
          HttpStatus.BAD_REQUEST,
        );
      }

      const newProduct = await this.prismaService.productos.create({
        data: {
          ...data,
          sku: await this.SKUgenerator(
            data.nombre_producto,
            categoriFind.nombre,
          ),
          codigo_producto: await this.secuencialCodeGenerator(),
          foto_url: null,
          foto_id: null,
          fecha_vencimiento:
            data.fecha_vencimiento == ''
              ? null
              : new Date(data.fecha_vencimiento),
          descuento: data.tiene_descuento ? data.descuento : null,
          marca: data.marca === '' ? null : data.marca,
          descripcion: data.descripcion === '' ? null : data.descripcion,
          precio_por_kilo: data.venta_por_fraccion
            ? data.precio_por_kilo
            : null,
        },
      });
      return newProduct;
    } catch (error) {
      console.log(error);
      if (error instanceof HttpException) {
        throw error;
      } else if (error instanceof PrismaClientKnownRequestError) {
        throw new HttpException(
          'Error al registrar producto',
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

  async secuencialCodeGenerator() {
    try {
      const productsQuantity = await this.prismaService.productos.count();
      const newCode = (productsQuantity + 1).toString().padStart(4, '0');
      return newCode;
    } catch (error) {
      console.error('Error generating sequential code:', error);
      throw new HttpException(
        'Error generating sequential code.',
        HttpStatus.INTERNAL_SERVER_ERROR,
      );
    }
  }

  async SKUgenerator(nombreProducto: string, categoria: string) {
    try {
      if (!nombreProducto || !categoria) {
        throw new HttpException(
          'Product name and category are required.',
          HttpStatus.BAD_REQUEST,
        );
      }

      const abreviaturaNombre = nombreProducto.slice(0, 3).toUpperCase();
      const abreviaturaCategoria = categoria.slice(0, 3).toUpperCase();
      const codigoUnico = await this.secuencialCodeGenerator();

      return `${abreviaturaNombre}-${abreviaturaCategoria}-${codigoUnico}`;
    } catch (error) {
      if (error instanceof HttpException) {
        throw error; // Re-lanzar la excepción con el mensaje adecuado
      }
      throw new HttpException(
        'Error generating SKU.',
        HttpStatus.INTERNAL_SERVER_ERROR,
      );
    }
  }
}
