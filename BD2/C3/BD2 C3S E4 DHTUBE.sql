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
select * from video v 
join video_etiqueta ve on v.idVideo = ve.Etiqueta_idEtiqueta 
join etiqueta e on ve.Etiqueta_idEtiqueta = e.idEtiqueta 
join usuario u on v.Usuario_idUsuario = u.idUsuario
join pais p on p.idPais = u.Pais_idPais order by duracion limit 5;



/* 6. Listar todas las playlists que posean menos de 3 videos, mostrando el nombre de
usuario y el avatar que poseen.*/
select p.*, u.*, a.*, count(*) cantidad from playlist p 
join playlist_video pv on p.idPlaylist = pv.Playlist_idPlaylist
join video v on pv.Video_idVideo = v.idVideo
join usuario u on p.Usuario_idUsuario = u.idUsuario
join avatar a on a.idAvatar = u.Avatar_idAvatar
group by p.idPlaylist
having cantidad < 3;


/* 7. Insertar un nuevo avatar y asignarlo a un usuario.*/
insert into avatar values (default, "bla bla bla","https://www.google.com/search?q=Captain Phasma+star+wars");
update usuario set Avatar_idAvatar=86
where idUsuario=19;

SELECT * FROM usuario;

insert into avatar(nombre,urlimagen)
values ("ketwol","https://www.google.com/search?q=Ketwol");

update usuario
set Avatar_idAvatar=(select avatar.idAvatar from avatar where avatar.nombre="ketwol")
where usuario.idUsuario=19;



/* 8. Generar un informe estilo ranking de avatares utilizados por país.*/
select count(usuario.idUsuario) as cantidad_de_usuarios, avatar.nombre as avatar, pais.nombre as pais
from usuario
inner join pais
on usuario.Pais_idPais=pais.idPais
inner join avatar
on usuario.Avatar_idAvatar=avatar.idAvatar
where usuario.Avatar_idAvatar is not null
group by usuario.Pais_idPais
order by cantidad_de_usuarios desc;

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


insert into usuario(nombre,email,password,fechaNacimiento,codigoPostal,Pais_idPais,Avatar_idAvatar)
values("Roberto Rodriguez","rrodriguez@dhtube.com","rr1254","1975-09-01",1429
,(select pais.idPais from pais where nombre="Argentina"),(select avatar.idAvatar from avatar where nombre="carita feliz"));



/*
10. Generar un reporte de todos los videos y sus etiquetas, pero solo de aquellos cuyos
nombres de la etiqueta contengan menos de 10 caracteres, ordenado
ascendentemente por la cantidad de caracteres que posea la etiqueta.
*/

select video.*, length(etiqueta.nombre) as nro_caracteres, etiqueta.nombre as etiqueta from video
inner join video_etiqueta 
on video_etiqueta.Video_idVideo=video.idVideo
inner join etiqueta
on video_etiqueta.Etiqueta_idEtiqueta=etiqueta.idEtiqueta
group by video_etiqueta.Etiqueta_idEtiqueta
having max(nro_caracteres)<10
order by nro_caracteres asc;

