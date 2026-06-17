-- =====================================================
-- CASO INTEGRADOR: BIBLIOTECA DIGITAL
-- Prácticas 7, 8 y 9 — Álgebra Relacional y Cálculo Relacional
-- IPN — Escuela Superior de Cómputo
-- Bases de Datos | ISC 2020
-- =====================================================
-- Archivo: 03_queries.sql
-- Descripción: 20 consultas del caso integrador expresadas en SQL,
--              equivalentes a sus expresiones en Álgebra Relacional (AR),
--              Cálculo Relacional de Tuplas (CRT) y Cálculo Relacional de
--              Dominios (CRD) documentadas en el archivo README.md y en el
--              documento PDF de entrega.
-- Motor: PostgreSQL 14+
-- =====================================================


-- =====================================================
-- SECCIÓN 1: OPERADORES BÁSICOS (Consultas 1–5)
-- Operadores: σ (selección), π (proyección), ∪, ∩, −, ×
-- =====================================================

-- ----------------------------------------------------
-- CONSULTA 1: Selección + Proyección
-- Descripción : Obtener el título y año de publicación de los libros
--               de categoría 'Fantasía' publicados después de 1990.
-- AR          : π_titulo, anio_publicacion(σ_categoria='Fantasía' ∧ anio_publicacion>1990(LIBRO))
-- CRT         : {t.titulo, t.anio_publicacion | LIBRO(t) ∧ t.categoria='Fantasía'
--                 ∧ t.anio_publicacion > 1990}
-- CRD         : {<titulo, anio> | ∃id, isbn, ed, cat, pag, ej, desc
--                 (LIBRO(id, titulo, isbn, ed, cat, pag, anio, ej, desc)
--                  ∧ cat='Fantasía' ∧ anio > 1990)}
-- ----------------------------------------------------
SELECT titulo,
       anio_publicacion
FROM   LIBRO
WHERE  categoria         = 'Fantasía'
  AND  anio_publicacion  > 1990
ORDER  BY anio_publicacion;


-- ----------------------------------------------------
-- CONSULTA 2: Unión (∪)
-- Descripción : Obtener todos los nombres de personas que son usuarios
--               O autores del sistema (sin duplicados).
-- AR          : π_nombre(USUARIO) ∪ π_nombre(AUTOR)
-- CRT         : {t.nombre | USUARIO(t)} ∪ {a.nombre | AUTOR(a)}
-- CRD         : {<nombre> | ∃id_u,email,c,dir,tel,fr,tipo
--                 (USUARIO(id_u,nombre,email,c,dir,tel,fr,tipo))
--                ∨ ∃id_a,nac,fn,obra (AUTOR(id_a,nombre,nac,fn,obra))}
-- ----------------------------------------------------
SELECT nombre FROM USUARIO
UNION
SELECT nombre FROM AUTOR
ORDER BY nombre;


-- ----------------------------------------------------
-- CONSULTA 3: Intersección (∩)
-- Descripción : Obtener títulos de libros que son de categoría 'Novela'
--               Y que han sido prestados al menos una vez.
-- AR          : π_titulo(σ_categoria='Novela'(LIBRO))
--               ∩ π_titulo(LIBRO ⋈ DETALLE_PRESTAMO)
-- CRT         : {t.titulo | LIBRO(t) ∧ t.categoria='Novela'
--                 ∧ ∃d (DETALLE_PRESTAMO(d) ∧ d.id_libro=t.id_libro)}
-- CRD         : {<titulo> | ∃id_l, id_p, cat
--                 (LIBRO(id_l,titulo,cat) ∧ cat='Novela'
--                  ∧ DETALLE_PRESTAMO(id_p,id_l))}
-- ----------------------------------------------------
SELECT titulo FROM LIBRO WHERE categoria = 'Novela'
INTERSECT
SELECT l.titulo
FROM   LIBRO l
JOIN   DETALLE_PRESTAMO dp ON l.id_libro = dp.id_libro
ORDER  BY titulo;


