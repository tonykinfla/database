-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------

-- Schema nfldb
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `nfldb` ;

-- -----------------------------------------------------
-- Schema nfldb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `nfldb` DEFAULT CHARACTER SET utf8 ;
USE `nfldb` ;

-- -----------------------------------------------------
-- Table `nfldb`.`nfl_team`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `nfldb`.`nfl_team` ;

CREATE TABLE IF NOT EXISTS `nfldb`.`nfl_team` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `team_name` VARCHAR(45) NULL DEFAULT '',
  `city` VARCHAR(45) NULL DEFAULT NULL,
  `arena` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `nfldb`.`players`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `nfldb`.`players` ;

CREATE TABLE IF NOT EXISTS `nfldb`.`players` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NULL DEFAULT NULL,
  `college` VARCHAR(45) NULL DEFAULT NULL,
  `position` VARCHAR(15) NULL DEFAULT NULL,
  `fantasy_points` VARCHAR(45) NULL DEFAULT NULL,
  `nfl_team_id` INT(11) NOT NULL,
  UNIQUE (`id`, `name`),
  PRIMARY KEY (`id`, `nfl_team_id`),
  INDEX `fk_players_nfl_team1_idx` (`nfl_team_id` ASC),
  CONSTRAINT `fk_players_nfl_team1`
    FOREIGN KEY (`nfl_team_id`)
    REFERENCES `nfldb`.`nfl_team` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `nfldb`.`season`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `nfldb`.`season` ;

CREATE TABLE IF NOT EXISTS `nfldb`.`season` (
  `id` Int(5) NOT NULL AUTO_INCREMENT,
  `season` VARCHAR(45) NULL DEFAULT NULL,
  `sport` VARCHAR(15) NULL DEFAULT '',
  `superbowl` VARCHAR(45) NULL DEFAULT '',
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `nfldb`.`player_season`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `nfldb`.`player_season` ;

CREATE TABLE IF NOT EXISTS `nfldb`.`player_season` (
  `players_id` INT(11) NOT NULL,
  `season_id` INT(5) NOT NULL,
  PRIMARY KEY (`players_id`, `season_id`),
  INDEX `fk_players_has_season_season1_idx` (`season_id` ASC),
  INDEX `fk_players_has_season_players1_idx` (`players_id` ASC),
  CONSTRAINT `fk_players_has_season_players1`
    FOREIGN KEY (`players_id`)
    REFERENCES `nfldb`.`players` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_players_has_season_season1`
    FOREIGN KEY (`season_id`)
    REFERENCES `nfldb`.`season` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

-- -----------------------------------------------------
-- Table `nfldb`.`user`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `nfldb`.`user` ;

CREATE TABLE IF NOT EXISTS `nfldb`.`user` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `user` VARCHAR(45) NULL DEFAULT '',
  `age` INT(11) NULL DEFAULT NULL,
  `rank` VARCHAR(45) NULL DEFAULT NULL,
  `league` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `nfldb`.`user_roster`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `nfldb`.`user_roster` ;

CREATE TABLE IF NOT EXISTS `nfldb`.`user_roster` (
  `user_id` INT(11) NOT NULL,
  `players_id` INT(11) NOT NULL,
  PRIMARY KEY (`user_id`, `players_id`),
  INDEX `fk_user_has_players_players1_idx` (`players_id` ASC),
  INDEX `fk_user_has_players_user1_idx` (`user_id` ASC),
  CONSTRAINT `fk_user_has_players_players1`
    FOREIGN KEY (`players_id`)
    REFERENCES `nfldb`.`players` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_user_has_players_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `nfldb`.`user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
