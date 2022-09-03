USE movies_db;

# SELECT
# 1. Mostrar todos los registros de la tabla de movies.
SELECT * FROM movies; 

# 2. Mostrar el nombre, apellido y rating de todos los actores.
SELECT first_name AS Nombre, last_name AS Apellido, rating FROM actors; 

# 3. Mostrar el título de todas las series.
SELECT title FROM series; 

# WHERE Y ORDER BY
# 4. Mostrar el nombre y apellido de los actores cuyo rating sea mayor a 7,5.

SELECT 
first_name as nombre, 
last_name as apellido, 
rating 
FROM actors
WHERE rating > 7.5
ORDER BY rating ASC; 

# 5. Mostrar el título de las películas, el rating y los premios de las películas con
# un rating mayor a 7,5 y con más de dos premios.
SELECT 
title as Titulo, 
rating, 
awards as Premios
FROM movies
WHERE rating > 7.5 AND awards > 2; 

# 6. Mostrar el título de las películas y el rating ordenadas por rating en forma
# ascendente.

SELECT 
title as Titulo, rating 
FROM movies
ORDER BY rating; 

# BETWEEN y LIKE
# 7. Mostrar el título y rating de todas las películas cuyo título incluya Toy Story.
SELECT title, rating 
FROM movies
WHERE title LIKE '%Toy Story%';

# 8. Mostrar a todos los actores cuyos nombres empiecen con Sam.
SELECT * FROM actors WHERE first_name LIKE 'Sam%';

# 9. Mostrar el título de las películas que salieron entre el ‘2004-01-01’ y
# ‘2008-12-31’.

SELECT * FROM movies
WHERE release_date BETWEEN '2004-01-01' AND '2008-12-31';


# Validemos lo aprendido
# Consultas
# Alias, limit y offset
# 2. Traer el título de las películas con el rating mayor a 3, con más de 1 premio y con
# fecha de lanzamiento entre el año ‘1988-01-01’ al ‘2009-12-31’. Ordenar los
# resultados por rating descendentemente.
SELECT title
FROM movies
WHERE rating > 3 
AND awards > 1 
AND release_date BETWEEN '1988-01-01' AND '2009-12-31'
ORDER BY rating DESC; 

# Movies: Ejercitación de SQL II
# Consultas
# Alias, limit y offset
# 1. Mostrar el título de todas las series y usar alias para que tanto el nombre de la
# tabla como el campo estén en español.
SELECT title AS titulo FROM series AS SERIES; 


# 2. Traer el título de las películas con el rating mayor a 3, con más de 1 premio y con
# fecha de lanzamiento entre el año ‘1988-01-01’ al ‘2009-12-31’. Ordenar los
# resultados por rating descendentemente.
SELECT title
FROM movies
WHERE rating > 3 
AND awards > 1 
AND release_date BETWEEN '1988-01-01' AND '2009-12-31'
ORDER BY rating DESC; 


# 3. Traer el top 3 a partir del registro 10 de la consulta anterior.
SELECT title
FROM movies
WHERE rating > 3 
AND awards > 1 
AND release_date BETWEEN '1988-01-01' AND '2009-12-31'
ORDER BY rating DESC
LIMIT 3
OFFSET 10; 


# 4. ¿Cuáles son los 3 peores episodios teniendo en cuenta su rating?
SELECT * FROM movies
ORDER BY rating ASC
LIMIT 3; 

# 5. Obtener el listado de todos los actores. Quitar las columnas de fechas y película
# favorita, además traducir los nombres de las columnas.

SELECT 
id, 
first_name AS Nombre,
last_name AS Apellido,
rating, 
favorite_movie_id AS idPeliculaFavorita
  FROM actors; 
  
  
#C13A - EJERCITACION OPCIONAL III

# Funciones de agregación, GROUP BY y HAVING
# 1. ¿Cuántas películas hay? -> 21 peliculas

SELECT COUNT(*) FROM movies; 


# 2. ¿Cuántas películas tienen entre 3 y 7 premios? -> 8 peliculas

SELECT COUNT(awards) 
FROM movies
WHERE awards BETWEEN 3 AND 7; 

# 3. ¿Cuántas películas tienen entre 3 y 7 premios y un rating mayor a 7? -> 8 películas

SELECT COUNT(awards) 
FROM movies
WHERE 
awards BETWEEN 3 AND 7
AND rating > 7 ; 



# 4. Crear un listado a partir de la tabla de películas, mostrar un reporte de la
# cantidad de películas por id. de género.

SELECT genre_id, COUNT(genre_id) 
FROM movies
GROUP BY genre_id; 

# 5. De la consulta anterior, listar sólo aquellos géneros que tengan como suma
# de premios un número mayor a 5.

SELECT * FROM movies; 

SELECT genre_id, COUNT(genre_id) 
FROM movies
GROUP BY genre_id
HAVING SUM(awards) > 5; 


#C14A - OPCIONAL - DER EN CARPETA C14
# Join
# 1. Utilizando la base de datos de movies, queremos conocer, por un lado, los títulos y el nombre del género de todas las series de la base de datos.



# 2. Por otro, necesitamos listar los títulos de los episodios junto con el nombre y apellido de los actores que trabajan en cada uno de ellos.

# 3. Para nuestro próximo desafío, necesitamos obtener a todos los actores o actrices (mostrar nombre y apellido) que han trabajado en cualquier película de la saga de La Guerra de las galaxias.

# 4. Crear un listado a partir de la tabla de películas, mostrar un reporte de la cantidad de películas por nombre de género.

