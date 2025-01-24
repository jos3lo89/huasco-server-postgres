import { Body, Controller, Get, Post } from '@nestjs/common';
import { ClientesService } from './clientes.service';
import { CreateDto } from './dto/create.dto';

@Controller('clientes')
export class ClientesController {
  constructor(private clienteService: ClientesService) {}

  @Get()
  listaClientes() {
    return this.clienteService.listaClientes();
  }

  @Post()
  create(@Body() body: CreateDto) {
    return this.clienteService.create(body);
  }
}
