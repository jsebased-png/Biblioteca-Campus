-- =====================================================================
-- Proyecto : Biblioteca Campus
-- Archivo  : db.sql
-- Motor    : MySQL 8.0 / InnoDB / utf8mb4
-- Contenido: Estructura completa (DDL) de la base de datos
-- =====================================================================

DROP DATABASE IF EXISTS biblioteca_campus;
CREATE DATABASE biblioteca_campus
    DEFAULT CHARACTER SET utf8mb4
    DEFAULT COLLATE utf8mb4_unicode_ci;
USE biblioteca_campus;

-- =====================================================================
-- Tabla: autor
-- Datos de los autores de las obras.
-- =====================================================================
CREATE TABLE autor (
    autor_id            INT UNSIGNED NOT NULL AUTO_INCREMENT,
    nombre              VARCHAR(80)  NOT NULL,
    apellido            VARCHAR(80)  NOT NULL,
    nacionalidad        VARCHAR(60)      NULL,
    fecha_nacimiento    DATE             NULL,
    fecha_fallecimiento DATE             NULL,
    biografia           TEXT             NULL,
    CONSTRAINT pk_autor PRIMARY KEY (autor_id),
    CONSTRAINT uq_autor_nombre UNIQUE (nombre, apellido, fecha_nacimiento),
    CONSTRAINT ck_autor_fechas CHECK (
        fecha_fallecimiento IS NULL
        OR fecha_nacimiento IS NULL
        OR fecha_fallecimiento >= fecha_nacimiento
    )
) ENGINE = InnoDB;

CREATE INDEX idx_autor_apellido ON autor (apellido, nombre);

-- =====================================================================
-- Tabla: libro
-- Obra catalogada en la biblioteca (el título como entidad).
-- =====================================================================
CREATE TABLE libro (
    libro_id               INT UNSIGNED NOT NULL AUTO_INCREMENT,
    isbn                   VARCHAR(20)  NOT NULL,
    titulo                 VARCHAR(200) NOT NULL,
    genero                 VARCHAR(60)  NOT NULL,
    idioma                 VARCHAR(40)  NOT NULL DEFAULT 'Español',
    anio_primera_edicion   SMALLINT UNSIGNED NULL,
    numero_paginas         SMALLINT UNSIGNED NULL,
    sinopsis               TEXT             NULL,
    ejemplares_totales     SMALLINT UNSIGNED NOT NULL DEFAULT 1,
    ejemplares_disponibles SMALLINT UNSIGNED NOT NULL DEFAULT 1,
    estado                 ENUM('Disponible','Prestado','En reparacion','Extraviado','Retirado')
                           NOT NULL DEFAULT 'Disponible',
    fecha_registro         DATE         NOT NULL DEFAULT (CURRENT_DATE),
    CONSTRAINT pk_libro PRIMARY KEY (libro_id),
    CONSTRAINT uq_libro_isbn UNIQUE (isbn),
    CONSTRAINT ck_libro_ejemplares CHECK (ejemplares_disponibles <= ejemplares_totales)
) ENGINE = InnoDB;

CREATE INDEX idx_libro_genero ON libro (genero);
CREATE INDEX idx_libro_titulo ON libro (titulo);

