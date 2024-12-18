# Modelo Relacional Product-E-Match

- **equipo** (`ID`, `nombre`, `escudo`, `equipacion`)

- **seleccion_nacional** (`id_equipo`, `ranking_fifa`)  
  - `id_equipo`: **FOREIGN KEY** `equipo` (`ID`)

- **club** (`id_equipo`, `estadio`, `liga`)  
  - `id_equipo`: **FOREIGN KEY** `equipo` (`ID`)

- **jugador** (`ID`, `nombre`, `dorsal`, `id_equipo`)  
  - `id_equipo`: **FOREIGN KEY** `equipo` (`ID`)

- **personalizacion** (`ID`, `id_parches`, `id_jugador`) //PRECIO ATRIBUTO CALCULADO
  - `id_parches`: **FOREIGN KEY** `parches` (`ID`)  
  - `id_jugador`: **FOREIGN KEY** `jugador` (`ID`)

- **parches** (`ID`, `num_parches`) //PRECIO ATRIBUTO CALCULADO

- **imagen** (`ID`, `ruta`)

- **camiseta** (`ID`, `temporada`, `categoria`, `talla`, `id_equipo`, `id_personalizacion`, `id_imagen`) //STOCK Y PRECIO ATRIBUTOS CALCULADOS
  - `id_equipo`: **FOREIGN KEY** `equipo` (`ID`)  
  - `id_personalizacion`: **FOREIGN KEY** `personalizacion` (`ID`)

- **pedido_distribuidor** (`ID`, `fecha_pago`, `fecha_llegada`, `id_distribuidor`, `id_camiseta`, `id_pedido_cliente`)  //PRECIO Y DURACION ENVIO ATRIBUTOS CALCULADOS
  - `id_distribuidor`: **FOREIGN KEY** `distribuidor` (`ID`)  
  - `id_camiseta`: **FOREIGN KEY** `camiseta` (`ID`)  
  - `id_pedido_cliente`: **FOREIGN KEY** `pedido_cliente` (`ID`)

- **distribuidor** (`ID`, `nombre`, `nombre_compania`, `iban`, `contacto`)

- **pedido_cliente** (`ID`, `id_camiseta`, `id_cliente`) //DURACION ENVIO, PRECIO Y ESTADO ATRIBUTOS CALCULADOS
  - `id_camiseta`: **FOREIGN KEY** `camiseta` (`ID`)  
  - `id_cliente`: **FOREIGN KEY** `cliente` (`ID`)

/////////////////////////////
- **relacion_triple_contiene** (`id_camiseta`, `id_pedido_distribuidor`, `id_pedido_cliente`, `cantidad`)
  - `id_camiseta`: **FOREIGN KEY** `camiseta` (`ID`)
  - `id_pedido_distribuidor`: **FOREIGN KEY** `pedido_distribuidor` (`ID`)
  - `id_pedido_cliente`: **FOREIGN KEY** `pedido_cliente` (`ID`)
////////////////////////////

- **cliente** (`ID`, `nombre`, `telefono`, `direccion`, `id_pedido_cliente`) //DESCUENTO Y NUM COMPRAS ATRIBUTOS CALCULADOS
  - `id_pedido_cliente`: **FOREIGN KEY** `pedido_cliente` (`ID`)

- **cliente_realiza_pedido** (`id_cliente`, `id_pedido_cliente`, `fecha_realiza`)
  - `id_cliente`: **FOREIGN KEY** `cliente` (`ID`)
  - `id_pedido_cliente`: **FOREIGN KEY** `pedido_cliente` (`ID`)

- **cliente_recibe_pedido** (`id_cliente`, `id_pedido_cliente`, `fecha_recibe`)  
  - `id_cliente`: **FOREIGN KEY** `cliente` (`ID`)
  - `id_pedido_cliente`: **FOREIGN KEY** `pedido_cliente` (`ID`)