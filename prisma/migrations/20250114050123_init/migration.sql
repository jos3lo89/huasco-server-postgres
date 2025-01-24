-- CreateTable
CREATE TABLE "Usuarios" (
    "id_usuario" TEXT NOT NULL PRIMARY KEY,
    "id_empleado" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "password" TEXT NOT NULL,
    "rol" TEXT NOT NULL,
    "estado" BOOLEAN NOT NULL DEFAULT true,
    CONSTRAINT "Usuarios_id_empleado_fkey" FOREIGN KEY ("id_empleado") REFERENCES "Empleados" ("id_empleado") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "Empleados" (
    "id_empleado" TEXT NOT NULL PRIMARY KEY,
    "nombre" TEXT NOT NULL,
    "apellido" TEXT NOT NULL,
    "puesto" TEXT NOT NULL,
    "numero_telefono" TEXT,
    "foto_url" TEXT,
    "foto_id" TEXT,
    "fecha_contratacion" DATETIME,
    "dni" TEXT,
    "fecha_nacimiento" DATETIME,
    "email" TEXT,
    "direccion" TEXT,
    "estado" BOOLEAN NOT NULL
);

-- CreateTable
CREATE TABLE "Clientes" (
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
    "estado" BOOLEAN NOT NULL
);

-- CreateTable
CREATE TABLE "Productos" (
    "id_producto" TEXT NOT NULL PRIMARY KEY,
    "nombre_producto" TEXT NOT NULL,
    "descripcion" TEXT,
    "categoria" TEXT NOT NULL,
    "precio_venta_menor" DECIMAL NOT NULL,
    "precio_venta_mayor" DECIMAL NOT NULL,
    "foto_url" TEXT,
    "foto_id" TEXT,
    "fecha_vencimiento" DATETIME NOT NULL,
    "codigo_producto" TEXT NOT NULL,
    "unidad_medida" TEXT NOT NULL,
    "stock_actual" INTEGER NOT NULL,
    "stock_minimo" INTEGER NOT NULL,
    "estado" BOOLEAN NOT NULL,
    "venta_por_fraccion" BOOLEAN NOT NULL DEFAULT false,
    "precio_por_kilo" DECIMAL,
    "created_at" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" DATETIME NOT NULL
);

-- CreateTable
CREATE TABLE "Ventas" (
    "id_venta" TEXT NOT NULL PRIMARY KEY,
    "id_empleado" TEXT NOT NULL,
    "id_cliente" TEXT,
    "tipo_venta" TEXT NOT NULL,
    "monto_total" DECIMAL NOT NULL,
    "fecha_venta" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "estado" TEXT NOT NULL,
    "observaciones" TEXT,
    "hubo_devolucion" BOOLEAN NOT NULL DEFAULT false,
    CONSTRAINT "Ventas_id_empleado_fkey" FOREIGN KEY ("id_empleado") REFERENCES "Empleados" ("id_empleado") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "Ventas_id_cliente_fkey" FOREIGN KEY ("id_cliente") REFERENCES "Clientes" ("id_cliente") ON DELETE SET NULL ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "DetalleVentas" (
    "id_detalle" TEXT NOT NULL PRIMARY KEY,
    "id_venta" TEXT NOT NULL,
    "id_producto" TEXT NOT NULL,
    "cantidad" INTEGER NOT NULL,
    "precio_unitario" DECIMAL NOT NULL,
    "subtotal" DECIMAL NOT NULL,
    CONSTRAINT "DetalleVentas_id_venta_fkey" FOREIGN KEY ("id_venta") REFERENCES "Ventas" ("id_venta") ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT "DetalleVentas_id_producto_fkey" FOREIGN KEY ("id_producto") REFERENCES "Productos" ("id_producto") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "Devoluciones" (
    "id_devolucion" TEXT NOT NULL PRIMARY KEY,
    "id_venta" TEXT NOT NULL,
    "id_empleado" TEXT NOT NULL,
    "id_producto" TEXT NOT NULL,
    "cantidad" INTEGER NOT NULL,
    "fecha_devolucion" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "observaciones" TEXT,
    CONSTRAINT "Devoluciones_id_venta_fkey" FOREIGN KEY ("id_venta") REFERENCES "Ventas" ("id_venta") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "Devoluciones_id_empleado_fkey" FOREIGN KEY ("id_empleado") REFERENCES "Empleados" ("id_empleado") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "Devoluciones_id_producto_fkey" FOREIGN KEY ("id_producto") REFERENCES "Productos" ("id_producto") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "Bonos" (
    "id_bono" TEXT NOT NULL PRIMARY KEY,
    "id_empleado" TEXT NOT NULL,
    "monto_bono" DECIMAL NOT NULL,
    "fecha_bono" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "observaciones" TEXT,
    CONSTRAINT "Bonos_id_empleado_fkey" FOREIGN KEY ("id_empleado") REFERENCES "Empleados" ("id_empleado") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "SalidasProductos" (
    "id_salida" TEXT NOT NULL PRIMARY KEY,
    "id_empleado" TEXT NOT NULL,
    "fecha_salida" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "observaciones" TEXT,
    CONSTRAINT "SalidasProductos_id_empleado_fkey" FOREIGN KEY ("id_empleado") REFERENCES "Empleados" ("id_empleado") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "DetalleSalidas" (
    "id_detalle" TEXT NOT NULL PRIMARY KEY,
    "id_salida" TEXT NOT NULL,
    "id_producto" TEXT NOT NULL,
    "cantidad" INTEGER NOT NULL,
    CONSTRAINT "DetalleSalidas_id_salida_fkey" FOREIGN KEY ("id_salida") REFERENCES "SalidasProductos" ("id_salida") ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT "DetalleSalidas_id_producto_fkey" FOREIGN KEY ("id_producto") REFERENCES "Productos" ("id_producto") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "Caja" (
    "id_caja" TEXT NOT NULL PRIMARY KEY,
    "id_empleado" TEXT NOT NULL,
    "fecha_apertura" DATETIME NOT NULL,
    "fecha_cierre" DATETIME,
    "monto_inicial" DECIMAL NOT NULL,
    "monto_final" DECIMAL,
    "estado" TEXT NOT NULL,
    CONSTRAINT "Caja_id_empleado_fkey" FOREIGN KEY ("id_empleado") REFERENCES "Empleados" ("id_empleado") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateIndex
CREATE UNIQUE INDEX "Usuarios_id_empleado_key" ON "Usuarios"("id_empleado");

-- CreateIndex
CREATE UNIQUE INDEX "Usuarios_email_key" ON "Usuarios"("email");

-- CreateIndex
CREATE UNIQUE INDEX "Productos_codigo_producto_key" ON "Productos"("codigo_producto");