-- ----------------------------------------------------
-- CONSULTA 4: Diferencia (−)
-- Descripción : Obtener los títulos de libros que NUNCA han sido prestados.
-- AR          : π_titulo(LIBRO) − π_titulo(LIBRO ⋈ DETALLE_PRESTAMO)
-- CRT         : {t.titulo | LIBRO(t)
--                 ∧ ¬∃d (DETALLE_PRESTAMO(d) ∧ d.id_libro=t.id_libro)}
-- CRD         : {<titulo> | ∃id_l
--                 (LIBRO(id_l,titulo)
--                  ∧ ¬∃id_p (DETALLE_PRESTAMO(id_p,id_l)))}
-- ----------------------------------------------------
SELECT titulo FROM LIBRO
EXCEPT
SELECT l.titulo
FROM   LIBRO l
JOIN   DETALLE_PRESTAMO dp ON l.id_libro = dp.id_libro
ORDER  BY titulo;


-- ----------------------------------------------------
-- CONSULTA 5: Producto Cartesiano (×)
-- Descripción : Obtener pares de libros distintos que pertenecen a la
--               misma categoría (usando producto cartesiano + selección).
-- AR          : π_L1.titulo, L1.categoria, L2.titulo (
--                 σ_L1.categoria=L2.categoria ∧ L1.id_libro<L2.id_libro (
--                   ρ_L1(LIBRO) × ρ_L2(LIBRO) ) )
-- CRT         : {l1.titulo, l1.categoria, l2.titulo | LIBRO(l1) ∧ LIBRO(l2)
--                 ∧ l1.categoria=l2.categoria ∧ l1.id_libro<l2.id_libro}
-- CRD         : {<t1, cat, t2> | ∃id1,id2,…
--                 (LIBRO(id1,t1,…,cat,…) ∧ LIBRO(id2,t2,…,cat,…) ∧ id1<id2)}
-- Nota        : El producto cartesiano genera n×n filas; la condición reduce
--               el resultado a C(n,2) pares por categoría.
-- ----------------------------------------------------
SELECT l1.titulo    AS libro_1,
       l1.categoria AS categoria,
       l2.titulo    AS libro_2
FROM   LIBRO l1,
       LIBRO l2
WHERE  l1.categoria  = l2.categoria
  AND  l1.id_libro   < l2.id_libro
ORDER  BY l1.categoria, l1.titulo;


-- =====================================================
-- SECCIÓN 2: REUNIONES (JOIN) — Consultas 6–10
-- =====================================================

-- ----------------------------------------------------
-- CONSULTA 6: Reunión Natural (⋈)
-- Descripción : Obtener el título de cada libro con el nombre de su(s) autor(es).
-- AR          : π_titulo, nombre (LIBRO ⋈ LIBRO_AUTOR ⋈ AUTOR)
-- CRT         : {t.titulo, a.nombre | LIBRO(t) ∧ AUTOR(a)
--                 ∧ ∃la (LIBRO_AUTOR(la) ∧ la.id_libro=t.id_libro
--                        ∧ la.id_autor=a.id_autor)}
-- CRD         : {<titulo, nombre> | ∃id_l, id_a
--                 (LIBRO(id_l,titulo) ∧ AUTOR(id_a,nombre)
--                  ∧ LIBRO_AUTOR(id_l,id_a))}
-- ----------------------------------------------------
SELECT l.titulo,
       a.nombre AS autor
FROM   LIBRO        l
JOIN   LIBRO_AUTOR  la ON l.id_libro  = la.id_libro
JOIN   AUTOR        a  ON la.id_autor = a.id_autor
ORDER  BY l.titulo, a.nombre;


-- ----------------------------------------------------
-- CONSULTA 7: Theta-Join / Equi-Join (⋈_θ)
-- Descripción : Obtener nombre del usuario, título del libro y fecha de
--               préstamo para todos los préstamos en estado 'activo'.
-- AR          : π_nombre, titulo, fecha_prestamo (
--                 σ_estado='activo'(PRESTAMO)
--                 ⋈_id_usuario  USUARIO
--                 ⋈_id_prestamo DETALLE_PRESTAMO
--                 ⋈_id_libro    LIBRO )
-- CRT         : {u.nombre, l.titulo, p.fecha_prestamo |
--                 USUARIO(u) ∧ PRESTAMO(p) ∧ DETALLE_PRESTAMO(d) ∧ LIBRO(l)
--                 ∧ p.estado='activo' ∧ p.id_usuario=u.id_usuario
--                 ∧ d.id_prestamo=p.id_prestamo ∧ d.id_libro=l.id_libro}
-- CRD         : {<nombre,titulo,fecha> | ∃id_u,id_p,id_l,estado
--                 (USUARIO(id_u,nombre) ∧ PRESTAMO(id_p,id_u,fecha,estado)
--                  ∧ estado='activo' ∧ DETALLE_PRESTAMO(id_p,id_l)
--                  ∧ LIBRO(id_l,titulo))}
-- ----------------------------------------------------
SELECT u.nombre,
       l.titulo,
       p.fecha_prestamo
