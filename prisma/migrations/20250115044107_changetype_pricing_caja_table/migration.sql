/*
  Warnings:

  - You are about to alter the column `efectivo` on the `Caja` table. The data in that column could be lost. The data in that column will be cast from `Decimal` to `Int`.

*/
-- RedefineTables
PRAGMA defer_foreign_keys=ON;
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_Caja" (
    "id_caja" TEXT NOT NULL PRIMARY KEY,
    "id_empleado" TEXT NOT NULL,
    "numero_caja" INTEGER NOT NULL,
    "nombre" TEXT NOT NULL,
    "efectivo" INTEGER NOT NULL,
    "created_at" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" DATETIME NOT NULL,
    CONSTRAINT "Caja_id_empleado_fkey" FOREIGN KEY ("id_empleado") REFERENCES "Empleados" ("id_empleado") ON DELETE RESTRICT ON UPDATE CASCADE
);
INSERT INTO "new_Caja" ("created_at", "efectivo", "id_caja", "id_empleado", "nombre", "numero_caja", "updated_at") SELECT "created_at", "efectivo", "id_caja", "id_empleado", "nombre", "numero_caja", "updated_at" FROM "Caja";
DROP TABLE "Caja";
ALTER TABLE "new_Caja" RENAME TO "Caja";
PRAGMA foreign_keys=ON;
PRAGMA defer_foreign_keys=OFF;
