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

-- Copiando dados para a tabela gop.centrodecusto: ~1 rows (aproximadamente)
INSERT INTO `centrodecusto` (`id`, `descricao`, `codigo`, `id_espacofisico`, `endereco`, `bairro`, `cidade`, `cep`, `fone1`, `fone2`, `email`, `responsavel`, `rateio`) VALUES
	(5, 'Modelo', NULL, 5, '', '', '', '', '(41) 23442-3424', '', '', 'modelo', 0);

-- Copiando estrutura para tabela gop.checklist
CREATE TABLE IF NOT EXISTS `checklist` (
  `id` int NOT NULL AUTO_INCREMENT,
  `descricao` varchar(150) NOT NULL DEFAULT '0',
  `descritivo` blob,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Copiando dados para a tabela gop.checklist: ~0 rows (aproximadamente)

-- Copiando estrutura para tabela gop.compras
CREATE TABLE IF NOT EXISTS `compras` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_fornecedor` int DEFAULT NULL,
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
  `descritivo` varchar(120) DEFAULT NULL,
  `valor_frete` double DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_compras_fornecedores` (`id_fornecedor`),
  CONSTRAINT `FK_compras_fornecedores` FOREIGN KEY (`id_fornecedor`) REFERENCES `fornecedores` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Copiando dados para a tabela gop.compras: ~0 rows (aproximadamente)

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
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Copiando dados para a tabela gop.compras_materiais: ~3 rows (aproximadamente)
INSERT INTO `compras_materiais` (`id`, `id_compra`, `id_material`, `id_unidade`, `quantidade`, `valor_unitario`, `valor_total`, `data_entrega`, `fator_conversao`, `receber`, `recebido`) VALUES
	(4, 3, 4, 8, 2, 15, 30, NULL, 1, NULL, NULL),
	(5, 3, 3, 8, 2, 20, 40, NULL, 1, NULL, NULL),
	(6, 3, 2, 8, 10, 17, 170, NULL, 1, NULL, NULL);

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
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Copiando dados para a tabela gop.configuracoes: ~0 rows (aproximadamente)
INSERT INTO `configuracoes` (`id`, `empresa`, `cnpj`, `responsavel`, `fone1`, `fone2`, `url`, `email_manutencao`, `emailcc_manutencao`, `emailco_manutencao`) VALUES
	(1, 'Prefeitura Municipal de Sabará', '22886816000105', 'Glaison', '(31) 3672-7688', '(31) 2121-2223', 'sabara.mg.gov.br', 'suporte@sabara.mg.gov.br', 'manutencao@sabara.mg.gov.br', 'glaison@sabara.mg.gov.br');

-- Copiando estrutura para tabela gop.contratos
CREATE TABLE IF NOT EXISTS `contratos` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_espacofisico` int DEFAULT NULL,
  `id_setor` int DEFAULT NULL,
  `id_centrocusto` int DEFAULT NULL,
  `empresa` varchar(200) DEFAULT NULL,
  `tipo_empresa` varchar(150) DEFAULT NULL,
  `vigencia` varchar(80) DEFAULT NULL,
  `inicio_contrato` date DEFAULT NULL,
  `termino_contrato` date DEFAULT NULL,
  `numero_contrato` varchar(30) DEFAULT NULL,
  `resp_contratado` varchar(100) DEFAULT NULL,
  `resp_contratante` varchar(100) DEFAULT NULL,
  `periodo_faturamento` varchar(100) DEFAULT NULL,
  `objeto` varchar(150) DEFAULT NULL,
  `email_operacional` varchar(180) DEFAULT NULL,
  `email_diretoria` varchar(180) DEFAULT NULL,
  `email_gerente` varchar(180) DEFAULT NULL,
  `valor_mensal` double DEFAULT NULL,
  `dados_iniciais` varchar(150) DEFAULT NULL,
  `denuncia` varchar(150) DEFAULT NULL,
  `reajuste` double DEFAULT NULL,
  `tipo_prestador_servico` char(1) DEFAULT NULL,
  `tipo_fornecedor_produtos` char(1) DEFAULT NULL,
  `tipo_producao_mes` char(1) DEFAULT NULL,
  `observacao` blob,
  PRIMARY KEY (`id`),
  KEY `FK_contratos_espacos` (`id_espacofisico`),
  KEY `FK_contratos_setores` (`id_setor`),
  KEY `FK_contratos_centrodecusto` (`id_centrocusto`),
  CONSTRAINT `FK_contratos_centrodecusto` FOREIGN KEY (`id_centrocusto`) REFERENCES `centrodecusto` (`id`),
  CONSTRAINT `FK_contratos_espacos` FOREIGN KEY (`id_espacofisico`) REFERENCES `espacos` (`id`),
  CONSTRAINT `FK_contratos_setores` FOREIGN KEY (`id_setor`) REFERENCES `setores` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Copiando dados para a tabela gop.contratos: ~0 rows (aproximadamente)

-- Copiando estrutura para tabela gop.contratos_lancamentos
CREATE TABLE IF NOT EXISTS `contratos_lancamentos` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_parametro` int DEFAULT NULL,
  `data` date DEFAULT NULL,
  `quantidade` double DEFAULT NULL,
  `valor` double DEFAULT NULL,
  `nota` varchar(30) DEFAULT NULL,
  `emissao` date DEFAULT NULL,
  `vencimento` date DEFAULT NULL,
  `cond_pagamento` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_contratos_lancamentos_contratos_parametros` (`id_parametro`),
  CONSTRAINT `FK_contratos_lancamentos_contratos_parametros` FOREIGN KEY (`id_parametro`) REFERENCES `contratos_parametros` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Copiando dados para a tabela gop.contratos_lancamentos: ~0 rows (aproximadamente)

-- Copiando estrutura para tabela gop.contratos_parametros
CREATE TABLE IF NOT EXISTS `contratos_parametros` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_unidade` int DEFAULT NULL,
  `id_contrato` int DEFAULT NULL,
  `descricao` varchar(150) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_contratos_parametros_contratos` (`id_contrato`),
  KEY `FK_contratos_parametros_unidades` (`id_unidade`),
  CONSTRAINT `FK_contratos_parametros_contratos` FOREIGN KEY (`id_contrato`) REFERENCES `contratos` (`id`),
  CONSTRAINT `FK_contratos_parametros_unidades` FOREIGN KEY (`id_unidade`) REFERENCES `unidades` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Copiando dados para a tabela gop.contratos_parametros: ~0 rows (aproximadamente)

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
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Copiando dados para a tabela gop.cotacao: ~0 rows (aproximadamente)

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

-- Copiando dados para a tabela gop.cotacao_fornecedor: ~0 rows (aproximadamente)

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Copiando dados para a tabela gop.cotacao_materiais: ~0 rows (aproximadamente)

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Copiando dados para a tabela gop.cotacao_materiais_fornecedor: ~0 rows (aproximadamente)

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
	(2, 'PLANEJAMENTO OPERACIONAL DE SERVIÇOS E OBRAS', _binary 0x506c616e656a616d656e746f204f7065726163696f6e616c206465205365727669c3a76f732065206f62726173),
	(4, 'Planejamento para Aquisição de Novos Servidores', _binary 0x417175697369c3a7c3a36f206465206e6f766f73207365727669646f726573207061726120736572656d0a7574696c697a61646f73206e6f202061726d617a656e616d656e746f206465206172717569766f732064612072656465),
	(5, 'Planejamento para Instalação de novos servidores', _binary 0x506c616e656a616d656e746f207061726120496e7374616c61c3a7c3a36f2064650a206e6f766f73207365727669646f726573);

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
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Copiando dados para a tabela gop.diretriz_estrategia: ~2 rows (aproximadamente)
INSERT INTO `diretriz_estrategia` (`id`, `id_estrategia`, `id_diretriz`) VALUES
	(1, 1, 2),
	(2, 2, 4);

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
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Copiando dados para a tabela gop.espacos: ~0 rows (aproximadamente)

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
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Copiando dados para a tabela gop.executores: ~0 rows (aproximadamente)

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
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Copiando dados para a tabela gop.fabricantes: ~0 rows (aproximadamente)

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
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Copiando dados para a tabela gop.ferramentas: ~1 rows (aproximadamente)

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
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Copiando dados para a tabela gop.fornecedores: ~0 rows (aproximadamente)

-- Copiando estrutura para tabela gop.funcoes
CREATE TABLE IF NOT EXISTS `funcoes` (
  `id` int NOT NULL AUTO_INCREMENT,
  `descricao` varchar(120) NOT NULL,
  `ValorHora` double DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Copiando dados para a tabela gop.funcoes: ~0 rows (aproximadamente)

-- Copiando estrutura para tabela gop.grupos
CREATE TABLE IF NOT EXISTS `grupos` (
  `id` int NOT NULL AUTO_INCREMENT,
  `descricao` varchar(120) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Copiando dados para a tabela gop.grupos: ~0 rows (aproximadamente)

-- Copiando estrutura para tabela gop.marcas
CREATE TABLE IF NOT EXISTS `marcas` (
  `id` int NOT NULL AUTO_INCREMENT,
  `descricao` varchar(120) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=99 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Copiando dados para a tabela gop.marcas: ~1 rows (aproximadamente)

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
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Copiando dados para a tabela gop.materiais: ~0 rows (aproximadamente)

-- Copiando estrutura para tabela gop.obras_grupo
CREATE TABLE IF NOT EXISTS `obras_grupo` (
  `id` int NOT NULL AUTO_INCREMENT,
  `descricao` varchar(150) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Copiando dados para a tabela gop.obras_grupo: ~0 rows (aproximadamente)

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Copiando dados para a tabela gop.obras_itens: ~0 rows (aproximadamente)

-- Copiando estrutura para tabela gop.ocorrencias
CREATE TABLE IF NOT EXISTS `ocorrencias` (
  `id` int NOT NULL AUTO_INCREMENT,
  `descricao` varchar(150) DEFAULT NULL,
  `texto` blob,
  `texto_fechamento` blob,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Copiando dados para a tabela gop.ocorrencias: ~1 rows (aproximadamente)
INSERT INTO `ocorrencias` (`id`, `descricao`, `texto`, `texto_fechamento`) VALUES
	(8, 'modelo de Ocorrência', _binary 0x6d6f64656c6f206465206162657274757261206465206368616d61646f, _binary 0x6d6f64656f20646520636f6e636c7573c3a36f206465206368616d61646f);

-- Copiando estrutura para tabela gop.oficinas
CREATE TABLE IF NOT EXISTS `oficinas` (
  `id` int NOT NULL AUTO_INCREMENT,
  `descricao` varchar(120) NOT NULL DEFAULT '0',
  `fone1` varchar(25) DEFAULT NULL,
  `fone2` varchar(25) DEFAULT NULL,
  `email` varchar(150) DEFAULT NULL,
  `responsavel` varchar(120) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Copiando dados para a tabela gop.oficinas: ~1 rows (aproximadamente)
INSERT INTO `oficinas` (`id`, `descricao`, `fone1`, `fone2`, `email`, `responsavel`) VALUES
	(1, 'Informática', '(31) 3672-7688', '(31) 9988-3883', 'microrede2@gmail.com', 'Israel');

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
  `id_executor_responsavel` int DEFAULT NULL,
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
  `motivo_cancelamen` blob,
  `hora_cancelamento` time DEFAULT NULL,
  `id_resp_cancelamento` int DEFAULT NULL,
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Copiando dados para a tabela gop.ordens: ~0 rows (aproximadamente)

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Copiando dados para a tabela gop.ordens_check: ~0 rows (aproximadamente)

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Copiando dados para a tabela gop.ordens_executores: ~0 rows (aproximadamente)

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Copiando dados para a tabela gop.ordens_ferramentas: ~0 rows (aproximadamente)

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
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Copiando dados para a tabela gop.ordens_imagens: ~0 rows (aproximadamente)

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Copiando dados para a tabela gop.ordens_materiais: ~0 rows (aproximadamente)

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Copiando dados para a tabela gop.ordens_pop: ~0 rows (aproximadamente)

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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Copiando dados para a tabela gop.ordens_suspensao: ~0 rows (aproximadamente)

-- Copiando estrutura para tabela gop.pa_diretrizes
CREATE TABLE IF NOT EXISTS `pa_diretrizes` (
  `id` int NOT NULL,
  `descricao` varchar(150) NOT NULL,
  `texto` blob,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Copiando dados para a tabela gop.pa_diretrizes: ~0 rows (aproximadamente)

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
  `cadastros_checklist` char(1) DEFAULT NULL,
  `cadastros_tipos` char(1) DEFAULT NULL,
  `servicos_solicitacoes` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `servicos_ordens` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `servicos_preventivas` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Copiando dados para a tabela gop.perfil_usuarios: ~1 rows (aproximadamente)
INSERT INTO `perfil_usuarios` (`id`, `descricao`, `cadastros_recursosfisicos`, `cadastros_espacosfisicos`, `cadastros_fornecedores`, `cadastros_fabricantes`, `cadastros_executores`, `cadastros_cargosfuncoes`, `cadastros_oficinas`, `cadastro_centrosdecusto`, `cadastros_setores`, `cadastros_ferramentas`, `cadastros_grupos`, `cadastros_marcas`, `cadastros_pop`, `cadastros_checklist`, `cadastros_tipos`, `servicos_solicitacoes`, `servicos_ordens`, `servicos_preventivas`, `servicos_ocorrencias_padroes`, `servicos_plano_acao`, `almoxarifado_cotacoes`, `almoxarifado_pedidodecompra`, `almoxarifado_materiais`, `almoxarifado_unidadesmedidas`, `indicadores_ocorrencias`, `indicadores_comparativos`, `custos_ocorrencias`, `custos_comparativos`, `custos`, `obras`) VALUES
	(1, 'Perfil padrão', 'S', 'S', 'S', 'S', 'S', 'S', 'S', 'S', 'S', 'S', 'S', 'S', 'S', 'S', 'S', 'S', 'S', 'S', 'S', 'N', 'S', 'S', 'S', 'S', 'S', 'S', 'S', 'S', NULL, NULL);

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

-- Copiando dados para a tabela gop.planejamento: ~0 rows (aproximadamente)
INSERT INTO `planejamento` (`id`, `id_setor`, `data`, `gerencia`, `descritivo`, `meta`) VALUES
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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Copiando dados para a tabela gop.planejamento_diretrizes: ~0 rows (aproximadamente)
INSERT INTO `planejamento_diretrizes` (`id`, `id_planejamento`, `id_diretriz`, `id_estrategia`, `prazo`, `local`, `responsavel`, `custo`, `situacao`, `motivo`, `metodologia`, `observacao`) VALUES
	(1, 2, 2, 1, '30 dias', 'Regional Ravena', 'Patricia', 1400, 'N', _binary 0x4f62726120646520636f6e74656ec3a7c3a36f, _binary 0x50616472c3a36f2049534f39303030, _binary 0x7465737465206465206469726574697661);

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
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Copiando dados para a tabela gop.pops: ~0 rows (aproximadamente)

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Copiando dados para a tabela gop.pop_anexos: ~0 rows (aproximadamente)

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
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Copiando dados para a tabela gop.preventivas: ~0 rows (aproximadamente)

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
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Copiando dados para a tabela gop.preventivas_checklist: ~0 rows (aproximadamente)

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

-- Copiando dados para a tabela gop.preventivas_executores: ~0 rows (aproximadamente)

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
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Copiando dados para a tabela gop.preventivas_ferramentas: ~0 rows (aproximadamente)

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

-- Copiando dados para a tabela gop.preventivas_materiais: ~1 rows (aproximadamente)

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
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Copiando dados para a tabela gop.preventivas_pop: ~0 rows (aproximadamente)

-- Copiando estrutura para tabela gop.recursos
CREATE TABLE IF NOT EXISTS `recursos` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_espacofisico` int NOT NULL DEFAULT '0',
  `id_fabricante` int NOT NULL DEFAULT '0',
  `id_fornecedor` int NOT NULL DEFAULT '0',
  `id_tipo` int NOT NULL DEFAULT '0',
  `id_centrodecusto` int NOT NULL DEFAULT '0',
  `id_oficina` int NOT NULL DEFAULT '0',
  `id_setor` int NOT NULL DEFAULT '0',
  `id_marca` int NOT NULL DEFAULT '0',
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
  `obs` blob,
  `tipo_comodato` char(1) DEFAULT NULL,
  `tipo_medico` char(1) DEFAULT NULL,
  `tipo_alugado` char(1) DEFAULT NULL,
  `empresa_locacao` varchar(100) DEFAULT NULL,
  `medico` varchar(100) DEFAULT NULL,
  `empresa_comodato` varchar(100) DEFAULT NULL,
  `mantenabilidade` char(1) DEFAULT NULL,
  `treinamento` char(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_recursos_espacos` (`id_espacofisico`),
  KEY `FK_recursos_fabricantes` (`id_fabricante`),
  KEY `FK_recursos_fornecedores` (`id_fornecedor`),
  KEY `FK_recursos_centrodecusto` (`id_centrodecusto`),
  KEY `FK_recursos_oficinas` (`id_oficina`),
  KEY `FK_recursos_setores` (`id_setor`),
  KEY `FK_recursos_marcas` (`id_marca`),
  KEY `FK_recursos_grupos` (`id_tipo`) USING BTREE,
  CONSTRAINT `FK_recursos_centrodecusto` FOREIGN KEY (`id_centrodecusto`) REFERENCES `centrodecusto` (`id`),
  CONSTRAINT `FK_recursos_espacos` FOREIGN KEY (`id_espacofisico`) REFERENCES `espacos` (`id`),
  CONSTRAINT `FK_recursos_fabricantes` FOREIGN KEY (`id_fabricante`) REFERENCES `fabricantes` (`id`),
  CONSTRAINT `FK_recursos_fornecedores` FOREIGN KEY (`id_fornecedor`) REFERENCES `fornecedores` (`id`),
  CONSTRAINT `FK_recursos_marcas` FOREIGN KEY (`id_marca`) REFERENCES `marcas` (`id`),
  CONSTRAINT `FK_recursos_oficinas` FOREIGN KEY (`id_oficina`) REFERENCES `oficinas` (`id`),
  CONSTRAINT `FK_recursos_setores` FOREIGN KEY (`id_setor`) REFERENCES `setores` (`id`),
  CONSTRAINT `FK_recursos_tipos` FOREIGN KEY (`id_tipo`) REFERENCES `tipos` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Copiando dados para a tabela gop.recursos: ~0 rows (aproximadamente)

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
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Copiando dados para a tabela gop.setores: ~0 rows (aproximadamente)
INSERT INTO `setores` (`id`, `descricao`, `id_centrodecusto`, `Responsavel`, `fone1`, `fone2`, `email`, `prioritario`, `nivelprioridade`) VALUES
	(5, 'Setor Modelo', 5, 'modelo', '(12) 34234-2342', '', '', 'SIM', '1');

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
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Copiando dados para a tabela gop.solicitacao: ~14 rows (aproximadamente)
INSERT INTO `solicitacao` (`id`, `id_setor`, `id_solicitante`, `id_recursos`, `id_espaco`, `id_ocorrencia`, `data_abertura`, `hora_abertura`, `status`, `tipo`, `descricao`, `classificacao`, `id_ordem`) VALUES
	(2, 5, 16, NULL, NULL, 8, '2025-02-05', '15:40:00', 'C', 'P', _binary 0x6d6f64656c6f, 'V', 38),
	(3, 5, 16, NULL, NULL, 8, '2025-02-05', '16:09:00', 'C', 'U', _binary 0x6d6f64656c6f0d0a54657374650d0a0d0a5465737465, 'V', 39),
	(4, 5, 16, NULL, NULL, 8, '2025-02-10', '08:26:00', 'C', 'P', _binary 0x6d6f64656c6f, 'V', 29),
	(5, 5, 16, NULL, NULL, 8, '2025-02-10', '08:41:00', 'C', 'P', _binary 0x6d6f64656c6f, 'V', 30),
	(6, 5, 16, NULL, NULL, 8, '2025-02-10', '09:03:00', 'C', 'P', _binary 0x6d6f64656c6f, 'V', 32),
	(7, 5, 16, NULL, NULL, 8, '2025-02-10', '09:26:00', 'C', 'P', _binary 0x6d6f64656c6f, 'V', 33),
	(8, 5, 16, NULL, NULL, 8, '2025-02-10', '09:46:00', 'C', 'P', _binary 0x6d6f64656c6f, 'V', 34),
	(9, 5, 16, NULL, NULL, 8, '2025-02-10', '10:09:00', 'C', 'P', _binary 0x6d6f64656c6f, 'V', 35),
	(10, 5, 16, NULL, NULL, 8, '2025-02-10', '10:10:00', 'C', 'P', _binary 0x6d6f64656c6f, 'V', 36),
	(11, 5, 16, NULL, NULL, 8, '2025-02-10', '10:11:00', 'C', 'P', _binary 0x6d6f64656c6f, 'V', 37),
	(12, 5, 16, NULL, NULL, 8, '2025-02-11', '10:11:00', 'C', 'P', _binary 0x6d6f64656c6f, 'V', 31),
	(13, 5, 16, NULL, NULL, 8, '2025-02-11', '23:07:00', 'E', 'P', _binary 0x6d6f64656c6f, 'V', 40),
	(14, 5, 16, NULL, NULL, 8, '2025-02-11', '23:21:00', 'A', 'P', _binary 0x6d6f64656c6f, 'V', NULL),
	(15, 5, 16, NULL, NULL, 8, '2025-02-11', '23:27:00', 'A', 'P', _binary 0x6d6f64656c6f, 'V', NULL),
	(16, 5, 16, NULL, NULL, 8, '2025-02-11', '23:29:00', 'A', 'P', _binary 0x6d6f64656c6f, 'V', NULL),
	(17, 5, 16, NULL, NULL, 8, '2025-03-05', '15:02:00', 'A', 'P', _binary 0x6d6f64656c6f, 'V', NULL);

-- Copiando estrutura para tabela gop.tempo_horas_mes
CREATE TABLE IF NOT EXISTS `tempo_horas_mes` (
  `id` int NOT NULL AUTO_INCREMENT,
  `horas` int DEFAULT NULL,
  `minutos` int DEFAULT NULL,
  `mes` int DEFAULT NULL,
  `tempo_grafico` double DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Copiando dados para a tabela gop.tempo_horas_mes: ~2 rows (aproximadamente)
INSERT INTO `tempo_horas_mes` (`id`, `horas`, `minutos`, `mes`, `tempo_grafico`) VALUES
	(18, 11, 30, 10, 11.5),
	(19, 2, 15, 11, 2.25);

-- Copiando estrutura para tabela gop.temp_custos
CREATE TABLE IF NOT EXISTS `temp_custos` (
  `id` int NOT NULL AUTO_INCREMENT,
  `valor_material` double DEFAULT NULL,
  `valor_servico` double DEFAULT NULL,
  `valor_total` double DEFAULT NULL,
  `descricao` varchar(120) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Copiando dados para a tabela gop.temp_custos: ~0 rows (aproximadamente)

-- Copiando estrutura para tabela gop.temp_horas
CREATE TABLE IF NOT EXISTS `temp_horas` (
  `id` int NOT NULL AUTO_INCREMENT,
  `horas` int DEFAULT NULL,
  `minutos` int DEFAULT NULL,
  `executor` varchar(150) DEFAULT NULL,
  `tempo_grafico` double DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=57 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Copiando dados para a tabela gop.temp_horas: ~3 rows (aproximadamente)
INSERT INTO `temp_horas` (`id`, `horas`, `minutos`, `executor`, `tempo_grafico`) VALUES
	(54, 8, 50, 'Glaison Queiroz', 8.8333333333333),
	(55, 13, 45, 'Juliana Almeida', 13.75),
	(56, 9, 60, 'Maria da Silva', 10);

-- Copiando estrutura para tabela gop.tipos
CREATE TABLE IF NOT EXISTS `tipos` (
  `id` int NOT NULL AUTO_INCREMENT,
  `descricao` varchar(150) DEFAULT NULL,
  `classe` varchar(70) DEFAULT NULL,
  `horas_operacao` int DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Copiando dados para a tabela gop.tipos: ~4 rows (aproximadamente)
INSERT INTO `tipos` (`id`, `descricao`, `classe`, `horas_operacao`) VALUES
	(1, 'Apoios', 'Infra Estrutura', 3000),
	(2, 'Aquecimento', 'Clinico', 400),
	(4, 'Computadores Pessoais (pc)', 'Operacional', 2000),
	(5, 'Equipamento Médicos', 'Clinico', 1396);

-- Copiando estrutura para tabela gop.unidades
CREATE TABLE IF NOT EXISTS `unidades` (
  `id` int NOT NULL AUTO_INCREMENT,
  `descricao` varchar(120) NOT NULL DEFAULT '0',
  `abreviatura` varchar(6) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Copiando dados para a tabela gop.unidades: ~8 rows (aproximadamente)
INSERT INTO `unidades` (`id`, `descricao`, `abreviatura`) VALUES
	(1, 'Metro Quadrado', 'M2'),
	(2, 'Centímetro', 'cm'),
	(3, 'Kilo', 'KG'),
	(4, 'Hora', 'H'),
	(5, 'Litro', 'LT'),
	(8, 'Unidade', 'UN'),
	(9, 'Metro Cúbico', 'M3'),
	(10, 'Metro', 'm'),
	(11, 'kilowatts', 'Kw'),
	(12, 'Quilowatt-hora (kWh)', 'KWh');

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
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Copiando dados para a tabela gop.usuarios: ~6 rows (aproximadamente)
INSERT INTO `usuarios` (`id`, `id_perfil`, `id_setor`, `nome`, `login`, `senha`, `ativo`, `cpf`, `tipo`, `email`) VALUES
	(16, 1, NULL, 'Glaison Queiroz', 'Glaison', 'Z29wQDIwMjU=', 'S', '695.510.226-53', 'Administrador', 'glaison26.queiroz@gmail.com'),
	(17, 1, NULL, 'Manoel da Silva Braga', 'ManuelBraga', 'MTIzNDU2ZmRnZGZnc2Y=', 'N', '695.510.226-53', 'Administrador', NULL),
	(19, 1, NULL, 'Itamar Franco', 'Franco', 'OTk5OTk5OTk5', 'S', '695.510.226-53', 'Administrador', NULL),
	(21, 1, NULL, 'Manoel de Nobrega', 'Manoel', 'dGFpb2JhMTIz', 'S', '695.510.226-53', 'Operador', 'manoel@gmail.com'),
	(22, 1, NULL, 'Solicitante', 'Solicitante', 'MTIzNDU2Nzg=', 'S', '69551022653', 'Solicitante', 'glaison26.queiroz@gmail.com'),
	(23, 1, NULL, 'Adm', 'Adm', 'MTIzNDU2Nzg=', 'S', '69551022653', 'Administrador', 'glaison26.queiroz@gmail.com');

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
