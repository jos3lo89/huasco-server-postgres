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
  id_categoria: string;
  @IsNotEmpty()
  @IsString()
  id_proveedor: string;

  @IsNotEmpty()
  @IsBoolean()
  tiene_descuento: boolean;
  @IsNotEmpty()
  @IsBoolean()
  venta_por_fraccion: boolean;
  @IsNotEmpty()
  @IsBoolean()
  tiene_vencimiento: boolean;
  @IsNotEmpty()
  @IsBoolean()
  estado: boolean;

  @IsNotEmpty()
  @IsString()
  nombre_producto: string;
  @IsNotEmpty()
  @IsNumber()
  producto_precio_compra: number;
  @IsNotEmpty()
  @IsString()
  producto_tipo_unidad: string;
  @IsNotEmpty()
  @IsNumber()
  precio_venta_menor: number;
  @IsNotEmpty()
  @IsNumber()
  precio_venta_mayor: number;

  @IsNotEmpty()
  @IsNumber()
  stock_actual: number;
  @IsNotEmpty()
  @IsNumber()
  stock_minimo: number;
  @IsOptional()
  @IsString()
  fecha_vencimiento: string;
  @IsOptional()
  @IsNumber()
  descuento: number;
  @IsOptional()
  @IsString()
  marca: string;
  @IsOptional()
  @IsString()
  descripcion: string;
  @IsOptional()
  @IsNumber()
  precio_por_kilo: number;
}
