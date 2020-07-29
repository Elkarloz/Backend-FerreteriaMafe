/*

 Navicat Premium Data Transfer

 Source Server         : Localhost
 Source Server Type    : MySQL
 Source Server Version : 100408
 Source Host           : localhost:3306
 Source Schema         : ferreteria_mafe

 Target Server Type    : MySQL
 Target Server Version : 100408
 File Encoding         : 65001

 Date: 20/07/2020 19:25:12
*/
use ferreteria;




SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for tblmovimiento
-- ----------------------------
DROP TABLE IF EXISTS `tblmovimiento`;
CREATE TABLE `tblmovimiento`  (
  `MovId` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `MovProveedor` int(10) UNSIGNED NULL DEFAULT NULL COMMENT 'El proveedor al que se le compra, cuando es un ingreso',
  `MovProducto` int(10) UNSIGNED NOT NULL,
  `MovCantidad` int(10) UNSIGNED NULL DEFAULT NULL,
  `MovTipo` enum('Entrada','Salida') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'ENTRADA/SALIDA',
  `MovFecha` date NULL DEFAULT NULL,
  `MovTotal` int(10) NULL DEFAULT NULL,
  PRIMARY KEY (`MovId`) USING BTREE,
  INDEX `MovProveedor`(`MovProveedor`) USING BTREE,
  INDEX `MovProducto`(`MovProducto`) USING BTREE,
  CONSTRAINT `MovProducto` FOREIGN KEY (`MovProducto`) REFERENCES `tblproducto` (`ProdId`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `MovProveedor` FOREIGN KEY (`MovProveedor`) REFERENCES `tblprovedor` (`ProvId`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 41 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of tblmovimiento
-- ----------------------------

-- ----------------------------
-- Table structure for tblproducto
-- ----------------------------
DROP TABLE IF EXISTS `tblproducto`;
CREATE TABLE `tblproducto`  (
  `ProdId` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `ProdNombre` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `ProdMarca` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `ProdCategoria` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `ProdDescripcion` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `ProdPrecio` int(200) NOT NULL,
  `ProdIva` int(200) NOT NULL,
  `ProdStock` int(200) NULL DEFAULT NULL,
  PRIMARY KEY (`ProdId`) USING BTREE,
  INDEX `ProdMarca`(`ProdMarca`) USING BTREE,
  INDEX `ProdCategoria`(`ProdNombre`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 12 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of tblproducto
-- ----------------------------

-- ----------------------------
-- Table structure for tblprovedor
-- ----------------------------
DROP TABLE IF EXISTS `tblprovedor`;
CREATE TABLE `tblprovedor`  (
  `ProvId` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `ProvNit` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `ProvTelefono` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `ProvEmail` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `ProvNEmpresa` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `ProvTipProducto` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `ProvCiudad` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `ProvDireccion` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `ProvEstado` enum('Activo','Inactivo') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`ProvId`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 132 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of tblprovedor
-- ----------------------------
INSERT INTO `tblprovedor` VALUES (131, 'asd', 'asd', 'asd', 'asd', 'asd', 'asd', 'asd', 'Inactivo');

-- ----------------------------
-- Procedure structure for Actualizar_Prov
-- ----------------------------
DROP PROCEDURE IF EXISTS `Actualizar_Prov`;
delimiter ;;
CREATE PROCEDURE `Actualizar_Prov`(IN codigo INT,
	IN nit VARCHAR ( 100 ),
	IN telefono VARCHAR ( 100 ),
	IN email VARCHAR ( 100 ),
	IN NEmpresa VARCHAR ( 100 ),
	IN TipoProduc VARCHAR ( 100 ),
	IN Ciudad VARCHAR ( 100 ),
	IN direccion VARCHAR ( 100 ))
BEGIN
	UPDATE tblprovedor 
	SET ProvNit = nit,
	ProvTelefono = telefono,
	ProvEmail = email,
	ProvNEmpresa = NEmpresa,
	ProvTipProducto = TipoProduc,
	ProvCiudad = Ciudad,
	ProvDireccion = direccion
	WHERE
		ProvId = codigo;
	SELECT 'Actualizado correctamente' AS message;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for agregarEntrada
-- ----------------------------
DROP PROCEDURE IF EXISTS `agregarEntrada`;
delimiter ;;
CREATE PROCEDURE `agregarEntrada`(IN Estado VARCHAR(10),
IN NProducto VARCHAR (100),
IN NEmpresa VARCHAR(100),
IN Descripcion VARCHAR(100),
IN Cantidad INT,
IN Total INT,
IN Fecha DATE)
BEGIN

DECLARE llaveProd INT;
DECLARE llaveProv INT;
DECLARE NCandidad INT;
DECLARE LlaveMov INT;
DECLARE CantidadAux INT;

IF(Estado='Entrada')THEN
	

	SET llaveProd=(SELECT ProdId FROM tblproducto WHERE ProdNombre = NProducto);
	SET llaveProv=(SELECT ProvId FROM tblprovedor WHERE ProvNEmpresa = NEmpresa);
	SET NCandidad=(SELECT SUM(MovCantidad) FROM tblmovimiento INNER JOIN tblproducto ON tblmovimiento.MovProducto = tblproducto.ProdId WHERE ProdNombre = NProducto);
	SET CantidadAux=NCandidad+Cantidad;
	UPDATE tblproducto SET ProdDescripcion = Descripcion, ProdStock = CantidadAux WHERE ProdId = llaveProd;
  INSERT INTO tblmovimiento VALUES(null,llaveProv,llaveProd,Cantidad,Estado,Fecha,Total); 

ELSE

	SET NCandidad=(SELECT SUM(MovCantidad) FROM tblmovimiento INNER JOIN tblproducto ON tblmovimiento.MovProducto = tblproducto.ProdId WHERE ProdNombre = NProducto);
	SET CantidadAux=NCandidad-Cantidad;
	SET LlaveMov=(SELECT MovId FROM tblmovimiento INNER JOIN tblproducto ON tblmovimiento.MovProducto = tblproducto.ProdId WHERE ProdNombre = NProducto order by MovId desc limit 1);
	SET llaveProd=(SELECT ProdId FROM tblproducto WHERE ProdNombre = NProducto);
	SET llaveProv=(SELECT ProvId FROM tblprovedor WHERE ProvNEmpresa = NEmpresa);
	
	INSERT INTO tblmovimiento VALUES(null,llaveProv,llaveProd,Cantidad,Estado,Fecha,Total);
	
	UPDATE tblproducto SET ProdDescripcion = Descripcion, ProdStock = CantidadAux WHERE ProdId = llaveProd;
	
	
	
END IF;

END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for agregar_Prod
-- ----------------------------
DROP PROCEDURE IF EXISTS `agregar_Prod`;
delimiter ;;
CREATE PROCEDURE `agregar_Prod`(IN Nombre VARCHAR ( 100 ),
IN Marca VARCHAR ( 100 ),
IN Categoria VARCHAR ( 100 ),
IN Precio INT,
IN Iva INT)
BEGIN 

INSERT INTO tblproducto VALUES(null,Nombre,Marca,Categoria,null,Precio,Iva,0);
SELECT 'Agregado correctamente' AS message;

END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for Agregar_Prov
-- ----------------------------
DROP PROCEDURE IF EXISTS `Agregar_Prov`;
delimiter ;;
CREATE PROCEDURE `Agregar_Prov`(IN nit VARCHAR ( 100 ),
	IN telefono VARCHAR ( 100 ),
	IN email VARCHAR ( 100 ),
	IN NEmpresa VARCHAR ( 100 ),
	IN TipoProduc VARCHAR ( 100 ),
	IN Ciudad VARCHAR ( 100 ),
	IN direccion VARCHAR ( 100 ))
BEGIN
		INSERT INTO tblprovedor VALUES(null,nit,telefono,email,NEmpresa,TipoProduc,Ciudad,direccion,"Activo");
		SELECT 'Agregado correctamente' AS message;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for EliminarProv
-- ----------------------------
DROP PROCEDURE IF EXISTS `EliminarProv`;
delimiter ;;
CREATE PROCEDURE `EliminarProv`(IN Codigo INT)
BEGIN

UPDATE tblprovedor
SET ProvEstado="Inactivo"
	WHERE
		ProvId = Codigo;
	SELECT 'Eliminado correctamente' AS message;

END
;;
delimiter ;

SET FOREIGN_KEY_CHECKS = 1;
