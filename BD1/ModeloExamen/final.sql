SELECT * FROM Usuarios WHERE nombreUsuario LIKE 'M%';

SELECT Viajes.* 
FROM Puertos
INNER JOIN Viajes ON Viajes.idPuertoOrig = Puertos.idPuertos
WHERE fecha BETWEEN 10-08-2020 AND 30-08-2020
AND Puertos.Nombre = 'EscolleraSur'

SELECT * 
FROM producto 
WHERE precio IN (100,101,102)

SELECT * 
FROM producto 
WHERE precio BETWEEN 100 AND 102

SELECT m.title, g.name, m.rating
FROM movies m
INNER JOIN genres g ON m.genre_id = g.id
ORDER BY m.title DESC;


SELECT * FROM musimundos.facturas where pais_de_facturacion != 'Germany';

SELECT * FROM persona WHERE nombre LIKE '%a_';


SELECT mesas.ID_MESA, ciudades.CIUDAD
FROM mesas
INNER JOIN ciudades ON mesas.ID_CIUDAD = crolrolrolroliudades.ID_CIUDAD
INNER JOIN provincias ON ciudades.ID_PROVINCIA = provincias.ID_PROVINCIA
WHERE provincias.PROVINCIA = 'Buenos Aires';

SELECT * FROM Productos
LEFT JOIN FacturaDetalle ON FacturaDetalle.ProductoID = Productos.ProductoID
WHERE FacturaDetalle.FacturaID is null;