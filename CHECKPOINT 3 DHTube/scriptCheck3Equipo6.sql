-- 1. Generar un reporte que indique la cantidad de usuarios por país,
-- mostrando el nombre del país y su cantidad.

select p.nombre,count(u.idUsuario) as cantidad_usuario from usuario u
join pais p on u.pais_idpais = p.idPais
group by u.pais_idpais;

-- 2. Mostrar el Top 5 de avatars utilizados por los usuarios, listando el
-- nombre del avatar y la cantidad de veces utilizado.

select a.nombre,count(u.avatar_idAvatar) as Cantidad 
from avatar A
join usuario U
on A.idAvatar = U.Avatar_idAvatar
group by u.Avatar_idAvatar
order by Cantidad desc
limit 5;


-- 3. Emitir un listado de todas las playlists públicas, informando el nombre
-- del usuario que la creó, el título de cada video que posee y el nombre
-- y año de creación de la playlist.

SELECT playlist.idPlaylist AS ID, playlist.nombre AS Playlist, playlist.fechaCreacion AS "Fecha de creacion", video.titulo AS Videos, video.idVideo AS "ID de video", usuario.nombre AS Creador
FROM playlist, usuario, video
WHERE playlist.privado = 0
ORDER BY playlist.idPlaylist;


-- 4. Listar las 10 etiquetas menos usadas.

select e.idetiqueta, e.nombre, count(ve.Etiqueta_idEtiqueta) as cantidad_usadas
from video_etiqueta ve
join etiqueta e 
on e.idetiqueta = ve.etiqueta_idetiqueta
group by ve.video_idvideo
order by cantidad_usadas
limit 10;


-- 5. Generar un reporte de las últimas 10 reacciones, listando la fecha, el
-- nombre de la reacción, el id y nombre de usuario, y el título del video.

SELECT idReaccion, fecha, tiporeaccion.nombre, usuario.idUsuario, usuario.nombre, titulo
FROM reaccion
INNER JOIN tiporeaccion ON reaccion.TipoReaccion_idTipoReaccion = tiporeaccion.idTipoReaccion
INNER JOIN usuario ON usuario.idUsuario = reaccion.Usuario_idUsuario
INNER JOIN video ON reaccion.Video_idVideo = video.idVideo
ORDER BY fecha DESC
LIMIT 10;

-- 6. Mostrar por usuario la cantidad de playlists que posee, pero solo para
-- aquellos que tengan más de 1 playlist creada en el año 2021.

select * from playlist
where YEAR(fechaCreacion) >= 2021



# 7. Generar un reporte de las reacciones generadas en el 2021, con el siguiente formato: 
# Nombre de Reacción Nombre de Usuario Título de Video Fecha

SELECT tiporeaccion.nombre as 'Nombre de Reaccion', 
usuario.nombre as 'Nombre Usuario', 
titulo as 'Titulo Video', 
reaccion.fecha as 'Fecha Reaccion'
FROM reaccion
INNER JOIN tiporeaccion ON reaccion.TipoReaccion_idTipoReaccion = tiporeaccion.idTipoReaccion
INNER JOIN usuario ON usuario.idUsuario = reaccion.Usuario_idUsuario
INNER JOIN video ON reaccion.Video_idVideo = video.idVideo
WHERE YEAR(reaccion.fecha) = 2021;


-- 8. Listar la cantidad de videos según sean públicos o privados.

SELECT count(*) AS Cantidad_Videos,
CASE 
WHEN privado = 1 THEN 'Privado'
WHEN privado = 0 THEN 'Publico'
END AS Visibilidad
FROM video
GROUP BY privado;


-- 9. Generar un reporte con los nombres de los usuario que no poseen
-- ninguna Playlist.

select u.nombre, p.idplaylist
from usuario u
left join playlist p
on u.idUsuario = p.Usuario_idUsuario
where p.idplaylist is null;



-- 10.Listar todos los videos hayan o no recibido reacciones en el último
-- mes; indicar cuántas reacciones tuvieron y si han sido reproducidos o
-- no. El listado debe estar ordenado alfabéticamente por título del vídeo.

select v.*,
count(r.idReaccion) as Cantidad_Reacciones,
case 
when length(v.cantidadReproducciones) > 0 then 'Si'
else 'No'
end as Reproducido
from video v
left join reaccion r
on r.video_idvideo = v.idvideo
where month(r.fecha) = 05
group by v.idVideo
order by v.titulo;



