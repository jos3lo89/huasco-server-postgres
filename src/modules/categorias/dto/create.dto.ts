import { IsBoolean, IsNotEmpty, IsString } from 'class-validator';

export class CreateDto {
  @IsString()
  @IsNotEmpty()
  nombre: string;
  @IsBoolean()
  @IsNotEmpty()
  estado: boolean;
}
