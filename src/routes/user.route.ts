import { Router } from 'express';
import UserController from '../controllers/user/User.Controller';

const router = Router();

router.get("/", UserController.index);

router.post("/regsiter", UserController.store);

export default router;
