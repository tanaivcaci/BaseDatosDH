# C16A - SAKILA

# Reportes
# Reportes parte 1:

# 1. Obtener el nombre y apellido de los primeros 5 actores disponibles. Utilizar alias para mostrar los nombres de las columnas en español.

SELECT first_name as nombre, last_name as apellido 
FROM actor
LIMIT 5;

# 2. Obtener un listado que incluya nombre, apellido y correo electrónico de los clientes (customers) inactivos. Utilizar alias para mostrar los nombres de las columnas en español.

SELECT first_name as nombre, last_name as apellido, email, active as activo
FROM customer
WHERE active = 0; 

# 3. Obtener un listado de films incluyendo título, año y descripción de los films que tienen un rental_duration mayor a cinco. Ordenar por rental_duration de mayor a menor. Utilizar alias para mostrar los nombres de las columnas en español.

SELECT title as titulo, release_year as año, description as descripcion
FROM film
WHERE rental_duration > 5
ORDER BY rental_duration DESC;

# 4. Obtener un listado de alquileres (rentals) que se hicieron durante el mes de mayo de 2005, incluir en el resultado todas las columnas disponibles.

SELECT * 
FROM rental
WHERE rental_date LIKE '%-05-%'; 

# Reportes parte 2: Sumemos complejidad
# Si llegamos hasta acá, tenemos en claro la estructura básica de un SELECT. En los siguientes reportes vamos a sumar complejidad.
# ¿Probamos?

# 1. Obtener la cantidad TOTAL de alquileres (rentals). Utilizar un alias para mostrarlo en una columna llamada “cantidad”.

SELECT COUNT(*) as Cantidad FROM rental; 

# 2. Obtener la suma TOTAL de todos los pagos (payments). Utilizar un alias para mostrarlo en una columna llamada “total”, junto a una columna con la cantidad de alquileres con el alias “Cantidad” y una columna que indique el  “Importe promedio” por alquiler.

SELECT SUM(amount) as total, COUNT(*) as cantidad, AVG(amount) as 'Importe Promedio' FROM payment; 

# 3. Generar un reporte que responda la pregunta: ¿cuáles son los diez clientes que más dinero gastan y en cuántos alquileres lo hacen?

#prueba
SELECT sum(amount) FROM payment
WHERE customer_id = 2;


SELECT payment.customer_id, SUM(amount) as total, COUNT(payment.rental_id) as CantAlquileres
FROM customer
INNER JOIN payment ON customer.customer_id = payment.customer_id
GROUP BY payment.customer_id
LIMIT 10; 

# 4. Generar un reporte que indique: ID de cliente, cantidad de alquileres y monto total para todos los clientes que hayan gastado más de 150 dólares en alquileres.

SELECT customer.customer_id as idCliente, 
COUNT(rental.customer_id) as CantAlq, 
SUM(amount)
FROM customer
INNER JOIN payment ON customer.customer_id = payment.customer_id
INNER JOIN rental ON payment.rental_id = rental.rental_id
GROUP BY idcliente
having SUM(amount) > 150;




# 5. Generar un reporte que muestre por mes de alquiler (rental_date de tabla rental), la cantidad de alquileres y la suma total pagada (amount de tabla payment) para el año de alquiler 2005 (rental_date de tabla rental).

SELECT COUNT(rental.rental_id) as cantAlq, 		# Cantidad de alquileres
month(rental_date),  							# Muestra el mes de alquiler
SUM(amount)										# Suma total pagada
FROM rental										# De la tabla rental
INNER JOIN payment								# con la tabla payment
ON payment.rental_id = rental.rental_id			# condición para unir las tablas
WHERE YEAR(rental_date) = 2005					# Donde el año de alquiler sea 2005
GROUP BY MONTH(rental_date);					# Agrupa el resultado por MES DE ALQUILER


# 6. Generar un reporte que responda a la pregunta: ¿cuáles son los 5 inventarios más alquilados? (columna inventory_id en la tabla rental). Para cada una de ellas indicar la cantidad de alquileres.

SELECT * FROM rental;

SELECT inventory_id, COUNT(inventory_id) as cantidad
FROM rental
GROUP BY inventory_id
ORDER BY cantidad DESC
LIMIT 5;

-- otra forma (PROFE)
select inventory_id, count(*) as cantidad from rental
inner join payment
on rental.rental_id = payment.rental_id
group by inventory_id
order by cantidad desc, inventory_id
limit 5;



#################################################################################
#################################################################################
#################################################################################

# C17A Desafío Extra - SAKILA

# Consultas
# Views:

# 1. a) Crear una vista denominada “vista_mostrar_pais” que devuelva un reporte de los países.

CREATE VIEW vista_mostrar_pais AS
SELECT * FROM country;

# b) Invocar la vista creada.

SELECT * FROM vista_mostrar_pais;


# 2. a) Crear una vista que devuelva un resumen con el apellido y nombre (en una sola columna denominada “artista”) de los artistas y la cantidad de filmaciones que tienen. Traer solo aquellos que tengan más de 25 filmaciones y ordenarlos por apellido.

CREATE VIEW artistas_resumen AS
SELECT 
concat(first_name, ' ' , last_name) AS 'Artista', 
COUNT(film_actor.film_id) AS 'Cantidad_de_films'
FROM actor
INNER JOIN film_actor ON actor.actor_id = film_actor.actor_id
-- INNER JOIN film ON film.film_id = film_actor.film_id
GROUP BY Artista
HAVING Cantidad_de_films > 25
ORDER BY Artista;



# b) Invocar la vista creada.
SELECT * FROM artistas_resumen;


# c) En la misma invocación de la vista, traer aquellos artistas que tienen menos de 33 filmaciones.

SELECT * FROM artistas_resumen
HAVING Cantidad_de_films < 33;



# d) Con la misma sentencia anterior, ahora, mostrar el apellido y nombre de los artistas en minúsculas y traer solo aquellos artistas cuyo apellido comience con la letra "a".

SELECT * FROM artistas_resumen
HAVING Artista LIKE 'a%';

# e) Eliminar la vista creada.
DROP VIEW artistas_resumen;


# 3. a) Crear una vista que devuelva un reporte del título de la película, el apellido y nombre (en una sola columna denominada “artista”) de los artistas y el costo de reemplazo. Traer solo aquellas películas donde su costo de reemplazo es entre 15 y 27 dólares, ordenarlos por costo de reemplazo.


# b) Invocar la vista creada.


# c) En la misma invocación de la vista, traer aquellas películas que comienzan con la letra "b".


# d) Modificar la vista creada agregando una condición que traiga los artistas cuyo nombre termine con la letra "a" y ordenarlos por mayor costo de reemplazo.


# e) Invocar la vista creada.