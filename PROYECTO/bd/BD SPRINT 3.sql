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
  `id` VARCHAR(36) NOT NULL,
  `name` VARCHAR(45) NULL,
  `province` VARCHAR(45) NULL,
  `country` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `digitalbooking`.`policy`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `digitalbooking`.`policy` (
  `id` VARCHAR(36) NOT NULL,
  `norms` VARCHAR(45) NULL,
  `healthAndSecurity` VARCHAR(45) NULL,
  `cancellationPolicy` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `digitalbooking`.`products`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `digitalbooking`.`products` (
  `id` VARCHAR(36) NOT NULL,
  `description` VARCHAR(800) NULL,
  `availability` TINYINT NULL,
  `policy` VARCHAR(45) NULL,
  `cities_id` VARCHAR(36) NOT NULL,
  `categories_id` VARCHAR(36) NOT NULL,
  `policy_id` VARCHAR(36) NOT NULL,
  PRIMARY KEY (`id`, `cities_id`, `categories_id`, `policy_id`),
  INDEX `fk_products_cities1_idx` (`cities_id` ASC) VISIBLE,
  INDEX `fk_products_categories1_idx` (`categories_id` ASC) VISIBLE,
  INDEX `fk_products_policy1_idx` (`policy_id` ASC) VISIBLE,
  CONSTRAINT `fk_products_cities1`
    FOREIGN KEY (`cities_id`)
    REFERENCES `digitalbooking`.`cities` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_products_categories1`
    FOREIGN KEY (`categories_id`)
    REFERENCES `digitalbooking`.`categories` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_products_policy1`
    FOREIGN KEY (`policy_id`)
    REFERENCES `digitalbooking`.`policy` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `digitalbooking`.`features`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `digitalbooking`.`features` (
  `id` VARCHAR(36) NOT NULL,
  `name` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `digitalbooking`.`images`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `digitalbooking`.`images` (
  `id` VARCHAR(36) NOT NULL,
  `title` VARCHAR(45) NULL,
  `url` VARCHAR(255) NULL,
  `products_id` VARCHAR(36) NOT NULL,
  PRIMARY KEY (`id`, `products_id`),
  INDEX `fk_images_products_idx` (`products_id` ASC) VISIBLE,
  CONSTRAINT `fk_images_products`
    FOREIGN KEY (`products_id`)
    REFERENCES `digitalbooking`.`products` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `digitalbooking`.`products_has_features`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `digitalbooking`.`products_has_features` (
  `id` VARCHAR(45) NOT NULL,
  `products_idProduct` VARCHAR(36) NOT NULL,
  `features_idFeatures` VARCHAR(36) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_products_has_features_features1_idx` (`features_idFeatures` ASC) VISIBLE,
  INDEX `fk_products_has_features_products1_idx` (`products_idProduct` ASC) VISIBLE,
  CONSTRAINT `fk_products_has_features_products1`
    FOREIGN KEY (`products_idProduct`)
    REFERENCES `digitalbooking`.`products` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_products_has_features_features1`
    FOREIGN KEY (`features_idFeatures`)
    REFERENCES `digitalbooking`.`features` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `digitalbooking`.`roles`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `digitalbooking`.`roles` (
  `id` VARCHAR(36) NOT NULL,
  `name` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `digitalbooking`.`users`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `digitalbooking`.`users` (
  `id` VARCHAR(36) NOT NULL,
  `name` VARCHAR(45) NULL,
  `lastname` VARCHAR(45) NULL,
  `email` VARCHAR(45) NULL,
  `password` VARCHAR(45) NULL,
  `city` VARCHAR(45) NULL,
  `roles_id` VARCHAR(36) NOT NULL,
  PRIMARY KEY (`id`, `roles_id`),
  INDEX `fk_users_roles1_idx` (`roles_id` ASC) VISIBLE,
  CONSTRAINT `fk_users_roles1`
    FOREIGN KEY (`roles_id`)
    REFERENCES `digitalbooking`.`roles` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `digitalbooking`.`reservation`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `digitalbooking`.`reservation` (
  `id` VARCHAR(36) NOT NULL,
  `startTime` TIME NULL,
  `checkIn` DATE NULL,
  `checkOut` DATE NULL,
  `products_id` VARCHAR(36) NOT NULL,
  `users_id` VARCHAR(36) NOT NULL,
  PRIMARY KEY (`id`, `products_id`, `users_id`),
  INDEX `fk_reservation_products1_idx` (`products_id` ASC) VISIBLE,
  INDEX `fk_reservation_users1_idx` (`users_id` ASC) VISIBLE,
  CONSTRAINT `fk_reservation_products`
    FOREIGN KEY (`products_id`)
    REFERENCES `digitalbooking`.`products` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_reservation_users`
    FOREIGN KEY (`users_id`)
    REFERENCES `digitalbooking`.`users` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

