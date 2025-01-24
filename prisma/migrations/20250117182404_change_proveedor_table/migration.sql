/*
  Warnings:

  - You are about to alter the column `estado` on the `Proveedores` table. The data in that column could be lost. The data in that column will be cast from `String` to `Boolean`.

*/
-- RedefineTables
PRAGMA defer_foreign_keys=ON;
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_Proveedores" (
    "id_proveedor" TEXT NOT NULL PRIMARY KEY,
    "tipo_documento" TEXT NOT NULL,
    "numero_documento" TEXT NOT NULL,
    "nombre" TEXT NOT NULL,
    "direccion" TEXT,
    "estado" BOOLEAN NOT NULL,
    "email" TEXT,
    "telefono" TEXT,
    "nombre_encargado" TEXT,
    "created_at" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" DATETIME NOT NULL
);
INSERT INTO "new_Proveedores" ("created_at", "direccion", "email", "estado", "id_proveedor", "nombre", "nombre_encargado", "numero_documento", "telefono", "tipo_documento", "updated_at") SELECT "created_at", "direccion", "email", "estado", "id_proveedor", "nombre", "nombre_encargado", "numero_documento", "telefono", "tipo_documento", "updated_at" FROM "Proveedores";
DROP TABLE "Proveedores";
ALTER TABLE "new_Proveedores" RENAME TO "Proveedores";
PRAGMA foreign_keys=ON;
PRAGMA defer_foreign_keys=OFF;
