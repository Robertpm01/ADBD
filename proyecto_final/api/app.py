import os
import psycopg2
from flask import Flask, render_template, request, url_for, redirect, jsonify

app = Flask(__name__)


def get_db_connection():
    conn = psycopg2.connect(
        host='localhost',
        database="product-e-match",
        user="postgres",
        password="01082002"
    )
    return conn

# @app.route('/camisetas', methods=['POST'])
# def add_camiseta():
#     data = request.json
#     temporada = data.get('temporada')
#     categoria = data.get('categoria')
#     talla = data.get('talla')
#     nombre_equipo = data.get('nombre_equipo')

#     conn = get_db_connection()
#     cur = conn.cursor()

#     cur.execute(
#         """
#         INSERT INTO camiseta (temporada, categoria, talla, nombre_equipo)
#         VALUES (%s, %s, %s, %s)
#         """,
#         (temporada, categoria, talla, nombre_equipo)
#     )

#     conn.commit()
#     cur.close()
#     conn.close()

#     return jsonify({"message": "Camiseta añadida exitosamente"}), 201

@app.route('/', methods=['GET'])
def get_camisetas():
    conn = get_db_connection()
    cur = conn.cursor()

    # Consulta para obtener los datos
    cur.execute("""
        SELECT c.id, c.temporada, c.categoria, c.talla, e.nombre AS nombre_equipo
        FROM camiseta c
        JOIN equipo e ON c.id_equipo = e.id
    """)
    camisetas = cur.fetchall()

    cur.close()
    conn.close()

    # Construye los datos para la plantilla
    result = []
    for camiseta in camisetas:
        result.append({
            "id": camiseta[0],
            "temporada": camiseta[1],
            "categoria": camiseta[2],
            "talla": camiseta[3],
            "nombre_equipo": camiseta[4]
        })

    # Renderiza la plantilla HTML
    return render_template('camiseta.html', camisetas=result)

@app.route('/nueva', methods=['GET', 'POST'])
def nueva_camiseta():
    if request.method == 'POST':
        # Recoge los datos del formulario
        temporada = request.form.get('temporada')
        categoria = request.form.get('categoria')
        talla = request.form.get('talla')
        nombre_equipo = request.form.get('nombre_equipo')
        num_parches = request.form.get('num_parches')
        imagen_camiseta = request.form.get('imagen_camiseta')

        conn = get_db_connection()
        cur = conn.cursor()

        # Busca el id_equipo correspondiente al nombre del equipo
        cur.execute("SELECT id FROM equipo WHERE nombre = %s", (nombre_equipo,))
        equipo = cur.fetchone()

        if not equipo:
            # Si el equipo no existe, devuelve un error
            cur.close()
            conn.close()
            return jsonify({"error": f"El equipo '{nombre_equipo}' no existe."}), 400

        id_equipo = equipo[0]

        # Inserta la personalización en la tabla personalizacion
        cur.execute(
            """
            INSERT INTO personalizacion (num_parches)
            VALUES (%s) RETURNING id
            """,
            (num_parches,)
        )
        id_personalizacion = cur.fetchone()[0]

        # Inserta la imagen de la camiseta en la tabla imagen_camiseta
        cur.execute(
            """
            INSERT INTO imagen_camiseta (imagen)
            VALUES (%s) RETURNING id
            """,
            (imagen_camiseta,)
        )
        id_imagen_camiseta = cur.fetchone()[0]

        # Inserta la nueva camiseta en la tabla camiseta
        cur.execute(
            """
            INSERT INTO camiseta (temporada, categoria, talla, id_equipo, id_personalizacion, id_imagen_camiseta)
            VALUES (%s, %s, %s, %s, %s, %s)
            """,
            (temporada, categoria, talla, id_equipo, id_personalizacion, id_imagen_camiseta)
        )

        conn.commit()
        cur.close()
        conn.close()

        # Redirige a la página principal
        return redirect(url_for('home'))

    # Si es un método GET, renderiza el formulario
    return render_template('nueva_camiseta.html')

@app.route('/eliminar/<int:camiseta_id>', methods=['POST'])
def eliminar_camiseta(camiseta_id):
    conn = get_db_connection()
    cur = conn.cursor()

    try:
        # Eliminar la camiseta por su ID
        cur.execute("DELETE FROM camiseta WHERE id = %s", (camiseta_id,))
        conn.commit()
        message = f"Camiseta con ID {camiseta_id} eliminada exitosamente."
    except Exception as e:
        conn.rollback()
        message = f"Error al eliminar la camiseta: {str(e)}"
    finally:
        cur.close()
        conn.close()

    return jsonify({"message": message})

@app.route('/editar/<int:camiseta_id>', methods=['GET', 'POST'])
def editar_camiseta(camiseta_id):
    conn = get_db_connection()
    cur = conn.cursor()

    if request.method == 'POST':
        # Recoge los datos del formulario
        temporada = request.form.get('temporada')
        categoria = request.form.get('categoria')
        talla = request.form.get('talla')
        nombre_equipo = request.form.get('nombre_equipo')

        # Buscar el ID del equipo
        cur.execute("SELECT id FROM equipo WHERE nombre = %s", (nombre_equipo,))
        equipo = cur.fetchone()

        if not equipo:
            cur.close()
            conn.close()
            return jsonify({"error": f"El equipo '{nombre_equipo}' no existe"}), 400

        id_equipo = equipo[0]

        # Actualizar la camiseta
        cur.execute(
            """
            UPDATE camiseta
            SET temporada = %s, categoria = %s, talla = %s, id_equipo = %s
            WHERE id = %s
            """,
            (temporada, categoria, talla, id_equipo, camiseta_id)
        )
        conn.commit()
        cur.close()
        conn.close()
        return redirect(url_for('get_camisetas'))

    # Si es GET, obtener los datos actuales de la camiseta
    cur.execute(
        """
        SELECT c.temporada, c.categoria, c.talla, e.nombre AS equipo
        FROM camiseta c
        JOIN equipo e ON c.id_equipo = e.id
        WHERE c.id = %s
        """,
        (camiseta_id,)
    )
    camiseta = cur.fetchone()
    cur.close()
    conn.close()

    if not camiseta:
        return jsonify({"error": "Camiseta no encontrada"}), 404

    return render_template('editar_camiseta.html', camiseta={
        "id": camiseta_id,
        "temporada": camiseta[0],
        "categoria": camiseta[1],
        "talla": camiseta[2],
        "equipo": camiseta[3]
    })


if __name__ == '__main__':
    app.run(debug=True)
