import prisma from "../../lib/prisma";

class RolService {

    public async findName(name: string) {
        try {

            return await prisma.rol.findFirst({
                where: {
                    nombre: name
                }
            });

        } catch (error) {
            throw error;
        }
    }
}

export default RolService;