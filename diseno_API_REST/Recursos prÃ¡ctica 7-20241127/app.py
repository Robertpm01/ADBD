import os
import psycopg2
from flask import Flask, render_template, request, url_for, redirect, jsonify

app = Flask(__name__)

def get_db_connection():
    conn = psycopg2.connect(host='localhost',
        	database="flask_db",
        # user=os.environ['DB_USERNAME'],
		user="postgres",
		# password=os.environ['DB_PASSWORD']
        password="01082002")
    return conn

def get_myhome_db_connection():
    return psycopg2.connect(
        host="localhost",
        database="myhome",
        user="postgres",
        password="01082002"
    )

@app.route('/')
def index():
    try:
        # Establecer conexión con la base de datos
        conn = get_db_connection()
        cur = conn.cursor()

        # Ejecutar consulta para obtener todos los registros de la tabla books
        cur.execute('SELECT * FROM books;')
        books = cur.fetchall()

        # Cerrar cursor y conexión
        cur.close()
        conn.close()

        # Renderizar la plantilla index.html con los registros
        return render_template('index.html', books=books)

    except psycopg2.Error as e:
        # En caso de error, imprimir el mensaje y mostrar página de error
        print(f"Error al consultar la base de datos: {e}")
        return render_template('error.html', message="Error al visualizar los registros. Inténtelo más tarde.")

    except Exception as e:
        # Capturar cualquier otro error y mostrar un mensaje genérico
        print(f"Error inesperado: {e}")
        return render_template('error.html', message="Ha ocurrido un error inesperado.")


@app.route('/create/', methods=('GET', 'POST'))
def create():
    if request.method == 'POST':
        try:
            # Obtener datos del formulario
            title = request.form['title']
            author = request.form['author']
            pages_num = int(request.form['pages_num'])
            review = request.form['review']

            # Conectar a la base de datos
            conn = get_db_connection()
            cur = conn.cursor()

            # Insertar registro en la tabla books
            cur.execute('INSERT INTO books (title, author, pages_num, review) VALUES (%s, %s, %s, %s)',
                        (title, author, pages_num, review))

            # Confirmar cambios
            conn.commit()

            # Cerrar cursor y conexión
            cur.close()
            conn.close()

            # Redirigir a la página principal
            return redirect(url_for('index'))

        except psycopg2.Error as e:
            # Manejar errores específicos de PostgreSQL
            print(f"Error al insertar el registro en la base de datos: {e}")
            return render_template('error.html', message="Error al insertar el registro. Por favor, inténtelo más tarde.")

        except ValueError as e:
            # Manejar errores en la conversión de datos
            print(f"Error en los datos del formulario: {e}")
            return render_template('error.html', message="Error en los datos proporcionados. Asegúrese de que los campos sean válidos.")

        except Exception as e:
            # Capturar cualquier otro error inesperado
            print(f"Error inesperado: {e}")
            return render_template('error.html', message="Ha ocurrido un error inesperado.")

    # Renderizar la página de creación de registros
    return render_template('create.html')

@app.route('/delete/<int:id>/', methods=['POST'])
def delete(id):
    try:
        # Conexión a la base de datos
        conn = get_db_connection()
        cur = conn.cursor()

        # Verificar si el registro existe
        cur.execute('SELECT * FROM books WHERE id = %s', (id,))
        book = cur.fetchone()
        if book is None:
            return render_template('error.html', message="El registro no existe.")

        # Eliminar el registro
        cur.execute('DELETE FROM books WHERE id = %s', (id,))
        conn.commit()

        # Cerrar conexión
        cur.close()
        conn.close()

        # Redirigir a la página principal después de eliminar
        return redirect(url_for('index'))

    except psycopg2.Error as e:
        # Manejar errores relacionados con la base de datos
        print(f"Error al eliminar el registro: {e}")
        return render_template('error.html', message="Error al eliminar el registro. Por favor, inténtelo más tarde.")

    except Exception as e:
        # Capturar otros errores
        print(f"Error inesperado: {e}")
        return render_template('error.html', message="Ha ocurrido un error inesperado.")

@app.route('/update/<int:id>/', methods=('GET', 'POST'))
def update(id):
    try:
        # Conexión a la base de datos
        conn = get_db_connection()
        cur = conn.cursor()

        # Obtener el registro actual para prellenar el formulario
        cur.execute('SELECT * FROM books WHERE id = %s', (id,))
        book = cur.fetchone()
        if book is None:
            return render_template('error.html', message="El registro no existe.")

        if request.method == 'POST':
            # Obtener datos actualizados del formulario
            title = request.form['title']
            author = request.form['author']
            pages_num = int(request.form['pages_num'])
            review = request.form['review']

            # Actualizar el registro en la base de datos
            cur.execute('''
                UPDATE books
                SET title = %s, author = %s, pages_num = %s, review = %s
                WHERE id = %s
            ''', (title, author, pages_num, review, id))
            conn.commit()

            # Cerrar cursor y conexión
            cur.close()
            conn.close()

            # Redirigir a la página principal
            return redirect(url_for('index'))

        # Cerrar cursor y conexión
        cur.close()
        conn.close()

        # Renderizar el formulario con los datos actuales
        return render_template('update.html', book=book)

    except psycopg2.Error as e:
        print(f"Error al actualizar el registro: {e}")
        return render_template('error.html', message="Error al actualizar el registro. Por favor, inténtelo más tarde.")
    except Exception as e:
        print(f"Error inesperado: {e}")
        return render_template('error.html', message="Ha ocurrido un error inesperado.")




