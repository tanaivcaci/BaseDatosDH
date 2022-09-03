-- Quizás nos pidan insertar un reporte diario a través de ... 
SELECT * FROM dhfitness.reportediario;  

-- Orden en que aparece la info en columnas dentro de reportediario
SELECT * FROM dhfitness.actividad;
SELECT * FROM dhfitness.tipo_medicion;
SELECT * FROM dhfitness.unidadmedida;
SELECT * FROM dhfitness.medicion;
SELECT * FROM dhfitness.usuario;

-- no aparece en reporte diario
SELECT * FROM dhfitness.pais;

-- Mostrar el nombre de usuario, fecha de nacimiento y país
SELECT usuario.nombre, usuario.fechaNacimiento, usuario.Pais_idPais, pais.Nombre FROM usuario
INNER JOIN pais ON usuario.Pais_idPais = pais.idPais;


-- NOMBRE ACTIVIDAD, NOMBRE UNIDAD MEDIDA Y NOMBRE DE TIPO DE MEDICIÓN


-- Mostrar idUsuario, Nombre de Usuario, NombreActividad, NombreMedicion, NombreUnidadMedida, Fecha, Valor y país
-- MÁS ABAJO HICE UNA vista_reporte con ésta QUERY
SELECT 
	usuario.idUsuario, usuario.nombre, 
    medicion.id as idMedicion, medicion.valor, medicion.Usuario_idUsuario, 
	unidadmedida.Nombre as unidadMedida,
    tipo_medicion.nombre as tipoMedicion, 
    actividad.nombre as actividad,
    pais.Nombre as pais
FROM
	usuario
INNER JOIN
	pais ON usuario.Pais_idPais = pais.idPais
INNER JOIN 
	medicion ON usuario.idUsuario = medicion.Usuario_idUsuario
INNER JOIN 
	unidadmedida ON medicion.UnidadMedida_Id = unidadmedida.Id
INNER JOIN 
	tipo_medicion ON medicion.Tipo_Medicion_id = tipo_medicion.id
INNER JOIN 
	actividad ON medicion.Actividad_id = actividad.id;
-- WHERE usuario.idUsuario = 2;



/* SELECT 49 */

SELECT 
    actividad.nombre as actividad,
    tipo_medicion.nombre as tipoMedicion,
    unidadmedida.Nombre as unidadMedida,
    medicion.id as idMedicion, medicion.valor, medicion.Usuario_idUsuario, 
	usuario.idUsuario, usuario.nombre
FROM
	usuario
INNER JOIN 
	medicion ON usuario.idUsuario = medicion.Usuario_idUsuario
INNER JOIN 
	unidadmedida ON medicion.UnidadMedida_Id = unidadmedida.Id
INNER JOIN 
	tipo_medicion ON medicion.Tipo_Medicion_id = tipo_medicion.id
INNER JOIN 
	actividad ON medicion.Actividad_id = actividad.id;
-- WHERE usuario.idUsuario = 2;






/*
REPORTE DIARIO
*/

SELECT 
    actividad.nombre as actividad,
    tipo_medicion.nombre as tipoMedicion,
    unidadmedida.Nombre as unidadMedida,
    
    medicion.id as idMedicion, medicion.valor, medicion.Usuario_idUsuario, 
	
	usuario.idUsuario, usuario.nombre
FROM
	usuario
INNER JOIN 
	medicion ON usuario.idUsuario = medicion.Usuario_idUsuario
INNER JOIN 
	unidadmedida ON medicion.UnidadMedida_Id = unidadmedida.Id
INNER JOIN 
	tipo_medicion ON medicion.Tipo_Medicion_id = tipo_medicion.id
INNER JOIN 
	actividad ON medicion.Actividad_id = actividad.id;
-- WHERE usuario.idUsuario = 2;




-- Traer el usuario con mayor distancia recorrida en metros en ciclismo

SELECT 
	usuario.idUsuario as idUsuario, 
    usuario.nombre as Usuario, 
    actividad.nombre as actividad, 
    tipo_medicion.nombre as tipoMedicion, 
    unidadmedida.nombre as unidadMedida, 
    medicion.valor as valor 
FROM 
	usuario
INNER JOIN 
	medicion ON usuario.idUsuario = medicion.Usuario_idUsuario
INNER JOIN 
	actividad ON medicion.Actividad_id = actividad.id
INNER JOIN 
	tipo_medicion ON medicion.Tipo_Medicion_id = tipo_medicion.id
