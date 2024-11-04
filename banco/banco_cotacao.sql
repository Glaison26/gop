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

-- Copiando estrutura para tabela gop.cotacao
CREATE TABLE IF NOT EXISTS `cotacao` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_responsavel` int DEFAULT NULL,
  `descritivo` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `data` date DEFAULT NULL,
  `valor` double DEFAULT NULL,
  `status` char(50) DEFAULT NULL,
  `data_encerramento` date DEFAULT NULL,
  `observacao` blob,
  `tipo` char(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_cotacao_usuarios` (`id_responsavel`),
  CONSTRAINT `FK_cotacao_usuarios` FOREIGN KEY (`id_responsavel`) REFERENCES `usuarios` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Copiando dados para a tabela gop.cotacao: ~3 rows (aproximadamente)
INSERT INTO `cotacao` (`id`, `id_responsavel`, `descritivo`, `data`, `valor`, `status`, `data_encerramento`, `observacao`, `tipo`) VALUES
	(1, 16, 'Cotação para Material Elétrico para OS38', '2024-10-24', NULL, 'A', '2024-10-24', _binary 0x7465737465, 'M'),
	(4, 16, 'Cotação Material Obra do Estacionamento', '2024-10-24', NULL, 'A', NULL, NULL, 'M'),
	(5, 16, 'Cotação Manutenção de Bomba de Infusão', '2024-10-24', NULL, 'A', NULL, NULL, 'M'),
	(7, 16, 'Serviço de Pintura', '2024-10-29', NULL, 'A', NULL, NULL, 'S');

-- Copiando estrutura para tabela gop.cotacao_fornecedor
CREATE TABLE IF NOT EXISTS `cotacao_fornecedor` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_cotacao` int DEFAULT NULL,
  `id_fornecedor` int DEFAULT NULL,
  `observacao` blob,
  `status` char(1) DEFAULT NULL,
  `valor_total` double DEFAULT NULL,
  `frete` double DEFAULT NULL,
  `prazo` int DEFAULT NULL,
  `forma_pagamento` varchar(100) DEFAULT NULL,
  `vendedor` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK__cotacao` (`id_cotacao`),
  KEY `FK__fornecedores` (`id_fornecedor`),
  CONSTRAINT `FK__cotacao` FOREIGN KEY (`id_cotacao`) REFERENCES `cotacao` (`id`),
  CONSTRAINT `FK__fornecedores` FOREIGN KEY (`id_fornecedor`) REFERENCES `fornecedores` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Copiando dados para a tabela gop.cotacao_fornecedor: ~6 rows (aproximadamente)
INSERT INTO `cotacao_fornecedor` (`id`, `id_cotacao`, `id_fornecedor`, `observacao`, `status`, `valor_total`, `frete`, `prazo`, `forma_pagamento`, `vendedor`) VALUES
	(1, 1, 3, _binary 0x746573746520646520696e636c7573c3a36f, 'P', 68, 45, 30, 'A vista', 'Astolfo Nunes'),
	(2, 1, 1, _binary 0x746573746532, 'C', 63.2, 45, 45, 'A vista', 'Danllo Alves'),
	(3, 5, 2, _binary '', 'B', 523.8, 45, 8, 'A vista', 'Astolfo Nunes'),
	(4, 5, 3, _binary '', 'P', 533, 15.5, 30, '30 dias', 'Carlos Augusto'),
	(5, 4, 2, _binary '', 'C', 839, 15.5, 7, 'A Vista', 'Alfredo Duarte'),
	(6, 4, 3, _binary '', 'Z', 995, 15.5, 3, 'A Vista', 'Carlos Augusto'),
	(7, 1, 2, _binary '', 'Z', 95, 15, 10, 'a vista', 'Pedro Neves');

-- Copiando estrutura para tabela gop.cotacao_materiais
CREATE TABLE IF NOT EXISTS `cotacao_materiais` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_cotacao` int DEFAULT NULL,
  `id_material` int DEFAULT NULL,
  `id_unidade` int DEFAULT NULL,
  `quantidade` double DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_cotacao_materiais_cotacao` (`id_cotacao`),
  KEY `FK_cotacao_materiais_materiais` (`id_material`),
  KEY `FK_cotacao_materiais_unidades` (`id_unidade`),
  CONSTRAINT `FK_cotacao_materiais_cotacao` FOREIGN KEY (`id_cotacao`) REFERENCES `cotacao` (`id`),
  CONSTRAINT `FK_cotacao_materiais_materiais` FOREIGN KEY (`id_material`) REFERENCES `materiais` (`id`),
  CONSTRAINT `FK_cotacao_materiais_unidades` FOREIGN KEY (`id_unidade`) REFERENCES `unidades` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Copiando dados para a tabela gop.cotacao_materiais: ~7 rows (aproximadamente)
