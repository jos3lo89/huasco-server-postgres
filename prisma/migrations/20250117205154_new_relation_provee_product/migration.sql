/*
  Warnings:

  - Added the required column `id_proveedor` to the `Productos` table without a default value. This is not possible if the table is not empty.

*/
-- RedefineTables
PRAGMA defer_foreign_keys=ON;
PRAGMA foreign_keys=OFF;
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
    "id_proveedor" TEXT NOT NULL,
    CONSTRAINT "Productos_id_categoria_fkey" FOREIGN KEY ("id_categoria") REFERENCES "Categorias" ("id_categoria") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "Productos_id_proveedor_fkey" FOREIGN KEY ("id_proveedor") REFERENCES "Proveedores" ("id_proveedor") ON DELETE RESTRICT ON UPDATE CASCADE
);
INSERT INTO "new_Productos" ("cantidad_vendidos", "codigo_producto", "created_at", "descripcion", "descuento", "estado", "fecha_vencimiento", "foto_id", "foto_url", "id_categoria", "id_producto", "marca", "nombre_producto", "precio_compra", "precio_por_kilo", "precio_venta_mayor", "precio_venta_menor", "producto_precio_compra", "producto_tipo_unidad", "si_vence", "sku", "stock_actual", "stock_minimo", "tiene_descuento", "unidad_medida", "updated_at", "venta_por_fraccion") SELECT "cantidad_vendidos", "codigo_producto", "created_at", "descripcion", "descuento", "estado", "fecha_vencimiento", "foto_id", "foto_url", "id_categoria", "id_producto", "marca", "nombre_producto", "precio_compra", "precio_por_kilo", "precio_venta_mayor", "precio_venta_menor", "producto_precio_compra", "producto_tipo_unidad", "si_vence", "sku", "stock_actual", "stock_minimo", "tiene_descuento", "unidad_medida", "updated_at", "venta_por_fraccion" FROM "Productos";
DROP TABLE "Productos";
ALTER TABLE "new_Productos" RENAME TO "Productos";
CREATE UNIQUE INDEX "Productos_codigo_producto_key" ON "Productos"("codigo_producto");
PRAGMA foreign_keys=ON;
PRAGMA defer_foreign_keys=OFF;
