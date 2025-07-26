import express, { Application } from "express";
import cors from "cors";

import routerApi from "./routes";

class Server {
    private port: number | string;
    private app: Application;

    constructor(port: number | string) {
        this.port = port;
        this.app = express();
    }

    private setupMiddlewares(): void {
        this.app.use(cors());
        this.app.use(express.json());
    }

    private setupRoutes(): void {
        // Aquí se pueden agregar más rutas según sea necesario
        this.app.use("/api",routerApi());
        
    
    }

    private startServer(): void {
        this.app.listen(this.port, () => {
            console.log(`Servidor corriendo en http://localhost:${this.port}`);
        });
    }


    public async init(): Promise<void> {
        this.setupMiddlewares();
        this.setupRoutes();
        this.startServer();
    }

    public getApp(): Application {
        return this.app;
    }
}

export default Server;