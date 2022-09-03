-- -----------------------------------------------------
-- Table `digitalbooking`.`roles`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `digitalbooking`.`roles` (
  `id` VARCHAR(36) NOT NULL,
  `name` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;