/*
  Warnings:

  - Added the required column `usuario` to the `Usuarios` table without a default value. This is not possible if the table is not empty.

*/
-- RedefineTables
PRAGMA defer_foreign_keys=ON;
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_Usuarios" (
    "id_usuario" TEXT NOT NULL PRIMARY KEY,
    "id_empleado" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "usuario" TEXT NOT NULL,
    "password" TEXT NOT NULL,
    "rol" TEXT NOT NULL,
    "estado" BOOLEAN NOT NULL DEFAULT true,
    CONSTRAINT "Usuarios_id_empleado_fkey" FOREIGN KEY ("id_empleado") REFERENCES "Empleados" ("id_empleado") ON DELETE RESTRICT ON UPDATE CASCADE
);
INSERT INTO "new_Usuarios" ("email", "estado", "id_empleado", "id_usuario", "password", "rol") SELECT "email", "estado", "id_empleado", "id_usuario", "password", "rol" FROM "Usuarios";
DROP TABLE "Usuarios";
ALTER TABLE "new_Usuarios" RENAME TO "Usuarios";
CREATE UNIQUE INDEX "Usuarios_id_empleado_key" ON "Usuarios"("id_empleado");
CREATE UNIQUE INDEX "Usuarios_email_key" ON "Usuarios"("email");
CREATE UNIQUE INDEX "Usuarios_usuario_key" ON "Usuarios"("usuario");
PRAGMA foreign_keys=ON;
PRAGMA defer_foreign_keys=OFF;
