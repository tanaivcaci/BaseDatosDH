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
