import { IsBoolean, IsNotEmpty, IsNumber, IsString } from 'class-validator';

export class UpdateDTo {
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
  @IsString()
  efectivo: string;

  @IsNotEmpty()
  @IsBoolean()
  estado: boolean;
}
