DELIMITER $$
CREATE FUNCTION tinyint_to_bool(dato TINYINT)
RETURNS CHAR(2) DETERMINISTIC
BEGIN
RETURN (CASE WHEN dato = 0 THEN 'No' ELSE 'Si' END);
END $$


SELECT titulo, descripcion, tinyint_to_bool(privado) AS privado FROM video;


SELECT * FROM video; 

SELECT nombreArchivo, REVERSE(nombreArchivo) FROM video; 

SELECT nombreArchivo, REVERSE(nombreArchivo) as reverses, LOCATE() FROM video; 
-- me falto uno

SELECT nombreArchivo, REVERSE(nombreArchivo) AS reverses, LOCATE('.', REVERSE(nombreArchivo)) AS locates, 
	RIGHT(nombreArchivo, LOCATE('.', REVERSE(nombreArchivo)) -1) as ext FROM video; 

