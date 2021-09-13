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

SELECT sum(amount) FROM payment
WHERE customer_id = 2;


SELECT payment.customer_id, SUM(amount) as total, COUNT(payment.rental_id) as CantAlquileres
FROM customer
INNER JOIN payment ON customer.customer_id = payment.customer_id
GROUP BY payment.customer_id
LIMIT 10; 

# 4. Generar un reporte que indique: ID de cliente, cantidad de alquileres y monto total para todos los clientes que hayan gastado más de 150 dólares en alquileres.

SELECT customer.customer_id as idCliente, COUNT(rental.customer_id) as CantAlq, SUM(amount)
FROM customer
INNER JOIN payment ON customer.customer_id = payment.customer_id
INNER JOIN rental ON payment.rental_id = rental.rental_id
WHERE SUM(amount) > 150
GROUP BY customer_id
;



# 5. Generar un reporte que muestre por mes de alquiler (rental_date de tabla rental), la cantidad de alquileres y la suma total pagada (amount de tabla payment) para el año de alquiler 2005 (rental_date de tabla rental).



# 6. Generar un reporte que responda a la pregunta: ¿cuáles son los 5 inventarios más alquilados? (columna inventory_id en la tabla rental). Para cada una de ellas indicar la cantidad de alquileres.