INNER JOIN 
	unidadmedida ON medicion.UnidadMedida_Id = unidadmedida.Id
WHERE 
	actividad.nombre = "ciclismo"
AND 	
	unidadmedida.nombre = "metros"
AND 
	tipo_medicion.nombre = "Distancia"
ORDER BY 
	medicion.valor 
    DESC
LIMIT 1;

-- SELECT MAX valor --> No usar MAX SI GROUP BY --> Si tenemos una función de agregación (AVG, SUM, MIN, COUNT) y no tenemos group by no poner otro dato de join u order by
/*  NO ME FUNCIONO *

SELECT MAX(medicion.valor), 
	usuario.idUsuario as idUsuario, 
    usuario.nombre as Usuario, 
    actividad.nombre as actividad,
    medicion.valor as valor
FROM 
	medicion
INNER JOIN 
	usuario ON usuario.idUsuario = medicion.Usuario_idUsuario
INNER JOIN 
	actividad ON medicion.Actividad_id = actividad.id
INNER JOIN 
	tipo_medicion ON medicion.Tipo_Medicion_id = tipo_medicion.id
INNER JOIN 
	unidadmedida ON medicion.UnidadMedida_Id = unidadmedida.Id

WHERE 
	actividad.nombre = "ciclismo"
AND 	
	unidadmedida.nombre = "metros"
AND 
	tipo_medicion.nombre = "Distancia"

GROUP BY usuario.nombre, actividad.nombre, unidadmedida.nombre, tipo_medicion.nombre, medicion.valor;


*/
--


SELECT 
	actividad.nombre 'NombreActividad', 
    tipo_medicion.nombre 'NombreMedicion', 
    unidadmedida.Nombre 'NombreUnidadMedida', 
    medicion.Usuario_idUsuario 'idUsuario', 
    ÇDATE(medicion.timestamp), ROUND(AVG(medicion.valor)) FROM medicion INNER JOIN usuario ON usuario.idUsuario = medicion.Usuario_idUsuario INNER JOIN unidadmedida ON medicion.UnidadMedida_Id = unidadmedida.Id INNER JOIN tipo_medicion ON medicion.Tipo_Medicion_id = tipo_medicion.id INNER JOIN actividad ON medicion.Actividad_id = actividad.id WHERE YEAR(medicion.timestamp) = '2022' GROUP BY actividad.nombre, tipo_medicion.nombre,unidadmedida.Nombre, medicion.Usuario_idUsuario, DATE(medicion.timestamp); 


-- Cantidad de ACTIVIDAD por Usuario (Ej. cantidad de caminatas por usuario)
SELECT 
	COUNT(actividad.nombre),
    usuario.nombre,
    actividad.nombre
FROM 
	medicion
INNER JOIN 
	usuario ON medicion.Usuario_idUsuario = usuario.idUsuario
INNER JOIN
	actividad ON actividad.id = medicion.Actividad_id
GROUP BY actividad.nombre, usuario.nombre;
-- HAVING actividad.nombre = "Ciclismo";



-- Cantidad de actividades por usuario
SELECT DISTINCT
	COUNT(DISTINCT actividad.nombre) as 'cantidad de actividades',
    usuario.nombre
--    actividad.nombre
FROM 
	medicion
INNER JOIN 
	usuario ON medicion.Usuario_idUsuario = usuario.idUsuario
INNER JOIN
	actividad ON actividad.id = medicion.Actividad_id
GROUP BY usuario.nombre;

-- Cantidad de veces que realizó cada actividad cada usuario
SELECT 
	COUNT(actividad.nombre) as 'cantidad de actividades',
    usuario.nombre,
    actividad.nombre
FROM 
	medicion
INNER JOIN 
	usuario ON medicion.Usuario_idUsuario = usuario.idUsuario
INNER JOIN
	actividad ON actividad.id = medicion.Actividad_id
GROUP BY actividad.nombre, usuario.nombre;


