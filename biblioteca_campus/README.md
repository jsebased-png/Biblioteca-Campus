# Biblioteca Campus — Consultas SQL

### 1. Listar todos los libros disponibles

```sql
SELECT libro_id,
       isbn,
       titulo,
       genero,
       ejemplares_disponibles
FROM libro
WHERE estado = 'Disponible'
  AND ejemplares_disponibles > 0
ORDER BY titulo;
```

### 2. Buscar libros por género

```sql
SELECT libro_id,
       isbn,
       titulo,
       genero,
       idioma
FROM libro
WHERE genero = 'Realismo magico'
ORDER BY titulo;
```

### 3. Obtener información de un libro por ISBN

```sql
SELECT *
FROM libro
WHERE isbn = '978-84-376-0494-7';
```

### 4. Contar el número de libros en la biblioteca

```sql
SELECT COUNT(*)                  AS titulos_registrados,
       SUM(ejemplares_totales)   AS ejemplares_totales,
       SUM(ejemplares_disponibles) AS ejemplares_disponibles
FROM libro;
```

### 5. Listar todos los autores

```sql
SELECT autor_id,
       CONCAT(nombre, ' ', apellido) AS autor,
       nacionalidad,
       fecha_nacimiento
FROM autor
ORDER BY apellido, nombre;
```

### 6. Buscar autores por nombre

```sql
SELECT autor_id,
       nombre,
       apellido,
       nacionalidad
FROM autor
WHERE nombre LIKE '%Gabriel%'
   OR apellido LIKE '%Gabriel%'
ORDER BY apellido;
```

### 7. Obtener todos los libros de un autor específico

```sql
SELECT l.libro_id,
       l.isbn,
       l.titulo,
       l.genero,
       la.rol
FROM libro l
INNER JOIN libro_autor la ON la.libro_id = l.libro_id
INNER JOIN autor a        ON a.autor_id  = la.autor_id
WHERE a.autor_id = 1
ORDER BY l.titulo;
```

### 8. Listar todas las ediciones de un libro

```sql
SELECT p.publicacion_id,
       p.numero_edicion,
       p.editorial,
       p.anio_publicacion,
       p.ciudad,
       p.formato,
       p.isbn_edicion
FROM publicacion p
WHERE p.libro_id = 1
ORDER BY p.numero_edicion;
```

### 9. Obtener la última edición de un libro

```sql
SELECT p.publicacion_id,
       p.numero_edicion,
       p.editorial,
       p.anio_publicacion,
       p.formato
FROM publicacion p
WHERE p.libro_id = 1
ORDER BY p.anio_publicacion DESC, p.numero_edicion DESC
LIMIT 1;
```

### 10. Contar cuántas ediciones hay de un libro específico

```sql
SELECT l.libro_id,
       l.titulo,
       COUNT(p.publicacion_id) AS total_ediciones
FROM libro l
LEFT JOIN publicacion p ON p.libro_id = l.libro_id
WHERE l.libro_id = 1
GROUP BY l.libro_id, l.titulo;
```

### 11. Listar todas las transacciones de préstamo

```sql
SELECT t.transaccion_id,
       l.titulo,
       CONCAT(m.nombre, ' ', m.apellido) AS miembro,
       t.fecha_prestamo,
       t.fecha_devolucion_esperada,
       t.fecha_devolucion_real,
       t.estado,
       t.multa
FROM transaccion t
INNER JOIN libro l   ON l.libro_id   = t.libro_id
INNER JOIN miembro m ON m.miembro_id = t.miembro_id
ORDER BY t.fecha_prestamo DESC;
```

### 12. Obtener los libros prestados actualmente

