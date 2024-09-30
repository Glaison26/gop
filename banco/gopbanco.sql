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

-- Copiando estrutura para tabela gop.preventivas
CREATE TABLE IF NOT EXISTS `preventivas` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_recurso` int DEFAULT NULL,
  `id_espaco` int DEFAULT NULL,
  `id_oficina` int DEFAULT NULL,
  `id_centrodecusto` int DEFAULT NULL,
  `tipo` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'R = recurso E +espaco fisico / Edificação',
  `tipo_preventiva` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'sistema\r\npreditiva\r\nrotina',
  `data_cadastro` date NOT NULL,
  `periodicidade_geracao` int NOT NULL,
  `data_prox_realizacao` date DEFAULT NULL,
  `data_ult_realizacao` date DEFAULT NULL,
  `calibracao` char(1) DEFAULT NULL,
  `descritivo` blob,
  KEY `id` (`id`),
  KEY `FK_preventivas_recursos` (`id_recurso`),
  KEY `FK_preventivas_espacos` (`id_espaco`),
  KEY `FK_preventivas_oficinas` (`id_oficina`),
  KEY `FK_preventivas_centrodecusto` (`id_centrodecusto`),
  CONSTRAINT `FK_preventivas_centrodecusto` FOREIGN KEY (`id_centrodecusto`) REFERENCES `centrodecusto` (`id`),
  CONSTRAINT `FK_preventivas_espacos` FOREIGN KEY (`id_espaco`) REFERENCES `espacos` (`id`),
  CONSTRAINT `FK_preventivas_oficinas` FOREIGN KEY (`id_oficina`) REFERENCES `oficinas` (`id`),
  CONSTRAINT `FK_preventivas_recursos` FOREIGN KEY (`id_recurso`) REFERENCES `recursos` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Copiando dados para a tabela gop.preventivas: ~2 rows (aproximadamente)
INSERT INTO `preventivas` (`id`, `id_recurso`, `id_espaco`, `id_oficina`, `id_centrodecusto`, `tipo`, `tipo_preventiva`, `data_cadastro`, `periodicidade_geracao`, `data_prox_realizacao`, `data_ult_realizacao`, `calibracao`, `descritivo`) VALUES
	(1, 1, NULL, 3, 1, 'R', 'S', '2024-09-25', 30, '2024-10-25', '2024-09-25', 'N', _binary 0x7465737465),
	(2, 1, NULL, 3, 1, 'R', 'P', '2024-09-26', 45, '2024-11-10', '2024-09-26', 'N', _binary 0x746573746520636f6d20746573746520646520616c74657261c3a7c3a36f),
	(4, NULL, 2, 7, 2, 'E', 'P', '2024-09-26', 20, '2024-10-08', '2024-09-18', 'N', _binary 0x74657374652065737061c3a76f2066697369636f);

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
