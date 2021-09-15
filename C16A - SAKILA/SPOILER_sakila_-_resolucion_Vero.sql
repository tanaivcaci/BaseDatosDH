-- volver al futuro SAKILA
-- 1 - Obtener el nombre y apellido de los primeros 5 actores disponibles. Utilizar
-- alias para mostrar los nombres de las columnas en español.

select first_name as nombre, last_name as apellido from actor
limit 5;

-- 2.  Obtener un listado que incluya nombre, apellido y correo electrónico de los
--  clientes (customers) inactivos. Utilizar alias para mostrar los nombres de las
-- columnas en español.
select * from customer;
select first_name as nombre, last_name as apellido, email "correo electronico", active
from customer
where active = false;

-- 3. Obtener un listado de films incluyendo título, año y descripción de los films
-- que tienen un rental_duration mayor a cinco. Ordenar por rental_duration de
-- mayor a menor. Utilizar alias para mostrar los nombres de las columnas en
-- español.

select * from film;
select title titulo, release_year año, description descripcion, rental_duration
from film
where rental_duration > 5
order by rental_duration desc;

-- 4. Obtener un listado de alquileres (rentals) que se hicieron durante el mes de
-- mayo de 2005, incluir en el resultado todas las columnas disponibles.

select * from rental
where month(rental_date) = 05 and year(rental_date) = 2005;

-- REPORTES PARTE 2
-- 1. Obtener la cantidad TOTAL de alquileres (rentals). Utilizar un alias para
-- mostrarlo en una columna llamada “cantidad”.
select count(rental_id) cantidad from rental;

-- 2.- Obtener la suma TOTAL de todos los pagos (payments). Utilizar un alias para
-- mostrarlo en una columna llamada “total”, junto a una columna con la
-- cantidad de alquileres con el alias “Cantidad” y una columna que indique el
-- “Importe promedio” por alquiler.
select * from payment;
select sum(amount) as total, count(distinct rental_id) as cantidad, avg(amount) as promedio
from payment;

-- 3. Generar un reporte que responda la pregunta: ¿cuáles son los diez clientes
-- que más dinero gastan y en cuántos alquileres lo hacen?

select customer_id cliente, sum(amount) gasto, count(distinct rental_id) from payment
group by customer_id
order by gasto
limit 10;

-- 4. Generar un reporte que indique: ID de cliente, cantidad de alquileres y monto
-- total para todos los clientes que hayan gastado más de 150 dólares en alquileres.

select customer_id, count(rental_id), sum(amount) from payment
group by customer_id
having sum(amount) > 150;
-- 5. Generar un reporte que muestre por mes de alquiler (rental_date de tabla rental), 
-- la cantidad de alquileres y la suma total pagada (amount de tabla payment) 
-- para el año de alquiler 2005 (rental_date de tabla rental).


select month(rental_date), count(rental_date), sum(amount) from rental
inner join payment
on rental.rental_id = payment.rental_id
where year(rental_date) = 2005
group by month(rental_date);

-- 6.Generar un reporte que responda a la pregunta: ¿cuáles son los 5 inventarios más alquilados?
-- (columna inventory_id en la tabla rental). Para cada una de ellas indicar la cantidad de alquileres.
select inventory_id, count(*) from rental
group by inventory_id
order by count(*) desc;

-- otra forma
select inventory_id, count(*) as cantidad from rental
inner join payment
on rental.rental_id = payment.rental_id
group by inventory_id
order by cantidad, inventory_id desc;