INSERT INTO `cotacao_materiais` (`id`, `id_cotacao`, `id_material`, `id_unidade`, `quantidade`) VALUES
	(5, 5, 4, 8, 2),
	(6, 5, 3, 8, 2),
	(7, 5, 2, 8, 10),
	(8, 1, 3, 10, 10),
	(9, 1, 4, 8, 2),
	(10, 4, 3, 10, 3),
	(11, 4, 2, 8, 1000);

-- Copiando estrutura para tabela gop.cotacao_materiais_fornecedor
CREATE TABLE IF NOT EXISTS `cotacao_materiais_fornecedor` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_material` int DEFAULT NULL,
  `id_fornecedor` int DEFAULT NULL,
  `id_cotacao_fornecedor` int DEFAULT NULL,
  `valor_unitario` double DEFAULT NULL,
  `prazo_entrega` date DEFAULT NULL,
  `valor_total` double DEFAULT NULL,
  `quantidade` double DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK__materiais` (`id_material`),
  KEY `FK_cotacao_materiais_fornecedor_fornecedores` (`id_fornecedor`),
  KEY `FK_cotacao_materiais_fornecedor_cotacao_fornecedor` (`id_cotacao_fornecedor`),
  CONSTRAINT `FK_cotacao_materiais_fornecedor_cotacao_fornecedor` FOREIGN KEY (`id_cotacao_fornecedor`) REFERENCES `cotacao_fornecedor` (`id`),
  CONSTRAINT `FK_cotacao_materiais_fornecedor_fornecedores` FOREIGN KEY (`id_fornecedor`) REFERENCES `fornecedores` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Copiando dados para a tabela gop.cotacao_materiais_fornecedor: ~13 rows (aproximadamente)
INSERT INTO `cotacao_materiais_fornecedor` (`id`, `id_material`, `id_fornecedor`, `id_cotacao_fornecedor`, `valor_unitario`, `prazo_entrega`, `valor_total`, `quantidade`) VALUES
	(4, 4, 2, 3, 17.4, '2024-11-22', 34.8, 2),
	(5, 3, 2, 3, 160.5, '2024-11-29', 321, 2),
	(6, 2, 2, 3, 16.8, '2024-11-28', 168, 10),
	(7, 4, 3, 4, 80, '2024-10-30', 160, 2),
	(8, 3, 3, 4, 130, '2024-10-31', 260, 2),
	(9, 2, 3, 4, 11.3, '2024-11-02', 113, 10),
	(10, 3, 1, 2, 5.3, '2024-11-04', 53, 10),
	(11, 4, 1, 2, 5.1, '2024-11-03', 10.2, 2),
	(12, 3, 3, 1, 6, '2024-10-31', 60, 10),
	(13, 4, 3, 1, 4, '2024-10-31', 8, 2),
	(14, 3, 2, 5, 13, '2024-11-01', 39, 3),
	(15, 3, 3, 6, 15, '2024-11-01', 45, 3),
	(16, 2, 2, 5, 0.8, '2024-11-01', 800, 1000),
	(17, 2, 3, 6, 0.95, '2024-11-01', 950, 1000),
	(18, 3, 2, 7, 3.5, '2024-11-03', 35, 10),
	(19, 4, 2, 7, 30, '2024-11-03', 60, 2);

-- Copiando estrutura para tabela gop.cotacao_servicos
CREATE TABLE IF NOT EXISTS `cotacao_servicos` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_cotacao` int DEFAULT NULL,
  `descricao` blob,
  PRIMARY KEY (`id`),
  KEY `FK_cotacao_servicos_cotacao` (`id_cotacao`),
  CONSTRAINT `FK_cotacao_servicos_cotacao` FOREIGN KEY (`id_cotacao`) REFERENCES `cotacao` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Copiando dados para a tabela gop.cotacao_servicos: ~2 rows (aproximadamente)
INSERT INTO `cotacao_servicos` (`id`, `id_cotacao`, `descricao`) VALUES
	(1, 4, _binary 0x5365727669c3a76f2064652050696e74757261206465207061726564652064652045646966696361c3a7c3a36f2064650a3930206d6574726f7320717561647261646f73),
	(3, 7, _binary 0x5265637573747275c3a7c3a36f20646520466178616461206465205072c3a964696f);

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
