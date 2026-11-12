-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema pizzeria
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema pizzeria
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `pizzeria` DEFAULT CHARACTER SET utf8 ;
USE `pizzeria` ;

-- -----------------------------------------------------
-- Table `pizzeria`.`tiendas`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pizzeria`.`tiendas` ;

CREATE TABLE IF NOT EXISTS `pizzeria`.`tiendas` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `direccion` VARCHAR(150) NOT NULL,
  `codigo_postal` VARCHAR(5) NOT NULL,
  `localidad` VARCHAR(45) NOT NULL,
  `provincia` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pizzeria`.`empleados`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pizzeria`.`empleados` ;

CREATE TABLE IF NOT EXISTS `pizzeria`.`empleados` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `nif` VARCHAR(10) NOT NULL,
  `telefono` VARCHAR(20) NOT NULL,
  `tienda_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `nif_UNIQUE` (`nif` ASC) VISIBLE,
  INDEX `fk_empleados_tiendas1_idx` (`tienda_id` ASC) VISIBLE,
  CONSTRAINT `fk_empleados_tiendas1`
    FOREIGN KEY (`tienda_id`)
    REFERENCES `pizzeria`.`tiendas` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pizzeria`.`repartidores`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pizzeria`.`repartidores` ;

CREATE TABLE IF NOT EXISTS `pizzeria`.`repartidores` (
  `empleado_id` INT NOT NULL,
  PRIMARY KEY (`empleado_id`),
  CONSTRAINT `fk_repartidores_empleados1`
    FOREIGN KEY (`empleado_id`)
    REFERENCES `pizzeria`.`empleados` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pizzeria`.`clientes`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pizzeria`.`clientes` ;

CREATE TABLE IF NOT EXISTS `pizzeria`.`clientes` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `apellido` VARCHAR(45) NOT NULL,
  `direccion` VARCHAR(150) NOT NULL,
  `cp` VARCHAR(10) NOT NULL,
  `localidad` VARCHAR(45) NOT NULL,
  `provincia` VARCHAR(45) NOT NULL,
  `telefono` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pizzeria`.`pedidos`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pizzeria`.`pedidos` ;

CREATE TABLE IF NOT EXISTS `pizzeria`.`pedidos` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `fecha_hora_pedido` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `tipo_entrega` ENUM('domicilio', 'recoger') NOT NULL,
  `precio` DECIMAL(8,2) NOT NULL,
  `fecha_hora_entrega` DATETIME NOT NULL,
  `tienda_id` INT NOT NULL,
  `repartidor_empleado_id` INT NULL,
  `cliente_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_pedidos_tiendas1_idx` (`tienda_id` ASC) VISIBLE,
  INDEX `fk_pedidos_repartidores1_idx` (`repartidor_empleado_id` ASC) VISIBLE,
  INDEX `fk_pedidos_clientes1_idx` (`cliente_id` ASC) VISIBLE,
  CONSTRAINT `fk_pedidos_tiendas1`
    FOREIGN KEY (`tienda_id`)
    REFERENCES `pizzeria`.`tiendas` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_pedidos_repartidores1`
    FOREIGN KEY (`repartidor_empleado_id`)
    REFERENCES `pizzeria`.`repartidores` (`empleado_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_pedidos_clientes1`
    FOREIGN KEY (`cliente_id`)
    REFERENCES `pizzeria`.`clientes` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pizzeria`.`tipos_de_productos`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pizzeria`.`tipos_de_productos` ;

CREATE TABLE IF NOT EXISTS `pizzeria`.`tipos_de_productos` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pizzeria`.`categorias_pizzas`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pizzeria`.`categorias_pizzas` ;

CREATE TABLE IF NOT EXISTS `pizzeria`.`categorias_pizzas` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pizzeria`.`productos`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pizzeria`.`productos` ;

CREATE TABLE IF NOT EXISTS `pizzeria`.`productos` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `descripcion` VARCHAR(45) NULL,
  `imagen` VARCHAR(45) NULL,
  `precio` DECIMAL(6,2) NOT NULL,
  `tipos_de_productos_id` INT NOT NULL,
  `categorias_pizzas_id` INT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_productos_tipos_de_productos1_idx` (`tipos_de_productos_id` ASC) VISIBLE,
  INDEX `fk_productos_categorias_pizzas1_idx` (`categorias_pizzas_id` ASC) VISIBLE,
  CONSTRAINT `fk_productos_tipos_de_productos1`
    FOREIGN KEY (`tipos_de_productos_id`)
    REFERENCES `pizzeria`.`tipos_de_productos` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_productos_categorias_pizzas1`
    FOREIGN KEY (`categorias_pizzas_id`)
    REFERENCES `pizzeria`.`categorias_pizzas` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pizzeria`.`productos_has_pedidos`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pizzeria`.`productos_has_pedidos` ;

CREATE TABLE IF NOT EXISTS `pizzeria`.`productos_has_pedidos` (
  `productos_id` INT NOT NULL,
  `pedidos_id` INT NOT NULL,
  `cantidad` INT NOT NULL,
  PRIMARY KEY (`productos_id`, `pedidos_id`),
  INDEX `fk_productos_has_pedidos_pedidos1_idx` (`pedidos_id` ASC) VISIBLE,
  INDEX `fk_productos_has_pedidos_productos1_idx` (`productos_id` ASC) VISIBLE,
  CONSTRAINT `fk_productos_has_pedidos_productos1`
    FOREIGN KEY (`productos_id`)
    REFERENCES `pizzeria`.`productos` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_productos_has_pedidos_pedidos1`
    FOREIGN KEY (`pedidos_id`)
    REFERENCES `pizzeria`.`pedidos` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
