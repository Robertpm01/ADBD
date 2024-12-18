import psycopg2

# Configuración de conexión
conn = psycopg2.connect(
    host="localhost",
    database="flask_db",
    user="postgres",   # Cambia si usas otro usuario
    password="01082002"  # Cambia si usas otra contraseña
)

# Crear un cursor para realizar operaciones
cur = conn.cursor()

# Eliminar la tabla si ya existe y crearla de nuevo
cur.execute('DROP TABLE IF EXISTS books;')
cur.execute('CREATE TABLE books (id serial PRIMARY KEY,'
                                 'title varchar (150) NOT NULL,'
                                 'author varchar (50) NOT NULL,'
                                 'pages_num integer NOT NULL,'
                                 'review text,'
                                 'date_added date DEFAULT CURRENT_TIMESTAMP);'
                                 )

# Insertar datos en la tabla
cur.execute('INSERT INTO books (title, author, pages_num, review) VALUES (%s, %s, %s, %s)',
            ('A Tale of Two Cities', 'Charles Dickens', 489, 'A great classic!'))

cur.execute('INSERT INTO books (title, author, pages_num, review) VALUES (%s, %s, %s, %s)',
            ('Anna Karenina', 'Leo Tolstoy', 864, 'Another great classic!'))

# Nuevas inserciones
books = [
    ('War and Peace', 'Leo Tolstoy', 1225, 'Epic historical novel.'),
    ('Brave New World', 'Aldous Huxley', 288, 'A dystopian vision of the future.'),
    ('The Lord of the Rings', 'J.R.R. Tolkien', 1178, 'An epic high-fantasy novel.'),
    ('Pride and Prejudice', 'Jane Austen', 279, 'A timeless romantic classic.'),
    ('The Catcher in the Rye', 'J.D. Salinger', 214, 'A coming-of-age story.'),
    ('The Grapes of Wrath', 'John Steinbeck', 464, 'A novel about the Great Depression.'),
    ('The Picture of Dorian Gray', 'Oscar Wilde', 320, 'A gothic novel about vanity.'),
    ('One Hundred Years of Solitude', 'Gabriel García Márquez', 417, 'A masterpiece of magical realism.'),
    ('The Brothers Karamazov', 'Fyodor Dostoevsky', 824, 'A philosophical and psychological novel.')
]

for book in books:
    cur.execute('INSERT INTO books (title, author, pages_num, review) VALUES (%s, %s, %s, %s)', book)

# Confirmar los cambios
conn.commit()

# Cerrar el cursor y la conexión
cur.close()
conn.close()

print("Base de datos inicializada con éxito y registros insertados.")
