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

 Date: 08/05/2020 12:15:29
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for tblcategoria
-- ----------------------------
DROP TABLE IF EXISTS `tblcategoria`;
CREATE TABLE `tblcategoria`  (
  `CatId` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `CatNombre` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`CatId`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tblcategoria
-- ----------------------------
INSERT INTO `tblcategoria` VALUES (1, 'a');

-- ----------------------------
-- Table structure for tblmarca
-- ----------------------------
DROP TABLE IF EXISTS `tblmarca`;
CREATE TABLE `tblmarca`  (
  `MarId` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `MarNombre` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`MarId`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tblmarca
-- ----------------------------
INSERT INTO `tblmarca` VALUES (1, 'Roa');

-- ----------------------------
-- Table structure for tblmovimiento
-- ----------------------------
DROP TABLE IF EXISTS `tblmovimiento`;
CREATE TABLE `tblmovimiento`  (
  `MovId` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `MovProveedor` int(10) UNSIGNED NULL DEFAULT NULL COMMENT 'El proveedor al que se le compra, cuando es un ingreso',
  `MovProducto` int(10) UNSIGNED NOT NULL,
  `MovCantidad` int(10) UNSIGNED NULL DEFAULT NULL,
  `MovTipo` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'ENTRADA/SALIDA',
  `MovFecha` datetime(0) NULL DEFAULT NULL,
  PRIMARY KEY (`MovId`) USING BTREE,
  INDEX `MovProveedor`(`MovProveedor`) USING BTREE,
  INDEX `MovProducto`(`MovProducto`) USING BTREE,
  CONSTRAINT `MovProducto` FOREIGN KEY (`MovProducto`) REFERENCES `tblproducto` (`ProdId`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `MovProveedor` FOREIGN KEY (`MovProveedor`) REFERENCES `tblprovedor` (`ProvId`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for tblproducto
-- ----------------------------
DROP TABLE IF EXISTS `tblproducto`;
CREATE TABLE `tblproducto`  (
  `ProdId` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `ProdCategoria` int(10) UNSIGNED NOT NULL,
  `ProdMarca` int(10) UNSIGNED NOT NULL,
  `ProdNombre` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `ProdDescripcion` varchar(800) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `ProdPrecio` decimal(18, 2) NULL DEFAULT NULL,
  `ProdIva` decimal(18, 2) NULL DEFAULT NULL,
  PRIMARY KEY (`ProdId`) USING BTREE,
  INDEX `ProdMarca`(`ProdMarca`) USING BTREE,
  INDEX `ProdCategoria`(`ProdCategoria`) USING BTREE,
  CONSTRAINT `ProdCategoria` FOREIGN KEY (`ProdCategoria`) REFERENCES `tblcategoria` (`CatId`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `ProdMarca` FOREIGN KEY (`ProdMarca`) REFERENCES `tblmarca` (`MarId`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tblproducto
-- ----------------------------
INSERT INTO `tblproducto` VALUES (1, 1, 1, 'Aguacate', NULL, NULL, NULL);

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
) ENGINE = InnoDB AUTO_INCREMENT = 107 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

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
END
;;
delimiter ;

SET FOREIGN_KEY_CHECKS = 1;