-- ///////////////// VISTAS /////////////////////////////////
/* TEORÍA y un ejercicio
CREATE VIEW vista_reporte AS 
SELECT 
	usuario.idUsuario, usuario.nombre, 
    medicion.id as idMedicion, medicion.valor, medicion.Usuario_idUsuario, 
	unidadmedida.Nombre as unidadMedida,
    tipo_medicion.nombre as tipoMedicion, 
    actividad.nombre as actividad,
    pais.Nombre as pais
FROM
	usuario
INNER JOIN
	pais ON usuario.Pais_idPais = pais.idPais
INNER JOIN 
	medicion ON usuario.idUsuario = medicion.Usuario_idUsuario
INNER JOIN 
	unidadmedida ON medicion.UnidadMedida_Id = unidadmedida.Id
INNER JOIN 
	tipo_medicion ON medicion.Tipo_Medicion_id = tipo_medicion.id
INNER JOIN 
	actividad ON medicion.Actividad_id = actividad.id;
    
-- LLAMO LA VISTA
SELECT * FROM vista_reporte; 
-- LLAMO LA VISTA con cláusula WHERE
SELECT * FROM vista_reporte
WHERE idUsuario = 2;

-- MODIFICAR VISTA
-- ALTER VIEW vista_reporte AS SELECT * FROM actividad WHERE actividad.nombre = 'Ciclismo';

-- ELIMINAR VISTA

-- DROP VIEW nombre_vista; 


*/

-- ///////////////// ÍNDICES ////////////////////////////////
/* TEORÍA
Índice: 
Es una estructura de datos que mejora la velocidad de las consultas, por medio de un 
identificador único de cada fila de una tabla, permitiendo un rápido acceso a los registros
de una tabla de BD

Se usa cuando se realiza una consulta muchas veces sobre lo mismo para mejorar la performance. 
Un índice es una estructura adicional, donde elegimos 1 o más columnas que formarán parte del índice. 
Esto permitirá localizar de forma rápida las filas de la tabla en base a su contenido 
en la/las columna/s indexada/s.

Tenemos los tipos de índices: simple, compuesto, agrupado y no agrupado. Veamos un ejemplo de cada uno:
Simple: está definido sobre una sola columna:

CREATE INDEX "I_LIBROS_AUTOR" 
ON "LIBROS" (AUTOR);

Compuesto: está formado por varias columnas de la misma tabla.
CREATE INDEX "I_LIBROS_AUTOREDITORIAL" 
ON "LIBROS" (AUTOR,EDITORIAL);


Único: los valores deben ser únicos y diferentes. Si intentamos agregar un registro 
con un valor ya existente, aparece un mensaje de error. A su vez, puede ser simple o compuesto.
CREATE UNIQUE INDEX "I_LIBROS_AUTOR" 
ON "LIBROS" (AUTOR);

CREATE UNIQUE INDEX "I_LIBROS_AUTOREDITORIAL" 
ON "LIBROS" (AUTOR,EDITORIAL);


Índice agrupado (CLUSTERED): almacena los datos de las filas en orden. Solo se puede crear un único 
índice agrupado en una tabla de base de datos. Esto funciona de manera eficiente únicamente si los datos se ordenan en orden creciente o decreciente.

CREATE CLUSTERED INDEX "I_LIBROS_AUTOR" 
ON "LIBROS" (AUTOR);



Índice no agrupado: organiza los datos de forma aleatoria, pero el índice específica internamente un orden lógico. 
El orden del índice no es el mismo que el ordenamiento físico de los datos. Los índices no agrupados funcionan bien 
con tablas donde los datos se modifican con frecuencia y el índice se crea en las columnas utilizadas en orden por 
las declaraciones WHERE y JOIN.


CREATE NONCLUSTERED INDEX "I_LIBROS_AUTOR" 
ON "LIBROS" (AUTOR);


--------- SINTAXIS 
Crear índice

CREATE INDEX "NOMBRE_ÍNDICE" 
ON "NOMBRE_TABLA" (NOMBRE_COLUMNA);

Eliminar índice
ALTER TABLE "NOMBRE_TABLA"
DROP INDEX "NOMBRE_ÍNDICE";

Analizar tabla
Con ANALYZE TABLE analizamos y almacenamos la distribución de claves para una tabla:

ANALYZE TABLE "NOMBRE_TABLA";



*/

