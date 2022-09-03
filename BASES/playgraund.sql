INSERT INTO `playground`.`categoria`
(`idCategoria`, `nombre`)
VALUES
(1, "Alumno"),
(2, "Docente"),
(3, "Editor"),
(4, "Administrador");

DELETE FROM `playground`.`categoria`
WHERE nombre = "Editor";

DELETE FROM `playground`.`categorias`
WHERE nombre = "Alumno";

