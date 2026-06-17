-- =====================================================
-- 1. AUTORES (30 tuplas)
-- =====================================================
INSERT INTO AUTOR (id_autor, nombre, nacionalidad, fecha_nacimiento, obra_destacada) VALUES
(1, 'Gabriel García Márquez', 'Colombiana', '1927-03-06', 'Cien años de soledad'),
(2, 'J.K. Rowling', 'Británica', '1965-07-31', 'Harry Potter y la piedra filosofal'),
(3, 'George R.R. Martin', 'Estadounidense', '1948-09-20', 'Juego de Tronos'),
(4, 'Isabel Allende', 'Chilena', '1942-08-02', 'La casa de los espíritus'),
(5, 'Dan Brown', 'Estadounidense', '1964-06-22', 'El código Da Vinci'),
(6, 'Paulo Coelho', 'Brasileña', '1947-08-24', 'El alquimista'),
(7, 'Mario Vargas Llosa', 'Peruana', '1936-03-28', 'La ciudad y los perros'),
(8, 'Stephen King', 'Estadounidense', '1947-09-21', 'El resplandor'),
(9, 'Jane Austen', 'Británica', '1775-12-16', 'Orgullo y prejuicio'),
(10, 'Julio Verne', 'Francesa', '1828-02-08', 'Veinte mil leguas de viaje submarino'),
(11, 'J.R.R. Tolkien', 'Británica', '1892-01-03', 'El Señor de los Anillos'),
(12, 'Agatha Christie', 'Británica', '1890-09-15', 'Asesinato en el Orient Express'),
(13, 'Haruki Murakami', 'Japonesa', '1949-01-12', 'Kafka en la orilla'),
(14, 'Carlos Ruiz Zafón', 'Española', '1964-09-25', 'La sombra del viento'),
(15, 'Jorge Luis Borges', 'Argentina', '1899-08-24', 'Ficciones'),
(16, 'Octavio Paz', 'Mexicana', '1914-03-31', 'El laberinto de la soledad'),
(17, 'Elena Poniatowska', 'Mexicana', '1932-05-19', 'La noche de Tlatelolco'),
(18, 'Carlos Fuentes', 'Mexicana', '1928-11-11', 'La muerte de Artemio Cruz'),
(19, 'Juan Rulfo', 'Mexicana', '1917-05-16', 'Pedro Páramo'),
(20, 'Rosario Castellanos', 'Mexicana', '1925-05-25', 'Balún Canán'),
(21, 'Laura Esquivel', 'Mexicana', '1950-09-30', 'Como agua para chocolate'),
(22, 'Ángeles Mastretta', 'Mexicana', '1949-10-09', 'Arráncame la vida'),
(23, 'Sergio Pitol', 'Mexicana', '1933-03-18', 'El arte de la fuga'),
(24, 'José Emilio Pacheco', 'Mexicana', '1939-06-30', 'Las batallas en el desierto'),
(25, 'David Foster Wallace', 'Estadounidense', '1962-02-21', 'La broma infinita'),
(26, 'Don DeLillo', 'Estadounidense', '1936-11-20', 'Submundo'),
(27, 'Toni Morrison', 'Estadounidense', '1931-02-18', 'Beloved'),
(28, 'Philip Roth', 'Estadounidense', '1933-03-19', 'La mancha humana'),
(29, 'Cormac McCarthy', 'Estadounidense', '1933-07-20', 'La carretera'),
(30, 'Margaret Atwood', 'Canadiense', '1939-11-18', 'El cuento de la criada');

