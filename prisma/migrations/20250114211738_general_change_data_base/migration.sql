/*
  Warnings:

  - You are about to drop the column `categoria` on the `Productos` table. All the data in the column will be lost.
  - Added the required column `updated_at` to the `Bonos` table without a default value. This is not possible if the table is not empty.
  - Added the required column `updated_at` to the `Caja` table without a default value. This is not possible if the table is not empty.
  - Added the required column `updated_at` to the `Clientes` table without a default value. This is not possible if the table is not empty.
  - Added the required column `updated_at` to the `Devoluciones` table without a default value. This is not possible if the table is not empty.
  - Added the required column `updated_at` to the `Empleados` table without a default value. This is not possible if the table is not empty.
  - Added the required column `cantidad_vendidos` to the `Productos` table without a default value. This is not possible if the table is not empty.
  - Added the required column `id_categoria` to the `Productos` table without a default value. This is not possible if the table is not empty.
  - Added the required column `precio_compra` to the `Productos` table without a default value. This is not possible if the table is not empty.
  - Added the required column `producto_precio_compra` to the `Productos` table without a default value. This is not possible if the table is not empty.
  - Added the required column `producto_tipo_unidad` to the `Productos` table without a default value. This is not possible if the table is not empty.
  - Added the required column `sku` to the `Productos` table without a default value. This is not possible if the table is not empty.
  - Added the required column `updated_at` to the `Usuarios` table without a default value. This is not possible if the table is not empty.
  - Added the required column `id_caja` to the `Ventas` table without a default value. This is not possible if the table is not empty.
  - Added the required column `venta_pagado` to the `Ventas` table without a default value. This is not possible if the table is not empty.
  - Added the required column `venta_vuelto` to the `Ventas` table without a default value. This is not possible if the table is not empty.

*/
-- CreateTable
CREATE TABLE "Empresa" (
    "id_empresa" TEXT NOT NULL PRIMARY KEY,
    "nombre" TEXT NOT NULL,
    "telefono" TEXT NOT NULL,
    "email" TEXT,
    "direccion" TEXT,
    "created_at" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" DATETIME NOT NULL
);

-- CreateTable
CREATE TABLE "Categorias" (
    "id_categoria" TEXT NOT NULL PRIMARY KEY,
    "nombre" TEXT NOT NULL,
    "created_at" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" DATETIME NOT NULL
);

-- CreateTable
CREATE TABLE "Proveedores" (
    "id_proveedor" TEXT NOT NULL PRIMARY KEY,
    "tipo_documento" TEXT NOT NULL,
    "numero_documento" TEXT NOT NULL,
    "nombre" TEXT NOT NULL,
    "direccion" TEXT,
    "estado" TEXT NOT NULL,
    "email" TEXT,
    "telefono" TEXT,
    "nombre_encargado" TEXT,
    "created_at" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" DATETIME NOT NULL
);

