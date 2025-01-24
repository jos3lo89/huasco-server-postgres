/*
  Warnings:

  - You are about to drop the column `rol` on the `Usuarios` table. All the data in the column will be lost.
  - Added the required column `puesto` to the `Usuarios` table without a default value. This is not possible if the table is not empty.

*/
-- RedefineTables
PRAGMA defer_foreign_keys=ON;
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_Usuarios" (
    "id_usuario" TEXT NOT NULL PRIMARY KEY,
    "id_empleado" TEXT NOT NULL,
    "usuario" TEXT NOT NULL,
    "password" TEXT NOT NULL,
    "puesto" TEXT NOT NULL,
    "estado" BOOLEAN NOT NULL DEFAULT true,
    CONSTRAINT "Usuarios_id_empleado_fkey" FOREIGN KEY ("id_empleado") REFERENCES "Empleados" ("id_empleado") ON DELETE RESTRICT ON UPDATE CASCADE
);
INSERT INTO "new_Usuarios" ("estado", "id_empleado", "id_usuario", "password", "usuario") SELECT "estado", "id_empleado", "id_usuario", "password", "usuario" FROM "Usuarios";
DROP TABLE "Usuarios";
ALTER TABLE "new_Usuarios" RENAME TO "Usuarios";
CREATE UNIQUE INDEX "Usuarios_id_empleado_key" ON "Usuarios"("id_empleado");
CREATE UNIQUE INDEX "Usuarios_usuario_key" ON "Usuarios"("usuario");
PRAGMA foreign_keys=ON;
PRAGMA defer_foreign_keys=OFF;
