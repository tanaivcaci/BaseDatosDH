
/*SELECT p.Nombre, v.fecha 
FROM Viajes v
INNER JOIN Puertos p ON v.idPuertoOrig = p.idPuertos
INNER JOIN Barcos b ON v.idBarco = b.Matricula
WHERE b.Capacidad > 1000; 
*/

/*SELECT EXTRACT(YEAR FROM order_date) FECHA,     #muestra año
count(*) as cantidad, 							#cuenta cantidad de ordenes
sum(amount) as importe 							#suma el total del año
FROM orders 									#de la tabla ordenes
GROUP BY fecha 									#agrupa los resultados por año	
ORDER BY count(*) DESC 							#ordena en forma descendente por cantidad
LIMIT 1;										#muestra la fecha más actual
*/

/*SELECT Modelo, Min(capacidad)
FROM Barcos
GROUP BY modelo
ORDER BY MIN(CAPACIDAD) DESC;*/

/*SELECT l.NRO_LECTOR, l.Nombre, p.F_PREST
FROM lector l
LEFT JOIN prestamo p ON l.NRO_LECTOR = p.NRO_LECTOR;*/

/*SELECT nombreUsuario, credito 
FROM usuarios 
ORDER BY credito 
DESC LIMIT 1;*/

/*SELECT DISTINCT a.Marca
FROM aviones
INNER JOIN vuelos ON aviones.AvionId = vuelos.AvionId
WHERE vuelos.Fecha = '2021-05-08' ORDER BY Marca;*/

/*SELECT pais, AVG(credito)
FROM Usuarios
GROUP BY pais; */

/*SELECT *
FROM empleado
WHERE YEAR(Fecha_Ingreso) BETWEEN 2010 AND 2012;*/


