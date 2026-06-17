-- DROP DATABASE IF EXISTS "BibliotecaDigital";

CREATE DATABASE "BibliotecaDigital"
    WITH
    OWNER = postgres
    ENCODING = 'UTF8'
    LC_COLLATE = 'en_US.utf8'
    LC_CTYPE = 'en_US.utf8'
    LOCALE_PROVIDER = 'libc'
    TABLESPACE = pg_default
    CONNECTION LIMIT = -1
    IS_TEMPLATE = False;
-- =====================================================
-- 1. TABLA: AUTOR
-- =====================================================
CREATE TABLE AUTOR (
    id_autor INT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    nacionalidad VARCHAR(50),
    fecha_nacimiento DATE,
    obra_destacada VARCHAR(200)
);

-- =====================================================
-- 2. TABLA: LIBRO
-- =====================================================
CREATE TABLE LIBRO (
    id_libro INT PRIMARY KEY,
    titulo VARCHAR(200) NOT NULL,
    isbn VARCHAR(20) UNIQUE,
    editorial VARCHAR(100),
    categoria VARCHAR(50),
    num_paginas INT,
    anio_publicacion INT,
    ejemplares_total INT DEFAULT 1,
    descripcion TEXT
);

-- =====================================================
-- 3. TABLA: LIBRO_AUTOR (Relación N:M)
-- =====================================================
CREATE TABLE LIBRO_AUTOR (
    id_libro INT,
    id_autor INT,
    PRIMARY KEY (id_libro, id_autor),
    FOREIGN KEY (id_libro) REFERENCES LIBRO(id_libro),
    FOREIGN KEY (id_autor) REFERENCES AUTOR(id_autor)
);

-- =====================================================
-- 4. TABLA: USUARIO
-- =====================================================
CREATE TABLE USUARIO (
    id_usuario INT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    contrasena VARCHAR(50) NOT NULL,
    direccion VARCHAR(200),
    telefono VARCHAR(20),
    fecha_registro DATE DEFAULT CURRENT_DATE,
    tipo VARCHAR(20) CHECK (tipo IN ('estudiante', 'profesor', 'externo'))
);

-- =====================================================
-- 5. TABLA: PRESTAMO
-- =====================================================
CREATE TABLE PRESTAMO (
    id_prestamo INT PRIMARY KEY,
    id_usuario INT NOT NULL,
    fecha_prestamo DATE NOT NULL,
    fecha_devolucion_prevista DATE NOT NULL,
    fecha_devolucion_real DATE,
    estado VARCHAR(20) DEFAULT 'activo' CHECK (estado IN ('activo', 'devuelto', 'retrasado')),
    FOREIGN KEY (id_usuario) REFERENCES USUARIO(id_usuario)
);

-- =====================================================
-- 6. TABLA: DETALLE_PRESTAMO
-- =====================================================
CREATE TABLE DETALLE_PRESTAMO (
    id_prestamo INT,
    id_libro INT,
    fecha_devolucion_individual DATE,
    PRIMARY KEY (id_prestamo, id_libro),
    FOREIGN KEY (id_prestamo) REFERENCES PRESTAMO(id_prestamo) ON DELETE CASCADE,
    FOREIGN KEY (id_libro) REFERENCES LIBRO(id_libro)
);
