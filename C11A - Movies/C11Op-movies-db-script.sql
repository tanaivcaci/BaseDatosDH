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