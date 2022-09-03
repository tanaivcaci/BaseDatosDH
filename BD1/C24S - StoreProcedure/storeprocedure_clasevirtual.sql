-- base musimundos
/* 1. a) Crear un Stored Procedure que reciba el nombre de un País y una ciudad, y que devuelva la información de contacto de todos los clientes de ese país y ciudad.
   En el caso que el parámetro de ciudad esté vacío, se debe devolver todos los clientes del país indicado.
   b) Invocar el procedimiento para obtener la información de los clientes de Brasilia en Brazil.
   c) Invocar el procedimiento para obtener la información de todos los clientes de Brazil.
*/

DELIMITER $$
CREATE PROCEDURE sp_clientes_por_ciudad(IN filtro_pais VARCHAR(14), IN filtro_ciudad VARCHAR(19))
BEGIN
	SELECT primer_nombre, apellido, direccion, ciudad, telefono
    FROM clientes
    WHERE pais = filtro_pais and (ciudad = filtro_ciudad or filtro_ciudad is null or filtro_ciudad = '');
END $$

Call sp_clientes_por_ciudad('Brazil', 'Brasilia');
Call sp_clientes_por_ciudad('Brazil', '');
Call sp_clientes_por_ciudad('Brazil', null);

DELIMITER $$
CREATE PROCEDURE sp_contacto_paisciudad (IN sppais varchar(14), IN spciudad varchar(19), OUT VAR1 varchar(20))
BEGIN
	IF length(spciudad) <> 0 THEN
		SELECT * FROM clientes
		WHERE PAIS = sppais AND CIUDAD = spciudad;
	ELSE
		SELECT * FROM clientes
		WHERE PAIS = sppais;
	END IF;
END
$$

CALL sp_contacto_paisciudad("Brazil", "Brasilia");
CALL sp_contacto_paisciudad("Brazil", null);

/*2.a) Crear un stored procedure que reciba como parámetro un nombre de género musical y lo inserte en la tabla generos.
       Además, el stored procedure debe devolver el id de género que se insertó.
       TIP! Para calcular el nuevo id incluir la siguiente línea dentro del bloque de código del SP:
       SET nuevoid = (SELECT MAX(id) FROM generos) + 1;
	b) Invocar el stored procedure creado para insertar el géneros Funk. ¿Qué id devolvió el SP ? Consultar la tabla de géneros para ver los cambios.
    c) Repetir el paso anterior insertando esta vez el género Tango.
*/ 

DELIMITER $$
CREATE PROCEDURE sp_insercion_genero(in nuevoGenero varchar(18), out nuevoid int)
BEGIN
	SET nuevoid = (select max(id) from generos)+1;
	INSERT INTO `musimundos`.`generos`
		(`id`,
		`nombre`)
		VALUES
		(nuevoid,
		nuevoGenero);
END;
$$

call sp_insercion_genero("Funk1", @var);
call sp_insercion_genero("Tango", @var);
select @var;