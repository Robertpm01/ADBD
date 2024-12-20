# Modelo Relacional Product-E-Match

- **equipo** (`NOMBRE`, `escudo`, `equipacion`)

- **seleccion_nacional** (`nombre_equipo`, `ranking_fifa`)  
  - `nombre_equipo`: **FOREIGN KEY** `equipo` (`NOMBRE`)

- **club** (`nombre_equipo`, `estadio`, `liga`)  
  - `nombre_equipo`: **FOREIGN KEY** `equipo` (`NOMBRE`)

- **jugador** (`ID`, `nombre`, `dorsal`, `nombre_equipo`)  
  - `nombre_equipo`: **FOREIGN KEY** `equipo` (`NOMBRE`)

- **parches** (`ID`, `parche`)

- **personalizacion** (`ID`, `num_parches`, `id_parches`, `id_jugador`) //PRECIO ATRIBUTO CALCULADO
  - `id_parches`: **FOREIGN KEY** `parches` (`ID`)  
  - `id_jugador`: **FOREIGN KEY** `jugador` (`ID`)

- **imagen_camiseta** (`ID`, `ruta`)

- **camiseta** (`ID`, `temporada`, `categoria`, `talla`, `nombre_equipo`, `id_personalizacion`, `id_imagen`) //STOCK Y PRECIO ATRIBUTOS CALCULADOS
  - `nombre_equipo`: **FOREIGN KEY** `equipo` (`NOMBRE`)  
  - `id_personalizacion`: **FOREIGN KEY** `personalizacion` (`ID`)
  - `id_imagen`: **FOREIGN KEY** `imagen_camiseta` (`ID`)

- **distribuidor** (`ID`, `nombre`, `nombre_compania`, `iban`, `contacto`)

- **cliente** (`ID`, `nombre`, `telefono`, `direccion`) //DESCUENTO Y NUM COMPRAS ATRIBUTOS CALCULADOS

- **pedido_cliente** (`ID`, `id_camiseta`, `id_cliente`) //DURACION ENVIO, PRECIO Y ESTADO ATRIBUTOS CALCULADOS
  - `id_camiseta`: **FOREIGN KEY** `camiseta` (`ID`)  
  - `id_cliente`: **FOREIGN KEY** `cliente` (`ID`)

- **pedido_distribuidor** (`ID`, `fecha_pago`, `fecha_llegada`, `id_distribuidor`, `id_camiseta`, `id_pedido_cliente`)  //PRECIO Y DURACION ENVIO ATRIBUTOS CALCULADOS
  - `id_distribuidor`: **FOREIGN KEY** `distribuidor` (`ID`)  
  - `id_camiseta`: **FOREIGN KEY** `camiseta` (`ID`)  
  - `id_pedido_cliente`: **FOREIGN KEY** `pedido_cliente` (`ID`)

- **cliente_realiza_pedido** (`id_cliente`, `id_pedido_cliente`, `fecha_realiza`)
  - `id_cliente`: **FOREIGN KEY** `cliente` (`ID`)
  - `id_pedido_cliente`: **FOREIGN KEY** `pedido_cliente` (`ID`)

- **cliente_recibe_pedido** (`id_cliente`, `id_pedido_cliente`, `fecha_envia`)  
  - `id_cliente`: **FOREIGN KEY** `cliente` (`ID`)
  - `id_pedido_cliente`: **FOREIGN KEY** `pedido_cliente` (`ID`)