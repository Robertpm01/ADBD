# Proyecto de Base de Datos: Blockbuster

## Descripción
Los principales objetivos de esta práctica son los siguientes:
- Aplicar tecnologías de monitorización de sistemas de bases de datos para favorecer la gestión y eficiencia de estos sistemas.

## Actividades

### Paso 1: Instalar Prometheus
1. Instalamos Prometheus en nuestro sistema operativo (En este caso MacOs) introduciendo el siguiente comando en la terminal:  
`wget https://github.com/prometheus/prometheus/releases/download/v2.34.0/prometheus-2.34.0.darwin-amd64.tar.gz`

2. Extraemos el archivo descargado y movemos la carpeta a un directorio de nuestra elección, como /usr/local/bin/:
`tar -xvf prometheus-*.tar.gz`  
`sudo mv prometheus-*/ /usr/local/bin/prometheus`

3. Configuramos Prometheus:

- Creamos un archivo `prometheus.yml` en `/usr/local/bin/prometheus/` con el siguiente contenido:

- Ejecutamos Prometheus:
Accedemos al directorio de Prometheus y lo ejecutamos:
`cd /usr/local/bin/prometheus`  
`./prometheus --config.file=prometheus.yml`