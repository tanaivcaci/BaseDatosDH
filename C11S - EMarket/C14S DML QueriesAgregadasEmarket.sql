#C14S - DML - QUERIES AGREGADAS - QUERIES XL Parte 1 - GROUP BY

# Clientes
# 1) ¿Cuántos clientes existen?

SELECT COUNT(*) as CantClientes FROM Clientes; 

# 2) ¿Cuántos clientes hay por ciudad?

SELECT Ciudad, COUNT(Ciudad) FROM Clientes
GROUP BY Ciudad; 


# Facturas
# 1) ¿CUáL es el total de transporte?

 
SELECT SUM(Transporte) as 'Total Transporte' FROM Facturas; 

# 2) ¿Cuál es el total de transporte por EnvioVia (empresa de envío)?

SELECT EnvioVia, SUM(Transporte) as 'Total Transporte' FROM Facturas GROUP BY EnvioVia; 

# 3) Calcular la cantidad de facturas por cliente. Ordenar descendentemente por cantidad de facturas.

SELECT ClienteID, COUNT(FacturaID) as CantFact FROM Facturas GROUP BY ClienteID ORDER BY CantFact DESC; 

# 4) Obtener el Top 5 de clientes de acuerdo a su cantidad de facturas.

SELECT ClienteID, COUNT(FacturaID) as CantFact FROM Facturas GROUP BY ClienteID ORDER BY CantFact DESC LIMIT 5; 

# 5) ¿Cuál es el país de envío menos frecuente de acuerdo a la cantidad de facturas?

SELECT PaisEnvio, COUNT(FacturaID) as CantFact FROM Facturas GROUP BY PaisEnvio ORDER BY CantFact LIMIT 1; 

# 6) Se quiere otorgar un bono al empleado con más ventas. ¿Qué ID de empleado realizó más operaciones de ventas?
SELECT * FROM Facturas;
SELECT EmpleadoID, COUNT(FacturaID) as CantOperaciones FROM Facturas
GROUP BY EmpleadoID
ORDER BY CantOperaciones DESC LIMIT 1;

# Factura detalle
# 1) ¿Cuál es el producto que aparece en más líneas de la tabla Factura Detalle?

SELECT ProductoID, COUNT(ProductoID) as Cant FROM FacturaDetalle GROUP BY ProductoID ORDER BY Cant DESC LIMIT 1; 

# 2) ¿Cuál es el total facturado? Considerar que el total facturado es la suma de cantidad por precio unitario.

SELECT SUM(PrecioUnitario * Cantidad) as TotalFacturado FROM FacturaDetalle; 

# 3) ¿Cuál es el total facturado para los productos ID entre 30 y 50?
SELECT * FROM FacturaDetalle;

SELECT SUM(PrecioUnitario * Cantidad) as TotalFacturado FROM FacturaDetalle WHERE ProductoID BETWEEN 30 AND 50; 

# 4) ¿Cuál es el precio unitario promedio de cada producto?

SELECT ProductoID, AVG(PrecioUnitario) FROM FacturaDetalle GROUP BY ProductoID; 

# 5) ¿Cuál es el precio unitario máximo?

SELECT MAX(PrecioUnitario) FROM FacturaDetalle; 


###################################################################################
# Consultas queries XL parte II - JOIN
# En esta segunda parte vamos a intensificar la práctica de consultas con JOIN.

# 1) Generar un listado de todas las facturas del empleado 'Buchanan'.

SELECT * FROM Empleados WHERE Apellido = 'Buchanan';

SELECT Apellido, FacturaID 
FROM Facturas
INNER JOIN Empleados ON Facturas.EmpleadoID = Empleados.EmpleadoID
WHERE Apellido = 'Buchanan';

# 2) Generar un listado con todos los campos de las facturas del correo 'Speedy Express'.
SELECT * FROM Correos; #1

SELECT Compania, Facturas.* 
FROM Facturas
INNER JOIN Correos ON Facturas.EnvioVia = Correos.CorreoID
WHERE Compania = 'Speedy Express';

# 3) Generar un listado de todas las facturas con el nombre y apellido de los empleados.

SELECT FacturaID, Apellido, Nombre 
FROM Facturas
INNER JOIN Empleados ON Facturas.EmpleadoID = Empleados.EmpleadoID;

# 4) Mostrar un listado de las facturas de todos los clientes “Owner” y país de envío “USA”.
SELECT * FROM Facturas;
SELECT * FROM Clientes; 

SELECT Titulo, PaisEnvio, FacturaID 
FROM Facturas
INNER JOIN Clientes ON Facturas.ClienteID = Clientes.ClienteID
WHERE Clientes.Titulo = 'Owner'
AND 
PaisEnvio = 'USA';

# 5) Mostrar todos los campos de las facturas del empleado cuyo apellido sea “Leverling” o que incluyan el producto id = “42”.

# SELECT Apellido, ProductoID, Facturas.* FROM Facturas 

SELECT Facturas.* FROM Facturas
INNER JOIN Empleados ON Facturas.EmpleadoID = Empleados.EmpleadoID
INNER JOIN FacturaDetalle ON Facturas.FacturaID = FacturaDetalle.FacturaID
WHERE Apellido = 'Leverling' OR ProductoID = 42;

# 6) Mostrar todos los campos de las facturas del empleado cuyo apellido sea “Leverling” y que incluya los  producto id = “80” o ”42”.

SELECT Facturas.* FROM Facturas
INNER JOIN Empleados ON Facturas.EmpleadoID = Empleados.EmpleadoID
INNER JOIN FacturaDetalle ON Facturas.FacturaID = FacturaDetalle.FacturaID
WHERE Apellido = 'Leverling' AND ProductoID IN (80, 42);

# 7) Generar un listado con los cinco mejores clientes, según sus importes de compras total (PrecioUnitario * Cantidad).

SELECT Facturas.ClienteID, SUM(PrecioUnitario * Cantidad) AS Total 
FROM Clientes
INNER JOIN Facturas ON Clientes.ClienteID = Facturas.ClienteID
INNER JOIN FacturaDetalle ON Facturas.FacturaID = FacturaDetalle.FacturaID
GROUP BY Facturas.ClienteID
ORDER BY Total DESC
LIMIT 5; 

# 8) Generar un listado de facturas, con los campos id, nombre y apellido del cliente, fecha de factura, país de envío, Total, ordenado de manera descendente por fecha de factura y limitado a 10 filas.

SELECT Facturas.FacturaID, Clientes.ClienteID, Contacto, FechaFactura, PaisEnvio, SUM(PrecioUnitario * Cantidad) as Total 
FROM Clientes
INNER JOIN Facturas ON Clientes.ClienteID = Facturas.ClienteID
INNER JOIN FacturaDetalle ON Facturas.FacturaID = FacturaDetalle.FacturaID
GROUP BY ClienteID, FacturaID, FechaFactura
ORDER BY FechaFactura DESC; 