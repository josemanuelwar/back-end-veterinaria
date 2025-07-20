import { Router } from 'express';

const router = Router();

// Aquí importarás y montarás otras rutas
// router.use('/auth', authRoutes);

router.get('/', (req, res) => {
  res.json({ message: 'API Express funcionando correctamente' });
});

export default router;
