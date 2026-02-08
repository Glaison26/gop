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

-- Copiando estrutura para tabela gop.centrodecusto
CREATE TABLE IF NOT EXISTS `centrodecusto` (
  `id` int NOT NULL AUTO_INCREMENT,
  `descricao` varchar(120) NOT NULL,
  `codigo` char(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `id_espacofisico` int NOT NULL,
  `endereco` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `bairro` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `cidade` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `cep` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `fone1` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `fone2` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `email` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `responsavel` varchar(100) NOT NULL,
  `rateio` float DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Copiando dados para a tabela gop.centrodecusto: ~4 rows (aproximadamente)
INSERT INTO `centrodecusto` (`id`, `descricao`, `codigo`, `id_espacofisico`, `endereco`, `bairro`, `cidade`, `cep`, `fone1`, `fone2`, `email`, `responsavel`, `rateio`) VALUES
	(1, 'Meio Ambiente', NULL, 4, '', '', '', '', '(31)4442-3423', '(31)4423-4234', '', 'Prefeitura', 0),
	(2, 'Almoxarifado Saúde', NULL, 1, '', '', '', '', '(31)3323-4124', '(31)1223-4123', '', 'Prefeitura', 0),
	(3, 'Estacionamento de Ambulancia', NULL, 2, '', '', '', '', '(31)3434-1344', '(31)3242-1342', '', 'Manoel', 0),
	(5, 'Prefeitura', NULL, 1, '', '', '', '', '', '', '', 'Patricia', 0);

-- Copiando estrutura para tabela gop.checklist
CREATE TABLE IF NOT EXISTS `checklist` (
  `id` int NOT NULL AUTO_INCREMENT,
  `descricao` varchar(150) NOT NULL DEFAULT '0',
  `descritivo` blob,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Copiando dados para a tabela gop.checklist: ~3 rows (aproximadamente)
INSERT INTO `checklist` (`id`, `descricao`, `descritivo`) VALUES
	(1, 'Instalação de Memória SSD', _binary 0x2d2043686176652064652046656e64610d0a2d2050656e20447269766520636f6d2053697374656d61204f7065726163696f6e616c0d0a2d20446973636f2065787465726e6f2070617261206261636b7570),
	(2, 'Instalação de Ponto de Rede', _binary 0x312043686176652064652066656e64610d0a32205465737461646f72206465204361626f),
	(3, 'checklist roteador de rede', _binary 0x46657272616d656e746173);

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
  `descritivo` varchar(120) DEFAULT NULL,
  `observacao` blob,
  PRIMARY KEY (`id`),
  KEY `FK_compras_fornecedores` (`id_fornecedor`),
  KEY `FK_compras_cotacao_fornecedor` (`id_cotacao_fornecedor`),
  CONSTRAINT `FK_compras_cotacao_fornecedor` FOREIGN KEY (`id_cotacao_fornecedor`) REFERENCES `cotacao_fornecedor` (`id`),
  CONSTRAINT `FK_compras_fornecedores` FOREIGN KEY (`id_fornecedor`) REFERENCES `fornecedores` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Copiando dados para a tabela gop.compras: ~5 rows (aproximadamente)
INSERT INTO `compras` (`id`, `id_fornecedor`, `id_cotacao_fornecedor`, `data`, `tipo`, `nota`, `condicoes_pag`, `vencimento`, `comprador`, `prazo`, `valor`, `status`, `tipo_compra`, `valor_frete`, `descritivo`, `observacao`) VALUES
	(3, 2, 3, '2024-11-13', 'Avulsas Internas', '56546', 'A vista com desconto', '2024-11-29', 'Glaison', '8', 240, 'A', 'M', 45, 'Cotação Manutenção de Bomba de Infusão', _binary 0x7465737465),
	(4, 2, 4, '2024-11-13', 'Manutenção', NULL, 'A vista', NULL, 'Emilio Santiago', '15', 50, 'A', 'S', 45, 'Serviço de Pintura', NULL),
	(7, 3, 3, '2024-11-15', 'Avulsas Internas', '1234312', '60 dias', '2024-11-15', 'Emilio Santiago', '12', 165, 'C', 'M', 17.5, 'Cotação Manutenção de Bomba de Infusão', _binary ''),
	(8, 2, 4, '2024-11-15', 'Manutenção', NULL, 'A vista', NULL, 'Emilio Santiago', '30', 45, 'C', 'M', 0, 'Manutenção de Equipamento', NULL),
	(12, 1, 6, '2024-11-15', 'Manutenção', NULL, 'A Vista', NULL, 'Glaison', '10', 270, 'C', 'M', 15.5, 'Compra Operacional de Novembro', NULL),
	(13, 3, 15, '2024-12-16', 'Operacionais', NULL, 'a vista', NULL, 'Emilio Santiago', '12', 270, 'C', 'M', 15.5, 'compra Operacional', NULL);

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
  `fator_conversao` int DEFAULT NULL,
  `receber` char(1) DEFAULT NULL,
  `recebido` char(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK__materiais` (`id_material`),
  KEY `FK__unidades` (`id_unidade`),
  KEY `FK_compras_materiais_compras` (`id_compra`),
  CONSTRAINT `FK__materiais` FOREIGN KEY (`id_material`) REFERENCES `materiais` (`id`),
  CONSTRAINT `FK__unidades` FOREIGN KEY (`id_unidade`) REFERENCES `unidades` (`id`),
  CONSTRAINT `FK_compras_materiais_compras` FOREIGN KEY (`id_compra`) REFERENCES `compras` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Copiando dados para a tabela gop.compras_materiais: ~9 rows (aproximadamente)
INSERT INTO `compras_materiais` (`id`, `id_compra`, `id_material`, `id_unidade`, `quantidade`, `valor_unitario`, `valor_total`, `data_entrega`, `fator_conversao`, `receber`, `recebido`) VALUES
	(1, 7, 3, 10, 20, 3, 60, NULL, 1, 'S', 'S'),
	(2, 7, 4, 8, 30, 2.5, 75, NULL, 1, 'S', 'S'),
	(3, 7, 2, 8, 20, 1.5, 30, NULL, 1, 'S', 'S'),
	(4, 3, 4, 8, 2, 15, 30, NULL, 1, 'S', NULL),
	(5, 3, 3, 8, 2, 20, 40, NULL, 1, 'S', NULL),
	(6, 3, 2, 8, 10, 17, 170, NULL, 1, 'S', NULL),
	(8, 12, 2, 13, 3, 90, 270, NULL, 12, 'S', 'S'),
	(9, 13, 3, 10, 15, 6, 90, NULL, 1, 'S', 'S'),
	(10, 13, 4, 8, 20, 9, 180, NULL, 1, 'S', 'S');

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

-- Copiando estrutura para tabela gop.configuracoes
CREATE TABLE IF NOT EXISTS `configuracoes` (
  `id` int NOT NULL AUTO_INCREMENT,
  `empresa` varchar(200) DEFAULT NULL,
  `cnpj` varchar(18) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `responsavel` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `fone1` varchar(20) DEFAULT NULL,
  `fone2` varchar(20) DEFAULT NULL,
  `url` varchar(200) DEFAULT NULL,
  `email_manutencao` varchar(150) DEFAULT NULL,
  `emailcc_manutencao` varchar(150) DEFAULT NULL,
  `emailco_manutencao` varchar(150) DEFAULT NULL,
  `email_envio` varchar(200) DEFAULT NULL,
  `porta_smtp` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `email_host` varchar(20) DEFAULT NULL,
  `senha_email` varchar(20) DEFAULT NULL,
  `solicitacao_avulsa` char(1) DEFAULT NULL,
  `solicitacao_recursos` char(1) DEFAULT NULL,
  `solicitacao_espacos` char(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Copiando dados para a tabela gop.configuracoes: ~1 rows (aproximadamente)
INSERT INTO `configuracoes` (`id`, `empresa`, `cnpj`, `responsavel`, `fone1`, `fone2`, `url`, `email_manutencao`, `emailcc_manutencao`, `emailco_manutencao`, `email_envio`, `porta_smtp`, `email_host`, `senha_email`, `solicitacao_avulsa`, `solicitacao_recursos`, `solicitacao_espacos`) VALUES
	(1, 'Unica Engenharia', '22886816000105', 'Glaison', '(31) 3672-7688', '(31) 2121-2223', 'sabara.mg.gov.br', 'microrede2@gmail.com', 'microrede2@gmail.com', 'microrede2@gmail.com', 'glaison26.queiroz@gmail.com', '465', 'smtp.gmail.com', 'qypq xjmy xmmu uoso', 'S', 'N', 'N');

-- Copiando estrutura para tabela gop.contratos
CREATE TABLE IF NOT EXISTS `contratos` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_espacofisico` int DEFAULT NULL,
  `id_setor` int DEFAULT NULL,
  `id_centrocusto` int DEFAULT NULL,
  `empresa` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `tipo_empresa` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `vigencia` varchar(80) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `inicio_contrato` date DEFAULT NULL,
  `termino_contrato` date DEFAULT NULL,
  `numero_contrato` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `resp_contratado` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `resp_contratante` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `periodo_faturamento` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `objeto` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `email_operacional` varchar(180) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `email_diretoria` varchar(180) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `email_gerente` varchar(180) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `valor_mensal` double DEFAULT NULL,
  `dados_iniciais` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `denuncia` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `reajuste` double DEFAULT NULL,
  `tipo_prestador_servico` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `tipo_fornecedor_produtos` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `tipo_producao_mes` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `observacao` blob,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `FK_contratos_espacos` (`id_espacofisico`) USING BTREE,
  KEY `FK_contratos_setores` (`id_setor`) USING BTREE,
  KEY `FK_contratos_centrodecusto` (`id_centrocusto`) USING BTREE,
  CONSTRAINT `FK_contratos_centrodecusto` FOREIGN KEY (`id_centrocusto`) REFERENCES `centrodecusto` (`id`),
  CONSTRAINT `FK_contratos_espacos` FOREIGN KEY (`id_espacofisico`) REFERENCES `espacos` (`id`),
  CONSTRAINT `FK_contratos_setores` FOREIGN KEY (`id_setor`) REFERENCES `setores` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Copiando dados para a tabela gop.contratos: ~0 rows (aproximadamente)
INSERT INTO `contratos` (`id`, `id_espacofisico`, `id_setor`, `id_centrocusto`, `empresa`, `tipo_empresa`, `vigencia`, `inicio_contrato`, `termino_contrato`, `numero_contrato`, `resp_contratado`, `resp_contratante`, `periodo_faturamento`, `objeto`, `email_operacional`, `email_diretoria`, `email_gerente`, `valor_mensal`, `dados_iniciais`, `denuncia`, `reajuste`, `tipo_prestador_servico`, `tipo_fornecedor_produtos`, `tipo_producao_mes`, `observacao`) VALUES
	(1, 2, 3, 2, 'Copasa', 'Água e Esgoto', '1300 dias', '2025-06-13', '2025-06-30', '3342432', '', '', NULL, 'Tratamento de água e esgoto', '', '', '', 2000, 'copasa empresa', '', 5, '', '', '', _binary '');

-- Copiando estrutura para tabela gop.contratos_lancamentos
CREATE TABLE IF NOT EXISTS `contratos_lancamentos` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_parametro` int DEFAULT NULL,
  `data` date DEFAULT NULL,
  `quantidade` double DEFAULT NULL,
  `valor` double DEFAULT NULL,
  `nota` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `emissao` date DEFAULT NULL,
  `vencimento` date DEFAULT NULL,
  `cond_pagamento` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `rateio` double DEFAULT NULL,
  `unidade` varchar(80) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `FK_contratos_lancamentos_contratos_parametros` (`id_parametro`) USING BTREE,
  CONSTRAINT `FK_contratos_lancamentos_contratos_parametros` FOREIGN KEY (`id_parametro`) REFERENCES `contratos_parametros` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Copiando dados para a tabela gop.contratos_lancamentos: ~0 rows (aproximadamente)

-- Copiando estrutura para tabela gop.contratos_parametros
CREATE TABLE IF NOT EXISTS `contratos_parametros` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_contrato` int DEFAULT NULL,
  `descricao` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `unidade` varchar(80) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `FK_contratos_parametros_contratos` (`id_contrato`) USING BTREE,
  CONSTRAINT `FK_contratos_parametros_contratos` FOREIGN KEY (`id_contrato`) REFERENCES `contratos` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Copiando dados para a tabela gop.contratos_parametros: ~2 rows (aproximadamente)
INSERT INTO `contratos_parametros` (`id`, `id_contrato`, `descricao`, `unidade`) VALUES
	(1, 1, 'Consumo de Água', 'Metro Cúbico'),
	(10, 1, 'Esgoto', 'Metro Cúbico');

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
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Copiando dados para a tabela gop.cotacao: ~8 rows (aproximadamente)
INSERT INTO `cotacao` (`id`, `id_responsavel`, `descritivo`, `data`, `valor`, `status`, `data_encerramento`, `observacao`, `tipo`) VALUES
	(1, 16, 'Cotação para Material Elétrico para OS38', '2024-10-24', NULL, 'A', '2024-10-24', _binary 0x7465737465, 'M'),
	(2, 16, 'Manutenção de Equipamento', '2024-11-15', NULL, 'A', NULL, NULL, 'M'),
	(3, 16, 'Compra Operacional de Novembro', '2024-11-15', NULL, 'A', NULL, NULL, 'M'),
	(4, 16, 'Cotação Material Obra do Estacionamento', '2024-10-24', NULL, 'A', NULL, NULL, 'M'),
	(5, 16, 'Cotação Manutenção de Bomba de Infusão', '2024-10-24', NULL, 'A', NULL, NULL, 'M'),
	(7, 16, 'Serviço de Pintura', '2024-10-29', NULL, 'A', NULL, NULL, 'S'),
	(8, 16, 'Cotação Material Obra do Estacionamento', '2024-11-04', NULL, 'A', NULL, NULL, 'M'),
	(9, 16, 'Cotação para estoque Operacional', '2024-11-13', NULL, 'A', NULL, NULL, 'M'),
	(10, 16, 'compra Operacional', '2024-12-16', NULL, 'A', NULL, NULL, 'M'),
	(11, 16, 'cotação operacional', '2025-01-09', NULL, 'A', NULL, NULL, 'M');

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
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Copiando dados para a tabela gop.cotacao_fornecedor: ~13 rows (aproximadamente)
INSERT INTO `cotacao_fornecedor` (`id`, `id_cotacao`, `id_fornecedor`, `observacao`, `status`, `valor_total`, `frete`, `prazo`, `forma_pagamento`, `vendedor`) VALUES
	(1, 1, 3, _binary 0x746573746520646520696e636c7573c3a36f, 'P', 906, 45, 30, 'A vista', 'Astolfo Nunes'),
	(2, 1, 1, _binary 0x746573746532, 'C', 896, 45, 45, 'A vista', 'Danllo Alves'),
	(3, 5, 2, _binary '', 'B', 240, 45, 8, 'A vista', 'Astolfo Nunes'),
	(4, 7, 2, _binary 0x7365727669c3a76f20636f6d20676172616e746961, 'B', 50, 45, 15, 'A vista', 'Astolfo Nunes'),
	(5, 1, 2, _binary '', 'Z', 500, 45, 5, 'A vista', 'Astolfo Nunes'),
	(6, 7, 1, _binary '', 'P', 65, 20, 20, 'A vista', 'Danllo Alves'),
	(7, 5, 1, _binary 0x7465737465, 'P', 252, 90, 30, 'A vista', 'Danllo Alves'),
	(8, 8, 2, _binary '', 'C', 88.5, 25, 25, 'a vista', 'Umberto Ramos'),
	(9, 8, 1, _binary '', 'Z', 180, 16, 22, 'a vista', 'Maria Aparecida'),
	(10, 8, 3, _binary '', 'P', 132, 17, 23, 'a vista', 'Rafaela dos Santos'),
	(11, 9, 2, _binary '', 'Z', 480, 15, 10, 'a vista', 'Umberto Ramos'),
	(12, 9, 1, _binary '', 'C', 415, 17, 12, 'a vista', 'Astolfo Nunes'),
	(13, 9, 3, _binary '', 'P', 540, 17.5, 13, 'A vista', 'Danllo Alves'),
	(14, 10, 2, _binary '', 'Z', 275, 17.5, 10, 'A vista', 'Pedro Neves'),
	(15, 10, 3, _binary '', 'C', 270, 15.5, 12, 'a vista', 'Astolfo Nunes'),
	(16, 11, 2, _binary '', 'P', 75, 15.5, 15, 'a vista', 'Alfredo');

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
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Copiando dados para a tabela gop.cotacao_materiais: ~12 rows (aproximadamente)
INSERT INTO `cotacao_materiais` (`id`, `id_cotacao`, `id_material`, `id_unidade`, `quantidade`) VALUES
	(1, 1, 3, 10, 20),
	(2, 1, 4, 8, 30),
	(3, 1, 2, 8, 20),
	(4, 2, 3, 10, 3),
	(5, 5, 4, 8, 2),
	(6, 5, 3, 8, 2),
	(7, 5, 2, 8, 10),
	(8, 1, 3, 10, 10),
	(9, 1, 4, 8, 2),
	(10, 1, 2, 8, 12),
	(11, 10, 3, 10, 15),
	(12, 10, 4, 8, 20),
	(13, 11, 3, 10, 5);

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
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Copiando dados para a tabela gop.cotacao_materiais_fornecedor: ~16 rows (aproximadamente)
INSERT INTO `cotacao_materiais_fornecedor` (`id`, `id_material`, `id_fornecedor`, `id_cotacao_fornecedor`, `id_unidade`, `valor_unitario`, `prazo_entrega`, `valor_total`, `quantidade`) VALUES
	(1, 4, 2, 3, 8, 15, NULL, 30, 2),
	(2, 3, 2, 3, 8, 20, NULL, 40, 2),
	(3, 2, 2, 3, 8, 17, NULL, 170, 10),
	(4, 4, 1, 7, 8, 14, NULL, 28, 2),
	(5, 3, 1, 7, 8, 17, NULL, 34, 2),
	(6, 2, 1, 7, 8, 19, NULL, 190, 10),
	(7, 3, 2, 5, 10, NULL, NULL, NULL, 10),
	(8, 4, 2, 5, 8, NULL, NULL, NULL, 2),
	(9, 2, 2, 5, 8, NULL, NULL, NULL, 12),
	(10, 2, 3, 3, 8, 1.5, NULL, 30, 20),
	(11, 3, 2, 4, 10, 15, NULL, 45, 3),
	(12, 3, 3, 5, 10, 20, NULL, 60, 3),
	(13, 2, 1, 6, 13, 90, NULL, 270, 3),
	(14, 3, 2, 14, 10, 5, NULL, 75, 15),
	(15, 4, 2, 14, 8, 10, NULL, 200, 20),
	(16, 3, 3, 15, 10, 6, NULL, 90, 15),
	(17, 4, 3, 15, 8, 9, NULL, 180, 20),
	(18, 3, 2, 16, 10, 15, NULL, 75, 5);

-- Copiando estrutura para tabela gop.cotacao_servicos
CREATE TABLE IF NOT EXISTS `cotacao_servicos` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_cotacao` int DEFAULT NULL,
  `descricao` blob,
  PRIMARY KEY (`id`),
  KEY `FK_cotacao_servicos_cotacao` (`id_cotacao`),
  CONSTRAINT `FK_cotacao_servicos_cotacao` FOREIGN KEY (`id_cotacao`) REFERENCES `cotacao` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Copiando dados para a tabela gop.cotacao_servicos: ~0 rows (aproximadamente)
INSERT INTO `cotacao_servicos` (`id`, `id_cotacao`, `descricao`) VALUES
	(1, 10, _binary 0x5365727669c3a76f2064652050696e74757261),
	(3, 7, _binary 0x5365727669c3a76f206465204d616e7574656ec3a7c3a36f20646520496d70726573736f726173);

-- Copiando estrutura para tabela gop.cotacao_servicos_fornecedores
CREATE TABLE IF NOT EXISTS `cotacao_servicos_fornecedores` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_servico` int DEFAULT NULL,
  `id_fornecedor` int DEFAULT NULL,
  `id_cotacao_fornecedor` int DEFAULT NULL,
  `valor` double DEFAULT NULL,
  `quantidade` int DEFAULT NULL,
  `prazo_entrega` date DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_cotacao_servicos_fornecedores_fornecedores` (`id_fornecedor`),
  KEY `FK_cotacao_servicos_fornecedores_cotacao_servicos_2` (`id_servico`),
  KEY `FK_cotacao_servicos_fornecedores_cotacao_fornecedor` (`id_cotacao_fornecedor`),
  CONSTRAINT `FK_cotacao_servicos_fornecedores_cotacao_fornecedor` FOREIGN KEY (`id_cotacao_fornecedor`) REFERENCES `cotacao_fornecedor` (`id`),
  CONSTRAINT `FK_cotacao_servicos_fornecedores_cotacao_servicos_2` FOREIGN KEY (`id_servico`) REFERENCES `cotacao_servicos` (`id`),
  CONSTRAINT `FK_cotacao_servicos_fornecedores_fornecedores` FOREIGN KEY (`id_fornecedor`) REFERENCES `fornecedores` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Copiando dados para a tabela gop.cotacao_servicos_fornecedores: ~2 rows (aproximadamente)
INSERT INTO `cotacao_servicos_fornecedores` (`id`, `id_servico`, `id_fornecedor`, `id_cotacao_fornecedor`, `valor`, `quantidade`, `prazo_entrega`) VALUES
	(2, 3, 2, 4, 50, 1, '2024-10-31'),
	(3, 3, 1, 6, 65, NULL, '2024-11-07');

-- Copiando estrutura para tabela gop.diretrizes
CREATE TABLE IF NOT EXISTS `diretrizes` (
  `id` int NOT NULL AUTO_INCREMENT,
  `descricao` varchar(150) NOT NULL DEFAULT '',
  `texto` blob,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Copiando dados para a tabela gop.diretrizes: ~3 rows (aproximadamente)
INSERT INTO `diretrizes` (`id`, `descricao`, `texto`) VALUES
	(2, 'OPERACIONAL DE SERVIÇOS E OBRAS', _binary 0x506c616e656a616d656e746f204f7065726163696f6e616c206465205365727669c3a76f732065206f62726173),
	(4, 'Aquisição de Novos Servidores', _binary 0x417175697369c3a7c3a36f206465206e6f766f73207365727669646f726573207061726120736572656d0a7574696c697a61646f73206e6f202061726d617a656e616d656e746f206465206172717569766f732064612072656465),
	(5, 'Instalação de novos servidores', _binary 0x506c616e656a616d656e746f207061726120496e7374616c61c3a7c3a36f2064650a206e6f766f73207365727669646f726573);

-- Copiando estrutura para tabela gop.diretriz_estrategia
CREATE TABLE IF NOT EXISTS `diretriz_estrategia` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_estrategia` int DEFAULT NULL,
  `id_diretriz` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK__estrategias` (`id_estrategia`),
  KEY `FK__diretrizes` (`id_diretriz`),
  CONSTRAINT `FK__diretrizes` FOREIGN KEY (`id_diretriz`) REFERENCES `diretrizes` (`id`),
  CONSTRAINT `FK__estrategias` FOREIGN KEY (`id_estrategia`) REFERENCES `estrategias` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Copiando dados para a tabela gop.diretriz_estrategia: ~4 rows (aproximadamente)
INSERT INTO `diretriz_estrategia` (`id`, `id_estrategia`, `id_diretriz`) VALUES
	(1, 1, 2),
	(2, 2, 4),
	(5, 1, 4),
	(6, 1, 5);

-- Copiando estrutura para tabela gop.enderecos
CREATE TABLE IF NOT EXISTS `enderecos` (
  `id` int NOT NULL AUTO_INCREMENT,
  `logradouro` varchar(220) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `numero` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `usuario_id` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Copiando dados para a tabela gop.enderecos: ~15 rows (aproximadamente)
INSERT INTO `enderecos` (`id`, `logradouro`, `numero`, `usuario_id`) VALUES
	(1, 'Avenida Winston Churchill', '936', 1),
	(2, 'Avenida Winston Churchill', '936', 2),
	(3, 'Avenida Winston Churchill', '936', 3),
	(4, 'Avenida Winston Churchill', '936', 4),
	(5, 'Avenida Winston Churchill', '936', 5),
	(6, 'Avenida Winston Churchill', '936', 6),
	(7, 'Avenida Winston Churchill', '936', 7),
	(8, 'Avenida Winston Churchill', '936', 8),
	(9, 'Avenida Winston Churchill', '936', 9),
	(10, 'Avenida Winston Churchill', '936', 10),
	(11, 'Avenida Winston Churchill', '936', 11),
	(12, 'Avenida Winston Churchill', '936', 12),
	(13, 'Avenida Winston Churchill', '936', 13),
	(14, 'Avenida Winston Churchill', '936', 14),
	(15, 'Avenida Winston Churchill', '936', 15);

-- Copiando estrutura para tabela gop.espacos
CREATE TABLE IF NOT EXISTS `espacos` (
  `id` int NOT NULL AUTO_INCREMENT,
  `descricao` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `tipo` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `medida` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `endereco` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `bairro` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `cidade` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `cep` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `responsavel` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `email` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `fone1` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `fone2` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Copiando dados para a tabela gop.espacos: ~5 rows (aproximadamente)
INSERT INTO `espacos` (`id`, `descricao`, `tipo`, `medida`, `endereco`, `bairro`, `cidade`, `cep`, `responsavel`, `email`, `fone1`, `fone2`) VALUES
	(1, 'Meio Ambiente', 'Instalação', '30', 'Rua da Itendencia 316', 'Centro', 'Sabará', '34505480', 'Prefeitura', 'teste@gmail.com', '', ''),
	(2, 'Prédio Saúde', 'Edificação', '0', '0', '0', '0', '0', 'Prefeitura', '0', '(31)9855-5555', '(31)5555-8888'),
	(5, 'Predio da Fazenda segundo andar', 'Instalação', '', 'Rua da Intendência', 'Centro', 'Sabará', '34505-480', 'Sonia Almeida', 'glaison26.queiroz@gmail.com', '(31) 3672-7688', ''),
	(7, 'Prefeitura', 'Instalação', '', 'Rua da Intendência', 'Centro', 'Sabará', '34505-480', 'Patricia', 'glaison26.queiroz@gmail.com', '(31) 3672-7688', ''),
	(8, 'Prédio Sede da Prefeitura', 'Edificação', '', 'Rua Marques de Sapucaí 200', 'Centro', 'Sabará', '34505480', 'Prefeitura Municipal de Sabará', 'comunicacao@sabara.mg.gov.br', '(31) 3672-7720', '');

-- Copiando estrutura para tabela gop.estrategias
CREATE TABLE IF NOT EXISTS `estrategias` (
  `id` int NOT NULL AUTO_INCREMENT,
  `descricao` varchar(150) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Copiando dados para a tabela gop.estrategias: ~2 rows (aproximadamente)
INSERT INTO `estrategias` (`id`, `descricao`) VALUES
	(1, 'Estrategia I'),
	(2, 'Estratégia II');

-- Copiando estrutura para tabela gop.executores
CREATE TABLE IF NOT EXISTS `executores` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_oficina` int DEFAULT NULL,
  `id_funcao` int DEFAULT NULL,
  `nome` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `endereco` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `bairro` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `cep` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `cidade` varchar(90) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `uf` char(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `contato` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `tipo` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT '',
  `cpf_cnpj` varchar(18) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `email` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `url` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `fone1` varchar(20) DEFAULT NULL,
  `fone2` varchar(20) DEFAULT NULL,
  `fone3` varchar(20) DEFAULT NULL,
  `salario` double DEFAULT NULL,
  `horastrab` int DEFAULT NULL,
  `valorhora` double DEFAULT '0',
  `escolaridade` varchar(50) DEFAULT '0.00',
  `formacao` varchar(90) DEFAULT NULL,
  `obs` blob,
  PRIMARY KEY (`id`),
  KEY `FK_executores_oficinas` (`id_oficina`),
  KEY `FK_executores_funcoes` (`id_funcao`),
  CONSTRAINT `FK_executores_funcoes` FOREIGN KEY (`id_funcao`) REFERENCES `funcoes` (`id`),
  CONSTRAINT `FK_executores_oficinas` FOREIGN KEY (`id_oficina`) REFERENCES `oficinas` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Copiando dados para a tabela gop.executores: ~4 rows (aproximadamente)
INSERT INTO `executores` (`id`, `id_oficina`, `id_funcao`, `nome`, `endereco`, `bairro`, `cep`, `cidade`, `uf`, `contato`, `tipo`, `cpf_cnpj`, `email`, `url`, `fone1`, `fone2`, `fone3`, `salario`, `horastrab`, `valorhora`, `escolaridade`, `formacao`, `obs`) VALUES
	(5, 7, 5, 'Glaison Queiroz', 'Rua da Itendencia 316', 'Centro', '34.505-480', 'Sabará', 'AC', 'Shay lin', 'F', '695.510.226-53', 'glaison26.queiroz@gmail.com', '', '(31)3672-7688', '', '', 0, 0, 150.9, 'Primário', '', _binary 0x7465737465),
	(6, 7, 5, 'Maria da Silva', 'Rua da Itendencia 316', 'Centro', '34.505-480', 'Sabará', 'MG', 'Antonio Dias', 'F', '695.510.226-53', 'glaison26.queiroz@gmail.com', '', '(31) 3672-7720', '', '', 0, 0, 0, 'Primário', '', _binary ''),
	(7, 3, 5, 'Juliana Almeida', 'Rua da Intendência', 'Centro', '34505-480', 'Sabará', 'AC', 'Juliana', 'F', '695.510.226-53', 'glaison26.queiroz@gmail.com', '', '(31) 3672-7688', '', '', 0, 0, 0, 'Primário', '', _binary ''),
	(10, 7, 5, 'Wanderlei', 'Rua da Intendência', 'Centro', '34505-480', 'Sabará', 'MG', '', 'F', '695.510.226-53', 'glaison26.queiroz@gmail.com', '', '(31) 3672-7688', '', '', 0, 0, 100, 'Primário', '', _binary '');

-- Copiando estrutura para tabela gop.fabricantes
CREATE TABLE IF NOT EXISTS `fabricantes` (
  `id` int NOT NULL AUTO_INCREMENT,
  `descricao` varchar(120) DEFAULT NULL,
  `razaosocial` varchar(120) DEFAULT NULL,
  `tipo` varchar(20) DEFAULT NULL,
  `cep` varchar(11) NOT NULL,
  `endereco` varchar(120) NOT NULL,
  `bairro` varchar(120) NOT NULL,
  `cidade` varchar(120) NOT NULL,
  `estado` varchar(2) NOT NULL,
  `cnpj_cpf` varchar(18) DEFAULT NULL,
  `insc_estad` varchar(16) NOT NULL,
  `insc_munic` varchar(16) NOT NULL,
  `fone1` varchar(20) NOT NULL,
  `fone2` varchar(20) NOT NULL,
  `contato` varchar(100) DEFAULT NULL,
  `email` varchar(120) NOT NULL,
  `url` varchar(120) NOT NULL,
  `obs` blob NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Copiando dados para a tabela gop.fabricantes: ~3 rows (aproximadamente)
INSERT INTO `fabricantes` (`id`, `descricao`, `razaosocial`, `tipo`, `cep`, `endereco`, `bairro`, `cidade`, `estado`, `cnpj_cpf`, `insc_estad`, `insc_munic`, `fone1`, `fone2`, `contato`, `email`, `url`, `obs`) VALUES
	(2, 'Epson', 'Epson Ltda', 'Juridica', '', '', '', '', 'MG', '01.846.742/0001-03', '', '', '(23)4143-2412', '(31)5555-8888', 'Shay lin', '', '', _binary 0x7465737465),
	(3, 'Samsung', 'Samsung do Brasil', 'Juridica', '', '', '', '', 'SP', '01.846.742/0001-03', '', '', '(11)4654-6546', '(11)4565-8789', 'Antonio Dias', '', '', _binary ''),
	(5, 'Intelbras', 'Intelbras SA', 'Juridica', '34505-480', '', 'Centro', 'Sabará', 'AC', '23.451.301/0001-37', '', '', '(31) 3672-7688', '', 'Glaison', 'glaison26.queiroz@gmail.com', '', _binary '');

-- Copiando estrutura para tabela gop.ferramentas
CREATE TABLE IF NOT EXISTS `ferramentas` (
  `id` int NOT NULL AUTO_INCREMENT,
  `descricao` varchar(120) NOT NULL,
  `patrimonio` varchar(15) DEFAULT NULL,
  `serie` varchar(15) DEFAULT NULL,
  `id_fabricante` int DEFAULT NULL,
  `id_fornecedor` int DEFAULT NULL,
  `notafiscal` varchar(15) DEFAULT NULL,
  `data_aquisicao` date DEFAULT NULL,
  `valor_aquisicao` float DEFAULT '0',
  `data_garantia` date DEFAULT NULL,
  `id_marca` int DEFAULT NULL,
  `id_oficina` int DEFAULT NULL,
  `conservacao` varchar(15) DEFAULT NULL,
  `obs` blob,
  PRIMARY KEY (`id`),
  KEY `FK_ferramentas_fabricantes` (`id_fabricante`),
  KEY `FK_ferramentas_fornecedores` (`id_fornecedor`),
  KEY `FK_ferramentas_marcas` (`id_marca`),
  KEY `FK_ferramentas_oficinas` (`id_oficina`),
  CONSTRAINT `FK_ferramentas_fabricantes` FOREIGN KEY (`id_fabricante`) REFERENCES `fabricantes` (`id`),
  CONSTRAINT `FK_ferramentas_fornecedores` FOREIGN KEY (`id_fornecedor`) REFERENCES `fornecedores` (`id`),
  CONSTRAINT `FK_ferramentas_marcas` FOREIGN KEY (`id_marca`) REFERENCES `marcas` (`id`),
  CONSTRAINT `FK_ferramentas_oficinas` FOREIGN KEY (`id_oficina`) REFERENCES `oficinas` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Copiando dados para a tabela gop.ferramentas: ~4 rows (aproximadamente)
INSERT INTO `ferramentas` (`id`, `descricao`, `patrimonio`, `serie`, `id_fabricante`, `id_fornecedor`, `notafiscal`, `data_aquisicao`, `valor_aquisicao`, `data_garantia`, `id_marca`, `id_oficina`, `conservacao`, `obs`) VALUES
	(1, 'Martelo', '3434', '3434', 2, 1, '3423', '2023-01-18', 0, '2023-01-18', 8, 3, 'Bom', _binary 0x7465737465),
	(5, 'Serra de Madeira', '9000', '452345', 3, 2, '', '2023-01-21', 0, '2023-01-21', 6, 1, 'Ótimo', _binary ''),
	(6, 'Multimetro', '312222', '2334445', 3, 1, '93993', '2023-01-20', 900, '2024-01-20', 6, 2, 'Ótimo', _binary 0x7465737465),
	(14, 'Chave de Pressão', '4565465', '5465465', 3, 3, '4546546', '2024-10-02', 0, '2024-10-02', 6, 7, 'Ótimo', _binary '');

-- Copiando estrutura para tabela gop.fornecedores
CREATE TABLE IF NOT EXISTS `fornecedores` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_grupo` int NOT NULL DEFAULT '0',
  `descricao` varchar(120) NOT NULL DEFAULT '0',
  `razaosocial` varchar(120) NOT NULL DEFAULT '0',
  `cnpj_cpf` varchar(18) NOT NULL DEFAULT '0',
  `insc_estad` varchar(16) DEFAULT '0',
  `insc_munic` varchar(16) DEFAULT '0',
  `tipo` varchar(20) NOT NULL DEFAULT '0',
  `endereco` varchar(100) DEFAULT '0',
  `bairro` varchar(100) DEFAULT '0',
  `cep` varchar(11) DEFAULT '0',
  `cidade` varchar(100) DEFAULT '0',
  `estado` varchar(2) DEFAULT '0',
  `fone1` varchar(20) DEFAULT '0',
  `fone2` varchar(20) DEFAULT '0',
  `email` varchar(120) DEFAULT '0',
  `site` varchar(120) DEFAULT '0',
  `contato` varchar(100) DEFAULT '0',
  `obs` blob,
  PRIMARY KEY (`id`),
  KEY `FK__grupos` (`id_grupo`),
  CONSTRAINT `FK__grupos` FOREIGN KEY (`id_grupo`) REFERENCES `grupos` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Copiando dados para a tabela gop.fornecedores: ~3 rows (aproximadamente)
INSERT INTO `fornecedores` (`id`, `id_grupo`, `descricao`, `razaosocial`, `cnpj_cpf`, `insc_estad`, `insc_munic`, `tipo`, `endereco`, `bairro`, `cep`, `cidade`, `estado`, `fone1`, `fone2`, `email`, `site`, `contato`, `obs`) VALUES
	(1, 3, 'Simpress', 'Simpress do Brasil Ltda', '01.846.742/0001-03', '', '', 'Juridica', '', '', '', '', 'MG', '(31)3334-4444', '(31)2444-4444', '', '', 'Antonio Dias da Silva', _binary ''),
	(2, 1, 'Comercial Santo Antônio', 'Método Informática SA', '22.998.344/0001-99', '543245234', '5342524323', 'Juridica', 'Rua da Intendência', '', '34505-480', 'Sabará', 'MG', '(31)3454-3333', '(31)2453-3332', 'glaison26.queiroz@gmail.com', '', 'Guilherme', _binary 0x7465737465),
	(3, 7, 'Vilafort', 'vilafort sa.', '23.451.301/0001-37', '', '', 'Juridica', 'Rua da Intendência', 'Centro', '34505-480', 'Sabará', 'MG', '(31) 3672-7688', '', 'glaison26.queiroz@gmail.com', '', 'José', _binary '');

-- Copiando estrutura para tabela gop.funcoes
CREATE TABLE IF NOT EXISTS `funcoes` (
  `id` int NOT NULL AUTO_INCREMENT,
  `descricao` varchar(120) NOT NULL,
  `ValorHora` double DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Copiando dados para a tabela gop.funcoes: ~7 rows (aproximadamente)
INSERT INTO `funcoes` (`id`, `descricao`, `ValorHora`) VALUES
	(1, 'Técnico em Manutenção', 150),
	(2, 'Coordenador de Sistemas', 16.4),
	(4, 'Programador', 0),
	(5, 'Analista de Sistemas', 200),
	(6, 'Eletricista', 200),
	(7, 'Encanador', 90),
	(9, 'Operador de Máquinas', 100);

-- Copiando estrutura para tabela gop.grupos
CREATE TABLE IF NOT EXISTS `grupos` (
  `id` int NOT NULL AUTO_INCREMENT,
  `descricao` varchar(120) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Copiando dados para a tabela gop.grupos: ~8 rows (aproximadamente)
INSERT INTO `grupos` (`id`, `descricao`) VALUES
	(1, 'Computadores Desktop'),
	(2, 'NoteBooks'),
	(3, 'Impressoras'),
	(4, 'Equipamento de rede'),
	(7, 'Câmeras de Vigilancia'),
	(9, 'Equipamentos Médicos'),
	(10, 'Insumo');

-- Copiando estrutura para tabela gop.grupos_fornecedores
CREATE TABLE IF NOT EXISTS `grupos_fornecedores` (
  `id` int NOT NULL AUTO_INCREMENT,
  `descricao` varchar(180) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Copiando dados para a tabela gop.grupos_fornecedores: ~0 rows (aproximadamente)
INSERT INTO `grupos_fornecedores` (`id`, `descricao`) VALUES
	(1, 'Equipamentos Médicos');

-- Copiando estrutura para tabela gop.marcas
CREATE TABLE IF NOT EXISTS `marcas` (
  `id` int NOT NULL AUTO_INCREMENT,
  `descricao` varchar(120) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=100 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Copiando dados para a tabela gop.marcas: ~10 rows (aproximadamente)
INSERT INTO `marcas` (`id`, `descricao`) VALUES
	(1, 'Dell'),
	(2, 'samsung'),
	(4, 'Le Novo'),
	(5, 'Positivo'),
	(6, 'Acer'),
	(8, 'Epson'),
	(16, 'Intelbras'),
	(18, 'General Eletric'),
	(98, 'EngelBras');

-- Copiando estrutura para tabela gop.materiais
CREATE TABLE IF NOT EXISTS `materiais` (
  `id` int NOT NULL AUTO_INCREMENT,
  `descricao` varchar(150) NOT NULL,
  `id_grupo` int NOT NULL,
  `id_marca` int NOT NULL,
  `custo` double NOT NULL DEFAULT '0',
  `qtdmin` double NOT NULL DEFAULT '0',
  `qtdmax` double NOT NULL DEFAULT '0',
  `id_unidadeEntrada` int NOT NULL DEFAULT '0',
  `id_unidadeSaida` int NOT NULL DEFAULT '0',
  `fator` double NOT NULL DEFAULT '0',
  `ultimasaida` date NOT NULL,
  `ultimaentrada` date NOT NULL,
  `data_validade` date NOT NULL,
  `quantidadeatual` double NOT NULL DEFAULT '0',
  `obs` blob NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_materiais_grupos` (`id_grupo`),
  KEY `FK_materiais_marcas` (`id_marca`),
  KEY `FK_materiais_unidades` (`id_unidadeEntrada`),
  KEY `FK_materiais_unidades_2` (`id_unidadeSaida`),
  CONSTRAINT `FK_materiais_grupos` FOREIGN KEY (`id_grupo`) REFERENCES `grupos` (`id`),
  CONSTRAINT `FK_materiais_marcas` FOREIGN KEY (`id_marca`) REFERENCES `marcas` (`id`),
  CONSTRAINT `FK_materiais_unidades` FOREIGN KEY (`id_unidadeEntrada`) REFERENCES `unidades` (`id`),
  CONSTRAINT `FK_materiais_unidades_2` FOREIGN KEY (`id_unidadeSaida`) REFERENCES `unidades` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Copiando dados para a tabela gop.materiais: ~3 rows (aproximadamente)
INSERT INTO `materiais` (`id`, `descricao`, `id_grupo`, `id_marca`, `custo`, `qtdmin`, `qtdmax`, `id_unidadeEntrada`, `id_unidadeSaida`, `fator`, `ultimasaida`, `ultimaentrada`, `data_validade`, `quantidadeatual`, `obs`) VALUES
	(2, 'Parafusos Sextavados', 10, 6, 12.85, 0, 0, 8, 8, 1, '2023-01-26', '2023-01-26', '2023-01-26', 50, _binary 0x202020),
	(3, 'Cabos de rede', 4, 4, 4.5, 0, 0, 8, 1, 1, '2023-01-26', '2024-12-16', '2023-01-26', 27, _binary 0x74657374652020),
	(4, 'Fita Isolante', 10, 6, 3.5, 0, 0, 8, 8, 1, '2024-10-02', '2024-12-16', '2029-06-22', 28, _binary 0x20202020);

-- Copiando estrutura para tabela gop.obra
CREATE TABLE IF NOT EXISTS `obra` (
  `id` int NOT NULL AUTO_INCREMENT,
  `descricao` varchar(200) DEFAULT NULL,
  `observacao` blob,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Copiando dados para a tabela gop.obra: ~4 rows (aproximadamente)
INSERT INTO `obra` (`id`, `descricao`, `observacao`) VALUES
	(1, 'Vestiários do Bloco Cirúrgico', _binary 0x5265737461757261c3a7c3a36f20646f205665737469c3a172696f206d617363756c696e6f20652046656d696e696e6f),
	(2, 'Reforma do Centro Obstétrico', NULL),
	(3, 'Medição de Obra Laboratório Medição Geral', _binary 0x5365727669c3a76f206465206d656469c3a7c3a36f),
	(5, 'Restauração de Fachada UPA', _binary 0x72657374617261c3a7c3a36f206465206661636861646120636f6d207265637572736f73207072c3b37072696f730a646f20686f73706974616c);

-- Copiando estrutura para tabela gop.obras_grupo
CREATE TABLE IF NOT EXISTS `obras_grupo` (
  `id` int NOT NULL AUTO_INCREMENT,
  `descricao` varchar(150) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Copiando dados para a tabela gop.obras_grupo: ~6 rows (aproximadamente)
INSERT INTO `obras_grupo` (`id`, `descricao`) VALUES
	(1, 'Projetos Técnicos'),
	(2, 'Sondagens'),
	(3, 'Instalação de Canteiro de Obras'),
	(4, 'Limpeza de Terreno'),
	(5, 'Locação de Obra'),
	(6, 'Aterro e Compactação'),
	(8, 'grupo teste');

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
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Copiando dados para a tabela gop.obras_insumos: ~3 rows (aproximadamente)
INSERT INTO `obras_insumos` (`id`, `id_item`, `id_obra`, `id_unidade`, `quantidade`, `valor_maodeobra`, `valor_material`) VALUES
	(1, 1, 3, 8, 1, 1000, 2000),
	(2, 2, 5, 8, 1, 300, 450),
	(3, 3, 5, 8, 1, 180, 190),
	(6, 2, 2, 14, 1, 600, 900);

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

-- Copiando estrutura para tabela gop.ocorrencias
CREATE TABLE IF NOT EXISTS `ocorrencias` (
  `id` int NOT NULL AUTO_INCREMENT,
  `descricao` varchar(150) DEFAULT NULL,
  `texto` blob,
  `texto_fechamento` blob,
  `tempo_hora` int DEFAULT NULL,
  `tempo_minuto` int DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Copiando dados para a tabela gop.ocorrencias: ~9 rows (aproximadamente)
INSERT INTO `ocorrencias` (`id`, `descricao`, `texto`, `texto_fechamento`, `tempo_hora`, `tempo_minuto`) VALUES
	(1, 'Manutenção de Impressoras', _binary 0x4e6f2e20646f2053454c420a50726f626c656d61203a, NULL, NULL, NULL),
	(2, 'Manutenção PC', _binary 0x50616472696d6f6e696f3a0a446573637269c3a7c3a36f20646f2070726f626c656d610a, _binary 0x4f627365727661c3a7c3b56573203a, 48, 0),
	(3, 'Manutenção Elétrica', _binary 0x446573637269c3a7c3a36f203a, _binary '', NULL, NULL),
	(5, 'Criação de conta de email', _binary 0x446573637269c3a7c3a36f20646f20456d61696c3a0a, _binary 0x652d6d61696c2063726961646f203a0a53656e686120696e696369616c203b, 0, 15),
	(6, 'Telefonia', _binary 0x4ec3ba6d65726f20646f2074656c65666f6e650a52616d616c, _binary 0x436f6e636c7573c3a36f203a, 1, 0),
	(7, 'Criação de Usuários de Rede', _binary 0x4e6f6d6520646f20757375c3a172696f3a0a50617374612064652061636573736f3a, NULL, NULL, NULL),
	(8, 'Manutenção Eletrônica', NULL, NULL, NULL, NULL),
	(10, 'Criação de Usuário Moderna', _binary 0x4e6f6d6520436f6d706c65746f203a0a4dc3b364756c6f73203a0a4350463a, _binary 0x557375c3a172696f2041636573736f203b0a73656e68612041636573736f203b0a0a557375c3a172696f20646f73206dc3b364756c6f733b0a53656e686120646f73206dc3b364756c6f73203a, 1, 0),
	(14, 'Calibração', _binary '', _binary '', 1, 0);

-- Copiando estrutura para tabela gop.oficinas
CREATE TABLE IF NOT EXISTS `oficinas` (
  `id` int NOT NULL AUTO_INCREMENT,
  `descricao` varchar(120) NOT NULL DEFAULT '0',
  `fone1` varchar(25) DEFAULT NULL,
  `fone2` varchar(25) DEFAULT NULL,
  `email` varchar(150) DEFAULT NULL,
  `responsavel` varchar(120) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Copiando dados para a tabela gop.oficinas: ~7 rows (aproximadamente)
INSERT INTO `oficinas` (`id`, `descricao`, `fone1`, `fone2`, `email`, `responsavel`) VALUES
	(1, 'Elétrica', '(31) 3672-7688', '(31) 9988-3883', 'eletrica@gmail.com', 'Israel'),
	(2, 'Eletrônica', '(31) 3672-7688', '(31) 9984-2655', 'glaison26.queiroz@gmail.com', 'Glaison'),
	(3, 'Informática', '(31) 3672-7688', '(31) 3672-7642', 'suporte@sabara.mg.gov.br', 'Glaison Queiroz'),
	(6, 'Marcenaria 1', '', '', '', ''),
	(7, 'Alvenaria', NULL, NULL, NULL, NULL),
	(8, 'Equipamentos Médicos', NULL, NULL, NULL, NULL),
	(21, 'Hidráulico', '(31) 3672-7688', '(31) 9984-2655', 'Welligton Jardins', 'suporte@sabara.mg.gov.br');

-- Copiando estrutura para tabela gop.ordens
CREATE TABLE IF NOT EXISTS `ordens` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_solicitante` int NOT NULL,
  `id_responsavel` int NOT NULL,
  `id_setor` int NOT NULL,
  `id_recurso` int DEFAULT NULL,
  `id_espaco` int DEFAULT NULL,
  `id_oficina` int NOT NULL,
  `id_executor_responsavel` int DEFAULT NULL,
  `data_entrada` date DEFAULT NULL,
  `hora_entrada` time DEFAULT NULL,
  `data_inicio` date DEFAULT NULL,
  `hora_inicio` time DEFAULT NULL,
  `data_conclusao` date DEFAULT NULL,
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
  `data_cancelamento` date DEFAULT NULL,
  `hora_cancelamento` time DEFAULT NULL,
  `id_resp_cancelamento` int DEFAULT NULL,
  `motivo_cancelamento` blob,
  PRIMARY KEY (`id`),
  KEY `FK_ordens_usuarios` (`id_solicitante`),
  KEY `FK_ordens_usuarios_2` (`id_responsavel`),
  KEY `FK_ordens_setores` (`id_setor`),
  KEY `FK_ordens_recursos` (`id_recurso`),
  KEY `FK_ordens_espacos` (`id_espaco`),
  KEY `FK_ordens_oficinas` (`id_oficina`) USING BTREE,
  KEY `FK_ordens_executores` (`id_executor_responsavel`),
  CONSTRAINT `FK_ordens_executores` FOREIGN KEY (`id_executor_responsavel`) REFERENCES `executores` (`id`),
  CONSTRAINT `FK_ordens_oficinas` FOREIGN KEY (`id_oficina`) REFERENCES `oficinas` (`id`),
  CONSTRAINT `FK_ordens_setores` FOREIGN KEY (`id_setor`) REFERENCES `setores` (`id`),
  CONSTRAINT `FK_ordens_usuarios` FOREIGN KEY (`id_solicitante`) REFERENCES `usuarios` (`id`),
  CONSTRAINT `FK_ordens_usuarios_2` FOREIGN KEY (`id_responsavel`) REFERENCES `usuarios` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=152 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Copiando dados para a tabela gop.ordens: ~111 rows (aproximadamente)
INSERT INTO `ordens` (`id`, `id_solicitante`, `id_responsavel`, `id_setor`, `id_recurso`, `id_espaco`, `id_oficina`, `id_executor_responsavel`, `data_entrada`, `hora_entrada`, `data_inicio`, `hora_inicio`, `data_conclusao`, `hora_conclusao`, `data_garantia`, `data_entrega`, `hora_entrega`, `data_saida`, `previsao_Horas`, `previsao_minutos`, `tipo`, `numero_nota`, `conclusao`, `valor_material`, `valor_servico`, `tipo_ordem`, `tipo_corretiva`, `tipo_preventiva`, `descritivo`, `mau_uso`, `situacao`, `motivo_naoconformidade`, `data_emissao`, `descricao`, `data_geracao`, `hora_geracao`, `data_previsao`, `hora_previsao`, `status`, `id_solicitacao`, `id_ocorrencia`, `data_cancelamento`, `hora_cancelamento`, `id_resp_cancelamento`, `motivo_cancelamento`) VALUES
	(38, 16, 16, 6, 1, NULL, 3, 6, '2024-10-14', '10:57:00', '2024-10-14', '10:56:00', '2024-10-22', '10:25:00', '2024-10-14', '2024-10-14', '11:57:00', '2024-10-14', NULL, NULL, 'R', '46546', _binary 0x54617265666120726561697a61646120636f6d207375636573736f, 129, 375, 'C', 'P', '', 'troca de fonte', NULL, 'C', '', NULL, _binary 0x56617272656475726120646520616e7469207669727573, '2024-10-01', '14:41:00', '2024-10-14', '12:56:00', 'C', NULL, 2, NULL, NULL, NULL, NULL),
	(39, 16, 16, 6, NULL, 1, 3, 6, '2024-10-14', '10:57:00', '2024-10-14', '10:56:00', '2024-10-17', '15:51:00', '2024-10-14', '2024-10-14', '11:57:00', '2024-10-14', NULL, NULL, 'E', '46546', _binary 0x7365727669c3a76f207265616c697a61646f, 0, 385, 'C', 'P', '', 'troca de fonte', NULL, 'C', '', NULL, _binary 0x496e737065c3a7c3a36f20456cc3a9747269636120646f207072c3a964696f, '2024-10-01', '14:41:00', '2024-10-14', '12:56:00', 'C', NULL, 3, NULL, NULL, NULL, NULL),
	(40, 16, 16, 6, NULL, 2, 3, 6, '2024-10-14', '10:57:00', '2024-10-14', '10:56:00', NULL, NULL, '2024-10-14', '2024-10-14', '11:57:00', '2024-10-14', NULL, NULL, 'E', '46546', NULL, 0, 0, 'C', 'P', '', 'troca de fonte', NULL, 'C', '', NULL, _binary 0x4d616e7574656ec3a7c3a36f20646520726f74696e61206e61207265646520656cc3a9747269636120646f2067616c70c3a36f20646f20616c6d6f786172696661646f206461207361c3ba6465, '2024-10-02', '15:13:00', '2024-10-14', '12:56:00', 'A', NULL, 3, NULL, NULL, NULL, NULL),
	(41, 16, 16, 6, 1, 0, 3, 6, '2024-10-14', '10:57:00', '2024-10-14', '10:56:00', '2024-10-14', '13:36:00', '2024-10-14', '2024-10-14', '11:57:00', '2024-10-14', NULL, NULL, 'R', '46546', _binary 0x546f64617320617320546f6d6164617320666f72616d2074726f6361646173, 0, 0, 'C', 'P', '', 'troca de fonte', NULL, 'C', '', NULL, _binary 0x496e7374616c61c3a7c3a36f20646520546f6d61646120656cc3a97472696361, '2024-10-02', '16:01:00', '2024-10-14', '12:56:00', 'C', 39, 3, NULL, NULL, NULL, NULL),
	(43, 16, 16, 6, 1, NULL, 3, 6, '2024-10-14', '10:57:00', '2024-10-14', '10:56:00', '2024-10-17', '14:58:00', '2024-10-14', '2024-10-14', '11:57:00', '2024-10-14', NULL, NULL, 'R', '46546', _binary 0x546f646f73206f732070726f636564696d656e746f73207265616c697a61646f7320636f6d207375636573736f, 0, 0, 'C', 'P', '', 'troca de fonte', NULL, 'C', '', NULL, _binary 0x546573746520636f6d2067657261c3a7c3a36f20636f6d706574612064612070726576656e74697661, '2024-10-03', '16:02:00', '2024-10-14', '12:56:00', 'C', NULL, 5, NULL, NULL, NULL, NULL),
	(44, 16, 16, 6, 1, NULL, 3, 6, '2024-10-14', '10:57:00', '2024-10-14', '10:56:00', '2024-10-17', '15:00:00', '2024-10-14', '2024-10-14', '11:57:00', '2024-10-14', NULL, NULL, 'R', '46546', _binary 0x746573746520646520636f6e636c7573c3a36f, 270, 0, 'C', 'P', '', 'troca de fonte', NULL, 'C', '', NULL, _binary 0x546573746520636f6d2067657261c3a7c3a36f20636f6d706574612064612070726576656e74697661, '2024-10-03', '16:06:00', '2024-10-14', '12:56:00', 'C', NULL, 5, NULL, NULL, NULL, NULL),
	(45, 16, 16, 6, 3, NULL, 3, 6, '2024-10-14', '10:57:00', '2024-10-14', '10:56:00', NULL, NULL, '2024-10-14', '2024-10-14', '11:57:00', '2024-10-14', NULL, NULL, 'R', '46546', NULL, 60, 99.166666666667, 'C', 'P', '', 'troca de fonte', NULL, 'C', '', NULL, _binary 0x43686563616167656d20646f2061706172656c686f0d0a736567756e64612067657261c3a7c3a36f2064652070726576656e74697661, '2024-10-03', '16:20:00', '2024-10-14', '12:56:00', 'X', NULL, 8, '2024-10-17', '15:15:00', 16, NULL),
	(46, 16, 16, 6, NULL, 2, 3, 6, '2024-10-14', '10:57:00', '2024-10-14', '10:56:00', NULL, NULL, '2024-10-14', '2024-10-14', '11:57:00', '2024-10-14', NULL, NULL, 'E', '46546', NULL, 0, 0, 'C', 'P', '', 'troca de fonte', NULL, 'C', '', NULL, _binary 0x496e737065c3a7c3a36f20456cc3a9747269636120646f207072c3a964696f0d0a736567756e64612067657261c3a7c3a36f2064652070726576656e7469766120636f6d2065737061c3a76f2066697369636f, '2024-10-03', '16:20:00', '2024-10-14', '12:56:00', 'A', NULL, 3, NULL, NULL, NULL, NULL),
	(47, 16, 16, 6, 1, 0, 3, 6, '2024-10-14', '10:57:00', '2024-10-14', '10:56:00', '2024-10-14', '14:01:00', '2024-10-14', '2024-10-14', '11:57:00', '2024-10-14', NULL, NULL, 'R', '46546', _binary 0x54726f636120646120666f6e7465207265616c697a61646120636f6d207375636573736f, 75, 578.83333333333, 'C', 'P', '', 'troca de fonte', NULL, 'C', '', NULL, _binary 0x54726f636120646520666f6e7465, '2024-10-14', '10:56:00', '2024-10-14', '12:56:00', 'C', 41, 2, NULL, NULL, NULL, NULL),
	(48, 16, 16, 6, 0, 7, 3, 6, NULL, NULL, '2024-10-14', '11:24:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'E', NULL, NULL, NULL, NULL, 'C', 'P', NULL, 'Troca de lampadas', NULL, NULL, NULL, NULL, _binary 0x54726f6361206465206c616d7061646173, '2024-10-14', '11:25:00', '2024-10-14', '11:24:00', 'A', 42, 3, NULL, NULL, NULL, NULL),
	(49, 16, 16, 4, 0, 0, 3, 6, NULL, NULL, '2024-10-14', '11:42:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'V', NULL, NULL, NULL, NULL, 'C', 'P', NULL, 'teste', NULL, NULL, NULL, NULL, _binary 0x557375c3a172696f206e6f766f206465202072656465, '2024-10-14', '11:42:00', '2024-10-14', '11:42:00', 'A', 40, 7, NULL, NULL, NULL, NULL),
	(50, 16, 16, 1, 0, 0, 3, 6, NULL, NULL, '2024-10-14', '11:45:00', '2024-10-17', '15:59:00', NULL, NULL, NULL, NULL, NULL, NULL, 'V', NULL, _binary 0x436f6e636c75c3ad646f, NULL, 375, 'C', 'P', NULL, 'teste', NULL, NULL, NULL, NULL, _binary 0x63726961c3a7c3a36f20646520656d61696c20706f6461407361626172612e6d672e676f762e6272, '2024-10-14', '11:45:00', '2024-10-14', '12:45:00', 'C', 38, 2, NULL, NULL, NULL, NULL),
	(51, 16, 16, 6, 0, 0, 3, 6, NULL, NULL, '2024-10-16', '10:06:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'V', NULL, NULL, NULL, NULL, 'C', 'P', NULL, 'criação de email', NULL, NULL, NULL, NULL, _binary 0x43726961c3a7c3a36f20646520656d61696c, '2024-10-16', '10:06:00', '2024-10-16', '10:06:00', 'A', 45, 5, NULL, NULL, NULL, NULL),
	(52, 16, 16, 4, 0, 7, 7, 6, NULL, NULL, '2024-10-16', '10:12:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'E', NULL, NULL, NULL, NULL, 'C', 'P', NULL, 'reparo', NULL, NULL, NULL, NULL, _binary 0x72657061726f, '2024-10-16', '10:12:00', '2024-10-16', '10:12:00', 'A', 46, 3, NULL, NULL, NULL, NULL),
	(53, 22, 16, 6, 1, 0, 3, 6, NULL, NULL, '2024-10-18', '09:50:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'R', NULL, NULL, NULL, NULL, 'C', 'P', NULL, 'Problema na impressora', NULL, NULL, NULL, NULL, _binary 0x696d7072657373c3a36f207275696d, '2024-10-18', '09:54:00', '2024-10-18', '09:50:00', 'A', 47, 1, NULL, NULL, NULL, NULL),
	(54, 16, 16, 4, 1, NULL, 7, 6, NULL, NULL, '2024-10-25', '09:49:00', '2024-11-11', '11:51:00', NULL, NULL, NULL, NULL, NULL, NULL, 'R', NULL, _binary 0x7365727669c3a76f20636f6e636c7569646f, 207.6, 226.25, 'P', NULL, 'R', 'Preventiva de computador DeskTop', NULL, NULL, NULL, NULL, _binary 0x7465737465, '2024-10-25', '09:49:00', NULL, NULL, 'C', NULL, 3, NULL, NULL, NULL, NULL),
	(55, 16, 16, 3, 1, NULL, 3, 6, NULL, NULL, '2024-10-25', '09:49:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'R', NULL, NULL, 1697, 380, 'P', NULL, 'R', 'Preventiva de computador DeskTop', NULL, NULL, NULL, NULL, _binary 0x56617272656475726120646520616e7469207669727573, '2024-10-25', '09:49:00', NULL, NULL, 'A', NULL, 2, NULL, NULL, NULL, NULL),
	(56, 16, 16, 4, 3, NULL, 3, 6, NULL, NULL, '2024-10-25', '09:49:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'R', NULL, NULL, NULL, NULL, 'P', NULL, 'S', 'Preventiva de Estabilizador Z3', NULL, NULL, NULL, NULL, _binary 0x636865636167656d2064652074656e73c3a36f, '2024-10-25', '09:49:00', NULL, NULL, 'A', NULL, 8, NULL, NULL, NULL, NULL),
	(57, 16, 16, 4, NULL, 2, 1, 6, NULL, NULL, '2024-10-25', '09:49:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'E', NULL, NULL, NULL, NULL, 'P', NULL, 'R', 'Preventiva de Prédio Saúde', NULL, NULL, NULL, NULL, _binary 0x4d616e7574656ec3a7c3a36f20646520726f74696e61206e61207265646520656cc3a9747269636120646f2067616c70c3a36f20646f20616c6d6f786172696661646f206461207361c3ba6465, '2024-10-25', '09:49:00', NULL, NULL, 'A', NULL, 3, NULL, NULL, NULL, NULL),
	(58, 16, 16, 3, NULL, 2, 1, 6, NULL, NULL, '2024-10-25', '09:49:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'E', NULL, NULL, NULL, NULL, 'P', NULL, 'R', 'Preventiva de Prédio Saúde', NULL, NULL, NULL, NULL, _binary 0x496e737065c3a7c3a36f20456cc3a9747269636120646f207072c3a964696f0d0a736567756e64612067657261c3a7c3a36f2064652070726576656e7469766120636f6d2065737061c3a76f2066697369636f, '2024-10-25', '09:49:00', NULL, NULL, 'A', NULL, 3, NULL, NULL, NULL, NULL),
	(59, 16, 16, 4, 3, NULL, 3, 6, NULL, NULL, '2024-10-25', '16:35:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'R', NULL, NULL, NULL, NULL, 'P', NULL, 'S', 'Preventiva de Estabilizador Z3', NULL, NULL, NULL, NULL, _binary 0x636865636167656d2064652074656e73c3a36f, '2024-10-25', '16:35:00', NULL, NULL, 'A', NULL, 8, NULL, NULL, NULL, NULL),
	(60, 16, 16, 6, 0, 0, 3, 6, NULL, NULL, '2024-10-25', '16:37:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'V', NULL, NULL, NULL, NULL, 'C', 'P', NULL, 'usuario novo', NULL, NULL, NULL, NULL, _binary 0x4e6f6d6520646f20757375c3a172696f3a476c6169736f6e0d0a50617374612064652061636573736f3a63706c6d73, '2024-10-25', '16:37:00', '2024-10-25', '18:37:00', 'A', 49, 7, NULL, NULL, NULL, NULL),
	(61, 16, 16, 3, 0, 0, 3, 6, NULL, NULL, '2024-11-05', '15:18:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'V', NULL, NULL, 62.5, 390, 'C', 'P', NULL, 'criação de email', NULL, NULL, NULL, NULL, _binary 0x446573637269c3a7c3a36f20646f20456d61696c3a, '2024-11-05', '15:18:00', '2024-11-05', '15:18:00', 'A', 50, 5, NULL, NULL, NULL, NULL),
	(62, 16, 16, 1, 2, NULL, 3, 6, '2024-10-09', '02:32:00', '2024-10-08', '08:00:00', NULL, NULL, '2024-11-10', '2024-11-10', '21:41:00', '2024-11-10', NULL, NULL, 'R', '', NULL, 180, 277.92, 'C', 'P', '', 'Manutenção de pc. setor de poda de árvores', NULL, 'C', '', NULL, _binary 0x70726576656e74697661202e2e2e2e2e2e2e2e, '2024-10-26', '16:55:00', '2024-10-10', '13:00:00', 'A', NULL, 3, NULL, NULL, NULL, NULL),
	(63, 16, 16, 1, 1, NULL, 3, 6, '2024-10-09', '02:32:00', '2024-10-08', '08:00:00', NULL, NULL, '2024-11-10', '2024-11-10', '21:41:00', '2024-11-10', NULL, NULL, 'R', '', NULL, 180, 277.92, 'C', 'P', '', 'Manutenção de pc. setor de poda de árvores', NULL, 'C', '', NULL, _binary 0x5665726966696361c3a7c3a36f20707265646974697661, '2024-10-26', '16:55:00', '2024-10-10', '13:00:00', 'A', NULL, 2, NULL, NULL, NULL, NULL),
	(64, 22, 16, 1, 0, 0, 7, 6, '2024-10-09', '02:32:00', '2024-10-08', '08:00:00', '2024-11-10', '19:06:00', '2024-11-10', '2024-11-10', '21:41:00', '2024-11-10', NULL, NULL, 'V', '', _binary 0x7465737465, 2000, 213.33333333333, 'C', 'P', '', 'Manutenção de pc. setor de poda de árvores', NULL, 'C', '', NULL, _binary 0x446573637269c3a7c3a36f20646f20656d61696c3a636f6d70726173407361626172612e6d672c676f762e6272, '2024-11-10', '00:13:00', '2024-10-10', '13:00:00', 'C', 57, 5, NULL, NULL, NULL, NULL),
	(65, 16, 16, 1, 3, 0, 3, 6, '2024-10-09', '02:32:00', '2024-10-08', '08:00:00', NULL, NULL, '2024-11-10', '2024-11-10', '21:41:00', '2024-11-10', NULL, NULL, 'R', '', NULL, 180, 277.92, 'C', 'P', '', 'Manutenção de pc. setor de poda de árvores', NULL, 'C', '', NULL, _binary 0x4d616e7574656ec3a7c3a36f206573746162696c697a61646f72, '2024-11-10', '00:31:00', '2024-10-10', '13:00:00', 'A', 52, 3, NULL, NULL, NULL, NULL),
	(66, 16, 16, 1, 1, 0, 3, 6, '2024-10-09', '02:32:00', '2024-10-08', '08:00:00', NULL, NULL, '2024-11-10', '2024-11-10', '21:41:00', '2024-11-10', NULL, NULL, 'R', '', NULL, 7, 277.92, 'C', 'P', '', 'Manutenção de pc. setor de poda de árvores', NULL, 'C', '', NULL, _binary 0x746573746520636f6d207265637572736f, '2024-11-10', '00:42:00', '2024-10-10', '13:00:00', 'A', 50, 8, NULL, NULL, NULL, NULL),
	(67, 16, 16, 7, 0, 0, 3, 6, NULL, NULL, '2024-11-10', '20:30:00', '2024-11-10', '20:31:00', NULL, NULL, NULL, NULL, NULL, NULL, 'V', NULL, _binary 0x7365727669c3a76f207265616c697a61646f, 45, 140, 'C', 'P', NULL, 'criação de usuário', NULL, NULL, NULL, NULL, _binary 0x4e6f6d6520646f205573756172696f203a204d617269612e53696c76610d0a6d6174726963756c6120303339393339, '2024-11-10', '20:30:00', '2024-11-10', '21:30:00', 'C', 58, 7, NULL, NULL, NULL, NULL),
	(68, 21, 21, 9, 0, 5, 1, 6, NULL, NULL, '2024-11-15', '16:10:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'E', NULL, NULL, 5, 106.66666666667, 'C', 'P', NULL, 'Passagem de Cabos Elétricos', NULL, NULL, NULL, NULL, _binary 0x506173736167656d2064652063616265616d656e746f20456cc3a9747269636f, '2024-11-15', '16:11:00', '2024-11-18', '16:10:00', 'A', 59, 3, NULL, NULL, NULL, NULL),
	(69, 16, 16, 9, 3, 0, 2, 6, NULL, NULL, '2024-11-16', '09:37:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'R', NULL, NULL, 89, 100, 'C', 'P', NULL, 'teste de ordem de serviço', NULL, NULL, NULL, NULL, _binary 0x7465737465, '2024-11-16', '09:38:00', '2024-11-16', '15:37:00', 'A', 60, 2, NULL, NULL, NULL, NULL),
	(70, 16, 16, 9, 0, 0, 3, 6, NULL, NULL, '2024-11-16', '09:43:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'V', NULL, NULL, NULL, 180, 'C', 'P', NULL, 'teste de consulta', NULL, NULL, NULL, NULL, _binary 0x4e6f6d6520646f205573756172696f0d0a6d6174726963756c61, '2024-11-16', '09:43:00', '2024-11-16', '10:43:00', 'A', 61, 7, NULL, NULL, NULL, NULL),
	(71, 16, 16, 4, 3, NULL, 1, 6, NULL, NULL, '2025-02-12', '00:03:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'R', NULL, NULL, NULL, NULL, 'P', NULL, 'R', 'Preventiva de Estabilizador Z3', NULL, NULL, NULL, NULL, _binary 0x7465737465, '2025-02-12', '00:03:00', '2025-02-24', '00:03:00', 'A', NULL, 3, NULL, NULL, NULL, NULL),
	(72, 16, 16, 3, 1, NULL, 3, 6, NULL, NULL, '2025-02-12', '00:03:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'R', NULL, NULL, NULL, NULL, 'P', NULL, 'R', 'Preventiva de computador DeskTop', NULL, NULL, NULL, NULL, _binary 0x56617272656475726120646520616e7469207669727573, '2025-02-12', '00:03:00', '2069-12-31', '00:03:00', 'A', NULL, 2, NULL, NULL, NULL, NULL),
	(73, 16, 16, 3, 1, NULL, 3, 6, NULL, NULL, '2025-02-12', '00:03:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'R', NULL, NULL, NULL, NULL, 'P', NULL, 'R', 'Preventiva de computador DeskTop', NULL, NULL, NULL, NULL, _binary 0x56617272656475726120646520616e7469207669727573, '2025-02-12', '00:03:00', '2069-12-31', '00:03:00', 'A', NULL, 2, NULL, NULL, NULL, NULL),
	(74, 16, 16, 4, 1, NULL, 7, 6, NULL, NULL, '2025-02-12', '00:03:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'R', NULL, NULL, NULL, NULL, 'P', NULL, 'R', 'Preventiva de computador DeskTop', NULL, NULL, NULL, NULL, _binary 0x7465737465, '2025-02-12', '00:03:00', '2069-12-31', '00:03:00', 'A', NULL, 3, NULL, NULL, NULL, NULL),
	(75, 16, 16, 4, 1, NULL, 7, 6, NULL, NULL, '2025-02-12', '00:03:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'R', NULL, NULL, NULL, NULL, 'P', NULL, 'R', 'Preventiva de computador DeskTop', NULL, NULL, NULL, NULL, _binary 0x7465737465, '2025-02-12', '00:03:00', '2069-12-31', '00:03:00', 'A', NULL, 3, NULL, NULL, NULL, NULL),
	(76, 16, 16, 1, 3, NULL, 2, 6, NULL, NULL, '2025-02-12', '00:03:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'R', NULL, NULL, NULL, NULL, 'P', NULL, 'P', 'Preventiva de Estabilizador Z3', NULL, NULL, NULL, NULL, _binary 0x43686563616167656d20646f2061706172656c686f0d0a736567756e64612067657261c3a7c3a36f2064652070726576656e74697661, '2025-02-12', '00:03:00', '2069-12-31', '00:03:00', 'A', NULL, 8, NULL, NULL, NULL, NULL),
	(77, 16, 16, 4, 3, NULL, 3, 6, NULL, NULL, '2025-02-12', '00:03:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'R', NULL, NULL, NULL, NULL, 'P', NULL, 'S', 'Preventiva de Estabilizador Z3', NULL, NULL, NULL, NULL, _binary 0x636865636167656d2064652074656e73c3a36f, '2025-02-12', '00:03:00', '2069-12-31', '00:03:00', 'A', NULL, 8, NULL, NULL, NULL, NULL),
	(78, 16, 16, 1, 3, NULL, 2, 6, NULL, NULL, '2025-02-12', '00:03:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'R', NULL, NULL, NULL, NULL, 'P', NULL, 'P', 'Preventiva de Estabilizador Z3', NULL, NULL, NULL, NULL, _binary 0x43686563616167656d20646f2061706172656c686f0d0a736567756e64612067657261c3a7c3a36f2064652070726576656e74697661, '2025-02-12', '00:03:00', '2069-12-31', '00:03:00', 'A', NULL, 8, NULL, NULL, NULL, NULL),
	(79, 16, 16, 4, 1, NULL, 7, 6, NULL, NULL, '2025-02-12', '00:03:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'R', NULL, NULL, NULL, NULL, 'P', NULL, 'R', 'Preventiva de computador DeskTop', NULL, NULL, NULL, NULL, _binary 0x546573746520636f6d2067657261c3a7c3a36f20636f6d706574612064612070726576656e74697661, '2025-02-12', '00:03:00', '2069-12-31', '00:03:00', 'A', NULL, 5, NULL, NULL, NULL, NULL),
	(80, 16, 16, 4, 1, NULL, 7, 6, NULL, NULL, '2025-02-12', '00:03:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'R', NULL, NULL, NULL, NULL, 'P', NULL, 'R', 'Preventiva de computador DeskTop', NULL, NULL, NULL, NULL, _binary 0x546573746520636f6d2067657261c3a7c3a36f20636f6d706574612064612070726576656e74697661, '2025-02-12', '00:03:00', '2069-12-31', '00:03:00', 'A', NULL, 5, NULL, NULL, NULL, NULL),
	(81, 16, 16, 9, 3, NULL, 1, 6, NULL, NULL, '2025-02-12', '00:03:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'R', NULL, NULL, NULL, NULL, 'P', NULL, 'S', 'Preventiva de Estabilizador Z3', NULL, NULL, NULL, NULL, _binary 0x5265766973c3a36f20646f204571756970616d656e746f, '2025-02-12', '00:03:00', '2069-12-31', '00:03:00', 'A', NULL, 8, NULL, NULL, NULL, NULL),
	(82, 16, 16, 4, 3, NULL, 3, 6, NULL, NULL, '2025-02-12', '00:03:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'R', NULL, NULL, NULL, NULL, 'P', NULL, 'S', 'Preventiva de Estabilizador Z3', NULL, NULL, NULL, NULL, _binary 0x636865636167656d2064652074656e73c3a36f, '2025-02-12', '00:03:00', '2069-12-31', '00:03:00', 'A', NULL, 8, NULL, NULL, NULL, NULL),
	(83, 16, 16, 1, 2, NULL, 3, 6, NULL, NULL, '2025-02-12', '00:03:00', '2026-01-13', '23:27:00', NULL, NULL, NULL, NULL, NULL, NULL, 'R', NULL, _binary 0x7365727669c3a76f20666569746f, NULL, NULL, 'P', NULL, 'R', 'Preventiva de Servidor Dell 15456', NULL, NULL, NULL, NULL, _binary 0x70726576656e74697661202e2e2e2e2e2e2e2e, '2025-02-12', '00:03:00', '2025-02-14', '00:03:00', 'C', NULL, 3, NULL, NULL, NULL, NULL),
	(84, 16, 16, 6, 1, NULL, 3, 6, NULL, NULL, '2025-02-12', '00:03:00', '2026-01-13', '23:21:00', NULL, NULL, NULL, NULL, NULL, NULL, 'R', NULL, _binary 0x7465737465, NULL, 283.33333333333, 'P', NULL, 'P', 'Preventiva de computador DeskTop', NULL, NULL, NULL, NULL, _binary 0x5665726966696361c3a7c3a36f20707265646974697661, '2025-02-12', '00:03:00', '2025-02-15', '00:03:00', 'C', NULL, 2, NULL, NULL, NULL, NULL),
	(85, 16, 16, 9, 0, 0, 1, 6, NULL, NULL, '2025-03-04', '15:54:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'V', NULL, NULL, NULL, NULL, 'C', 'P', NULL, 'teste', NULL, NULL, NULL, NULL, _binary 0x7465737465, '2025-03-04', '15:55:00', '2025-03-04', '16:54:00', 'A', 78, 14, NULL, NULL, NULL, NULL),
	(86, 16, 16, 4, 3, NULL, 1, NULL, NULL, NULL, '2025-03-04', '17:08:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'R', NULL, NULL, NULL, NULL, 'P', NULL, 'R', 'Preventiva de Estabilizador Z3', NULL, NULL, NULL, NULL, _binary 0x7465737465, '2025-03-04', '17:08:00', '2025-03-16', '17:08:00', 'A', NULL, 3, NULL, NULL, NULL, NULL),
	(87, 16, 16, 1, 3, NULL, 2, NULL, NULL, NULL, '2025-03-04', '17:08:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'R', NULL, NULL, NULL, NULL, 'P', NULL, 'P', 'Preventiva de Estabilizador Z3', NULL, NULL, NULL, NULL, _binary 0x43686563616167656d20646f2061706172656c686f0d0a736567756e64612067657261c3a7c3a36f2064652070726576656e74697661, '2025-03-04', '17:08:00', '2069-12-31', '17:08:00', 'A', NULL, 8, NULL, NULL, NULL, NULL),
	(88, 16, 16, 1, 3, NULL, 2, NULL, NULL, NULL, '2025-03-04', '17:08:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'R', NULL, NULL, NULL, NULL, 'P', NULL, 'P', 'Preventiva de Estabilizador Z3', NULL, NULL, NULL, NULL, _binary 0x43686563616167656d20646f2061706172656c686f0d0a736567756e64612067657261c3a7c3a36f2064652070726576656e74697661, '2025-03-04', '17:08:00', '2069-12-31', '17:08:00', 'A', NULL, 8, NULL, NULL, NULL, NULL),
	(89, 16, 16, 4, 1, NULL, 7, NULL, NULL, NULL, '2025-03-04', '17:08:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'R', NULL, NULL, NULL, NULL, 'P', NULL, 'R', 'Preventiva de computador DeskTop', NULL, NULL, NULL, NULL, _binary 0x7465737465, '2025-03-04', '17:08:00', '2069-12-31', '17:08:00', 'A', NULL, 3, NULL, NULL, NULL, NULL),
	(90, 16, 16, 4, 1, NULL, 7, NULL, NULL, NULL, '2025-03-04', '17:08:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'R', NULL, NULL, NULL, NULL, 'P', NULL, 'R', 'Preventiva de computador DeskTop', NULL, NULL, NULL, NULL, _binary 0x546573746520636f6d2067657261c3a7c3a36f20636f6d706574612064612070726576656e74697661, '2025-03-04', '17:08:00', '2069-12-31', '17:08:00', 'A', NULL, 5, NULL, NULL, NULL, NULL),
	(91, 16, 16, 4, 1, NULL, 7, NULL, NULL, NULL, '2025-03-04', '17:08:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'R', NULL, NULL, NULL, NULL, 'P', NULL, 'R', 'Preventiva de computador DeskTop', NULL, NULL, NULL, NULL, _binary 0x7465737465, '2025-03-04', '17:08:00', '2069-12-31', '17:08:00', 'A', NULL, 3, NULL, NULL, NULL, NULL),
	(92, 16, 16, 4, 1, NULL, 7, NULL, NULL, NULL, '2025-03-04', '17:08:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'R', NULL, NULL, NULL, NULL, 'P', NULL, 'R', 'Preventiva de computador DeskTop', NULL, NULL, NULL, NULL, _binary 0x546573746520636f6d2067657261c3a7c3a36f20636f6d706574612064612070726576656e74697661, '2025-03-04', '17:08:00', '2069-12-31', '17:08:00', 'A', NULL, 5, NULL, NULL, NULL, NULL),
	(93, 16, 16, 4, 3, NULL, 3, NULL, NULL, NULL, '2025-03-04', '17:08:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'R', NULL, NULL, NULL, NULL, 'P', NULL, 'S', 'Preventiva de Estabilizador Z3', NULL, NULL, NULL, NULL, _binary 0x636865636167656d2064652074656e73c3a36f, '2025-03-04', '17:08:00', '2069-12-31', '17:08:00', 'A', NULL, 8, NULL, NULL, NULL, NULL),
	(94, 16, 16, 4, 3, NULL, 3, NULL, NULL, NULL, '2025-03-04', '17:08:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'R', NULL, NULL, NULL, NULL, 'P', NULL, 'S', 'Preventiva de Estabilizador Z3', NULL, NULL, NULL, NULL, _binary 0x636865636167656d2064652074656e73c3a36f, '2025-03-04', '17:08:00', '2069-12-31', '17:08:00', 'A', NULL, 8, NULL, NULL, NULL, NULL),
	(95, 16, 16, 9, 3, NULL, 1, NULL, NULL, NULL, '2025-03-04', '17:08:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'R', NULL, NULL, NULL, NULL, 'P', NULL, 'S', 'Preventiva de Estabilizador Z3', NULL, NULL, NULL, NULL, _binary 0x5265766973c3a36f20646f204571756970616d656e746f, '2025-03-04', '17:08:00', '2069-12-31', '17:08:00', 'A', NULL, 8, NULL, NULL, NULL, NULL),
	(96, 16, 16, 1, 2, NULL, 3, NULL, NULL, NULL, '2025-03-04', '17:08:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'R', NULL, NULL, NULL, NULL, 'P', NULL, 'R', 'Preventiva de Servidor Dell 15456', NULL, NULL, NULL, NULL, _binary 0x70726576656e74697661202e2e2e2e2e2e2e2e, '2025-03-04', '17:08:00', '2025-03-06', '17:08:00', 'A', NULL, 3, NULL, NULL, NULL, NULL),
	(97, 16, 16, 6, 1, NULL, 3, NULL, NULL, NULL, '2025-03-04', '17:08:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'R', NULL, NULL, NULL, NULL, 'P', NULL, 'P', 'Preventiva de computador DeskTop', NULL, NULL, NULL, NULL, _binary 0x5665726966696361c3a7c3a36f20707265646974697661, '2025-03-04', '17:08:00', '2025-03-07', '17:08:00', 'A', NULL, 2, NULL, NULL, NULL, NULL),
	(98, 16, 16, 4, NULL, 2, 1, NULL, NULL, NULL, '2025-03-04', '17:08:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'E', NULL, NULL, NULL, NULL, 'P', NULL, 'R', 'Preventiva de Prédio Saúde', NULL, NULL, NULL, NULL, _binary 0x4d616e7574656ec3a7c3a36f20646520726f74696e61206e61207265646520656cc3a9747269636120646f2067616c70c3a36f20646f20616c6d6f786172696661646f206461207361c3ba6465, '2025-03-04', '17:08:00', '2069-12-31', '17:08:00', 'A', NULL, 3, NULL, NULL, NULL, NULL),
	(99, 16, 16, 4, NULL, 2, 1, NULL, NULL, NULL, '2025-03-04', '17:08:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'E', NULL, NULL, NULL, NULL, 'P', NULL, 'R', 'Preventiva de Prédio Saúde', NULL, NULL, NULL, NULL, _binary 0x4d616e7574656ec3a7c3a36f20646520726f74696e61206e61207265646520656cc3a9747269636120646f2067616c70c3a36f20646f20616c6d6f786172696661646f206461207361c3ba6465, '2025-03-04', '17:08:00', '2069-12-31', '17:08:00', 'A', NULL, 3, NULL, NULL, NULL, NULL),
	(100, 16, 16, 3, NULL, 2, 1, NULL, NULL, NULL, '2025-03-04', '17:08:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'E', NULL, NULL, NULL, NULL, 'P', NULL, 'R', 'Preventiva de Prédio Saúde', NULL, NULL, NULL, NULL, _binary 0x496e737065c3a7c3a36f20456cc3a9747269636120646f207072c3a964696f0d0a736567756e64612067657261c3a7c3a36f2064652070726576656e7469766120636f6d2065737061c3a76f2066697369636f, '2025-03-04', '17:08:00', '2069-12-31', '17:08:00', 'A', NULL, 3, NULL, NULL, NULL, NULL),
	(101, 16, 16, 3, NULL, 2, 1, NULL, NULL, NULL, '2025-03-04', '17:08:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'E', NULL, NULL, NULL, NULL, 'P', NULL, 'R', 'Preventiva de Prédio Saúde', NULL, NULL, NULL, NULL, _binary 0x496e737065c3a7c3a36f20456cc3a9747269636120646f207072c3a964696f0d0a736567756e64612067657261c3a7c3a36f2064652070726576656e7469766120636f6d2065737061c3a76f2066697369636f, '2025-03-04', '17:08:00', '2069-12-31', '17:08:00', 'A', NULL, 3, NULL, NULL, NULL, NULL),
	(102, 16, 16, 1, 3, NULL, 2, NULL, NULL, NULL, '2025-03-05', '12:29:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'R', NULL, NULL, NULL, NULL, 'P', NULL, 'P', 'Preventiva de Estabilizador Z3', NULL, NULL, NULL, NULL, _binary 0x43686563616167656d20646f2061706172656c686f0d0a736567756e64612067657261c3a7c3a36f2064652070726576656e74697661, '2025-03-05', '12:29:00', '2069-12-31', '12:29:00', 'A', NULL, 8, NULL, NULL, NULL, NULL),
	(103, 16, 16, 1, 3, NULL, 2, NULL, NULL, NULL, '2025-03-05', '12:29:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'R', NULL, NULL, NULL, NULL, 'P', NULL, 'P', 'Preventiva de Estabilizador Z3', NULL, NULL, NULL, NULL, _binary 0x43686563616167656d20646f2061706172656c686f0d0a736567756e64612067657261c3a7c3a36f2064652070726576656e74697661, '2025-03-05', '12:29:00', '2069-12-31', '12:29:00', 'A', NULL, 8, NULL, NULL, NULL, NULL),
	(104, 16, 16, 4, 1, NULL, 7, NULL, NULL, NULL, '2025-03-05', '12:29:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'R', NULL, NULL, NULL, NULL, 'P', NULL, 'R', 'Preventiva de computador DeskTop', NULL, NULL, NULL, NULL, _binary 0x546573746520636f6d2067657261c3a7c3a36f20636f6d706574612064612070726576656e74697661, '2025-03-05', '12:29:00', '2069-12-31', '12:29:00', 'A', NULL, 5, NULL, NULL, NULL, NULL),
	(105, 16, 16, 4, 1, NULL, 7, NULL, NULL, NULL, '2025-03-05', '12:29:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'R', NULL, NULL, NULL, NULL, 'P', NULL, 'R', 'Preventiva de computador DeskTop', NULL, NULL, NULL, NULL, _binary 0x546573746520636f6d2067657261c3a7c3a36f20636f6d706574612064612070726576656e74697661, '2025-03-05', '12:29:00', '2069-12-31', '12:29:00', 'A', NULL, 5, NULL, NULL, NULL, NULL),
	(106, 16, 16, 4, 3, NULL, 1, NULL, NULL, NULL, '2025-03-05', '12:29:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'R', NULL, NULL, NULL, NULL, 'P', NULL, 'R', 'Preventiva de Estabilizador Z3', NULL, NULL, NULL, NULL, _binary 0x7465737465, '2025-03-05', '12:29:00', '2025-03-17', '12:29:00', 'A', NULL, 3, NULL, NULL, NULL, NULL),
	(107, 16, 16, 4, 3, NULL, 3, NULL, NULL, NULL, '2025-03-05', '12:29:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'R', NULL, NULL, NULL, NULL, 'P', NULL, 'S', 'Preventiva de Estabilizador Z3', NULL, NULL, NULL, NULL, _binary 0x636865636167656d2064652074656e73c3a36f, '2025-03-05', '12:29:00', '2069-12-31', '12:29:00', 'A', NULL, 8, NULL, NULL, NULL, NULL),
	(108, 16, 16, 4, 3, NULL, 3, NULL, NULL, NULL, '2025-03-05', '12:29:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'R', NULL, NULL, NULL, NULL, 'P', NULL, 'S', 'Preventiva de Estabilizador Z3', NULL, NULL, NULL, NULL, _binary 0x636865636167656d2064652074656e73c3a36f, '2025-03-05', '12:29:00', '2069-12-31', '12:29:00', 'A', NULL, 8, NULL, NULL, NULL, NULL),
	(109, 16, 16, 4, 1, NULL, 7, NULL, NULL, NULL, '2025-03-05', '12:29:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'R', NULL, NULL, NULL, NULL, 'P', NULL, 'R', 'Preventiva de computador DeskTop', NULL, NULL, NULL, NULL, _binary 0x7465737465, '2025-03-05', '12:29:00', '2069-12-31', '12:29:00', 'A', NULL, 3, NULL, NULL, NULL, NULL),
	(110, 16, 16, 4, 1, NULL, 7, NULL, NULL, NULL, '2025-03-05', '12:29:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'R', NULL, NULL, NULL, NULL, 'P', NULL, 'R', 'Preventiva de computador DeskTop', NULL, NULL, NULL, NULL, _binary 0x7465737465, '2025-03-05', '12:29:00', '2069-12-31', '12:29:00', 'A', NULL, 3, NULL, NULL, NULL, NULL),
	(111, 16, 16, 9, 3, NULL, 1, NULL, NULL, NULL, '2025-03-05', '12:29:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'R', NULL, NULL, NULL, NULL, 'P', NULL, 'S', 'Preventiva de Estabilizador Z3', NULL, NULL, NULL, NULL, _binary 0x5265766973c3a36f20646f204571756970616d656e746f, '2025-03-05', '12:29:00', '2069-12-31', '12:29:00', 'A', NULL, 8, NULL, NULL, NULL, NULL),
	(112, 16, 16, 1, 2, NULL, 3, NULL, NULL, NULL, '2025-03-05', '12:29:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'R', NULL, NULL, NULL, NULL, 'P', NULL, 'R', 'Preventiva de Servidor Dell 15456', NULL, NULL, NULL, NULL, _binary 0x70726576656e74697661202e2e2e2e2e2e2e2e, '2025-03-05', '12:29:00', '2025-03-07', '12:29:00', 'A', NULL, 3, NULL, NULL, NULL, NULL),
	(113, 16, 16, 6, 1, NULL, 3, NULL, NULL, NULL, '2025-03-05', '12:29:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'R', NULL, NULL, NULL, NULL, 'P', NULL, 'P', 'Preventiva de computador DeskTop', NULL, NULL, NULL, NULL, _binary 0x5665726966696361c3a7c3a36f20707265646974697661, '2025-03-05', '12:29:00', '2025-03-08', '12:29:00', 'A', NULL, 2, NULL, NULL, NULL, NULL),
	(114, 16, 16, 4, NULL, 2, 1, NULL, NULL, NULL, '2025-03-05', '12:29:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'E', NULL, NULL, NULL, NULL, 'P', NULL, 'R', 'Preventiva de Prédio Saúde', NULL, NULL, NULL, NULL, _binary 0x4d616e7574656ec3a7c3a36f20646520726f74696e61206e61207265646520656cc3a9747269636120646f2067616c70c3a36f20646f20616c6d6f786172696661646f206461207361c3ba6465, '2025-03-05', '12:29:00', '2069-12-31', '12:29:00', 'A', NULL, 3, NULL, NULL, NULL, NULL),
	(115, 16, 16, 4, NULL, 2, 1, NULL, NULL, NULL, '2025-03-05', '12:29:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'E', NULL, NULL, NULL, NULL, 'P', NULL, 'R', 'Preventiva de Prédio Saúde', NULL, NULL, NULL, NULL, _binary 0x4d616e7574656ec3a7c3a36f20646520726f74696e61206e61207265646520656cc3a9747269636120646f2067616c70c3a36f20646f20616c6d6f786172696661646f206461207361c3ba6465, '2025-03-05', '12:29:00', '2069-12-31', '12:29:00', 'A', NULL, 3, NULL, NULL, NULL, NULL),
	(116, 16, 16, 3, NULL, 2, 1, NULL, NULL, NULL, '2025-03-05', '12:29:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'E', NULL, NULL, NULL, NULL, 'P', NULL, 'R', 'Preventiva de Prédio Saúde', NULL, NULL, NULL, NULL, _binary 0x496e737065c3a7c3a36f20456cc3a9747269636120646f207072c3a964696f0d0a736567756e64612067657261c3a7c3a36f2064652070726576656e7469766120636f6d2065737061c3a76f2066697369636f, '2025-03-05', '12:29:00', '2069-12-31', '12:29:00', 'A', NULL, 3, NULL, NULL, NULL, NULL),
	(117, 16, 16, 3, NULL, 2, 1, NULL, NULL, NULL, '2025-03-05', '12:29:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'E', NULL, NULL, NULL, NULL, 'P', NULL, 'R', 'Preventiva de Prédio Saúde', NULL, NULL, NULL, NULL, _binary 0x496e737065c3a7c3a36f20456cc3a9747269636120646f207072c3a964696f0d0a736567756e64612067657261c3a7c3a36f2064652070726576656e7469766120636f6d2065737061c3a76f2066697369636f, '2025-03-05', '12:29:00', '2069-12-31', '12:29:00', 'A', NULL, 3, NULL, NULL, NULL, NULL),
	(118, 22, 16, 8, 0, 0, 7, 7, NULL, NULL, '2026-01-13', '23:43:00', '2026-01-13', '23:46:00', NULL, NULL, NULL, NULL, NULL, NULL, 'V', NULL, _binary 0x557375c3a172696f2043726961646f20787878780d0a73656e68612079797979, NULL, NULL, 'C', 'U', NULL, 'teste', NULL, NULL, NULL, NULL, _binary 0x4e6f6d6520646f20757375c3a172696f3a41726e616c20416e74756e65730d0a50617374612064652061636573736f3a4564756361c3a7c3a36f2065204e756765, '2026-01-13', '23:43:00', '2026-01-15', '03:43:00', 'C', 79, 7, NULL, NULL, NULL, NULL),
	(119, 16, 16, 9, 0, 0, 7, 10, NULL, NULL, '2026-01-14', '00:30:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'V', NULL, NULL, NULL, NULL, 'C', 'P', NULL, 'teste', NULL, NULL, NULL, NULL, _binary 0x4e6f2e20646f2053454c4220786335360d0a50726f626c656d61203a206d616e636861206e6120696d7072657373c3a36f, '2026-01-14', '00:13:00', '2026-01-14', '00:30:00', 'A', 80, 1, NULL, NULL, NULL, NULL),
	(120, 16, 16, 9, 0, 0, 3, 5, '2026-02-01', '19:06:00', '2026-01-26', '08:00:00', NULL, NULL, '2026-02-01', '2026-02-01', '19:06:00', '2026-02-01', NULL, NULL, 'V', '', NULL, 0, 50.3, 'C', 'P', '', 'Criação de Email', NULL, 'C', '', NULL, _binary 0x446573637269c3a7c3a36f20646f20656d61696c3a61646d4070617264696e692e636f6d2e6272, '2026-01-24', '15:56:00', '2026-01-24', '09:00:00', 'A', 56, 5, NULL, NULL, NULL, NULL),
	(121, 22, 16, 9, 0, 0, 3, 5, NULL, NULL, '2026-01-29', '11:30:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'V', NULL, NULL, 154.2, NULL, 'C', 'P', NULL, 'Manutenção', NULL, NULL, NULL, NULL, _binary 0x7465737465, '2026-01-29', '23:31:00', '2026-01-29', '01:00:00', 'A', 69, 14, NULL, NULL, NULL, NULL),
	(122, 22, 16, 7, 0, 0, 3, 6, NULL, NULL, '2026-01-31', '12:45:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'V', NULL, NULL, 203.25, 0, 'C', 'P', NULL, 'Criação usuário Moderna', NULL, NULL, NULL, NULL, _binary 0x4e6f6d6520436f6d706c65746f203a5269636172646f204e6576730d0a4dc3b364756c6f73203a2070617472696d6f6e696f206520636f6d707261730d0a4350463a363336333636373733, '2026-01-31', '12:46:00', '2026-01-31', '14:00:00', 'A', 81, 10, NULL, NULL, NULL, NULL),
	(123, 22, 16, 8, 0, 0, 3, 6, NULL, NULL, '2026-02-05', '09:00:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'V', NULL, NULL, NULL, 226.35, 'C', 'P', NULL, 'Manutenção de Impressora do compras', NULL, NULL, NULL, NULL, _binary 0x4e6f2e20646f2053454c423a207a6e333434630d0a50726f626c656d61203a4d616e63686173206e6120696d7072657373c3a36f, '2026-02-04', '23:37:00', '2026-02-05', '15:00:00', 'A', 83, 1, NULL, NULL, NULL, NULL),
	(124, 16, 16, 4, 1, NULL, 7, 5, NULL, NULL, '2026-02-07', '22:25:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'R', NULL, NULL, NULL, NULL, 'P', NULL, 'R', 'Preventiva de computador DeskTop', NULL, NULL, NULL, NULL, _binary 0x7465737465, '2026-02-07', '22:25:00', '2026-02-10', '22:25:00', 'A', NULL, 8, NULL, NULL, NULL, NULL),
	(125, 16, 16, 1, 3, NULL, 2, 5, NULL, NULL, '2026-02-07', '22:25:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'R', NULL, NULL, NULL, NULL, 'P', NULL, 'P', 'Preventiva de Estabilizador Z3', NULL, NULL, NULL, NULL, _binary 0x43686563616167656d20646f2061706172656c686f0d0a736567756e64612067657261c3a7c3a36f2064652070726576656e74697661, '2026-02-07', '22:25:00', '2069-12-31', '22:25:00', 'A', NULL, 8, NULL, NULL, NULL, NULL),
	(126, 16, 16, 1, 3, NULL, 2, 5, NULL, NULL, '2026-02-07', '22:25:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'R', NULL, NULL, NULL, NULL, 'P', NULL, 'P', 'Preventiva de Estabilizador Z3', NULL, NULL, NULL, NULL, _binary 0x43686563616167656d20646f2061706172656c686f0d0a736567756e64612067657261c3a7c3a36f2064652070726576656e74697661, '2026-02-07', '22:25:00', '2069-12-31', '22:25:00', 'A', NULL, 8, NULL, NULL, NULL, NULL),
	(127, 16, 16, 4, 1, NULL, 7, 5, NULL, NULL, '2026-02-07', '22:25:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'R', NULL, NULL, NULL, NULL, 'P', NULL, 'R', 'Preventiva de computador DeskTop', NULL, NULL, NULL, NULL, _binary 0x546573746520636f6d2067657261c3a7c3a36f20636f6d706574612064612070726576656e74697661, '2026-02-07', '22:25:00', '2069-12-31', '22:25:00', 'A', NULL, 5, NULL, NULL, NULL, NULL),
	(128, 16, 16, 4, 1, NULL, 7, 5, NULL, NULL, '2026-02-07', '22:25:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'R', NULL, NULL, NULL, NULL, 'P', NULL, 'R', 'Preventiva de computador DeskTop', NULL, NULL, NULL, NULL, _binary 0x546573746520636f6d2067657261c3a7c3a36f20636f6d706574612064612070726576656e74697661, '2026-02-07', '22:25:00', '2069-12-31', '22:25:00', 'A', NULL, 5, NULL, NULL, NULL, NULL),
	(129, 16, 16, 4, 3, NULL, 1, 5, NULL, NULL, '2026-02-07', '22:25:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'R', NULL, NULL, NULL, NULL, 'P', NULL, 'R', 'Preventiva de Estabilizador Z3', NULL, NULL, NULL, NULL, _binary 0x7465737465, '2026-02-07', '22:25:00', '2026-02-19', '22:25:00', 'A', NULL, 3, NULL, NULL, NULL, NULL),
	(130, 16, 16, 4, 3, NULL, 3, 5, NULL, NULL, '2026-02-07', '22:25:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'R', NULL, NULL, NULL, NULL, 'P', NULL, 'S', 'Preventiva de Estabilizador Z3', NULL, NULL, NULL, NULL, _binary 0x636865636167656d2064652074656e73c3a36f, '2026-02-07', '22:25:00', '2069-12-31', '22:25:00', 'A', NULL, 8, NULL, NULL, NULL, NULL),
	(131, 16, 16, 4, 3, NULL, 3, 5, NULL, NULL, '2026-02-07', '22:25:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'R', NULL, NULL, NULL, NULL, 'P', NULL, 'S', 'Preventiva de Estabilizador Z3', NULL, NULL, NULL, NULL, _binary 0x636865636167656d2064652074656e73c3a36f, '2026-02-07', '22:25:00', '2069-12-31', '22:25:00', 'A', NULL, 8, NULL, NULL, NULL, NULL),
	(132, 16, 16, 4, 1, NULL, 7, 5, NULL, NULL, '2026-02-07', '22:25:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'R', NULL, NULL, NULL, NULL, 'P', NULL, 'R', 'Preventiva de computador DeskTop', NULL, NULL, NULL, NULL, _binary 0x7465737465, '2026-02-07', '22:25:00', '2069-12-31', '22:25:00', 'A', NULL, 3, NULL, NULL, NULL, NULL),
	(133, 16, 16, 4, 1, NULL, 7, 5, NULL, NULL, '2026-02-07', '22:25:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'R', NULL, NULL, NULL, NULL, 'P', NULL, 'R', 'Preventiva de computador DeskTop', NULL, NULL, NULL, NULL, _binary 0x7465737465, '2026-02-07', '22:25:00', '2069-12-31', '22:25:00', 'A', NULL, 3, NULL, NULL, NULL, NULL),
	(134, 16, 16, 9, 3, NULL, 1, 5, NULL, NULL, '2026-02-07', '22:25:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'R', NULL, NULL, NULL, NULL, 'P', NULL, 'S', 'Preventiva de Estabilizador Z3', NULL, NULL, NULL, NULL, _binary 0x5265766973c3a36f20646f204571756970616d656e746f, '2026-02-07', '22:25:00', '2069-12-31', '22:25:00', 'A', NULL, 8, NULL, NULL, NULL, NULL),
	(135, 16, 16, 1, 2, NULL, 3, 5, NULL, NULL, '2026-02-07', '22:25:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'R', NULL, NULL, NULL, NULL, 'P', NULL, 'R', 'Preventiva de Servidor Dell 15456', NULL, NULL, NULL, NULL, _binary 0x70726576656e74697661202e2e2e2e2e2e2e2e, '2026-02-07', '22:25:00', '2026-02-09', '22:25:00', 'A', NULL, 3, NULL, NULL, NULL, NULL),
	(136, 16, 16, 6, 1, NULL, 3, 5, NULL, NULL, '2026-02-07', '22:25:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'R', NULL, NULL, NULL, NULL, 'P', NULL, 'P', 'Preventiva de computador DeskTop', NULL, NULL, NULL, NULL, _binary 0x5665726966696361c3a7c3a36f20707265646974697661, '2026-02-07', '22:25:00', '2026-02-10', '22:25:00', 'A', NULL, 2, NULL, NULL, NULL, NULL),
	(138, 16, 16, 4, 1, NULL, 7, 5, NULL, NULL, '2026-02-07', '22:26:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'R', NULL, NULL, NULL, NULL, 'P', NULL, 'R', 'Preventiva de computador DeskTop', NULL, NULL, NULL, NULL, _binary 0x7465737465, '2026-02-07', '22:26:00', '2026-02-10', '22:26:00', 'A', NULL, 8, NULL, NULL, NULL, NULL),
	(139, 16, 16, 1, 3, NULL, 2, 5, NULL, NULL, '2026-02-07', '22:26:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'R', NULL, NULL, NULL, NULL, 'P', NULL, 'P', 'Preventiva de Estabilizador Z3', NULL, NULL, NULL, NULL, _binary 0x43686563616167656d20646f2061706172656c686f0d0a736567756e64612067657261c3a7c3a36f2064652070726576656e74697661, '2026-02-07', '22:26:00', '2069-12-31', '22:26:00', 'A', NULL, 8, NULL, NULL, NULL, NULL),
	(140, 16, 16, 1, 3, NULL, 2, 5, NULL, NULL, '2026-02-07', '22:26:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'R', NULL, NULL, NULL, NULL, 'P', NULL, 'P', 'Preventiva de Estabilizador Z3', NULL, NULL, NULL, NULL, _binary 0x43686563616167656d20646f2061706172656c686f0d0a736567756e64612067657261c3a7c3a36f2064652070726576656e74697661, '2026-02-07', '22:26:00', '2069-12-31', '22:26:00', 'A', NULL, 8, NULL, NULL, NULL, NULL),
	(141, 16, 16, 4, 1, NULL, 7, 5, NULL, NULL, '2026-02-07', '22:26:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'R', NULL, NULL, NULL, NULL, 'P', NULL, 'R', 'Preventiva de computador DeskTop', NULL, NULL, NULL, NULL, _binary 0x546573746520636f6d2067657261c3a7c3a36f20636f6d706574612064612070726576656e74697661, '2026-02-07', '22:26:00', '2069-12-31', '22:26:00', 'A', NULL, 5, NULL, NULL, NULL, NULL),
	(142, 16, 16, 4, 1, NULL, 7, 5, NULL, NULL, '2026-02-07', '22:26:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'R', NULL, NULL, NULL, NULL, 'P', NULL, 'R', 'Preventiva de computador DeskTop', NULL, NULL, NULL, NULL, _binary 0x546573746520636f6d2067657261c3a7c3a36f20636f6d706574612064612070726576656e74697661, '2026-02-07', '22:26:00', '2069-12-31', '22:26:00', 'A', NULL, 5, NULL, NULL, NULL, NULL),
	(143, 16, 16, 4, 3, NULL, 1, 5, NULL, NULL, '2026-02-07', '22:26:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'R', NULL, NULL, NULL, NULL, 'P', NULL, 'R', 'Preventiva de Estabilizador Z3', NULL, NULL, NULL, NULL, _binary 0x7465737465, '2026-02-07', '22:26:00', '2026-02-19', '22:26:00', 'A', NULL, 3, NULL, NULL, NULL, NULL),
	(144, 16, 16, 4, 3, NULL, 3, 5, NULL, NULL, '2026-02-07', '22:26:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'R', NULL, NULL, NULL, NULL, 'P', NULL, 'S', 'Preventiva de Estabilizador Z3', NULL, NULL, NULL, NULL, _binary 0x636865636167656d2064652074656e73c3a36f, '2026-02-07', '22:26:00', '2069-12-31', '22:26:00', 'A', NULL, 8, NULL, NULL, NULL, NULL),
	(145, 16, 16, 4, 3, NULL, 3, 5, NULL, NULL, '2026-02-07', '22:26:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'R', NULL, NULL, NULL, NULL, 'P', NULL, 'S', 'Preventiva de Estabilizador Z3', NULL, NULL, NULL, NULL, _binary 0x636865636167656d2064652074656e73c3a36f, '2026-02-07', '22:26:00', '2069-12-31', '22:26:00', 'A', NULL, 8, NULL, NULL, NULL, NULL),
	(146, 16, 16, 4, 1, NULL, 7, 5, NULL, NULL, '2026-02-07', '22:26:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'R', NULL, NULL, NULL, NULL, 'P', NULL, 'R', 'Preventiva de computador DeskTop', NULL, NULL, NULL, NULL, _binary 0x7465737465, '2026-02-07', '22:26:00', '2069-12-31', '22:26:00', 'A', NULL, 3, NULL, NULL, NULL, NULL),
	(147, 16, 16, 4, 1, NULL, 7, 5, NULL, NULL, '2026-02-07', '22:26:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'R', NULL, NULL, NULL, NULL, 'P', NULL, 'R', 'Preventiva de computador DeskTop', NULL, NULL, NULL, NULL, _binary 0x7465737465, '2026-02-07', '22:26:00', '2069-12-31', '22:26:00', 'A', NULL, 3, NULL, NULL, NULL, NULL),
	(148, 16, 16, 9, 3, NULL, 1, 5, NULL, NULL, '2026-02-07', '22:26:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'R', NULL, NULL, NULL, NULL, 'P', NULL, 'S', 'Preventiva de Estabilizador Z3', NULL, NULL, NULL, NULL, _binary 0x5265766973c3a36f20646f204571756970616d656e746f, '2026-02-07', '22:26:00', '2069-12-31', '22:26:00', 'A', NULL, 8, NULL, NULL, NULL, NULL),
	(149, 16, 16, 1, 2, NULL, 3, 5, NULL, NULL, '2026-02-07', '22:26:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'R', NULL, NULL, NULL, NULL, 'P', NULL, 'R', 'Preventiva de Servidor Dell 15456', NULL, NULL, NULL, NULL, _binary 0x70726576656e74697661202e2e2e2e2e2e2e2e, '2026-02-07', '22:26:00', '2026-02-09', '22:26:00', 'A', NULL, 3, NULL, NULL, NULL, NULL),
	(150, 16, 16, 6, 1, NULL, 3, 5, NULL, NULL, '2026-02-07', '22:26:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'R', NULL, NULL, NULL, NULL, 'P', NULL, 'P', 'Preventiva de computador DeskTop', NULL, NULL, NULL, NULL, _binary 0x5665726966696361c3a7c3a36f20707265646974697661, '2026-02-07', '22:26:00', '2026-02-10', '22:26:00', 'A', NULL, 2, NULL, NULL, NULL, NULL);

-- Copiando estrutura para tabela gop.ordens_check
CREATE TABLE IF NOT EXISTS `ordens_check` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_ordem` int DEFAULT NULL,
  `id_check` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_ordens_check_ordens` (`id_ordem`),
  KEY `FK_ordens_check_checklist` (`id_check`),
  CONSTRAINT `FK_ordens_check_checklist` FOREIGN KEY (`id_check`) REFERENCES `checklist` (`id`),
  CONSTRAINT `FK_ordens_check_ordens` FOREIGN KEY (`id_ordem`) REFERENCES `ordens` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=38 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Copiando dados para a tabela gop.ordens_check: ~30 rows (aproximadamente)
INSERT INTO `ordens_check` (`id`, `id_ordem`, `id_check`) VALUES
	(4, 24, 2),
	(7, 24, 1),
	(8, 41, 1),
	(11, 44, 1),
	(12, 44, 3),
	(13, 43, 3),
	(14, 47, 1),
	(15, 45, 3),
	(16, 48, 3),
	(17, 79, 1),
	(18, 79, 3),
	(19, 80, 1),
	(20, 80, 3),
	(21, 90, 1),
	(22, 90, 3),
	(23, 92, 1),
	(24, 92, 3),
	(25, 104, 1),
	(26, 104, 3),
	(27, 105, 1),
	(28, 105, 3),
	(29, 84, 1),
	(30, 127, 1),
	(31, 127, 3),
	(32, 128, 1),
	(33, 128, 3),
	(34, 141, 1),
	(35, 141, 3),
	(36, 142, 1),
	(37, 142, 3);

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
) ENGINE=InnoDB AUTO_INCREMENT=59 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Copiando dados para a tabela gop.ordens_executores: ~54 rows (aproximadamente)
INSERT INTO `ordens_executores` (`id`, `id_ordem`, `id_executor`, `tempo_horas`, `tempo_minutos`, `valor_hora`, `valor_total`) VALUES
	(1, 51, 5, 3, 15, 120, 390),
	(2, 56, 6, 2, 40, 100, 266.66666666667),
	(3, 61, 10, 4, 30, 80, 360),
	(4, 56, 5, 9, 14, 140, 1292.6666666667),
	(5, 48, 7, 3, 30, 120, 420),
	(6, 24, 6, 4, 30, 15, 67.5),
	(7, 24, 5, 12, 20, 150, 1850),
	(8, 45, 6, 3, 15, 15, 48.75),
	(9, 24, 5, 3, 35, 140, 501.66666666667),
	(10, 24, 5, 2, 30, 20, 50),
	(11, 38, 6, 2, 30, 150, 375),
	(12, 41, 7, 3, 40, 85, 311.66666666667),
	(13, 70, 7, 2, 15, 80, 180),
	(14, 69, 7, 1, 15, 80, 100),
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
	(30, 61, 7, 2, 15, 120, 270),
	(31, 72, 6, NULL, NULL, NULL, NULL),
	(32, 72, 5, NULL, NULL, NULL, NULL),
	(33, 73, 6, NULL, NULL, NULL, NULL),
	(34, 73, 5, NULL, NULL, NULL, NULL),
	(35, 79, 5, NULL, NULL, NULL, NULL),
	(36, 79, 7, NULL, NULL, NULL, NULL),
	(37, 80, 5, NULL, NULL, NULL, NULL),
	(38, 80, 7, NULL, NULL, NULL, NULL),
	(39, 90, 5, NULL, NULL, NULL, NULL),
	(40, 90, 7, NULL, NULL, NULL, NULL),
	(41, 92, 5, NULL, NULL, NULL, NULL),
	(42, 92, 7, NULL, NULL, NULL, NULL),
	(43, 104, 5, NULL, NULL, NULL, NULL),
	(44, 104, 7, NULL, NULL, NULL, NULL),
	(45, 105, 5, NULL, NULL, NULL, NULL),
	(46, 105, 7, NULL, NULL, NULL, NULL),
	(47, 84, 10, 2, 50, 100, 283.33333333333),
	(48, 120, 5, 0, 20, 150.9, 50.3),
	(49, 122, 6, 2, 0, 0, 0),
	(50, 123, 5, 1, 30, 150.9, 226.35),
	(51, 127, 5, NULL, NULL, NULL, NULL),
	(52, 127, 7, NULL, NULL, NULL, NULL),
	(53, 128, 5, NULL, NULL, NULL, NULL),
	(54, 128, 7, NULL, NULL, NULL, NULL),
	(55, 141, 5, NULL, NULL, NULL, NULL),
	(56, 141, 7, NULL, NULL, NULL, NULL),
	(57, 142, 5, NULL, NULL, NULL, NULL),
	(58, 142, 7, NULL, NULL, NULL, NULL);

-- Copiando estrutura para tabela gop.ordens_ferramentas
CREATE TABLE IF NOT EXISTS `ordens_ferramentas` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_ordem` int DEFAULT NULL,
  `id_ferramenta` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_ordens_ferramentas_ordens` (`id_ordem`),
  KEY `FK_ordens_ferramentas_ferramentas` (`id_ferramenta`),
  CONSTRAINT `FK_ordens_ferramentas_ferramentas` FOREIGN KEY (`id_ferramenta`) REFERENCES `ferramentas` (`id`),
  CONSTRAINT `FK_ordens_ferramentas_ordens` FOREIGN KEY (`id_ordem`) REFERENCES `ordens` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Copiando dados para a tabela gop.ordens_ferramentas: ~27 rows (aproximadamente)
INSERT INTO `ordens_ferramentas` (`id`, `id_ordem`, `id_ferramenta`) VALUES
	(1, 24, 6),
	(4, 41, 6),
	(5, 44, 6),
	(6, 44, 1),
	(7, 47, 6),
	(8, 45, 5),
	(9, 54, 6),
	(10, 79, 6),
	(11, 79, 1),
	(12, 80, 6),
	(13, 80, 1),
	(14, 90, 6),
	(15, 90, 1),
	(16, 92, 6),
	(17, 92, 1),
	(18, 104, 6),
	(19, 104, 1),
	(20, 105, 6),
	(21, 105, 1),
	(22, 127, 6),
	(23, 127, 1),
	(24, 128, 6),
	(25, 128, 1),
	(26, 141, 6),
	(27, 141, 1),
	(28, 142, 6),
	(29, 142, 1);

-- Copiando estrutura para tabela gop.ordens_imagens
CREATE TABLE IF NOT EXISTS `ordens_imagens` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_ordem` int DEFAULT NULL,
  `caminho` varchar(250) DEFAULT NULL,
  `data` date DEFAULT NULL,
  `comentario` varchar(120) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_ordens_imagens_ordens` (`id_ordem`),
  CONSTRAINT `FK_ordens_imagens_ordens` FOREIGN KEY (`id_ordem`) REFERENCES `ordens` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Copiando dados para a tabela gop.ordens_imagens: ~8 rows (aproximadamente)
INSERT INTO `ordens_imagens` (`id`, `id_ordem`, `caminho`, `data`, `comentario`) VALUES
	(3, 38, 'img/computador.jpeg', '2024-10-04', 'Primeira manutenção do equipamento'),
	(4, 38, 'img/placamae.jpeg', '2024-10-04', 'Imagem da placa mãe'),
	(5, 43, 'img/computador.jpeg', '2024-10-08', 'Situação do equipamento no atendimento'),
	(6, 47, 'img/placamae.jpeg', '2024-10-14', 'troca da placa máe'),
	(7, 41, 'img/computador.jpeg', '2024-10-15', NULL),
	(8, 41, 'img/computador.jpeg', '2024-10-15', NULL),
	(9, 41, 'img/computador.jpeg', '2024-10-15', NULL),
	(10, 45, 'img/computador.jpeg', '2024-10-15', NULL),
	(11, 66, 'img/133701324653692118.jpg', '2025-01-07', NULL),
	(12, 55, 'img/133701324653692118.jpg', '2025-01-07', NULL);

-- Copiando estrutura para tabela gop.ordens_materiais
CREATE TABLE IF NOT EXISTS `ordens_materiais` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_ordem` int DEFAULT NULL,
  `id_material` int DEFAULT NULL,
  `id_unidade` int DEFAULT NULL,
  `quantidade` double DEFAULT NULL,
  `valor` double DEFAULT NULL,
  `baixa` char(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_ordens_materiais_materiais` (`id_material`),
  KEY `FK_ordens_materiais_unidades` (`id_unidade`),
  KEY `FK_ordens_materiais_ordens` (`id_ordem`),
  CONSTRAINT `FK_ordens_materiais_materiais` FOREIGN KEY (`id_material`) REFERENCES `materiais` (`id`),
  CONSTRAINT `FK_ordens_materiais_ordens` FOREIGN KEY (`id_ordem`) REFERENCES `ordens` (`id`),
  CONSTRAINT `FK_ordens_materiais_unidades` FOREIGN KEY (`id_unidade`) REFERENCES `unidades` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=68 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Copiando dados para a tabela gop.ordens_materiais: ~52 rows (aproximadamente)
INSERT INTO `ordens_materiais` (`id`, `id_ordem`, `id_material`, `id_unidade`, `quantidade`, `valor`, `baixa`) VALUES
	(8, 24, 2, 8, 100, 1.5, NULL),
	(13, 24, 3, 10, 2, 17.5, NULL),
	(14, 38, 3, 2, 1, 120, NULL),
	(15, 38, 2, 8, 6, 1.5, NULL),
	(16, 41, 4, 8, 10, 1.7, NULL),
	(17, 41, 2, 8, 15, 1.5, NULL),
	(22, 44, 4, 10, 5, 6, NULL),
	(23, 44, 2, 8, 120, 2, NULL),
	(24, 43, 4, 10, 1, 3.5, NULL),
	(25, 43, 2, 8, 15, 1.5, NULL),
	(26, 47, 3, 10, 5, 15, NULL),
	(27, 45, 3, 10, 5, 12, NULL),
	(28, 55, 2, 8, 120, 13.85, NULL),
	(29, 54, 3, 2, 12, 15.75, NULL),
	(30, 54, 4, 8, 2, 9.3, NULL),
	(31, 61, 3, 10, 3, 5.5, NULL),
	(32, 61, 4, 8, 1, 6, NULL),
	(33, 61, 2, 8, 20, 2, NULL),
	(34, 45, 2, 8, 12, 12, 'N'),
	(35, 64, 4, 2, 100, 20, 'N'),
	(36, 49, 4, 2, 34, 4.5, 'N'),
	(37, 67, 4, 8, 3, 15, 'N'),
	(38, 68, 4, 8, 1, 5, 'N'),
	(39, 69, 3, 10, 12, 4.5, 'S'),
	(40, 69, 4, 8, 10, 3.5, 'S'),
	(41, 66, 4, 8, 2, 3.5, 'S'),
	(42, 55, 4, 8, 10, 3.5, 'N'),
	(43, 72, 2, 8, 15, NULL, NULL),
	(44, 73, 2, 8, 15, NULL, NULL),
	(45, 79, 4, 10, 5, NULL, NULL),
	(46, 79, 2, 8, 120, NULL, NULL),
	(47, 80, 4, 10, 5, NULL, NULL),
	(48, 80, 2, 8, 120, NULL, NULL),
	(49, 90, 4, 10, 5, NULL, NULL),
	(50, 90, 2, 8, 120, NULL, NULL),
	(51, 92, 4, 10, 5, NULL, NULL),
	(52, 92, 2, 8, 120, NULL, NULL),
	(53, 104, 4, 10, 5, NULL, NULL),
	(54, 104, 2, 8, 120, NULL, NULL),
	(55, 105, 4, 10, 5, NULL, NULL),
	(56, 105, 2, 8, 120, NULL, NULL),
	(57, 122, 4, 8, 1, 10.5, 'N'),
	(58, 122, 2, 8, 15, 12.85, 'N'),
	(59, 121, 2, 8, 12, 12.85, 'N'),
	(60, 127, 4, 10, 5, NULL, NULL),
	(61, 127, 2, 8, 120, NULL, NULL),
	(62, 128, 4, 10, 5, NULL, NULL),
	(63, 128, 2, 8, 120, NULL, NULL),
	(64, 141, 4, 10, 5, NULL, NULL),
	(65, 141, 2, 8, 120, NULL, NULL),
	(66, 142, 4, 10, 5, NULL, NULL),
	(67, 142, 2, 8, 120, NULL, NULL);

-- Copiando estrutura para tabela gop.ordens_plano
CREATE TABLE IF NOT EXISTS `ordens_plano` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_plano` int DEFAULT NULL,
  `id_ordem` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_ordens_plano_planejamento` (`id_plano`),
  KEY `FK_ordens_plano_ordens` (`id_ordem`),
  CONSTRAINT `FK_ordens_plano_ordens` FOREIGN KEY (`id_ordem`) REFERENCES `ordens` (`id`),
  CONSTRAINT `FK_ordens_plano_planejamento` FOREIGN KEY (`id_plano`) REFERENCES `planejamento` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Copiando dados para a tabela gop.ordens_plano: ~4 rows (aproximadamente)
INSERT INTO `ordens_plano` (`id`, `id_plano`, `id_ordem`) VALUES
	(2, 1, 38),
	(3, 1, 47),
	(4, 1, 45),
	(5, 2, 48);

-- Copiando estrutura para tabela gop.ordens_pop
CREATE TABLE IF NOT EXISTS `ordens_pop` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_ordem` int DEFAULT NULL,
  `id_pop` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_ordens_pop_ordens` (`id_ordem`),
  KEY `FK_ordens_pop_pops` (`id_pop`),
  CONSTRAINT `FK_ordens_pop_ordens` FOREIGN KEY (`id_ordem`) REFERENCES `ordens` (`id`),
  CONSTRAINT `FK_ordens_pop_pops` FOREIGN KEY (`id_pop`) REFERENCES `pops` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=38 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Copiando dados para a tabela gop.ordens_pop: ~30 rows (aproximadamente)
INSERT INTO `ordens_pop` (`id`, `id_ordem`, `id_pop`) VALUES
	(1, 24, 2),
	(5, 24, 4),
	(7, 41, 4),
	(10, 44, 2),
	(11, 44, 4),
	(13, 43, 2),
	(14, 47, 2),
	(15, 45, 4),
	(16, 48, 4),
	(17, 79, 2),
	(18, 79, 4),
	(19, 80, 2),
	(20, 80, 4),
	(21, 90, 2),
	(22, 90, 4),
	(23, 92, 2),
	(24, 92, 4),
	(25, 104, 2),
	(26, 104, 4),
	(27, 105, 2),
	(28, 105, 4),
	(29, 84, 4),
	(30, 127, 2),
	(31, 127, 4),
	(32, 128, 2),
	(33, 128, 4),
	(34, 141, 2),
	(35, 141, 4),
	(36, 142, 2),
	(37, 142, 4);

-- Copiando estrutura para tabela gop.ordens_prestadores
CREATE TABLE IF NOT EXISTS `ordens_prestadores` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_ordem` int DEFAULT NULL,
  `id_prestador` int DEFAULT NULL,
  `tempo_horas` int DEFAULT NULL,
  `tempo_minutos` int DEFAULT NULL,
  `valor_hora` double DEFAULT NULL,
  `valor_total` double DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `FK_ordens_prestadores_ordens` (`id_ordem`) USING BTREE,
  KEY `FK_ordens_prestadores_prestador` (`id_prestador`) USING BTREE,
  CONSTRAINT `FK_ordens_prestadores_ordens` FOREIGN KEY (`id_ordem`) REFERENCES `ordens` (`id`),
  CONSTRAINT `FK_ordens_prestadores_prestadores` FOREIGN KEY (`id_prestador`) REFERENCES `prestadores` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Copiando dados para a tabela gop.ordens_prestadores: ~0 rows (aproximadamente)

-- Copiando estrutura para tabela gop.ordens_suspensao
CREATE TABLE IF NOT EXISTS `ordens_suspensao` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_ordem` int DEFAULT NULL,
  `data_suspensao` date DEFAULT NULL,
  `hora_suspensao` time DEFAULT NULL,
  `data_retirada` date DEFAULT NULL,
  `hora_retirada` time DEFAULT NULL,
  `motivo` blob,
  PRIMARY KEY (`id`),
  KEY `FK_ordens_suspensao_ordens` (`id_ordem`),
  CONSTRAINT `FK_ordens_suspensao_ordens` FOREIGN KEY (`id_ordem`) REFERENCES `ordens` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Copiando dados para a tabela gop.ordens_suspensao: ~5 rows (aproximadamente)
INSERT INTO `ordens_suspensao` (`id`, `id_ordem`, `data_suspensao`, `hora_suspensao`, `data_retirada`, `hora_retirada`, `motivo`) VALUES
	(2, 43, '2024-10-19', '15:28:00', '2025-03-05', '12:35:00', _binary 0x7465737465),
	(3, 38, '2024-10-17', '10:58:00', '2025-03-05', '12:35:00', _binary 0x7465737465),
	(4, 55, '2025-01-01', '19:18:00', '2025-03-05', '12:35:00', _binary 0x7465737465),
	(5, 55, '2025-03-04', '16:25:00', '2025-03-05', '12:35:00', _binary 0x7465737465),
	(6, 40, '2025-03-04', '16:29:00', '2025-03-05', '12:35:00', _binary 0x7465737465),
	(7, 57, '2025-03-04', '16:30:00', '2025-03-05', '12:35:00', _binary 0x7465737465);

-- Copiando estrutura para tabela gop.perfil_usuarios
CREATE TABLE IF NOT EXISTS `perfil_usuarios` (
  `id` int NOT NULL AUTO_INCREMENT,
  `descricao` varchar(120) DEFAULT NULL,
  `cadastros_recursosfisicos` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `cadastros_espacosfisicos` char(1) DEFAULT NULL,
  `cadastros_fornecedores` char(1) DEFAULT NULL,
  `cadastros_fabricantes` char(1) DEFAULT NULL,
  `cadastros_executores` char(1) DEFAULT NULL,
  `cadastros_cargosfuncoes` char(1) DEFAULT NULL,
  `cadastros_oficinas` char(1) DEFAULT NULL,
  `cadastro_centrosdecusto` char(1) DEFAULT NULL,
  `cadastros_setores` char(1) DEFAULT NULL,
  `cadastros_ferramentas` char(1) DEFAULT NULL,
  `cadastros_grupos` char(1) DEFAULT NULL,
  `cadastros_marcas` char(1) DEFAULT NULL,
  `cadastros_pop` char(1) DEFAULT NULL,
  `cadastros_tipos` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `cadastros_checklist` char(1) DEFAULT NULL,
  `cadastros_prestadores` char(1) DEFAULT NULL,
  `servicos_solicitacoes` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `servicos_ordens` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `servicos_preventivas` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `servicos_agenda` char(1) DEFAULT NULL,
  `servicos_ocorrencias_padroes` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `servicos_plano_acao` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `almoxarifado_cotacoes` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `almoxarifado_pedidodecompra` char(1) DEFAULT NULL,
  `almoxarifado_materiais` char(1) DEFAULT NULL,
  `almoxarifado_unidadesmedidas` char(1) DEFAULT NULL,
  `indicadores_ocorrencias` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `indicadores_comparativos` char(1) DEFAULT NULL,
  `custos_ocorrencias` char(1) DEFAULT NULL,
  `custos_comparativos` char(1) DEFAULT NULL,
  `custos` char(1) DEFAULT NULL,
  `obras` char(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Copiando dados para a tabela gop.perfil_usuarios: ~6 rows (aproximadamente)
INSERT INTO `perfil_usuarios` (`id`, `descricao`, `cadastros_recursosfisicos`, `cadastros_espacosfisicos`, `cadastros_fornecedores`, `cadastros_fabricantes`, `cadastros_executores`, `cadastros_cargosfuncoes`, `cadastros_oficinas`, `cadastro_centrosdecusto`, `cadastros_setores`, `cadastros_ferramentas`, `cadastros_grupos`, `cadastros_marcas`, `cadastros_pop`, `cadastros_tipos`, `cadastros_checklist`, `cadastros_prestadores`, `servicos_solicitacoes`, `servicos_ordens`, `servicos_preventivas`, `servicos_agenda`, `servicos_ocorrencias_padroes`, `servicos_plano_acao`, `almoxarifado_cotacoes`, `almoxarifado_pedidodecompra`, `almoxarifado_materiais`, `almoxarifado_unidadesmedidas`, `indicadores_ocorrencias`, `indicadores_comparativos`, `custos_ocorrencias`, `custos_comparativos`, `custos`, `obras`) VALUES
	(2, 'Secretária', 'S', 'S', 'S', 'S', 'S', 'S', 'S', 'S', 'S', 'S', 'S', 'S', 'S', 'S', 'S', 'N', 'S', 'S', 'S', 'N', 'S', 'N', 'S', 'S', 'S', 'S', 'S', 'S', 'S', 'S', NULL, 'N'),
	(3, 'Agente de Manutenção', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', NULL, 'N', NULL, 'S', 'S', 'N', NULL, 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', NULL, NULL),
	(4, 'Administrador', 'S', 'S', 'S', 'S', 'S', 'S', 'S', 'S', 'S', 'S', 'S', 'S', 'S', NULL, 'S', NULL, 'S', 'S', 'S', NULL, 'S', 'N', 'S', 'S', 'S', 'S', 'S', 'S', 'S', 'S', NULL, NULL),
	(5, 'teste', 'S', 'S', 'S', 'S', 'S', 'S', 'S', 'S', 'S', 'S', 'S', 'S', 'S', 'S', 'S', NULL, 'S', 'S', 'S', NULL, 'S', 'N', 'S', 'S', 'S', 'S', 'S', 'S', 'S', 'S', NULL, 'S'),
	(6, 'teste2', 'S', 'S', 'S', 'S', 'S', 'S', 'S', 'S', 'S', 'S', 'S', 'S', 'S', 'S', 'S', NULL, 'S', 'S', 'S', NULL, 'S', 'N', 'S', 'S', 'S', 'S', 'S', 'S', 'S', 'S', NULL, 'N'),
	(7, 'teste3', 'S', 'S', 'S', 'S', 'S', 'S', 'S', 'S', 'S', 'S', 'S', 'S', 'S', 'S', 'S', 'S', 'S', 'S', 'S', 'S', 'S', 'N', 'S', 'S', 'S', 'S', 'S', 'S', 'S', 'S', NULL, 'N');

-- Copiando estrutura para tabela gop.planejamento
CREATE TABLE IF NOT EXISTS `planejamento` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_setor` int DEFAULT NULL,
  `data` date DEFAULT NULL,
  `gerencia` varchar(120) DEFAULT NULL,
  `descritivo` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `meta` blob,
  PRIMARY KEY (`id`),
  KEY `FK_planejamento_setores` (`id_setor`),
  CONSTRAINT `FK_planejamento_setores` FOREIGN KEY (`id_setor`) REFERENCES `setores` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Copiando dados para a tabela gop.planejamento: ~2 rows (aproximadamente)
INSERT INTO `planejamento` (`id`, `id_setor`, `data`, `gerencia`, `descritivo`, `meta`) VALUES
	(1, 6, '2024-10-09', 'Informática', 'Implantação de sistema 1doc', _binary 0x496d706c617461c3a7c3a36f2064652073697374656d61203120646f63206e612070726566656974757261),
	(2, 6, '2024-10-09', 'CPLMS', 'Implantação do 1doc', _binary 0x496d706c616e7461c3a7c3a36f20646f2073697374656d612031646f6320706172612067657374c3a36f20646520646f63756d656e746f73);

-- Copiando estrutura para tabela gop.planejamento_diretrizes
CREATE TABLE IF NOT EXISTS `planejamento_diretrizes` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_planejamento` int DEFAULT NULL,
  `id_diretriz` int DEFAULT NULL,
  `id_estrategia` int DEFAULT NULL,
  `prazo` varchar(50) DEFAULT NULL,
  `local` varchar(120) DEFAULT NULL,
  `responsavel` varchar(120) DEFAULT NULL,
  `custo` double DEFAULT NULL,
  `situacao` char(1) DEFAULT NULL,
  `motivo` blob,
  `metodologia` blob,
  `observacao` blob,
  PRIMARY KEY (`id`),
  KEY `FK_planejamento_diretrizes_planejamento_diretrizes` (`id_planejamento`),
  KEY `FK_planejamento_diretrizes_diretrizes` (`id_diretriz`),
  KEY `FK_planejamento_diretrizes_estrategias` (`id_estrategia`),
  CONSTRAINT `FK_planejamento_diretrizes_diretrizes` FOREIGN KEY (`id_diretriz`) REFERENCES `diretrizes` (`id`),
  CONSTRAINT `FK_planejamento_diretrizes_estrategias` FOREIGN KEY (`id_estrategia`) REFERENCES `estrategias` (`id`),
  CONSTRAINT `FK_planejamento_diretrizes_planejamento` FOREIGN KEY (`id_planejamento`) REFERENCES `planejamento` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Copiando dados para a tabela gop.planejamento_diretrizes: ~3 rows (aproximadamente)
INSERT INTO `planejamento_diretrizes` (`id`, `id_planejamento`, `id_diretriz`, `id_estrategia`, `prazo`, `local`, `responsavel`, `custo`, `situacao`, `motivo`, `metodologia`, `observacao`) VALUES
	(1, 2, 2, 1, '30 dias', 'Regional Ravena', 'Patricia', 1400, 'N', _binary 0x4f62726120646520636f6e74656ec3a7c3a36f, _binary 0x50616472c3a36f2049534f39303030, _binary 0x7465737465206465206469726574697661),
	(7, 1, 4, 1, '30 dias', 'Prefeitura', 'Alexandra', 1400, 'N', _binary '', _binary '', _binary ''),
	(8, 1, 5, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

-- Copiando estrutura para tabela gop.pops
CREATE TABLE IF NOT EXISTS `pops` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_recurso` int DEFAULT NULL,
  `id_espaco` int DEFAULT NULL,
  `id_oficina` int NOT NULL,
  `tipo` char(1) NOT NULL,
  `descricao` varchar(120) NOT NULL,
  `revisado` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `preparado` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `resultadoesperado` blob,
  `materialnecessario` blob,
  `descritivo` blob,
  `atividadecritica` blob,
  `cuidados` blob,
  `anc` blob,
  `data` date DEFAULT NULL,
  `dataemissao` date DEFAULT NULL,
  `processo` blob,
  `objetivo` blob,
  `risco` blob,
  `refbibliografica` blob,
  PRIMARY KEY (`id`),
  KEY `FK_pops_recursos` (`id_recurso`),
  KEY `FK_pops_espacos` (`id_espaco`),
  KEY `FK_pops_oficinas` (`id_oficina`),
  CONSTRAINT `FK_pops_espacos` FOREIGN KEY (`id_espaco`) REFERENCES `espacos` (`id`),
  CONSTRAINT `FK_pops_oficinas` FOREIGN KEY (`id_oficina`) REFERENCES `oficinas` (`id`),
  CONSTRAINT `FK_pops_recursos` FOREIGN KEY (`id_recurso`) REFERENCES `recursos` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Copiando dados para a tabela gop.pops: ~2 rows (aproximadamente)
INSERT INTO `pops` (`id`, `id_recurso`, `id_espaco`, `id_oficina`, `tipo`, `descricao`, `revisado`, `preparado`, `resultadoesperado`, `materialnecessario`, `descritivo`, `atividadecritica`, `cuidados`, `anc`, `data`, `dataemissao`, `processo`, `objetivo`, `risco`, `refbibliografica`) VALUES
	(2, 1, 2, 3, '1', 'Instalação Super Nova', 'Marcos', 'Glaison', _binary 0x61636573736f20616f207365727669646f722064612073757065726e6f766120652061636573736f20616f207265737065637469766f73206dc3b364756c6f73, _binary 0x706173746120636f6d206f206172717569766f20646520696e7374616c61c3a7c3a36f20646973706f6ec3ad76656c206e61207061737461207574696c73, _binary 0x496e7374616c61c3a7c3a36f2070617261206f2061636573736f20646f2073697374656d612073757065726e6f7661206e6f20706320636c69656e746520, _binary 0x6e656e68756d61, _binary 0x696e7374616c6172206e6f206c6f67696e20646f20757375c3a172696f20717565206972c3a1207574696c697a6172206f2073697374656d61, _binary 0x5061737361722070617261206f207375706f72746520646520746920646120656d707265736120496e6f7661, '2024-09-04', NULL, _binary 0x2d20636f7069617220612070617374612073757065726e6f766120646973706f6e6976656c206e61207061737461207574696c7320646120726564650d0a2d20496e7374616c61206f2061706c6963617469766f20617070636f6e74726f6c65720d0a2d206372696172206174616c686f206e6120c3a17265612064652074726162616c686f, _binary 0x41636573736f20616f2073697374656d6120646f2073757065726e6f7661, _binary '', _binary 0x6e656e68756d61),
	(4, 1, 1, 7, '1', 'Configurar PC no Dominio', '', '', _binary '', _binary '', _binary '', _binary '', _binary '', _binary '', '2024-09-22', NULL, _binary '', _binary '', _binary '', _binary '');

-- Copiando estrutura para tabela gop.pop_anexos
CREATE TABLE IF NOT EXISTS `pop_anexos` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_pop` int DEFAULT NULL,
  `descricao` varchar(200) DEFAULT NULL,
  `path` varchar(250) DEFAULT NULL,
  `data` date DEFAULT NULL,
  `responsavel` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_pop_anexos_pops` (`id_pop`),
  CONSTRAINT `FK_pop_anexos_pops` FOREIGN KEY (`id_pop`) REFERENCES `pops` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Copiando dados para a tabela gop.pop_anexos: ~2 rows (aproximadamente)
INSERT INTO `pop_anexos` (`id`, `id_pop`, `descricao`, `path`, `data`, `responsavel`) VALUES
	(1, 4, 'cpf do Glaison', 'anexos/cpf_Glaison.pdf', '2025-01-07', 'Glaison'),
	(4, 4, 'Conta da claro', 'anexos/conta_claro.pdf', '2025-01-07', 'Glaison da conta');

-- Copiando estrutura para tabela gop.prestadores
CREATE TABLE IF NOT EXISTS `prestadores` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_tipo` int DEFAULT NULL,
  `razao_social` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `nome` varchar(200) DEFAULT NULL,
  `contato` varchar(120) DEFAULT NULL,
  `telefone1` varchar(25) DEFAULT NULL,
  `telefone2` varchar(25) DEFAULT NULL,
  `emal` varchar(120) DEFAULT NULL,
  `site` varchar(120) DEFAULT NULL,
  `endereco` varchar(150) DEFAULT NULL,
  `bairro` varchar(80) DEFAULT NULL,
  `cep` varchar(11) DEFAULT NULL,
  `cidade` varchar(80) DEFAULT NULL,
  `uf` varchar(2) DEFAULT NULL,
  `cnpj` varchar(18) DEFAULT NULL,
  `contrato` varchar(80) DEFAULT NULL,
  `valor_contrato` float DEFAULT NULL,
  `valor_visita` float DEFAULT NULL,
  `ativa` char(1) DEFAULT NULL,
  `observacao` blob,
  PRIMARY KEY (`id`),
  KEY `FK_prestadores_grupos_fornecedores` (`id_tipo`),
  CONSTRAINT `FK_prestadores_grupos_fornecedores` FOREIGN KEY (`id_tipo`) REFERENCES `grupos_fornecedores` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Copiando dados para a tabela gop.prestadores: ~0 rows (aproximadamente)

-- Copiando estrutura para tabela gop.preventivas
CREATE TABLE IF NOT EXISTS `preventivas` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_recurso` int DEFAULT NULL,
  `id_espaco` int DEFAULT NULL,
  `id_oficina` int DEFAULT NULL,
  `id_centrodecusto` int DEFAULT NULL,
  `id_ocorrencia` int DEFAULT NULL,
  `id_setor` int DEFAULT NULL,
  `id_executor` int DEFAULT NULL,
  `tipo` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'R = recurso E +espaco fisico / Edificação',
  `tipo_preventiva` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'sistema\r\npreditiva\r\nrotina',
  `data_cadastro` date NOT NULL,
  `periodicidade_geracao` int NOT NULL,
  `data_prox_realizacao` date DEFAULT NULL,
  `data_ult_realizacao` date DEFAULT NULL,
  `calibracao` char(1) DEFAULT NULL,
  `descritivo` blob,
  `gerar` char(3) DEFAULT NULL,
  `prazo_atendimento` int DEFAULT NULL,
  KEY `id` (`id`),
  KEY `FK_preventivas_recursos` (`id_recurso`),
  KEY `FK_preventivas_espacos` (`id_espaco`),
  KEY `FK_preventivas_oficinas` (`id_oficina`),
  KEY `FK_preventivas_centrodecusto` (`id_centrodecusto`),
  KEY `FK_preventivas_ocorrencias` (`id_ocorrencia`),
  KEY `FK_preventivas_setores` (`id_setor`),
  KEY `FK_preventivas_executores` (`id_executor`),
  CONSTRAINT `FK_preventivas_centrodecusto` FOREIGN KEY (`id_centrodecusto`) REFERENCES `centrodecusto` (`id`),
  CONSTRAINT `FK_preventivas_espacos` FOREIGN KEY (`id_espaco`) REFERENCES `espacos` (`id`),
  CONSTRAINT `FK_preventivas_executores` FOREIGN KEY (`id_executor`) REFERENCES `executores` (`id`),
  CONSTRAINT `FK_preventivas_ocorrencias` FOREIGN KEY (`id_ocorrencia`) REFERENCES `ocorrencias` (`id`),
  CONSTRAINT `FK_preventivas_oficinas` FOREIGN KEY (`id_oficina`) REFERENCES `oficinas` (`id`),
  CONSTRAINT `FK_preventivas_recursos` FOREIGN KEY (`id_recurso`) REFERENCES `recursos` (`id`),
  CONSTRAINT `FK_preventivas_setores` FOREIGN KEY (`id_setor`) REFERENCES `setores` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Copiando dados para a tabela gop.preventivas: ~20 rows (aproximadamente)
INSERT INTO `preventivas` (`id`, `id_recurso`, `id_espaco`, `id_oficina`, `id_centrodecusto`, `id_ocorrencia`, `id_setor`, `id_executor`, `tipo`, `tipo_preventiva`, `data_cadastro`, `periodicidade_geracao`, `data_prox_realizacao`, `data_ult_realizacao`, `calibracao`, `descritivo`, `gerar`, `prazo_atendimento`) VALUES
	(4, 1, NULL, 3, 2, 2, 3, 5, 'R', 'R', '2024-10-01', 3, '2024-12-12', '2024-11-12', 'N', _binary 0x56617272656475726120646520616e7469207669727573, 'Não', NULL),
	(5, NULL, 2, 1, 2, 3, 3, 5, 'E', 'R', '2024-10-01', 3, '2024-11-24', '2024-11-21', 'N', _binary 0x496e737065c3a7c3a36f20456cc3a9747269636120646f207072c3a964696f0d0a736567756e64612067657261c3a7c3a36f2064652070726576656e7469766120636f6d2065737061c3a76f2066697369636f, 'Sim', NULL),
	(6, 1, NULL, 7, 2, 3, 4, 5, 'R', 'R', '2024-10-02', 3, '2024-12-30', '2024-12-27', 'N', _binary 0x7465737465, 'Sim', NULL),
	(7, NULL, 2, 1, 2, 3, 4, 5, 'E', 'R', '2024-10-02', 3, '2024-11-26', '2024-11-23', 'N', _binary 0x4d616e7574656ec3a7c3a36f20646520726f74696e61206e61207265646520656cc3a9747269636120646f2067616c70c3a36f20646f20616c6d6f786172696661646f206461207361c3ba6465, 'Não', NULL),
	(8, 1, NULL, 7, 2, 5, 4, 5, 'R', 'R', '2024-10-02', 3, '2025-01-09', '2025-01-06', 'N', _binary 0x546573746520636f6d2067657261c3a7c3a36f20636f6d706574612064612070726576656e74697661, 'Sim', NULL),
	(9, 3, NULL, 2, 1, 8, 1, 5, 'R', 'P', '2024-10-02', 3, '2025-02-13', '2025-02-10', 'N', _binary 0x43686563616167656d20646f2061706172656c686f0d0a736567756e64612067657261c3a7c3a36f2064652070726576656e74697661, 'Sim', NULL),
	(10, 3, NULL, 3, 2, 8, 4, 5, 'R', 'S', '2024-10-04', 3, '2025-01-07', '2025-01-04', 'N', _binary 0x636865636167656d2064652074656e73c3a36f, 'Sim', NULL),
	(11, 3, NULL, 1, 5, 8, 9, 5, 'R', 'S', '2024-10-20', 3, '2024-11-22', '2024-11-19', 'N', _binary 0x5265766973c3a36f20646f204571756970616d656e746f, 'Sim', NULL),
	(12, 2, NULL, 3, 1, 3, 1, 5, 'R', 'R', '2024-10-24', 3, '2024-11-09', '2024-11-06', 'N', _binary 0x70726576656e74697661202e2e2e2e2e2e2e2e, 'Sim', 2),
	(13, 1, NULL, 3, 5, 2, 6, 5, 'R', 'P', '2024-10-26', 3, '2024-11-07', '2024-11-04', 'N', _binary 0x5665726966696361c3a7c3a36f20707265646974697661, 'Sim', 3),
	(4, 1, NULL, 3, 2, 2, 3, 5, 'R', 'R', '2024-10-01', 3, '2024-12-12', '2024-11-12', 'N', _binary 0x56617272656475726120646520616e7469207669727573, 'Não', NULL),
	(5, NULL, 2, 1, 2, 3, 3, 5, 'E', 'R', '2024-10-01', 3, '2024-11-24', '2024-11-21', 'N', _binary 0x496e737065c3a7c3a36f20456cc3a9747269636120646f207072c3a964696f0d0a736567756e64612067657261c3a7c3a36f2064652070726576656e7469766120636f6d2065737061c3a76f2066697369636f, 'Sim', NULL),
	(6, 1, NULL, 7, 2, 3, 4, 5, 'R', 'R', '2024-10-02', 3, '2024-12-30', '2024-12-27', 'N', _binary 0x7465737465, 'Sim', NULL),
	(7, NULL, 2, 1, 2, 3, 4, 5, 'E', 'R', '2024-10-02', 3, '2024-11-26', '2024-11-23', 'N', _binary 0x4d616e7574656ec3a7c3a36f20646520726f74696e61206e61207265646520656cc3a9747269636120646f2067616c70c3a36f20646f20616c6d6f786172696661646f206461207361c3ba6465, 'Não', NULL),
	(8, 1, NULL, 7, 2, 5, 4, 5, 'R', 'R', '2024-10-02', 3, '2025-01-09', '2025-01-06', 'N', _binary 0x546573746520636f6d2067657261c3a7c3a36f20636f6d706574612064612070726576656e74697661, 'Sim', NULL),
	(9, 3, NULL, 2, 1, 8, 1, 5, 'R', 'P', '2024-10-02', 3, '2025-02-13', '2025-02-10', 'N', _binary 0x43686563616167656d20646f2061706172656c686f0d0a736567756e64612067657261c3a7c3a36f2064652070726576656e74697661, 'Sim', NULL),
	(10, 3, NULL, 3, 2, 8, 4, 5, 'R', 'S', '2024-10-04', 3, '2025-01-07', '2025-01-04', 'N', _binary 0x636865636167656d2064652074656e73c3a36f, 'Sim', NULL),
	(14, 3, NULL, 1, 2, 3, 4, 5, 'R', 'R', '2024-12-20', 3, '2025-01-09', '2025-01-06', 'N', _binary 0x7465737465, 'Sim', 12),
	(15, 1, NULL, 7, 2, 8, 4, 5, 'R', 'R', '2025-03-05', 3, '2025-03-22', '2025-03-19', 'N', _binary 0x7465737465, 'Sim', 3),
	(16, NULL, 2, 7, 2, 3, 10, 5, 'E', 'R', '2025-03-05', 3, '2025-04-04', '2025-03-05', 'N', _binary 0x7465737465, 'Sim', 30);

-- Copiando estrutura para tabela gop.preventivas_checklist
CREATE TABLE IF NOT EXISTS `preventivas_checklist` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_check` int DEFAULT NULL,
  `id_preventiva` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_preventivas_checklist_checklist` (`id_check`),
  KEY `FK_preventivas_checklist_preventivas` (`id_preventiva`),
  CONSTRAINT `FK_preventivas_checklist_checklist` FOREIGN KEY (`id_check`) REFERENCES `checklist` (`id`),
  CONSTRAINT `FK_preventivas_checklist_preventivas` FOREIGN KEY (`id_preventiva`) REFERENCES `preventivas` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Copiando dados para a tabela gop.preventivas_checklist: ~2 rows (aproximadamente)
INSERT INTO `preventivas_checklist` (`id`, `id_check`, `id_preventiva`) VALUES
	(2, 1, 8),
	(5, 3, 8);

-- Copiando estrutura para tabela gop.preventivas_executores
CREATE TABLE IF NOT EXISTS `preventivas_executores` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_preventiva` int DEFAULT NULL,
  `id_executor` int DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `FK_preventivas_executores_preventivas` (`id_preventiva`) USING BTREE,
  KEY `FK_preventivas_executores_executores` (`id_executor`) USING BTREE,
  CONSTRAINT `FK_preventivas_executores_executores` FOREIGN KEY (`id_executor`) REFERENCES `executores` (`id`),
  CONSTRAINT `FK_preventivas_executores_preventivas` FOREIGN KEY (`id_preventiva`) REFERENCES `preventivas` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Copiando dados para a tabela gop.preventivas_executores: ~4 rows (aproximadamente)
INSERT INTO `preventivas_executores` (`id`, `id_preventiva`, `id_executor`) VALUES
	(12, 4, 6),
	(13, 4, 5),
	(14, 8, 5),
	(15, 8, 7);

-- Copiando estrutura para tabela gop.preventivas_ferramentas
CREATE TABLE IF NOT EXISTS `preventivas_ferramentas` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_ferramenta` int DEFAULT NULL,
  `id_preventiva` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK__ferramentas` (`id_ferramenta`),
  KEY `FK__preventivas` (`id_preventiva`),
  CONSTRAINT `FK__ferramentas` FOREIGN KEY (`id_ferramenta`) REFERENCES `ferramentas` (`id`),
  CONSTRAINT `FK__preventivas` FOREIGN KEY (`id_preventiva`) REFERENCES `preventivas` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Copiando dados para a tabela gop.preventivas_ferramentas: ~2 rows (aproximadamente)
INSERT INTO `preventivas_ferramentas` (`id`, `id_ferramenta`, `id_preventiva`) VALUES
	(1, 6, 8),
	(3, 1, 8);

-- Copiando estrutura para tabela gop.preventivas_materiais
CREATE TABLE IF NOT EXISTS `preventivas_materiais` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_preventiva` int DEFAULT NULL,
  `id_material` int DEFAULT NULL,
  `id_unidade` int DEFAULT NULL,
  `quantidade` double DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `FK_preventivas_materiais_materiais` (`id_material`) USING BTREE,
  KEY `FK_preventivas_materiais_unidades` (`id_unidade`) USING BTREE,
  KEY `FK_preventivas_materiais_prevntivas` (`id_preventiva`) USING BTREE,
  CONSTRAINT `FK_preventivas_materiais_materiais` FOREIGN KEY (`id_material`) REFERENCES `materiais` (`id`),
  CONSTRAINT `FK_preventivas_materiais_preventivas` FOREIGN KEY (`id_preventiva`) REFERENCES `preventivas` (`id`),
  CONSTRAINT `FK_preventivas_materiais_unidades` FOREIGN KEY (`id_unidade`) REFERENCES `unidades` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Copiando dados para a tabela gop.preventivas_materiais: ~3 rows (aproximadamente)
INSERT INTO `preventivas_materiais` (`id`, `id_preventiva`, `id_material`, `id_unidade`, `quantidade`) VALUES
	(16, 4, 2, 8, 15),
	(17, 8, 4, 10, 5),
	(18, 8, 2, 8, 120);

-- Copiando estrutura para tabela gop.preventivas_pop
CREATE TABLE IF NOT EXISTS `preventivas_pop` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_pop` int DEFAULT NULL,
  `id_preventiva` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_preventivas_pop_pops` (`id_pop`),
  KEY `FK_preventivas_pop_preventivas` (`id_preventiva`),
  CONSTRAINT `FK_preventivas_pop_pops` FOREIGN KEY (`id_pop`) REFERENCES `pops` (`id`),
  CONSTRAINT `FK_preventivas_pop_preventivas` FOREIGN KEY (`id_preventiva`) REFERENCES `preventivas` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Copiando dados para a tabela gop.preventivas_pop: ~2 rows (aproximadamente)
INSERT INTO `preventivas_pop` (`id`, `id_pop`, `id_preventiva`) VALUES
	(1, 2, 8),
	(3, 4, 8);

-- Copiando estrutura para tabela gop.recursos
CREATE TABLE IF NOT EXISTS `recursos` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_espacofisico` int NOT NULL DEFAULT '0',
  `id_fabricante` int NOT NULL DEFAULT '0',
  `id_fornecedor` int NOT NULL DEFAULT '0',
  `id_centrodecusto` int NOT NULL DEFAULT '0',
  `id_oficina` int NOT NULL DEFAULT '0',
  `id_setor` int NOT NULL DEFAULT '0',
  `id_marca` int NOT NULL DEFAULT '0',
  `id_tipo` int DEFAULT NULL,
  `descricao` varchar(150) NOT NULL,
  `patrimonio` varchar(20) NOT NULL,
  `modelo` varchar(90) NOT NULL,
  `numeroserie` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `estado` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `notafiscal` varchar(20) NOT NULL,
  `datacadastro` date NOT NULL,
  `datagarantia` date NOT NULL,
  `valoraquisicao` double NOT NULL DEFAULT '0',
  `valordepreciado` double DEFAULT '0',
  `ultimapreventiva` date DEFAULT NULL,
  `ultimamanutencao` date DEFAULT NULL,
  `dataaquisicao` date NOT NULL,
  `ativo` varchar(3) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `motivoinativo` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `reganvisa` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `tipo_comodato` char(1) DEFAULT NULL,
  `tipo_alugado` char(1) DEFAULT NULL,
  `tipo_medico` char(1) DEFAULT NULL,
  `empresa_locacao` varchar(100) DEFAULT NULL,
  `medico` varchar(100) DEFAULT NULL,
  `empresa_comodato` varchar(100) DEFAULT NULL,
  `mantenabilidade` char(1) DEFAULT NULL,
  `treinamento` char(1) DEFAULT NULL,
  `obs` blob,
  PRIMARY KEY (`id`),
  KEY `FK_recursos_espacos` (`id_espacofisico`),
  KEY `FK_recursos_fabricantes` (`id_fabricante`),
  KEY `FK_recursos_fornecedores` (`id_fornecedor`),
  KEY `FK_recursos_centrodecusto` (`id_centrodecusto`),
  KEY `FK_recursos_oficinas` (`id_oficina`),
  KEY `FK_recursos_setores` (`id_setor`),
  KEY `FK_recursos_marcas` (`id_marca`),
  KEY `FK_recursos_tipos` (`id_tipo`),
  CONSTRAINT `FK_recursos_centrodecusto` FOREIGN KEY (`id_centrodecusto`) REFERENCES `centrodecusto` (`id`),
  CONSTRAINT `FK_recursos_espacos` FOREIGN KEY (`id_espacofisico`) REFERENCES `espacos` (`id`),
  CONSTRAINT `FK_recursos_fabricantes` FOREIGN KEY (`id_fabricante`) REFERENCES `fabricantes` (`id`),
  CONSTRAINT `FK_recursos_fornecedores` FOREIGN KEY (`id_fornecedor`) REFERENCES `fornecedores` (`id`),
  CONSTRAINT `FK_recursos_marcas` FOREIGN KEY (`id_marca`) REFERENCES `marcas` (`id`),
  CONSTRAINT `FK_recursos_oficinas` FOREIGN KEY (`id_oficina`) REFERENCES `oficinas` (`id`),
  CONSTRAINT `FK_recursos_setores` FOREIGN KEY (`id_setor`) REFERENCES `setores` (`id`),
  CONSTRAINT `FK_recursos_tipos` FOREIGN KEY (`id_tipo`) REFERENCES `tipos` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Copiando dados para a tabela gop.recursos: ~3 rows (aproximadamente)
INSERT INTO `recursos` (`id`, `id_espacofisico`, `id_fabricante`, `id_fornecedor`, `id_centrodecusto`, `id_oficina`, `id_setor`, `id_marca`, `id_tipo`, `descricao`, `patrimonio`, `modelo`, `numeroserie`, `estado`, `notafiscal`, `datacadastro`, `datagarantia`, `valoraquisicao`, `valordepreciado`, `ultimapreventiva`, `ultimamanutencao`, `dataaquisicao`, `ativo`, `motivoinativo`, `reganvisa`, `tipo_comodato`, `tipo_alugado`, `tipo_medico`, `empresa_locacao`, `medico`, `empresa_comodato`, `mantenabilidade`, `treinamento`, `obs`) VALUES
	(1, 2, 3, 1, 3, 1, 1, 6, 1, 'computador DeskTop', '1222', 'asdA', '3423234', 'Razoável', '234', '2023-02-08', '2023-02-08', 3000, 306.33333333333, '2023-02-08', '2023-02-08', '2023-02-08', 'S', 'DDD', '3333', 'N', 'N', 'N', '', '', '', 'A', 'A', _binary ''),
	(2, 1, 3, 2, 2, 3, 1, 6, 1, 'Servidor Dell 15456', '54654654', 'ALtPLAN', '546546', 'Ótimo', '324444', '2009-02-23', '2023-02-09', 0, 0, '2023-02-09', '2023-02-09', '2023-02-09', 'S', '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
	(3, 1, 2, 2, 2, 1, 1, 6, 1, 'Estabilizador Z3', '84848484', 'ALtPLAN', '546546', 'Ótimo', '412324', '2023-09-02', '2023-02-09', 0, 1152.4166666666702, '2023-02-09', '2023-02-09', '2023-02-09', 'S', '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

-- Copiando estrutura para tabela gop.servico_instalacao
CREATE TABLE IF NOT EXISTS `servico_instalacao` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_usuario` int NOT NULL,
  `id_espaco` int NOT NULL,
  `id_oficina` int NOT NULL,
  `id_setor` int NOT NULL,
  `id_ordem` int NOT NULL,
  `data_abertura` date NOT NULL,
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `tipo` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `hora_abertura` time NOT NULL,
  `data_atualizacao` date NOT NULL,
  `hora_atualizacao` time NOT NULL,
  `data_limite` date NOT NULL,
  `descricao` blob NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_servico_instalacao_usuarios` (`id_usuario`),
  KEY `FK_servico_instalacao_espacos` (`id_espaco`),
  KEY `FK_servico_instalacao_oficinas` (`id_oficina`),
  KEY `FK_servico_instalacao_setores` (`id_setor`),
  CONSTRAINT `FK_servico_instalacao_espacos` FOREIGN KEY (`id_espaco`) REFERENCES `espacos` (`id`),
  CONSTRAINT `FK_servico_instalacao_oficinas` FOREIGN KEY (`id_oficina`) REFERENCES `oficinas` (`id`),
  CONSTRAINT `FK_servico_instalacao_setores` FOREIGN KEY (`id_setor`) REFERENCES `setores` (`id`),
  CONSTRAINT `FK_servico_instalacao_usuarios` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Copiando dados para a tabela gop.servico_instalacao: ~0 rows (aproximadamente)

-- Copiando estrutura para tabela gop.setores
CREATE TABLE IF NOT EXISTS `setores` (
  `id` int NOT NULL AUTO_INCREMENT,
  `descricao` varchar(120) NOT NULL,
  `id_centrodecusto` int NOT NULL,
  `Responsavel` varchar(120) NOT NULL DEFAULT '',
  `fone1` varchar(20) DEFAULT '',
  `fone2` varchar(20) DEFAULT '',
  `email` varchar(120) DEFAULT '',
  `prioritario` char(3) DEFAULT NULL,
  `nivelprioridade` char(2) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_setores_centrodecusto` (`id_centrodecusto`),
  CONSTRAINT `FK_setores_centrodecusto` FOREIGN KEY (`id_centrodecusto`) REFERENCES `centrodecusto` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Copiando dados para a tabela gop.setores: ~8 rows (aproximadamente)
INSERT INTO `setores` (`id`, `descricao`, `id_centrodecusto`, `Responsavel`, `fone1`, `fone2`, `email`, `prioritario`, `nivelprioridade`) VALUES
	(1, 'Poda e Corte de Árvores', 1, 'Prefeitura', '(31)3672-9844', '(42)3423-4234', '', 'NÃO', '4'),
	(3, 'Secretaria de Saúde', 2, 'Patricia', '(31) 3-3333', '', 'glaison26.queiroz@gmail.com', 'SIM', '1'),
	(4, 'Almoxarifado da Saúde', 2, 'Alexandra', '(31) 3672-7688', '', '', 'SIM', '1'),
	(6, 'CPLMS', 5, 'Glaison', '', '', '', 'SIM', '1'),
	(7, 'Patrimônio', 2, 'pms', '(31) 3672-7688', '', '', 'SIM', '1'),
	(8, 'Compras', 5, 'pms', '(31) 3672-7688', '', '', 'SIM', '1'),
	(9, 'Administração', 5, 'pms', '(31) 3672-7688', '', '', 'SIM', '1'),
	(10, 'Licitação', 5, 'pms', '(31) 3672-7688', '', '', 'SIM', '1'),
	(11, 'Planejamento', 2, 'pms', '(31) 3672-7688', '', '', 'SIM', '1');

-- Copiando estrutura para tabela gop.solicitacao
CREATE TABLE IF NOT EXISTS `solicitacao` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_setor` int DEFAULT NULL,
  `id_solicitante` int NOT NULL,
  `id_recursos` int DEFAULT NULL,
  `id_espaco` int DEFAULT NULL,
  `id_ocorrencia` int DEFAULT NULL,
  `data_abertura` date NOT NULL,
  `hora_abertura` time NOT NULL,
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `tipo` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `descricao` blob NOT NULL,
  `classificacao` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `id_ordem` int DEFAULT NULL,
  `prazo_data` date DEFAULT NULL,
  `prazo_hora` time DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_solicitacao_setores` (`id_setor`),
  KEY `FK_solicitacao_usuarios` (`id_solicitante`),
  KEY `FK_solicitacao_recursos` (`id_recursos`),
  KEY `FK_solicitacao_espacos` (`id_espaco`),
  KEY `FK_solicitacao_ocorrencias` (`id_ocorrencia`),
  CONSTRAINT `FK_solicitacao_espacos` FOREIGN KEY (`id_espaco`) REFERENCES `espacos` (`id`),
  CONSTRAINT `FK_solicitacao_ocorrencias` FOREIGN KEY (`id_ocorrencia`) REFERENCES `ocorrencias` (`id`),
  CONSTRAINT `FK_solicitacao_recursos` FOREIGN KEY (`id_recursos`) REFERENCES `recursos` (`id`),
  CONSTRAINT `FK_solicitacao_setores` FOREIGN KEY (`id_setor`) REFERENCES `setores` (`id`),
  CONSTRAINT `FK_solicitacao_usuarios` FOREIGN KEY (`id_solicitante`) REFERENCES `usuarios` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=84 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Copiando dados para a tabela gop.solicitacao: ~50 rows (aproximadamente)
INSERT INTO `solicitacao` (`id`, `id_setor`, `id_solicitante`, `id_recursos`, `id_espaco`, `id_ocorrencia`, `data_abertura`, `hora_abertura`, `status`, `tipo`, `descricao`, `classificacao`, `id_ordem`, `prazo_data`, `prazo_hora`) VALUES
	(31, 3, 16, 1, NULL, 2, '2024-09-18', '16:14:00', 'E', 'P', _binary 0x466f726d617461c3a7c3a36f20646f205043, 'R', NULL, NULL, NULL),
	(32, 3, 16, 1, NULL, 2, '2024-09-18', '16:31:00', 'E', 'P', _binary 0x466f6d617461c3a7c3a36f, 'R', NULL, NULL, NULL),
	(33, 1, 16, NULL, 1, 3, '2024-09-18', '16:34:00', 'E', 'P', _binary 0x746f6d61646173, 'E', NULL, NULL, NULL),
	(34, 3, 16, NULL, NULL, 5, '2024-09-18', '16:36:00', 'E', 'P', _binary 0x43726961c3a7c3a36f20646520636f6e746120646520656d61696c20207465737465407361626172612e636f6d2e6272, 'V', NULL, NULL, NULL),
	(35, 3, 16, NULL, NULL, 7, '2024-09-18', '20:13:00', 'E', 'P', _binary 0x43726961c3a7c3a36f20646520757375c3a172696f207061726120616365737361207061737461206461207361c3ba64650d0a0d0a4d617269612064652046c3a174696d61206d6174726963756c612030303039333933, 'V', NULL, NULL, NULL),
	(36, 3, 16, 3, NULL, 1, '2024-09-18', '20:36:00', 'E', 'P', _binary 0x496d70726573736f726120626f7272616e646f, 'R', NULL, NULL, NULL),
	(37, 1, 16, NULL, 1, 1, '2024-09-18', '20:39:00', 'E', 'P', _binary 0x496d70726573736f7261, 'E', NULL, NULL, NULL),
	(38, 1, 16, NULL, NULL, 2, '2024-09-18', '20:40:00', 'A', 'P', _binary 0x63726961c3a7c3a36f20646520656d61696c20706f6461407361626172612e6d672e676f762e6272, 'V', NULL, NULL, NULL),
	(39, 4, 16, 1, NULL, 3, '2024-10-02', '15:53:00', 'E', 'P', _binary 0x496e7374616c61c3a7c3a36f20646520546f6d61646120656cc3a97472696361, 'R', NULL, NULL, NULL),
	(40, 4, 16, NULL, NULL, 7, '2024-10-02', '16:03:00', 'A', 'P', _binary 0x557375c3a172696f206e6f766f206465202072656465, 'V', NULL, NULL, NULL),
	(41, 1, 16, 3, NULL, 2, '2024-10-08', '23:23:00', 'E', 'P', _binary 0x436f6d70757461646f722074726176616e646f20652070657264656e646f20636f6e6578c3a36f20636f6d20696e7465726e6574, 'R', NULL, NULL, NULL),
	(42, 3, 16, 2, NULL, 2, '2024-10-14', '23:51:00', 'E', 'P', _binary 0x6d616e7574656ec3a7c3a36f207063, 'R', 52, NULL, NULL),
	(43, 6, 16, NULL, NULL, 5, '2024-10-15', '00:27:00', 'A', 'P', _binary 0x43726961c3a7c3a36f20646520656d61696c, 'V', NULL, NULL, NULL),
	(44, 1, 16, NULL, NULL, 7, '2024-10-15', '00:30:00', 'A', 'P', _binary 0x557375c3a172696f2064652072656465, 'V', NULL, NULL, NULL),
	(45, 4, 16, NULL, NULL, 5, '2024-10-15', '00:31:00', 'A', 'P', _binary 0x686a68676a6b, 'V', NULL, NULL, NULL),
	(46, 4, 16, NULL, NULL, 5, '2024-10-15', '00:32:00', 'A', 'P', _binary 0x68686c686c6b, 'V', NULL, NULL, NULL),
	(47, 4, 16, NULL, NULL, 5, '2024-10-15', '00:36:00', 'A', 'P', _binary 0x6a686a686c6b6a686b, 'V', NULL, NULL, NULL),
	(48, 4, 16, NULL, NULL, 10, '2024-10-16', '22:17:00', 'A', 'P', _binary 0x446573637269c3a7c3a36f20646f20656d61696c3a, 'V', NULL, NULL, NULL),
	(49, 4, 16, NULL, NULL, 10, '2024-10-16', '23:23:00', 'A', 'P', _binary 0x4e6f6d6520436f6d706c65746f204d6172696120646520666174696d610d0a4dc3b364756c6f73207265637572736f732068756d616e6f73, 'V', NULL, NULL, NULL),
	(50, 4, 16, 1, NULL, 8, '2024-10-16', '23:32:00', 'E', 'P', _binary 0x746573746520636f6d207265637572736f, 'R', 66, NULL, NULL),
	(51, 4, 16, NULL, 1, 3, '2024-10-16', '23:35:00', 'A', 'P', _binary 0x54726f636120646520746f6d61646173, 'E', NULL, NULL, NULL),
	(52, 6, 16, 3, NULL, 3, '2024-10-16', '23:39:00', 'E', 'P', _binary 0x4d616e7574656ec3a7c3a36f206573746162696c697a61646f72, 'R', 65, NULL, NULL),
	(53, 8, 16, NULL, NULL, 10, '2024-10-20', '22:52:00', 'C', 'P', _binary 0x4e6f6d6520436f6d706c65746f203a204d617269612064612073696c76610d0a4dc3b364756c6f73203a20436f6d707261732c2070726f746f636f6c6f206520637265646f7265730d0a4350463a3639353531303232363533, 'V', 53, NULL, NULL),
	(54, 9, 16, 3, NULL, 3, '2024-10-24', '20:43:00', 'E', 'P', _binary 0x6d616e7574656ec3a7c3a36f20646520666f6e7465, 'R', 54, NULL, NULL),
	(55, 9, 16, NULL, NULL, 7, '2024-10-24', '21:12:00', 'A', 'P', _binary 0x4e6f6d6520646f205573756172696f206d617269612064612073696c76610d0a6d6174726963756c6120383834, 'V', NULL, NULL, NULL),
	(56, 9, 16, NULL, NULL, 5, '2024-10-29', '23:23:00', 'E', 'P', _binary 0x446573637269c3a7c3a36f20646f20656d61696c3a61646d4070617264696e692e636f6d2e6272, 'V', 120, NULL, NULL),
	(57, 8, 22, NULL, NULL, 5, '2024-11-10', '00:11:00', 'C', 'P', _binary 0x446573637269c3a7c3a36f20646f20656d61696c3a636f6d70726173407361626172612e6d672c676f762e6272, 'V', 64, NULL, NULL),
	(58, 7, 16, NULL, NULL, 7, '2024-11-10', '20:29:00', 'C', 'P', _binary 0x4e6f6d6520646f205573756172696f203a204d617269612e53696c76610d0a6d6174726963756c6120303339393339, 'V', 67, NULL, NULL),
	(59, 9, 21, NULL, 5, 3, '2024-11-15', '16:09:00', 'E', 'P', _binary 0x506173736167656d2064652063616265616d656e746f20456cc3a9747269636f, 'E', 68, NULL, NULL),
	(60, 9, 16, 3, NULL, 2, '2024-11-16', '08:56:00', 'E', 'P', _binary 0x7465737465, 'R', 69, NULL, NULL),
	(61, 9, 16, NULL, NULL, 7, '2024-11-16', '09:26:00', 'E', 'P', _binary 0x4e6f6d6520646f205573756172696f0d0a6d6174726963756c61, 'V', 70, NULL, NULL),
	(62, 7, 16, NULL, NULL, 5, '2025-02-09', '16:58:00', 'A', 'P', _binary 0x446573637269c3a7c3a36f20646f20456d61696c3a746573746540676d61696c, 'V', NULL, NULL, NULL),
	(63, 9, 16, NULL, NULL, 2, '2025-02-09', '17:01:00', 'A', 'P', _binary 0x7465737465, 'V', NULL, NULL, NULL),
	(64, 9, 16, NULL, NULL, 10, '2025-02-09', '17:11:00', 'A', 'P', _binary 0x4e6f6d6520436f6d706c65746f203a0d0a4dc3b364756c6f73203a0d0a4350463a, 'V', NULL, NULL, NULL),
	(65, 9, 16, NULL, NULL, 14, '2025-02-09', '17:28:00', 'A', 'P', _binary 0x6b686a6b6a686b6c6a, 'V', NULL, NULL, NULL),
	(66, 9, 22, NULL, NULL, 5, '2025-02-09', '17:40:00', 'A', 'P', _binary 0x446573637269c3a7c3a36f20646f20456d61696c3a, 'V', NULL, NULL, NULL),
	(67, 9, 22, NULL, NULL, 5, '2025-02-09', '17:48:00', 'A', 'P', _binary 0x446573637269c3a7c3a36f20646f20456d61696c3a, 'V', NULL, NULL, NULL),
	(68, 9, 22, NULL, NULL, 14, '2025-02-09', '17:49:00', 'A', 'P', _binary 0x7465737465, 'V', NULL, NULL, NULL),
	(69, 9, 22, NULL, NULL, 14, '2025-02-11', '22:24:00', 'E', 'P', _binary 0x7465737465, 'V', 121, '2026-01-29', '01:00:00'),
	(70, 9, 22, NULL, NULL, 5, '2025-02-11', '22:29:00', 'A', 'P', _binary 0x446573637269c3a7c3a36f20646f20456d61696c3a, 'V', NULL, NULL, NULL),
	(71, 9, 22, NULL, NULL, 5, '2025-02-11', '22:34:00', 'A', 'P', _binary 0x446573637269c3a7c3a36f20646f20456d61696c3a, 'V', NULL, NULL, NULL),
	(72, 9, 22, NULL, NULL, 5, '2025-02-11', '22:36:00', 'A', 'P', _binary 0x446573637269c3a7c3a36f20646f20456d61696c3a, 'V', NULL, NULL, NULL),
	(73, 9, 22, NULL, NULL, 5, '2025-02-11', '22:39:00', 'A', 'P', _binary 0x446573637269c3a7c3a36f20646f20456d61696c3a, 'V', NULL, NULL, NULL),
	(74, 9, 22, NULL, NULL, 5, '2025-02-11', '23:07:00', 'A', 'P', _binary 0x446573637269c3a7c3a36f20646f20456d61696c3a, 'V', NULL, NULL, NULL),
	(75, 9, 16, NULL, NULL, 10, '2025-02-11', '23:11:00', 'A', 'P', _binary 0x4e6f6d6520436f6d706c65746f203a0d0a4dc3b364756c6f73203a0d0a4350463a, 'V', NULL, NULL, NULL),
	(76, 9, 16, NULL, NULL, 10, '2025-02-11', '23:15:00', 'A', 'P', _binary 0x4e6f6d6520436f6d706c65746f203a0d0a4dc3b364756c6f73203a0d0a4350463a, 'V', NULL, NULL, NULL),
	(77, 9, 16, NULL, NULL, 5, '2025-02-11', '23:39:00', 'A', 'P', _binary 0x446573637269c3a7c3a36f20646f20456d61696c3a, 'V', NULL, NULL, NULL),
	(78, 9, 16, NULL, NULL, 14, '2025-03-03', '21:50:00', 'E', 'P', _binary 0x7465737465, 'V', 85, NULL, NULL),
	(79, 8, 22, NULL, NULL, 7, '2026-01-13', '20:12:00', 'C', 'U', _binary 0x4e6f6d6520646f20757375c3a172696f3a41726e616c20416e74756e65730d0a50617374612064652061636573736f3a4564756361c3a7c3a36f2065204e756765, 'V', 118, NULL, NULL),
	(80, 9, 16, NULL, NULL, 1, '2026-01-13', '20:31:00', 'E', 'P', _binary 0x4e6f2e20646f2053454c4220786335360d0a50726f626c656d61203a206d616e636861206e6120696d7072657373c3a36f, 'V', 119, NULL, NULL),
	(81, 7, 22, NULL, NULL, 10, '2026-01-31', '12:42:00', 'E', 'P', _binary 0x4e6f6d6520436f6d706c65746f203a5269636172646f204e6576730d0a4dc3b364756c6f73203a2070617472696d6f6e696f206520636f6d707261730d0a4350463a363336333636373733, 'V', 122, '2026-01-31', '14:00:00'),
	(82, 8, 16, NULL, NULL, 2, '2026-02-01', '16:27:00', 'A', 'U', _binary 0x50616472696d6f6e696f3a38303830393830390d0a446573637269c3a7c3a36f20646f2070726f626c656d61203a20436f6d70757461646f722074726176616e646f0d0a, 'V', NULL, NULL, NULL),
	(83, 8, 22, NULL, NULL, 1, '2026-02-04', '23:34:00', 'E', 'P', _binary 0x4e6f2e20646f2053454c423a207a6e333434630d0a50726f626c656d61203a4d616e63686173206e6120696d7072657373c3a36f, 'V', 123, '2026-02-05', '15:00:00');

-- Copiando estrutura para tabela gop.tempo_horas_mes
CREATE TABLE IF NOT EXISTS `tempo_horas_mes` (
  `id` int NOT NULL AUTO_INCREMENT,
  `horas` int DEFAULT NULL,
  `minutos` int DEFAULT NULL,
  `mes` int DEFAULT NULL,
  `tempo_grafico` double DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Copiando dados para a tabela gop.tempo_horas_mes: ~2 rows (aproximadamente)
INSERT INTO `tempo_horas_mes` (`id`, `horas`, `minutos`, `mes`, `tempo_grafico`) VALUES
	(32, 0, 0, 2, 0),
	(33, 2, 0, 1, 2);

-- Copiando estrutura para tabela gop.temp_custos
CREATE TABLE IF NOT EXISTS `temp_custos` (
  `id` int NOT NULL AUTO_INCREMENT,
  `descricao` varchar(120) DEFAULT NULL,
  `valor_material` double DEFAULT NULL,
  `valor_servico` double DEFAULT NULL,
  `valor_total` double DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=67 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Copiando dados para a tabela gop.temp_custos: ~3 rows (aproximadamente)
INSERT INTO `temp_custos` (`id`, `descricao`, `valor_material`, `valor_servico`, `valor_total`) VALUES
	(64, 'Manutenção Elétrica', 0, 0, 0),
	(65, 'Manutenção PC', 0, 283.33333333333, 283.33333333333),
	(66, 'Criação de Usuários de Rede', 0, 0, 0);

-- Copiando estrutura para tabela gop.temp_horas
CREATE TABLE IF NOT EXISTS `temp_horas` (
  `id` int NOT NULL AUTO_INCREMENT,
  `horas` int DEFAULT NULL,
  `minutos` int DEFAULT NULL,
  `executor` varchar(150) DEFAULT NULL,
  `tempo_grafico` double DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=130 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Copiando dados para a tabela gop.temp_horas: ~4 rows (aproximadamente)
INSERT INTO `temp_horas` (`id`, `horas`, `minutos`, `executor`, `tempo_grafico`) VALUES
	(126, 0, 20, 'Glaison Queiroz', 0.33333333333333),
	(127, 0, 20, 'Juliana Almeida', 0.33333333333333),
	(128, 2, 20, 'Maria da Silva', 2.3333333333333),
	(129, 2, 50, 'Wanderlei', 2.8333333333333);

-- Copiando estrutura para tabela gop.tipos
CREATE TABLE IF NOT EXISTS `tipos` (
  `id` int NOT NULL AUTO_INCREMENT,
  `descricao` varchar(150) DEFAULT NULL,
  `classe` varchar(70) DEFAULT NULL,
  `horas_operacao` int DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Copiando dados para a tabela gop.tipos: ~2 rows (aproximadamente)
INSERT INTO `tipos` (`id`, `descricao`, `classe`, `horas_operacao`) VALUES
	(1, 'Apoio', 'Operacional', 1400),
	(2, 'Clinicos', 'Clinico', 1200);

-- Copiando estrutura para tabela gop.unidades
CREATE TABLE IF NOT EXISTS `unidades` (
  `id` int NOT NULL AUTO_INCREMENT,
  `descricao` varchar(120) NOT NULL DEFAULT '0',
  `abreviatura` varchar(6) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Copiando dados para a tabela gop.unidades: ~9 rows (aproximadamente)
INSERT INTO `unidades` (`id`, `descricao`, `abreviatura`) VALUES
	(1, 'Metro Quadrado', 'M2'),
	(2, 'Centímetro', 'cm'),
	(3, 'Kilo', 'KG'),
	(4, 'Hora', 'H'),
	(5, 'Litro', 'LT'),
	(8, 'Unidade', 'UN'),
	(9, 'Metro Cúbico', 'M3'),
	(10, 'Metro', 'Metro'),
	(11, 'Milimetro', 'mm'),
	(13, 'Caixa', 'CX'),
	(14, 'Verba', 'vb');

-- Copiando estrutura para tabela gop.usuarios
CREATE TABLE IF NOT EXISTS `usuarios` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_perfil` int DEFAULT NULL,
  `id_setor` int DEFAULT NULL,
  `nome` char(120) DEFAULT NULL,
  `login` char(40) DEFAULT NULL,
  `senha` char(32) DEFAULT NULL,
  `ativo` char(1) DEFAULT NULL,
  `cpf` char(14) DEFAULT NULL,
  `tipo` char(15) DEFAULT NULL,
  `email` varchar(150) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_usuarios_setores` (`id_setor`),
  KEY `FK_usuarios_perfil_usuarios` (`id_perfil`),
  CONSTRAINT `FK_usuarios_perfil_usuarios` FOREIGN KEY (`id_perfil`) REFERENCES `perfil_usuarios` (`id`),
  CONSTRAINT `FK_usuarios_setores` FOREIGN KEY (`id_setor`) REFERENCES `setores` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Copiando dados para a tabela gop.usuarios: ~7 rows (aproximadamente)
INSERT INTO `usuarios` (`id`, `id_perfil`, `id_setor`, `nome`, `login`, `senha`, `ativo`, `cpf`, `tipo`, `email`) VALUES
	(16, 4, NULL, 'Glaison Queiroz', 'Glaison', 'VGFpb2JhQDMxNjMxOA==', 'S', '695.510.226-53', 'Administrador', 'glaison26.queiroz@gmail.com'),
	(17, 4, NULL, 'Manoel da Silva Braga', 'ManuelBraga', 'MTIzNDU2ZmRnZGZnc2Y=', 'N', '695.510.226-53', 'Administrador', NULL),
	(19, 4, NULL, 'Itamar Franco', 'Franco', 'OTk5OTk5OTk5', 'S', '695.510.226-53', 'Administrador', NULL),
	(21, 4, NULL, 'Manoel de Nobrega', 'Manoel', 'ODc2NTQzMjE=', 'S', '695.510.226-53', 'Operador', 'manoel@gmail.com'),
	(22, 4, NULL, 'Solicitante', 'Solicitante', 'VGFpb2JhQDMxNg==', 'S', '69551022653', 'Solicitante', 'glaison26.queiroz@gmail.com'),
	(23, 4, NULL, 'Adm', 'Adm', 'MTIzNDU2Nzg=', 'S', '69551022653', 'Administrador', 'glaison26.queiroz@gmail.com'),
	(24, 4, NULL, 'Maria Joana', 'MJ', 'MTIzNDU2Nzg=', 'S', '69551022653', 'Solicitante', 'glaison26.queiroz@gmail.com'),
	(25, 2, NULL, 'Oprador', 'Operador', 'T3BlcmFkb3JAMjAyNg==', 'S', '69551022653', 'Operador', 'glaison26.queiroz@gmail.com');

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