-- ///////////////// STORED PROCEDURES //////////////////////
/* TEORÍA
Son una estructura que almacena y engloba una cantidad de acciones (sentencias de SQL).

A la hora de consultar la base de datos, solo se ve el nombre del stored procedure (o SP), si necesita parámetros de entrada (input) o no, 
y el resultado (output) —si es que tiene—. No vemos qué sucede internamente.

Los SP (stored procedure) son un conjunto de instrucciones en formato SQL que se almacenan, compilan y ejecutan dentro del servidor de bases de datos. 
Pueden incluir parámetros de entrada y salida, devolver resultados tabulares o escalares, mensajes para el cliente e invocar instrucciones DDL y DML.
Por lo general, se los utiliza para definir la lógica del negocio dentro de la base de datos y reducir la necesidad de codificar dicha lógica en programas clientes.

*/
/* ******************** Estructura de un stored procedure

DELIMITER: Se escribe esta cláusula seguida de una combinación de símbolos que no serán utilizados en el interior del SP. 
CREATE PROCEDURE: Se escribe este comando seguido del nombre que identificará al SP.
BEGIN: Esta cláusula se utiliza para indicar el inicio del código SQL.
Bloque de instrucciones SQL.
END: Se escribe esta cláusula seguida de la combinación de símbolos definidos en DELIMITER y se utiliza para indicar el final del código SQL. 

DELIMITER $$
CREATE PROCEDURE sp_nombre_procedimiento()
BEGIN    
     -- Bloque de instrucciones SQL;
END $$


*/
/********************** Definición de un stored procedure

CREATE PROCEDURE: Crea un procedimiento almacenado.
CREATE PROCEDURE sp_nombre_procedimiento()

DROP PROCEDURE: Elimina un procedimiento almacenado. Se requiere del privilegio de ALTER ROUTINE.
DROP PROCEDURE [IF EXISTS] sp_nombre_procedimiento();




*/
/********************** Declaración de variables

Dentro de un SP se permite declarar variables que son elementos que almacenan datos que pueden ir cambiando a lo largo de la ejecución. 
La declaración de variables se coloca después de la cláusula BEGIN y antes del bloque de instrucciones SQL. 
Opcionalmente, se puede definir un valor inicial mediante la cláusula DEFAULT.

Sintaxis:
DECLARE nombre_variable TIPO_DE_DATO [DEFAULT valor];


Ejemplo:
DECLARE salario FLOAT DEFAULT 1000.00;


FUERA DEL SP se puede setear una variable y agregarle un valor así: 
SET @nombre_variable = 0;

SELECT @nombre_variable;  -- me muestra lo que tiene la variable

*/
/******************* Asignación de valores a variables
Para asignar un valor a una variable se utiliza la cláusula SET.
Las variables solo pueden contener valores escalares. Es decir, un solo valor.

Sintaxis:
SET nombre_variable = expresión;


Ejemplo:
DELIMITER $$
CREATE PROCEDURE sp_nombre_procedimiento()
BEGIN    
     DECLARE salario FLOAT DEFAULT 1000.00;
     SET salario = 25700.50;
END $$




*/
/*********** Parámetros

Los parámetros son variables por donde se envían y reciben datos de programas clientes.
Se definen dentro de la cláusula CREATE.
Los SP pueden tener uno, varios o ningún parámetro de entrada y asimismo, pueden tener uno, varios o ningún parámetro de salida.
Existen 3 tipos de parámetros:
 
IN > Entrada > Recibe datos
OUT > Salida > Devuelve datos
INOUT > Entrada-Salida > Recibe y devuelve datos

*/
/******* Declaración del parámetro IN
Es un parámetro de entrada de datos y se utiliza para recibir valores. Este parámetro viene definido por defecto cuando no se especifica su tipo.

Sintaxis:
CREATE PROCEDURE sp_nombre_procedimiento(IN param1 TIPO_DE_DATO, IN param2 TIPO_DE_DATO);

Ejemplo:
DELIMITER $$
CREATE PROCEDURE sp_nombre_procedimiento(IN id_usuario INT)
BEGIN    
     -- Bloque de instrucciones SQL;
END $$


Ejecución:
CALL sp_nombre_procedimiento(11);


*/
/******* Declaración del parámetro OUT
Es un parámetro de salida de datos y se utiliza para devolver valores. 

Sintaxis:
CREATE PROCEDURE sp_nombre_procedimiento(OUT param1 TIPO_DE_DATO, OUT param2 TIPO_DE_DATO);

Ejemplo:
DELIMITER $$
CREATE PROCEDURE sp_nombre_procedimiento(OUT salario FLOAT)
BEGIN    
     SET salario = 25700.50;
END $$

Ejecución:
CALL sp_nombre_procedimiento(@salario);
SELECT @salario; -- Bloque de instrucciones SQL

*/
/******* Declaración del parámetro INOUT
Es un mismo parámetro que utiliza para la entrada y salida de datos. Puede recibir valores y devolver los resultados en la misma variable.

Sintaxis:
CREATE PROCEDURE sp_nombre_procedimiento(INOUT param1 TIPO_DE_DATO, INOUT param2 TIPO_DE_DATO);

Ejemplo:
DELIMITER $$
CREATE PROCEDURE sp_nombre_procedimiento(INOUT aumento FLOAT)
BEGIN    
     SET aumento = aumento + 25700.50;
END $$

Ejecución:
SET @salario = 2000.00; -- Declaración y asignación de variable (dato)
CALL sp_nombre_procedimiento(@salario); -- Ejecución y envío de dato (2000.00)
SELECT @salario; -- Muestra el resultado



*/


