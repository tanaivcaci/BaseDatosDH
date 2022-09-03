-- C17S - DESAFÍO - MUSIMUNDO Queries XXL: ¿Cómo se resuelve?

-- Realizar una consulta sobre la tabla canciones con la siguiente información:
-- Solo los 10 primeros caracteres del nombre de la canción en mayúscula.
-- La duración de la canción expresada en minutos. Ejemplo 5:10
-- El peso en kbytes en número entero (sin decimales, 1000 bytes = 1 kb)
-- El precio formateado con 3 decimales, Ej: $100.123
-- El primer compositor de la canción (notar que si hay más de uno, mostrar separados por coma)

CREATE VIEW consulta_rara as
SELECT substr(upper(nombre), 1, 10) as cancion, 
SEC_TO_TIME(ROUND(milisegundos/1000))  minutos,
ROUND(bytes/1000, 2) as kb,
FORMAT(precio_unitario, 3) as precio,
CASE
WHEN POSITION("," in compositor)-1 <> -1 then left(compositor,position("," in compositor)-1)
WHEN length(compositor) = 0 then "sin datos"
ELSE compositor
END AS compositor
FROM canciones; 

SELECT * FROM consulta_rara
WHERE compositor = "sin datos";