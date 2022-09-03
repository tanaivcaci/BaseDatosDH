#Use Adventure Works

#Triggers 

#Crear la tabla Employee_Age_Hist con los mismos campos que la tabla y ademas los campos: 
#la fecha de creacion, fecha de modificacion, usuario creacion, usuario de modificacion. 
#Crear un trigger que cuando inserta los valores en la tabla Employee_Age, inserte los registros correpondientes en la tabla Employee_Age_Hist


#DROP table Employee_Age_Hist
CREATE TABLE Employee_Age_Hist(firstName VARCHAR(50), LastName varchar(50), age tinyint, CreatedDate datetime, ModifiedDAte datetime, CreatedUser varchar(20), ModifiedUser varchar(20));


DELIMITER $$
CREATE TRIGGER trg_After_Insert_Employee_Age 
before INSERT 
ON Employee_Age FOR each row 

BEGIN 

insert into Employee_Age_Hist(FirstName, LastName, Age, CreatedDate, ModifiedDAte, CreatedUser, ModifiedUser) values
(New.FirstName, New.LastName, New.Age,NOW(), NOW(), CURRENT_USER(), CURRENT_USER() );

END; $$


#TEST
#drop procedure usp_Employee_Age_Insertar
DELIMITER $$
CREATE PROCEDURE usp_Employee_Age_Insertar(pi_FirstName varchar(50), pi_LastName VARCHAR(50), IN pi_edad tinyint) 
BEGIN 

INSERT INTO Employee_Age(FirstName, LastName, Age)VALUES (pi_FirstName, pi_LastName, pi_edad);

END;
$$ 

CALL usp_Employee_Age_Insertar('Digital', 'House', 33)

select * from Employee_Age_Hist;

#Modificar el procedimiento usp_Employee_Age_Insertar para que permita insertar los valores a la tabla Employee_Age y que ademas se inserte en la tabla Employee_Age_Hist los mismos resultados con 
#la fecha de creacion, fecha de modificacion, usuario creacion, usuario de modificacion. La creacion de la tabla tiene que estar en un handler
#La edad tiene que ser parametro de entrada en el procedimiento almacenado.

#Use Adventure Works

#Triggers 

#Crear la tabla Employee_Age_Hist con los mismos campos que la tabla y ademas los campos: 
#la fecha de creacion, fecha de modificacion, usuario creacion, usuario de modificacion. 
#Crear un trigger que cuando inserta los valores en la tabla Employee_Age, inserte los registros correpondientes en la tabla Employee_Age_Hist


#DROP table Employee_Age_Hist
CREATE TABLE Employee_Age_Hist(firstName VARCHAR(50), LastName varchar(50), age tinyint, CreatedDate datetime, ModifiedDAte datetime, CreatedUser varchar(20), ModifiedUser varchar(20));


DELIMITER $$
CREATE TRIGGER trg_After_Insert_Employee_Age 
before INSERT 
ON Employee_Age FOR each row 

BEGIN 

insert into Employee_Age_Hist(FirstName, LastName, Age, CreatedDate, ModifiedDAte, CreatedUser, ModifiedUser) values
(New.FirstName, New.LastName, New.Age,NOW(), NOW(), CURRENT_USER(), CURRENT_USER() );

END; $$


#TEST
#drop procedure usp_Employee_Age_Insertar
DELIMITER $$
CREATE PROCEDURE usp_Employee_Age_Insertar(pi_FirstName varchar(50), pi_LastName VARCHAR(50), IN pi_edad tinyint) 
BEGIN 

INSERT INTO Employee_Age(FirstName, LastName, Age)VALUES (pi_FirstName, pi_LastName, pi_edad);

END;
$$ 

CALL usp_Employee_Age_Insertar('Digital', 'House', 33)

select * from Employee_Age_Hist

#Modificar el procedimiento usp_Employee_Age_Insertar para que permita insertar los valores a la tabla Employee_Age y que ademas se inserte en la tabla Employee_Age_Hist los mismos resultados con 
#la fecha de creacion, fecha de modificacion, usuario creacion, usuario de modificacion. La creacion de la tabla tiene que estar en un handler
#La edad tiene que ser parametro de entrada en el procedimiento almacenado.



#DROP table Employee_Age_Hist
#DROP PROCEDURE usp_Employee_Age_Insertar
DELIMITER $$
CREATE PROCEDURE usp_Employee_Age_Insertar(pi_FirstName varchar(50), pi_LastName VARCHAR(50), IN pi_edad tinyint) 
BEGIN 

DECLARE CONTINUE HANDLER FOR 1146 
BEGIN 
	SELECT 'Tabla Employee_Age_Hist no Existe';
	CREATE TABLE Employee_Age_Hist(firstName VARCHAR(50), LastName varchar(50), age tinyint, CreatedDate datetime, ModifiedDAte datetime, CreatedUser varchar(20), ModifiedUser varchar(20));
	SELECT 'Se creo la tabla Employee_Age_Hist';
	INSERT INTO Employee_Age_Hist(firstName , LastName, age, CreatedDate , ModifiedDAte , CreatedUser , ModifiedUser) 
	VALUES (pi_FirstName,pi_LastName, pi_edad, now(), now(), current_user(), current_user());

END;

INSERT INTO Employee_Age(FirstName, LastName, Age)VALUES (pi_FirstName, pi_LastName, pi_edad);

INSERT INTO Employee_Age_Hist(firstName , LastName, age, CreatedDate , ModifiedDAte , CreatedUser , ModifiedUser) 
VALUES (pi_FirstName,pi_LastName, pi_edad, now(), now(), current_user(), current_user() );

END;
$$ 



#SubConsultas

#Escribir una consulta que devuelva un producto de un vendedor que se haya recibido el 10-09-2001 y tambien el 13-09-2001. Ademas, mostrar la cantidad de prodcutos del vendedor.

select * , (select count(*) from productvendor pv2 where pv2.VendorID = v.VendorID ) as VendorQuant
from productvendor pv 
inner join vendor v 
	on pv.VendorID = v.VendorId 
where 
	exists (
		select * 
			from productvendor pv2 
			where year(pv2.lastReceiptDate) = 2001 
			and month(pv2.lastReceiptDate) = 09
            and day(pv2.lastReceiptDate) = 10
            and pv.ProductID = pv2.ProductID
    )
    
and exists (
		select * 
			from productvendor pv3 
			where year(pv3.lastReceiptDate) = 2001 
			and month(pv3.lastReceiptDate) = 09
            and day(pv3.lastReceiptDate) = 13
            and pv.ProductID = pv3.ProductID
    )


select productID, count(*) from productvendor
group by productID 
having count(*) > 1

select * from productvendor where productID in (375)
