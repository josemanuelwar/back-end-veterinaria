import prisma from "../../lib/prisma";
import verificarPassword from "../../utils/verificarPassword";
import { userInterface } from "./interface/User.Interface";
class UserService {

    public async validarLogin(email: string, password: string) {
        const user = await prisma.user.findUnique({
            where: { email },
            select: { password: true }
        });

        if (!user) {
            return false;
        }

        const esValida = await verificarPassword(password, user.password);
        return esValida;
    }




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
            console.log(user);

            return await prisma.user.create({
                data: {
                    email: user.email,
                    password: user.password,
                    rolId: user.rol
                },
            });
        } catch (error) {
            throw error;
        }
    }


}


export default UserService;