-- =====================================================
-- 2. LIBROS (30 tuplas)
-- =====================================================
INSERT INTO LIBRO (id_libro, titulo, isbn, editorial, categoria, num_paginas, anio_publicacion, ejemplares_total, descripcion) VALUES
(1, 'Cien años de soledad', '9788437604947', 'Sudamericana', 'Novela', 496, 1967, 15, 'Realismo mágico, historia de la familia Buendía'),
(2, 'El amor en los tiempos del cólera', '9788437604954', 'Sudamericana', 'Novela', 401, 1985, 8, 'Historia de amor eterno'),
(3, 'Harry Potter y la piedra filosofal', '9788478884455', 'Salamandra', 'Fantasía', 254, 1997, 20, 'Primera aventura de Harry Potter'),
(4, 'Harry Potter y la cámara secreta', '9788478884950', 'Salamandra', 'Fantasía', 320, 1998, 18, 'Segunda aventura de Harry Potter'),
(5, 'Harry Potter y el prisionero de Azkaban', '9788478884951', 'Salamandra', 'Fantasía', 368, 1999, 16, 'Tercera aventura de Harry Potter'),
(6, 'Harry Potter y el cáliz de fuego', '9788478884952', 'Salamandra', 'Fantasía', 640, 2000, 14, 'Cuarta aventura de Harry Potter'),
(7, 'Juego de Tronos', '9788401324910', 'Plaza & Janés', 'Fantasía', 800, 1996, 10, 'Primer libro de Canción de Hielo y Fuego'),
(8, 'La casa de los espíritus', '9788401324958', 'Plaza & Janés', 'Novela', 432, 1982, 7, 'Historia de la familia Trueba'),
(9, 'El código Da Vinci', '9788401324972', 'Planeta', 'Misterio', 656, 2003, 12, 'Misterio en el Louvre'),
(10, 'El alquimista', '9788401324989', 'HarperCollins', 'Fábula', 192, 1988, 25, 'Viaje de un pastor andaluz'),
(11, 'Orgullo y prejuicio', '9788491051277', 'Penguin', 'Clásico', 432, 1813, 10, 'Historia de Elizabeth Bennet'),
(12, 'Veinte mil leguas de viaje submarino', '9788491051284', 'Penguin', 'Aventura', 480, 1870, 8, 'Aventuras del Capitán Nemo'),
(13, 'El Señor de los Anillos: La Comunidad del Anillo', '9788445005400', 'Minotauro', 'Fantasía', 576, 1954, 12, 'Primera parte de la trilogía'),
(14, 'El Señor de los Anillos: Las Dos Torres', '9788445005417', 'Minotauro', 'Fantasía', 512, 1954, 11, 'Segunda parte de la trilogía'),
(15, 'El Señor de los Anillos: El Retorno del Rey', '9788445005424', 'Minotauro', 'Fantasía', 544, 1955, 10, 'Tercera parte de la trilogía'),
(16, 'Asesinato en el Orient Express', '9788401324996', 'Planeta', 'Misterio', 256, 1934, 8, 'Clásico de Agatha Christie'),
(17, 'Kafka en la orilla', '9788401324997', 'Tusquets', 'Novela', 464, 2002, 6, 'Novela de Murakami'),
(18, 'La sombra del viento', '9788401324998', 'Planeta', 'Novela', 512, 2001, 9, 'Bestseller de Ruiz Zafón'),
(19, 'Ficciones', '9788401324999', 'Alianza', 'Cuento', 192, 1944, 7, 'Colección de cuentos de Borges'),
(20, 'El laberinto de la soledad', '9788401325000', 'Fondo de Cultura', 'Ensayo', 192, 1950, 5, 'Ensayo de Octavio Paz'),
(21, 'La noche de Tlatelolco', '9788401325001', 'ERA', 'Historia', 256, 1971, 4, 'Crónica de la matanza de 1968'),
(22, 'La muerte de Artemio Cruz', '9788401325002', 'Fondo de Cultura', 'Novela', 288, 1962, 6, 'Novela de Carlos Fuentes'),
(23, 'Pedro Páramo', '9788401325003', 'Fondo de Cultura', 'Novela', 144, 1955, 8, 'Obra maestra de Juan Rulfo'),
(24, 'Balún Canán', '9788401325004', 'Fondo de Cultura', 'Novela', 256, 1957, 4, 'Novela de Rosario Castellanos'),
(25, 'Como agua para chocolate', '9788401325005', 'Planeta', 'Novela', 256, 1989, 12, 'Novela de Laura Esquivel'),
(26, 'Arráncame la vida', '9788401325006', 'Seix Barral', 'Novela', 256, 1985, 7, 'Novela de Ángeles Mastretta'),
(27, 'El arte de la fuga', '9788401325007', 'ERA', 'Ensayo', 224, 1996, 3, 'Ensayo de Sergio Pitol'),
(28, 'Las batallas en el desierto', '9788401325008', 'ERA', 'Novela', 80, 1981, 6, 'Novela corta de José Emilio Pacheco'),
(29, 'La carretera', '9788401325009', 'Literatura Random House', 'Novela', 288, 2006, 5, 'Novela post-apocalíptica de McCarthy'),
(30, 'El cuento de la criada', '9788401325010', 'Salamandra', 'Novela', 384, 1985, 8, 'Novela distópica de Atwood');

