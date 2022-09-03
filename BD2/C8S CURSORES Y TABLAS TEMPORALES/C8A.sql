/* 1. Crear un procedimiento almacenado que inserta de a un registro en la
 tabla items_de_factura. Parámetros de entrada: mismos campos que la tabla
 items_de_facturas.
Parámetros de salida: no tiene.
Tip: La Primary KEY de la tabla  items_de_factura  no es AutoIncremental,
 por lo tanto, vamos a tener que calcularlo en nuestro procedimiento.*/
 
 DELIMITER $$
 CREATE PROCEDURE insertar_registro_tabla_items_de_factura(IN IdFactura smallint, IN IdCancion smallint, IN PrecioUnitario decimal(3,2), IN Cantidad tinyint)
 BEGIN
	DECLARE idItem SMALLINT DEFAULT (SELECT MAX(id) FROM items_de_facturas);
	INSERT INTO items_de_facturas (id, id_factura, id_cancion, precio_unitario, cantidad) VALUES (idItem, IdFactura, IdCancion, PrecioUnitario, Cantidad);
 END $$

/* 2. Crear un procedimiento almacenado que inserta ítems de  facturas utilizando
 el procedimiento del punto 1. 
Los ítems que vamos a insertar son los que estarán en la siguiente tabla temporal:  
CREATE TEMPORARY TABLE temp_items_de_factura SELECT id, id_factura, id_cancion,
 precio_unitario, 15 as cantidad FROM items_de_facturas;
Utilizar un cursor que recorra los registros de la tabla temporal y llame al
 procedimiento del punto 1 para insertar los valores de la misma.*/
 
 DELIMITER $$
 CREATE PROCEDURE insertar_items_facturas_cursor()
 BEGIN
 # Definición de variables
 DECLARE IdFactura, IdCancion smallint;
 DECLARE PrecioUnitario decimal(3,2);
 DECLARE Cantidad tinyint;
 DECLARE finished tinyint DEFAULT 0;
 
 # Definición de cursor
 DECLARE cur1 CURSOR FOR SELECT * FROM temp_items_de_factura;
 
 # Definición de variable para salir del loop
 DECLARE CONTINUE HANDLER FOR NOT FOUND SET finished = 1;
 
 # Definición de tabla temporal
 CREATE TEMPORARY TABLE IF NOT EXISTS temp_items_de_factura SELECT id_factura, id_cancion, precio_unitario, 15 as cantidad FROM items_de_facturas;
 
 # Abrimos el cursor
 OPEN cur1;
 
 # Iteramos cada registro con un LOOP
 etiqueta_Loop: LOOP
 
 FETCH cur1 INTO IdFactura, IdCancion, PrecioUnitario, Cantidad;
 
 # Si ya no hay mas rgistros, salimos del loop
 IF finished = 1 THEN
	LEAVE etiqueta_Loop;
END IF;
 
 CALL insertar_registro_tabla_items_de_factura(ItemsFacturasID, IdFactura, IdCancion, PrecioUnitario, Cantidad);

 END LOOP; 
 
 CLOSE cur1;
 
 END $$

/* 3. Luego de la ejecución del sp, validar que los registros se hayan insertado correctamente
 en la tabla items_de_facturas.*/
 
CALL insertar_items_facturas_cursor();
