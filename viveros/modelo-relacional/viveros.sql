-- Eliminar las tablas si existen para evitar conflictos
DROP TABLE IF EXISTS pedido;
DROP TABLE IF EXISTS cliente;
DROP TABLE IF EXISTS producto;
DROP TABLE IF EXISTS trabaja;
DROP TABLE IF EXISTS empleado;
DROP TABLE IF EXISTS objetivo;
DROP TABLE IF EXISTS zona;
DROP TABLE IF EXISTS empresa;
DROP TABLE IF EXISTS vivero;
DROP TABLE IF EXISTS ubicacion;

-- Tabla ubicacion
CREATE TABLE ubicacion (
  id SERIAL PRIMARY KEY,
  latitud NUMERIC(9, 6) CHECK (latitud >= -90 AND latitud <= 90) UNIQUE,
  longitud NUMERIC(9, 6) CHECK (longitud >= -180 AND longitud <= 180) UNIQUE
);

-- Tabla vivero
CREATE TABLE vivero (
  id SERIAL PRIMARY KEY,
  id_ubicacion SERIAL,
  FOREIGN KEY (id_ubicacion) REFERENCES ubicacion (id) ON DELETE CASCADE
);

-- Tabla empresa
CREATE TABLE empresa (
  nombre VARCHAR(50) PRIMARY KEY,
  id_vivero SERIAL,
  FOREIGN KEY (id_vivero) REFERENCES vivero (id) ON DELETE CASCADE
);

-- Tabla zona
CREATE TABLE zona (
  id SERIAL UNIQUE,
  id_vivero SERIAL,
  id_ubicacion SERIAL,
  FOREIGN KEY (id_vivero) REFERENCES vivero (id) ON DELETE CASCADE,
  FOREIGN KEY (id_ubicacion) REFERENCES ubicacion (id) ON DELETE CASCADE,
  PRIMARY KEY (id, id_vivero)
);

-- Tabla objetivo
CREATE TABLE objetivo (
  id INT PRIMARY KEY,
  descripcion VARCHAR(255) NOT NULL
);

-- Tabla empleado
CREATE TABLE empleado (
  id SERIAL UNIQUE,
  id_objetivo INT DEFAULT 0,
  nombre VARCHAR(50) NOT NULL,
  FOREIGN KEY (id_objetivo) REFERENCES objetivo (id) ON DELETE SET DEFAULT,
  PRIMARY KEY (id, id_objetivo),
  CHECK (nombre ~ '^[A-Za-z ]+$')
);

-- Tabla trabaja
CREATE TABLE trabaja (
  id_zona SERIAL,
  id_empleado SERIAL,
  tarea VARCHAR(100) NOT NULL,
  fecha_inicio DATE NOT NULL,
  fecha_fin DATE,
  FOREIGN KEY (id_zona) REFERENCES zona (id) ON DELETE CASCADE,
  FOREIGN KEY (id_empleado) REFERENCES empleado (id),
  PRIMARY KEY (id_zona, id_empleado),
  CHECK (fecha_inicio <= CURRENT_DATE),
  CHECK (fecha_fin IS NULL OR fecha_fin <= CURRENT_DATE),
  CHECK (fecha_fin IS NULL OR fecha_inicio <= fecha_fin)
);

-- Tabla producto
CREATE TABLE producto (
  id SERIAL PRIMARY KEY,
  id_zona SERIAL,
  nombre VARCHAR(50) NOT NULL,
  stock INTEGER NOT NULL,
  FOREIGN KEY (id_zona) REFERENCES zona (id) ON DELETE CASCADE,
  CHECK (nombre ~ '^[A-Za-z ]+$'),
  CHECK (stock >= 0)
);

-- Tabla cliente
CREATE TABLE cliente (
  id VARCHAR PRIMARY KEY,
  fecha_ingreso DATE NOT NULL,
  num_compras INTEGER DEFAULT 0,
  bonificacion DECIMAL(4, 2) DEFAULT 0.00,
  CHECK (id ~ '^[0-9]{8}[A-Z]$'),
  CHECK (fecha_ingreso <= CURRENT_DATE),
  CHECK (num_compras >= 0),
  CHECK (bonificacion >= 0)
);

-- Tabla pedido
CREATE TABLE pedido (
  id SERIAL PRIMARY KEY,
  id_empleado SERIAL,
  id_producto SERIAL,
  id_cliente VARCHAR,
  fecha DATE NOT NULL,
  FOREIGN KEY (id_empleado) REFERENCES empleado (id) ON DELETE SET DEFAULT,
  FOREIGN KEY (id_producto) REFERENCES producto (id) ON DELETE CASCADE,
  FOREIGN KEY (id_cliente) REFERENCES cliente (id) ON UPDATE CASCADE,
  CHECK (fecha <= CURRENT_DATE)
);
