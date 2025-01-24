/*
  Warnings:

  - You are about to drop the column `email` on the `Usuarios` table. All the data in the column will be lost.
  - Made the column `dni` on table `Empleados` required. This step will fail if there are existing NULL values in that column.

*/
-- RedefineTables
PRAGMA defer_foreign_keys=ON;
PRAGMA foreign_keys=OFF;
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
    "estado" BOOLEAN NOT NULL
);
INSERT INTO "new_Empleados" ("apellido", "direccion", "dni", "email", "estado", "fecha_contratacion", "fecha_nacimiento", "foto_id", "foto_url", "id_empleado", "nombre", "numero_telefono", "puesto") SELECT "apellido", "direccion", "dni", "email", "estado", "fecha_contratacion", "fecha_nacimiento", "foto_id", "foto_url", "id_empleado", "nombre", "numero_telefono", "puesto" FROM "Empleados";
DROP TABLE "Empleados";
ALTER TABLE "new_Empleados" RENAME TO "Empleados";
CREATE TABLE "new_Usuarios" (
    "id_usuario" TEXT NOT NULL PRIMARY KEY,
    "id_empleado" TEXT NOT NULL,
    "usuario" TEXT NOT NULL,
    "password" TEXT NOT NULL,
    "rol" TEXT NOT NULL,
    "estado" BOOLEAN NOT NULL DEFAULT true,
    CONSTRAINT "Usuarios_id_empleado_fkey" FOREIGN KEY ("id_empleado") REFERENCES "Empleados" ("id_empleado") ON DELETE RESTRICT ON UPDATE CASCADE
);
INSERT INTO "new_Usuarios" ("estado", "id_empleado", "id_usuario", "password", "rol", "usuario") SELECT "estado", "id_empleado", "id_usuario", "password", "rol", "usuario" FROM "Usuarios";
DROP TABLE "Usuarios";
ALTER TABLE "new_Usuarios" RENAME TO "Usuarios";
CREATE UNIQUE INDEX "Usuarios_id_empleado_key" ON "Usuarios"("id_empleado");
CREATE UNIQUE INDEX "Usuarios_usuario_key" ON "Usuarios"("usuario");
PRAGMA foreign_keys=ON;
PRAGMA defer_foreign_keys=OFF;
