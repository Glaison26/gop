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

-- Copiando estrutura para tabela gop.ordens
CREATE TABLE IF NOT EXISTS `ordens` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_solicitante` int NOT NULL,
  `id_responsavel` int NOT NULL,
  `id_setor` int NOT NULL,
  `id_recurso` int DEFAULT NULL,
  `id_espaco` int DEFAULT NULL,
  `id_oficina` int NOT NULL,
  `data_entrada` date DEFAULT NULL,
  `hora_entrada` time DEFAULT NULL,
  `data_inicio` date DEFAULT NULL,
  `hora_inicio` time DEFAULT NULL,
  `data_conclucao` date DEFAULT NULL,
  `hora_conclusao` time DEFAULT NULL,
  `data_garantia` date DEFAULT NULL,
  `data_entrega` date DEFAULT NULL,
  `hora_entrega` time DEFAULT NULL,
  `data_saida` date DEFAULT NULL,
  `previsao_Horas` int DEFAULT NULL,
  `previsao_minutos` int DEFAULT NULL,
  `tipo` char(1) DEFAULT NULL COMMENT 'definice se é ordem de recurso fisico ou espaço fisico\r\n(r=recurso ou E para espaco)',
  `numero_nota` varchar(20) DEFAULT NULL,
  `conclusao` blob,
  `valor_material` double DEFAULT NULL,
  `valor_servico` double DEFAULT NULL,
  `tipo_ordem` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT 'tipo =corretiva ou preventiva valores = (c ou P)',
  `tipo_corretiva` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT 'aperan tipo ordem corretiva = normal ou urgente \r\nvalores = (n ou u)',
  `tipo_preventiva` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT 'apenas para preventiva = rotina , preditiva\r\nou sistematica valores = (r,p ou s)',
  `descritivo` varchar(50) DEFAULT NULL,
  `mau_uso` char(1) DEFAULT NULL,
  `situacao` char(1) DEFAULT NULL,
  `motivo_naoconformidade` char(1) DEFAULT NULL,
  `data_emissao` date DEFAULT NULL,
  `descricao` blob,
  `data_geracao` date DEFAULT NULL,
  `hora_geracao` time DEFAULT NULL,
  `data_previsao` date DEFAULT NULL,
  `hora_previsao` time DEFAULT NULL,
  `status` char(1) DEFAULT NULL,
  `id_solicitacao` int DEFAULT NULL,
  `id_ocorrencia` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_ordens_usuarios` (`id_solicitante`),
  KEY `FK_ordens_usuarios_2` (`id_responsavel`),
  KEY `FK_ordens_setores` (`id_setor`),
  KEY `FK_ordens_recursos` (`id_recurso`),
  KEY `FK_ordens_espacos` (`id_espaco`),
  KEY `FK_ordens_oficinas` (`id_oficina`) USING BTREE,
  CONSTRAINT `FK_ordens_oficinas` FOREIGN KEY (`id_oficina`) REFERENCES `oficinas` (`id`),
  CONSTRAINT `FK_ordens_setores` FOREIGN KEY (`id_setor`) REFERENCES `setores` (`id`),
  CONSTRAINT `FK_ordens_usuarios` FOREIGN KEY (`id_solicitante`) REFERENCES `usuarios` (`id`),
  CONSTRAINT `FK_ordens_usuarios_2` FOREIGN KEY (`id_responsavel`) REFERENCES `usuarios` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Copiando dados para a tabela gop.ordens: ~4 rows (aproximadamente)
REPLACE INTO `ordens` (`id`, `id_solicitante`, `id_responsavel`, `id_setor`, `id_recurso`, `id_espaco`, `id_oficina`, `data_entrada`, `hora_entrada`, `data_inicio`, `hora_inicio`, `data_conclucao`, `hora_conclusao`, `data_garantia`, `data_entrega`, `hora_entrega`, `data_saida`, `previsao_Horas`, `previsao_minutos`, `tipo`, `numero_nota`, `conclusao`, `valor_material`, `valor_servico`, `tipo_ordem`, `tipo_corretiva`, `tipo_preventiva`, `descritivo`, `mau_uso`, `situacao`, `motivo_naoconformidade`, `data_emissao`, `descricao`, `data_geracao`, `hora_geracao`, `data_previsao`, `hora_previsao`, `status`, `id_solicitacao`, `id_ocorrencia`) VALUES
	(24, 16, 16, 3, 1, 0, 3, '2024-09-21', '18:09:00', '2024-09-18', '08:00:00', NULL, NULL, '2024-09-22', '2024-09-22', '02:41:00', '2024-09-22', NULL, NULL, 'R', '', NULL, 185, 2469.16666666667, 'C', 'P', '', 'formatação ', NULL, 'C', '', NULL, _binary 0x466f6d617461c3a7c3a36f, '2024-09-18', '16:33:00', '2024-09-20', '17:00:00', 'A', 32, 2),
	(25, 16, 16, 3, 0, 1, 3, '2024-09-21', '18:09:00', '2024-09-18', '08:00:00', NULL, NULL, '2024-09-22', '2024-09-22', '02:41:00', '2024-09-22', NULL, NULL, 'E', '', NULL, 185, 2419.17, 'C', 'P', '', 'formatação ', NULL, 'C', '', NULL, _binary 0x746f6d61646173, '2024-09-18', '16:35:00', '2024-09-20', '17:00:00', 'A', 33, 3),
	(26, 16, 16, 3, 0, 0, 3, '2024-09-21', '18:09:00', '2024-09-18', '08:00:00', NULL, NULL, '2024-09-22', '2024-09-22', '02:41:00', '2024-09-22', NULL, NULL, 'V', '', NULL, 185, 2419.17, 'C', 'P', '', 'formatação ', NULL, 'C', '', NULL, _binary 0x43726961c3a7c3a36f20646520636f6e746120646520656d61696c20207465737465407361626172612e636f6d2e6272, '2024-09-18', '16:37:00', '2024-09-20', '17:00:00', 'A', 34, 5),
	(27, 16, 16, 3, 0, 0, 3, '2024-09-21', '18:09:00', '2024-09-18', '08:00:00', NULL, NULL, '2024-09-22', '2024-09-22', '02:41:00', '2024-09-22', NULL, NULL, 'V', '', NULL, 185, 2419.17, 'C', 'P', '', 'formatação ', NULL, 'C', '', NULL, _binary 0x43726961c3a7c3a36f20646520757375c3a172696f207061726120616365737361207061737461206461207361c3ba64650d0a0d0a4d617269612064652046c3a174696d61206d6174726963756c612030303039333933, '2024-09-18', '20:46:00', '2024-09-20', '17:00:00', 'A', 35, 7);