-- 11. Generar un reporte con el nombre del usuario y el título de 
-- videos del usuario que no pertenecen a ninguna playlist.

SELECT u.nombre as 'Nombre Usuario' , v.titulo as 'Titulo video'
FROM usuario u
INNER JOIN video v ON v.Usuario_idUsuario = u.idUsuario
LEFT JOIN playlist_video ON v.idVideo = playlist_video.video_idVideo
WHERE Playlist_idPlaylist IS NULL;



-- 12.Listar a todos los usuarios que no poseen ningún video.

select u.nombre, v.idVideo
from usuario u
left join video v
on u.idUsuario = v.Usuario_idUsuario
where v.idVideo is null;


-- 13.Listar la cantidad total de reacciones por cada tipo de reacción, en el
-- período del 01-01-2021 al 01-04-2021

SELECT TipoReaccion_idTipoReaccion, COUNT(idReaccion) FROM reaccion
WHERE reaccion.fecha BETWEEN "2021-01-01 00:00:00" AND "2021-04-01 00:00:00"
GROUP BY TipoReaccion_idTipoReaccion
ORDER BY TipoReaccion_idTipoReaccion;



-- 14.Listar los videos que tienen los usuarios cuyo nombre contiene la letra
-- “a” y son del país Argentina.

select u.nombre, v.titulo, p.nombre
from usuario u
inner join video v on u.idUsuario = v.Usuario_idUsuario
inner join pais p on u.pais_idpais = p.idpais
where u.nombre like "%a%"
 and p.nombre = "Argentina";

-- 15.Generar un informe estilo ranking de avatars utilizados por país. 
SELECT avatar.nombre AS NombreAvatar, pais.nombre AS Nacionalidad, count(Pais_idPais) as CantidadPorPais
FROM avatar
INNER JOIN usuario ON avatar.idAvatar =  usuario.Avatar_idAvatar
INNER JOIN pais ON usuario.Pais_idPais = pais.idPais
GROUP BY pais.nombre, avatar.nombre
ORDER BY count(Pais_idPais) DESC;


-- 16.Generar un reporte de todos los videos, mostrando los que poseen
-- reacciones y cuántas veces han sido reproducidos.

SELECT *
FROM video v
join reaccion r on v.idVideo = r.video_idvideo;



-- 17.Mostrar los 5 videos de menor duración, listando el título del vídeo y el
-- nombre de usuario y país al que corresponde.

SELECT titulo as 'Titulo Video', u.nombre as 'Nombre Usuario', p.nombre as pais
FROM video v
INNER JOIN usuario u ON u.idUsuario = v.Usuario_idUsuario
INNER JOIN pais p ON p.idPais = u.Pais_idPais
ORDER BY duracion ASC
LIMIT 5; 



-- 18. Listar el usuario brasilero con más reacciones durante el 2021.

SELECT u.*, 
COUNT(r.usuario_idusuario) AS Reacciones
FROM usuario u 
join pais p on u.pais_idPais = p.idPais
INNER JOIN reaccion r
ON u.idUsuario = r.Usuario_idUsuario
WHERE p.nombre = "Brasil"
order by reacciones
limit 1;



-- 19. Generar un reporte listando los usuarios, sus canales, playlists y los
-- videos que integran esas playlists.

SELECT usuario.nombre as 'Nombre Usuario', canal.nombre as 'canal' , playlist.nombre as 'playlist', video.titulo as video
FROM usuario
INNER JOIN canal ON usuario.idUsuario = canal.Usuario_idUsuario
INNER JOIN playlist ON playlist.Usuario_idUsuario = usuario.idUsuario
INNER JOIN playlist_video ON playlist_video.Playlist_idPlaylist = playlist.idPlaylist
INNER JOIN video ON playlist_video.Video_idVideo = video.idVideo;



-- 20. Listar todas las playlists que posean menos de 3 videos, mostrando el
-- nombre de usuario y el avatar que posee.


select count(pv.video_idvideo) as cantidad 
from playlist p
join 
playlist_video pv on p.idplaylist = pv.playlist_idplaylist
where count(video_idvideo) < 3 
group by pv.video_idvideo;

