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

-- Copiando estrutura para tabela gop.ordens_executores
CREATE TABLE IF NOT EXISTS `ordens_executores` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_ordem` int DEFAULT NULL,
  `id_executor` int DEFAULT NULL,
  `tempo_horas` int DEFAULT NULL,
  `tempo_minutos` int DEFAULT NULL,
  `valor_hora` double DEFAULT NULL,
  `valor_total` double DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_ordens_executores_ordens` (`id_ordem`),
  KEY `FK_ordens_executores_executores` (`id_executor`),
  CONSTRAINT `FK_ordens_executores_executores` FOREIGN KEY (`id_executor`) REFERENCES `executores` (`id`),
  CONSTRAINT `FK_ordens_executores_ordens` FOREIGN KEY (`id_ordem`) REFERENCES `ordens` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Copiando dados para a tabela gop.ordens_executores: ~18 rows (aproximadamente)
REPLACE INTO `ordens_executores` (`id`, `id_ordem`, `id_executor`, `tempo_horas`, `tempo_minutos`, `valor_hora`, `valor_total`) VALUES
	(6, 24, 6, 4, 30, 15, 67.5),
	(7, 24, 5, 12, 20, 150, 1850),
	(9, 24, 5, 3, 35, 140, 501.66666666667),
	(10, 24, 5, 2, 30, 20, 50),
	(11, 38, 6, 2, 30, 150, 375),
	(12, 41, 7, 3, 40, 85, 311.66666666667),
	(17, 44, 5, 2, 40, 150, 400),
	(18, 44, 7, NULL, NULL, NULL, NULL),
	(19, 43, 7, 1, 30, 70, 105),
	(20, 47, 7, 3, 50, 151, 578.83333333333),
	(21, 45, 5, 1, 10, 85, 99.166666666667),
	(22, 39, 6, 3, 40, 105, 385),
	(23, 50, 5, 2, 30, 150, 375),
	(24, 55, 6, 2, 50, 90, 255),
	(25, 55, 5, 2, 30, 50, 125),
	(26, 54, 7, 2, 30, 90.5, 226.25),
	(29, 61, 6, 1, 0, 120, 120),
	(30, 61, 7, 2, 15, 120, 270);

-- Copiando estrutura para tabela gop.temp_custos
CREATE TABLE IF NOT EXISTS `temp_custos` (
  `id` int NOT NULL AUTO_INCREMENT,
  `valor_material` double DEFAULT NULL,
  `valor_servico` double DEFAULT NULL,
  `valor_total` double DEFAULT NULL,
  `descricao` varchar(120) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Copiando dados para a tabela gop.temp_custos: ~0 rows (aproximadamente)
REPLACE INTO `temp_custos` (`id`, `valor_material`, `valor_servico`, `valor_total`, `descricao`) VALUES
	(22, 129, 760, 889, 'Maria da Silva'),
	(23, 552.6, 805.08333333333, 1357.6833333333, 'Juliana Almeida'),
	(24, 270, 375, 645, 'Glaison Queiroz');

-- Copiando estrutura para tabela gop.temp_horas
CREATE TABLE IF NOT EXISTS `temp_horas` (
  `id` int NOT NULL AUTO_INCREMENT,
  `horas` int DEFAULT NULL,
  `minutos` int DEFAULT NULL,
  `executor` varchar(150) DEFAULT NULL,
  `tempo_grafico` int DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Copiando dados para a tabela gop.temp_horas: ~0 rows (aproximadamente)
REPLACE INTO `temp_horas` (`id`, `horas`, `minutos`, `executor`, `tempo_grafico`) VALUES
	(31, 8, 50, 'Glaison Queiroz', 9),
	(32, 13, 45, 'Juliana Almeida', 14),
	(33, 9, 60, 'Maria da Silva', 10);

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
