/*
  Warnings:

  - You are about to drop the column `fecha_registro` on the `Clientes` table. All the data in the column will be lost.
  - You are about to drop the column `limite_credito` on the `Clientes` table. All the data in the column will be lost.
  - You are about to drop the column `saldo_credito` on the `Clientes` table. All the data in the column will be lost.
  - You are about to drop the column `tipo_cliente` on the `Clientes` table. All the data in the column will be lost.

*/
-- CreateTable
CREATE TABLE "PagosClientes" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "monto_recibido" DECIMAL NOT NULL,
    "monto_pagado" DECIMAL NOT NULL,
    "vuelto" DECIMAL NOT NULL,
    "fecha_pago" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "metodo_pago" TEXT NOT NULL,
    "observacion" TEXT,
    "id_cliente" TEXT NOT NULL,
    "id_venta" TEXT NOT NULL,
    "created_at" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" DATETIME NOT NULL,
    CONSTRAINT "PagosClientes_id_cliente_fkey" FOREIGN KEY ("id_cliente") REFERENCES "Clientes" ("id_cliente") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "PagosClientes_id_venta_fkey" FOREIGN KEY ("id_venta") REFERENCES "Ventas" ("id_venta") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- RedefineTables
PRAGMA defer_foreign_keys=ON;
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_Clientes" (
    "id_cliente" TEXT NOT NULL PRIMARY KEY,
    "nombre" TEXT NOT NULL,
    "deuda" DECIMAL NOT NULL DEFAULT 0.00,
    "total_pagos" DECIMAL NOT NULL DEFAULT 0.00,
    "estado" BOOLEAN NOT NULL,
    "numero_telefono" TEXT,
    "dni_ruc" TEXT,
    "direccion" TEXT,
    "email" TEXT,
    "observaciones" TEXT,
    "created_at" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" DATETIME NOT NULL
);
INSERT INTO "new_Clientes" ("created_at", "deuda", "direccion", "dni_ruc", "email", "estado", "id_cliente", "nombre", "numero_telefono", "updated_at") SELECT "created_at", "deuda", "direccion", "dni_ruc", "email", "estado", "id_cliente", "nombre", "numero_telefono", "updated_at" FROM "Clientes";
DROP TABLE "Clientes";
ALTER TABLE "new_Clientes" RENAME TO "Clientes";
PRAGMA foreign_keys=ON;
PRAGMA defer_foreign_keys=OFF;

-- CreateIndex
CREATE UNIQUE INDEX "PagosClientes_id_venta_key" ON "PagosClientes"("id_venta");