-- CreateTable
CREATE TABLE "CierreCaja" (
    "id_cierre" TEXT NOT NULL PRIMARY KEY,
    "id_caja" TEXT NOT NULL,
    "total_vendido" DECIMAL NOT NULL,
    "total_ganancia" DECIMAL NOT NULL,
    "monto_dejado" DECIMAL NOT NULL,
    "fecha_cierre" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "observaciones" TEXT,
    CONSTRAINT "CierreCaja_id_caja_fkey" FOREIGN KEY ("id_caja") REFERENCES "Caja" ("id_caja") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "AperturaCaja" (
    "id_apertura" TEXT NOT NULL PRIMARY KEY,
    "id_caja" TEXT NOT NULL,
    "monto_inicial" DECIMAL NOT NULL,
    "fecha_apertura" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "observaciones" TEXT,
    CONSTRAINT "AperturaCaja_id_caja_fkey" FOREIGN KEY ("id_caja") REFERENCES "Caja" ("id_caja") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- RedefineTables
PRAGMA defer_foreign_keys=ON;
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_Bonos" (
    "id_bono" TEXT NOT NULL PRIMARY KEY,
    "id_empleado" TEXT NOT NULL,
    "monto_bono" DECIMAL NOT NULL,
    "fecha_bono" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "observaciones" TEXT,
    "created_at" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" DATETIME NOT NULL,
    CONSTRAINT "Bonos_id_empleado_fkey" FOREIGN KEY ("id_empleado") REFERENCES "Empleados" ("id_empleado") ON DELETE RESTRICT ON UPDATE CASCADE
);
INSERT INTO "new_Bonos" ("fecha_bono", "id_bono", "id_empleado", "monto_bono", "observaciones") SELECT "fecha_bono", "id_bono", "id_empleado", "monto_bono", "observaciones" FROM "Bonos";
DROP TABLE "Bonos";
ALTER TABLE "new_Bonos" RENAME TO "Bonos";
CREATE TABLE "new_Caja" (
    "id_caja" TEXT NOT NULL PRIMARY KEY,
    "id_empleado" TEXT NOT NULL,
    "fecha_apertura" DATETIME NOT NULL,
    "fecha_cierre" DATETIME,
    "monto_inicial" DECIMAL NOT NULL,
    "monto_final" DECIMAL,
    "estado" TEXT NOT NULL,
    "created_at" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" DATETIME NOT NULL,
    CONSTRAINT "Caja_id_empleado_fkey" FOREIGN KEY ("id_empleado") REFERENCES "Empleados" ("id_empleado") ON DELETE RESTRICT ON UPDATE CASCADE
);
INSERT INTO "new_Caja" ("estado", "fecha_apertura", "fecha_cierre", "id_caja", "id_empleado", "monto_final", "monto_inicial") SELECT "estado", "fecha_apertura", "fecha_cierre", "id_caja", "id_empleado", "monto_final", "monto_inicial" FROM "Caja";
DROP TABLE "Caja";
ALTER TABLE "new_Caja" RENAME TO "Caja";
CREATE TABLE "new_Clientes" (
    "id_cliente" TEXT NOT NULL PRIMARY KEY,
    "nombre" TEXT NOT NULL,
    "tipo_cliente" TEXT NOT NULL,
    "deuda" DECIMAL NOT NULL DEFAULT 0.00,
    "numero_telefono" TEXT,
    "dni_ruc" TEXT,
    "direccion" TEXT,
    "email" TEXT,
    "limite_credito" DECIMAL NOT NULL,
    "saldo_credito" DECIMAL NOT NULL,
    "fecha_registro" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "estado" BOOLEAN NOT NULL,
    "created_at" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" DATETIME NOT NULL
);
INSERT INTO "new_Clientes" ("deuda", "direccion", "dni_ruc", "email", "estado", "fecha_registro", "id_cliente", "limite_credito", "nombre", "numero_telefono", "saldo_credito", "tipo_cliente") SELECT "deuda", "direccion", "dni_ruc", "email", "estado", "fecha_registro", "id_cliente", "limite_credito", "nombre", "numero_telefono", "saldo_credito", "tipo_cliente" FROM "Clientes";
DROP TABLE "Clientes";
ALTER TABLE "new_Clientes" RENAME TO "Clientes";
CREATE TABLE "new_Devoluciones" (
    "id_devolucion" TEXT NOT NULL PRIMARY KEY,
    "id_venta" TEXT NOT NULL,
    "id_empleado" TEXT NOT NULL,
    "id_producto" TEXT NOT NULL,
    "cantidad" INTEGER NOT NULL,
    "fecha_devolucion" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "observaciones" TEXT,
    "created_at" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" DATETIME NOT NULL,
    CONSTRAINT "Devoluciones_id_venta_fkey" FOREIGN KEY ("id_venta") REFERENCES "Ventas" ("id_venta") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "Devoluciones_id_empleado_fkey" FOREIGN KEY ("id_empleado") REFERENCES "Empleados" ("id_empleado") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "Devoluciones_id_producto_fkey" FOREIGN KEY ("id_producto") REFERENCES "Productos" ("id_producto") ON DELETE RESTRICT ON UPDATE CASCADE
);
INSERT INTO "new_Devoluciones" ("cantidad", "fecha_devolucion", "id_devolucion", "id_empleado", "id_producto", "id_venta", "observaciones") SELECT "cantidad", "fecha_devolucion", "id_devolucion", "id_empleado", "id_producto", "id_venta", "observaciones" FROM "Devoluciones";
DROP TABLE "Devoluciones";
ALTER TABLE "new_Devoluciones" RENAME TO "Devoluciones";
CREATE TABLE "new_Empleados" (
    "id_empleado" TEXT NOT NULL PRIMARY KEY,
    "nombre" TEXT NOT NULL,
    "apellido" TEXT NOT NULL,
    "puesto" TEXT NOT NULL,
    "numero_telefono" TEXT,
    "foto_url" TEXT,
    "foto_id" TEXT,
    "fecha_contratacion" DATETIME,
    "dni" TEXT NOT NULL,
    "fecha_nacimiento" DATETIME,
    "email" TEXT,
    "direccion" TEXT,
    "estado" BOOLEAN NOT NULL,
    "created_at" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" DATETIME NOT NULL
);
INSERT INTO "new_Empleados" ("apellido", "direccion", "dni", "email", "estado", "fecha_contratacion", "fecha_nacimiento", "foto_id", "foto_url", "id_empleado", "nombre", "numero_telefono", "puesto") SELECT "apellido", "direccion", "dni", "email", "estado", "fecha_contratacion", "fecha_nacimiento", "foto_id", "foto_url", "id_empleado", "nombre", "numero_telefono", "puesto" FROM "Empleados";
DROP TABLE "Empleados";
ALTER TABLE "new_Empleados" RENAME TO "Empleados";
CREATE TABLE "new_Productos" (
    "id_producto" TEXT NOT NULL PRIMARY KEY,
    "sku" TEXT NOT NULL,
    "producto_precio_compra" DECIMAL NOT NULL,
    "producto_tipo_unidad" TEXT NOT NULL,
    "nombre_producto" TEXT NOT NULL,
    "descripcion" TEXT,
    "id_categoria" TEXT NOT NULL,
    "marca" TEXT,
    "precio_compra" DECIMAL NOT NULL,
    "precio_venta_menor" DECIMAL NOT NULL,
    "precio_venta_mayor" DECIMAL NOT NULL,
    "foto_url" TEXT,
    "foto_id" TEXT,
    "fecha_vencimiento" DATETIME,
    "si_vence" BOOLEAN NOT NULL DEFAULT true,
    "descuento" INTEGER,
    "tiene_descuento" BOOLEAN NOT NULL DEFAULT false,
    "codigo_producto" TEXT NOT NULL,
    "unidad_medida" TEXT NOT NULL,
    "stock_actual" INTEGER NOT NULL,
    "stock_minimo" INTEGER NOT NULL,
    "cantidad_vendidos" INTEGER NOT NULL,
    "estado" BOOLEAN NOT NULL,
    "venta_por_fraccion" BOOLEAN NOT NULL DEFAULT false,
    "precio_por_kilo" DECIMAL,
    "created_at" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" DATETIME NOT NULL,
    CONSTRAINT "Productos_id_categoria_fkey" FOREIGN KEY ("id_categoria") REFERENCES "Categorias" ("id_categoria") ON DELETE RESTRICT ON UPDATE CASCADE
);
INSERT INTO "new_Productos" ("codigo_producto", "created_at", "descripcion", "estado", "fecha_vencimiento", "foto_id", "foto_url", "id_producto", "nombre_producto", "precio_por_kilo", "precio_venta_mayor", "precio_venta_menor", "stock_actual", "stock_minimo", "unidad_medida", "updated_at", "venta_por_fraccion") SELECT "codigo_producto", "created_at", "descripcion", "estado", "fecha_vencimiento", "foto_id", "foto_url", "id_producto", "nombre_producto", "precio_por_kilo", "precio_venta_mayor", "precio_venta_menor", "stock_actual", "stock_minimo", "unidad_medida", "updated_at", "venta_por_fraccion" FROM "Productos";
DROP TABLE "Productos";
ALTER TABLE "new_Productos" RENAME TO "Productos";
CREATE UNIQUE INDEX "Productos_codigo_producto_key" ON "Productos"("codigo_producto");
CREATE TABLE "new_Usuarios" (
    "id_usuario" TEXT NOT NULL PRIMARY KEY,
    "id_empleado" TEXT NOT NULL,
    "usuario" TEXT NOT NULL,
    "password" TEXT NOT NULL,
    "puesto" TEXT NOT NULL,
    "estado" BOOLEAN NOT NULL DEFAULT true,
    "created_at" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" DATETIME NOT NULL,
    CONSTRAINT "Usuarios_id_empleado_fkey" FOREIGN KEY ("id_empleado") REFERENCES "Empleados" ("id_empleado") ON DELETE RESTRICT ON UPDATE CASCADE
);
INSERT INTO "new_Usuarios" ("estado", "id_empleado", "id_usuario", "password", "puesto", "usuario") SELECT "estado", "id_empleado", "id_usuario", "password", "puesto", "usuario" FROM "Usuarios";
DROP TABLE "Usuarios";
ALTER TABLE "new_Usuarios" RENAME TO "Usuarios";
CREATE UNIQUE INDEX "Usuarios_id_empleado_key" ON "Usuarios"("id_empleado");
CREATE UNIQUE INDEX "Usuarios_usuario_key" ON "Usuarios"("usuario");
CREATE TABLE "new_Ventas" (
    "id_venta" TEXT NOT NULL PRIMARY KEY,
    "id_empleado" TEXT NOT NULL,
    "id_caja" TEXT NOT NULL,
    "id_cliente" TEXT,
    "tipo_venta" TEXT NOT NULL,
    "monto_total" DECIMAL NOT NULL,
    "venta_pagado" DECIMAL NOT NULL,
    "venta_vuelto" DECIMAL NOT NULL,
    "fecha_venta" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "estado" TEXT NOT NULL,
    "observaciones" TEXT,
    "hubo_devolucion" BOOLEAN NOT NULL DEFAULT false,
    CONSTRAINT "Ventas_id_empleado_fkey" FOREIGN KEY ("id_empleado") REFERENCES "Empleados" ("id_empleado") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "Ventas_id_cliente_fkey" FOREIGN KEY ("id_cliente") REFERENCES "Clientes" ("id_cliente") ON DELETE SET NULL ON UPDATE CASCADE,
    CONSTRAINT "Ventas_id_caja_fkey" FOREIGN KEY ("id_caja") REFERENCES "Caja" ("id_caja") ON DELETE RESTRICT ON UPDATE CASCADE
);
INSERT INTO "new_Ventas" ("estado", "fecha_venta", "hubo_devolucion", "id_cliente", "id_empleado", "id_venta", "monto_total", "observaciones", "tipo_venta") SELECT "estado", "fecha_venta", "hubo_devolucion", "id_cliente", "id_empleado", "id_venta", "monto_total", "observaciones", "tipo_venta" FROM "Ventas";
DROP TABLE "Ventas";
ALTER TABLE "new_Ventas" RENAME TO "Ventas";
PRAGMA foreign_keys=ON;
PRAGMA defer_foreign_keys=OFF;
