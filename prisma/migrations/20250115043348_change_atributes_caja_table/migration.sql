/*
  Warnings:

  - You are about to drop the column `estado` on the `Caja` table. All the data in the column will be lost.
  - You are about to drop the column `fecha_apertura` on the `Caja` table. All the data in the column will be lost.
  - You are about to drop the column `fecha_cierre` on the `Caja` table. All the data in the column will be lost.
  - You are about to drop the column `monto_final` on the `Caja` table. All the data in the column will be lost.
  - You are about to drop the column `monto_inicial` on the `Caja` table. All the data in the column will be lost.
  - Added the required column `efectivo` to the `Caja` table without a default value. This is not possible if the table is not empty.
  - Added the required column `nombre` to the `Caja` table without a default value. This is not possible if the table is not empty.
  - Added the required column `numero_caja` to the `Caja` table without a default value. This is not possible if the table is not empty.

*/
-- RedefineTables
PRAGMA defer_foreign_keys=ON;
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_Caja" (
    "id_caja" TEXT NOT NULL PRIMARY KEY,
    "id_empleado" TEXT NOT NULL,
    "numero_caja" INTEGER NOT NULL,
    "nombre" TEXT NOT NULL,
    "efectivo" DECIMAL NOT NULL,
    "created_at" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" DATETIME NOT NULL,
    CONSTRAINT "Caja_id_empleado_fkey" FOREIGN KEY ("id_empleado") REFERENCES "Empleados" ("id_empleado") ON DELETE RESTRICT ON UPDATE CASCADE
);
INSERT INTO "new_Caja" ("created_at", "id_caja", "id_empleado", "updated_at") SELECT "created_at", "id_caja", "id_empleado", "updated_at" FROM "Caja";
DROP TABLE "Caja";
ALTER TABLE "new_Caja" RENAME TO "Caja";
PRAGMA foreign_keys=ON;
PRAGMA defer_foreign_keys=OFF;
