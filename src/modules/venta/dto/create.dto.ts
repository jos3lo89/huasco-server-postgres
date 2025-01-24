import {
  IsString,
  IsOptional,
  IsNumber,
  IsBoolean,
  IsArray,
  ValidateNested,
  IsUUID,
  IsDecimal,
} from 'class-validator';
import { Type } from 'class-transformer';

export class CreateDetalleVentaDto {
  @IsUUID()
  @IsString()
  id_producto: string; // ID del producto vendido.

  @IsNumber()
  cantidad: number; // Cantidad del producto vendido (por unidad).

  @IsNumber()
  precio_unitario: number; // Precio unitario del producto vendido.

  @IsNumber()
  subtotal: number; // Subtotal (precio_unitario * cantidad).

  @IsOptional()
  @IsNumber()
  cantidad_peso: number; // Cantidad en kilogramos si el producto se vende por peso (opcional).

  @IsOptional()
  @IsNumber()
  precio_rebaja: number; // solo si tiene  reabaja

  @IsBoolean()
  tiene_rebaja: boolean; // indica que si tiene  rebaja
}

export class CreateVentaDto {
  @IsOptional()
  @IsString()
  numero_proforma: string; // Código de proforma o boleta asociado a la venta.

  @IsUUID()
  @IsString()
  id_empleado: string; // ID del empleado que realizó la venta.

  @IsUUID()
  @IsString()
  id_caja: string; // ID de la caja en la que se realizó la venta.

  @IsString()
  tipo_venta: string; // Tipo de venta (por mayor, por menor, menudeo).

  @IsNumber()
  monto_total: number; // Monto total de la venta.

  @IsNumber()
  venta_pagado: number; // Monto pagado por el cliente.

  @IsNumber()
  venta_vuelto: number; // Monto devuelto como cambio al cliente.

  @IsOptional()
  @IsString()
  observaciones?: string; // Observaciones adicionales sobre la venta (opcional).

  @IsBoolean()
  estado: boolean; // Estado de la venta (completa, anulada).

  @IsOptional()
  @IsBoolean()
  hubo_devolucion?: boolean; // Indica si hubo devoluciones asociadas a esta venta.

  @IsOptional()
  @IsUUID()
  @IsString()
  id_cliente?: string; // ID del cliente que realizó la compra (opcional).

  @IsArray()
  @ValidateNested({ each: true })
  @Type(() => CreateDetalleVentaDto)
  DetalleVentas: CreateDetalleVentaDto[]; // Lista de detalles de productos vendidos.
}
