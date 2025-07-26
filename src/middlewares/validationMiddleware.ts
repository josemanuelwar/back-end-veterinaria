
import { Request, Response, NextFunction } from "express";
import { ClassConstructor, plainToInstance } from "class-transformer";
import { validate } from "class-validator";


export function validationMiddleware<T extends object>(dto: ClassConstructor<T>) {
  return async (req: Request, res: Response, next: NextFunction) => {
    const object = plainToInstance(dto, req.body);
    const errors = await validate(object, { whitelist: true, forbidNonWhitelisted: true });

    if (errors.length > 0) {
      const formattedErrors = errors.map(err => ({
        field: err.property,
        errors: Object.values(err.constraints || {})
      }));
      return res.status(400).json({ errors: formattedErrors });
    }

    next();
  };
}