```sql
SELECT t.transaccion_id,
       l.libro_id,
       l.titulo,
       CONCAT(m.nombre, ' ', m.apellido) AS miembro,
       t.fecha_prestamo,
       t.fecha_devolucion_esperada,
       t.estado
FROM transaccion t
INNER JOIN libro l   ON l.libro_id   = t.libro_id
INNER JOIN miembro m ON m.miembro_id = t.miembro_id
WHERE t.fecha_devolucion_real IS NULL
  AND t.estado IN ('Prestado', 'Vencido')
ORDER BY t.fecha_devolucion_esperada;
```

### 13. Contar el número de transacciones de un miembro específico

```sql
SELECT m.miembro_id,
       CONCAT(m.nombre, ' ', m.apellido) AS miembro,
       COUNT(t.transaccion_id) AS total_transacciones
FROM miembro m
LEFT JOIN transaccion t ON t.miembro_id = m.miembro_id
WHERE m.miembro_id = 1
GROUP BY m.miembro_id, m.nombre, m.apellido;
```

### 14. Listar todos los miembros de la biblioteca

```sql
SELECT miembro_id,
       codigo_miembro,
       CONCAT(nombre, ' ', apellido) AS miembro,
       email,
       tipo_miembro,
       estado,
       fecha_registro
FROM miembro
ORDER BY apellido, nombre;
```

### 15. Buscar un miembro por nombre

```sql
SELECT miembro_id,
       codigo_miembro,
       nombre,
       apellido,
       email,
       tipo_miembro
FROM miembro
WHERE nombre LIKE '%Laura%'
   OR apellido LIKE '%Laura%'
ORDER BY apellido;
```

### 16. Obtener las transacciones de un miembro específico

```sql
SELECT t.transaccion_id,
       l.titulo,
       t.fecha_prestamo,
       t.fecha_devolucion_esperada,
       t.fecha_devolucion_real,
       t.estado,
       t.multa
FROM transaccion t
INNER JOIN libro l ON l.libro_id = t.libro_id
WHERE t.miembro_id = 1
ORDER BY t.fecha_prestamo DESC;
```

### 17. Listar todos los libros y sus autores

```sql
SELECT l.libro_id,
       l.titulo,
       GROUP_CONCAT(CONCAT(a.nombre, ' ', a.apellido)
                    ORDER BY la.orden SEPARATOR ', ') AS autores
FROM libro l
LEFT JOIN libro_autor la ON la.libro_id = l.libro_id
LEFT JOIN autor a        ON a.autor_id  = la.autor_id
GROUP BY l.libro_id, l.titulo
ORDER BY l.titulo;
```

### 18. Obtener el historial de préstamos de un libro específico

```sql
SELECT t.transaccion_id,
       CONCAT(m.nombre, ' ', m.apellido) AS miembro,
       t.fecha_prestamo,
       t.fecha_devolucion_esperada,
       t.fecha_devolucion_real,
       t.estado,
       t.multa
FROM transaccion t
INNER JOIN miembro m ON m.miembro_id = t.miembro_id
WHERE t.libro_id = 1
ORDER BY t.fecha_prestamo DESC;
```

### 19. Contar cuántos libros han sido prestados en total

```sql
SELECT COUNT(*)                  AS prestamos_totales,
       COUNT(DISTINCT libro_id)  AS libros_distintos_prestados
FROM transaccion;
```

### 20. Listar todos los libros junto con su última edición y estado de disponibilidad

```sql
SELECT l.libro_id,
       l.titulo,
       l.isbn,
       p.numero_edicion   AS ultima_edicion,
       p.editorial,
       p.anio_publicacion,
       l.ejemplares_disponibles,
       CASE
           WHEN l.estado = 'Disponible' AND l.ejemplares_disponibles > 0
                THEN 'Disponible'
           ELSE 'No disponible'
       END AS disponibilidad
FROM libro l
LEFT JOIN publicacion p
       ON p.publicacion_id = (
            SELECT p2.publicacion_id
            FROM publicacion p2
            WHERE p2.libro_id = l.libro_id
            ORDER BY p2.anio_publicacion DESC, p2.numero_edicion DESC
            LIMIT 1
       )
ORDER BY l.titulo;
```