-- =====================================================
-- 3. RELACIÓN LIBRO_AUTOR (40 registros - varios libros con autores múltiples)
-- =====================================================
INSERT INTO LIBRO_AUTOR (id_libro, id_autor) VALUES
-- García Márquez (id_autor = 1): libros 1 y 2
(1,  1),
(2,  1),
 
-- J.K. Rowling (id_autor = 2): libros 3, 4, 5, 6
(3,  2),
(4,  2),
(5,  2),
(6,  2),
 
-- George R.R. Martin (id_autor = 3): libro 7
(7,  3),
 
-- Isabel Allende (id_autor = 4): libro 8
(8,  4),
 
-- Dan Brown (id_autor = 5): libro 9
(9,  5),
 
-- Paulo Coelho (id_autor = 6): libro 10
(10, 6),
 
-- Jane Austen (id_autor = 9): libro 11
(11, 9),
 
-- Julio Verne (id_autor = 10): libro 12
(12, 10),
 
-- J.R.R. Tolkien (id_autor = 11): libros 13, 14, 15
(13, 11),
(14, 11),
(15, 11),
 
-- Agatha Christie (id_autor = 12): libro 16
(16, 12),
 
-- Haruki Murakami (id_autor = 13): libro 17
(17, 13),
 
-- Carlos Ruiz Zafón (id_autor = 14): libro 18
(18, 14),
 
-- Jorge Luis Borges (id_autor = 15): libro 19
(19, 15),
 
-- Octavio Paz (id_autor = 16): libro 20
(20, 16),
 
-- Elena Poniatowska (id_autor = 17): libro 21
(21, 17),
 
-- Carlos Fuentes (id_autor = 18): libro 22
(22, 18),
 
-- Juan Rulfo (id_autor = 19): libro 23
(23, 19),
 
-- Rosario Castellanos (id_autor = 20): libro 24
(24, 20),
 
-- Laura Esquivel (id_autor = 21): libro 25
(25, 21),
 
-- Ángeles Mastretta (id_autor = 22): libro 26
(26, 22),
 
-- Sergio Pitol (id_autor = 23): libro 27
(27, 23),
 
-- José Emilio Pacheco (id_autor = 24): libro 28
(28, 24),
 
-- Cormac McCarthy (id_autor = 29): libro 29
(29, 29),
 
-- Margaret Atwood (id_autor = 30): libro 30
(30, 30),
 
-- ─── Colaboraciones hipotéticas (múltiples autores) ──────────────────────
-- El Señor de los Anillos (libro 13) + George R.R. Martin
(13, 3),
 
-- La sombra del viento (libro 18) + Mario Vargas Llosa
(18, 7),
 
-- Como agua para chocolate (libro 25) + Paulo Coelho
(25, 6),
 
-- El cuento de la criada (libro 30) + Haruki Murakami
(30, 13);
 

