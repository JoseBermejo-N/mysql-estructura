-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema cul_d_ampolla
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema cul_d_ampolla
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `cul_d_ampolla` DEFAULT CHARACTER SET utf8 ;
USE `cul_d_ampolla` ;

-- -----------------------------------------------------
-- Table `cul_d_ampolla`.`PROVEEDORES`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cul_d_ampolla`.`PROVEEDORES` ;

CREATE TABLE IF NOT EXISTS `cul_d_ampolla`.`PROVEEDORES` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(50) NOT NULL,
  `calle` VARCHAR(50) NOT NULL,
  `numero` VARCHAR(10) NOT NULL,
  `piso` VARCHAR(10) NULL,
  `puerta` VARCHAR(10) NULL,
  `ciudad` VARCHAR(45) NOT NULL,
  `codigo_postal` VARCHAR(10) NOT NULL,
  `pais` VARCHAR(45) NOT NULL,
  `telefono` VARCHAR(20) NOT NULL,
  `fax` VARCHAR(20) NULL,
  `nif` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `nif_UNIQUE` (`nif` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `cul_d_ampolla`.`MARCAS`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cul_d_ampolla`.`MARCAS` ;

CREATE TABLE IF NOT EXISTS `cul_d_ampolla`.`MARCAS` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `proveedor_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_MARCAS_PROVEEDORES_idx` (`proveedor_id` ASC) VISIBLE,
  UNIQUE INDEX `nombre_UNIQUE` (`nombre` ASC) VISIBLE,
  CONSTRAINT `fk_MARCAS_PROVEEDORES`
    FOREIGN KEY (`proveedor_id`)
    REFERENCES `cul_d_ampolla`.`PROVEEDORES` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `cul_d_ampolla`.`GAFAS`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cul_d_ampolla`.`GAFAS` ;

CREATE TABLE IF NOT EXISTS `cul_d_ampolla`.`GAFAS` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `marca_id` INT NOT NULL,
  `graduacion_izq` DECIMAL(4,2) NOT NULL,
  `graduacion_dcha` DECIMAL(4,2) NOT NULL,
  `montura` ENUM('flotante', 'pasta', 'metálica') NOT NULL,
  `color_montura` VARCHAR(15) NOT NULL,
  `color_vidrio_izq` VARCHAR(15) NOT NULL,
  `color_vidrio_dcho` VARCHAR(15) NOT NULL,
  `precio` DECIMAL(6,2) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_GAFAS_MARCAS1_idx` (`marca_id` ASC) VISIBLE,
  CONSTRAINT `fk_GAFAS_MARCAS1`
    FOREIGN KEY (`marca_id`)
    REFERENCES `cul_d_ampolla`.`MARCAS` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `cul_d_ampolla`.`CLIENTES`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cul_d_ampolla`.`CLIENTES` ;

CREATE TABLE IF NOT EXISTS `cul_d_ampolla`.`CLIENTES` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `direccion_postal` VARCHAR(150) NULL,
  `telefono` VARCHAR(20) NOT NULL,
  `email` VARCHAR(45) NULL,
  `fecha_registro` DATE NOT NULL,
  `recomendado_por_cliente_id` INT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_CLIENTES_CLIENTES1_idx` (`recomendado_por_cliente_id` ASC) VISIBLE,
  UNIQUE INDEX `telefono_UNIQUE` (`telefono` ASC) VISIBLE,
  CONSTRAINT `fk_CLIENTES_CLIENTES1`
    FOREIGN KEY (`recomendado_por_cliente_id`)
    REFERENCES `cul_d_ampolla`.`CLIENTES` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `cul_d_ampolla`.`EMPLEADOS`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cul_d_ampolla`.`EMPLEADOS` ;

CREATE TABLE IF NOT EXISTS `cul_d_ampolla`.`EMPLEADOS` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `nombre_UNIQUE` (`nombre` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `cul_d_ampolla`.`VENTAS`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cul_d_ampolla`.`VENTAS` ;

CREATE TABLE IF NOT EXISTS `cul_d_ampolla`.`VENTAS` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `fecha_de_venta` DATE NOT NULL,
  `cliente_id` INT NOT NULL,
  `empleado_id` INT NOT NULL,
  `gafa_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_VENTAS_CLIENTES1_idx` (`cliente_id` ASC) VISIBLE,
  INDEX `fk_VENTAS_EMPLEADOS1_idx` (`empleado_id` ASC) VISIBLE,
  INDEX `fk_VENTAS_GAFAS1_idx` (`gafa_id` ASC) VISIBLE,
  CONSTRAINT `fk_VENTAS_CLIENTES1`
    FOREIGN KEY (`cliente_id`)
    REFERENCES `cul_d_ampolla`.`CLIENTES` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_VENTAS_EMPLEADOS1`
    FOREIGN KEY (`empleado_id`)
    REFERENCES `cul_d_ampolla`.`EMPLEADOS` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_VENTAS_GAFAS1`
    FOREIGN KEY (`gafa_id`)
    REFERENCES `cul_d_ampolla`.`GAFAS` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
