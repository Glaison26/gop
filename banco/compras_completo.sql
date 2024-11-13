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

-- Copiando estrutura para tabela gop.compras
CREATE TABLE IF NOT EXISTS `compras` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_fornecedor` int DEFAULT NULL,
  `id_cotacao_fornecedor` int DEFAULT NULL,
  `data` date DEFAULT NULL,
  `tipo` varchar(50) DEFAULT NULL,
  `nota` varchar(30) DEFAULT NULL,
  `condicoes_pag` varchar(100) DEFAULT NULL,
  `vencimento` date DEFAULT NULL,
  `comprador` varchar(100) DEFAULT NULL,
  `prazo` varchar(50) DEFAULT NULL,
  `valor` double DEFAULT NULL,
  `status` char(1) DEFAULT NULL,
  `tipo_compra` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '0',
  `valor_frete` double DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_compras_fornecedores` (`id_fornecedor`),
  KEY `FK_compras_cotacao_fornecedor` (`id_cotacao_fornecedor`),
  CONSTRAINT `FK_compras_cotacao_fornecedor` FOREIGN KEY (`id_cotacao_fornecedor`) REFERENCES `cotacao_fornecedor` (`id`),
  CONSTRAINT `FK_compras_fornecedores` FOREIGN KEY (`id_fornecedor`) REFERENCES `fornecedores` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Copiando dados para a tabela gop.compras: ~0 rows (aproximadamente)
INSERT INTO `compras` (`id`, `id_fornecedor`, `id_cotacao_fornecedor`, `data`, `tipo`, `nota`, `condicoes_pag`, `vencimento`, `comprador`, `prazo`, `valor`, `status`, `tipo_compra`, `valor_frete`) VALUES
	(5, 2, 8, '2024-11-13', 'Avulsas Internas', NULL, 'a vista', NULL, 'Emilio Santiago', '25', 88.5, 'A', 'M', 25),
	(6, 1, 12, '2024-11-13', 'Operacionais', NULL, 'a vista', NULL, 'Emilio Santiago', '12', 415, 'A', 'M', 17);

-- Copiando estrutura para tabela gop.compras_materiais
CREATE TABLE IF NOT EXISTS `compras_materiais` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_compra` int DEFAULT NULL,
  `id_material` int DEFAULT NULL,
  `id_unidade` int DEFAULT NULL,
  `quantidade` double DEFAULT NULL,
  `valor_unitario` double DEFAULT NULL,
  `valor_total` double DEFAULT NULL,
  `data_entrega` date DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK__materiais` (`id_material`),
  KEY `FK__unidades` (`id_unidade`),
  KEY `FK_compras_materiais_compras` (`id_compra`),
  CONSTRAINT `FK__materiais` FOREIGN KEY (`id_material`) REFERENCES `materiais` (`id`),
  CONSTRAINT `FK__unidades` FOREIGN KEY (`id_unidade`) REFERENCES `unidades` (`id`),
  CONSTRAINT `FK_compras_materiais_compras` FOREIGN KEY (`id_compra`) REFERENCES `compras` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Copiando dados para a tabela gop.compras_materiais: ~5 rows (aproximadamente)
INSERT INTO `compras_materiais` (`id`, `id_compra`, `id_material`, `id_unidade`, `quantidade`, `valor_unitario`, `valor_total`, `data_entrega`) VALUES
	(1, 5, 3, NULL, 3, 17, 51, '2024-11-15'),
	(2, 5, 4, NULL, 3, 5, 15, '2024-11-05'),
	(3, 5, 2, NULL, 15, 1.5, 22.5, '2024-11-05'),
	(4, 6, 3, 10, 20, 7, 140, '2024-11-22'),
	(5, 6, 2, 8, 50, 5.5, 275, '2024-11-26');

