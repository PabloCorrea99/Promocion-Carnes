-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema LaPromocion1.0
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema LaPromocion1.0
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `LaPromocion1.0` DEFAULT CHARACTER SET utf8 ;
USE `LaPromocion1.0` ;

-- -----------------------------------------------------
-- Table `LaPromocion1.0`.`Cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LaPromocion1.0`.`Cliente` (
  `idCliente` BIGINT NOT NULL,
  `nombreCliente` VARCHAR(45) NOT NULL,
  `apellidoCliente` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idCliente`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LaPromocion1.0`.`Empleado`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LaPromocion1.0`.`Empleado` (
  `idEmpleado` INT NOT NULL,
  `nombreEmpleado` VARCHAR(45) NOT NULL,
  `apellidoEmpleado` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idEmpleado`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LaPromocion1.0`.`Animal`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LaPromocion1.0`.`Animal` (
  `idAnimal` INT NOT NULL AUTO_INCREMENT,
  `Especie` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idAnimal`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LaPromocion1.0`.`Producto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LaPromocion1.0`.`Producto` (
  `idProducto` INT NOT NULL AUTO_INCREMENT,
  `nombreProducto` VARCHAR(45) NOT NULL,
  `Animal_idAnimal` INT NOT NULL,
  `PrecioLibra` INT NOT NULL,
  PRIMARY KEY (`idProducto`),
  INDEX `fk_Producto_Animal_idx` (`Animal_idAnimal` ASC),
  CONSTRAINT `fk_Producto_Animal`
    FOREIGN KEY (`Animal_idAnimal`)
    REFERENCES `LaPromocion1.0`.`Animal` (`idAnimal`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LaPromocion1.0`.`Compra`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LaPromocion1.0`.`Compra` (
  `idCompra` INT NOT NULL AUTO_INCREMENT,
  `Fecha` DATETIME NOT NULL,
  `Empleado_idEmpleado` INT NOT NULL,
  `Cliente_idCliente` BIGINT NOT NULL,
  PRIMARY KEY (`idCompra`),
  INDEX `fk_Compra_Empleado1_idx` (`Empleado_idEmpleado` ASC),
  INDEX `fk_Compra_Cliente1_idx` (`Cliente_idCliente` ASC),
  CONSTRAINT `fk_Compra_Empleado1`
    FOREIGN KEY (`Empleado_idEmpleado`)
    REFERENCES `LaPromocion1.0`.`Empleado` (`idEmpleado`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Compra_Cliente1`
    FOREIGN KEY (`Cliente_idCliente`)
    REFERENCES `LaPromocion1.0`.`Cliente` (`idCliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LaPromocion1.0`.`Compra_has_Producto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LaPromocion1.0`.`Compra_has_Producto` (
  `Compra_idCompra` INT NOT NULL,
  `Producto_idProducto` INT NOT NULL,
  `PesoProducto` FLOAT NOT NULL,
  `Total` INT NOT NULL,
  PRIMARY KEY (`Compra_idCompra`, `Producto_idProducto`),
  INDEX `fk_Compra_has_Producto_Producto1_idx` (`Producto_idProducto` ASC),
  INDEX `fk_Compra_has_Producto_Compra1_idx` (`Compra_idCompra` ASC),
  CONSTRAINT `fk_Compra_has_Producto_Compra1`
    FOREIGN KEY (`Compra_idCompra`)
    REFERENCES `LaPromocion1.0`.`Compra` (`idCompra`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Compra_has_Producto_Producto1`
    FOREIGN KEY (`Producto_idProducto`)
    REFERENCES `LaPromocion1.0`.`Producto` (`idProducto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LaPromocion1.0`.`Descuento`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LaPromocion1.0`.`Descuento` (
  `idDescuento` INT NOT NULL AUTO_INCREMENT,
  `Valor` INT NOT NULL,
  `Descripcion` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`idDescuento`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LaPromocion1.0`.`Factura`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LaPromocion1.0`.`Factura` (
  `idFactura` INT NOT NULL AUTO_INCREMENT,
  `Valor` INT NOT NULL,
  `Compra_idCompra` INT NOT NULL,
  PRIMARY KEY (`idFactura`),
  INDEX `fk_Factura_Compra1_idx` (`Compra_idCompra` ASC),
  CONSTRAINT `fk_Factura_Compra1`
    FOREIGN KEY (`Compra_idCompra`)
    REFERENCES `LaPromocion1.0`.`Compra` (`idCompra`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LaPromocion1.0`.`Producto_has_Descuento`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LaPromocion1.0`.`Producto_has_Descuento` (
  `Producto_idProducto` INT NOT NULL,
  `Descuento_idDescuento` INT NOT NULL,
  PRIMARY KEY (`Producto_idProducto`, `Descuento_idDescuento`),
  INDEX `fk_Producto_has_Descuento_Descuento1_idx` (`Descuento_idDescuento` ASC),
  INDEX `fk_Producto_has_Descuento_Producto1_idx` (`Producto_idProducto` ASC),
  CONSTRAINT `fk_Producto_has_Descuento_Producto1`
    FOREIGN KEY (`Producto_idProducto`)
    REFERENCES `LaPromocion1.0`.`Producto` (`idProducto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Producto_has_Descuento_Descuento1`
    FOREIGN KEY (`Descuento_idDescuento`)
    REFERENCES `LaPromocion1.0`.`Descuento` (`idDescuento`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `InsertarCliente`(IN idCliente BIGINT, IN nombreCliente VARCHAR(45), IN apellidoCliente VARCHAR(45))
BEGIN
	INSERT IGNORE INTO cliente (idCliente, nombreCliente, apellidoCliente) VALUES (idCliente, nombreCliente, apellidoCliente);
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `InsertarCompra`(IN Fecha DATETIME, IN Empleado_idEmpleado BIGINT, IN Cliente_idCliente BIGINT)
BEGIN
	INSERT IGNORE INTO compra (Fecha, Empleado_idEmpleado, Cliente_idCliente) VALUES (Fecha, Empleado_idEmpleado, Cliente_idCliente); 
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `InsertarCompra_has_Producto`(IN Producto_idProducto INT, IN PesoProducto FLOAT)
BEGIN
	DECLARE precio INT;
    DECLARE descuento INT;
    DECLARE valorADescontar INT;
    SET precio = (SELECT PrecioLibra FROM Producto WHERE idProducto = Producto_idProducto);
    SET descuento = (SELECT Valor FROM producto_has_descuento pd, descuento d WHERE pd.Descuento_idDescuento = d.idDescuento AND pd.Producto_idProducto = Producto_idProducto);
    SET valorADescontar = (precio*PesoProducto)*(descuento/100);
	INSERT INTO compra_has_producto (Compra_idCompra, Producto_idProducto, PesoProducto, Total) VALUES (last_insert_id(), Producto_idProducto, PesoProducto, (precio*PesoProducto) - ValorADescontar);
    SET descuento = 0;
	SET valorADescontar = 0;
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `InsertarFactura`(IN Valor INT)
BEGIN
	INSERT IGNORE INTO factura (Valor, Compra_idCompra) VALUES (Valor, last_insert_id());
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` FUNCTION `getTotalFactura`() RETURNS int(11)
    DETERMINISTIC
BEGIN
	DECLARE suma INT;
    DECLARE cont INT;
    DECLARE _Total INT;
    DECLARE i INT;
    DECLARE c1 CURSOR FOR SELECT Total from compra_has_producto WHERE Compra_idCompra = last_insert_id();
    
    SET suma = 0;
    SET cont = 0;
    SET _Total = 0;
    SET i = 1;
    SELECT COUNT(*) INTO cont FROM compra_has_producto WHERE Compra_idCompra = last_insert_id();
    
    open c1;
    while i<=cont do 
		FETCH c1 INTO _Total;
        SET suma = suma + _Total;
        SET i = i + 1;
    end while;
    close c1;
RETURN suma;
SET suma = 0;
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `InsertarDescuento`(IN Valor INT, IN Descripcion VARCHAR(100))
BEGIN
    INSERT IGNORE INTO Descuento (Valor, Descripcion) VALUES (Valor, Descripcion);
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `InsertarProducto_has_Descuento`(IN Producto_idProducto INT)
BEGIN
    INSERT IGNORE INTO Producto_has_Descuento (Producto_idProducto, Descuento_idDescuento) VALUES (Producto_idProducto, LAST_INSERT_ID());
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` FUNCTION `get_idCompra`() RETURNS int(11)
    DETERMINISTIC
BEGIN
	DECLARE var INT;
    SET var = (SELECT last_insert_id());
RETURN var;
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` FUNCTION `get_idFactura`() RETURNS int(11)
    DETERMINISTIC
BEGIN
	DECLARE id INT;
    SET id = (SELECT idFactura FROM factura WHERE idFactura = last_insert_id());
RETURN id;
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` FUNCTION `get_TotalFactura`() RETURNS int(11)
    DETERMINISTIC
BEGIN
	DECLARE total INT;
    SET total = (SELECT Valor FROM factura f WHERE f.idFactura = last_insert_id());
RETURN total;
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` FUNCTION `TotalFactura`(id INT) RETURNS int(11)
    DETERMINISTIC
BEGIN
	DECLARE valor INT;
    SET valor = (SELECT Valor FROM factura f WHERE f.idFactura = id); 
RETURN valor;
END$$
DELIMITER ;

INSERT INTO Animal (Especie) VALUES ("Pollo"),("Res"),("Cerdo"),("Pescado");
INSERT INTO Empleado (idEmpleado, nombreEmpleado, apellidoEmpleado) VALUES (1, "Pablo", "Correa");
INSERT INTO Producto (nombreProducto, Animal_idAnimal, PrecioLibra) VALUES ("Costilla", 2, 8500), ("Costilla", 3, 7000), ("Pechuga", 1, 7000);
INSERT INTO Descuento (Valor, Descripcion) VALUES (5, "Descuento carne de res"), (0, "N/A");
INSERT INTO Producto_has_Descuento (Producto_idProducto, Descuento_idDescuento) VALUES (1, 1), (2, 2), (3, 2);

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;