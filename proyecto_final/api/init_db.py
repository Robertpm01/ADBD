import psycopg2

# Configuración de conexión
try:
    # Conectarse a la base de datos
    conn = psycopg2.connect(
        host="localhost",
        database="product-e-match",
        user="postgres",  # Cambia si usas otro usuario
        password="01082002"  # Cambia si usas otra contraseña
    )
    conn.autocommit = True  # Permitir transacciones automáticas

    # Crear un cursor para ejecutar comandos
    cur = conn.cursor()

    # Leer el archivo SQL
    with open("product-e-match.sql", "r") as file:
        sql_script = file.read()

    # Ejecutar el script SQL
    cur.execute(sql_script)
    print("Base de datos inicializada con éxito y script ejecutado.")

    # Cerrar el cursor y la conexión
    cur.close()
    conn.close()

except Exception as e:
    print(f"Ocurrió un error: {e}")
