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
RIGHT JOIN Proveedores pro ON pro.ProveedorID = pr.ProveedorID
;

SELECT ProductoNombre, pro.Contacto
FROM Productos pr
RIGHT JOIN Proveedores pro ON pro.ProveedorID = pr.ProveedorID;

# 4. Para cada categoría listar el promedio del precio unitario de sus productos.



# 5. Para cada cliente, indicar la última factura de compra. Incluir a los clientes que nunca hayan comprado en e-market.
# 6. Todas las facturas tienen una empresa de correo asociada (enviovia). Generar un listado con todas las empresas de correo, y la cantidad de facturas correspondientes. Realizar la consulta utilizando RIGHT JOIN.