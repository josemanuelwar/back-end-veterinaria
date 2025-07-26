
import { IsEmail, IsString, IsInt} from "class-validator";

export class createUserDto{
    
    @IsString()
    @IsEmail()
    public email!:string;
    @IsInt()
    public rol!:number;
}