-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema DH_Salud
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema DH_Salud
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `DH_Salud` ;
-- -----------------------------------------------------
-- Schema playground
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema playground
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `playground` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `DH_Salud` ;

-- -----------------------------------------------------
-- Table `DH_Salud`.`Paciente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `DH_Salud`.`Paciente` (
  `id` INT NOT NULL,
  `nombre` VARCHAR(50) NULL,
  `apellido` VARCHAR(50) NULL,
  `identificacion_salud` BIGINT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `DH_Salud`.`Especialidad`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `DH_Salud`.`Especialidad` (
  `id` INT NOT NULL,
  `nombre` VARCHAR(50) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `DH_Salud`.`Medico`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `DH_Salud`.`Medico` (
  `id` INT NOT NULL,
  `matricula` BIGINT NULL,
  `nombre` VARCHAR(50) NULL,
  `apellido` VARCHAR(50) NULL,
  `id_especialidad` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_Medico_Especialidad1_idx` (`id_especialidad` ASC) VISIBLE,
  CONSTRAINT `fk_Medico_Especialidad1`
    FOREIGN KEY (`id_especialidad`)
    REFERENCES `DH_Salud`.`Especialidad` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `DH_Salud`.`Turno`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `DH_Salud`.`Turno` (
  `id` INT NOT NULL,
  `fecha` DATETIME NULL,
  `id_paciente` INT NOT NULL,
  `id_medico` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_Turno_Paciente_idx` (`id_paciente` ASC) VISIBLE,
  INDEX `fk_Turno_Medico1_idx` (`id_medico` ASC) VISIBLE,
  CONSTRAINT `fk_Turno_Paciente`
    FOREIGN KEY (`id_paciente`)
    REFERENCES `DH_Salud`.`Paciente` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Turno_Medico1`
    FOREIGN KEY (`id_medico`)
    REFERENCES `DH_Salud`.`Medico` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

USE `playground` ;

-- -----------------------------------------------------
-- Table `playground`.`carrera`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `playground`.`carrera` (
  `idcarrera` INT NOT NULL,
  `titulo` VARCHAR(45) NULL DEFAULT NULL,
  `descripcion` VARCHAR(100) NULL DEFAULT NULL,
  PRIMARY KEY (`idcarrera`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `playground`.`categorias`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `playground`.`categorias` (
  `idcategoria` INT NOT NULL,
  `nombre` VARCHAR(100) NULL DEFAULT NULL,
  PRIMARY KEY (`idcategoria`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `playground`.`usuarios`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `playground`.`usuarios` (
  `idusuario` INT NOT NULL,
  `nombre` VARCHAR(100) NULL DEFAULT NULL,
  `apellido` VARCHAR(100) NULL DEFAULT NULL,
  `email` VARCHAR(50) NULL DEFAULT NULL,
  `categoria` INT NULL DEFAULT NULL,
  PRIMARY KEY (`idusuario`),
  INDEX `categoria` (`categoria` ASC) VISIBLE,
  CONSTRAINT `usuarios_ibfk_1`
    FOREIGN KEY (`categoria`)
    REFERENCES `playground`.`categorias` (`idcategoria`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `playground`.`usuarios_carrera`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `playground`.`usuarios_carrera` (
  `id` INT NOT NULL,
  `usuario` INT NULL DEFAULT NULL,
  `carrera` INT NULL DEFAULT NULL,
  `fechainscripcion` DATE NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `usuario` (`usuario` ASC) VISIBLE,
  INDEX `carrera` (`carrera` ASC) VISIBLE,
  CONSTRAINT `usuarios_carrera_ibfk_1`
    FOREIGN KEY (`usuario`)
    REFERENCES `playground`.`usuarios` (`idusuario`),
  CONSTRAINT `usuarios_carrera_ibfk_2`
    FOREIGN KEY (`carrera`)
    REFERENCES `playground`.`carrera` (`idcarrera`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
