-- Eliminar las tablas si existen para evitar conflictos
-- DROP TABLE IF EXISTS seleccion_nacional CASCADE;
-- DROP TABLE IF EXISTS club CASCADE;
-- DROP TABLE IF EXISTS equipo CASCADE;
-- DROP TABLE IF EXISTS jugador CASCADE;
-- DROP TABLE IF EXISTS personalizacion CASCADE;
-- DROP TABLE IF EXISTS parches CASCADE;
-- DROP TABLE IF EXISTS imagen_camiseta CASCADE;
-- DROP TABLE IF EXISTS camiseta CASCADE;
-- DROP TABLE IF EXISTS pedido_distribuidor CASCADE;
-- DROP TABLE IF EXISTS distribuidor CASCADE;
-- DROP TABLE IF EXISTS pedido_cliente CASCADE;
-- DROP TABLE IF EXISTS cliente CASCADE;
-- DROP TABLE IF EXISTS cliente_realiza_pedido CASCADE;
-- DROP TABLE IF EXISTS cliente_recibe_pedido CASCADE;

-- Tabla equipo
CREATE TABLE equipo (
  id SERIAL PRIMARY KEY,
  nombre VARCHAR(50) NOT NULL,
  escudo VARCHAR(150) UNIQUE, --ruta a la imagen
  equipacion VARCHAR(50) NOT NULL,
  CONSTRAINT chk_escudo CHECK (escudo ~ '^(.*/)?[a-zA-Z0-9_-]+\\.(jpg|jpeg|png)$'),
  CONSTRAINT chk_equipacion CHECK (
    equipacion LIKE 'primera' OR
    equipacion LIKE 'segunda' OR
    equipacion LIKE 'tercera'
  )
);

-- Tabla seleccion_nacional
CREATE TABLE seleccion_nacional (
  ranking_fifa INT NOT NULL,
  id_equipo SERIAL NOT NULL,
  FOREIGN KEY (id_equipo) REFERENCES equipo (id) ON DELETE CASCADE,
  CONSTRAINT chk_ranking_fifa CHECK (ranking_fifa >= 1 AND ranking_fifa <= 210)
);

-- Tabla club
CREATE TABLE club (
  estadio VARCHAR(50),
  liga VARCHAR(50) NOT NULL,
  id_equipo SERIAL NOT NULL,
  FOREIGN KEY (id_equipo) REFERENCES equipo (id) ON DELETE CASCADE
);

-- Tabla jugador
CREATE TABLE jugador (
  id SERIAL PRIMARY KEY,
  nombre VARCHAR(50) NOT NULL,
  dorsal INT NOT NULL,
  id_equipo SERIAL NOT NULL,
  FOREIGN KEY (id_equipo) REFERENCES equipo(id) ON DELETE CASCADE,
  CONSTRAINT chk_nombre_jugador CHECK (nombre ~ '^[A-Z]+(\.?[ ]?[A-Z]+)*\.?$'),
  CONSTRAINT chk_dorsal CHECK (dorsal >= 1 AND dorsal <= 99)
);

-- Tabla parches
CREATE TABLE parches (
  id SERIAL PRIMARY KEY,
  parche VARCHAR(150) NOT NULL,
  CONSTRAINT chk_parche CHECK (parche ~ '^(.*/)?[a-zA-Z0-9_-]+\\.(jpg|jpeg|png)$')
);

-- Tabla personalizacion
CREATE TABLE personalizacion (
  id SERIAL PRIMARY KEY,
  num_parches INT NOT NULL,
  id_jugador SERIAL,
  id_parches SERIAL,
  FOREIGN KEY (id_jugador) REFERENCES jugador(id) ON DELETE CASCADE,
  FOREIGN KEY (id_parches) REFERENCES parches(id) ON DELETE CASCADE,
  CONSTRAINT chk_num_parches CHECK (num_parches >= 0 AND num_parches <= 4)
);

CREATE TABLE imagen_camiseta (
  id SERIAL PRIMARY KEY,
  imagen VARCHAR(150) NOT NULL --ruta a la imagen
  CONSTRAINT chk_imagen_camiseta CHECK (imagen ~ '^(.*/)?[a-zA-Z0-9_-]+\\.(jpg|jpeg|png)$')
);

-- Tabla camiseta
CREATE TABLE camiseta (
  id SERIAL PRIMARY KEY,
  temporada VARCHAR(7) NOT NULL,
  categoria VARCHAR(25) NOT NULL,
  talla VARCHAR(10) NOT NULL,
  id_equipo SERIAL NOT NULL,
  id_personalizacion SERIAL,
  id_imagen_camiseta SERIAL,
  FOREIGN KEY (id_equipo) REFERENCES equipo(id) ON DELETE CASCADE,
  FOREIGN KEY (id_personalizacion) REFERENCES personalizacion(id) ON DELETE CASCADE,
  FOREIGN KEY (id_imagen_camiseta) REFERENCES imagen_camiseta(id) ON DELETE CASCADE,
  CONSTRAINT chk_temporada CHECK (temporada ~ '^[0-9]{4}/[0-9]{2}$'),
  CONSTRAINT chk_categoria CHECK (categoria IN ('retro', 'jugador', 'fan', 'conjunto')),
  CONSTRAINT chk_talla CHECK (
    talla IN ('16', '18', '20', '22', '24', '26', '28', 'S', 'M', 'L', 'XL', '2XL', '3XL')
  )
);



