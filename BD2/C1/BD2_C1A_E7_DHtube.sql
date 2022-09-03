/*
Selección de nombre usuario, título de video y duración dónde el video dure menos de 600000 ms
*/
SELECT u.nombre, v.titulo, v.duracion from usuario AS u
INNER JOIN video AS v ON u.idUsuario = v.Usuario_idUsuario
WHERE v.duracion < 600000;


/*
Contar cantidad de reacciones de los usuarios
*/
SELECT u.nombre, u.idUsuario, COUNT(r.idReaccion) 
FROM usuario AS u
INNER JOIN reaccion as r
ON u.idUsuario = r.Usuario_idUsuario
GROUP BY u.idUsuario;



/*
Contar cantidad de reacciones de los usuarios que tengan más de 6 reacciones
*/
SELECT u.nombre, u.idUsuario, COUNT(r.idReaccion) 
FROM usuario AS u
INNER JOIN reaccion as r
ON u.idUsuario = r.Usuario_idUsuario
GROUP BY u.idUsuario
HAVING COUNT(r.idReaccion) >=6;


/*
Listar usuarios que no tienen email
*/
SELECT * from usuario AS u
WHERE email IS NULL;


/*
Listar títulos de videos que tengan en el título "Tutorial"
*/
SELECT * from video as v
WHERE v.titulo LIKE '%Tutorial%';

/*
Ordenar el segundo video con mayor cantidad de likes
*/
SELECT v.titulo, v.cantidadLikes FROM video AS v
ORDER BY v.cantidadLikes desc
LIMIT 1 offset 1;



/* listar playlist por usuario ordenado por usuario desc 
cantidad de videos en cada playlist
cantidad de usuarios por pais agrupado por nombre de pais
listar las reacciones de cada video agrupandola por el nombre
listar usuarios sin tener playlist creadas */

SELECT playlist.nombre, usuario.nombre FROM usuario
INNER JOIN playlist ON usuario.idUsuario = playlist.Usuario_idUsuario
ORDER BY usuario.nombre DESC;

SELECT COUNT(video.idVideo) AS Videos, playlist.nombre FROM video
INNER JOIN playlist_video ON video.idVideo = playlist_video.Video_idVideo
INNER JOIN playlist ON playlist.idPlaylist = playlist_video.Playlist_idPlaylist
GROUP BY playlist.nombre;

SELECT COUNT(usuario.idUsuario), pais.nombre FROM usuario
INNER JOIN pais ON pais.idPais = usuario.Pais_idPais
GROUP BY pais.nombre;

SELECT video.titulo, tiporeaccion.nombre FROM reaccion
INNER JOIN tiporeaccion ON tiporeaccion.idTipoReaccion = reaccion.TipoReaccion_idTipoReaccion
INNER JOIN video ON video.idVideo = reaccion.Video_idVideo
GROUP BY video.titulo;

SELECT usuario.nombre FROM usuario
LEFT JOIN playlist ON usuario.idUsuario = null

-- 1. Cuántos videos tiene la playlist
select count(video.idVideo) as cantidad, playlist.idPlaylist, playlist.nombre
from video
inner join playlist_video
on video.idVideo = playlist_video.Video_idVideo
inner join playlist
on playlist.idPlaylist = playlist_video.Playlist_idPlaylist
group by playlist.idPlaylist, playlist.nombre;

-- 2. Cuántos usuarios hay de cada país
select count(usuario.idUsuario) as cant_users, pais.nombre as pais
from usuario
inner join pais
on usuario.Pais_idPais = pais.idPais
group by pais.nombre;

-- 3. cuantos avatar hay en cada pais?
select pais.nombre, count(*) as cant_avatars from usuario 
inner join avatar
on usuario.Avatar_idAvatar=avatar.idAvatar
inner join pais 
on usuario.Pais_idPais = pais.idPais
group by Pais_idPais;

