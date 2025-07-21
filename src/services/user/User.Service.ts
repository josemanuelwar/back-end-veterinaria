import prisma from "../../lib/prisma";
import { userInterface } from "./interface/User.Interface";
class UserService {

  

    public async findEmail(email: string) {
        try {
            return await prisma.user.findUnique({
                where: {
                    email
                },
                select: {
                    email: true,
                    password: true,
                }
            });
        } catch (error) {
            throw error;
        }
    }

    public async Save(user: userInterface) {
        try {
            return await prisma.user.create({
                data: {
                    email:  user.email,
                    password: user.password,
                    rolId:user.rol
                },
            });
        } catch (error) {
            throw error;
        }
    }


}


export default UserService;