import { Router } from 'express';
import userRoutes from './user.route';

export default function routerApi(): Router{
    const router = Router();
    router.use(userRoutes());
    
    return router;
}


