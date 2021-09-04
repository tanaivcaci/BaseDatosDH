USE Proyecto_Spotify;
SELECT * FROM cancion; 

#1. Listar las canciones que poseen la letra “z” en su título.
SELECT * FROM cancion
WHERE titulo like '%z%'; 

# 2. Listar las canciones que poseen como segundo carácter la letra “a” y como último, la letra “s”.
SELECT * FROM cancion
WHERE titulo like '_a%s'; 

# 3. Mostrar la playlist que tiene más canciones, renombrando las columnas poniendo mayúsculas en la primera letra, 
# los tildes correspondientes y agregar los espacios entre palabras.
SELECT 
idPlaylist AS 'ID Playlist', 
idUsuario AS 'ID Usuario', 
titulo AS 'Título', 
cantcanciones AS 'Cantidad Canciones',
idestado AS 'ID Estado', 
Fechacreacion AS 'Fecha Creación',
Fechaeliminada AS 'Fecha Eliminada'
FROM playlist 
WHERE cantcanciones 
ORDER BY cantcanciones 
DESC LIMIT 1;


# 4. En otro momento se obtuvo un listado con los 5 usuarios más jóvenes, obtener un listado de los 10 siguientes.
SELECT * FROM usuario
ORDER BY fecha_nac DESC
LIMIT 10
OFFSET 5;

# 5. Listar las 5 canciones con más reproducciones, ordenadas descendentemente.
SELECT * FROM cancion
ORDER BY cantreproduccion DESC
LIMIT 5;

# 6. Generar un reporte de todos los álbumes ordenados alfabéticamente.
SELECT * FROM album
ORDER BY titulo; 

# 7. Listar todos los álbumes que no tengan imagen, ordenados alfabéticamente.
SELECT * FROM album
WHERE imagenportada IS NULL
ORDER BY titulo; 


# 8. Insertar un usuario nuevo con los siguientes datos (tener en cuenta las relaciones):
# 8.a) nombreusuario: nuevousuariodespotify@gmail.com
# 8.b) Nombre y apellido: Elmer Gomez
# 8.c) password: S4321m
# 8.d) Fecha de nacimiento: 15/11/1991
# 8.e) Sexo: Masculino
# 8.f) Código Postal: B4129ATF
# 8.g) País: Colombia

SELECT * FROM Proyecto_Spotify.usuario;

INSERT INTO `Proyecto_Spotify`.`usuario`
(`idUsuario`,
`nombreusuario`,
`nyap`,
`fecha_nac`,
`sexo`,
`CP`,
`password`,
`Pais_idPais`,
`IdTipoUsuario`)
VALUES
(20,
'nuevousuariodespotify@gmail.com',
'SELECT * FROM Proyecto_Spotify.usuario;',
'1991-11-15',
'M',
'B4129ATF',
'S4321m',
'2',
'3');


# 9. Eliminar todas las canciones de género “pop”. 
# pop (tiene id 9 en la tabla genero)

SELECT * FROM generoxcancion
WHERE idGenero = 9;

SELECT idCancion FROM generoxcancion
WHERE idGenero = 9; 

SELECT * FROM cancion; 


# Acá borro de la tabla intermedia todas las concurrencias que tienen idGenero = 9 (pop) 
# DELETE FROM generoxcancion
# WHERE idGenero = 9;


# DELETE FROM cancion 
# WHERE idCancion IN (6, 7, 8, 9, 11, 12, 13, 14, 15, 18, 19, 20, 21, 22, 23, 24, 25, 79, 85, 130, 133);

DELETE FROM cancion 
WHERE idCancion IN (SELECT idCancion FROM generoxcancion WHERE idGenero = 9);


# 10. Editar todos los artistas que no tengan una imagen cargada y cargarles el texto “Imagen faltante” en
# la columna de imagen.
SELECT * FROM Proyecto_Spotify.artista
WHERE imagen IS NULL;

UPDATE `Proyecto_Spotify`.`artista`
SET
`imagen` = 'Imagen faltante'
WHERE `imagen` IS NULL;

SELECT * FROM Proyecto_Spotify.artista
WHERE imagen = 'Imagen faltante';

set sql_safe_updates = 1;