@app.route('/about/')
def about():
    return render_template('about.html')

########## RUTAS MYHOME BASE DE DATOS ##########

@app.route('/average_temperature', methods=['GET'])
def average_temperature():
    try:
        # Conexión a la base de datos
        conn = get_myhome_db_connection()
        cur = conn.cursor()

        # Consulta SQL para calcular la temperatura media
        cur.execute('SELECT AVG(temperature) FROM public.temperatures;')
        avg_temp = cur.fetchone()[0]  # Obtener el resultado de la consulta

        # Cerrar la conexión
        cur.close()
        conn.close()

        # Retornar la temperatura media en formato JSON
        return jsonify({"average_temperature": avg_temp})

    except Exception as e:
        # Manejo de errores
        return jsonify({"error": str(e)}), 500

@app.route('/max_temperature', methods=['GET'])
def max_temperature():
    try:
        # Conexión a la base de datos myhome
        conn = get_myhome_db_connection()
        cur = conn.cursor()

        # Consulta SQL para obtener la temperatura máxima
        cur.execute('SELECT MAX(temperature) FROM public.temperatures;')
        max_temp = cur.fetchone()[0]  # Obtener el resultado de la consulta

        # Cerrar la conexión
        cur.close()
        conn.close()

        # Retornar la temperatura máxima en formato JSON
        return jsonify({"max_temperature": max_temp})

    except Exception as e:
        # Manejo de errores
        print(f"Error: {e}")
        return jsonify({"error": "An error occurred while retrieving the maximum temperature."}), 500

@app.route('/room_name/<int:room_id>', methods=['GET'])
def room_name(room_id):
    try:
        # Conexión a la base de datos myhome
        conn = get_myhome_db_connection()
        cur = conn.cursor()

        # Consulta SQL para obtener el nombre de la habitación
        cur.execute('SELECT name FROM public.rooms WHERE id = %s;', (room_id,))
        room = cur.fetchone()

        # Cerrar la conexión
        cur.close()
        conn.close()

        # Si no se encuentra la habitación, devolver un error 404
        if room is None:
            return jsonify({"error": f"Room with id {room_id} not found"}), 404

        # Retornar el nombre de la habitación en formato JSON
        return jsonify({"room_id": room_id, "room_name": room[0]})

    except Exception as e:
        # Manejo de errores
        print(f"Error: {e}")
        return jsonify({"error": "An error occurred while retrieving the room name."}), 500

@app.route('/average_temperature/<int:room_id>', methods=['GET'])
def room_average_temperature(room_id):
    try:
        # Conexión a la base de datos myhome
        conn = get_myhome_db_connection()
        cur = conn.cursor()

        # Consulta SQL para calcular la temperatura media de la habitación
        cur.execute('SELECT AVG(temperature) FROM public.temperatures WHERE room_id = %s;', (room_id,))
        avg_temp = cur.fetchone()[0]  # Obtener el resultado de la consulta

        # Cerrar la conexión
        cur.close()
        conn.close()

        # Si no hay registros para el room_id, retornar un mensaje adecuado
        if avg_temp is None:
            return jsonify({"error": f"No data found for room_id {room_id}"}), 404

        # Retornar la temperatura media histórica en formato JSON
        return jsonify({"room_id": room_id, "average_temperature": avg_temp})

    except Exception as e:
        # Manejo de errores
        print(f"Error: {e}")
        return jsonify({"error": "An error occurred while calculating the average temperature."}), 500

@app.route('/room_min_temperature/<int:room_id>', methods=['GET'])
def room_min_temperature(room_id):
    try:
        # Conexión a la base de datos myhome
        conn = get_myhome_db_connection()
        cur = conn.cursor()

        # Consulta SQL para obtener la temperatura mínima y el nombre de la habitación
        cur.execute('''
            SELECT MIN(temperatures.temperature), rooms.name
            FROM public.temperatures
            JOIN public.rooms ON temperatures.room_id = rooms.id
            WHERE rooms.id = %s
            GROUP BY rooms.name;
        ''', (room_id,))
        result = cur.fetchone()

        # Cerrar la conexión
        cur.close()
        conn.close()

        # Si no se encuentra el room_id, retornar un error 404
        if result is None:
            return jsonify({"error": f"No data found for room_id {room_id}"}), 404

        # Retornar la temperatura mínima y el nombre de la habitación en formato JSON
        return jsonify({"room_id": room_id, "room_name": result[1], "min_temperature": result[0]})

    except Exception as e:
        # Manejo de errores
        print(f"Error: {e}")
        return jsonify({"error": "An error occurred while retrieving the minimum temperature and room name."}), 500

