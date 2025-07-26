import { Router } from 'express';
import UserController from '../controllers/user/User.Controller';
import { validationMiddleware } from '../middlewares/validationMiddleware';
import { createUserDto } from '../DTO/user/CreateUserDto'
import { LoginDto } from '../DTO/user/LoginDto';

export default function UserRoutes(): Router {
    const router = Router();

    router.post("/login", validationMiddleware(LoginDto), UserController.login)

    router.post("/register_user", validationMiddleware(createUserDto), UserController.store);

    return router;
}