-- CreateTable
CREATE TABLE "Rol" (
    "id" SERIAL NOT NULL,
    "nombre" TEXT NOT NULL,

    CONSTRAINT "Rol_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "User" (
    "id" SERIAL NOT NULL,
    "email" TEXT NOT NULL,
    "password" TEXT NOT NULL,
    "rolId" INTEGER NOT NULL,

    CONSTRAINT "User_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Veterinaria" (
    "id" SERIAL NOT NULL,
    "userId" INTEGER NOT NULL,
    "nombre" TEXT NOT NULL,
    "direccion" TEXT NOT NULL,
    "telefono" TEXT NOT NULL,
    "email" TEXT NOT NULL,

    CONSTRAINT "Veterinaria_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Veterinarios" (
    "id" SERIAL NOT NULL,
    "nombreCompleto" TEXT NOT NULL,
    "especialidad" TEXT NOT NULL,
    "telefono" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "verterinariaId" INTEGER NOT NULL,
    "userId" INTEGER NOT NULL,

    CONSTRAINT "Veterinarios_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Cliente" (
    "id" SERIAL NOT NULL,
    "nombreCompleto" TEXT NOT NULL,
    "direccion" TEXT NOT NULL,
    "telefono" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "userId" INTEGER NOT NULL,

    CONSTRAINT "Cliente_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Mascota" (
    "id" SERIAL NOT NULL,
    "nomber" TEXT NOT NULL,
    "especie" TEXT NOT NULL,
    "raza" TEXT NOT NULL,
    "fechaNacimiento" TIMESTAMP(3) NOT NULL,
    "clienteId" INTEGER NOT NULL,

    CONSTRAINT "Mascota_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Citas" (
    "id" SERIAL NOT NULL,
    "fecha" TIMESTAMP(3) NOT NULL,
    "motivo" TEXT NOT NULL,
    "estado" TEXT NOT NULL,
    "mascotaId" INTEGER NOT NULL,
    "clienteId" INTEGER NOT NULL,

    CONSTRAINT "Citas_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "CategoriaMedicamento" (
    "id" SERIAL NOT NULL,
    "nombre" TEXT NOT NULL,
    "descripcion" TEXT,

    CONSTRAINT "CategoriaMedicamento_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Medicamento" (
    "id" SERIAL NOT NULL,
    "nombre" TEXT NOT NULL,
    "descripcion" TEXT,
    "fechaCaducidad" TIMESTAMP(3) NOT NULL,
    "cantidad" INTEGER NOT NULL,
    "veterinariaId" INTEGER NOT NULL,
    "categoriaId" INTEGER NOT NULL,

    CONSTRAINT "Medicamento_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "MedicamentoPrecio" (
    "id" SERIAL NOT NULL,
    "precioCompra" DECIMAL(10,2) NOT NULL,
    "precioVenta" DECIMAL(10,2) NOT NULL,
    "vigente" BOOLEAN NOT NULL DEFAULT true,
    "fechaRegistro" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "medicamentoId" INTEGER NOT NULL,

    CONSTRAINT "MedicamentoPrecio_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Receta" (
    "id" SERIAL NOT NULL,
    "citaId" INTEGER NOT NULL,
    "notas" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "Receta_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "RecetaItem" (
    "id" SERIAL NOT NULL,
    "recetaId" INTEGER NOT NULL,
    "medicamentoId" INTEGER NOT NULL,
    "dosis" TEXT NOT NULL,
    "duracion" TEXT NOT NULL,
    "observaciones" TEXT,

    CONSTRAINT "RecetaItem_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "Rol_nombre_key" ON "Rol"("nombre");

-- CreateIndex
CREATE UNIQUE INDEX "User_email_key" ON "User"("email");

-- CreateIndex
CREATE UNIQUE INDEX "CategoriaMedicamento_nombre_key" ON "CategoriaMedicamento"("nombre");

-- AddForeignKey
ALTER TABLE "User" ADD CONSTRAINT "User_rolId_fkey" FOREIGN KEY ("rolId") REFERENCES "Rol"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Veterinaria" ADD CONSTRAINT "Veterinaria_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Veterinarios" ADD CONSTRAINT "Veterinarios_verterinariaId_fkey" FOREIGN KEY ("verterinariaId") REFERENCES "Veterinaria"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Veterinarios" ADD CONSTRAINT "Veterinarios_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Cliente" ADD CONSTRAINT "Cliente_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Mascota" ADD CONSTRAINT "Mascota_clienteId_fkey" FOREIGN KEY ("clienteId") REFERENCES "Cliente"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Citas" ADD CONSTRAINT "Citas_mascotaId_fkey" FOREIGN KEY ("mascotaId") REFERENCES "Mascota"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Citas" ADD CONSTRAINT "Citas_clienteId_fkey" FOREIGN KEY ("clienteId") REFERENCES "Cliente"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Medicamento" ADD CONSTRAINT "Medicamento_veterinariaId_fkey" FOREIGN KEY ("veterinariaId") REFERENCES "Veterinaria"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Medicamento" ADD CONSTRAINT "Medicamento_categoriaId_fkey" FOREIGN KEY ("categoriaId") REFERENCES "CategoriaMedicamento"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "MedicamentoPrecio" ADD CONSTRAINT "MedicamentoPrecio_medicamentoId_fkey" FOREIGN KEY ("medicamentoId") REFERENCES "Medicamento"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Receta" ADD CONSTRAINT "Receta_citaId_fkey" FOREIGN KEY ("citaId") REFERENCES "Citas"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "RecetaItem" ADD CONSTRAINT "RecetaItem_recetaId_fkey" FOREIGN KEY ("recetaId") REFERENCES "Receta"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "RecetaItem" ADD CONSTRAINT "RecetaItem_medicamentoId_fkey" FOREIGN KEY ("medicamentoId") REFERENCES "Medicamento"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
