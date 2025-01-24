//   id_empleado  String
//   numero_caja  Int
//   nombre       String
//   efectivo     Decimal

import { IsNotEmpty, IsNumber, IsString } from 'class-validator';

export class CreateDto {
  @IsNotEmpty()
  @IsString()
  id_empleado: string;

  @IsNotEmpty()
  @IsNumber()
  numero_caja: number;

  @IsNotEmpty()
  @IsString()
  nombre: string;

  @IsNotEmpty()
  @IsNumber()
  efectivo: number;
}
