import { IsEnum, IsNotEmpty, IsString } from 'class-validator';

export class RegisterDto {
  @IsNotEmpty({ message: 'Los nombres no pueden estar vacíos' })
  @IsString({ message: 'Los nombres deben ser una cadena de texto' })
  nombres: string;

  @IsNotEmpty({ message: 'Los apellidos no pueden estar vacíos' })
  @IsString({ message: 'Los apellidos deben ser una cadena de texto' })
  apellido: string;

  @IsNotEmpty({ message: 'El puesto no puede estar vacío' })
  @IsEnum(['Administrador', 'Caja', 'Vendedor'], {
    message: 'El puesto debe ser Administrador, Caja o Vendedor',
  })
  puesto: 'Administrador' | 'Caja' | 'Vendedor';

  @IsNotEmpty({ message: 'El número de documento no puede estar vacío' })
  @IsString({ message: 'El número de documento debe ser de caracteres' })
  dni: string;
}
