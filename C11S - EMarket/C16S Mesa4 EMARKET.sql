# Reportes parte I - Repasamos INNER JOIN
# Realizar una consulta de la facturación de e-market. Incluir la siguiente información:
# ● Id de la factura # ● fecha de la factura # ● nombre de la empresa de correo
# ● nombre del cliente # ● categoría del producto vendido # ● nombre del producto
# ● precio unitario # ● cantidad

SELECT * FROM Facturas;

SELECT f.FacturaID, f.FechaFactura, c.Compania, cl.Contacto, cat.CategoriaNombre, 
p.ProductoNombre, p.PrecioUnitario, fd.Cantidad
FROM Facturas f
INNER JOIN Correos c ON f.EnvioVia = c.CorreoID
INNER JOIN Clientes cl ON f.ClienteID = cl.ClienteID
INNER JOIN FacturaDetalle fd ON f.FacturaID = fd.FacturaID
INNER JOIN Productos p ON fd.ProductoID = p.ProductoID
INNER JOIN Categorias cat ON cat.CategoriaID = p.CategoriaID
ORDER BY Compania; 


# Reportes parte II - INNER, LEFT Y RIGHT JOIN
# 1. Listar todas las categorías junto con información de sus productos. Incluir todas las categorías aunque no tengan productos.

SELECT * 
FROM Categorias cat
LEFT JOIN Productos pr ON cat.CategoriaID = pr.CategoriaID;

# 2. Listar la información de contacto de los clientes que no hayan comprado nunca en emarket.

SELECT * 
FROM Clientes
LEFT JOIN Facturas ON Clientes.ClienteID = Facturas.ClienteID
WHERE Facturas.ClienteID IS NULL;

# 3. Realizar un listado de productos. Para cada uno indicar su nombre, categoría, y la información de contacto de su proveedor. Tener en cuenta que puede haber productos para los cuales no se indicó quién es el proveedor.

SELECT ProductoNombre, ca.CategoriaNombre, pro.Contacto
FROM Categorias ca
INNER JOIN Productos pr ON ca.CategoriaID = pr.CategoriaID
left JOIN Proveedores pro ON pro.ProveedorID = pr.ProveedorID;

SELECT ProductoNombre, pro.Contacto
FROM Productos pr
RIGHT JOIN Proveedores pro ON pro.ProveedorID = pr.ProveedorID;

# 4. Para cada categoría listar el promedio del precio unitario de sus productos.
SELECT * FROM Categorias; 
SELECT * FROM Productos;

#comprobación
SELECT AVG(PrecioUnitario) FROM Productos WHERE CategoriaID = 1; 

#query definitiva
SELECT Categorias.CategoriaID, CategoriaNombre, 
AVG(PrecioUnitario) as PromedioPU
FROM Categorias 
LEFT JOIN Productos ON Productos.CategoriaID = Categorias.CategoriaID
GROUP BY Categorias.CategoriaID, CategoriaNombre;

# 5. Para cada cliente, indicar la última factura de compra. Incluir a los clientes que nunca hayan comprado en e-market.

#COMPROBACIÓN
SELECT c.ClienteID, f.FechaFactura
FROM Clientes c
LEFT JOIN Facturas f ON c.ClienteID = f.ClienteID
where c.ClienteID = 'WOLZA'
ORDER BY f.FechaFactura DESC;

#QUERY TERMINADA
SELECT c.ClienteID, c.Contacto, MAX(f.FechaFactura)
FROM Clientes c
LEFT JOIN Facturas f ON c.ClienteID = f.ClienteID
GROUP BY c.ClienteID
HAVING MAX(f.FechaFactura)
ORDER BY c.ClienteID DESC;

# 6. Todas las facturas tienen una empresa de correo asociada (enviovia). Generar un listado con todas las empresas de correo, y la cantidad de facturas correspondientes. Realizar la consulta utilizando RIGHT JOIN.

