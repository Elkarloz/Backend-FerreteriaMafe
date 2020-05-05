/*
 Navicat Premium Data Transfer

 Source Server         : localhost
 Source Server Type    : MySQL
 Source Server Version : 100408
 Source Host           : localhost:3306
 Source Schema         : fereteria_mafe

 Target Server Type    : MySQL
 Target Server Version : 100408
 File Encoding         : 65001

 Date: 04/05/2020 20:11:46
*/

CREATE DATABASE fereteria_mafe;

USE fereteria_mafe 

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
  CONSTRAINT `MovProveedor` FOREIGN KEY (`MovProveedor`) REFERENCES `tblprovedor` (`ProvId`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `MovProducto` FOREIGN KEY (`MovProducto`) REFERENCES `tblproducto` (`ProdId`) ON DELETE RESTRICT ON UPDATE RESTRICT
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
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tblprovedor
-- ----------------------------
INSERT INTO `tblprovedor` VALUES (22, '1', '3144102488', '', '', '', '', '16142 Cra. 8 Florencia, Caquetá');
INSERT INTO `tblprovedor` VALUES (23, '1', '3144102488', '', '', '', '', '16142 Cra. 8 Florencia, Caquetá');
INSERT INTO `tblprovedor` VALUES (24, '1', '3144102488', '', '', '', '', '16142 Cra. 8 Florencia, Caquetá');
INSERT INTO `tblprovedor` VALUES (25, '1', '3144102488', '', '', '', '', '16142 Cra. 8 Florencia, Caquetá');
INSERT INTO `tblprovedor` VALUES (26, '1', '3144102488', '', '', '', '', '16142 Cra. 8 Florencia, Caquetá');
INSERT INTO `tblprovedor` VALUES (27, '1', '3144102488', '', '', '', '', '16142 Cra. 8 Florencia, Caquetá');
INSERT INTO `tblprovedor` VALUES (28, '1', '3144102488', '', '', '', '', '16142 Cra. 8 Florencia, Caquetá');
INSERT INTO `tblprovedor` VALUES (29, '1', '3144102488', '', '', '', '', '16142 Cra. 8 Florencia, Caquetá');
INSERT INTO `tblprovedor` VALUES (30, '1', '3144102488', '', '', '', '', '16142 Cra. 8 Florencia, Caquetá');
INSERT INTO `tblprovedor` VALUES (31, '1', '3144102488', '', '', '', '', '16142 Cra. 8 Florencia, Caquetá');
INSERT INTO `tblprovedor` VALUES (32, '1', '3144102488', '', '', '', '', '16142 Cra. 8 Florencia, Caquetá');
INSERT INTO `tblprovedor` VALUES (33, '1', '3144102488', '', '', '', '', '16142 Cra. 8 Florencia, Caquetá');
INSERT INTO `tblprovedor` VALUES (34, '1', '3144102488', '', '', '', '', '16142 Cra. 8 Florencia, Caquetá');
INSERT INTO `tblprovedor` VALUES (35, '1', '3144102488', '', '', '', '', '16142 Cra. 8 Florencia, Caquetá');

SET FOREIGN_KEY_CHECKS = 1;