-- 4. Cantidad de reacciones que tiene el video Shake it off de usuarios de Argentina
select count(reaccion.idReaccion) as cant_reacciones, video.titulo as cancion
from video
inner join reaccion
on video.idVideo = reaccion.Video_idVideo
inner join usuario
on usuario.idUsuario = reaccion.Usuario_idUsuario
inner join pais
on pais.idPais = usuario.Pais_idPais
where video.titulo = 'Shake It Off' and pais.nombre = 'Argentina';

-- 5. 
select count(etiqueta.idEtiqueta) as etiqueta_mas_usada, etiqueta.nombre
from video
inner join video_etiqueta
on video.idVideo=video_etiqueta.Video_idVideo
inner join etiqueta 
on etiqueta.idEtiqueta=video_etiqueta.Etiqueta_idEtiqueta
group by etiqueta.nombre
order by etiqueta_mas_usada desc
limit 1;


SELECT pais.nombre, COUNT(usuario.idUsuario) cantidadUsuarios
FROM dhtube.usuario
INNER JOIN pais ON pais.idPais = usuario.Pais_idPais
GROUP BY pais.nombre
HAVING cantidadUsuarios !=0
ORDER BY cantidadUsuarios DESC
LIMIT 5
OFFSET 2;

SELECT usuario.nombre, video.titulo  
FROM dhtube.usuario
INNER JOIN video ON video.Usuario_idUsuario = usuario.idUsuario
WHERE usuario.fechaNacimiento > "2000-01-01";

SELECT * FROM playlist
INNER JOIN reaccion on reaccion.Usuario_idUsuario = playlist.Usuario_idUsuario
ORDER BY playlist.idPlaylist DESC;

SELECT * FROM dhtube.video
WHERE titulo in ("Shake It Off","Faded")
ORDER BY titulo;

SELECT * FROM dhtube.video
WHERE duracion > 300000 AND duracion < 800000 AND nombreArchivo LIKE "%tutorial%";


-- Contar los usuarios por Pais
SELECT count(*),  p.nombre
FROM usuario as u 
INNER JOIN pais p on u.Pais_idPais = p.idPais
GROUP BY p.nombre;
-- Contar las playlist por Usuario
SELECT count(p.idPlaylist), u.nombre
FROM usuario u
INNER JOIN playlist p ON p.Usuario_idUsuario = u.idUsuario
GROUP BY u.nombre;
-- Titulo del video que contenga la palabra Tutorial
SELECT v.titulo
FROM video v 
WHERE v.titulo LIKE "%Tutorial%";
-- Videos que tengan mas Likes que Dislikes y Tengan entre 3000 y 6000 likes
SELECT * 
FROM video v
WHERE v.cantidadLikes > v.cantidadDislikes 
AND v.cantidadLikes BETWEEN 3000 AND 6000;
-- Top 10 de videos por su reproducciones
SELECT v.titulo, v.cantidadReproducciones
FROM video v 
ORDER BY cantidadReproducciones DESC
limit 10 ;


-- 1Generar un reporte que indique la cantidad de usuarios por país,
-- mostrando el nombre del país y su cantidad.

SELECT count(idUsuario) as 'cant_usuarios', pais.nombre as 'nombre_pais'
FROM usuario
inner join  pais ON pais_idPais = pais.idpais
group by pais.nombre;



-- 2. Mostrar el Top 5 de avatars utilizados por los usuarios, listando el
-- nombre del avatar y la cantidad de veces utilizado.

SELECT count(Avatar_idAvatar) as 'cantidad_avatar' , avatar.nombre as 'nombre_avatar'
FROM usuario
inner join avatar ON avatar.idAvatar = Avatar_idAvatar
group by idAvatar
order by cantidad_avatar DESC
limit 5;

-- 3. Emitir un listado de todas las playlists públicas, informando el nombre
-- del usuario que la creó, el título de cada video que posee y el nombre
-- y año de creación de la playlist.

SELECT  playlist.nombre as 'nombre_playlist', playlist.fechaCreacion , playlist.privado , usuario.nombre as 'nombre_usuario', video.titulo as 'titulo_video'
FROM playlist 
inner join usuario ON Usuario_idUsuario = idUsuario
inner join playlist_video ON Playlist_idPlaylist = idPlaylist
inner join video ON Video_idVideo = idVideo
WHERE playlist.privado = 0;



