SELECT * FROM dhfitness.medicion;
/*
1. Crear un sp que inserte un registro en la tabla ReporteDiario.
Nombre del sp: usp_reporte_diario_insertar
Parámetros de entrada: NombreActividad, NombreMedicion,
NombreUnidadMedida,Fecha, Valor, idUsuario
*/

delimiter $$
create procedure usp_reporte_diario_insertar(pNombreActividad varchar(45),pNombreMedicion varchar(45), pNombreUnidadMedida varchar(45), pFecha date, pValor float, pidUsuario int)
begin
	insert into reporteDiario(idReporte, NombreActividad ,NombreMedicion , NombreUnidadMedida , Fecha , Valor , Usuario_idUsuario)
    values(default,  pNombreActividad, pNombreMedicion, pNombreUnidadMedida, pFecha, pValor , pidUsuario );
end;
$$


/*
2. Crear una función que verifique si un registro en la tabla ReporteDiario ya existe.
Nombre de la función: udf_existe_reporteDiario
Parametros: idUsuario, NombreActividad, NombreMedicion, Date
Tipo de Resultado: TINYINT
Devolver 1 si en la tabla ReporteDiario existe un registro con TODOS los parametros
de entrada. Se puede utilizar lo siguiente para validar la existencia: SELECT EXISTS
(consulta)
*/

delimiter $$
create function udf_existe_reporteDiario(pidUsuario int, pNombreActividad varchar(45), pNombreMedicion varchar(45), pDate date)
returns TINYINT deterministic
begin
	declare existTable TINYINT;
    set existTable=(exists(select * from reportediario 
						where reportediario.NombreActividad=pNombreActividad
						 and reportediario.NombreMedicion=pNombreMedicion
						 and reportediario.Fecha=pDate
						 and reportediario.Usuario_idUsuario=pidUsuario));
    return existTable;
end;
$$
 -- select udf_existe_reporteDiario(1, "nadar", "metros","2022-08-02");
 
 /*
 3. Crear un sp que recorra todos los valores de las mediciones diarias de un año e
inserte los valores correspondientes en la tabla ReporteDiario. Tener en cuenta no
insertar registros duplicados en la tabla ReporteDiario.
Nombre Sp: usp_reporte_diario_insertar_anio
Parámetros Entrada: anio smallint

El sp debe de contener:
Un cursor: el cual recorrerá todas las mediciones para el año
Error handling: SQLEXCEPTION
Transacción: se tienen que insertar TODOS los valores si no hay errores. en caso de
haber error no insertar NINGÚN valor.

Notas
Además, se debe utilizar el sp creado en el ejercicio 1 y la función creada en el
ejercicio 2.
Mediciones diarias: promedio del campo valor por: usuario, unidad de medida, tipo de
medición y actividad
 */
 
 delimiter $$
 create procedure usp_reporte_diario_insertar_anio(anio smallInt) 
 begin
 declare NombreActividad varchar(45);
 declare NombreMedicion varchar(45);
 declare NombreUnidadMedida varchar(45);
 declare idUsuario int;
 declare Fecha date;
 declare promedio float;
 declare finished TINYINT DEFAULT 0;
 declare errorNumber int;
 declare message varchar(255);

 DECLARE curs1 CURSOR FOR SELECT ( SELECT actividad.nombre 'NombreActividad',
 tipo_medicion.nombre 'NombreMedicion',
 unidadmedida.Nombre 'NombreUnidadMedida',
 medicion.Usuario_idUsuario 'idUsuario',
 DATE(medicion.timestamp),
 ROUND(AVG(medicion.valor)) 'promedio'
			 FROM
					medicion
				INNER JOIN 
					usuario ON usuario.idUsuario = medicion.Usuario_idUsuario
				INNER JOIN 
					unidadmedida ON medicion.UnidadMedida_Id = unidadmedida.Id
				INNER JOIN 
					tipo_medicion ON medicion.Tipo_Medicion_id = tipo_medicion.id
				INNER JOIN 
					actividad ON medicion.Actividad_id = actividad.id
				WHERE YEAR(medicion.timestamp) = anio
				GROUP BY actividad.nombre, tipo_medicion.nombre,unidadmedida.Nombre,
                medicion.Usuario_idUsuario, DATE(medicion.timestamp))
                limit 10;
			
 DECLARE CONTINUE HANDLER FOR NOT FOUND SET finished=1;
DECLARE EXIT HANDLER FOR SQLEXCEPTION
BEGIN
GET DIAGNOSTICS CONDITION 1
                errorNumber    = MYSQL_ERRNO,
                message    = MESSAGE_TEXT;

rollback;
SELECT errorNumber, message;
END;
                
OPEN curs1;
START transaction;
BEGIN
sumarMedDiar: LOOP
FETCH curs1 INTO NombreActividad,NombreMedicion,NombreUnidadMedida,idUsuario,Fecha,promedio;
	
	IF finished= 1 THEN 
		LEAVE sumarMedDiar;
	END IF;
    IF( udf_existe_reporteDiario(idUsuario , NombreActividad , NombreUnidadMedida , Fecha )=0)THEN
		CALL usp_reporte_diario_insertar(NombreActividad ,NombreMedicion , NombreUnidadMedida , Fecha , promedio , idUsuario);
        END IF;
END LOOP;
CLOSE curs1;
COMMIT;
END;
END;
 $$
 call usp_reporte_diario_insertar_anio(2022);
 
 
 
 
 
 
