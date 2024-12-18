-- Eliminar las tablas si existen para evitar conflictos
DROP TABLE IF EXISTS seleccion_nacional;
DROP TABLE IF EXISTS club;
DROP TABLE IF EXISTS equipo;
DROP TABLE IF EXISTS jugador;
DROP TABLE IF EXISTS personalizacion;
DROP TABLE IF EXISTS parches;
DROP TABLE IF EXISTS imagenes_camiseta;
DROP TABLE IF EXISTS camiseta;
DROP TABLE IF EXISTS pedido_distribuidor;
DROP TABLE IF EXISTS distribuidor;
DROP TABLE IF EXISTS pedido_cliente;
DROP TABLE IF EXISTS cliente;
DROP TABLE IF EXISTS cliente_realiza_pedido;
DROP TABLE IF EXISTS cliente_recibe_pedido;

-- Tabla equipo
CREATE TABLE equipo (
  nombre VARCHAR(50) PRIMARY KEY,
  escudo VARCHAR(150) UNIQUE, --ruta a la imagen
  CONSTRAINT chk_ruta_imagen CHECK (
    escudo LIKE '%.png' OR
    escudo LIKE '%.jpg' OR
    escudo LIKE '%.jpeg'
  )
);

-- Tabla seleccion_nacional
CREATE TABLE seleccion_nacional (
  id SERIAL PRIMARY KEY,
  ranking_fifa INT NOT NULL,
  id_equipo SERIAL NOT NULL,
  FOREIGN KEY (id_equipo) REFERENCES equipo (id) ON DELETE CASCADE,
  CONSTRAINT chk_ranking_fifa CHECK (ranking_fifa >= 1 AND ranking_fifa <= 210)
);

-- Tabla club
CREATE TABLE club (
  id SERIAL PRIMARY KEY,
  estadio VARCHAR(50),
  liga VARCHAR(50) NOT NULL,
  id_equipo SERIAL NOT NULL,
  FOREIGN KEY (id_equipo) REFERENCES equipo (id) ON DELETE CASCADE
);

-- Tabla jugador
CREATE TABLE jugador (
  nombre VARCHAR(50) NOT NULL,
  dorsal INT NOT NULL,
  id_equipo SERIAL NOT NULL,
  PRIMARY KEY (nombre, dorsal),
  FOREIGN KEY (id_equipo) REFERENCES equipo(id),
  CONSTRAINT chk_dorsal CHECK (dorsal >= 1 AND dorsal <= 99)
);

-- Tabla parches
CREATE TABLE parches (
  id SERIAL PRIMARY KEY,
  num_parches INT NOT NULL,
  CONSTRAINT chk_ruta_imagen CHECK (num_parches >= 0 AND num_parches <= 4)
);

-- Tabla personalizacion
CREATE TABLE personalizacion (
  id SERIAL PRIMARY KEY,
  nombre VARCHAR(50),
  dorsal INT,
  precio DECIMAL(3, 2) NOT NULL,
  id_jugador SERIAL NOT NULL,
  id_parches SERIAL NOT NULL,
  FOREIGN KEY (id_jugador) REFERENCES jugador(id) ON DELETE SET NULL,
  FOREIGN KEY (id_parches) REFERENCES parches(id)
);

CREATE TABLE imagenes_camiseta (
  id SERIAL PRIMARY KEY,
  imagen VARCHAR(150) NOT NULL --ruta a la imagen
);

-- Tabla camiseta
CREATE TABLE camiseta (
  id SERIAL PRIMARY KEY,
  categoria VARCHAR(25),
  talla VARCHAR(10),
  temporada VARCHAR(10) NOT NULL,
  equipacion VARCHAR(25) NOT NULL,
  id_equipo SERIAL NOT NULL,
  id_personalizacion SERIAL NOT NULL,
  id_imagenes_camiseta SERIAL,
  FOREIGN KEY (id_equipo) REFERENCES equipo(id),
  FOREIGN KEY (id_personalizacion) REFERENCES personalizacion(id),
  FOREIGN KEY (id_imagenes_camiseta) REFERENCES imagenes_camiseta(id),
  CONSTRAINT chk_talla CHECK (
    talla IN ('16', '18', '20', '22', '24', '26', '28', 'S', 'M', 'L', 'XL', '2XL', '3XL')
  ),
  CONSTRAINT chk_stock CHECK (stock >= 0)
);

-- Tabla distribuidor
CREATE TABLE distribuidor (
  id SERIAL PRIMARY KEY,
  nombre VARCHAR(50) NOT NULL,
  nombre_compania VARCHAR(50) NOT NULL,
  IBAN VARCHAR(34) UNIQUE NOT NULL,
  contacto VARCHAR(50) NOT NULL,
  CONSTRAINT chk_iban CHECK (
    IBAN ~ '^[A-Z]{2}[0-9A-Z]{13,32}$'
  )
);

-- Tabla cliente
CREATE TABLE cliente (
  id SERIAL PRIMARY KEY,
  nombre VARCHAR(100) NOT NULL,
  direccion VARCHAR(255),
  email VARCHAR(100) UNIQUE,
  telefono VARCHAR(15),
  descuento INT DEFAULT 0,
  num_compras INT DEFAULT 0,
  CONSTRAINT chk_email CHECK (
    email ~ '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$'
  ),
  CONSTRAINT chk_telefono CHECK (
    telefono ~ '^\\+?[0-9]{9,15}$'
  ),
  CONSTRAINT chk_descuento CHECK (descuento >= 0 AND descuento <= 100)
);

-- Tabla pedido_cliente
CREATE TABLE pedido_cliente (
  id SERIAL PRIMARY KEY,
  id_cliente SERIAL NOT NULL,
  id_camiseta SERIAL NOT NULL,
  FOREIGN KEY (id_cliente) REFERENCES cliente(id),
  FOREIGN KEY (id_camiseta) REFERENCES camiseta(id)
);

-- Tabla pedido_distribuidor
CREATE TABLE pedido_distribuidor (
  id SERIAL PRIMARY KEY,
  fecha_pago DATE NOT NULL,
  fecha_llegada DATE,
  id_distribuidor SERIAL NOT NULL,
  id_camiseta SERIAL NOT NULL,
  id_pedido_cliente SERIAL NOT NULL,
  FOREIGN KEY (id_distribuidor) REFERENCES distribuidor(id),
  FOREIGN KEY (id_camiseta) REFERENCES camiseta(id),
  FOREIGN KEY (id_pedido_cliente) REFERENCES pedido_cliente(id),
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
  FOREIGN KEY (id_cliente) REFERENCES cliente(id),
  FOREIGN KEY (id_pedido_cliente) REFERENCES pedido_cliente(id),
  CONSTRAINT chk_fecha_realiza CHECK (fecha_realiza <= CURRENT_DATE)
);

-- Tabla relacion cliente realiza pedido
CREATE TABLE cliente_recibe_pedido (
  id_cliente SERIAL NOT NULL,
  id_pedido_cliente SERIAL NOT NULL,
  fecha_recibe DATE,
  PRIMARY KEY (id_cliente, id_pedido_cliente),
  FOREIGN KEY (id_cliente) REFERENCES cliente(id),
  FOREIGN KEY (id_pedido_cliente) REFERENCES pedido_cliente(id),
  CONSTRAINT chk_fecha_recibe CHECK (fecha_recibe <= CURRENT_DATE)
);