-- 4. Listar las 10 etiquetas menos usadas.

SELECT count(etiqueta.idEtiqueta) as 'cantidad_etiqueta_por_video', etiqueta.nombre as 'nombre_etiqueta'
FROM video
inner join video_etiqueta ON Video_idVideo = idVideo
inner join  etiqueta ON Etiqueta_idEtiqueta = idEtiqueta
group by  etiqueta.idEtiqueta
order by cantidad_etiqueta_por_video
limit 10;

-- select * from etiqueta

-- 5. Generar un reporte de las últimas 10 reacciones, listando la fecha, el
-- nombre de la reacción, el id y nombre de usuario, y el título del video.

-- SELECT 





select count(idPais) as cantidadDeUsuarios, pais.nombre from usuario
inner join pais on pais.idPais = usuario.Pais_idPais
group by pais.idPais;


select count(playlist.privado) as cantidadDePlaylistPublicas from playlist
group by playlist.privado
having playlist.privado = 0;


select usuario.nombre, tiporeaccion.nombre, video.titulo from reaccion
inner join video on video.idVideo = reaccion.Video_idVideo
inner join usuario on usuario.idUsuario = reaccion.Usuario_idUsuario
inner join tiporeaccion on tiporeaccion.idTipoReaccion = reaccion.TipoReaccion_idTipoReaccion;

SELECT usuario.idUsuario, usuario.nombre, canal.idCanal, canal.nombre
FROM usuario
INNER JOIN canal
on usuario.idUsuario = canal.Usuario_idUsuario
WHERE usuario.nombre like 'e%';

SELECT usuario.idUsuario, usuario.nombre, usuario.fechaNacimiento
FROM usuario
ORDER BY usuario.fechaNacimiento DESC
LIMIT 1;


/*1*/ 
select count(usuario.idUsuario) as Usuarios, pais.nombre from usuario
inner join pais
on usuario.Pais_idPais = pais.idpais
group by pais.nombre;

/*2*/
select usuario.nombre as Creador,
playlist.privado as Publica,
playlist.nombre as 'Nombre Playlist',
playlist.fechaCreacion as 'Fecha de Creación',
video.titulo as 'Título Video'
from playlist
inner join usuario on usuario.idUsuario = playlist.Usuario_idUsuario
inner join playlist_video on playlist.idPlaylist = playlist_video.Playlist_idPlaylist
inner join video on playlist_video.Video_idVideo = video.idVideo
where playlist.privado = 0;

/*3*/ 
select usuario.nombre, count(idPlaylist) as cantiPlaylist 
from playlist inner join usuario on playlist.Usuario_idUsuario = usuario.idUsuario 
where playlist.fechaCreacion between '2021-01-01' and '2021-12-31' 
group by usuario.nombre
having cantiPlaylist > 1;

/*4*/
select usuario.nombre, playlist.idPlaylist FROM usuario
left join playlist on usuario.idUsuario = playlist.Usuario_idUsuario 
where playlist.Usuario_idUsuario IS NULL;

/*5*/
select count(reaccion.idReaccion) as CantReaccion, video.titulo, video.cantidadReproducciones,
case
 when video.cantidadReproducciones > 0 then 'Tiene' 
 when video.cantidadReproducciones = 0 then 'No tiene'
end as Reproducciones
from reaccion
inner join video on reaccion.video_idVideo = video.idVideo 
group by video.titulo
order by video.titulo;


select idUsuario as ID, nombre as Nombre, email as 'E-mail', fechaNacimiento as 'Fecha de Nacimiento', (year(now())- year(fechaNacimiento)) as Edad ,  Pais_idPais as 'Codigo de Pais'
from usuario; 

select nombre, password
from usuario
where length(password) < 5;

select *
from video
where descripcion LIKE "%FAN%";

select *
from video
order by cantidadReproducciones desc
limit 1;

select count(idVideo)
from video v
inner join playlist_video pv on v.idVideo = pv.Video_idVideo
inner join playlist p on pv.Playlist_idPlaylist = p.idPlaylist
where titulo like "Python%";


