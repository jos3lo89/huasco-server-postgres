import {
  IsBoolean,
  IsNotEmpty,
  IsNumber,
  IsOptional,
  IsString,
} from 'class-validator';

export class CreateDto {
  @IsNotEmpty()
  @IsString()
  nombre: string;

  @IsNotEmpty()
  @IsNumber()
  deuda: number;

  @IsNotEmpty()
  @IsNumber()
  total_pagos: number;

  @IsNotEmpty()
  @IsBoolean()
  estado: boolean;

  @IsOptional()
  @IsString()
  numero_telefono: string;

  @IsOptional()
  @IsString()
  dni_ruc: string;

  @IsOptional()
  @IsString()
  direccion: string;

  @IsOptional()
  @IsString()
  email: string;

  @IsOptional()
  @IsString()
  observaciones: string;
}
