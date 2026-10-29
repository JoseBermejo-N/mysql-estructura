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
-- Table `pizzeria`.`productos`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pizzeria`.`productos` ;

CREATE TABLE IF NOT EXISTS `pizzeria`.`productos` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `descripcion` VARCHAR(45) NULL,
  `imagen` VARCHAR(45) NULL,
  `precio` DECIMAL(6,2) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pizzeria`.`categorias`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pizzeria`.`categorias` ;

CREATE TABLE IF NOT EXISTS `pizzeria`.`categorias` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pizzeria`.`pizzas`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pizzeria`.`pizzas` ;

CREATE TABLE IF NOT EXISTS `pizzeria`.`pizzas` (
  `producto_id` INT NOT NULL,
  `categorias_id` INT NOT NULL,
  PRIMARY KEY (`producto_id`),
  INDEX `fk_pizzas_categorias1_idx` (`categorias_id` ASC) VISIBLE,
  CONSTRAINT `fk_pizzas_productos1`
    FOREIGN KEY (`producto_id`)
    REFERENCES `pizzeria`.`productos` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_pizzas_categorias1`
    FOREIGN KEY (`categorias_id`)
    REFERENCES `pizzeria`.`categorias` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pizzeria`.`hamburguesas`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pizzeria`.`hamburguesas` ;

CREATE TABLE IF NOT EXISTS `pizzeria`.`hamburguesas` (
  `producto_id` INT NOT NULL,
  PRIMARY KEY (`producto_id`),
  CONSTRAINT `fk_hamburguesas_productos1`
    FOREIGN KEY (`producto_id`)
    REFERENCES `pizzeria`.`productos` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pizzeria`.`bebidas`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pizzeria`.`bebidas` ;

CREATE TABLE IF NOT EXISTS `pizzeria`.`bebidas` (
  `producto_id` INT NOT NULL,
  PRIMARY KEY (`producto_id`),
  CONSTRAINT `fk_bebidas_productos1`
    FOREIGN KEY (`producto_id`)
    REFERENCES `pizzeria`.`productos` (`id`)
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
