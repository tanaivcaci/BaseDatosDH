# 1. Listar todos los usuarios cuyo nombre comience con la letra “a”.
select * from usuario
where nombre like 'a%';

# 2. Listar todos los usuarios que no hayan cargado el email.
select * from usuario
where email is null;

# 3. Mostrar todos los canales creados entre el 01/04/2021 y el 01/06/2021.
select * from canal
where fechaCreacion between '2021-04-01' and '2021-06-01';

# 4. Listar los 10 usuarios más jóvenes.
select * from usuario
order by fechaNacimiento DESC
limit 10;

#5. Mostrar todas las playlists que sean privadas.
select * from playlist
where privado = 1;

#6. Listar el top 5 de videos con más cantidad de likes.
select * from video
order by cantidadLikes DESC
limit 5;

#7. Insertar un usuario con los siguientes datos:
INSERT INTO `DHtubeII`.`usuario`
(`idUsuario`, 
`nombre`, 
`email`, 
`password`, 
`fechaNacimiento`, 
`codigoPostal`, 
`Pais_idPais`, 
`Avatar_idAvatar`)
VALUES
(20, 'Juan Jose Batzal', 'jjbatzal@gmail.com', 'jj1597', '2000-04-01', 1429, 9, 85);

#8. Generar un listado con todos los usuarios que hayan nacido en el año 2000.
select * from usuario
where fechaNacimiento like '2000%';

#9. Listar todos los países ordenados alfabéticamente y su nombre en mayúsculas.
select upper(nombre) as nombre
from pais;

#10.Listar todos los videos que posean más de 500.000 reproducciones.
select * from video
where cantidadReproducciones > 500000;

#11. Generar un reporte de todos los videos publicados en el año 2020 que sean privados y que posean más de 100 dislikes.
select * from video
where fechaPublicacion like '2020%' and cantidadDislikes > 100 and privado = 1;

#12.Por error hemos cargado mal los datos de Juan Jose Batzal. La fecha de nacimiento no era 01/04/2000, 
#sino 04/01/2000. Ahora debemos crear y ejecutar la sentencia necesaria para realizar la modificación.
UPDATE `DHtubeII`.`usuario`
SET
fechaNacimiento = '2000-01-04'
WHERE idUsuario = 20;

#13.Listar todos los usuarios cuyo password contenga menos de 5 caracteres (pista: ver la función length()).
select * from usuario
where length(password)<5;

#14. Generar un reporte de los usuarios. En la consulta mostrar los siguientes títulos:

SELECT idUsuario AS ID, nombre AS Nombre, email AS 'E-mail',  
fechaNacimiento AS 'Fecha de Nacimiento', TIMESTAMPDIFF(YEAR, fechaNacimiento, CURDATE()) AS Edad,  
Pais_idPais AS "Codigo de Pais" FROM usuario;

select idUsuario as ID, nombre as Nombre, email as 'E-mail', fechaNacimiento as 'Fecha de Nacimiento',
fechaNacimiento as Edad, Pais_idPais as 'Codigo de Pais'
from usuario;

#15.Listar el video de mayor tamaño.
select * from video
order by duracion desc
limit 1;

# 16.Generar un reporte de las últimas 10 reacciones, listando la fecha, el código de reacción, el ID de usuario y el video.
select idReaccion, fecha, Usuario_idUsuario, Video_idVideo
from reaccion
order by fecha desc
limit 10;

# 17.Listar todos los videos que tengan menos de 100.000 reproducciones y 100 o ás likes.
select * from video
where cantidadReproducciones < 100000 and cantidadLikes >99;

# 18.Mostrar todos los videos que incluyan la palabra “FAN” dentro de su descripción.
select * from video
where descripcion like '%fan%';

#19.Generar un listado de los usuarios cuyos passwords sean aquellos que no satisfacen las políticas de seguridad de la empresa.
select * from usuario
where password in ('123', '1234', '12345', 'abc', 'clave', 'password');

#20.Eliminar el avatar cuyo nombre sea avDhTube.
SET sql_safe_updates = 0;
DELETE FROM `DHtubeII`.`avatar`
WHERE nombre = 'avDhtube';





