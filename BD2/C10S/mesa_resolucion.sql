/* 1. Necesitamos crear auditoría para la tabla donde se guardan las cuotas. Necesitamos
saber quién modifica y quién elimina cuotas. Crear una solución implementando
triggers. */

CREATE TABLE auditoria (usarie VARCHAR(45), tiempo DATETIME, nombre_tabla VARCHAR(45), id_registro TINYINT, accion_realizada VARCHAR(45));

DELIMITER $$
CREATE TRIGGER add_user_updater
AFTER UPDATE ON cuotas FOR EACH ROW
	INSERT INTO `dhprestamos`.`auditoria`
	(`usarie`, tiempo, nombre_tabla, id_registro, accion_realizada)
	VALUES (CURRENT_USER(), NOW(), 'cuotas', NEW.idcuotas, 'Update');
$$

DELIMITER $$
CREATE TRIGGER add_user_deleter
AFTER DELETE ON cuotas FOR EACH ROW
	INSERT INTO `dhprestamos`.`auditoria`
	(`usarie`, tiempo, nombre_tabla, id_registro, accion_realizada)
	VALUES (CURRENT_USER(), NOW(), 'cuotas', OLD.idcuotas, 'Delete');
$$

SELECT `cuotas`.`idcuotas`,
    `cuotas`.`idprestamo`,
    `cuotas`.`fecha`,
    `cuotas`.`importe`
FROM `dhprestamos`.`cuotas`;

UPDATE `dhprestamos`.`cuotas`
SET `importe` = 4000
WHERE `idcuotas` = 5;

SELECT `auditoria`.*
FROM `dhprestamos`.`auditoria`;

DELETE FROM `dhprestamos`.`cuotas`
WHERE idcuotas = 5;

/* 2. Necesitamos agregar en el sp sp_Genera_Cuota, un handlers para todas aquellas
SQLEXCEPTIONS. */

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `SP_Genera_cuota`(IN pImporte decimal(10,2) , pFechaInicio date, pCuotas int)
BEGIN
	declare valorCuota decimal(10,2) default 1;
    declare vCuota int ;
    declare fechaCuota date;
    
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
		SELECT("Se ejecutó un excepción SQL y abandonamos el procedimiento!");
    END;
    
    set vCuota = 1;
    
    
    /* Valor de la cuota */
    set valorCuota = (pImporte / pCuotas) ;
	
    /*Creacion de tabla temporal para las cuotas */
    Drop table tmpCuotas;
    CREATE TEMPORARY TABLE tmpCuotas
		(nrocuota int, fecha date, importe decimal(10,2));
    
    set fechaCuota = pFechaInicio;
    WHILE vCuota <= pCuotas DO
		/*Select vCuota,valorCuota, fechaCuota;*/
        insert into tmpCuotas (nrocuota,fecha,importe) values  
        (vCuota,fn_diahabil(fechaCuota),valorCuota);
       set fechaCuota = Date_add(fechaCuota,Interval 30 day);
		Set vCuota = vCuota +1 ;
    END WHILE;
	Select 
		nrocuota as 'Nro de Cuota ',
        DATE_FORMAT(fecha,'%d %M %Y') as 'Fecha de Cuota',
        importe as 'Valor Cuota'
    from tmpCuotas;
END
$$

/* 3. Crear una consulta que devuelva todas las cuotas a vencer en el siguiente día hábil y
que, además, el importe pagado hasta el momento sea menor al 30% del total del
préstamo. */