FROM   PRESTAMO         p
JOIN   USUARIO          u  ON p.id_usuario  = u.id_usuario
JOIN   DETALLE_PRESTAMO dp ON p.id_prestamo = dp.id_prestamo
JOIN   LIBRO            l  ON dp.id_libro   = l.id_libro
WHERE  p.estado = 'activo'
ORDER  BY p.fecha_prestamo;


-- ----------------------------------------------------
-- CONSULTA 8: Left Outer Join (⟕)
-- Descripción : Listar TODOS los usuarios con el conteo total de préstamos
--               realizados; los usuarios sin préstamos aparecen con 0.
-- AR          : G_nombre F_COUNT(id_prestamo) (USUARIO ⟕ PRESTAMO)
-- CRT         : {u.nombre, COUNT(p.id_prestamo) | USUARIO(u)
--                 ∧ (∃p (PRESTAMO(p) ∧ p.id_usuario=u.id_usuario)
--                    ∨ ¬∃p (PRESTAMO(p) ∧ p.id_usuario=u.id_usuario))}
-- CRD         : {<nombre,conteo> | ∃id_u
--                 (USUARIO(id_u,nombre)
--                  ∧ conteo=COUNT({id_p | PRESTAMO(id_p,id_u)}))}
-- ----------------------------------------------------
SELECT u.nombre,
       COUNT(p.id_prestamo) AS total_prestamos
FROM   USUARIO  u
LEFT JOIN PRESTAMO p ON u.id_usuario = p.id_usuario
GROUP  BY u.id_usuario, u.nombre
ORDER  BY total_prestamos DESC, u.nombre;


-- ----------------------------------------------------
-- CONSULTA 9: Semi-Join (⋉)
-- Descripción : Obtener los nombres de usuarios que tienen al menos
--               un préstamo en estado 'activo'.
-- AR          : π_nombre (USUARIO ⋉ σ_estado='activo'(PRESTAMO))
-- CRT         : {u.nombre | USUARIO(u)
--                 ∧ ∃p (PRESTAMO(p) ∧ p.id_usuario=u.id_usuario
--                        ∧ p.estado='activo')}
-- CRD         : {<nombre> | ∃id_u,id_p,estado
--                 (USUARIO(id_u,nombre) ∧ PRESTAMO(id_p,id_u,estado)
--                  ∧ estado='activo')}
-- ----------------------------------------------------
SELECT DISTINCT u.nombre
FROM   USUARIO u
WHERE  EXISTS (
    SELECT 1
    FROM   PRESTAMO p
    WHERE  p.id_usuario = u.id_usuario
      AND  p.estado     = 'activo'
)
ORDER  BY u.nombre;


-- ----------------------------------------------------
-- CONSULTA 10: Self-Join (Auto-Reunión)
-- Descripción : Encontrar pares de libros de la misma categoría donde
--               el primero tiene más páginas que el segundo.
-- AR          : π_L1.titulo, L1.num_paginas, L2.titulo, L2.num_paginas (
--                 σ_L1.categoria=L2.categoria ∧ L1.num_paginas>L2.num_paginas (
--                   ρ_L1(LIBRO) × ρ_L2(LIBRO) ) )
-- CRT         : {l1.titulo, l1.num_paginas, l2.titulo, l2.num_paginas |
--                 LIBRO(l1) ∧ LIBRO(l2) ∧ l1.categoria=l2.categoria
--                 ∧ l1.num_paginas>l2.num_paginas ∧ l1.id_libro≠l2.id_libro}
-- CRD         : {<t1,p1,t2,p2> | ∃id1,id2,cat,…
--                 (LIBRO(id1,t1,…,cat,p1,…) ∧ LIBRO(id2,t2,…,cat,p2,…)
--                  ∧ p1>p2 ∧ id1≠id2)}
-- ----------------------------------------------------
SELECT l1.titulo         AS libro_mayor,
       l1.num_paginas    AS paginas_mayor,
       l2.titulo         AS libro_menor,
       l2.num_paginas    AS paginas_menor,
       l1.categoria
