/* 1. Listar todos los países que contengan la letra A, ordenada alfabéticamente. */

SELECT * FROM pais WHERE nombre LIKE '%a%' ORDER BY nombre ASC;

/* 2. Generar un listado de los usuarios, con el detalle de todos sus datos, el avatar que
poseen y a qué país pertenecen. */

SELECT usuario.*, pais.nombre as pais, avatar.nombre as avatar 
FROM usuario
INNER JOIN pais on usuario.Pais_idPais = pais.idPais
INNER JOIN avatar on usuario.Avatar_idAvatar = avatar.idAvatar;




/* 3. Confeccionar un listado con los usuarios que tienen playlists, mostrando la cantidad 
que poseen.*/

SELECT usuario.idUsuario ,usuario.nombre, COUNT(playlist.Usuario_idUsuario) 
FROM usuario
INNER JOIN playlist ON usuario.idUsuario = playlist.Usuario_idUsuario
GROUP BY usuario.idUsuario;

SELECT * FROM playlist; 

/* 4. Mostrar todos los canales creados entre el 01/04/2021 y el 01/06/2021.*/
SELECT *
FROM canal
WHERE fechaCreacion BETWEEN '2021-04-01 00:00:00' and '2021-06-01 00:00:00';



/* 5. Mostrar los 5 videos de menor duración, listando el título del vídeo, la o las etiquetas
que poseen, el nombre de usuario y país al que corresponden.*/



/* 6. Listar todas las playlists que posean menos de 3 videos, mostrando el nombre de
usuario y el avatar que poseen.*/



/* 7. Insertar un nuevo avatar y asignarlo a un usuario.*/




/* 8. Generar un informe estilo ranking de avatares utilizados por país.*/


/*
9. Insertar un usuario con los siguientes datos:
a. Nombre: Roberto Rodriguez
b. E-mail: rrodriguez@dhtube.com
c. Password: rr1254
d. Fecha de nacimiento: 01 de noviembre de 1975
e. Código postal: 1429
f. País: Argentina
g. Avatar: carita feliz
*/




/*
10. Generar un reporte de todos los videos y sus etiquetas, pero solo de aquellos cuyos
nombres de la etiqueta contengan menos de 10 caracteres, ordenado
ascendentemente por la cantidad de caracteres que posea la etiqueta.
*/



