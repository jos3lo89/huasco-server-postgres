import { HttpException, HttpStatus, Injectable } from '@nestjs/common';
import { PrismaClientKnownRequestError } from '@prisma/client/runtime/library';
import { LoginDto } from 'src/auth/dto/login.dto';
import { RegisterDto } from 'src/auth/dto/register.dto';
import { PrismaService } from 'src/database/prisma/prisma.service';
import * as bcrypt from 'bcrypt';

@Injectable()
export class UsersService {
  constructor(private prismaService: PrismaService) {}

  async getUsers() {
    try {
      const users = await this.prismaService.empleados.findMany();
      return users;
    } catch (error) {
      console.log(error);
      if (error instanceof HttpException) {
        throw error;
      } else if (error instanceof PrismaClientKnownRequestError) {
        throw new HttpException(
          'Error al buscar el usuario',
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

  async findOne(data: LoginDto) {
    try {
      const user = await this.prismaService.usuarios.findFirst({
        where: {
          usuario: data.usuario,
        },
        include: {
          empleado: true,
        },
      });

      return user;
    } catch (error) {
      console.log(error);
      if (error instanceof HttpException) {
        throw error;
      } else if (error instanceof PrismaClientKnownRequestError) {
        throw new HttpException(
          'Error al buscar el usuario',
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

  async create(data: RegisterDto) {
    try {
      console.log(data);

      const findUser = await this.prismaService.empleados.findFirst({
        where: {
          dni: data.dni,
        },
      });

      if (findUser && findUser.dni === data.dni) {
        throw new HttpException(
          'El dni ya se encuentra en uso.',
          HttpStatus.BAD_REQUEST,
        );
      }

      const newUser = await this.prismaService.empleados.create({
        data: {
          apellido: data.apellido,
          nombre: data.nombres,
          dni: data.dni,
          estado: true,
          puesto: data.puesto,
        },
      });

      const password = await bcrypt.hash(data.dni, 10);

      await this.prismaService.usuarios.create({
        data: {
          usuario: data.dni,
          puesto: data.puesto,
          id_empleado: newUser.id_empleado,
          password,
        },
      });

      return newUser;
    } catch (error) {
      console.log(error);

      if (error instanceof HttpException) {
        throw error;
      } else if (error instanceof PrismaClientKnownRequestError) {
        throw new HttpException(
          'Error al registrar usuario',
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
