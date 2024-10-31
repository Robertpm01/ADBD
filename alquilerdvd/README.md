# Proyecto de Base de Datos: Blockbuster

## Descripción
Blockbuster LLC, conocida como Blockbuster Video, fue una franquicia estadounidense de videoclubes, especializada en alquiler de películas y videojuegos a través de tiendas físicas, servicios por correo y vídeo bajo demanda. Fue una de las precursoras de plataformas como la actual Netflix. Su modelo de negocios se basaba en el alquiler de DVD de juegos y películas.
Sobre el escenario descrito anteriormente, en esta práctica trabajaremos como una base de datos que típicamente se podría encontrar en un establecimiento en el que los clientes están registrados y pueden alquilar películas con un tiempo máximo de alquiler y su histórico de alquileres. Además, se incluyen datos sobre las películas disponibles, los empleados y las tiendas.

## Actividades

Realice las siguientes actividades con la ayuda de psql y el PL/pgSQL:
### 1. Realice la restauración de la base de datos alquilerdvd.tar. Observe que la base de datos no tiene un formato SQL como el empleado en actividades anteriores.
Esta guía explica cómo restaurar una base de datos en PostgreSQL usando un archivo de respaldo en formato `.tar` (por ejemplo, `alquilerdvd.tar`).
#### Pasos a Seguir:
1. Crear una base de datos vacía  
Antes de realizar la restauración, asegúrate de tener una base de datos vacía en la que puedas importar el archivo de respaldo.  
Ejecuta el siguiente comando en la terminal, reemplazando `<nombre_base_datos>` por el nombre de la base de datos que quieres crear (por ejemplo, `alquilerdvd`): `createdb <nombre_base_datos>`
2. Restaurar el Archivo .tar en la Base de Datos
Usa el comando pg_restore para restaurar el archivo .tar en la base de datos creada:  
`pg_restore -d <nombre_base_datos> -U <usuario> -h localhost -p 5432 -c alquilerdvd.tar`  
  -d <nombre_base_datos>: Especifica el nombre de la base de datos de destino.  
  -U <usuario>: Especifica el usuario de PostgreSQL.  
  -h localhost: Indica el host (localhost en este caso).  
  -p 5432: Especifica el puerto, que generalmente es 5432.  
  -c: Elimina los objetos existentes antes de restaurarlos (opcional, si quieres sobrescribir la estructura actual).

### 2. Identifique las tablas, vistas y secuencias.
### 3. Identifique las tablas principales y sus principales elementos.
### 4. Realice las siguientes consultas.
  - #### Obtenga las ventas totales por categoría de películas ordenadas descendentemente.
  - #### Obtenga las ventas totales por tienda, donde se refleje la ciudad, el país (concatenar la ciudad y el país empleando como separador la “,”), y el encargado. Pudiera emplear GROUP BY, ORDER BY
  - #### Obtenga una lista de películas, donde se reflejen el identificador, el título, descripción, categoría, el precio, la duración de la película, clasificación, nombre y apellidos de los actores (puede realizar una concatenación de ambos). Pudiera emplear GROUP BY
  - #### Obtenga la información de los actores, donde se incluya sus nombres y apellidos, las categorías y sus películas. Los actores deben de estar agrupados y, las categorías y las películas deben estar concatenados por “:” 
### 5. Realice todas las vistas de las consultas anteriores. Colóqueles el prefijo view_ a su denominación.
### 6. Haga un análisis del modelo e incluya las restricciones CHECK que considere necesarias.
### 7. Explique la sentencia que aparece en la tabla customer 
    Triggers:  
    last_updated BEFORE UPDATE ON customer  
    FOR EACH ROW EXECUTE PROCEDURE last_updated()  
    Identifique alguna tabla donde se utilice una solución similar.  
### 8. Construya un disparador que guarde en una nueva tabla creada por usted la fecha de cuando se insertó un nuevo registro en la tabla film. 
### 9. Construya un disparador que guarde en una nueva tabla creada por usted la fecha de cuando se eliminó un registro en la tabla film y el identificador del film. 
### 10.  Comente el significado y la relevancia de las secuencias.
