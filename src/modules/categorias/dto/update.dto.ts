import { IsBoolean, IsNotEmpty, IsString } from 'class-validator';

export class UpdateDto {
  @IsString()
  @IsNotEmpty()
  nombre: string;
  @IsBoolean()
  @IsNotEmpty()
  estado: boolean;
}