FROM   LIBRO l1,
       LIBRO l2
WHERE  l1.categoria  = l2.categoria
  AND  l1.num_paginas > l2.num_paginas
  AND  l1.id_libro   <> l2.id_libro
ORDER  BY l1.categoria, l1.num_paginas DESC;


-- =====================================================
-- SECCIÓN 3: AGRUPACIÓN Y AGREGACIÓN — Consultas 11–15
-- Funciones: COUNT, SUM, AVG, MAX, MIN  |  Operador: G (GROUP BY)
-- =====================================================

-- ----------------------------------------------------
-- CONSULTA 11: COUNT — Préstamos por usuario
-- Descripción : Contar cuántos préstamos ha realizado cada usuario.
-- AR          : G_id_usuario,nombre F_COUNT(id_prestamo) (USUARIO ⋈ PRESTAMO)
-- CRT         : {u.nombre, COUNT(p.id_prestamo) | USUARIO(u) ∧ PRESTAMO(p)
--                 ∧ p.id_usuario=u.id_usuario}
-- CRD         : {<nombre,total> | ∃id_u
--                 (USUARIO(id_u,nombre)
--                  ∧ total=COUNT({id_p | PRESTAMO(id_p,id_u)}))}
-- ----------------------------------------------------
SELECT u.nombre,
       COUNT(p.id_prestamo) AS total_prestamos
FROM   USUARIO  u
JOIN   PRESTAMO p ON u.id_usuario = p.id_usuario
GROUP  BY u.id_usuario, u.nombre
ORDER  BY total_prestamos DESC, u.nombre;


-- ----------------------------------------------------
-- CONSULTA 12: SUM — Total de días de préstamo por usuario
-- Descripción : Calcular la suma de días (fecha_devolucion_prevista −
--               fecha_prestamo) de todos los préstamos por usuario.
-- AR          : G_id_usuario,nombre
--               F_SUM(fecha_devolucion_prevista − fecha_prestamo)
--               (USUARIO ⋈ PRESTAMO)
-- CRT         : {u.nombre, SUM(p.fdp − p.fp) | USUARIO(u) ∧ PRESTAMO(p)
--                 ∧ p.id_usuario=u.id_usuario}
-- CRD         : {<nombre,total_dias> | ∃id_u
--                 (USUARIO(id_u,nombre)
--                  ∧ total_dias=SUM({fdp−fp | PRESTAMO(id_p,id_u,fp,fdp)}))}
-- ----------------------------------------------------
SELECT u.nombre,
       SUM(p.fecha_devolucion_prevista - p.fecha_prestamo) AS total_dias_prestamo
FROM   USUARIO  u
JOIN   PRESTAMO p ON u.id_usuario = p.id_usuario
GROUP  BY u.id_usuario, u.nombre
ORDER  BY total_dias_prestamo DESC, u.nombre;


-- ----------------------------------------------------
-- CONSULTA 13: AVG — Promedio de páginas por categoría
-- Descripción : Calcular el promedio de páginas de los libros agrupados
--               por categoría.
-- AR          : G_categoria F_AVG(num_paginas) (LIBRO)
-- CRT         : {l.categoria, AVG(l.num_paginas) | LIBRO(l)}
-- CRD         : {<categoria,promedio> |
--                 promedio=AVG({np | ∃id,t,isbn,ed,np,anio,ej,d
--                   (LIBRO(id,t,isbn,ed,categoria,np,anio,ej,d))})}
-- ----------------------------------------------------
SELECT categoria,
       ROUND(AVG(num_paginas), 2) AS promedio_paginas,
       COUNT(*)                   AS total_libros
FROM   LIBRO
GROUP  BY categoria
ORDER  BY promedio_paginas DESC;


-- ----------------------------------------------------
-- CONSULTA 14: MAX / MIN — Libro más largo y más corto por categoría
-- Descripción : Obtener el máximo y mínimo de páginas por categoría,
--               junto con la diferencia entre ambos.
-- AR          : G_categoria F_MAX(num_paginas), F_MIN(num_paginas) (LIBRO)
-- CRT         : {l.categoria, MAX(l.num_paginas), MIN(l.num_paginas) | LIBRO(l)}
-- CRD         : {<categoria,max_p,min_p> |
--                 max_p=MAX({np|…}) ∧ min_p=MIN({np|…})}
-- ----------------------------------------------------
SELECT categoria,
       MAX(num_paginas)                      AS max_paginas,
       MIN(num_paginas)                      AS min_paginas,
       MAX(num_paginas) - MIN(num_paginas)   AS diferencia
