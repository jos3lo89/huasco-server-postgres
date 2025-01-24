/*
  Warnings:

  - You are about to drop the column `precio_compra` on the `Productos` table. All the data in the column will be lost.
  - You are about to drop the column `unidad_medida` on the `Productos` table. All the data in the column will be lost.

*/
-- AlterTable
ALTER TABLE "DetalleVentas" ADD COLUMN "cantidad_peso" DECIMAL;

-- RedefineTables
PRAGMA defer_foreign_keys=ON;
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_Productos" (
    "id_producto" TEXT NOT NULL PRIMARY KEY,
    "id_categoria" TEXT NOT NULL,
    "id_proveedor" TEXT NOT NULL,
    "si_vence" BOOLEAN NOT NULL DEFAULT true,
    "tiene_descuento" BOOLEAN NOT NULL DEFAULT false,
    "venta_por_fraccion" BOOLEAN NOT NULL DEFAULT false,
    "estado" BOOLEAN NOT NULL DEFAULT true,
    "tiene_vencimiento" BOOLEAN NOT NULL DEFAULT true,
    "sku" TEXT NOT NULL,
    "nombre_producto" TEXT NOT NULL,
    "producto_precio_compra" DECIMAL NOT NULL,
    "producto_tipo_unidad" TEXT NOT NULL,
    "precio_venta_menor" DECIMAL NOT NULL,
    "precio_venta_mayor" DECIMAL NOT NULL,
    "codigo_producto" TEXT NOT NULL,
    "stock_actual" INTEGER NOT NULL,
    "stock_minimo" INTEGER NOT NULL,
    "cantidad_vendidos" INTEGER NOT NULL,
    "foto_url" TEXT,
    "foto_id" TEXT,
    "fecha_vencimiento" DATETIME,
    "descuento" INTEGER,
    "marca" TEXT,
    "descripcion" TEXT,
    "precio_por_kilo" DECIMAL,
    "created_at" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" DATETIME NOT NULL,
    CONSTRAINT "Productos_id_categoria_fkey" FOREIGN KEY ("id_categoria") REFERENCES "Categorias" ("id_categoria") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "Productos_id_proveedor_fkey" FOREIGN KEY ("id_proveedor") REFERENCES "Proveedores" ("id_proveedor") ON DELETE RESTRICT ON UPDATE CASCADE
);
INSERT INTO "new_Productos" ("cantidad_vendidos", "codigo_producto", "created_at", "descripcion", "descuento", "estado", "fecha_vencimiento", "foto_id", "foto_url", "id_categoria", "id_producto", "id_proveedor", "marca", "nombre_producto", "precio_por_kilo", "precio_venta_mayor", "precio_venta_menor", "producto_precio_compra", "producto_tipo_unidad", "si_vence", "sku", "stock_actual", "stock_minimo", "tiene_descuento", "updated_at", "venta_por_fraccion") SELECT "cantidad_vendidos", "codigo_producto", "created_at", "descripcion", "descuento", "estado", "fecha_vencimiento", "foto_id", "foto_url", "id_categoria", "id_producto", "id_proveedor", "marca", "nombre_producto", "precio_por_kilo", "precio_venta_mayor", "precio_venta_menor", "producto_precio_compra", "producto_tipo_unidad", "si_vence", "sku", "stock_actual", "stock_minimo", "tiene_descuento", "updated_at", "venta_por_fraccion" FROM "Productos";
DROP TABLE "Productos";
ALTER TABLE "new_Productos" RENAME TO "Productos";
CREATE UNIQUE INDEX "Productos_codigo_producto_key" ON "Productos"("codigo_producto");
PRAGMA foreign_keys=ON;
PRAGMA defer_foreign_keys=OFF;