-- ***************** Integración de instrucciones DDL y DML en SP
-- +++++++ INSTRUCCIONES DDL

/****** Instrucción CREATE TABLE

Dentro de un SP podemos utilizar diferentes instrucciones DDL. 
Si queremos crear una tabla para almacenar datos temporales, 
debemos introducir la instrucción CREATE TABLE dentro para crear dicha tabla.

DELIMITER $$
CREATE PROCEDURE sp_crear_tabla()
BEGIN    
     CREATE TABLE nombre_tabla (
          id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT, 
          descripcion VARCHAR(200));
END $$


CALL sp_crear_tabla();




*/
/****** Instrucción ALTER TABLE
Si requerimos modificar una tabla porque su estructura cambia de forma frecuente, 
introducimos la instrucción ALTER TABLE dentro de un SP.

DELIMITER $$
CREATE PROCEDURE sp_modificar_tabla()
BEGIN    
     ALTER TABLE nombre_tabla ADD COLUMN campo VARCHAR(50) NOT NULL;
END $$


CALL sp_modificar_tabla();


*/
/****** Instrucción DROP TABLE
Eliminar una tabla temporal, introducimos la instrucción DROP TABLE dentro de un SP.

DELIMITER $$
CREATE PROCEDURE sp_eliminar_tabla()
BEGIN    
     DROP TABLE IF EXISTS nombre_tabla;
END $$

CALL sp_eliminar_tabla();

*/




-- +++++++ INSTRUCCIONES DML con parámetros

/******* Instrucción INSERT
Dentro de un SP podemos utilizar diferentes instrucciones DML. 
Si queremos agregar un nuevo usuario llamado “DIEGO PEREZ”, 
debemos utilizar parámetros de entrada para que el SP reciba dichos datos. 
Estos datos, serán utilizados como valores en la instrucción INSERT.

DELIMITER $$
CREATE PROCEDURE sp_agregar_usuario(
     IN nombre VARCHAR(30), IN apellido VARCHAR(30))
BEGIN
     INSERT INTO usuario (nombre, apellido) VALUES (nombre, apellido);
END $$


CALL sp_agregar_usuario('DIEGO', 'PEREZ');


*/
/******* Instrucción UPDATE
También, podemos modificar los datos de una tabla. Por ejemplo, se 
necesita cambiar el nombre de un usuario llamado “DIEGO” por “PABLO”. 
Para esto, se utilizan parámetros de entrada para que el SP reciba dichos datos. 
Estos datos, serán utilizados como valores en la instrucción UPDATE.

DELIMITER $$
CREATE PROCEDURE sp_modificar_nombre_usuario(
     IN id INT, IN nombre VARCHAR(30))
BEGIN
     UPDATE usuario SET nombre = nombre WHERE id_usuario = id; 
END $$

CALL sp_modificar_nombre_usuario(1,'PABLO');


*/
/******* Instrucción DELETE
Podemos eliminar los datos de una tabla. Por ejemplo, se requiere 
borrar los datos de un usuario cuyo ID es 1. Entonces, se utilizan 
parámetros de entrada para que el SP reciba el valor del ID y tal 
valor será introducido en el WHERE de la instrucción DELETE.

DELIMITER $$
CREATE PROCEDURE sp_eliminar_usuario(IN id INT)
BEGIN
     DELETE FROM usuario WHERE id_usuario = id; 
END $$


CALL sp_eliminar_usuario(1);


*/
/******* Instrucción SELECT Con IN - OUT
La instrucción SELECT nos permite listar los datos de una tabla. 
Por ejemplo, se quiere saber cuál es el nombre del usuario con ID de valor 1. 
Para esto, se recibe el ID en un parámetro de entrada y el resultado se 
almacena en un parámetro de salida con la cláusula INTO.

DELIMITER $$
CREATE PROCEDURE sp_dame_nombre_usuario(
     INOUT id INT, OUT nom VARCHAR(30))
BEGIN
     SELECT nombre INTO nom FROM usuario WHERE id_usuario = id; 
END $$


CALL sp_dame_nombre_usuario(1,@nombre); -- Ejecución del SP y envía “1” como dato
SELECT @nombre; -- Muestra el resultado


*/
/******* Instrucción SELECT Con INOUT
Una variante del uso de esta instrucción podría ser utilizar un mismo 
parámetro para la entrada y la devolución del resultado. Por ejemplo, 
se quiere saber cuántos usuarios tienen en su nombre la letra “a”. 

DELIMITER $$
CREATE PROCEDURE sp_dame_nombre_usuario(INOUT valor VARCHAR(30))
BEGIN
      SELECT COUNT(*) INTO valor FROM usuario 
      WHERE nombre LIKE CONCAT('%', valor, '%');
END $$


SET @letra = 'a'; -- Declaración y asignación de una variable (dato)
CALL sp_dame_nombre_usuario(@letra); -- Ejecución del SP y envía “a” como dato
SELECT @letra; -- Muestra el resultado

*/



