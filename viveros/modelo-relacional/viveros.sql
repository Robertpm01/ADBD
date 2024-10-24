CREATE TABLE ubicacion (
  id SERIAL PRIMARY KEY,
  latitud NUMERIC(9, 6) CHECK (latitud >= -90 AND latitud <= 90),
  longitud NUMERIC(9, 6) CHECK (longitud >= -180 AND longitud <= 180)
);

CREATE TABLE vivero (
  id serial PRIMARY KEY,
  id_ubicacion serial,
  FOREIGN KEY (id_ubicacion) REFERENCES ubicacion (id)
);

CREATE TABLE empresa (
  nombre VARCHAR (50) PRIMARY KEY,
  id_vivero serial,
  FOREIGN KEY (id_vivero) REFERENCES vivero (id)
);

CREATE TABLE zona (
  id serial,
  id_vivero serial,
  id_ubicacion serial,
  FOREIGN KEY (id_vivero) REFERENCES vivero (id),
  FOREIGN KEY (id_ubicacion) REFERENCES ubicacion (id),
  PRIMARY KEY (id, id_vivero)
);

CREATE TABLE objetivo (
  id SERIAL PRIMARY KEY,
  descripcion VARCHAR(255) NOT NULL
);

CREATE TABLE empleado (
  id SERIAL,
  id_objetivo serial,
  nombre VARCHAR(50) NOT NULL,
  FOREIGN KEY (id_objetivo) REFERENCES objetivo (id),
  PRIMARY KEY (id, id_objetivo),
  CHECK (nombre ~ '^[A-Za-z ]+$')
);

CREATE TABLE trabaja (
  id_zona serial,
  id_empleado serial,
  tarea VARCHAR(100) NOT NULL,
  fecha_inicio DATE NOT NULL,
  fecha_fin DATE,
  FOREIGN KEY (id_zona) REFERENCES zona (id),
  FOREIGN KEY (id_empleado) REFERENCES empleado (id),
  PRIMARY KEY (id_zona, id_empleado),
  CHECK (fecha_inicio <= CURRENT_DATE),
  CHECK (fecha_fin IS NULL OR fecha_fin <= CURRENT_DATE),
  CHECK (fecha_fin IS NULL OR fecha_inicio <= fecha_fin)
);

CREATE TABLE producto (
  ID SERIAL PRIMARY KEY,
  id_zona serial,
  nombre VARCHAR(50) NOT NULL,
  stock INTEGER NOT NULL,
  FOREIGN KEY (id_zona) REFERENCES zona (id),
  CHECK (nombre ~ '^[A-Za-z ]+$'),
  CHECK (stock >= 0)
);

CREATE TABLE cliente (
  id SERIAL PRIMARY KEY,
  fecha_ingreso DATE NOT NULL,
  num_compras INTEGER DEFAULT 0,
  bonificacion DECIMAL(4, 2) DEFAULT 0.00,
  CHECK (fecha_ingreso <= CURRENT_DATE),
  CHECK (num_compras >= 0),
  CHECK (bonificacion >= 0)
);

CREATE TABLE pedido (
  id SERIAL PRIMARY KEY,
  id_empleado SERIAL,
  id_producto SERIAL,
  id_cliente SERIAL,
  fecha DATE NOT NULL,
  FOREIGN KEY (id_empleado) REFERENCES empleado (id),
  FOREIGN KEY (id_producto) REFERENCES producto (id),
  FOREIGN KEY (id_cliente) REFERENCES cliente (id),
  CHECK (fecha <= CURRENT_DATE)
);