SELECT EnvioVia, Compania, COUNT(FacturaID) AS Cantidad
FROM Facturas fa
RIGHT JOIN Correos co
ON	fa.EnvioVia = co.CorreoID
GROUP BY EnvioVia, Compania
ORDER BY Cantidad DESC;


#C17A - DML - Queries XXL Parte II - VISTAS

# Vistas - Parte I

# Clientes

# 1. Crear una vista con los siguientes datos de los clientes: ID, contacto, y el Fax. En caso de que no tenga Fax, colocar el teléfono, pero aclarándolo. Por ejemplo: “TEL: (01) 123-4567”.

CREATE VIEW cliente_contactos AS
SELECT ClienteID, contacto, Fax, Telefono,
CASE
	WHEN Fax = '' THEN CONCAT("Tel: ", Telefono)
	ELSE Fax
END AS faxTel
FROM Clientes c;

DROP VIEW cliente_contactos;

SELECT ClienteID, contacto, Fax, Telefono, if(Fax= '', concat("Tel: ", Telefono) , Fax) as FaxTel
FROM Clientes;
 
SELECT * FROM cliente_contactos;

# 2. Se necesita listar los números de teléfono de los clientes que no tengan fax. Hacerlo de dos formas distintas:
# a. Consultando la tabla de clientes.

SELECT ClienteID, Contacto, Telefono
FROM Clientes
WHERE Fax is null OR Fax = '';

# b. Consultando la vista de clientes. --------------------------------------------------------------------

SELECT ClienteID, contacto, Telefono FROM cliente_contactos
WHERE Fax is null OR Fax = '';

# Proveedores

# 1. Crear una vista con los siguientes datos de los proveedores: ID, contacto, compañía y dirección. Para la dirección tomar la dirección, ciudad, código postal y país.

CREATE VIEW datos_proveedores AS
SELECT ProveedorID, Contacto, Compania, concat(Direccion , ' · ', Ciudad, ' · ' , CodigoPostal, ' · ', Pais ) as Direccion
FROM Proveedores; 

SELECT * FROM datos_proveedores;

# 2. Listar los proveedores que vivan en la calle Americanas en Brasil. Hacerlo de dos formas distintas:
# a. Consultando la tabla de proveedores.

SELECT * FROM Proveedores
WHERE Direccion LIKE '%americanas%';

# b. Consultando la vista de proveedores.

SELECT * FROM datos_proveedores
WHERE Direccion LIKE '%americanas%';

# Vistas - Parte II

# 1. Crear una vista de productos que se usará para control de stock. Incluir el ID y nombre del producto, el precio unitario redondeado sin decimales, las unidades en stock y las unidades pedidas. Incluir además una nueva columna PRIORIDAD con los siguientes valores:

# ■ BAJA: si las unidades pedidas son cero.
# ■ MEDIA: si las unidades pedidas son menores que las unidades en stock.
# ■ URGENTE: si las unidades pedidas no duplican el número de unidades.
# ■ SUPER URGENTE: si las unidades pedidas duplican el número de unidades en caso contrario.

CREATE VIEW control_Stock AS
SELECT ProductoID, ProductoNombre, round(PrecioUnitario) as PxUnitario, UnidadesStock, UnidadesPedidas, 
CASE
	WHEN UnidadesPedidas = 0 THEN 'BAJA'
    WHEN UnidadesPedidas < UnidadesStock THEN 'MEDIA'
    WHEN UnidadesPedidas < (UnidadesStock * 2) THEN 'URGENTE'
    WHEN UnidadesPedidas > (UnidadesStock * 2) THEN 'SUPER URGENTE'
END AS Prioridad
FROM Productos; 


# 2. Se necesita un reporte de productos para identificar problemas de stock. Para cada prioridad indicar cuántos productos hay y su precio promedio. No incluir las prioridades para las que haya menos de 5 productos.

