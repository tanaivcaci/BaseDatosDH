# C16A - EXTRA JOINS  BD: extra_joins

# Reportes - JOINS

# Consignas:
# 1. Obtener los artistas que han actuado en una o más películas.

SELECT DISTINCT a.id, a.* 
FROM artista a
INNER JOIN artista_x_pelicula ap ON a.id = ap.artista_id
INNER JOIN pelicula p ON p.id = ap.pelicula_id; 

# 2. Obtener las películas donde han participado más de un artista según nuestra base de datos.

SELECT p.titulo 
FROM pelicula p
LEFT JOIN artista_x_pelicula ap ON p.id = ap.pelicula_id 
INNER JOIN artista a ON a.id = ap.artista_id
GROUP BY p.titulo
HAVING COUNT(a.id) > 1;

# 3. Obtener aquellos artistas que han actuado en alguna película, incluso aquellos que aún no lo han hecho, según nuestra base de datos.

SELECT DISTINCT a.id, a.*, p.titulo
FROM artista a
LEFT JOIN artista_x_pelicula ap ON a.id = ap.artista_id
LEFT JOIN pelicula p ON p.id = ap.pelicula_id; 

# 4. Obtener las películas que no se le han asignado artistas en nuestra base de datos.

SELECT p.titulo , a.id as artistaID
FROM artista a
RIGHT JOIN artista_x_pelicula ap ON a.id = ap.artista_id
RIGHT JOIN pelicula p ON p.id = ap.pelicula_id
WHERE a.id IS NULL;



# 5. Obtener aquellos artistas que no han actuado en alguna película, según nuestra base de datos.

SELECT a.id as artistaID, a.nombre, a.apellido, p.titulo
FROM artista a
LEFT JOIN artista_x_pelicula ap ON a.id = ap.artista_id
LEFT JOIN pelicula p ON p.id = ap.pelicula_id
WHERE titulo IS NULL;

# 6. Obtener aquellos artistas que han actuado en dos o más películas según nuestra base de datos.

SELECT a.*, COUNT(p.id)
FROM artista a
INNER JOIN artista_x_pelicula ap ON a.id = ap.artista_id
INNER JOIN pelicula p ON p.id = ap.pelicula_id
GROUP BY a.id
HAVING COUNT(p.id) >= 2;


# 7. Obtener aquellas películas que tengan asignado uno o más artistas, incluso aquellas que aún no le han asignado un artista en nuestra base de datos.

SELECT p.*, COUNT(a.id) as 'CantArtistasAsignados'
FROM artista a
RIGHT JOIN artista_x_pelicula ap ON a.id = ap.artista_id
RIGHT JOIN pelicula p ON p.id = ap.pelicula_id
GROUP BY p.id
ORDER BY CantArtistasAsignados;
