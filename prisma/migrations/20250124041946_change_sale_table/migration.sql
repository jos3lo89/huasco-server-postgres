/*
  Warnings:

  - You are about to alter the column `estado` on the `Ventas` table. The data in that column could be lost. The data in that column will be cast from `String` to `Boolean`.

*/
-- RedefineTables
PRAGMA defer_foreign_keys=ON;
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_DetalleVentas" (
    "id_detalle" TEXT NOT NULL PRIMARY KEY,
    "id_venta" TEXT NOT NULL,
    "id_producto" TEXT NOT NULL,
    "cantidad" INTEGER NOT NULL,
    "precio_unitario" DECIMAL NOT NULL,
    "precio_rebaja" DECIMAL,
    "subtotal" DECIMAL NOT NULL,
    "tiene_rebaja" BOOLEAN NOT NULL DEFAULT false,
    "cantidad_peso" DECIMAL,
    CONSTRAINT "DetalleVentas_id_venta_fkey" FOREIGN KEY ("id_venta") REFERENCES "Ventas" ("id_venta") ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT "DetalleVentas_id_producto_fkey" FOREIGN KEY ("id_producto") REFERENCES "Productos" ("id_producto") ON DELETE RESTRICT ON UPDATE CASCADE
);
INSERT INTO "new_DetalleVentas" ("cantidad", "cantidad_peso", "id_detalle", "id_producto", "id_venta", "precio_unitario", "subtotal") SELECT "cantidad", "cantidad_peso", "id_detalle", "id_producto", "id_venta", "precio_unitario", "subtotal" FROM "DetalleVentas";
DROP TABLE "DetalleVentas";
ALTER TABLE "new_DetalleVentas" RENAME TO "DetalleVentas";
CREATE TABLE "new_Ventas" (
    "id_venta" TEXT NOT NULL PRIMARY KEY,
    "numero_proforma" TEXT,
    "id_empleado" TEXT NOT NULL,
    "id_caja" TEXT NOT NULL,
    "tipo_venta" TEXT NOT NULL,
    "monto_total" DECIMAL NOT NULL,
    "venta_pagado" DECIMAL NOT NULL,
    "venta_vuelto" DECIMAL NOT NULL,
    "fecha_venta" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "estado" BOOLEAN NOT NULL DEFAULT true,
    "observaciones" TEXT,
    "hubo_devolucion" BOOLEAN NOT NULL DEFAULT false,
    "id_cliente" TEXT,
    CONSTRAINT "Ventas_id_empleado_fkey" FOREIGN KEY ("id_empleado") REFERENCES "Empleados" ("id_empleado") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "Ventas_id_cliente_fkey" FOREIGN KEY ("id_cliente") REFERENCES "Clientes" ("id_cliente") ON DELETE SET NULL ON UPDATE CASCADE,
    CONSTRAINT "Ventas_id_caja_fkey" FOREIGN KEY ("id_caja") REFERENCES "Caja" ("id_caja") ON DELETE RESTRICT ON UPDATE CASCADE
);
INSERT INTO "new_Ventas" ("estado", "fecha_venta", "hubo_devolucion", "id_caja", "id_cliente", "id_empleado", "id_venta", "monto_total", "observaciones", "tipo_venta", "venta_pagado", "venta_vuelto") SELECT "estado", "fecha_venta", "hubo_devolucion", "id_caja", "id_cliente", "id_empleado", "id_venta", "monto_total", "observaciones", "tipo_venta", "venta_pagado", "venta_vuelto" FROM "Ventas";
DROP TABLE "Ventas";
ALTER TABLE "new_Ventas" RENAME TO "Ventas";
CREATE UNIQUE INDEX "Ventas_numero_proforma_key" ON "Ventas"("numero_proforma");
PRAGMA foreign_keys=ON;
PRAGMA defer_foreign_keys=OFF;