SELECT Prioridad, COUNT(ProductoNombre) as CantPdtos, ROUND(AVG(PxUnitario), 2) as PromedioPU
FROM control_Stock
GROUP BY Prioridad
HAVING CantPdtos >= 5; 


#####################################################################
#####################################################################
#####################################################################
# C17S - DML - Queries XXL - Parte II

# Consultas
# Views:

# 1. a) Crear una vista denominada “vista_mostrar_pais” que devuelva un reporte de los países.
# b) Invocar la vista creada.

# 2. a) Crear una vista que devuelva un resumen con el apellido y nombre (en una sola columna denominada “artista”) de los artistas y la cantidad de filmaciones que tienen. Traer solo aquellos que tengan más de 25 filmaciones y ordenarlos por apellido.

# b) Invocar la vista creada.

# c) En la misma invocación de la vista, traer aquellos artistas que tienen menos de 33 filmaciones.

# d) Con la misma sentencia anterior, ahora, mostrar el apellido y nombre de los artistas en minúsculas y traer solo aquellos artistas cuyo apellido comience con la letra "a".

# e) Eliminar la vista creada.

# 3. a) Crear una vista que devuelva un reporte del título de la película, el apellido y nombre (en una sola columna denominada “artista”) de los artistas y el costo de reemplazo. Traer solo aquellas películas donde su costo de reemplazo es entre 15 y 27 dólares, ordenarlos por costo de reemplazo.

# b) Invocar la vista creada.

# c) En la misma invocación de la vista, traer aquellas películas que comienzan con la letra "b".

# d) Modificar la vista creada agregando una condición que traiga los artistas cuyo nombre termine con la letra "a" y ordenarlos por mayor costo de reemplazo

# e) Invocar la vista creada.


###########################################################################
#C18S

# Ejercicio 1

# 1. Crear una vista para poder organizar los envíos de las facturas. Indicar número de factura, fecha de la factura y fecha de envío, ambas en formato dd/mm/yyyy, valor del transporte formateado con dos decimales, y la información del domicilio del destino incluyendo dirección, ciudad, código postal y país, en una columna llamada Destino.
SET lc_time_names = 'es_ES';

Select * FROM Facturas;

CREATE VIEW v_facturas as
SELECT FacturaID, date_format(FechaFactura, '%d/%m/%Y') as FechaFact, date_format(FechaEnvio, '%d/%m/%Y') as FechaEnv, EnvioVia, ROUND(Transporte, 2) as ValorTransporte, concat(DireccionEnvio, ', ', CiudadEnvio, ', ', CodigoPostalEnvio, ', ', PaisEnvio) as Destino
FROM Facturas; 

# 2. Realizar una consulta con todos los correos y el detalle de las facturas que usaron ese correo. Utilizar la vista creada.

SELECT v_facturas.FacturaID, c.Compania, c.Telefono, fd.ProductoID, fd.PrecioUnitario, fd.PrecioUnitario
FROM v_facturas
INNER JOIN Correos c ON v_facturas.EnvioVia = c.CorreoID
INNER JOIN FacturaDetalle fd ON v_facturas.FacturaID = fd.FacturaID;


# 3. ¿Qué dificultad o problema encontrás en esta consigna? Proponer alguna alternativa o solución.
-- La dificultad es que no se puede acceder a los datos de una columna que no fue incorporada en la creación de la vista.
-- Una alternativa es eliminar la vista y crearla nuevamente agregando el campo EnvioVia y luego al invocar la vista, se puede realizar join con la tabla Correos y FacturaDetalle. 


# Ejercicio 2

# 1. Crear una vista con un detalle de los productos en stock. Indicar id, nombre del producto, nombre de la categoría y precio unitario.



# 2. Escribir una consulta que liste el nombre y la categoría de todos los productos vendidos. Utilizar la vista creada.



# 3. ¿Qué dificultad o problema encontrás en esta consigna? Proponer alguna alternativa o solución.
