/*
 Navicat Premium Data Transfer

 Source Server         : localhost
 Source Server Type    : MySQL
 Source Server Version : 100408
 Source Host           : localhost:3306
 Source Schema         : ferreteria_mafe

 Target Server Type    : MySQL
 Target Server Version : 100408
 File Encoding         : 65001

 Date: 01/06/2020 10:57:41
*/

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
) ENGINE = InnoDB AUTO_INCREMENT = 32 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tblmovimiento
-- ----------------------------
INSERT INTO `tblmovimiento` VALUES (29, 109, 8, 100, 'Entrada', '2020-05-25', 10000);
INSERT INTO `tblmovimiento` VALUES (30, 109, 8, 10, 'Salida', '2020-05-26', 100);
INSERT INTO `tblmovimiento` VALUES (31, 127, 9, 500, 'Entrada', '2020-05-30', 200000);

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
) ENGINE = InnoDB AUTO_INCREMENT = 11 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tblproducto
-- ----------------------------
INSERT INTO `tblproducto` VALUES (8, 'Tejas', 'Pepito', 'b', 'asdasd', 1000, 100, 90);
INSERT INTO `tblproducto` VALUES (9, 'Tornillo', 'Torniquete', 'B', 'Mal estado', 1000, 100, 500);
INSERT INTO `tblproducto` VALUES (10, 'Bombillos', 'Cacki', 'd', NULL, 1600, 123, 0);

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
  PRIMARY KEY (`ProvId`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 128 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tblprovedor
-- ----------------------------
INSERT INTO `tblprovedor` VALUES (109, '213123', '3173731515', 'croameneses@gmail.com', 'Elpapu', 'Puntillas', 'Florencia, Caquetá', '16142 Cra. 8 ');
INSERT INTO `tblprovedor` VALUES (127, '123', '123123', 'croameneses@gmail.com', 'Seif', 'Lamadre', 'asdasd', 'asd');

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

	UPDATE tblproducto SET ProdDescripcion = Descripcion, ProdStock = Cantidad WHERE ProdId = llaveProd;
  INSERT INTO tblmovimiento VALUES(null,llaveProv,llaveProd,Cantidad,Estado,Fecha,Total); 

ELSE

	

	SET NCandidad=(SELECT MovCantidad FROM tblmovimiento INNER JOIN tblproducto ON tblmovimiento.MovProducto = tblproducto.ProdId WHERE ProdNombre = NProducto);
	SET CantidadAux=NCandidad-Cantidad;
	SET LlaveMov=(SELECT MovId FROM tblmovimiento INNER JOIN tblproducto ON tblmovimiento.MovProducto = tblproducto.ProdId WHERE ProdNombre = NProducto);
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
		INSERT INTO tblprovedor VALUES(null,nit,telefono,email,NEmpresa,TipoProduc,Ciudad,direccion);
		SELECT 'Agregado correctamente' AS message;
END
;;
delimiter ;

SET FOREIGN_KEY_CHECKS = 1;