-- ///////////////// FUNCIONES ALMACENADAS //////////////////////

/* TEORÍA
¿Qué es una función almacenada?

Una función almacenada en MySQL es una rutina creada para 
tomar uno o más parámetros, realizarles algún procedimiento 
y retornar los resultados en un salida.

Pueden incluir parámetros solamente de entrada. 

Deben retornar un valor con algún tipo de dato definido.

Solo retornan un valor individual, no un conjunto de registros. 
A esto se le llaman resultados escalares.


Por lo general, se los utiliza para realizar cálculos sobre los datos, 
obteniendo así lo que llamamos datos derivados. De esta forma, 
se reduce la necesidad de codificar dicha lógica en programas clientes.


Podemos decir que las funciones son nuestras funciones de alteración personalizadas. Mayormente son utilizadas para cuando se necesitan atributos derivados de los datos de nuestras tablas y que se utilicen en varias consultas de nuestro negocio.

Otra ventaja es que el uso de funciones puede ayudar a mejorar en gran medida el rendimiento y la performance general del sistema.


*/

/* ******* Estructura de una función

CREATE FUNCTION: se escribe este comando seguido del nombre que identificará a la función.
RETURNS: se utiliza para indicar qué tipo de dato se retornará. La característica es para definir el tipo de función.
BEGIN: esta cláusula se utiliza para indicar el inicio del código SQL.


RETURN: utilizamos este comando para retornar el Bloque de instrucciones SQL.
END: se utiliza para indicar el final del código SQL.



CREATE FUNCTION nombre_function()
RETURNS [TIPO DE DATO] [CARACTERISTICA]
BEGIN
     RETURN -- Bloque de instrucciones SQL;
END




¡Ojo! A no confundir RETURNS con RETURN. 
La primera es para indicar el tipo de dato de retorno de la función 
y la segunda es para retornar el valor en el cuerpo de la función.



Si estamos trabajando sobre una query de trabajo, no olvidarse 
de usar el DELIMITER como se utilizan en los stored procedures.


*/

/* ******* Estructura de una función - Características

Después de la definición del tipo de dato, tenemos que indicar 
las características de la función. 
Las opciones disponibles son las siguientes:

1. DETERMINISTIC: indica que la función siempre devuelve el 
mismo resultado cuando se utilizan los mismos parámetros de entrada.

2. NOT DETERMINISTIC: indica que la función no siempre devuelve 
el mismo resultado, aunque se utilicen los mismos parámetros de entrada.

3. CONTAINS SQL: indica que la función contiene sentencias SQL, 
pero no contiene sentencias de manipulación de datos.

4. NO SQL: indica que la función no contiene sentencias SQL.

5. READS SQL DATA: indica que contiene sentencias de lectura de datos, 
como la sentencia SELECT.

6. MODIFIES SQL DATA: indica que la función modifica los datos de 
la base y que contiene sentencias como INSERT, UPDATE o DELETE.

*/

/* ******* Estructura de una función - Aclaraciones

Si no queremos especificar una característica a la función, 
debemos ejecutar el siguiente comando para que no nos muestre 
mensaje de error a la hora de crearla:

SET GLOBAL log_bin_trust_function_creators = 1;


*/