-- =====================================================
-- 4. USUARIOS (30 tuplas)
-- =====================================================
INSERT INTO USUARIO (id_usuario, nombre, email, contrasena, direccion, telefono, fecha_registro, tipo) VALUES
(1, 'Ana García', 'ana.garcia@email.com', 'pass123', 'Calle 1 #123, Colonia Centro', '555-0101', '2024-01-15', 'estudiante'),
(2, 'Luis Martínez', 'luis.martinez@email.com', 'pass456', 'Avenida 2 #456, Colonia Reforma', '555-0102', '2024-01-20', 'profesor'),
(3, 'María López', 'maria.lopez@email.com', 'pass789', 'Boulevard 3 #789, Colonia Del Valle', '555-0103', '2024-02-01', 'estudiante'),
(4, 'Carlos Rodríguez', 'carlos.rod@email.com', 'pass234', 'Calle 4 #234, Colonia Roma', '555-0104', '2024-02-10', 'externo'),
(5, 'Laura Fernández', 'laura.fer@email.com', 'pass567', 'Avenida 5 #567, Colonia Condesa', '555-0105', '2024-03-01', 'estudiante'),
(6, 'Pedro Sánchez', 'pedro.san@email.com', 'pass890', 'Calle 6 #890, Colonia Narvarte', '555-0106', '2024-03-15', 'profesor'),
(7, 'Sofía Ramírez', 'sofia.ram@email.com', 'pass112', 'Boulevard 7 #111, Colonia Polanco', '555-0107', '2024-04-01', 'estudiante'),
(8, 'Jorge Torres', 'jorge.tor@email.com', 'pass223', 'Calle 8 #222, Colonia San Rafael', '555-0108', '2024-04-15', 'externo'),
(9, 'Carmen Vega', 'carmen.veg@email.com', 'pass334', 'Avenida 9 #333, Colonia Santa María', '555-0109', '2024-05-01', 'estudiante'),
(10, 'Ricardo Méndez', 'ricardo.men@email.com', 'pass445', 'Calle 10 #444, Colonia Tlatelolco', '555-0110', '2024-05-15', 'profesor'),
(11, 'Daniela Castro', 'daniela.cas@email.com', 'pass556', 'Boulevard 11 #555, Colonia Escandón', '555-0111', '2024-06-01', 'estudiante'),
(12, 'Alejandro Reyes', 'alejandro.rey@email.com', 'pass667', 'Calle 12 #666, Colonia Tacubaya', '555-0112', '2024-06-10', 'externo'),
(13, 'Valentina Ortiz', 'valentina.ort@email.com', 'pass778', 'Avenida 13 #777, Colonia Coyoacán', '555-0113', '2024-06-15', 'estudiante'),
(14, 'Fernando Silva', 'fernando.sil@email.com', 'pass889', 'Calle 14 #888, Colonia San Ángel', '555-0114', '2024-07-01', 'profesor'),
(15, 'Isabel Guerrero', 'isabel.gue@email.com', 'pass990', 'Boulevard 15 #999, Colonia Lindavista', '555-0115', '2024-07-10', 'estudiante'),
(16, 'Raúl Espinoza', 'raul.esp@email.com', 'pass101', 'Calle 16 #1010, Colonia Clavería', '555-0116', '2024-07-15', 'externo'),
(17, 'Adriana Molina', 'adriana.mol@email.com', 'pass202', 'Avenida 17 #1111, Colonia Azcapotzalco', '555-0117', '2024-08-01', 'estudiante'),
(18, 'Roberto Soto', 'roberto.sot@email.com', 'pass303', 'Calle 18 #1212, Colonia Tepeyac', '555-0118', '2024-08-10', 'profesor'),
(19, 'Paulina Rivas', 'paulina.riv@email.com', 'pass404', 'Boulevard 19 #1313, Colonia Villa Olímpica', '555-0119', '2024-08-15', 'estudiante'),
(20, 'Gilberto Paredes', 'gilberto.par@email.com', 'pass505', 'Calle 20 #1414, Colonia Lomas', '555-0120', '2024-09-01', 'externo'),
(21, 'Mónica Guzmán', 'monica.guz@email.com', 'pass606', 'Avenida 21 #1515, Colonia Bosques', '555-0121', '2024-09-10', 'estudiante'),
(22, 'Arturo Delgado', 'arturo.del@email.com', 'pass707', 'Calle 22 #1616, Colonia Vallejo', '555-0122', '2024-09-15', 'profesor'),
(23, 'Elena Flores', 'elena.flo@email.com', 'pass808', 'Boulevard 23 #1717, Colonia Zacatenco', '555-0123', '2024-10-01', 'estudiante'),
(24, 'Pablo Mendoza', 'pablo.men@email.com', 'pass909', 'Calle 24 #1818, Colonia Industrial', '555-0124', '2024-10-10', 'externo'),
(25, 'Catalina Herrera', 'catalina.her@email.com', 'pass010', 'Avenida 25 #1919, Colonia Granjas', '555-0125', '2024-10-15', 'estudiante'),
(26, 'Héctor Suárez', 'hector.sua@email.com', 'pass110', 'Calle 26 #2020, Colonia Pantitlán', '555-0126', '2024-11-01', 'profesor'),
(27, 'Mariana Bravo', 'mariana.bra@email.com', 'pass220', 'Boulevard 27 #2121, Colonia Aeropuerto', '555-0127', '2024-11-10', 'estudiante'),
(28, 'Javier Campos', 'javier.cam@email.com', 'pass330', 'Calle 28 #2222, Colonia Peñón', '555-0128', '2024-11-15', 'externo'),
(29, 'Teresa Acosta', 'teresa.aco@email.com', 'pass440', 'Avenida 29 #2323, Colonia Jardines', '555-0129', '2024-12-01', 'estudiante'),
(30, 'Eduardo Núñez', 'eduardo.nun@email.com', 'pass550', 'Calle 30 #2424, Colonia San Pedro', '555-0130', '2024-12-10', 'profesor');

