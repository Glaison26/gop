-- --------------------------------------------------------
-- Servidor:                     127.0.0.1
-- Versão do servidor:           8.0.30 - MySQL Community Server - GPL
-- OS do Servidor:               Win64
-- HeidiSQL Versão:              12.1.0.6537
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Copiando estrutura do banco de dados para gop
CREATE DATABASE IF NOT EXISTS `gop` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `gop`;

-- Copiando estrutura para tabela gop.obra
CREATE TABLE IF NOT EXISTS `obra` (
  `id` int NOT NULL AUTO_INCREMENT,
  `descricao` varchar(200) DEFAULT NULL,
  `observacao` blob,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Copiando dados para a tabela gop.obra: ~0 rows (aproximadamente)
INSERT INTO `obra` (`id`, `descricao`, `observacao`) VALUES
	(1, 'Vestiários do Bloco Cirúrgico', NULL),
	(2, 'Reforma do Centro Obstétrico', NULL),
	(3, 'Medição de Obra Laboratório Medição Geral', NULL),
	(5, 'Restauração de Fachada UPA', _binary 0x72657374617261c3a7c3a36f206465206661636861646120636f6d207265637572736f73207072c3b37072696f730a646f20686f73706974616c);

-- Copiando estrutura para tabela gop.obras_grupo
CREATE TABLE IF NOT EXISTS `obras_grupo` (
  `id` int NOT NULL AUTO_INCREMENT,
  `descricao` varchar(150) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Copiando dados para a tabela gop.obras_grupo: ~6 rows (aproximadamente)
INSERT INTO `obras_grupo` (`id`, `descricao`) VALUES
	(1, 'Projetos Técnicos'),
	(2, 'Sondagens'),
	(3, 'Instalação de Canteiro de Obras'),
	(4, 'Limpeza de Terreno'),
	(5, 'Locação de Obra'),
	(6, 'Aterro e Compactação');

-- Copiando estrutura para tabela gop.obras_insumos
CREATE TABLE IF NOT EXISTS `obras_insumos` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_item` int DEFAULT NULL,
  `id_obra` int DEFAULT NULL,
  `id_unidade` int DEFAULT NULL,
  `quantidade` int DEFAULT NULL,
  `valor_maodeobra` double DEFAULT NULL,
  `valor_material` double DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_obras_insumos_obras_itens` (`id_item`),
  KEY `FK_obras_insumos_obra` (`id_obra`),
  KEY `FK_obras_insumos_unidades` (`id_unidade`),
  CONSTRAINT `FK_obras_insumos_obra` FOREIGN KEY (`id_obra`) REFERENCES `obra` (`id`),
  CONSTRAINT `FK_obras_insumos_obras_itens` FOREIGN KEY (`id_item`) REFERENCES `obras_itens` (`id`),
  CONSTRAINT `FK_obras_insumos_unidades` FOREIGN KEY (`id_unidade`) REFERENCES `unidades` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Copiando dados para a tabela gop.obras_insumos: ~1 rows (aproximadamente)
INSERT INTO `obras_insumos` (`id`, `id_item`, `id_obra`, `id_unidade`, `quantidade`, `valor_maodeobra`, `valor_material`) VALUES
	(1, 1, 3, 8, 1, 1000, 2000);

-- Copiando estrutura para tabela gop.obras_itens
CREATE TABLE IF NOT EXISTS `obras_itens` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_grupo` int DEFAULT NULL,
  `id_unidade` int DEFAULT NULL,
  `descricao` varchar(200) DEFAULT NULL,
  `valor_maodeobra` double DEFAULT NULL,
  `valor_material` double DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_obras_itens_obras_grupo` (`id_grupo`),
  KEY `FK_obras_itens_unidades` (`id_unidade`),
  CONSTRAINT `FK_obras_itens_obras_grupo` FOREIGN KEY (`id_grupo`) REFERENCES `obras_grupo` (`id`),
  CONSTRAINT `FK_obras_itens_unidades` FOREIGN KEY (`id_unidade`) REFERENCES `unidades` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Copiando dados para a tabela gop.obras_itens: ~3 rows (aproximadamente)
INSERT INTO `obras_itens` (`id`, `id_grupo`, `id_unidade`, `descricao`, `valor_maodeobra`, `valor_material`) VALUES
	(1, 6, 8, 'Compactação de Aterro', 1000, 2000),
	(2, 4, 1, 'Corte manual de capoeira fina a foice', 1000, 5000),
	(3, 5, 1, 'Locação da obra: Execução de Gabarito', 150.9, 900);

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