-- Tabla distribuidor
CREATE TABLE distribuidor (
  id SERIAL PRIMARY KEY,
  nombre VARCHAR(50) NOT NULL,
  nombre_compania VARCHAR(50) NOT NULL,
  IBAN VARCHAR(34) UNIQUE NOT NULL,
  contacto VARCHAR(50) NOT NULL,
  CONSTRAINT chk_nombre_distribuidor CHECK (nombre ~ '^[A-Z][a-zA-Z ]*$'),
  CONSTRAINT chk_iban CHECK (
    IBAN ~ '^[A-Z]{2}[0-9A-Z]{13,32}$'
  )
);

-- Tabla cliente
CREATE TABLE cliente (
  id SERIAL PRIMARY KEY,
  nombre VARCHAR(100) NOT NULL,
  telefono VARCHAR(15),
  direccion VARCHAR(255),
  CONSTRAINT chk_nombre_cliente CHECK (nombre ~ '^[A-Z][a-zA-Z ]*$'),
  CONSTRAINT chk_telefono CHECK (
    telefono ~ '^\\+?[0-9]{9,15}$'
  )
);

-- Tabla pedido_cliente
CREATE TABLE pedido_cliente (
  id SERIAL PRIMARY KEY,
  id_cliente SERIAL NOT NULL,
  id_camiseta SERIAL NOT NULL,
  FOREIGN KEY (id_cliente) REFERENCES cliente(id) ON DELETE CASCADE,
  FOREIGN KEY (id_camiseta) REFERENCES camiseta(id) ON DELETE CASCADE
);

-- Tabla pedido_distribuidor
CREATE TABLE pedido_distribuidor (
  id SERIAL PRIMARY KEY,
  fecha_pago DATE NOT NULL,
  fecha_llegada DATE,
  id_distribuidor SERIAL NOT NULL,
  id_camiseta SERIAL NOT NULL,
  id_pedido_cliente SERIAL NOT NULL,
  FOREIGN KEY (id_distribuidor) REFERENCES distribuidor(id) ON DELETE CASCADE,
  FOREIGN KEY (id_camiseta) REFERENCES camiseta(id) ON DELETE CASCADE,
  FOREIGN KEY (id_pedido_cliente) REFERENCES pedido_cliente(id) ON DELETE CASCADE,
  CONSTRAINT chk_fecha_pago CHECK (fecha_pago <= CURRENT_DATE),
  CONSTRAINT chk_fecha_llegada CHECK (fecha_llegada IS NULL OR fecha_llegada <= CURRENT_DATE),
  CONSTRAINT chk_fecha_llegada_posterior_pago CHECK (fecha_llegada IS NULL OR fecha_llegada >= fecha_pago)
);

-- Tabla relacion cliente realiza pedido
CREATE TABLE cliente_realiza_pedido (
  id_cliente SERIAL NOT NULL,
  id_pedido_cliente SERIAL NOT NULL,
  fecha_realiza DATE NOT NULL,
  PRIMARY KEY (id_cliente, id_pedido_cliente),
  FOREIGN KEY (id_cliente) REFERENCES cliente(id) ON DELETE CASCADE,
  FOREIGN KEY (id_pedido_cliente) REFERENCES pedido_cliente(id) ON DELETE CASCADE,
  CONSTRAINT chk_fecha_realiza CHECK (fecha_realiza <= CURRENT_DATE)
);

-- Tabla relacion cliente realiza pedido
CREATE TABLE cliente_recibe_pedido (
  id_cliente SERIAL NOT NULL,
  id_pedido_cliente SERIAL NOT NULL,
  fecha_recibe DATE,
  PRIMARY KEY (id_cliente, id_pedido_cliente),
  FOREIGN KEY (id_cliente) REFERENCES cliente(id) ON DELETE CASCADE,
  FOREIGN KEY (id_pedido_cliente) REFERENCES pedido_cliente(id) ON DELETE CASCADE,
  CONSTRAINT chk_fecha_recibe CHECK (fecha_recibe <= CURRENT_DATE)
);

ALTER TABLE camiseta ALTER COLUMN id_personalizacion DROP NOT NULL;
ALTER TABLE camiseta ALTER COLUMN id_imagen_camiseta DROP NOT NULL;
ALTER TABLE personalizacion ALTER COLUMN num_parches DROP NOT NULL;
ALTER TABLE personalizacion ALTER COLUMN id_jugador DROP NOT NULL;
ALTER TABLE personalizacion ALTER COLUMN id_parches DROP NOT NULL;

