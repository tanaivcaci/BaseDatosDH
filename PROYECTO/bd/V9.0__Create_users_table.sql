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