/* ******* Definición de una función

CREATE FUNCTION: crea una función.
CREATE FUNCTION nombre_function()


DROP FUNCTION: elimina una función. 
Se requiere del privilegio de ALTER ROUTINE.

DROP FUNCTION [IF EXISTS] nombre_function();

 
 */
 
/* ******* Declaración de variables · DECLARE

Dentro de una función se permite declarar variables, es decir, 
elementos que almacenan datos que pueden ir cambiando a lo largo 
de la ejecución. 
La declaración de variables se coloca después de la cláusula BEGIN 
y antes del bloque de instrucciones SQL. 
Opcionalmente, se puede definir un valor inicial mediante la 
cláusula DEFAULT.

Sintaxis:
DECLARE nombre_variable TIPO_DE_DATO [DEFAULT valor];

Ejemplo:
DECLARE salario FLOAT DEFAULT 1000.00;
 
 */

/* ******* Asignación de valores a variables · SET 

Para asignar un valor a una variable se utiliza la cláusula SET.
Las variables solo pueden contener valores escalares. 
Es decir, un solo valor.

Sintaxis:
SET nombre_variable = expresión;

Ejemplo:
CREATE FUNCTION agregar_IVA(precio_sin_impuestos DOUBLE(10,12))
RETURNS DOUBLE(10,12) DETERMINISTIC
BEGIN    
     DECLARE IVA INT DEFAULT 21;
     RETURN ((precio_sin_impuestos * IVA) / 100) + precio_sin_impuestos;
END

*/

/* ******* Parámetros en funciones

Los parámetros son variables por donde se envían y 
reciben datos de programas clientes.

Se definen dentro de la cláusula CREATE.

Las funciones pueden tener uno, varios o ningún parámetro de entrada.

No pueden ingresarse parámetros del tipo OUT o INOUT.


IN > Entrada > Recibe datos

*/ 

/* ******* Declaración del parámetro IN

Es un parámetro de entrada de datos y se utiliza para recibir valores. 
Este parámetro viene definido por defecto cuando no se especifica 
su tipo.

Sintaxis:
CREATE FUNCTION nombre_function(IN param1 TIPO_DE_DATO, IN param2 TIPO_DE_DATO);

Ejemplo:
CREATE FUNCTION nombre_function(IN id_usuario INT)
BEGIN    
     -- Bloque de instrucciones SQL;
END


Ejecución:
SELECT *, nombre_function(idUsuario) FROM usuarios;

*/

/* ******* Ejecución y ejemplos de funciones

CREATE FUNCTION categoria_sueldo(sueldo DOUBLE)
RETURNS VARCHAR(15) DETERMINISTIC
BEGIN
DECLARE categoria VARCHAR(15);
CASE WHEN sueldo < 200 THEN SET categoria = ‘Bajo’;
WHEN sueldo < 1000 THEN SET categoria = ‘Promedio’;
ELSE SET categoria = ‘Alto’; END CASE;
     RETURN categoria;
END

SELECT legajo, sueldo, categoria_sueldo(sueldo) FROM empleados;

*/ 



/* ******* C8
CURSOR
Procesa registro por registro el resultado de una consulta
Procesar resultados. 

TABLA TEMPORAL
Objeto de la BD que permite guardar datos temporalmente mientras 
estemos conectados en nuestra sesión. 
Las tablas temporales las podemos usar en caso de
que nuestra consulta necesita acceder varias veces a nuestro 
set de datos o bien para mejorar la performance.
Al ser temporal la tabla se eliminará cuando finalice la sesión

EJEMPLO STORED PROCEDURE, CURSOR Y TABLA TEMPORAL, LOOP, INSERTAR 10'V C8A

*/ 




/* ******* C10 1'v SUBCONSULTAS
- ESCALARES

- con EXISTS O NOT EXISTS

- RELACIONADAS




*/ 


/* ******* C10 5'v TRIGGERS
Objetos de BD que sirven para ejecutar código SQL luego 
de que se haya ejecutado una sentencia de Insert, Update o Delete 
sobre una tabla específica. 
Siempre están vinculados a una tabla
No se pueden definir para tablas personales ni vistas.


Los eventos que disparan el código del trigger son insert, update, 
delete y la ejecución del código de un trigger puede ser antes o después 
de un evento además como podemos crear varios trigger es para una 
misma tabla también podemos definir el orden de su ejecución

New > hace referencia al nuevo valor que recibe la tabla
Old > es el que está guardado en la tabla actualmente

Para modificar datos, reglas complejas y auditorías (más usado). 

7'V EJEMPLO INSERT TRIGGER BEFORE
	EJEMPLO UPDATE TRIGGER BEFORE

*/ 


