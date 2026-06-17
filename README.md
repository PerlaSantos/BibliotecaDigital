#  BibliotecaDigital — Base de Datos Relacional

> Práctica de Álgebra Relacional, Cálculo Relacional y Operadores Avanzados  
> **Unidad de Aprendizaje:** Bases de Datos | **Grupo:** 3CV2  
> **Instituto Politécnico Nacional — Escuela Superior de Cómputo (ESCOM)**

---

##  Integrantes del equipo


 Alarcon Herrera Julio Alexis 

 Cedillo Baeza Martha Clara 

 Santos Martínez Perla 


**Profesor:** Gabriel Hurtado Avilés  
**Fecha de entrega:** 16/06/2026

---

##  Descripción del dominio

El sistema modela una **Biblioteca Digital** que gestiona el préstamo de libros físicos.  
Permite registrar autores, libros, usuarios (estudiantes, profesores y externos) y el ciclo
completo de préstamos, incluyendo devoluciones individuales por libro dentro de un mismo préstamo.

**Entidades principales:**
- `AUTOR` — Catálogo de autores con datos biográficos
- `LIBRO` — Acervo bibliográfico con control de ejemplares
- `LIBRO_AUTOR` — Relación N:M entre libros y autores
- `USUARIO` — Lectores registrados con tres tipos de membresía
- `PRESTAMO` — Registro de cada solicitud de préstamo
- `DETALLE_PRESTAMO` — Permite múltiples libros por préstamo con fechas individuales

---

| Diagrama Entidad-Relación Extendido (EER) |
|:---:|
| <img src="https://github.com/PerlaSantos/BibliotecaDigital/blob/24b1af16882dcf6766064bf75e0272ea6752af3b/docs/eer_biblioteca_digital.png" alt="Diagrama Entidad-Relación Extendido" width="800"/> |

### Transformación al Modelo Relacional

Una vez validado el diagrama EER, procedimos a su transformación al modelo relacional, obteniendo un esquema de 15 tablas que normalizan la información y evitan redundancias. Se definieron claves primarias y foráneas, junto con restricciones de integridad (CHECK, NOT NULL, UNIQUE, DEFAULT) para garantizar la calidad de los datos. La siguiente imagen presenta el esquema relacional resultante.

| Modelo Relacional |
|:---:|
| <img src="https://github.com/PerlaSantos/BibliotecaDigital/blob/24b1af16882dcf6766064bf75e0272ea6752af3b/docs/modelo_relacional_biblioteca.png" alt="Modelo Relacional" width="800"/> |


**Notación usada:**
- `PK` — Clave primaria
- `FK` — Clave foránea (con tabla referenciada)
- `⟨UNIQUE⟩` — Restricción de unicidad
- `⟨CHECK⟩` — Restricción de dominio
- `⟨DEF⟩` — Valor por defecto
- `ON DELETE CASCADE` — Borrado en cascada

---

##  Instrucciones de instalación y ejecución

### Requisitos

