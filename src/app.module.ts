import { Module } from '@nestjs/common';
import { AppController } from './app.controller';
import { AppService } from './app.service';
import { PrismaService } from './database/prisma/prisma.service';
import { AuthModule } from './auth/auth.module';
import { UsersModule } from './modules/users/users.module';
import { CajaModule } from './modules/caja/caja.module';
import { CategoriasModule } from './modules/categorias/categorias.module';
import { ProveedoresModule } from './modules/proveedores/proveedores.module';
import { ClientesModule } from './modules/clientes/clientes.module';
import { ProductosModule } from './modules/productos/productos.module';
import { VentaModule } from './modules/venta/venta.module';

@Module({
  imports: [AuthModule, UsersModule, CajaModule, CategoriasModule, ProveedoresModule, ClientesModule, ProductosModule, VentaModule],
  controllers: [AppController],
  providers: [AppService, PrismaService],
})
export class AppModule {}