-- =====================================================
-- 5. PRESTAMOS (50 tuplas)
-- =====================================================
-- Usaré un bloque PL/SQL o una serie de INSERTs para simular 50 préstamos
-- Para simplificar, usaré un generador manual con fechas variadas

INSERT INTO PRESTAMO (id_prestamo, id_usuario, fecha_prestamo, fecha_devolucion_prevista, fecha_devolucion_real, estado) VALUES
-- PRÉSTAMOS ACTIVOS (fecha_devolucion_real = NULL)
(1, 1, '2024-05-01', '2024-05-15', '2024-05-14', 'devuelto'),
(2, 2, '2024-05-03', '2024-05-17', '2024-05-16', 'devuelto'),
(3, 3, '2024-05-10', '2024-05-24', NULL, 'activo'),
(4, 4, '2024-05-12', '2024-05-26', NULL, 'activo'),
(5, 5, '2024-05-15', '2024-05-29', '2024-05-28', 'devuelto'),
(6, 6, '2024-05-18', '2024-06-01', NULL, 'activo'),
(7, 7, '2024-05-20', '2024-06-03', NULL, 'activo'),
(8, 8, '2024-05-22', '2024-06-05', '2024-06-04', 'devuelto'),
(9, 9, '2024-05-25', '2024-06-08', NULL, 'activo'),
(10, 10, '2024-05-28', '2024-06-11', NULL, 'activo'),
(11, 1, '2024-06-01', '2024-06-15', NULL, 'activo'),
(12, 3, '2024-06-05', '2024-06-19', NULL, 'activo'),
(13, 11, '2024-06-08', '2024-06-22', '2024-06-20', 'devuelto'),
(14, 12, '2024-06-10', '2024-06-24', NULL, 'activo'),
(15, 13, '2024-06-12', '2024-06-26', '2024-06-25', 'devuelto'),
(16, 14, '2024-06-15', '2024-06-29', NULL, 'activo'),
(17, 15, '2024-06-18', '2024-07-02', NULL, 'activo'),
(18, 16, '2024-06-20', '2024-07-04', '2024-07-03', 'devuelto'),
(19, 17, '2024-06-22', '2024-07-06', NULL, 'activo'),
(20, 18, '2024-06-25', '2024-07-09', NULL, 'activo'),
(21, 19, '2024-07-01', '2024-07-15', '2024-07-14', 'devuelto'),
(22, 20, '2024-07-03', '2024-07-17', NULL, 'activo'),
(23, 21, '2024-07-05', '2024-07-19', '2024-07-18', 'devuelto'),
(24, 22, '2024-07-08', '2024-07-22', NULL, 'activo'),
(25, 23, '2024-07-10', '2024-07-24', NULL, 'activo'),
(26, 24, '2024-07-12', '2024-07-26', '2024-07-25', 'devuelto'),
(27, 25, '2024-07-15', '2024-07-29', NULL, 'activo'),
(28, 26, '2024-07-18', '2024-08-01', NULL, 'activo'),
(29, 27, '2024-07-20', '2024-08-03', '2024-08-02', 'devuelto'),
(30, 28, '2024-07-22', '2024-08-05', NULL, 'activo'),
(31, 29, '2024-08-01', '2024-08-15', NULL, 'activo'),
(32, 30, '2024-08-03', '2024-08-17', '2024-08-16', 'devuelto'),
(33, 1, '2024-08-05', '2024-08-19', NULL, 'activo'),
(34, 2, '2024-08-08', '2024-08-22', '2024-08-21', 'devuelto'),
(35, 3, '2024-08-10', '2024-08-24', NULL, 'activo'),
(36, 4, '2024-08-12', '2024-08-26', NULL, 'activo'),
(37, 5, '2024-08-15', '2024-08-29', '2024-08-28', 'devuelto'),
(38, 6, '2024-08-18', '2024-09-01', NULL, 'activo'),
(39, 7, '2024-08-20', '2024-09-03', '2024-09-02', 'devuelto'),
(40, 8, '2024-08-22', '2024-09-05', NULL, 'activo'),
(41, 9, '2024-09-01', '2024-09-15', NULL, 'activo'),
(42, 10, '2024-09-03', '2024-09-17', '2024-09-16', 'devuelto'),
(43, 11, '2024-09-05', '2024-09-19', NULL, 'activo'),
(44, 12, '2024-09-08', '2024-09-22', NULL, 'activo'),
(45, 13, '2024-09-10', '2024-09-24', '2024-09-23', 'devuelto'),
(46, 14, '2024-09-12', '2024-09-26', NULL, 'activo'),
(47, 15, '2024-09-15', '2024-09-29', '2024-09-28', 'devuelto'),
(48, 16, '2024-09-18', '2024-10-02', NULL, 'activo'),
(49, 17, '2024-09-20', '2024-10-04', NULL, 'activo'),
(50, 18, '2024-09-22', '2024-10-06', '2024-10-05', 'devuelto');