FROM   LIBRO
GROUP  BY categoria
ORDER  BY diferencia DESC;


-- ----------------------------------------------------
-- CONSULTA 15: HAVING — Categorías con más de 2 libros
-- Descripción : Obtener las categorías que tienen más de 2 libros,
--               mostrando estadísticas de páginas.
-- AR          : σ_count>2 (G_categoria F_COUNT(id_libro), F_AVG(num_paginas),
--                           F_MIN(num_paginas), F_MAX(num_paginas) (LIBRO))
-- CRT         : {l.categoria, COUNT(l.id_libro), AVG(l.num_paginas) | LIBRO(l)
--                 GROUP BY l.categoria HAVING COUNT(l.id_libro)>2}
-- CRD         : {<categoria,total,prom,min_p,max_p> |
--                 total=COUNT({id|…}) ∧ total>2 ∧ prom=AVG({np|…})
--                 ∧ min_p=MIN({np|…}) ∧ max_p=MAX({np|…})}
-- ----------------------------------------------------
SELECT categoria,
       COUNT(*)                   AS total_libros,
       ROUND(AVG(num_paginas),2)  AS promedio_paginas,
       MIN(num_paginas)           AS min_paginas,
       MAX(num_paginas)           AS max_paginas
FROM   LIBRO
GROUP  BY categoria
HAVING COUNT(*) > 2
ORDER  BY total_libros DESC;


-- =====================================================
-- SECCIÓN 4: DIVISIÓN (÷) — Consultas 16–18
-- Expresión equivalente: R÷S = π_X(R) − π_X((π_X(R)×S) − R)
-- Implementada en SQL con doble NOT EXISTS
-- =====================================================

-- ----------------------------------------------------
-- CONSULTA 16: División — Usuarios que han prestado
--              TODOS los libros de la categoría 'Fantasía'
-- Descripción : Devuelve los usuarios u tales que para todo libro l
--               de Fantasía existe un préstamo de u que incluye l.
-- AR          : π_id_usuario(PRESTAMO ⋈ DETALLE_PRESTAMO
--                 ⋈ σ_categoria='Fantasía'(LIBRO))
--               ÷ π_id_libro(σ_categoria='Fantasía'(LIBRO))
-- CRT         : {u.nombre | USUARIO(u)
--                 ∧ ∀l (LIBRO(l) ∧ l.categoria='Fantasía'
--                   → ∃p,d (PRESTAMO(p) ∧ p.id_usuario=u.id_usuario
--                           ∧ DETALLE_PRESTAMO(d)
--                           ∧ d.id_prestamo=p.id_prestamo
--                           ∧ d.id_libro=l.id_libro))}
-- CRD         : {<nombre> | ∃id_u (USUARIO(id_u,nombre)
--                 ∧ ∀id_l,titulo,cat (LIBRO(id_l,titulo,cat) ∧ cat='Fantasía'
--                   → ∃id_p,fecha,estado
--                     (PRESTAMO(id_p,id_u,fecha,estado)
--                      ∧ DETALLE_PRESTAMO(id_p,id_l))))}
-- ----------------------------------------------------
SELECT u.nombre
FROM   USUARIO u
WHERE  NOT EXISTS (
    -- Existe algún libro de Fantasía que este usuario NO ha prestado
    SELECT 1
    FROM   LIBRO l
    WHERE  l.categoria = 'Fantasía'
      AND  NOT EXISTS (
          SELECT 1
          FROM   PRESTAMO         p
          JOIN   DETALLE_PRESTAMO dp ON p.id_prestamo = dp.id_prestamo
          WHERE  p.id_usuario = u.id_usuario
            AND  dp.id_libro  = l.id_libro
      )
)
ORDER  BY u.nombre;


