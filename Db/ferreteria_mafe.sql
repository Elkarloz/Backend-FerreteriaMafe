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

 Date: 30/04/2020 10:51:49
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for categoria
-- ----------------------------
DROP TABLE IF EXISTS `categoria`;
CREATE TABLE `categoria`  (
  `Id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `Nombre` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`Id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of categoria
-- ----------------------------
INSERT INTO `categoria` VALUES (1, 'a');

-- ----------------------------
-- Table structure for marca
-- ----------------------------
DROP TABLE IF EXISTS `marca`;
CREATE TABLE `marca`  (
  `Id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `Nombre` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`Id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of marca
-- ----------------------------
INSERT INTO `marca` VALUES (1, 'Roa');

-- ----------------------------
-- Table structure for movimiento
-- ----------------------------
DROP TABLE IF EXISTS `movimiento`;
CREATE TABLE `movimiento`  (
  `Id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `Proveedor` int(10) UNSIGNED NULL DEFAULT NULL COMMENT 'El proveedor al que se le compra, cuando es un ingreso',
  `Producto` int(10) UNSIGNED NOT NULL,
  `Cantidad` int(10) UNSIGNED NULL DEFAULT NULL,
  `TipoMov` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'ENTRADA/SALIDA',
  `Fecha` datetime(0) NULL DEFAULT NULL,
  PRIMARY KEY (`Id`) USING BTREE,
  INDEX `Producto`(`Producto`) USING BTREE,
  INDEX `Proveedor`(`Proveedor`) USING BTREE,
  CONSTRAINT `movimiento_ibfk_1` FOREIGN KEY (`Producto`) REFERENCES `producto` (`Id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `movimiento_ibfk_2` FOREIGN KEY (`Proveedor`) REFERENCES `proveedor` (`Id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for producto
-- ----------------------------
DROP TABLE IF EXISTS `producto`;
CREATE TABLE `producto`  (
  `Id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `Categoria` int(10) UNSIGNED NOT NULL,
  `Marca` int(10) UNSIGNED NOT NULL,
  `Nombre` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `Descripcion` varchar(800) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `Precio` decimal(18, 2) NULL DEFAULT NULL,
  `IvaPorcentaje` decimal(18, 2) NULL DEFAULT NULL,
  PRIMARY KEY (`Id`) USING BTREE,
  INDEX `Marca`(`Marca`) USING BTREE,
  INDEX `Categoria`(`Categoria`) USING BTREE,
  CONSTRAINT `producto_ibfk_1` FOREIGN KEY (`Marca`) REFERENCES `marca` (`Id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `producto_ibfk_2` FOREIGN KEY (`Categoria`) REFERENCES `categoria` (`Id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of producto
-- ----------------------------
INSERT INTO `producto` VALUES (1, 1, 1, 'Aguacate', NULL, NULL, NULL);

-- ----------------------------
-- Table structure for proveedor
-- ----------------------------
DROP TABLE IF EXISTS `proveedor`;
CREATE TABLE `proveedor`  (
  `Id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `Nombre` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `Identificacion` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`Id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

SET FOREIGN_KEY_CHECKS = 1;