-- =====================================================
-- 6. DETALLE_PRESTAMO (100+ tuplas)
-- =====================================================
-- Asignación de libros a cada préstamo (entre 1 y 4 libros por préstamo)
INSERT INTO DETALLE_PRESTAMO (id_prestamo, id_libro, fecha_devolucion_individual) VALUES
-- Préstamo 1 (devuelto)
(1, 1, '2024-05-14'),
(1, 2, '2024-05-14'),
(1, 3, '2024-05-14'),
-- Préstamo 2 (devuelto)
(2, 4, '2024-05-16'),
(2, 5, '2024-05-16'),
-- Préstamo 3 (activo)
(3, 6, NULL),
(3, 7, NULL),
-- Préstamo 4 (activo)
(4, 8, NULL),
(4, 9, NULL),
(4, 10, NULL),
-- Préstamo 5 (devuelto)
(5, 11, '2024-05-28'),
(5, 12, '2024-05-28'),
-- Préstamo 6 (activo)
(6, 13, NULL),
(6, 14, NULL),
-- Préstamo 7 (activo)
(7, 15, NULL),
(7, 16, NULL),
(7, 17, NULL),
-- Préstamo 8 (devuelto)
(8, 18, '2024-06-04'),
(8, 19, '2024-06-04'),
-- Préstamo 9 (activo)
(9, 20, NULL),
(9, 21, NULL),
-- Préstamo 10 (activo)
(10, 22, NULL),
(10, 23, NULL),
-- Préstamo 11 (activo)
(11, 24, NULL),
(11, 25, NULL),
(11, 26, NULL),
-- Préstamo 12 (activo)
(12, 27, NULL),
(12, 28, NULL),
-- Préstamo 13 (devuelto)
(13, 29, '2024-06-20'),
(13, 30, '2024-06-20'),
-- Préstamo 14 (activo)
(14, 1, NULL),
(14, 2, NULL),
-- Préstamo 15 (devuelto)
(15, 3, '2024-06-25'),
(15, 4, '2024-06-25'),
(15, 5, '2024-06-25'),
-- Préstamo 16 (activo)
(16, 6, NULL),
(16, 7, NULL),
(16, 8, NULL),
-- Préstamo 17 (activo)
(17, 9, NULL),
(17, 10, NULL),
-- Préstamo 18 (devuelto)
(18, 11, '2024-07-03'),
(18, 12, '2024-07-03'),
(18, 13, '2024-07-03'),
-- Préstamo 19 (activo)
(19, 14, NULL),
(19, 15, NULL),
-- Préstamo 20 (activo)
(20, 16, NULL),
(20, 17, NULL),
(20, 18, NULL),
-- Préstamo 21 (devuelto)
(21, 19, '2024-07-14'),
(21, 20, '2024-07-14'),
-- Préstamo 22 (activo)
(22, 21, NULL),
(22, 22, NULL),
-- Préstamo 23 (devuelto)
(23, 23, '2024-07-18'),
(23, 24, '2024-07-18'),
(23, 25, '2024-07-18'),
-- Préstamo 24 (activo)
(24, 26, NULL),
(24, 27, NULL),
-- Préstamo 25 (activo)
(25, 28, NULL),
(25, 29, NULL),
(25, 30, NULL),
-- Préstamo 26 (devuelto)
(26, 1, '2024-07-25'),
(26, 2, '2024-07-25'),
-- Préstamo 27 (activo)
(27, 3, NULL),
(27, 4, NULL),
-- Préstamo 28 (activo)
(28, 5, NULL),
(28, 6, NULL),
(28, 7, NULL),
-- Préstamo 29 (devuelto)
(29, 8, '2024-08-02'),
(29, 9, '2024-08-02'),
-- Préstamo 30 (activo)
(30, 10, NULL),
(30, 11, NULL),
-- Préstamo 31 (activo)
(31, 12, NULL),
(31, 13, NULL),
(31, 14, NULL),
-- Préstamo 32 (devuelto)
(32, 15, '2024-08-16'),
(32, 16, '2024-08-16'),
-- Préstamo 33 (activo)
(33, 17, NULL),
(33, 18, NULL),
-- Préstamo 34 (devuelto)
(34, 19, '2024-08-21'),
(34, 20, '2024-08-21'),
(34, 21, '2024-08-21'),
-- Préstamo 35 (activo)
(35, 22, NULL),
(35, 23, NULL),
-- Préstamo 36 (activo)
(36, 24, NULL),
(36, 25, NULL),
(36, 26, NULL),
-- Préstamo 37 (devuelto)
(37, 27, '2024-08-28'),
(37, 28, '2024-08-28'),
-- Préstamo 38 (activo)
(38, 29, NULL),
(38, 30, NULL),
-- Préstamo 39 (devuelto)
(39, 1, '2024-09-02'),
(39, 2, '2024-09-02'),
(39, 3, '2024-09-02'),
-- Préstamo 40 (activo)
(40, 4, NULL),
(40, 5, NULL),
-- Préstamo 41 (activo)
(41, 6, NULL),
(41, 7, NULL),
(41, 8, NULL),
-- Préstamo 42 (devuelto)
(42, 9, '2024-09-16'),
(42, 10, '2024-09-16'),
-- Préstamo 43 (activo)
(43, 11, NULL),
(43, 12, NULL),
-- Préstamo 44 (activo)
(44, 13, NULL),
(44, 14, NULL),
(44, 15, NULL),
-- Préstamo 45 (devuelto)
(45, 16, '2024-09-23'),
(45, 17, '2024-09-23'),
-- Préstamo 46 (activo)
(46, 18, NULL),
(46, 19, NULL),
-- Préstamo 47 (devuelto)
(47, 20, '2024-09-28'),
(47, 21, '2024-09-28'),
(47, 22, '2024-09-28'),
-- Préstamo 48 (activo)
(48, 23, NULL),
(48, 24, NULL),
-- Préstamo 49 (activo)
(49, 25, NULL),
(49, 26, NULL),
(49, 27, NULL),
-- Préstamo 50 (devuelto)
(50, 28, '2024-10-05'),
(50, 29, '2024-10-05'),
(50, 30, '2024-10-05');

-- =====================================================
-- CONSULTAS DE VERIFICACIÓN
-- =====================================================

-- Verificar conteo de registros
SELECT 'AUTOR' AS Tabla, COUNT(*) AS Total FROM AUTOR
UNION ALL
SELECT 'LIBRO', COUNT(*) FROM LIBRO
UNION ALL
SELECT 'LIBRO_AUTOR', COUNT(*) FROM LIBRO_AUTOR
UNION ALL
SELECT 'USUARIO', COUNT(*) FROM USUARIO
UNION ALL
SELECT 'PRESTAMO', COUNT(*) FROM PRESTAMO
UNION ALL
SELECT 'DETALLE_PRESTAMO', COUNT(*) FROM DETALLE_PRESTAMO;

-- Resultado esperado:
-- AUTOR: 30
-- LIBRO: 30
-- LIBRO_AUTOR: 48
-- USUARIO: 30
-- PRESTAMO: 50
-- DETALLE_PRESTAMO: 130+
-------------------------------------------------------------------------------------------------------

-- =====================================================
-- Verificación rápida (ejecuta después del INSERT):
-- Debe devolver 44.
-- =====================================================
-- SELECT COUNT(*) FROM LIBRO_AUTOR;