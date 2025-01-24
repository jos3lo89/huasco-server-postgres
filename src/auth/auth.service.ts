import {
  HttpException,
  HttpStatus,
  Injectable,
  UnauthorizedException,
} from '@nestjs/common';
import { LoginDto } from './dto/login.dto';
import { UsersService } from 'src/modules/users/users.service';
import * as bcrypt from 'bcrypt';
import { JwtService } from '@nestjs/jwt';
import { PrismaClientKnownRequestError } from '@prisma/client/runtime/library';
import { RegisterDto } from './dto/register.dto';

@Injectable()
export class AuthService {
  constructor(
    private userService: UsersService,
    private jwtService: JwtService,
  ) {}

  async login(data: LoginDto) {
    try {
      const user = await this.userService.findOne(data);
      if (!user) {
        throw new UnauthorizedException('Usuario no encontrado');
      }

      const isPwdValid = await bcrypt.compare(data.clave, user.password);

      if (!isPwdValid) {
        throw new UnauthorizedException('Usuario o contraseña no coinciden');
      }

      const payload = {
        id: user.id_usuario,
        name: user.empleado.nombre,
        role: user.puesto,
        email: user.empleado.email,
      };

      const token = await this.jwtService.signAsync(payload);

      return { ...user.empleado, token };
    } catch (error) {
      console.log(error);
      if (error instanceof HttpException) {
        throw error;
      } else if (error instanceof PrismaClientKnownRequestError) {
        throw new HttpException(
          'Error al iniciar sesión',
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

  async register(data: RegisterDto) {
    return this.userService.create(data);
  }
}
