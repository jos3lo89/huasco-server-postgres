import { applyDecorators, UseGuards } from '@nestjs/common';
import { Role } from '../enums/roles.enum';
import { RolesGuard } from '../guards/role.guard';
import { AuthGuard } from '../guards/auth.guard';
import { Roles } from './roles.decorator';

export function Auth(...roles: Role[]) {
  return applyDecorators(Roles(...roles), UseGuards(AuthGuard, RolesGuard));
}
