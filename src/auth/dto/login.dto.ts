import { IsNotEmpty, IsString, MinLength } from 'class-validator';

export class LoginDto {
  @IsNotEmpty({ message: 'El usuario no puede estar vacío' })
  @IsString({ message: 'El usuario debe ser una cadena de texto' })
  usuario: string;

  @IsNotEmpty({ message: 'La clave no puede estar vacía' })
  @IsString({ message: 'La clave debe ser una cadena de texto' })
  @MinLength(8, { message: 'La clave debe tener al menos 8 caracteres' })
  clave: string;
}