-- Copiando estrutura para tabela gop.preventivas
CREATE TABLE IF NOT EXISTS `preventivas` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_recurso` int DEFAULT NULL,
  `id_espaco` int DEFAULT NULL,
  `id_oficina` int DEFAULT NULL,
  `id_centrodecusto` int DEFAULT NULL,
  `id_ocorrencia` int DEFAULT NULL,
  `tipo` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'R = recurso E +espaco fisico / Edificação',
  `tipo_preventiva` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'sistema\r\npreditiva\r\nrotina',
  `data_cadastro` date NOT NULL,
  `periodicidade_geracao` int NOT NULL,
  `data_prox_realizacao` date DEFAULT NULL,
  `data_ult_realizacao` date DEFAULT NULL,
  `calibracao` char(1) DEFAULT NULL,
  `descritivo` blob,
  `gerar` char(3) DEFAULT NULL,
  KEY `id` (`id`),
  KEY `FK_preventivas_recursos` (`id_recurso`),
  KEY `FK_preventivas_espacos` (`id_espaco`),
  KEY `FK_preventivas_oficinas` (`id_oficina`),
  KEY `FK_preventivas_centrodecusto` (`id_centrodecusto`),
  KEY `FK_preventivas_ocorrencias` (`id_ocorrencia`),
  CONSTRAINT `FK_preventivas_centrodecusto` FOREIGN KEY (`id_centrodecusto`) REFERENCES `centrodecusto` (`id`),
  CONSTRAINT `FK_preventivas_espacos` FOREIGN KEY (`id_espaco`) REFERENCES `espacos` (`id`),
  CONSTRAINT `FK_preventivas_ocorrencias` FOREIGN KEY (`id_ocorrencia`) REFERENCES `ocorrencias` (`id`),
  CONSTRAINT `FK_preventivas_oficinas` FOREIGN KEY (`id_oficina`) REFERENCES `oficinas` (`id`),
  CONSTRAINT `FK_preventivas_recursos` FOREIGN KEY (`id_recurso`) REFERENCES `recursos` (`id`)
<<<<<<< HEAD
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Copiando dados para a tabela gop.preventivas: ~2 rows (aproximadamente)
INSERT INTO `preventivas` (`id`, `id_recurso`, `id_espaco`, `id_oficina`, `id_centrodecusto`, `tipo`, `tipo_preventiva`, `data_cadastro`, `periodicidade_geracao`, `data_prox_realizacao`, `data_ult_realizacao`, `calibracao`, `descritivo`) VALUES
	(1, 1, NULL, 3, 1, 'R', 'S', '2024-09-25', 30, '2024-10-25', '2024-09-25', 'N', _binary 0x7465737465),
	(2, 1, NULL, 3, 1, 'R', 'P', '2024-09-26', 45, '2024-11-10', '2024-09-26', 'N', _binary 0x746573746520636f6d20746573746520646520616c74657261c3a7c3a36f),
	(4, NULL, 2, 7, 2, 'E', 'P', '2024-09-26', 20, '2024-10-08', '2024-09-18', 'N', _binary 0x74657374652065737061c3a76f2066697369636f);
=======
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Copiando dados para a tabela gop.preventivas: ~3 rows (aproximadamente)
REPLACE INTO `preventivas` (`id`, `id_recurso`, `id_espaco`, `id_oficina`, `id_centrodecusto`, `id_ocorrencia`, `tipo`, `tipo_preventiva`, `data_cadastro`, `periodicidade_geracao`, `data_prox_realizacao`, `data_ult_realizacao`, `calibracao`, `descritivo`, `gerar`) VALUES
	(1, 1, NULL, 3, 1, NULL, 'R', 'S', '2024-09-25', 30, '2024-09-25', '2024-09-25', 'N', NULL, 'Sim'),
	(2, NULL, 2, 7, 2, NULL, 'E', 'R', '2024-09-30', 30, '2024-09-14', '2024-08-15', 'N', _binary 0x496e737065c3a7c3a36f207072656469616c, 'Sim'),
	(3, 2, NULL, 3, 1, 2, 'R', 'P', '2024-09-30', 60, '2024-10-29', '2024-08-30', 'N', _binary 0x4d616e7574656ec3a7c3a36f20646f205365727669646f72, 'Sim');
>>>>>>> 4228f6135e3e1e836208cb22d5c6eee1fa9a838b

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