/* ******* C10 11'V MANEJO DE ERRORES - HANDLERS

HANDLERS

CONDITIONS > nombres que podemos agregar a los errores 
Errores que vamos a capturar con nuestros handlers. 
15'V EJEMPLO CREACION DE CONDITIONS

*/ 


/* ******* C11A TRANSACCIONES
3'v EJEMPLO MODIFICAR ID DE UNA CANCIÓN QUE TAMBIÉN ESTÁ COMO FK EN OTRAS TABLAS. 
SET foreign_key_checks = 0; -> Para deshabilitar la validación de las FK para ejecutar 
el UPDATE de los registros sin problemas. 

SET foreign_key_checks = 1 -> Habilitamos la validación de las FK nuevamente

START TRANSACTION
COMMIT
ROLLBACK

5'V - NIVELES DE AISLAMIENTO [ ACID ]
 
*/ 

/* ******* C11S ESTRUCTURA STORED PROCEDURE, TRANSACTION, HANLDER

27'V ESTRUCTURA

29'V HANDLER GENERICO (9 A 17)

29'51 HANDLER
Si tenemos que hacer un cursor, para salir del bucle de un cursor usamos un handler
Si dejamos el handler genérico y no ponemos:
DECLARE CONTINUE HANLDER FOR NOT FOUND SET finished = 1;

lo que pasa es que va a entrar al handler genérico y va a hacer un rollback y en realidad no había pasado nada raro como para hacer rollback. 

Los DECLARE TIENEN UN ORDEN




*/ 




/* ******* 

*/ 

/* ******* 

*/ 

/* ******* 

*/ 

/* ******* 

*/ 

/* ******* 

*/ 

/* ******* 

*/ 
/* ******* 

*/ 


delimiter $$
 create procedure usp_reporte_diario_insertar_anio(anio smallInt) 
 begin
 declare NombreActividad,NombreMedicion,NombreUnidadMedida varchar(45);
 declare idUsuario int;
 declare Fecha date;
 declare promedio float;
 declare finished boolean;

 DECLARE curs1 CURSOR FOR SELECT ( SELECT actividad.nombre 'NombreActividad',
 tipo_medicion.nombre 'NombreMedicion',
 unidadmedida.Nombre 'NombreUnidadMedida',
 medicion.Usuario_idUsuario 'idUsuario',
 DATE(medicion.timestamp),
 ROUND(AVG(medicion.valor))
             FROM
                    medicion
                INNER JOIN 
                    usuario ON usuario.idUsuario = medicion.Usuario_idUsuario
                INNER JOIN 
                    unidadmedida ON medicion.UnidadMedida_Id = unidadmedida.Id
                INNER JOIN 
                    tipo_medicion ON medicion.Tipo_Medicion_id = tipo_medicion.id
                INNER JOIN 
                    actividad ON medicion.Actividad_id = actividad.id
                WHERE YEAR(medicion.timestamp) = anio
                GROUP BY actividad.nombre, tipo_medicion.nombre,unidadmedida.Nombre,
                medicion.Usuario_idUsuario, DATE(medicion.timestamp))
                limit 10;

 DECLARE CONTINUE HANDLER FOR NOT FOUND SET finished=1;
DECLARE EXIT HANDLER FOR SQLEXCEPTION
BEGIN
rollback;
SELECT 'Se ejecuto KO - Error SQL';
END;

OPEN curs1;
START transaction;
BEGIN
sumarMedDiar: LOOP
FETCH curs1 INTO NombreActividad,NombreMedicion,NombreUnidadMedida,idUsuario,Fecha,promedio;

    IF finished= 1 THEN 
        LEAVE sumarMedDiar;
    END IF;
    IF((SELECT udf_existe_reporteDiario(idUsuario , NombreActividad , NombreMedicion , _Date ))=0)THEN
        CALL usp_reporte_diario_insertar(NombreActividad ,NombreMedicion , NombreUnidadMedida , Fecha , Valor , idUsuario);
        END IF;
END LOOP;
CLOSE curs1;
COMMIT;
END;
END;
 $$