- Cuenta en [Supabase](https://supabase.com) (gratuita) **o** PostgreSQL 14+ instalado localmente
- Cliente SQL (pgAdmin, DBeaver, o el SQL Editor de Supabase)

### Opción A — Supabase (recomendado)

```bash
# 1. Crea un proyecto nuevo en https://app.supabase.com
# 2. Ve a: Database > SQL Editor
# 3. Ejecuta los scripts en orden:
```

1. Abre el **SQL Editor** de tu proyecto Supabase
2. Ejecuta `sql/01_ddl.sql` — crea todas las tablas y restricciones
3. Ejecuta `sql/02_inserts.sql` — inserta los datos de ejemplo (10+ registros por tabla)
4. Ejecuta cualquier consulta de `sql/03_consultas.sql` para verificar

### Opción B — PostgreSQL local

```bash
# Crear la base de datos
psql -U postgres -c 'CREATE DATABASE "BibliotecaDigital";'

# Ejecutar DDL e inserts
psql -U postgres -d BibliotecaDigital -f sql/01_ddl.sql
psql -U postgres -d BibliotecaDigital -f sql/02_inserts.sql

# Verificar
psql -U postgres -d BibliotecaDigital -c "SELECT COUNT(*) FROM LIBRO;"
```

### Estructura del repositorio

```
BibliotecaDigital/
├── README.md
├── docs/
│   ├── eer_extendido.png        ← Diagrama EER
│   └── modelo_relacional.png    ← Modelo relacional
└── sql/
    ├── 01_ddl.sql               ← CREATE TABLE, restricciones
    ├── 02_inserts.sql           ← Datos de ejemplo
    └── 03_consultas.sql         ← Las 20 consultas del caso integrador
```

---

##  Parte 1: Operadores Básicos del Álgebra Relacional

### Ejercicio 1.2 — Operador de Selección (σ)

> **Definición:** `σ_condición(R)` — Selecciona las tuplas de R que satisfacen la condición.


|
 1 
|
 Igualdad 
|
`σ_id_libro=8(LIBRO)`
|
`SELECT * FROM libro WHERE id_libro=8`
|
|
 2 
|
 Desigualdad 
|
`σ_id_libro≠8(LIBRO)`
|
`SELECT * FROM libro WHERE id_libro!=8`
|
|
 3 
|
 Comparación 
|
`σ_id_libro>5(LIBRO)`
|
`SELECT * FROM libro WHERE id_libro>5`
|
|
 4 
|
 AND (∧) 
|
`σ_editorial='Penguin' ∧ num_paginas>400(LIBRO)`
|
`SELECT * FROM libro WHERE editorial='Penguin' AND num_paginas>400`
|
|
 5 
|
 OR (∨) 
|
`σ_editorial='Penguin' ∨ editorial='Salamandra'(LIBRO)`
|
`SELECT * FROM libro WHERE editorial='Penguin' OR editorial='Salamandra'`
|
|
 6 
|
 NOT (¬) 
|
`σ_¬nacionalidad='Estadounidense'(AUTOR)`
|
`SELECT * FROM autor WHERE NOT nacionalidad='Estadounidense'`
|
|
 7 
|
 Compuesta con paréntesis 
|
`σ_(nacionalidad='Britanica' ∧ fecha_nacimiento>'1950-01-01') ∨ obra_destacada='El resplandor'(AUTOR)`
|
`SELECT * FROM autor WHERE (nacionalidad='Britanica' AND fecha_nacimiento>'1950-01-01') OR obra_destacada='El resplandor'`
|
|
 8 
|
 LIKE / patrón 
|
`σ_email LIKE '%maria%'(USUARIO)`
|
`SELECT * FROM usuario WHERE email LIKE '%maria%'`
|
|
 9 
|
 NULL 
|
`σ_fecha_devolucion_individual IS NULL(DETALLE_PRESTAMO)`
|
`SELECT * FROM detalle_prestamo WHERE fecha_devolucion_individual IS NULL`
|
|
 10 
|
 Rango (BETWEEN) 
|
`σ_num_paginas<401 ∧ num_paginas>199(LIBRO)`
|
`SELECT * FROM libro WHERE num_paginas BETWEEN 200 AND 400`
|

---

### Ejercicio 1.3 — Operador de Proyección (π)

> **Definición:** `π_atributos(R)` — Extrae columnas específicas, eliminando duplicados.


|
 1 
|
 Un atributo 
|
`π_obra_destacada(AUTOR)`
|
`SELECT obra_destacada FROM autor`
|
|
 2 
|
 Múltiples atributos 
|
`π_nombre,obra_destacada(AUTOR)`
|
`SELECT nombre, obra_destacada FROM autor`
|
|
 3 
|
 Renombramiento 
|
`π_obra_destacada→mejor_libro(AUTOR)`
|
`SELECT obra_destacada AS mejor_libro FROM autor`
|
|
 4 
|
 Elimina duplicados 
|
`π_editorial(LIBRO)`
|
`SELECT DISTINCT editorial FROM libro`
|
|
 5 
|
 Atributo calculado 
|
`π_nombre,autor(AUTOR)`
|
`SELECT CONCAT(nombre,' ', autor) AS identificador FROM autor`
|
|
 6 
|
 Clave primaria 
|
`π_id_libro,titulo(LIBRO)`
|
`SELECT id_libro, titulo FROM libro`
|
|
 7 
|
 Todos excepto algunos 
|
`π_titulo,editorial,categoria,num_paginas,ejemplares_total(LIBRO)`
|
`SELECT titulo,editorial,categoria,num_paginas,ejemplares_total FROM libro`
|
|
 8 
|
 π(σ(R)) 
|
`π_id_autor,nacionalidad(σ_nacionalidad='Británica'(AUTOR))`
|
`SELECT id_autor, nacionalidad FROM autor WHERE nacionalidad='Británica'`
|
|
 9 
|
 Diferentes tipos de datos 
|
`π_id_prestamo,fecha_devolucion_prevista,fecha_devolucion_real,estado(PRESTAMO)`
|
`SELECT id_prestamo, fecha_devolucion_prevista, fecha_devolucion_real, estado FROM prestamo`
|
|
 10 
|
 Relación vacía 
|
`π_id_libro,num_paginas(σ_num_paginas>1000000000(LIBRO))`
|
`SELECT id_libro, num_paginas FROM libro WHERE num_paginas>1000000000`
|

---

### Ejercicio 1.4 — Operadores de Teoría de Conjuntos

#### Unión (∪)

```
1. π_nombre(USUARIO) ∪ π_nombre(AUTOR)
   SQL: SELECT nombre FROM USUARIO UNION SELECT nombre FROM AUTOR;

2. π_nombre(σ_tipo='estudiante'(USUARIO)) ∪ π_nombre(σ_tipo='profesor'(USUARIO))
   SQL: SELECT nombre FROM USUARIO WHERE tipo='estudiante'
        UNION SELECT nombre FROM USUARIO WHERE tipo='profesor';

3. π_titulo(σ_categoria='Fantasía'(LIBRO)) ∪ π_titulo(σ_categoria='Novela'(LIBRO))
   SQL: SELECT titulo FROM LIBRO WHERE categoria='Fantasía'
        UNION SELECT titulo FROM LIBRO WHERE categoria='Novela';

4. π_nombre(USUARIO) ∪ π_nombre(σ_num_paginas>10000(LIBRO))   ← incluye relación vacía
   SQL: SELECT nombre FROM USUARIO
        UNION SELECT titulo FROM LIBRO WHERE num_paginas>10000;
```

#### Intersección (∩)

```
1. π_nombre(USUARIO) ∩ π_nombre(AUTOR)
   SQL: SELECT nombre FROM USUARIO INTERSECT SELECT nombre FROM AUTOR;

2. π_titulo(σ_categoria='Fantasía'(LIBRO)) ∩ π_titulo(σ_editorial='Salamandra'(LIBRO))
   SQL: SELECT titulo FROM LIBRO WHERE categoria='Fantasía'
        INTERSECT SELECT titulo FROM LIBRO WHERE editorial='Salamandra';

3. π_nombre(σ_tipo='externo'(USUARIO)) ∩ π_nombre(σ_tipo='profesor'(USUARIO))   ← vacío
   SQL: SELECT nombre FROM USUARIO WHERE tipo='externo'
        INTERSECT SELECT nombre FROM USUARIO WHERE tipo='profesor';

4. π_editorial(σ_categoria='Fantasía'(LIBRO)) ∩ π_editorial(σ_categoria='Novela'(LIBRO))
   SQL: SELECT editorial FROM LIBRO WHERE categoria='Fantasía'
        INTERSECT SELECT editorial FROM LIBRO WHERE categoria='Novela';
```

#### Diferencia (−)

```
1. π_nombre(AUTOR) − π_nombre(USUARIO)
   SQL: SELECT nombre FROM AUTOR EXCEPT SELECT nombre FROM USUARIO;

2. π_id_libro(LIBRO) − π_id_libro(DETALLE_PRESTAMO)   ← libros nunca prestados
   SQL: SELECT id_libro FROM LIBRO EXCEPT SELECT id_libro FROM DETALLE_PRESTAMO;

3. π_nombre(USUARIO) − π_nombre(σ_tipo='estudiante'(USUARIO))
   SQL: SELECT nombre FROM USUARIO
        EXCEPT SELECT nombre FROM USUARIO WHERE tipo='estudiante';

4. π_editorial(LIBRO) − π_editorial(σ_categoria='Fantasía'(LIBRO))
   SQL: SELECT editorial FROM LIBRO
        EXCEPT SELECT editorial FROM LIBRO WHERE categoria='Fantasía';
```

---

### Ejercicio 1.5 — Producto Cartesiano (×)

```
1. AUTOR × USUARIO
   SQL: SELECT * FROM AUTOR CROSS JOIN USUARIO;
   Cardinalidad: 10 × 10 = 100 tuplas

2. LIBRO × USUARIO (seguido de selección — simula JOIN)
   σ_LIBRO.id_libro=DETALLE_PRESTAMO.id_libro(LIBRO × DETALLE_PRESTAMO)
   SQL: SELECT * FROM LIBRO, DETALLE_PRESTAMO WHERE LIBRO.id_libro = DETALLE_PRESTAMO.id_libro;

3. AUTOR × LIBRO × LIBRO_AUTOR
   SQL: SELECT * FROM AUTOR CROSS JOIN LIBRO CROSS JOIN LIBRO_AUTOR;
   Cardinalidad: 10 × 10 × 10 = 1 000 tuplas

4. π_titulo,nombre(σ_LIBRO.id_libro=LA.id_libro ∧ AUTOR.id_autor=LA.id_autor(LIBRO × LIBRO_AUTOR LA × AUTOR))
   SQL: SELECT l.titulo, a.nombre FROM LIBRO l, LIBRO_AUTOR la, AUTOR a
        WHERE l.id_libro=la.id_libro AND la.id_autor=a.id_autor;

5. ρ(L1,LIBRO) × ρ(L2,LIBRO) con σ_L1.id_libro≠L2.id_libro   ← renombramiento
   SQL: SELECT l1.titulo AS libro1, l2.titulo AS libro2
        FROM LIBRO l1, LIBRO l2 WHERE l1.id_libro != l2.id_libro;
```

---

##  Parte 2: Operadores Avanzados del Álgebra Relacional

### Ejercicio 2.1 — Operador de Reunión (JOIN)

#### A) Reunión Natural (⋈)

```sql
-- Consulta 1: Libros con sus autores
-- AR: LIBRO_AUTOR ⋈ AUTOR
SELECT * FROM LIBRO_AUTOR NATURAL JOIN AUTOR;

-- Consulta 2: Préstamos con datos del usuario y detalle de libro
-- AR: PRESTAMO ⋈ USUARIO ⋈ DETALLE_PRESTAMO
SELECT p.id_prestamo, u.nombre, dp.id_libro
FROM PRESTAMO p NATURAL JOIN USUARIO u NATURAL JOIN DETALLE_PRESTAMO dp;

-- Consulta 3: Títulos de libros con sus autores (con proyección)
-- AR: π_{titulo,nombre}(LIBRO ⋈ LIBRO_AUTOR ⋈ AUTOR)
SELECT l.titulo, a.nombre
FROM LIBRO l JOIN LIBRO_AUTOR la ON l.id_libro = la.id_libro
             JOIN AUTOR a ON la.id_autor = a.id_autor;
```

#### B) Theta Join (⋈_θ)

```sql
-- Consulta 4: Libros publicados antes de 2000 con sus préstamos activos
-- AR: σ_{anio_publicacion<2000}(LIBRO) ⋈_{LIBRO.id_libro=DETALLE_PRESTAMO.id_libro} DETALLE_PRESTAMO
SELECT l.titulo, l.anio_publicacion, dp.id_prestamo
FROM LIBRO l JOIN DETALLE_PRESTAMO dp ON l.id_libro = dp.id_libro
WHERE l.anio_publicacion < 2000;

-- Consulta 5: Usuarios registrados después que el préstamo fue creado (desigualdad)
-- AR: USUARIO ⋈_{USUARIO.fecha_registro > PRESTAMO.fecha_prestamo} PRESTAMO
SELECT u.nombre, u.fecha_registro, p.id_prestamo, p.fecha_prestamo
FROM USUARIO u JOIN PRESTAMO p ON u.fecha_registro > p.fecha_prestamo
LIMIT 5;

-- Consulta 6: Préstamos activos de libros con más de 10 ejemplares (condición compuesta)
-- AR: σ_{estado='activo'}(PRESTAMO) ⋈ DETALLE_PRESTAMO ⋈ σ_{ejemplares_total>10}(LIBRO)
SELECT p.id_prestamo, l.titulo, l.ejemplares_total
FROM PRESTAMO p JOIN DETALLE_PRESTAMO dp ON p.id_prestamo = dp.id_prestamo
               JOIN LIBRO l ON dp.id_libro = l.id_libro
WHERE p.estado = 'activo' AND l.ejemplares_total > 10;
```

#### C) Reunión Externa (Outer Join)

```sql
-- Consulta 7: Todos los libros, incluyendo los sin préstamos (Left Outer Join)
-- AR: LIBRO ⟕ DETALLE_PRESTAMO
SELECT l.titulo, dp.id_prestamo
FROM LIBRO l LEFT OUTER JOIN DETALLE_PRESTAMO dp ON l.id_libro = dp.id_libro;

-- Consulta 8: Todos los préstamos, incluyendo libros sin datos (Right Outer Join)
-- AR: DETALLE_PRESTAMO ⟖ LIBRO
SELECT dp.id_prestamo, l.titulo
FROM DETALLE_PRESTAMO dp RIGHT OUTER JOIN LIBRO l ON dp.id_libro = l.id_libro;

-- Consulta 9: Todos los libros y todos los préstamos (Full Outer Join)
-- AR: LIBRO ⟗ DETALLE_PRESTAMO
SELECT l.titulo, dp.id_prestamo
FROM LIBRO l FULL OUTER JOIN DETALLE_PRESTAMO dp ON l.id_libro = dp.id_libro;
```

#### D) Semi-Join (⋉) y Anti-Join (▷)

```sql
-- Consulta 10: Usuarios que tienen al menos un préstamo activo (Semi-join)
-- AR: USUARIO ⋉ σ_{estado='activo'}(PRESTAMO)
SELECT DISTINCT u.nombre, u.tipo FROM USUARIO u
WHERE EXISTS (SELECT 1 FROM PRESTAMO p WHERE p.id_usuario = u.id_usuario AND p.estado = 'activo');

-- Consulta 11: Usuarios sin ningún préstamo (Anti-join)
-- AR: USUARIO ▷ PRESTAMO
SELECT u.nombre, u.tipo FROM USUARIO u
WHERE NOT EXISTS (SELECT 1 FROM PRESTAMO p WHERE p.id_usuario = u.id_usuario);

-- Consulta 12: Libros prestados al menos una vez a un estudiante (Semi-join combinado)
-- AR: LIBRO ⋉ (DETALLE_PRESTAMO ⋈ σ_{tipo='estudiante'}(USUARIO) ⋈ PRESTAMO)
SELECT DISTINCT l.titulo FROM LIBRO l
WHERE EXISTS (
  SELECT 1 FROM DETALLE_PRESTAMO dp
  JOIN PRESTAMO p ON dp.id_prestamo = p.id_prestamo
  JOIN USUARIO u ON p.id_usuario = u.id_usuario
  WHERE dp.id_libro = l.id_libro AND u.tipo = 'estudiante'
);
```

#### E) Auto-Reunión (Self Join)

```sql
-- Consulta 13: Pares de autores con la misma nacionalidad
-- AR: ρ(A1,AUTOR) ⋈_{A1.nacionalidad=A2.nacionalidad ∧ A1.id_autor<A2.id_autor} ρ(A2,AUTOR)
SELECT a1.nombre AS autor1, a2.nombre AS autor2, a1.nacionalidad
FROM AUTOR a1 JOIN AUTOR a2 ON a1.nacionalidad = a2.nacionalidad AND a1.id_autor < a2.id_autor;

-- Consulta 14: Libros de la misma categoría con diferentes autores
-- AR: ρ(L1,LIBRO) ⋈_{L1.categoria=L2.categoria ∧ L1.id_libro<L2.id_libro} ρ(L2,LIBRO)
SELECT l1.titulo AS libro1, l2.titulo AS libro2, l1.categoria
FROM LIBRO l1 JOIN LIBRO l2 ON l1.categoria = l2.categoria AND l1.id_libro < l2.id_libro;

-- Consulta 15: Préstamos del mismo usuario
-- AR: ρ(P1,PRESTAMO) ⋈_{P1.id_usuario=P2.id_usuario ∧ P1.id_prestamo<P2.id_prestamo} ρ(P2,PRESTAMO)
SELECT p1.id_prestamo AS prestamo1, p2.id_prestamo AS prestamo2, p1.id_usuario
FROM PRESTAMO p1 JOIN PRESTAMO p2 ON p1.id_usuario = p2.id_usuario AND p1.id_prestamo < p2.id_prestamo;
```

---

### Ejercicio 2.2 — Funciones de Agregación (ℱ)


|
 1 
|
`ℱ_COUNT(*)(LIBRO)`
|
`SELECT COUNT(*) AS total_libros FROM LIBRO`
|
 10 
|
|
 2 
|
`ℱ_COUNT DISTINCT nacionalidad(AUTOR)`
|
`SELECT COUNT(DISTINCT nacionalidad) AS nac_distintas FROM AUTOR`
|
 4 
|
|
 3 
|
`ℱ_SUM(ejemplares_total)(LIBRO)`
|
`SELECT SUM(ejemplares_total) AS total_ejemplares FROM LIBRO`
|
 133 
|
|
 4 
|
`ℱ_AVG(num_paginas)(LIBRO)`
|
`SELECT ROUND(AVG(num_paginas),1) AS promedio_paginas FROM LIBRO`
|
 446.1 
|
|
 5 
|
`ℱ_MAX(anio_publicacion)(LIBRO)`
|
`SELECT MAX(anio_publicacion) AS mas_reciente FROM LIBRO`
|
 2003 
|
|
 6 
|
`ℱ_MIN(ejemplares_total)(LIBRO)`
|
`SELECT MIN(ejemplares_total) AS min_ejemplares FROM LIBRO`
|
 7 
|
|
 7 
|
`ℱ_COUNT(*),MAX(num_paginas),AVG(num_paginas)(LIBRO)`
|
`SELECT COUNT(*), MAX(num_paginas), ROUND(AVG(num_paginas),1) FROM LIBRO`
|
 10, 800, 446.1 
|
|
 8 
|
`ℱ_COUNT(*)(σ_{estado='activo'}(PRESTAMO))`
|
`SELECT COUNT(*) FROM PRESTAMO WHERE estado='activo'`
|
 8 
|
|
 9 
|
`σ_{ejemplares_total>10}(ℱ_COUNT(*)(LIBRO))`
|
`SELECT titulo, ejemplares_total FROM LIBRO WHERE ejemplares_total>10 ORDER BY ejemplares_total DESC`
|
 5 libros 
|
|
 10 
|
`ℱ_COUNT(DISTINCT id_libro)(DETALLE_PRESTAMO ⋈ PRESTAMO)`
|
`SELECT COUNT(DISTINCT dp.id_libro) FROM DETALLE_PRESTAMO dp JOIN PRESTAMO p ON dp.id_prestamo=p.id_prestamo`
|
 10 
|

---

### Ejercicio 2.3 — Operador de Agrupación (γ)

```sql
-- C1: Número de libros por categoría
-- AR: γ_{categoria; COUNT(*)->total}(LIBRO)
SELECT categoria, COUNT(*) AS total FROM LIBRO GROUP BY categoria;

-- C2: Total de ejemplares por categoría
-- AR: γ_{categoria; SUM(ejemplares_total)->total_ej}(LIBRO)
SELECT categoria, SUM(ejemplares_total) AS total_ej FROM LIBRO GROUP BY categoria;

-- C3: Promedio de páginas por categoría
-- AR: γ_{categoria; AVG(num_paginas)->prom}(LIBRO)
SELECT categoria, ROUND(AVG(num_paginas),1) AS prom_paginas FROM LIBRO GROUP BY categoria;

-- C4: Libro con más y menos páginas por categoría
-- AR: γ_{categoria; MAX(num_paginas)->max_p, MIN(num_paginas)->min_p}(LIBRO)
SELECT categoria, MAX(num_paginas) AS max_p, MIN(num_paginas) AS min_p FROM LIBRO GROUP BY categoria;

-- C5: Préstamos por usuario y estado (agrupación múltiple)
-- AR: γ_{id_usuario, estado; COUNT(*)->total}(PRESTAMO)
SELECT id_usuario, estado, COUNT(*) AS total FROM PRESTAMO GROUP BY id_usuario, estado;

-- C6: Libros prestados por usuarios tipo 'estudiante'
-- AR: γ_{id_libro; COUNT(*)->veces}(DETALLE_PRESTAMO ⋈ PRESTAMO ⋈ σ_{tipo='estudiante'}(USUARIO))
SELECT dp.id_libro, COUNT(*) AS veces
FROM DETALLE_PRESTAMO dp
JOIN PRESTAMO p ON dp.id_prestamo = p.id_prestamo
JOIN USUARIO u ON p.id_usuario = u.id_usuario
WHERE u.tipo = 'estudiante' GROUP BY dp.id_libro;

-- C7: Usuarios con más de 1 préstamo (HAVING)
-- AR: σ_{total>1}(γ_{id_usuario; COUNT(*)->total}(PRESTAMO))
SELECT id_usuario, COUNT(*) AS total FROM PRESTAMO GROUP BY id_usuario HAVING COUNT(*) > 1;

-- C8: Número de libros prestados por préstamo
-- AR: γ_{id_prestamo; COUNT(*)->num_libros}(DETALLE_PRESTAMO ⋈ PRESTAMO)
SELECT dp.id_prestamo, COUNT(*) AS num_libros
FROM DETALLE_PRESTAMO dp JOIN PRESTAMO p ON dp.id_prestamo = p.id_prestamo
GROUP BY dp.id_prestamo ORDER BY dp.id_prestamo;

-- C9: Categoría, total de libros y total de ejemplares (múltiples funciones)
-- AR: γ_{categoria; COUNT(*)->total, SUM(ejemplares_total)->total_ej, AVG(num_paginas)->prom_p}(LIBRO)
SELECT categoria, COUNT(*) AS total_libros, SUM(ejemplares_total) AS total_ej,
       ROUND(AVG(num_paginas),1) AS prom_pag FROM LIBRO GROUP BY categoria;

-- C10: Autores con más de un libro
-- AR: σ_{total>1}(γ_{id_autor; COUNT(*)->total}(LIBRO_AUTOR))
SELECT a.nombre, COUNT(*) AS total_libros
FROM LIBRO_AUTOR la JOIN AUTOR a ON la.id_autor = a.id_autor
GROUP BY a.nombre HAVING COUNT(*) > 1;
```

---

### Ejercicio 2.4 — Operador de División (÷)

```sql
-- División 1: Usuarios que han pedido TODOS los libros del autor 1 (García Márquez)
-- AR: π_{id_usuario,id_libro}(DETALLE_PRESTAMO ⋈ PRESTAMO) ÷ π_{id_libro}(σ_{id_autor=1}(LIBRO_AUTOR))
-- S = {id_libro: 1, 2}
SELECT p.id_usuario FROM PRESTAMO p
JOIN DETALLE_PRESTAMO dp ON p.id_prestamo = dp.id_prestamo
WHERE dp.id_libro IN (1, 2)
GROUP BY p.id_usuario HAVING COUNT(DISTINCT dp.id_libro) = 2;
-- Resultado: id_usuario 9 (Carmen Vega)

-- División 2: Usuarios que pidieron TODOS los libros de categoría 'Fantasía'
-- AR: π_{id_usuario,id_libro}(DETALLE_PRESTAMO ⋈ PRESTAMO) ÷ π_{id_libro}(σ_{categoria='Fantasía'}(LIBRO))
-- S = {id_libro: 3, 4, 5}
SELECT p.id_usuario FROM PRESTAMO p
JOIN DETALLE_PRESTAMO dp ON p.id_prestamo = dp.id_prestamo
WHERE dp.id_libro IN (3,4,5)
GROUP BY p.id_usuario HAVING COUNT(DISTINCT dp.id_libro) = 3;
-- Resultado: id_usuario 3 (María López)

-- División 3: Usuarios que pidieron TODOS los libros de la editorial 'Salamandra'
-- AR: π_{id_usuario,id_libro}(DETALLE_PRESTAMO ⋈ PRESTAMO) ÷ π_{id_libro}(σ_{editorial='Salamandra'}(LIBRO))
-- S = {id_libro: 3, 4}
SELECT p.id_usuario FROM PRESTAMO p
JOIN DETALLE_PRESTAMO dp ON p.id_prestamo = dp.id_prestamo
WHERE dp.id_libro IN (3,4)
GROUP BY p.id_usuario HAVING COUNT(DISTINCT dp.id_libro) = 2;
-- Resultado: id_usuarios 7, 8, 3

-- División 4: Libros prestados por TODOS los tipos de usuario
-- AR: π_{id_libro,tipo}(DETALLE_PRESTAMO ⋈ PRESTAMO ⋈ USUARIO) ÷ π_{tipo}(USUARIO)
SELECT dp.id_libro FROM DETALLE_PRESTAMO dp
JOIN PRESTAMO p ON dp.id_prestamo = p.id_prestamo
JOIN USUARIO u ON p.id_usuario = u.id_usuario
GROUP BY dp.id_libro HAVING COUNT(DISTINCT u.tipo) = 3;
-- Resultado: vacío (ningún libro prestado por los 3 tipos)

-- División 5: Usuarios con préstamos en TODOS los estados posibles
-- AR: π_{id_usuario,estado}(PRESTAMO) ÷ π_{estado}(σ_{estado IN ('activo','devuelto','retrasado')}(PRESTAMO))
SELECT id_usuario FROM PRESTAMO GROUP BY id_usuario
HAVING COUNT(DISTINCT estado) = (SELECT COUNT(DISTINCT estado) FROM PRESTAMO);
-- Resultado: vacío (ningún usuario tiene los 3 estados)
```

---

##  Parte 3: Cálculo Relacional

> El desarrollo completo de los Ejercicios 3.1 (CRT — 15 consultas), 3.2 (CRD — 10 consultas),
> 3.3 (Equivalencia en 4 lenguajes — 10 consultas) y 3.4 (Seguridad y Completitud) se encuentra
> documentado en el archivo adjunto **`Parte3_CalculoRelacional_BibliotecaDigital.docx`**.

### Resumen de la Parte 3


|
 3.1 CRT 
|
 Consultas en Cálculo Relacional de Tuplas 
|
 15 consultas 
|
|
 3.2 CRD 
|
 Consultas en Cálculo Relacional de Dominios 
|
 10 consultas 
|
|
 3.3 Equivalencia 
|
 AR + CRT + CRD + SQL para cada consulta 
|
 10 consultas × 4 lenguajes 
|
|
 3.4 Seguridad 
|
 Expresiones inseguras y su corrección 
|
 5 ejemplos 
|
|
 3.4 Completitud 
|
 Teorema de Codd con demostraciones 
|
 3 demostraciones 
|

---

## Scripts SQL

Todos los scripts están en la carpeta `sql/`:

- **`01_ddl.sql`** — Definición del esquema completo (CREATE TABLE, restricciones, CHECK, UNIQUE, FK)
- **`02_inserts.sql`** — Datos de ejemplo con al menos 10 registros por tabla principal
- **`03_consultas.sql`** — Las 20 consultas del caso integrador del Ejercicio Final

---

##  Referencias

- Supabase. (s.f.). *Database*. Documentación oficial. https://supabase.com/docs/guides/database
- Supabase. (s.f.). *Row Level Security*. https://supabase.com/docs/guides/auth/row-level-security
- Ramakrishnan, R., & Gehrke, J. (2003). *Database Management Systems* (3.ª ed.). McGraw-Hill.
- Date, C. J. (2004). *An Introduction to Database Systems* (8.ª ed.). Pearson Education.
- Silberschatz, A., Korth, H., & Sudarshan, S. (2019). *Database System Concepts* (7.ª ed.). McGraw-Hill.