-- ----------------------------------------------------
-- CONSULTA 17: División — Usuarios que han prestado TODOS
--              los libros de Gabriel García Márquez (id_autor = 1)
-- Descripción : Devuelve usuarios que han prestado cada uno de los libros
--               asociados al autor con id_autor = 1.
-- AR          : π_id_usuario(PRESTAMO ⋈ DETALLE_PRESTAMO
--                 ⋈ (LIBRO ⋈ σ_id_autor=1(LIBRO_AUTOR)))
--               ÷ π_id_libro(σ_id_autor=1(LIBRO_AUTOR))
-- CRT         : {u.nombre | USUARIO(u)
--                 ∧ ∀la (LIBRO_AUTOR(la) ∧ la.id_autor=1
--                   → ∃l,p,d (LIBRO(l) ∧ l.id_libro=la.id_libro
--                             ∧ PRESTAMO(p) ∧ p.id_usuario=u.id_usuario
--                             ∧ DETALLE_PRESTAMO(d)
--                             ∧ d.id_prestamo=p.id_prestamo
--                             ∧ d.id_libro=l.id_libro))}
-- CRD         : {<nombre> | ∃id_u (USUARIO(id_u,nombre)
--                 ∧ ∀id_l,id_a (LIBRO_AUTOR(id_l,id_a) ∧ id_a=1
--                   → ∃id_p,fecha,estado
--                     (PRESTAMO(id_p,id_u,fecha,estado)
--                      ∧ DETALLE_PRESTAMO(id_p,id_l))))}
-- ----------------------------------------------------
SELECT u.nombre
FROM   USUARIO u
WHERE  NOT EXISTS (
    -- Existe algún libro de García Márquez que este usuario NO ha prestado
    SELECT 1
    FROM   LIBRO_AUTOR la
    WHERE  la.id_autor = 1
      AND  NOT EXISTS (
          SELECT 1
          FROM   PRESTAMO         p
          JOIN   DETALLE_PRESTAMO dp ON p.id_prestamo = dp.id_prestamo
          WHERE  p.id_usuario = u.id_usuario
            AND  dp.id_libro  = la.id_libro
      )
)
ORDER  BY u.nombre;


-- ----------------------------------------------------
-- CONSULTA 18: División — Libros prestados por TODOS los estudiantes
-- Descripción : Devuelve títulos de libros que han sido prestados por
--               cada uno de los usuarios de tipo 'estudiante'.
-- AR          : π_id_libro(DETALLE_PRESTAMO ⋈ PRESTAMO
--                 ⋈ σ_tipo='estudiante'(USUARIO))
--               ÷ π_id_usuario(σ_tipo='estudiante'(USUARIO))
-- CRT         : {l.titulo | LIBRO(l)
--                 ∧ ∀u (USUARIO(u) ∧ u.tipo='estudiante'
--                   → ∃p,d (PRESTAMO(p) ∧ p.id_usuario=u.id_usuario
--                           ∧ DETALLE_PRESTAMO(d)
--                           ∧ d.id_prestamo=p.id_prestamo
--                           ∧ d.id_libro=l.id_libro))}
-- CRD         : {<titulo> | ∃id_l (LIBRO(id_l,titulo)
--                 ∧ ∀id_u,tipo (USUARIO(id_u,tipo) ∧ tipo='estudiante'
--                   → ∃id_p,fecha,estado
--                     (PRESTAMO(id_p,id_u,fecha,estado)
--                      ∧ DETALLE_PRESTAMO(id_p,id_l))))}
-- ----------------------------------------------------
SELECT l.titulo
FROM   LIBRO l
WHERE  NOT EXISTS (
    -- Existe algún estudiante que NO ha prestado este libro
    SELECT 1
    FROM   USUARIO u
    WHERE  u.tipo = 'estudiante'
      AND  NOT EXISTS (
          SELECT 1
          FROM   PRESTAMO         p
          JOIN   DETALLE_PRESTAMO dp ON p.id_prestamo = dp.id_prestamo
          WHERE  p.id_usuario = u.id_usuario
            AND  dp.id_libro  = l.id_libro
      )
)
ORDER  BY l.titulo;


-- =====================================================
-- SECCIÓN 5: CUANTIFICADORES UNIVERSALES (∀) — Consultas 19–20
-- =====================================================

