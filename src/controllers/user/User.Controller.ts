import { Request, Response } from "express";
import UserService from "../../services/user/User.Service";

class UserController {

    private readonly service: UserService;

    public constructor() {
        this.service = new UserService();
    }


    public index() {
        return "hola";
    }

    public async store(request: Request, response: Response) {
        try {
            const { email, password, rol } = request.body;
            const newUser = await this.service.Save({ email, password, rol });
            response.status(200).json({ data: { newUser } });
        } catch (error) {
            response.status(500).json({
                data: {
                    message: "Error en el servidor"
                }
            });
        }
    }

}

export default new UserController();