-- Copiando estrutura para tabela gop.compras_servicos
CREATE TABLE IF NOT EXISTS `compras_servicos` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_compra` int DEFAULT NULL,
  `descricao` varchar(150) DEFAULT NULL,
  `valor` double DEFAULT NULL,
  `servico` blob,
  PRIMARY KEY (`id`),
  KEY `FK__compras` (`id_compra`),
  CONSTRAINT `FK__compras` FOREIGN KEY (`id_compra`) REFERENCES `compras` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Copiando dados para a tabela gop.compras_servicos: ~0 rows (aproximadamente)

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
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Copiando dados para a tabela gop.cotacao: ~0 rows (aproximadamente)
INSERT INTO `cotacao` (`id`, `id_responsavel`, `descritivo`, `data`, `valor`, `status`, `data_encerramento`, `observacao`, `tipo`) VALUES
	(8, 16, 'Cotação Material Obra do Estacionamento', '2024-11-04', NULL, 'A', NULL, NULL, 'M'),
	(9, 16, 'Cotação para estoque Operacional', '2024-11-13', NULL, 'A', NULL, NULL, 'M');

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
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Copiando dados para a tabela gop.cotacao_fornecedor: ~2 rows (aproximadamente)
INSERT INTO `cotacao_fornecedor` (`id`, `id_cotacao`, `id_fornecedor`, `observacao`, `status`, `valor_total`, `frete`, `prazo`, `forma_pagamento`, `vendedor`) VALUES
	(8, 8, 2, _binary '', 'C', 88.5, 25, 25, 'a vista', 'Umberto Ramos'),
	(9, 8, 1, _binary '', 'Z', 180, 16, 22, 'a vista', 'Maria Aparecida'),
	(10, 8, 3, _binary '', 'P', 132, 17, 23, 'a vista', 'Rafaela dos Santos'),
	(11, 9, 2, _binary '', 'Z', 480, 15, 10, 'a vista', 'Umberto Ramos'),
	(12, 9, 1, _binary '', 'C', 415, 17, 12, 'a vista', 'Astolfo Nunes'),
	(13, 9, 3, _binary '', 'P', 540, 17.5, 13, 'A vista', 'Danllo Alves');

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
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Copiando dados para a tabela gop.cotacao_materiais: ~2 rows (aproximadamente)
INSERT INTO `cotacao_materiais` (`id`, `id_cotacao`, `id_material`, `id_unidade`, `quantidade`) VALUES
	(1, 8, 3, 10, 3),
	(2, 8, 4, 8, 3),
	(3, 8, 2, 8, 15),
	(4, 9, 3, 10, 20),
	(5, 9, 2, 8, 50);

-- Copiando estrutura para tabela gop.cotacao_materiais_fornecedor
CREATE TABLE IF NOT EXISTS `cotacao_materiais_fornecedor` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_material` int DEFAULT NULL,
  `id_fornecedor` int DEFAULT NULL,
  `id_cotacao_fornecedor` int DEFAULT NULL,
  `id_unidade` int DEFAULT NULL,
  `valor_unitario` double DEFAULT NULL,
  `prazo_entrega` date DEFAULT NULL,
  `valor_total` double DEFAULT NULL,
  `quantidade` double DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK__materiais` (`id_material`),
  KEY `FK_cotacao_materiais_fornecedor_fornecedores` (`id_fornecedor`),
  KEY `FK_cotacao_materiais_fornecedor_cotacao_fornecedor` (`id_cotacao_fornecedor`),
  KEY `FK_cotacao_materiais_fornecedor_unidades` (`id_unidade`),
  CONSTRAINT `FK_cotacao_materiais_fornecedor_cotacao_fornecedor` FOREIGN KEY (`id_cotacao_fornecedor`) REFERENCES `cotacao_fornecedor` (`id`),
  CONSTRAINT `FK_cotacao_materiais_fornecedor_fornecedores` FOREIGN KEY (`id_fornecedor`) REFERENCES `fornecedores` (`id`),
  CONSTRAINT `FK_cotacao_materiais_fornecedor_unidades` FOREIGN KEY (`id_unidade`) REFERENCES `unidades` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Copiando dados para a tabela gop.cotacao_materiais_fornecedor: ~8 rows (aproximadamente)
INSERT INTO `cotacao_materiais_fornecedor` (`id`, `id_material`, `id_fornecedor`, `id_cotacao_fornecedor`, `id_unidade`, `valor_unitario`, `prazo_entrega`, `valor_total`, `quantidade`) VALUES
	(1, 3, 2, 8, NULL, 17, '2024-11-15', 51, 3),
	(2, 4, 2, 8, NULL, 5, '2024-11-05', 15, 3),
	(3, 2, 2, 8, NULL, 1.5, '2024-11-05', 22.5, 15),
	(4, 3, 1, 9, NULL, 7, '2024-11-05', 21, 3),
	(5, 4, 1, 9, NULL, 8, '2024-11-04', 24, 3),
	(6, 2, 1, 9, NULL, 9, '2024-11-04', 135, 15),
	(7, 3, 3, 10, NULL, 4.5, '2024-11-05', 13.5, 3),
	(8, 4, 3, 10, NULL, 6, '2024-11-05', 18, 3),
	(9, 2, 3, 10, NULL, 6.7, '2024-11-06', 100.5, 15),
	(10, 3, 2, 11, 10, 9, '2024-11-21', 180, 20),
	(11, 2, 2, 11, 8, 6, '2024-11-13', 300, 50),
	(12, 3, 1, 12, 10, 7, '2024-11-22', 140, 20),
	(13, 2, 1, 12, 8, 5.5, '2024-11-26', 275, 50),
	(14, 3, 3, 13, 10, 7, '2024-11-20', 140, 20),
	(15, 2, 3, 13, 8, 8, '2024-11-21', 400, 50);

-- Copiando estrutura para tabela gop.cotacao_servicos
CREATE TABLE IF NOT EXISTS `cotacao_servicos` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_cotacao` int DEFAULT NULL,
  `descricao` blob,
  PRIMARY KEY (`id`),
  KEY `FK_cotacao_servicos_cotacao` (`id_cotacao`),
  CONSTRAINT `FK_cotacao_servicos_cotacao` FOREIGN KEY (`id_cotacao`) REFERENCES `cotacao` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Copiando dados para a tabela gop.cotacao_servicos: ~0 rows (aproximadamente)

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
