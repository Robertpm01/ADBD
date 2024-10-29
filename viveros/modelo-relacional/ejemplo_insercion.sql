-- Tabla ubicacion
INSERT INTO ubicacion (id, latitud, longitud) VALUES
(1, 40.416775, -3.703790), 
(2, 34.052235, -118.243683), 
(3, 51.507351, -0.127758),
(4, 35.689487, 139.691711),
(5, -33.868820, 151.209290);

-- Tabla vivero
INSERT INTO vivero (id, id_ubicacion) VALUES (1, 1), (2, 2), (3, 3), (4, 4), (5, 5);

-- Tabla empresa
INSERT INTO empresa (nombre, id_vivero) VALUES
('GreenLife', 1),
('EcoGrow', 2),
('PlantNation', 3),
('UrbanGreens', 4),
('NatureFirst', 5);

-- Tabla zona
INSERT INTO zona (id, id_vivero, id_ubicacion) VALUES
(1, 1, 1), 
(2, 2, 2), 
(3, 3, 3), 
(4, 4, 4), 
(5, 5, 5);

-- Tabla objetivo
INSERT INTO objetivo (id, descripcion) VALUES
(0, 'Sin objetivo'),
(1, 'Cuidado de plantas'), 
(2, 'Investigación de especies'), 
(3, 'Cultivo hidropónico'), 
(4, 'Mantenimiento de invernadero'),
(5, 'Supervisión de operaciones');

-- Tabla empleado
INSERT INTO empleado (id, id_objetivo, nombre) VALUES
(1, 1, 'Carlos Lopez'), 
(2, 2, 'Ana Torres'), 
(3, 3, 'Luis Garcia'), 
(4, 4, 'Maria Perez'),
(5, 5, 'Javier Diaz');

-- Tabla trabaja
INSERT INTO trabaja (id_zona, id_empleado, tarea, fecha_inicio) VALUES
(1, 1, 'Revisar sistemas de riego', '2024-01-15'), 
(2, 2, 'Controlar plagas', '2024-02-20'), 
(3, 3, 'Mejorar iluminación', '2024-03-10'),
(4, 4, 'Capacitar empleados', '2024-04-05'),
(5, 5, 'Monitorear crecimiento', '2024-05-12');

-- Tabla producto
INSERT INTO producto (id, id_zona, nombre, stock) VALUES
(1, 1, 'Rosas', 150), 
(2, 2, 'Tulipanes', 200), 
(3, 3, 'Orquideas', 50),
(4, 4, 'Suculentas', 300),
(5, 5, 'Bonsais', 25);

-- Tabla cliente
INSERT INTO cliente (id, fecha_ingreso, num_compras, bonificacion) VALUES
('12345678A', '2024-01-10', 5, 10.00), 
('23456789B', '2024-02-15', 2, 5.50), 
('34567890C', '2024-03-20', 1, 0.00),
('45678901D', '2024-04-25', 8, 20.00),
('56789012E', '2024-05-30', 10, 30.00);

-- Tabla pedido
INSERT INTO pedido (id, id_empleado, id_producto, id_cliente, fecha) VALUES
(1, 1, 1, '12345678A', '2024-06-05'), 
(2, 2, 2, '23456789B', '2024-06-10'), 
(3, 3, 3, '34567890C', '2024-06-15'),
(4, 4, 4, '45678901D', '2024-06-20'),
(5, 5, 5, '56789012E', '2024-06-25');
