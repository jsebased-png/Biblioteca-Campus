-- =====================================================================
-- Proyecto : Biblioteca Campus
-- Archivo  : insert.sql
-- Contenido: Datos de prueba (únicamente comandos INSERT)
-- Orden    : autor -> libro -> libro_autor -> publicacion -> miembro -> transaccion
-- =====================================================================

    USE biblioteca_campus;

    -- ---------------------------------------------------------------------
    -- AUTORES
    -- ---------------------------------------------------------------------
    INSERT INTO autor (autor_id, nombre, apellido, nacionalidad, fecha_nacimiento, fecha_fallecimiento, biografia) VALUES
    (1,  'Gabriel',     'Garcia Marquez', 'Colombiana',     '1927-03-06', '2014-04-17', 'Novelista y periodista, Premio Nobel de Literatura en 1982.'),
    (2,  'Jose Eustasio','Rivera',        'Colombiana',     '1888-02-19', '1928-12-01', 'Abogado y escritor, maximo representante de la novela de la selva.'),
    (3,  'Julio',       'Cortazar',       'Argentina',      '1914-08-26', '1984-02-12', 'Narrador y traductor, figura central del boom latinoamericano.'),
    (4,  'Jorge Luis',  'Borges',         'Argentina',      '1899-08-24', '1986-06-14', 'Poeta y cuentista, referente de la literatura fantastica.'),
    (5,  'Isabel',      'Allende',        'Chilena',        '1942-08-02', NULL,         'Autora de novelas historicas y de realismo magico.'),
    (6,  'Juan',        'Rulfo',          'Mexicana',       '1917-05-16', '1986-01-07', 'Escritor y fotografo, autor de una obra breve y decisiva.'),
    (7,  'Christopher', 'Date',           'Britanica',      '1941-01-01', NULL,         'Especialista en el modelo relacional de bases de datos.'),
    (8,  'Abraham',     'Silberschatz',   'Estadounidense', NULL,         NULL,         'Investigador y docente en sistemas operativos y bases de datos.'),
    (9,  'Henry',       'Korth',          'Estadounidense', NULL,         NULL,         'Coautor de textos universitarios sobre bases de datos.'),
    (10, 'Robert',      'Martin',         'Estadounidense', '1952-12-05', NULL,         'Ingeniero de software, divulgador de buenas practicas de codigo.'),
    (11, 'Gregory',     'Rabassa',        'Estadounidense', '1922-03-09', '2016-06-13', 'Traductor literario del espanol y el portugues al ingles.');

    -- ---------------------------------------------------------------------
    -- LIBROS
    -- ---------------------------------------------------------------------
    INSERT INTO libro (libro_id, isbn, titulo, genero, idioma, anio_primera_edicion, numero_paginas, sinopsis, ejemplares_totales, ejemplares_disponibles, estado, fecha_registro) VALUES
    (1,  '978-84-376-0494-7', 'Cien anos de soledad',                        'Realismo magico', 'Espanol', 1967, 471, 'Cronica de varias generaciones de la familia Buendia en el pueblo de Macondo.',           4, 2, 'Disponible', '2024-02-10'),
    (2,  '978-958-30-1234-5', 'La voragine',                                 'Novela',          'Espanol', 1924, 328, 'Arturo Cova huye con Alicia y se interna en los llanos y la selva del Amazonas.',        3, 3, 'Disponible', '2024-02-10'),
    (3,  '978-84-663-1975-2', 'Rayuela',                                     'Novela',          'Espanol', 1963, 635, 'Horacio Oliveira busca sentido entre Paris y Buenos Aires en una novela de lectura abierta.', 2, 0, 'Prestado',   '2024-03-05'),
    (4,  '978-84-206-3311-0', 'Ficciones',                                   'Cuento',          'Espanol', 1944, 224, 'Coleccion de relatos sobre laberintos, bibliotecas infinitas y realidades bifurcadas.',  3, 2, 'Disponible', '2024-03-05'),
    (5,  '978-84-397-2077-2', 'El amor en los tiempos del colera',           'Romance',         'Espanol', 1985, 496, 'Florentino Ariza espera medio siglo para reencontrarse con Fermina Daza.',              2, 1, 'Disponible', '2024-04-18'),
    (6,  '978-84-01-33756-9', 'La casa de los espiritus',                    'Realismo magico', 'Espanol', 1982, 448, 'Saga de la familia Trueba atravesada por la historia politica de un pais latinoamericano.', 3, 2, 'Disponible', '2024-04-18'),
    (7,  '978-607-16-0121-8', 'Pedro Paramo',                                'Novela',          'Espanol', 1955, 134, 'Juan Preciado llega a Comala buscando a su padre y encuentra un pueblo de voces muertas.', 2, 2, 'Disponible', '2024-05-22'),
    (8,  '978-0-321-19784-9', 'Introduccion a los sistemas de bases de datos','Tecnico',        'Espanol', 1975, 936, 'Texto clasico sobre el modelo relacional, normalizacion y lenguajes de consulta.',      5, 4, 'Disponible', '2024-06-01'),
    (9,  '978-607-15-0619-4', 'Fundamentos de bases de datos',               'Tecnico',         'Espanol', 1986, 872, 'Manual universitario sobre diseno, transacciones e implementacion de bases de datos.',  4, 4, 'Disponible', '2024-06-01'),
    (10, '978-0-13-235088-4', 'Clean Code',                                  'Programacion',    'Ingles',  2008, 464, 'Principios y practicas para escribir codigo legible y mantenible.',                     3, 2, 'Disponible', '2024-08-14');

    -- ---------------------------------------------------------------------
    -- RELACION LIBRO - AUTOR
    -- ---------------------------------------------------------------------
    INSERT INTO libro_autor (libro_id, autor_id, rol, orden) VALUES
    (1,  1,  'Autor principal', 1),
    (1,  11, 'Traductor',       2),
    (2,  2,  'Autor principal', 1),
    (3,  3,  'Autor principal', 1),
    (4,  4,  'Autor principal', 1),
    (5,  1,  'Autor principal', 1),
    (6,  5,  'Autor principal', 1),
    (7,  6,  'Autor principal', 1),
    (8,  7,  'Autor principal', 1),
    (9,  8,  'Autor principal', 1),
    (9,  9,  'Coautor',         2),
    (10, 10, 'Autor principal', 1);

    -- ---------------------------------------------------------------------
    -- PUBLICACIONES (EDICIONES)
    -- ---------------------------------------------------------------------
    INSERT INTO publicacion (publicacion_id, libro_id, numero_edicion, editorial, anio_publicacion, ciudad, formato, isbn_edicion, numero_paginas) VALUES
    (1,  1,  1, 'Editorial Sudamericana', 1967, 'Buenos Aires', 'Tapa blanda', '978-950-07-0001-1', 471),
    (2,  1,  2, 'Alfaguara',              1997, 'Madrid',       'Tapa blanda', '978-84-204-8188-8', 496),
    (3,  1,  3, 'Real Academia Espanola', 2007, 'Madrid',       'Tapa dura',   '978-84-376-0494-7', 608),
    (4,  2,  1, 'Editorial Cromos',       1924, 'Bogota',       'Tapa blanda', '978-958-30-0001-4', 320),
    (5,  2,  2, 'Alfaguara',              2016, 'Bogota',       'Tapa blanda', '978-958-30-1234-5', 328),
    (6,  3,  1, 'Editorial Sudamericana', 1963, 'Buenos Aires', 'Tapa blanda', '978-950-07-0330-2', 635),
    (7,  3,  2, 'Alfaguara',              2013, 'Madrid',       'Bolsillo',    '978-84-663-1975-2', 640),
    (8,  4,  1, 'Editorial Sur',          1944, 'Buenos Aires', 'Tapa blanda', '978-950-00-0044-1', 203),
    (9,  4,  2, 'Debolsillo',             2011, 'Barcelona',    'Bolsillo',    '978-84-206-3311-0', 224),
    (10, 5,  1, 'Editorial Oveja Negra',  1985, 'Bogota',       'Tapa blanda', '978-958-06-0001-5', 473),
    (11, 5,  2, 'Debolsillo',             2014, 'Barcelona',    'Bolsillo',    '978-84-397-2077-2', 496),
    (12, 6,  1, 'Plaza y Janes',          1982, 'Barcelona',    'Tapa dura',   '978-84-01-00001-3', 448),
    (13, 6,  2, 'Debolsillo',             2017, 'Barcelona',    'Bolsillo',    '978-84-01-33756-9', 456),
    (14, 7,  1, 'Fondo de Cultura Economica', 1955, 'Ciudad de Mexico', 'Tapa blanda', '978-968-16-0001-9', 128),
    (15, 7,  2, 'Editorial RM',           2005, 'Ciudad de Mexico', 'Tapa dura','978-607-16-0121-8', 134),
    (16, 8,  1, 'Addison-Wesley',         1975, 'Boston',       'Tapa dura',   '978-0-201-14471-5', 652),
    (17, 8,  7, 'Pearson Educacion',      2001, 'Mexico D.F.',  'Tapa blanda', '978-968-444-419-1', 900),
    (18, 8,  8, 'Pearson Educacion',      2004, 'Mexico D.F.',  'Tapa blanda', '978-0-321-19784-9', 936),
    (19, 9,  5, 'McGraw-Hill',            2006, 'Madrid',       'Tapa blanda', '978-84-481-4644-8', 787),
    (20, 9,  6, 'McGraw-Hill',            2014, 'Mexico D.F.',  'Tapa blanda', '978-607-15-0619-4', 872),
    (21, 10, 1, 'Prentice Hall',          2008, 'Upper Saddle River', 'Tapa blanda', '978-0-13-235088-4', 464),
    (22, 10, 2, 'Pearson',                2020, 'Boston',       'Digital',     '978-0-13-999088-1', 470);

    -- ---------------------------------------------------------------------
    -- MIEMBROS
    -- ---------------------------------------------------------------------
    INSERT INTO miembro (miembro_id, codigo_miembro, nombre, apellido, documento, email, telefono, direccion, tipo_miembro, fecha_registro, estado) VALUES
    (1, 'MB-2024-001', 'Laura',   'Gomez',     '1098765432', 'laura.gomez@campus.edu.co',    '3104567890', 'Calle 34 #12-45, Bucaramanga',   'Estudiante',     '2024-02-12', 'Activo'),
    (2, 'MB-2024-002', 'Andres',  'Ramirez',   '1090876543', 'andres.ramirez@campus.edu.co', '3125678901', 'Carrera 27 #48-10, Bucaramanga', 'Estudiante',     '2024-02-15', 'Activo'),
    (3, 'MB-2024-003', 'Carolina','Pineda',    '63456789',   'carolina.pineda@campus.edu.co','3007894561', 'Avenida 15 #22-30, Floridablanca','Docente',       '2024-02-20', 'Activo'),
    (4, 'MB-2024-004', 'Julian',  'Martinez',  '1095123456', 'julian.martinez@campus.edu.co','3163214567', 'Calle 56 #31-08, Bucaramanga',   'Estudiante',     '2024-03-01', 'Suspendido'),
    (5, 'MB-2024-005', 'Diana',   'Castro',    '91234567',   'diana.castro@campus.edu.co',   '3145558899', 'Carrera 33 #45-12, Bucaramanga', 'Administrativo', '2024-03-10', 'Activo'),
    (6, 'MB-2024-006', 'Santiago','Vargas',    '1098223344', 'santiago.vargas@campus.edu.co','3181112233', 'Calle 9 #26-71, Giron',          'Estudiante',     '2024-04-02', 'Activo'),
    (7, 'MB-2025-007', 'Valentina','Moreno',   '1097554433', 'valentina.moreno@campus.edu.co','3192223344','Carrera 19 #35-60, Bucaramanga', 'Estudiante',     '2025-01-22', 'Activo'),
    (8, 'MB-2025-008', 'Ricardo', 'Suarez',    '79887766',   'ricardo.suarez@campus.edu.co', '3013334455', 'Calle 105 #17-25, Piedecuesta',  'Externo',        '2025-03-14', 'Inactivo');

    -- ---------------------------------------------------------------------
    -- TRANSACCIONES DE PRESTAMO Y DEVOLUCION
    -- ---------------------------------------------------------------------
    INSERT INTO transaccion (transaccion_id, libro_id, miembro_id, publicacion_id, fecha_prestamo, fecha_devolucion_esperada, fecha_devolucion_real, estado, multa, observaciones) VALUES
    -- Prestamos ya devueltos
    (1,  1,  1, 2,  '2025-08-04', '2025-08-19', '2025-08-18', 'Devuelto', 0.00,    'Devuelto en buen estado.'),
    (2,  4,  2, 9,  '2025-09-10', '2025-09-25', '2025-09-24', 'Devuelto', 0.00,    NULL),
    (3,  8,  3, 18, '2025-09-15', '2025-10-15', '2025-10-12', 'Devuelto', 0.00,    'Prestamo extendido para docente.'),
    (4,  3,  4, 7,  '2025-10-02', '2025-10-17', '2025-10-30', 'Devuelto', 13000.00,'Devolucion tardia, se aplico multa.'),
    (5,  10, 6, 21, '2025-11-05', '2025-11-20', '2025-11-19', 'Devuelto', 0.00,    NULL),
    (6,  1,  5, 3,  '2026-01-20', '2026-02-04', '2026-02-03', 'Devuelto', 0.00,    NULL),
    (7,  6,  7, 13, '2026-02-11', '2026-02-26', '2026-02-25', 'Devuelto', 0.00,    NULL),
    (8,  9,  3, 20, '2026-03-03', '2026-04-03', '2026-03-28', 'Devuelto', 0.00,    'Material de apoyo para curso.'),
    (9,  5,  1, 11, '2026-04-14', '2026-04-29', '2026-05-02', 'Devuelto', 3000.00, 'Tres dias de retraso.'),
    (10, 7,  2, 15, '2026-05-06', '2026-05-21', '2026-05-20', 'Devuelto', 0.00,    NULL),
    (11, 8,  6, 17, '2026-06-09', '2026-06-24', '2026-06-23', 'Devuelto', 0.00,    NULL),
    (12, 2,  7, 5,  '2026-07-07', '2026-07-22', '2026-07-21', 'Devuelto', 0.00,    NULL),
    -- Prestamos activos
    (13, 1,  2, 2,  '2026-09-01', '2026-09-16', NULL, 'Prestado', 0.00,    NULL),
    (14, 1,  7, 3,  '2026-09-03', '2026-09-18', NULL, 'Prestado', 0.00,    NULL),
    (15, 3,  1, 6,  '2026-08-25', '2026-09-09', NULL, 'Vencido',  5000.00, 'Se notifico al miembro por correo.'),
    (16, 3,  5, 7,  '2026-09-05', '2026-09-20', NULL, 'Prestado', 0.00,    NULL),
    (17, 4,  6, 9,  '2026-09-07', '2026-09-22', NULL, 'Prestado', 0.00,    NULL),
    (18, 5,  3, 10, '2026-08-28', '2026-09-27', NULL, 'Prestado', 0.00,    'Prestamo de un mes para docente.'),
    (19, 6,  4, 12, '2026-08-18', '2026-09-02', NULL, 'Vencido',  12000.00,'Miembro suspendido por mora.'),
    (20, 8,  1, 18, '2026-09-08', '2026-09-23', NULL, 'Prestado', 0.00,    NULL),
    (21, 10, 2, 22, '2026-09-10', '2026-09-25', NULL, 'Prestado', 0.00,    NULL);
