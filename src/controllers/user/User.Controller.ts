import { Request, Response } from "express";

import UserService from "../../services/user/User.Service";
import generarPasswordHasheada from "../../utils/Paswordhas";


class UserController {
    private readonly service = new UserService();


    public login = async (request: Request, response: Response) => {
        try {

            const { email, password } = request.body;
            const valido = await this.service.validarLogin(email, password);

            if (!valido) {
                return response.status(401).json({ message: 'Credenciales incorrectas' });
            }

            response.status(200).json({ message: 'Login correcto' });

        } catch (error) {
            response.status(500).json({ message: 'Error en el servidor' });
        }
    }

    public store = async (request: Request, response: Response) => {
        try {
            const { email, rol } = request.body;
            const { plain, hash } = await generarPasswordHasheada();

            const newUser = await this.service.Save({ email, password: hash, rol });

            response.status(201).json({
                message: 'Usuario creado correctamente',
                data: newUser,
                passwordTemporal: plain // opcional
            });
        } catch (error) {
            response.status(500).json({ message: 'Error en el servidor' });
        }
    };
}

export default new UserController();