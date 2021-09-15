# Reportes parte I - Repasamos INNER JOIN
# Realizar una consulta de la facturación de e-market. Incluir la siguiente información:
# ● Id de la factura # ● fecha de la factura # ● nombre de la empresa de correo
# ● nombre del cliente # ● categoría del producto vendido # ● nombre del producto
# ● precio unitario # ● cantidad

SELECT * FROM Facturas;

SELECT f.FacturaID, f.FechaFactura, c.Compania, cl.Contacto, cat.CategoriaNombre, p.ProductoNombre, p.PrecioUnitario, fd.Cantidad
FROM Facturas f
INNER JOIN Correos c ON f.EnvioVia = c.CorreoID
INNER JOIN Clientes cl ON f.ClienteID = cl.ClienteID
INNER JOIN FacturaDetalle fd ON f.FacturaID = fd.FacturaID
INNER JOIN Productos p ON fd.ProductoID = p.ProductoID
INNER JOIN Categorias cat ON cat.CategoriaID = p.CategoriaID; 


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
FROM Productos pr
INNER JOIN Categorias ca ON ca.CategoriaID = pr.CategoriaID
RIGHT JOIN Proveedores pro ON pro.ProveedorID = pr.ProveedorID;

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
FROM Productos 
INNER JOIN Categorias ON Productos.CategoriaID = Categorias.CategoriaID
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



# 2. Se necesita listar los números de teléfono de los clientes que no tengan fax. Hacerlo de dos formas distintas:
# a. Consultando la tabla de clientes.
# b. Consultando la vista de clientes.

# Proveedores

# 1. Crear una vista con los siguientes datos de los proveedores: ID, contacto, compañía y dirección. Para la dirección tomar la dirección, ciudad, código postal y país.

# 2. Listar los proveedores que vivan en la calle Americanas en Brasil. Hacerlo de dos formas distintas:
# a. Consultando la tabla de proveedores.
# b. Consultando la vista de proveedores.

# Vistas - Parte II

# 1. Crear una vista de productos que se usará para control de stock. Incluir el ID y nombre del producto, el precio unitario redondeado sin decimales, las unidades en stock y las unidades pedidas. Incluir además una nueva columna PRIORIDAD con los siguientes valores:
# ■ BAJA: si las unidades pedidas son cero.
# ■ MEDIA: si las unidades pedidas son menores que las unidades en stock.
# ■ URGENTE: si las unidades pedidas no duplican el número de unidades.
# ■ SUPER URGENTE: si las unidades pedidas duplican el número de unidades en caso contrario.

# 2. Se necesita un reporte de productos para identificar problemas de stock. Para cada prioridad indicar cuántos productos hay y su precio promedio. No incluir las prioridades para las que haya menos de 5 productos.

#######################################################################################
#######################################################################################
#######################################################################################
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
















