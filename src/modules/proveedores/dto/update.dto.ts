import {
  IsBoolean,
  IsEnum,
  IsNotEmpty,
  IsOptional,
  IsString,
} from 'class-validator';

export class UpdateDto {
  @IsNotEmpty()
  @IsEnum(['dni', 'ruc'])
  tipo_documento: 'dni' | 'ruc';

  @IsNotEmpty()
  @IsString()
  numero_documento: string;

  @IsNotEmpty()
  @IsString()
  nombre: string;

  @IsOptional()
  @IsString()
  direccion: string;

  @IsNotEmpty()
  @IsBoolean()
  estado: boolean;

  @IsOptional()
  @IsString()
  email: string;

  @IsOptional()
  @IsString()
  telefono: string;

  @IsOptional()
  @IsString()
  nombre_encargado: string;
}