-- ----------------------------------------------------
-- CONSULTA 19: Cuantificador Universal (∀)
--              Usuarios que SOLO han prestado libros de Fantasía
-- Descripción : Devuelve usuarios que tienen al menos un préstamo y en
--               todos sus préstamos los libros son de categoría 'Fantasía'.
-- AR          : π_nombre(USUARIO ⋈ PRESTAMO)
--               − π_nombre(USUARIO ⋈ PRESTAMO ⋈ DETALLE_PRESTAMO
--                           ⋈ σ_categoria≠'Fantasía'(LIBRO))
-- CRT         : {u.nombre | USUARIO(u)
--                 ∧ ∃p (PRESTAMO(p) ∧ p.id_usuario=u.id_usuario)
--                 ∧ ∀p (PRESTAMO(p) ∧ p.id_usuario=u.id_usuario
--                   → ∀d (DETALLE_PRESTAMO(d) ∧ d.id_prestamo=p.id_prestamo
--                     → ∃l (LIBRO(l) ∧ l.id_libro=d.id_libro
--                            ∧ l.categoria='Fantasía')))}
-- CRD         : {<nombre> | ∃id_u (USUARIO(id_u,nombre)
--                 ∧ ∃id_p (PRESTAMO(id_p,id_u))
--                 ∧ ∀id_p2,id_l,cat
--                   (PRESTAMO(id_p2,id_u) ∧ DETALLE_PRESTAMO(id_p2,id_l)
--                    ∧ LIBRO(id_l,cat) → cat='Fantasía'))}
-- ----------------------------------------------------
SELECT DISTINCT u.nombre
FROM   USUARIO u
WHERE  EXISTS (
    -- El usuario tiene al menos un préstamo
    SELECT 1 FROM PRESTAMO p WHERE p.id_usuario = u.id_usuario
)
AND NOT EXISTS (
    -- No existe ningún préstamo suyo que incluya un libro que NO sea Fantasía
    SELECT 1
    FROM   PRESTAMO         p
    JOIN   DETALLE_PRESTAMO dp ON p.id_prestamo = dp.id_prestamo
    JOIN   LIBRO            l  ON dp.id_libro   = l.id_libro
    WHERE  p.id_usuario  = u.id_usuario
      AND  l.categoria  <> 'Fantasía'
)
ORDER  BY u.nombre;


-- ----------------------------------------------------
-- CONSULTA 20: Cuantificador Universal (∀) + División
--              Libros prestados por usuarios de TODOS los tipos
-- Descripción : Devuelve títulos de libros que han sido prestados por
--               al menos un usuario de cada tipo existente
--               ('estudiante', 'profesor', 'externo').
-- AR          : π_id_libro(DETALLE_PRESTAMO ⋈ PRESTAMO ⋈ USUARIO)
--               ÷ π_tipo(USUARIO)
-- CRT         : {l.titulo | LIBRO(l)
--                 ∧ ∀t (∃u (USUARIO(u) ∧ u.tipo=t)
--                   → ∃u2,p,d (USUARIO(u2) ∧ u2.tipo=t
--                              ∧ PRESTAMO(p) ∧ p.id_usuario=u2.id_usuario
--                              ∧ DETALLE_PRESTAMO(d)
--                              ∧ d.id_prestamo=p.id_prestamo
--                              ∧ d.id_libro=l.id_libro))}
-- CRD         : {<titulo> | ∃id_l (LIBRO(id_l,titulo)
--                 ∧ ∀tipo_t (∃id_u (USUARIO(id_u,tipo_t))
--                   → ∃id_p,id_u2,fecha,estado
--                     (USUARIO(id_u2,tipo_t)
--                      ∧ PRESTAMO(id_p,id_u2,fecha,estado)
--                      ∧ DETALLE_PRESTAMO(id_p,id_l))))}
-- ----------------------------------------------------
SELECT l.titulo
FROM   LIBRO l
WHERE  NOT EXISTS (
    -- Existe algún tipo de usuario tal que NINGÚN usuario de ese tipo
    -- ha prestado este libro
    SELECT DISTINCT u.tipo
    FROM   USUARIO u
    WHERE  NOT EXISTS (
        SELECT 1
        FROM   PRESTAMO         p
        JOIN   DETALLE_PRESTAMO dp ON p.id_prestamo = dp.id_prestamo
        JOIN   USUARIO          u2 ON p.id_usuario  = u2.id_usuario
        WHERE  u2.tipo      = u.tipo
          AND  dp.id_libro  = l.id_libro
    )
)
ORDER  BY l.titulo;


-- =====================================================
-- FIN DEL ARCHIVO 03_queries.sql
-- =====================================================
