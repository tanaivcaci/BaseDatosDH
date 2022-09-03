-- sp

delimiter $$
create procedure usp_reporte_diario_insertar(NombreActividad varchar(45),NombreMedicion varchar(45), NombreUnidadMedida varchar(45), Fecha date, Valor float, idUsuario int)
begin
    insert into reporteDiario(idReporte, NombreActividad ,NombreMedicion , NombreUnidadMedida , Fecha , Valor , Usuario_idUsuario)
    values(default,  NombreActividad, NombreMedicion, NombreUnidadMedida, Fecha, Valor , idUsuario );
end;
$$

-- fx
delimiter $$
create function udf_existe_reporteDiario(idUsuario int, NombreActividad varchar(45), NombreMedicion varchar(45), _Date date)
returns TINYINT deterministic
begin
    declare existTable TINYINT;
    set existTable=(exists(select * from reportediario 
                        where reportediario.NombreActividad=NombreActividad
                         and reportediario.NombreMedicion=NombreMedicion
                         and reportediario.Fecha=_Date
                         and reportediario.Usuario_idUsuario=idUsuario));
    return existTable;
end;
$$
 -- select udf_existe_reporteDiario(1, "nadar", "metros","2022-08-02");
 
 
 
 -- punto 3
 
 