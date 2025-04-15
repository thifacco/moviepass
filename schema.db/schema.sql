-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema moviePass
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema moviePass
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `moviePass` DEFAULT CHARACTER SET utf8 ;
USE `moviePass` ;

-- -----------------------------------------------------
-- Table `moviePass`.`users`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `moviePass`.`users` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `first_name` VARCHAR(45) NOT NULL,
  `middle_name` VARCHAR(45) NULL,
  `last_name` VARCHAR(45) NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  `password` CHAR(8) NOT NULL,
  `document` CHAR(11) NOT NULL,
  `create_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `moviePass`.`movies`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `moviePass`.`movies` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `create_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `moviePass`.`rooms`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `moviePass`.`rooms` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `create_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `moviePass`.`sessions`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `moviePass`.`sessions` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NULL,
  `movie_id` INT NOT NULL,
  `room_id` INT NOT NULL,
  `schedule` DATETIME NOT NULL,
  `price` DECIMAL(10,2) NOT NULL DEFAULT 0.00,
  `create_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  INDEX `fk_session_movies_idx` (`movie_id` ASC) VISIBLE,
  INDEX `fk_sessions_rooms1_idx` (`room_id` ASC) VISIBLE,
  CONSTRAINT `fk_session_movies`
    FOREIGN KEY (`movie_id`)
    REFERENCES `moviePass`.`movies` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_sessions_rooms1`
    FOREIGN KEY (`room_id`)
    REFERENCES `moviePass`.`rooms` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `moviePass`.`chairs`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `moviePass`.`chairs` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `number` INT NOT NULL,
  `row` CHAR(2) NOT NULL,
  `room_id` INT NOT NULL,
  `create_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  INDEX `fk_chairs_rooms1_idx` (`room_id` ASC) VISIBLE,
  CONSTRAINT `fk_chairs_rooms1`
    FOREIGN KEY (`room_id`)
    REFERENCES `moviePass`.`rooms` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `moviePass`.`tickets`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `moviePass`.`tickets` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `user_id` INT NOT NULL,
  `session_id` INT NOT NULL,
  `hashcode` CHAR(8) NOT NULL,
  `chair_id` INT NOT NULL,
  `create_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  INDEX `fk_tickets_users1_idx` (`user_id` ASC) VISIBLE,
  INDEX `fk_tickets_sessions1_idx` (`session_id` ASC) VISIBLE,
  INDEX `fk_tickets_chairs1_idx` (`chair_id` ASC) VISIBLE,
  UNIQUE INDEX `unique_chair_per_session` (`chair_id` ASC, `session_id` ASC) VISIBLE,
  CONSTRAINT `fk_tickets_users1`
    FOREIGN KEY (`user_id`)
    REFERENCES `moviePass`.`users` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_tickets_sessions1`
    FOREIGN KEY (`session_id`)
    REFERENCES `moviePass`.`sessions` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_tickets_chairs1`
    FOREIGN KEY (`chair_id`)
    REFERENCES `moviePass`.`chairs` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `moviePass`.`receipts`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `moviePass`.`receipts` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `ticket_id` INT NOT NULL,
  `payment_method` ENUM('credit card', 'debit_card', 'pix', 'cash') NOT NULL,
  `total_paid` DECIMAL(10,2) NOT NULL,
  `status` ENUM('pending', 'confirmed', 'failed') NOT NULL DEFAULT 'pending',
  `create_at` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  `update_at` DATETIME NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  INDEX `fk_receipts_tickets1_idx` (`ticket_id` ASC) VISIBLE,
  UNIQUE INDEX `unique_ticket_per_receipt` (`ticket_id` ASC) VISIBLE,
  CONSTRAINT `fk_receipts_tickets1`
    FOREIGN KEY (`ticket_id`)
    REFERENCES `moviePass`.`tickets` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
