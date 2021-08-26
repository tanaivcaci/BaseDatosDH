CREATE SCHEMA UniversoLector; 
USE UniversoLector; 

CREATE TABLE UniversoLector.Socio (
    codigo INT NOT NULL, 
    dni VARCHAR(100) NULL,
    apellido VARCHAR(100) NULL,
    nombres VARCHAR(100) NULL,
    direccion VARCHAR(200) NULL, 
    localidad VARCHAR(100) NULL,
    PRIMARY KEY (codigo)
);

CREATE TABLE UniversoLector.Editorial (
    codigo INT NOT NULL,
    razon_social VARCHAR(100) NULL,
    telefono VARCHAR(100) NULL,
    PRIMARY KEY (codigo)
);

CREATE TABLE UniversoLector.Autor (
    codigo INT NOT NULL,
    apellido VARCHAR(100) NULL,
    nombres VARCHAR(100) NULL,
    PRIMARY KEY (codigo)
);

CREATE TABLE UniversoLector.TelefonoxSocio (
    codigo INT NOT NULL,
    nro_telefono VARCHAR(100) NULL,
    codigo_socio INT NULL,
    PRIMARY KEY (codigo),
        FOREIGN KEY (codigo_socio)
        REFERENCES UniversoLector.Socio (codigo)
);

CREATE TABLE Libro (
    codigo INT NOT NULL,
    isbn VARCHAR(13) NULL,
    titulo VARCHAR(200) NULL,
    anio_escritura DATE,
    anio_edicion DATE,
    codigo_autor INT NULL,
    codigo_editorial INT NULL,
    PRIMARY KEY (codigo),
        FOREIGN KEY (codigo_autor)
        REFERENCES UniversoLector.Autor (codigo),
        FOREIGN KEY (codigo_editorial)
        REFERENCES UniversoLector.Editorial (codigo)
);

CREATE TABLE Volumen (
    codigo INT NOT NULL,
    deteriorado BOOL,
    codigo_libro INT NULL,
    PRIMARY KEY (codigo),
        FOREIGN KEY (codigo_libro)
        REFERENCES UniversoLector.Libro (codigo)
);

CREATE TABLE Prestamo (
    codigo INT NOT NULL,
    fecha DATETIME,
    fecha_devolucion DATE,
    fecha_tope DATE,
    codigo_socio INT NULL,
    PRIMARY KEY (codigo),
        FOREIGN KEY (codigo_socio)
        REFERENCES UniversoLector.Socio (codigo)
);

CREATE TABLE PrestamoxVolumen (
    codigo INT NOT NULL,
    codigo_prestamo INT NOT NULL,
    codigo_volumen INT NOT NULL,
    PRIMARY KEY (codigo),
        FOREIGN KEY (codigo_prestamo)
        REFERENCES UniversoLector.Prestamo (codigo),
        FOREIGN KEY (codigo_volumen)
        REFERENCES UniversoLector.Volumen (codigo)
);

INSERT INTO `UniversoLector`.`Autor` (`codigo`, `apellido`, `nombres`) 
VALUES ('1', 'Rowling', 'J. K.');

INSERT INTO `UniversoLector`.`Editorial` (`codigo`, `razon_social`, `telefono`) VALUES ('1', 'Bloomsbury Publishing', '54911564874');
INSERT INTO `UniversoLector`.`Editorial` (`codigo`, `razon_social`, `telefono`) VALUES ('2', 'Scholastic', '223483646');
INSERT INTO `UniversoLector`.`Editorial` VALUES ('3', 'Pottermore Limited', '5694839582');
INSERT INTO `UniversoLector`.`Editorial` VALUES ('4', 'Editorial Salamandra', '0112392343');

INSERT INTO `UniversoLector`.`Libro` 
(`codigo`, `isbn`, `titulo`, `anio_escritura`, `anio_edicion`, `codigo_autor`, `codigo_editorial`) 
VALUES ('1', '9781907545009', 'Harry Potter y la piedra filosofal', '1997-01-01', '1997-01-01', '1', '4');
INSERT INTO `UniversoLector`.`Libro` 
(`codigo`, `isbn`, `titulo`, `anio_escritura`, `anio_edicion`, `codigo_autor`, `codigo_editorial`) 
VALUES ('2', '9789878000114', 'Harry Potter Y La Camara Secreta ', '2020-01-01', '2020-01-01', '1', '4');

INSERT INTO `UniversoLector`.`Socio` (`codigo`, `dni`, `apellido`, `nombres`, `direccion`, `localidad`) VALUES ('1', '3000000', 'PATRICIA', 'JOHNSON', '28 MySQL Boulevard', 'QLD');
INSERT INTO `UniversoLector`.`Socio` (`codigo`, `dni`, `apellido`, `nombres`, `direccion`, `localidad`) VALUES ('2', '2988800', 'LINDA', 'WILLIAMS', '23 Workhaven Lane', 'Alberta');
INSERT INTO `UniversoLector`.`Socio` (`codigo`, `dni`, `apellido`, `nombres`, `direccion`, `localidad`) VALUES ('3', '2500000', 'BARBARA', 'JONES', '1411 Lillydale Drive', 'QLD');
INSERT INTO `UniversoLector`.`Socio` (`codigo`, `dni`, `apellido`, `nombres`, `direccion`, `localidad`) VALUES ('4', '32980002', 'LOIS', 'BUTLER', '1688 Okara Way', 'Nothwest Border Prov');
INSERT INTO `UniversoLector`.`Socio` (`codigo`, `dni`, `apellido`, `nombres`, `direccion`, `localidad`) VALUES ('5', '2313909', 'ROBIN', 'HAYES', '262 A Corua (La Corua) Parkway', 'Dhaka');

INSERT INTO `UniversoLector`.`Volumen` (`codigo`, `deteriorado`, `codigo_libro`) VALUES ('1', '0', '1');
INSERT INTO `UniversoLector`.`Volumen` (`codigo`, `deteriorado`, `codigo_libro`) VALUES ('2', '0', '1');
INSERT INTO `UniversoLector`.`Volumen` (`codigo`, `deteriorado`, `codigo_libro`) VALUES ('3', '0', '2');

INSERT INTO `UniversoLector`.`Prestamo` (`codigo`, `fecha`, `fecha_devolucion`, `fecha_tope`, `codigo_socio`) VALUES ('2', '2020-01-07', '2020-01-15', '2020/01/14', '1');
INSERT INTO `UniversoLector`.`Prestamo` (`codigo`, `fecha`, `fecha_devolucion`, `fecha_tope`, `codigo_socio`) VALUES ('3', '2020-03-04', '2020-03-08', '2020-11-03', '2');

INSERT INTO `UniversoLector`.`PrestamoxVolumen` (`codigo`, `codigo_prestamo`, `codigo_volumen`) VALUES ('1', '1', '1');
INSERT INTO `UniversoLector`.`PrestamoxVolumen` (`codigo`, `codigo_prestamo`, `codigo_volumen`) VALUES ('2', '2', '2');
INSERT INTO `UniversoLector`.`PrestamoxVolumen` (`codigo`, `codigo_prestamo`, `codigo_volumen`) VALUES ('3', '3', '1');
INSERT INTO `UniversoLector`.`PrestamoxVolumen` (`codigo`, `codigo_prestamo`, `codigo_volumen`) VALUES ('4', '3', '3');