-- =====================================================================
-- Tabla: libro_autor
-- Tabla puente que resuelve la relación N:M entre libro y autor.
-- =====================================================================
CREATE TABLE libro_autor (
    libro_id INT UNSIGNED NOT NULL,
    autor_id INT UNSIGNED NOT NULL,
    rol      ENUM('Autor principal','Coautor','Traductor','Editor','Ilustrador','Prologuista')
             NOT NULL DEFAULT 'Autor principal',
    orden    TINYINT UNSIGNED NOT NULL DEFAULT 1,
    CONSTRAINT pk_libro_autor PRIMARY KEY (libro_id, autor_id),
    CONSTRAINT fk_libro_autor_libro FOREIGN KEY (libro_id)
        REFERENCES libro (libro_id) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_libro_autor_autor FOREIGN KEY (autor_id)
        REFERENCES autor (autor_id) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB;

CREATE INDEX idx_libro_autor_autor ON libro_autor (autor_id);

-- =====================================================================
-- Tabla: publicacion
-- Cada edición concreta de un libro (editorial, año, formato).
-- =====================================================================
CREATE TABLE publicacion (
    publicacion_id   INT UNSIGNED NOT NULL AUTO_INCREMENT,
    libro_id         INT UNSIGNED NOT NULL,
    numero_edicion   SMALLINT UNSIGNED NOT NULL DEFAULT 1,
    editorial        VARCHAR(120) NOT NULL,
    anio_publicacion SMALLINT UNSIGNED NOT NULL,
    ciudad           VARCHAR(80)      NULL,
    formato          ENUM('Tapa dura','Tapa blanda','Bolsillo','Digital','Audiolibro')
                     NOT NULL DEFAULT 'Tapa blanda',
    isbn_edicion     VARCHAR(20)      NULL,
    numero_paginas   SMALLINT UNSIGNED NULL,
    CONSTRAINT pk_publicacion PRIMARY KEY (publicacion_id),
    CONSTRAINT uq_publicacion_edicion UNIQUE (libro_id, numero_edicion),
    CONSTRAINT uq_publicacion_isbn UNIQUE (isbn_edicion),
    CONSTRAINT fk_publicacion_libro FOREIGN KEY (libro_id)
        REFERENCES libro (libro_id) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT ck_publicacion_anio CHECK (anio_publicacion BETWEEN 1400 AND 2100)
) ENGINE = InnoDB;

CREATE INDEX idx_publicacion_libro ON publicacion (libro_id, anio_publicacion);

-- =====================================================================
-- Tabla: miembro
-- Usuarios registrados de la biblioteca.
-- =====================================================================
CREATE TABLE miembro (
    miembro_id     INT UNSIGNED NOT NULL AUTO_INCREMENT,
    codigo_miembro VARCHAR(15)  NOT NULL,
    nombre         VARCHAR(80)  NOT NULL,
    apellido       VARCHAR(80)  NOT NULL,
    documento      VARCHAR(20)  NOT NULL,
    email          VARCHAR(120) NOT NULL,
    telefono       VARCHAR(20)      NULL,
    direccion      VARCHAR(160)     NULL,
    tipo_miembro   ENUM('Estudiante','Docente','Administrativo','Externo')
                   NOT NULL DEFAULT 'Estudiante',
    fecha_registro DATE         NOT NULL DEFAULT (CURRENT_DATE),
    estado         ENUM('Activo','Suspendido','Inactivo') NOT NULL DEFAULT 'Activo',
    CONSTRAINT pk_miembro PRIMARY KEY (miembro_id),
    CONSTRAINT uq_miembro_codigo UNIQUE (codigo_miembro),
    CONSTRAINT uq_miembro_documento UNIQUE (documento),
    CONSTRAINT uq_miembro_email UNIQUE (email)
) ENGINE = InnoDB;

CREATE INDEX idx_miembro_apellido ON miembro (apellido, nombre);

-- =====================================================================
-- Tabla: transaccion
-- Registro de préstamos y devoluciones.
-- =====================================================================
CREATE TABLE transaccion (
    transaccion_id            INT UNSIGNED NOT NULL AUTO_INCREMENT,
    libro_id                  INT UNSIGNED NOT NULL,
    miembro_id                INT UNSIGNED NOT NULL,
    publicacion_id            INT UNSIGNED     NULL,
    fecha_prestamo            DATE         NOT NULL,
    fecha_devolucion_esperada DATE         NOT NULL,
    fecha_devolucion_real     DATE             NULL,
    estado                    ENUM('Prestado','Devuelto','Vencido','Perdido')
                              NOT NULL DEFAULT 'Prestado',
    multa                     DECIMAL(8,2) NOT NULL DEFAULT 0.00,
    observaciones             VARCHAR(255)     NULL,
    CONSTRAINT pk_transaccion PRIMARY KEY (transaccion_id),
    CONSTRAINT fk_transaccion_libro FOREIGN KEY (libro_id)
        REFERENCES libro (libro_id) ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT fk_transaccion_miembro FOREIGN KEY (miembro_id)
        REFERENCES miembro (miembro_id) ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT fk_transaccion_publicacion FOREIGN KEY (publicacion_id)
        REFERENCES publicacion (publicacion_id) ON DELETE SET NULL ON UPDATE CASCADE,
    CONSTRAINT ck_transaccion_fechas CHECK (fecha_devolucion_esperada >= fecha_prestamo),
    CONSTRAINT ck_transaccion_multa CHECK (multa >= 0)
) ENGINE = InnoDB;

CREATE INDEX idx_transaccion_libro   ON transaccion (libro_id, fecha_prestamo);
CREATE INDEX idx_transaccion_miembro ON transaccion (miembro_id, fecha_prestamo);
CREATE INDEX idx_transaccion_estado  ON transaccion (estado);
