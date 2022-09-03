
#CLASE 8 - CAMADA 4 
#Use AdventureWorks
#Modificar el procedimiento usp_Employee_Age_Insertar_bulk para que permita insertar los valores a la 
# tabla Employee_Age utilizando el Procedimiento almacenado usp_Employee_Age_Insertar
#La edad tiene que ser parametro de entrada en el procedimiento almacenado.

/*CREATE VIEW vi_Employee AS 
SELECT 
    c.FirstName as 'Nombre'
    , c.LastName as 'Apellido'
    , udf_Age_Get(e.BirthDate) as 'Edad'
FROM  employee e 
INNER JOIN contact c 
    ON e.ContactID = c.ContactID;*/

DELIMITER $$
CREATE PROCEDURE usp_Employee_Age_Insertar(pi_FirstName varchar(50), pi_LastName VARCHAR(50), IN pi_edad tinyint) 
BEGIN 

INSERT INTO Employee_Age(FirstName, LastName, Age) VALUES (pi_FirsName, pi_LastName, pi_edad);

END;
$$ 

#Utilizando un cursor

DELIMITER $$
CREATE PROCEDURE usp_Employee_Age_Insertar_Bulk_Cursor(IN pi_edad tinyint) 
BEGIN 

DECLARE v_nombre, v_apellido VARCHAR(50); # Variables auxilaries que vamos utilizar en cada uno de los regitros
DECLARE v_edad TINYINT;

DECLARE finished INT DEFAULT 0; # Declaracion de la variable para validar si es el final de la cantidad de registros

DECLARE cur1 CURSOR FOR SELECT * FROM vi_employee WHERE edad = pi_edad; # Declaracion del cursor

DECLARE CONTINUE HANDLER FOR NOT FOUND SET finished = 1; # Handler para capturar la excepcion de que no hay mas registros

OPEN cur1; # Abrir Cursor

recorre: LOOP # Abro el LOOP
	FETCH cur1 INTO v_nombre, v_apellido, v_edad; # asigno los valores del registro a las variables
    
	IF finished = 1 THEN #valido si no mas registros
		LEAVE recorre;
	END IF;

	CALL usp_Employee_Age_Insertar(v_nombre, v_apellido, v_edad); #llamo al storeprocedure

END LOOP; #cierro el LOOP

CLOSE cur1; #cierro el cursor

END;
$$ 

SELECT * FROM vi_employee WHERE edad = 45

CALL usp_Employee_Age_Insertar_Bulk_Cursor(45)

SELECT * FROM Employee_Age


#Tablas Temporales
#Crear una tabla temporal que tenga nombre y apellido y cantidad de la vista vi_employee. 
#Luego realizar las siguientes consultas: 1-Listar los nombres que se repitan. 2-Listar los apellido que se repitan. 3-Listar los nombres y apellidos que se repitan.

create temporary table if not exists t_employee 
select * from vi_employee;

select  Nombre, count(*) from t_employee group by Nombre having count(*) > 1;
select  apellido, count(*) from t_employee group by apellido having count(*) > 1;
select  Nombre, apellido, count(*) from t_employee group by Nombre, apellido having count(*) > 1;





#Ejercicio 1 utilizando Cursor y Tabla Temporal
#Utilizando cursor y tabla temporal

DELIMITER $$
CREATE PROCEDURE usp_Employee_Age_Insertar_Bulk(IN pi_edad tinyint) 
BEGIN 
DECLARE nombre, apellido VARCHAR(50);
DECLARE edad TINYINT;

DECLARE finished INT DEFAULT 0; # Declaracion de la variable para validar si es el final de la cantidad de registros

DECLARE  cur1 CURSOR FOR SELECT * FROM t_employee; #Cursor

DECLARE CONTINUE HANDLER FOR NOT FOUND SET finished = 1; # Handler para capturar la excepcion de que no hay mas registros

CREATE  TEMPORARY  TABLE IF NOT EXISTS t_employee #Tabla temporal
SELECT * FROM vi_Employee WHERE edad = pi_edad;

OPEN cur1;

recorre: LOOP
FETCH cur1 INTO nombre, apellido, edad;

IF finished = 1 THEN #valido si no mas registros
		LEAVE recorre;
	END IF;

CALL usp_Employee_Age_Insertar(nombre, apellido, edad);

END LOOP;
CLOSE cur1;

DROP TABLE t_employee;

END;
$$ 






