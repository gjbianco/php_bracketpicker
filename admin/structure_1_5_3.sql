-- MySQL Script generated by MySQL Workbench
-- Sun 29 Mar 2015 11:08:14 AM CDT
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema tourney
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema tourney
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `tourney` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci ;
-- -----------------------------------------------------
-- Schema tourney2016
-- -----------------------------------------------------
USE `tourney` ;

-- -----------------------------------------------------
-- Table `tourney`.`Team`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `tourney`.`Team` ;

CREATE TABLE IF NOT EXISTS `tourney`.`Team` (
  `team_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NULL,
  `mascot` VARCHAR(45) NULL,
  `icon_path` VARCHAR(45) NULL,
  `team_color_1` VARCHAR(6) NULL DEFAULT '111111',
  `team_color_2` VARCHAR(6) NULL DEFAULT 'DDDDDD',
  `create_time` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `create_by` VARCHAR(45) NULL,
  `update_time` TIMESTAMP NULL,
  `update_by` VARCHAR(45) NULL,
  PRIMARY KEY (`team_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tourney`.`Game`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `tourney`.`Game` ;

CREATE TABLE IF NOT EXISTS `tourney`.`Game` (
  `game_id` INT NOT NULL AUTO_INCREMENT,
  `team_a` INT NOT NULL,
  `team_b` INT NOT NULL,
  `score_a` INT NULL,
  `score_b` INT NULL,
  `child_game_a` INT NULL,
  `child_game_b` INT NULL,
  `create_time` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `create_by` VARCHAR(45) NULL,
  `update_time` TIMESTAMP NULL,
  `update_by` VARCHAR(45) NULL,
  PRIMARY KEY (`game_id`),
  INDEX `fk_team_idx` (`team_a` ASC, `team_b` ASC),
  INDEX `fk_game_idx` (`child_game_a` ASC, `child_game_b` ASC),
  CONSTRAINT `fk_team`
    FOREIGN KEY (`team_a` , `team_b`)
    REFERENCES `tourney`.`Team` (`team_id` , `team_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_game`
    FOREIGN KEY (`child_game_a` , `child_game_b`)
    REFERENCES `tourney`.`Game` (`game_id` , `game_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tourney`.`User`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `tourney`.`User` ;

CREATE TABLE IF NOT EXISTS `tourney`.`User` (
  `user_id` INT NOT NULL AUTO_INCREMENT,
  `username` VARCHAR(45) NOT NULL,
  `email` VARCHAR(45) NULL,
  `name` VARCHAR(45) NULL,
  `create_time` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `create_by` VARCHAR(45) NULL,
  `update_time` TIMESTAMP NULL,
  `update_by` VARCHAR(45) NULL,
  PRIMARY KEY (`user_id`),
  UNIQUE INDEX `username_UNIQUE` (`username` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tourney`.`Bracket`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `tourney`.`Bracket` ;

CREATE TABLE IF NOT EXISTS `tourney`.`Bracket` (
  `bracket_id` INT NOT NULL AUTO_INCREMENT,
  `user_id` INT NULL,
  `root_game` INT NOT NULL,
  `create_time` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `create_by` VARCHAR(45) NULL,
  `update_time` TIMESTAMP NULL,
  `update_by` VARCHAR(45) NULL,
  PRIMARY KEY (`bracket_id`),
  INDEX `fk_user_idx` (`user_id` ASC),
  INDEX `fk_game_idx` (`root_game` ASC),
  CONSTRAINT `fk_user`
    FOREIGN KEY (`user_id`)
    REFERENCES `tourney`.`User` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_game`
    FOREIGN KEY (`root_game`)
    REFERENCES `tourney`.`Game` (`game_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tourney`.`RuleSet`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `tourney`.`RuleSet` ;

CREATE TABLE IF NOT EXISTS `tourney`.`RuleSet` (
  `ruleset_id` INT NOT NULL,
  `round_id` INT NOT NULL,
  `rule` VARCHAR(100) NOT NULL,
  `create_time` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `create_by` VARCHAR(45) NULL,
  `update_time` TIMESTAMP NULL,
  `update_by` VARCHAR(45) NULL,
  PRIMARY KEY (`ruleset_id`, `round_id`))
ENGINE = InnoDB
COMMENT = 'composite primary key of ruleset_id and round_id\n';


-- -----------------------------------------------------
-- Table `tourney`.`Blog`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `tourney`.`Blog` ;

CREATE TABLE IF NOT EXISTS `tourney`.`Blog` (
  `blog_id` INT NOT NULL,
  `content` TEXT NULL,
  `parent_id` INT NULL,
  `user_id` INT NULL,
  `create_time` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `create_by` VARCHAR(45) NULL,
  `update_time` TIMESTAMP NULL,
  `update_by` VARCHAR(45) NULL,
  PRIMARY KEY (`blog_id`),
  INDEX `fk_parent_idx` (`parent_id` ASC),
  INDEX `fk_user_idx` (`user_id` ASC),
  CONSTRAINT `fk_parent`
    FOREIGN KEY (`parent_id`)
    REFERENCES `tourney`.`Blog` (`blog_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_user`
    FOREIGN KEY (`user_id`)
    REFERENCES `tourney`.`User` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tourney`.`Score`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `tourney`.`Score` ;

CREATE TABLE IF NOT EXISTS `tourney`.`Score` (
  `score_id` INT NOT NULL,
  `ruleset_id` INT NOT NULL,
  `bracket_id` INT NOT NULL,
  `score` INT NOT NULL,
  `create_time` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `create_by` VARCHAR(45) NULL,
  `update_time` TIMESTAMP NULL,
  `update_by` VARCHAR(45) NULL,
  PRIMARY KEY (`score_id`),
  INDEX `fk_ruleset_idx` (`ruleset_id` ASC),
  INDEX `fk_bracket_idx` (`bracket_id` ASC),
  CONSTRAINT `fk_ruleset`
    FOREIGN KEY (`ruleset_id`)
    REFERENCES `tourney`.`RuleSet` (`ruleset_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_bracket`
    FOREIGN KEY (`bracket_id`)
    REFERENCES `tourney`.`Bracket` (`bracket_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tourney`.`LinkType`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `tourney`.`LinkType` ;

CREATE TABLE IF NOT EXISTS `tourney`.`LinkType` (
  `linktype_id` INT NOT NULL AUTO_INCREMENT,
  `type` VARCHAR(45) NULL,
  `create_time` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `create_by` VARCHAR(45) NULL,
  `update_time` TIMESTAMP NULL,
  `update_by` VARCHAR(45) NULL,
  PRIMARY KEY (`linktype_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tourney`.`BlogLink`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `tourney`.`BlogLink` ;

CREATE TABLE IF NOT EXISTS `tourney`.`BlogLink` (
  `link_id` INT NOT NULL AUTO_INCREMENT,
  `blog_id` INT NULL,
  `linktype_id` INT NULL,
  `target_id` INT NULL,
  `create_time` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `create_by` VARCHAR(45) NULL,
  `update_time` TIMESTAMP NULL,
  `update_by` VARCHAR(45) NULL,
  PRIMARY KEY (`link_id`),
  INDEX `fk_linktype_idx` (`linktype_id` ASC),
  INDEX `fk_blog_idx` (`blog_id` ASC),
  CONSTRAINT `fk_linktype`
    FOREIGN KEY (`linktype_id`)
    REFERENCES `tourney`.`LinkType` (`linktype_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_blog`
    FOREIGN KEY (`blog_id`)
    REFERENCES `tourney`.`Blog` (`blog_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
