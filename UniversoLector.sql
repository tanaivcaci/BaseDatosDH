#CREATE SCHEMA UniversoLector; 
#USE UniversoLector; 

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
