#1. Queremos tener un listado de todas las categorías. 
SELECT * FROM Categorias;

#2. Cómo las categorías no tienen imágenes, solamente interesa obtener un listado de CategoriaNombre y Descripcion. 
SELECT CategoriaNombre, Descripcion FROM `EMarket`.`Categorias`;

#3. Obtener un listado de los productos. 
SELECT * FROM Productos;

#4. ¿Existen productos discontinuados? (Discontinuado = 1). 
SELECT * FROM PRODuctos
WHERE DISContinuado= 1;

#5. Para el viernes hay que reunirse con el Proveedor 8. ¿Qué productos son los que nos provee? 
SELECT * FROM PrODUCtos
WHERE PROVEEdorID = 8;

#6. Queremos conocer todos los productos cuyo precio unitario se encuentre entre 10 y 22.
SELECT * FROM PrODUCtos
WHERE PRECIOUnitario BETWEEN 10 AND 22;

/* 7. Se define que un producto hay que solicitarlo al proveedor si sus unidades en stock son 
menores al Nivel de Reorden. ¿Hay productos por solicitar? 8. Se quiere conocer todos los 
productos del listado anterior, pero que unidades pedidas sea igual a cero. */

SELECT * FROM PRoDUCTos
WHERE UnIDADEsStock < NivelREorden;

#8. Se quiere conocer todos los productos del listado anterior, pero que unidades pedidas sea igual a cero. 

SELECT * FROM pRoDUCTos
WHERE UnIDADEsStock < NivelREorden and UnidADEsPedidas=0;

/*CLIentes 
1. Obtener un listado de todos los clientes con Contacto, Compania, Título, País. Ordenar el listado por País. 
*/

SELECT * FROM CLIeNtES
Order by PaIS;

#2. Queremos conocer a todos los clientes que tengan un título “Owner”. 

SELECT * FROM ClIENTES
WhERE Titulo = 'OWNER';

#3. El operador telefónico que atendió a un cliente no recuerda su nombre. Solo sabe que comienza con “C”. ¿Lo ayudamos a obtener un listado con todos los contactos que inician con la letra “C”?  

SELECT * FROM Clientes 
WHERE CONtAcTO LIKE 'c%';

/*
FActuras 
1. OBTener un listado de todas las facturas, ordenado por fecha de factura ascendente. 
*/
SELECT * FROM Facturas
ORDER BY FeChAFACtura; 

#2. AHOrA se requiere un listado de las facturas con el país de envío “USA” y que su correo (EnvioVia) sea distinto de 3. 
SELECT * FROM Facturas
WHERE PaisENVIO LIKE "USA" AND EnVIOVIa != 3;


#3. ¿El clieNTE 'GOURL' rEAlIzó algún pedido? 
SELECT * FROM Facturas WHERE ClienteID = 'GOURL';

#4. Se qUIERE visualizar todas las facturas de los empleados 2, 3, 5, 8 y 9.
SELECT * FROM Facturas WHERE EmpleadOID IN (2, 3, 5, 8, 9);

/*
Consultas quERiES ML - PaRTe II 
En esta segunda parte vamos a intensificar la práctica de consultas SELECT, añadiendo ALIAS, LIMIT y OFFSET. 
Productos */

#1. Obtener el listado de todos los productos ordenados descendentemente por precio unitario. 
SELECT * FROM Productos
ORDER BY PreciOUNITArIo DESC;

#2. ObtENER eL listado de top 5 DE productos cuyo precio unitario es el más caro. 
SELECT * FROM Productos 
ORDER BY PreciOUNITArIo DESC
LIMIT 5;

#3. ObTEner un top 10 de LOS PRODUcTos con más unidades en stock. 
SELECT * FROM Productos 
ORDER BY UnidadESSTOCk DESC
LIMIT 10;

/* FACtURaDetalle */
#1. OBTeNER Un Listado de FacturaID, Producto, Cantidad. 
SELECT ProductoID, FacturaID, Cantidad FROM FActuraDetallE;

#2. OrdEnar el lisTADO anterior por cantidad descendentemente. 
SELECT ProductoID, FacturaID, Cantidad 
FROM FacturaDetalLe 
ORDER BY Cantidad DESC;

#3. Filtrar el LISTAdO solo para AQUEllos productos donde la cantidad se encuentre entre 50 y 100. 
SELECT ProductoID, FacturaID, Cantidad 
FROM FacturaDetalLe 
WHERE CAntidad BETWEEN 50 AND 100
ORDER BY CAntidad DESC;

-- 4. EN OtRO lISTADo Nuevo, obteNER un listado con los siguientes nombres de columnas: 
-- NroFactura (FacturaID), Producto (ProductoID), Total (PrecioUnitario*Cantidad). 
SELECT FacturaID AS NroFactura, ProductoID AS Producto, PREcioUnitario * Cantidad AS Total 
FROM FacturaDetalle; 

/* 4. ¡EXtras! 
¿TE Sobró tiempo? ¿Querés seguir practicando? 
Te dejamos unos ejercicios extras a partir de la misma base: */

#1. Obtener un listado de todos los clientes que viven en “Brazil" o “Mexico”, 
#o que tengan un título que empiece con “Sales”. 
SELECT * FROM Clientes
WHERE Pais IN ('Brazil', 'Mexico') 
OR TItULO LIKE 'SaleS%';


#2. OBtEner un lIstado de TodOS los cliENTEs que pertenecen a una compañía que empiece con la letra "A". 
SELECT * FROM Clientes
WHERE Compania LIKE 'A%';

-- 3. ObTENER uN LISTado con loS DATos: Ciudad, COntacto y renombrarlo como Apellido y Nombre, Titulo y 
-- renombrarlo como Puesto, de todos los clientes que sean de la ciudad "Madrid". 

SELECT Ciudad, Contacto AS 'Apellido y Nombre', Titulo AS PUESTO 
FROM Clientes 
WHERE Ciudad 
LIKE 'MadRid';

#4. Obtener uN LIstado de toDAS Las facturAS Con ID entre 10000 y 10500 

SELECT * FROM Facturas WHERE FacturaID BETWEEN 10000 AND 10500;


#5. Obtener un LISTAdo de todas LAS FAcTURAS CON ID ENtre 10000 y 10500 o 
#de los clientes con ID que empiecen con la letra “B”. 

SELECT * FROM Facturas 
WHERE FacturaID 
BETWEEN 10000 AND 10500
OR CLiENTEID LIKE 'B%';

#6. ¿Existen FACTURAs QUE lA CiUDAD dE envío sea “Vancouver” o que utilicen el correo 3? 
SELECT * FROM Facturas
WHERE CiudadEnvio = 'Vancouver'
OR EnvioVia = 3;

#7. ¿CUÁl es el ID DE Empleado de “BUchanan”? 
SELECT EmpleadoID FROM Empleados
WHERE Apellido LIKE 'Buchanan';

#8. ¿ExiSTEN Facturas con EMPLeadoID del EMPLEado del ejERCIcio anterior? 
#(No relacionar, sino verificar que existan facturas) 

SELECT * FROM Facturas
WHERE EmpleadoID = 5;


###############################################################
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

