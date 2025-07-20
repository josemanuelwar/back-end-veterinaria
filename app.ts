import dotenv from "dotenv";
import Server from "./src/server";

dotenv.config();

const port = process.env.PORT || 8000;

// Instancia del servidor
const server = new Server(port);

// Inicialización
server.init();
