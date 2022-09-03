-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema spotify-equipo2
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema spotify-equipo2
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `spotify-equipo2` DEFAULT CHARACTER SET utf8 ;
USE `spotify-equipo2` ;

-- -----------------------------------------------------
-- Table `spotify-equipo2`.`artista`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `spotify-equipo2`.`artista` (
  `idArtista` INT NOT NULL,
  `nombreArtista` VARCHAR(45) NULL DEFAULT NULL,
  `imgArtista` BLOB NULL DEFAULT NULL,
  PRIMARY KEY (`idArtista`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `spotify-equipo2`.`discografica`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `spotify-equipo2`.`discografica` (
  `idDiscografica` INT NOT NULL,
  `nombreDiscografica` VARCHAR(45) NULL DEFAULT NULL,
  `paisDiscografica` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`idDiscografica`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `spotify-equipo2`.`album`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `spotify-equipo2`.`album` (
  `idAlbum` INT NOT NULL,
  `titulo` VARCHAR(45) NULL DEFAULT NULL,
  `publicacion` YEAR NULL DEFAULT NULL,
  `imgPortada` BLOB NULL DEFAULT NULL,
  `artista_idArtista` INT NOT NULL,
  `discografica_idDiscografica` INT NOT NULL,
  PRIMARY KEY (`idAlbum`, `artista_idArtista`, `discografica_idDiscografica`),
  INDEX `fk_album_artista1_idx` (`artista_idArtista` ASC) VISIBLE,
  INDEX `fk_album_discografica1_idx` (`discografica_idDiscografica` ASC) VISIBLE,
  CONSTRAINT `fk_album_artista1`
    FOREIGN KEY (`artista_idArtista`)
    REFERENCES `spotify-equipo2`.`artista` (`idArtista`),
  CONSTRAINT `fk_album_discografica1`
    FOREIGN KEY (`discografica_idDiscografica`)
    REFERENCES `spotify-equipo2`.`discografica` (`idDiscografica`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `spotify-equipo2`.`cancion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `spotify-equipo2`.`cancion` (
  `idCancion` INT NOT NULL,
  `tituloCancion` VARCHAR(45) NULL DEFAULT NULL,
  `duracionSeg` INT NULL DEFAULT NULL,
  `reproduccion` BIGINT NULL DEFAULT NULL,
  `like` BIGINT NULL DEFAULT NULL,
  `album_idAlbum` INT NOT NULL,
  PRIMARY KEY (`idCancion`, `album_idAlbum`),
  INDEX `fk_cancion_album1_idx` (`album_idAlbum` ASC) VISIBLE,
  CONSTRAINT `fk_cancion_album1`
    FOREIGN KEY (`album_idAlbum`)
    REFERENCES `spotify-equipo2`.`album` (`idAlbum`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `spotify-equipo2`.`genero`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `spotify-equipo2`.`genero` (
  `idgenero` INT NOT NULL,
  `nombreGenero` VARCHAR(45) NULL DEFAULT NULL,
  `cancion_idCancion` INT NOT NULL,
  PRIMARY KEY (`idgenero`, `cancion_idCancion`),
  INDEX `fk_genero_cancion1_idx` (`cancion_idCancion` ASC) VISIBLE,
  CONSTRAINT `fk_genero_cancion1`
    FOREIGN KEY (`cancion_idCancion`)
    REFERENCES `spotify-equipo2`.`cancion` (`idCancion`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `spotify-equipo2`.`password`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `spotify-equipo2`.`password` (
  `idPassword` INT NOT NULL,
  `vencimiento` DATETIME NULL DEFAULT NULL,
  `pass` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`idPassword`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `spotify-equipo2`.`usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `spotify-equipo2`.`usuario` (
  `idUsuario` INT NOT NULL,
  `mail` VARCHAR(100) NULL DEFAULT NULL,
  `fechaDeNacimiento` DATE NULL DEFAULT NULL,
  `sexo` TINYINT NULL DEFAULT NULL,
  `codigoPostal` CHAR(5) NULL DEFAULT NULL,
  `pais` VARCHAR(100) NULL DEFAULT NULL,
  `password_idPassword` INT NOT NULL,
  PRIMARY KEY (`idUsuario`, `password_idPassword`),
  INDEX `fk_usuario_password_idx` (`password_idPassword` ASC) VISIBLE,
  CONSTRAINT `fk_usuario_password`
    FOREIGN KEY (`password_idPassword`)
    REFERENCES `spotify-equipo2`.`password` (`idPassword`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `spotify-equipo2`.`playlist`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `spotify-equipo2`.`playlist` (
  `idPlaylist` INT NOT NULL,
  `tituloPlaylist` VARCHAR(30) NULL DEFAULT NULL,
  `cantidaCanciones` INT NULL DEFAULT NULL,
  `fechaCreacion` DATE NULL DEFAULT NULL,
  `usuario_idUsuario` INT NOT NULL,
  PRIMARY KEY (`idPlaylist`, `usuario_idUsuario`),
  INDEX `fk_playlist_usuario1_idx` (`usuario_idUsuario` ASC) VISIBLE,
  CONSTRAINT `fk_playlist_usuario1`
    FOREIGN KEY (`usuario_idUsuario`)
    REFERENCES `spotify-equipo2`.`usuario` (`idUsuario`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `spotify-equipo2`.`playlistActiva`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `spotify-equipo2`.`playlistActiva` (
  `idPlaylistActiva` INT NOT NULL,
  `activa` TINYINT NULL DEFAULT NULL,
  `fechaBaja` DATE NULL DEFAULT NULL,
  `playlist_idPlaylist` INT NOT NULL,
  PRIMARY KEY (`idPlaylistActiva`, `playlist_idPlaylist`),
  INDEX `fk_playlistActiva_playlist1_idx` (`playlist_idPlaylist` ASC) VISIBLE,
  CONSTRAINT `fk_playlistActiva_playlist1`
    FOREIGN KEY (`playlist_idPlaylist`)
    REFERENCES `spotify-equipo2`.`playlist` (`idPlaylist`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `spotify-equipo2`.`playlistCancion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `spotify-equipo2`.`playlistCancion` (
  `idplaylistCancion` INT NOT NULL,
  `playlist_idPlaylist` INT NOT NULL,
  `cancion_idCancion` INT NOT NULL,
  PRIMARY KEY (`idplaylistCancion`, `playlist_idPlaylist`, `cancion_idCancion`),
  INDEX `fk_playlistCancion_playlist_idx` (`playlist_idPlaylist` ASC) VISIBLE,
  INDEX `fk_playlistCancion_cancion1_idx` (`cancion_idCancion` ASC) VISIBLE,
  CONSTRAINT `fk_playlistCancion_cancion1`
    FOREIGN KEY (`cancion_idCancion`)
    REFERENCES `spotify-equipo2`.`cancion` (`idCancion`),
  CONSTRAINT `fk_playlistCancion_playlist`
    FOREIGN KEY (`playlist_idPlaylist`)
    REFERENCES `spotify-equipo2`.`playlist` (`idPlaylist`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

#CARGA DE DATOS

INSERT INTO `spotify-equipo2`.`password` (`idPassword`, `vencimiento`, `pass`)
VALUES ('1', '2020-09-30', 'passBlabla');

INSERT INTO `spotify-equipo2`.`password` VALUES ('2', '2020-10-30', 'otroPass');

INSERT INTO `spotify-equipo2`.`password` VALUES ('3', '2020-12-30', 'anotherPass');



INSERT INTO `spotify-equipo2`.`usuario` 
(`idUsuario`, `mail`, `fechaDeNacimiento`, `sexo`, `codigoPostal`, `pais`, `password_idPassword`)
VALUES ('1', 'tanaicc@gmail.com', '1982-12-07', '0', '5500', 'Argentina', '1');

INSERT INTO `spotify-equipo2`.`usuario` VALUES
('2', 'chuchu@gmail.com', '2000-12-07', '1', '1000', 'Argentina', '2');

INSERT INTO `spotify-equipo2`.`usuario` VALUES
('2', 'chacha@gmail.com', '2001-06-07', '1', '4000', 'Argentina', '3');


INSERT INTO `spotify-equipo2`.`artista`
(`idArtista`, `nombreArtista`, `imgArtista`)
VALUES (1, 'Charly García', NULL);

INSERT INTO `spotify-equipo2`.`discografica`
(`idDiscografica`, `nombreDiscografica`, `paisDiscografica`)
VALUES (1, 'Sony Music', 'Argentina');


INSERT INTO `spotify-equipo2`.`album`
(`idAlbum`, `titulo`, `publicacion`, `imgPortada`, `artista_idArtista`, `discografica_idDiscografica`)
VALUES (1, 'Adios Sui Generis', 1975, NULL, 1, 1);

INSERT INTO `spotify-equipo2`.`cancion` 
(`idCancion`, `tituloCancion`, `duracionSeg`, `reproduccion`, `like`, `album_idAlbum`)
VALUES (1, 'Eiti Leda', 150, 100, 1000, '1');

INSERT INTO `spotify-equipo2`.`cancion` 
(`idCancion`, `tituloCancion`, `duracionSeg`, `reproduccion`, `like`, `album_idAlbum`)
VALUES (2, 'Cuando ya me empiece a quedar solo', 1500, 90, 1000, '1');

INSERT INTO `spotify-equipo2`.`cancion` 
(`idCancion`, `tituloCancion`, `duracionSeg`, `reproduccion`, `like`, `album_idAlbum`)
VALUES (3, 'Fabricante', 190, 100, 1000, '1');