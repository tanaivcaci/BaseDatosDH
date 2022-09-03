-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema digitalbooking
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema digitalbooking
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `digitalbooking` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `digitalbooking` ;

-- -----------------------------------------------------
-- Table `digitalbooking`.`categories`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `digitalbooking`.`categories` (
  `id` VARCHAR(36) NOT NULL,
  `title` VARCHAR(50) NOT NULL,
  `description` VARCHAR(100) NOT NULL,
  `url` TEXT NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `digitalbooking`.`flyway_schema_history`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `digitalbooking`.`flyway_schema_history` (
  `installed_rank` INT NOT NULL,
  `version` VARCHAR(50) NULL DEFAULT NULL,
  `description` VARCHAR(200) NOT NULL,
  `type` VARCHAR(20) NOT NULL,
  `script` VARCHAR(1000) NOT NULL,
  `checksum` INT NULL DEFAULT NULL,
  `installed_by` VARCHAR(100) NOT NULL,
  `installed_on` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `execution_time` INT NOT NULL,
  `success` TINYINT(1) NOT NULL,
  PRIMARY KEY (`installed_rank`),
  INDEX `flyway_schema_history_s_idx` (`success` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `digitalbooking`.`cities`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `digitalbooking`.`cities` (
  `idCity` VARCHAR(36) NOT NULL,
  `name` VARCHAR(45) NULL,
  `province` VARCHAR(45) NULL,
  PRIMARY KEY (`idCity`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `digitalbooking`.`products`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `digitalbooking`.`products` (
  `idProduct` VARCHAR(36) NOT NULL,
  `idFeatures` VARCHAR(45) NULL,
  `description` VARCHAR(800) NULL,
  `availability` VARCHAR(45) NULL,
  `policy` VARCHAR(45) NULL,
  `cities_idCity` VARCHAR(36) NOT NULL,
  `categories_id` VARCHAR(36) NOT NULL,
  PRIMARY KEY (`idProduct`, `cities_idCity`, `categories_id`),
  INDEX `fk_products_cities1_idx` (`cities_idCity` ASC) VISIBLE,
  INDEX `fk_products_categories1_idx` (`categories_id` ASC) VISIBLE,
  CONSTRAINT `fk_products_cities1`
    FOREIGN KEY (`cities_idCity`)
    REFERENCES `digitalbooking`.`cities` (`idCity`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_products_categories1`
    FOREIGN KEY (`categories_id`)
    REFERENCES `digitalbooking`.`categories` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `digitalbooking`.`features`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `digitalbooking`.`features` (
  `idFeatures` VARCHAR(36) NOT NULL,
  `name` VARCHAR(45) NULL,
  PRIMARY KEY (`idFeatures`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `digitalbooking`.`images`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `digitalbooking`.`images` (
  `idImages` VARCHAR(36) NOT NULL,
  `title` VARCHAR(45) NULL,
  `url` VARCHAR(255) NULL,
  `products_idProduct` VARCHAR(36) NOT NULL,
  PRIMARY KEY (`idImages`, `products_idProduct`),
  INDEX `fk_images_products_idx` (`products_idProduct` ASC) VISIBLE,
  CONSTRAINT `fk_images_products`
    FOREIGN KEY (`products_idProduct`)
    REFERENCES `digitalbooking`.`products` (`idProduct`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `digitalbooking`.`policy`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `digitalbooking`.`policy` (
  `idPolicy` VARCHAR(36) NOT NULL,
  `norms` VARCHAR(45) NULL,
  `healthAndSecurity` VARCHAR(45) NULL,
  `cancellationPolicy` VARCHAR(45) NULL,
  PRIMARY KEY (`idPolicy`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `digitalbooking`.`products_has_features`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `digitalbooking`.`products_has_features` (
  `idProductFeature` VARCHAR(45) NOT NULL,
  `products_idProduct` VARCHAR(36) NOT NULL,
  `features_idFeatures` VARCHAR(36) NOT NULL,
  PRIMARY KEY (`idProductFeature`),
  INDEX `fk_products_has_features_features1_idx` (`features_idFeatures` ASC) VISIBLE,
  INDEX `fk_products_has_features_products1_idx` (`products_idProduct` ASC) VISIBLE,
  CONSTRAINT `fk_products_has_features_products1`
    FOREIGN KEY (`products_idProduct`)
    REFERENCES `digitalbooking`.`products` (`idProduct`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_products_has_features_features1`
    FOREIGN KEY (`features_idFeatures`)
    REFERENCES `digitalbooking`.`features` (`idFeatures`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
