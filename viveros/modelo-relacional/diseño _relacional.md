# Modelo Relacional

- **UBICACION** (`ID`, `latitud`, `longitud`)

- **VIVERO** (`ID`, `id_ubicacion`)
  - `id_ubicacion`: **FOREIGN KEY** `UBICACION` (`ID`)

- **EMPRESA** (`NOMBRE`, `id_vivero`)
  - `id_vivero`: **FOREIGN KEY** `VIVERO` (`ID`)

- **ZONA** (`ID`, `ID_VIVERO`, `id_ubicacion`)
  - `id_vivero`: **FOREIGN KEY** `VIVERO` (`ID`)
  - `id_ubicacion`: **FOREIGN KEY** `UBICACION` (`ID`)

- **OBJETIVO** (`ID`, `descripcion`)

- **EMPLEADO** (`ID`, `id_objetivo`, `nombre`)
  - `id_objetivo`: **FOREIGN KEY** `OBJETIVO` (`ID`)

- **TRABAJA** (`ID_ZONA`, `ID_EMPLEADO`, `tarea`, `fecha_inicio`, `fecha_fin`)
  - `ID_ZONA`: **FOREIGN KEY** `ZONA` (`ID`)
  - `ID_EMPLEADO`: **FOREIGN KEY** `EMPLEADO` (`ID`)

- **PRODUCTO** (`ID`, `id_zona`, `nombre`, `stock`)
  - `id_zona`: **FOREIGN KEY** `ZONA` (`ID`)

- **CLIENTE** (`ID`, `fecha_ingreso`, `num_compras`, `bonificacion`)

- **PEDIDO** (`ID`, `id_empleado`, `id_producto`, `id_cliente`, `fecha`)
  - `id_empleado`: **FOREIGN KEY** `EMPLEADO` (`ID`)
  - `id_producto`: **FOREIGN KEY** `PRODUCTO` (`ID`)
  - `id_cliente`: **FOREIGN KEY** `CLIENTE` (`ID`)

- **UBICACION** (`ID`, `latitud`, `longitud`)

- **VIVERO** (`ID`, `id_ubicacion`)
  - `id_ubicacion`: **FOREIGN KEY** `UBICACION` (`ID`)

- **EMPRESA** (`NOMBRE`, `id_vivero`)
  - `id_vivero`: **FOREIGN KEY** `VIVERO` (`ID`)

- **ZONA** (`ID`, `ID_VIVERO`, `id_ubicacion`)
  - `id_vivero`: **FOREIGN KEY** `VIVERO` (`ID`)
  - `id_ubicacion`: **FOREIGN KEY** `UBICACION` (`ID`)

- **OBJETIVO** (`ID`, `descripcion`)

- **EMPLEADO** (`ID`, `id_objetivo`, `nombre`)
  - `id_objetivo`: **FOREIGN KEY** `OBJETIVO` (`ID`)

- **TRABAJA** (`ID_ZONA`, `ID_EMPLEADO`, `tarea`, `fecha_inicio`, `fecha_fin`)
  - `ID_ZONA`: **FOREIGN KEY** `ZONA` (`ID`)
  - `ID_EMPLEADO`: **FOREIGN KEY** `EMPLEADO` (`ID`)

- **PRODUCTO** (`ID`, `id_zona`, `nombre`, `stock`)
  - `id_zona`: **FOREIGN KEY** `ZONA` (`ID`)

- **CLIENTE** (`ID`, `fecha_ingreso`, `num_compras`, `bonificacion`)

- **PEDIDO** (`ID`, `id_empleado`, `id_producto`, `id_cliente`, `fecha`)
  - `id_empleado`: **FOREIGN KEY** `EMPLEADO` (`ID`)
  - `id_producto`: **FOREIGN KEY** `PRODUCTO` (`ID`)
  - `id_cliente`: **FOREIGN KEY** `CLIENTE` (`ID`)



