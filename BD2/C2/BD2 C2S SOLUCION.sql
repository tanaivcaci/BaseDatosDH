/* 1. Mostrar las personas cuya segunda letra de su apellido sea una 
“a”. 
Tablas: Contact 
Campos: LastName 

*/
SELECT FirstName, LastName from contact
where LastName like '_a%';

/* 2. Mostrar el nombre concatenado con el apellido de las personas que tengan como “Title” los valores “Mr.” y “Ms.” 
Tablas: Contact 
Campos: FirstName, LastName, Title 
*/
select Title, concat(FirstName, ' ', LastName ) NombreYApellido from contact
where title = 'Mr.' or title = 'Ms.';


/* 3. Mostrar los nombres de los productos cuyo número de producto 
comiencen con “AR” o “BE” o “DC”. 
Tablas: Product 
Campos: Name, ProductNumber 
*/
select ProductID, Name, ProductNumber from product
where ProductNumber like 'AR%' or ProductNumber like 'BE%' or ProductNumber like 'DC%';

select Name, ProductNumber
from product
where SUBSTRING(ProductNumber,1,2) IN ('AR','BE','DC');

/*4. Mostrar las personas cuyos nombres tengan una C como primer caracter y que el segundo caracter no sea ni “O”, ni “E”. 
Tablas: Contact 
Campos: FirstName 
*/

SELECT FirstName, LastName from contact
where FirstName like 'c%' and (FirstName not like 'co%' and FirstName not like 'ce%');

select FirstName from contact where (FirstName like "C%") and (FirstName not like "_O%") or (FirstName not like  "_E%"); 



select ProductID, Name, ProductNumber, ListPrice from product
where ListPrice between 400 and 500;



