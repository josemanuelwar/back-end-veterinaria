import bcrypt from 'bcryptjs';


function generarPasswordAleatoria(longitud: number = 10): string {
    const caracteres = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789!@#$%^&*';
    let password = '';

    for (let i = 0; i < longitud; i++) {
        const indice = Math.floor(Math.random() * caracteres.length);
        password += caracteres[indice];
    }

    return password;
}



export default async function generarPasswordHasheada(): Promise<{ plain: string; hash: string }> {
    const plainPassword = generarPasswordAleatoria(10);
    const hash = await bcrypt.hash(plainPassword, 10); // 10 es el salt rounds

    return { plain: plainPassword, hash };
}



