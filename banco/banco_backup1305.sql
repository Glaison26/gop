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
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Copiando dados para a tabela gop.centrodecusto: ~1 rows (aproximadamente)
INSERT INTO `centrodecusto` (`id`, `descricao`, `codigo`, `id_espacofisico`, `endereco`, `bairro`, `cidade`, `cep`, `fone1`, `fone2`, `email`, `responsavel`, `rateio`) VALUES
	(5, 'Modelo', NULL, 5, '', '', '', '', '(41) 23442-3424', '', '', 'modelo', 0),
	(6, 'Prefeitura Municipal de Sabará', NULL, 6, '', '', '', '', '', '', '', 'pms', 0);

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
  `id_cotacao_fornecedor` int DEFAULT NULL,
  `observacao` blob,
  PRIMARY KEY (`id`),
  KEY `FK_compras_fornecedores` (`id_fornecedor`),
  CONSTRAINT `FK_compras_fornecedores` FOREIGN KEY (`id_fornecedor`) REFERENCES `fornecedores` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Copiando dados para a tabela gop.compras: ~0 rows (aproximadamente)
INSERT INTO `compras` (`id`, `id_fornecedor`, `data`, `tipo`, `nota`, `condicoes_pag`, `vencimento`, `comprador`, `prazo`, `valor`, `status`, `tipo_compra`, `descritivo`, `valor_frete`, `id_cotacao_fornecedor`, `observacao`) VALUES
	(1, 4, '2026-05-08', 'Operacionais', '0000', '0000', '2026-05-08', '0000', '000', 0, 'C', 'M', 'Entrada de Tonner', 0, NULL, _binary ''),
	(2, 4, '2026-05-11', 'Operacionais', '0', '0', '2026-05-11', '0', '0', 0, 'C', 'M', 'Toner colorido para impressora', 0, NULL, _binary '');

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
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Copiando dados para a tabela gop.compras_materiais: ~6 rows (aproximadamente)
INSERT INTO `compras_materiais` (`id`, `id_compra`, `id_material`, `id_unidade`, `quantidade`, `valor_unitario`, `valor_total`, `data_entrega`, `fator_conversao`, `receber`, `recebido`) VALUES
	(4, 3, 4, 8, 2, 15, 30, NULL, 1, NULL, NULL),
	(5, 3, 3, 8, 2, 20, 40, NULL, 1, NULL, NULL),
	(6, 3, 2, 8, 10, 17, 170, NULL, 1, NULL, NULL),
	(7, 1, 4, 8, 1, 0, 0, NULL, 1, 'S', 'S'),
	(8, 2, 5, 8, 2, 0, 0, NULL, 1, 'S', 'S'),
	(9, 2, 4, 8, 2, 0, 0, NULL, 1, 'S', 'S');

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
  `email_host` varchar(20) DEFAULT NULL,
  `porta_smtp` varchar(11) DEFAULT NULL,
  `senha_email` varchar(20) DEFAULT NULL,
  `solicitacao_recursos` char(1) DEFAULT NULL,
  `solicitacao_espacos` char(1) DEFAULT NULL,
  `solicitacao_avulsa` char(1) DEFAULT NULL,
  `tempo_atualizacao_menu` int DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Copiando dados para a tabela gop.configuracoes: ~1 rows (aproximadamente)
INSERT INTO `configuracoes` (`id`, `empresa`, `cnpj`, `responsavel`, `fone1`, `fone2`, `url`, `email_manutencao`, `emailcc_manutencao`, `emailco_manutencao`, `email_envio`, `email_host`, `porta_smtp`, `senha_email`, `solicitacao_recursos`, `solicitacao_espacos`, `solicitacao_avulsa`, `tempo_atualizacao_menu`) VALUES
	(1, 'Prefeitura Municipal de Sabará', '22886816000105', 'Glaison', '(31) 3672-7688', '(31) 2121-2223', 'sabara.mg.gov.br', 'suporte@sabara.mg.gov.br', 'manutencao@sabara.mg.gov.br', 'glaison@sabara.mg.gov.br', 'glaison26.queiroz@gmail.com', 'smtp.gmail.com', '465', 'qypq xjmy xmmu uoso', 'N', 'N', 'S', 5);

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
  `vencedor` char(3) DEFAULT NULL,
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
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Copiando dados para a tabela gop.espacos: ~0 rows (aproximadamente)
INSERT INTO `espacos` (`id`, `descricao`, `tipo`, `medida`, `endereco`, `bairro`, `cidade`, `cep`, `responsavel`, `email`, `fone1`, `fone2`) VALUES
	(6, 'Prefeitura Municipal de Sabará', 'Instalação', '', 'Rua Comendador Viana 122', '--', '--', '34505480', 'Glaison', 'teste@gmail.com', '', '');

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
  `ativo` char(3) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_executores_oficinas` (`id_oficina`),
  KEY `FK_executores_funcoes` (`id_funcao`),
  CONSTRAINT `FK_executores_funcoes` FOREIGN KEY (`id_funcao`) REFERENCES `funcoes` (`id`),
  CONSTRAINT `FK_executores_oficinas` FOREIGN KEY (`id_oficina`) REFERENCES `oficinas` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Copiando dados para a tabela gop.executores: ~4 rows (aproximadamente)
INSERT INTO `executores` (`id`, `id_oficina`, `id_funcao`, `nome`, `endereco`, `bairro`, `cep`, `cidade`, `uf`, `contato`, `tipo`, `cpf_cnpj`, `email`, `url`, `fone1`, `fone2`, `fone3`, `salario`, `horastrab`, `valorhora`, `escolaridade`, `formacao`, `obs`, `ativo`) VALUES
	(7, 1, 16, 'Glaison Queiroz', 'Rua da Intendencia 316', 'Centro', '34505480', 'Sabará', 'MG', '', 'F', '695.510.226-53', '', '', '(31) 3672-7688', '', '', 0, 0, 0, 'Primário', '', _binary '', 'Sim'),
	(8, 26, 8, 'Jerônimo Mayer dos Santos', 'Rua Marques de Sapucai,179', 'Centro', '34505480', 'Sabará', 'MG', '', 'F', '79017711604', 'manutencao@sabara.mg.gov.br', '', '(31) 3672-7688', '', '', 0, 0, 0, 'Primário', '', _binary '', 'Sim'),
	(9, 27, 8, 'Wellington Alves Jardim da Silva', 'Rua Comendador Viana 122', 'Centro', '34505480', 'Sabará', 'MG', '', 'F', '790.177.116-04', 'manutencao@sabara.mg.gov.br', '', '(31) 3672-7688', '', '', 0, 0, 0, 'Primário', '', _binary '', 'Sim'),
	(10, 26, 8, 'Edilson Fernandes da Cruz', 'Rua Marques de Sapucai,179', 'Centro', '34505480', 'Sabará', 'MG', '', 'F', '073.641.816-44', 'manutencao@sabara.mg.gov.br', '', '(31) 3672-7688', '', '', 0, 0, 0, '', '', _binary '', 'Sim'),
	(11, 1, 8, 'Jedean Moisés do Carmo', 'Rua Marques de Sapucaí 197', 'Centro', '34505480', 'Sabará', 'MG', '', 'F', '040.710.556-50', 'jedean@sabara.mg.gov.br', '', '(31) 3672-7688', '', '', 0, 0, 0, '', '', _binary '', 'Sim'),
	(12, 26, 8, 'Lucio Machado', 'Rua Marques de Sapucai,179', 'Centro', '34505480', 'Sabará', 'MG', '', 'F', '031.532.486-48', 'manutencao@sabara.mg.gov.br', '', '(31) 3672-7688', '', '', 0, 0, 0, '', '', _binary '', 'Sim');

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
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Copiando dados para a tabela gop.fabricantes: ~7 rows (aproximadamente)
INSERT INTO `fabricantes` (`id`, `descricao`, `razaosocial`, `tipo`, `cep`, `endereco`, `bairro`, `cidade`, `estado`, `cnpj_cpf`, `insc_estad`, `insc_munic`, `fone1`, `fone2`, `contato`, `email`, `url`, `obs`) VALUES
	(5, 'Dell', 'Dell Computadores', 'Física', '', '', '', '', 'MG', '695.510.226-53', '', '', '', '', 'Glaison', '', '', _binary ''),
	(6, 'Lenovo', 'Lenovo', 'Juridica', '', '', '', '', 'MG', '../-', '', '', '', '', '', '', '', _binary ''),
	(7, 'Positivo', 'Positivo', 'Juridica', '', '', '', '', 'MG', '../-', '', '', '', '', '', '', '', _binary ''),
	(8, 'Acer', 'Acer', 'Juridica', '', '', '', '', 'MG', '../-', '', '', '', '', '', '', '', _binary ''),
	(9, 'HP', 'HP', 'Juridica', '', '', '', '', 'MG', '../-', '', '', '', '', '', '', '', _binary ''),
	(10, 'GigaByte', 'GigaByte', 'Juridica', '', '', '', '', 'MG', '../-', '', '', '', '', '', '', '', _binary ''),
	(11, 'Samsung', 'Samsung', 'Juridica', '', '', '', '', 'MG', '../-', '', '', '', '', '', '', '', _binary ''),
	(12, 'Sony Vaio', 'Sony Vaio', 'Juridica', '', '', '', '', 'MG', '../-', '', '', '', '', '', '', '', _binary '');

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
  CONSTRAINT `FK_fornecedores_grupos_fonecedores` FOREIGN KEY (`id_grupo`) REFERENCES `grupos_fornecedores` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Copiando dados para a tabela gop.fornecedores: ~0 rows (aproximadamente)
INSERT INTO `fornecedores` (`id`, `id_grupo`, `descricao`, `razaosocial`, `cnpj_cpf`, `insc_estad`, `insc_munic`, `tipo`, `endereco`, `bairro`, `cep`, `cidade`, `estado`, `fone1`, `fone2`, `email`, `site`, `contato`, `obs`) VALUES
	(3, 3, 'Fornecedor de Computadores', 'Fornecedor de Computadores', '695.510.226-53', '', '', 'Física', '', '', '', '', 'MG', '(31) 98426-2508', '', '', '', 'Glaison', _binary ''),
	(4, 3, 'SELBETTI GESTÃO DE DOCUMENTOS S.A.', 'SELBETTI GESTÃO DE DOCUMENTOS S.A.', '83..48.3.2/30.0-00', '', '', 'Juridica', '', '', '', '', 'MG', '(31) 3672-7688', '', '', '', 'Eliezer', _binary '');

-- Copiando estrutura para tabela gop.funcoes
CREATE TABLE IF NOT EXISTS `funcoes` (
  `id` int NOT NULL AUTO_INCREMENT,
  `descricao` varchar(120) NOT NULL,
  `ValorHora` double DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Copiando dados para a tabela gop.funcoes: ~3 rows (aproximadamente)
INSERT INTO `funcoes` (`id`, `descricao`, `ValorHora`) VALUES
	(8, 'Supervisor de Sistemas', 0),
	(9, 'Técnico em Eletrônica', 0),
	(10, 'Técnico em Informática', 0),
	(16, 'Programador de Sistemas', 0),
	(17, 'Estagiário', 0);

-- Copiando estrutura para tabela gop.grupos
CREATE TABLE IF NOT EXISTS `grupos` (
  `id` int NOT NULL AUTO_INCREMENT,
  `descricao` varchar(120) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Copiando dados para a tabela gop.grupos: ~0 rows (aproximadamente)
INSERT INTO `grupos` (`id`, `descricao`) VALUES
	(13, 'Insumos de Informática');

-- Copiando estrutura para tabela gop.grupos_fornecedores
CREATE TABLE IF NOT EXISTS `grupos_fornecedores` (
  `id` int NOT NULL AUTO_INCREMENT,
  `descricao` varchar(140) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Copiando dados para a tabela gop.grupos_fornecedores: ~3 rows (aproximadamente)
INSERT INTO `grupos_fornecedores` (`id`, `descricao`) VALUES
	(1, 'Material de Construção'),
	(2, 'Materiais Elétricos'),
	(3, 'Equipamentos de Informática');

-- Copiando estrutura para tabela gop.marcas
CREATE TABLE IF NOT EXISTS `marcas` (
  `id` int NOT NULL AUTO_INCREMENT,
  `descricao` varchar(120) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=116 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Copiando dados para a tabela gop.marcas: ~15 rows (aproximadamente)
INSERT INTO `marcas` (`id`, `descricao`) VALUES
	(99, 'Dell'),
	(100, 'Positivo'),
	(101, 'Acer'),
	(102, 'HP'),
	(103, 'Ricoh'),
	(104, 'Samsung'),
	(105, 'IntelBras'),
	(106, 'Compaq'),
	(107, 'Toshiba'),
	(108, 'Epson'),
	(109, 'Apple'),
	(110, 'Lenovo'),
	(111, 'ASUS'),
	(112, 'LG'),
	(113, 'Multilazer'),
	(114, 'VAIO'),
	(115, 'GIGABYTE');

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
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Copiando dados para a tabela gop.materiais: ~7 rows (aproximadamente)
INSERT INTO `materiais` (`id`, `descricao`, `id_grupo`, `id_marca`, `custo`, `qtdmin`, `qtdmax`, `id_unidadeEntrada`, `id_unidadeSaida`, `fator`, `ultimasaida`, `ultimaentrada`, `data_validade`, `quantidadeatual`, `obs`) VALUES
	(4, 'Toner Ricoh C2000 Preto', 13, 103, 0, 2, 4, 8, 8, 1, '2026-04-27', '2026-05-11', '2026-04-27', 2, _binary 0x20),
	(5, 'Toner Ricoh C2000 Amarelo', 13, 103, 0, 2, 4, 8, 8, 1, '2026-04-27', '2026-05-11', '2026-04-27', 6, _binary ''),
	(6, 'Toner Ricoh C2000 Ciano', 13, 103, 0, 2, 4, 8, 8, 1, '2026-04-27', '2026-04-27', '2026-04-27', 2, _binary 0x20),
	(7, 'Toner Ricoh C2000 Margenta', 13, 103, 0, 2, 4, 8, 8, 1, '2026-04-27', '2026-04-27', '2026-04-27', 0, _binary 0x20),
	(8, 'Ricoh IM 430 Preto', 13, 103, 0, 4, 40, 8, 8, 1, '2026-04-27', '2026-04-27', '2026-04-27', 37, _binary 0x2020),
	(9, 'Toner 311 cp Preto', 13, 103, 0, 2, 10, 8, 8, 1, '2026-04-28', '2026-04-28', '2026-04-28', 2, _binary 0x2020),
	(10, 'Toner 601 / 501 Preto', 13, 103, 0, 2, 10, 8, 8, 1, '2026-04-28', '2026-04-28', '2026-04-28', 4, _binary 0x2020);

-- Copiando estrutura para tabela gop.mensagens
CREATE TABLE IF NOT EXISTS `mensagens` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_solicitacao` int DEFAULT NULL,
  `id_usuario` int DEFAULT NULL,
  `mensagem` blob,
  `tipo` char(1) DEFAULT NULL,
  `data` date DEFAULT NULL,
  `hora` time DEFAULT NULL,
  `status` char(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_menssagens_solicitacao` (`id_solicitacao`),
  KEY `FK_menssagens_usuarios` (`id_usuario`),
  CONSTRAINT `FK_menssagens_solicitacao` FOREIGN KEY (`id_solicitacao`) REFERENCES `solicitacao` (`id`),
  CONSTRAINT `FK_menssagens_usuarios` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Copiando dados para a tabela gop.mensagens: ~3 rows (aproximadamente)
INSERT INTO `mensagens` (`id`, `id_solicitacao`, `id_usuario`, `mensagem`, `tipo`, `data`, `hora`, `status`) VALUES
	(2, 66, 16, _binary 0x7465737465, '0', '2026-04-03', '09:59:24', 'N'),
	(3, 138, 16, _binary 0x7465737465, '0', '2026-05-08', '14:48:37', 'N'),
	(4, 138, 16, _binary 0x7465737465, '0', '2026-05-08', '14:58:06', 'N');

-- Copiando estrutura para tabela gop.obra
CREATE TABLE IF NOT EXISTS `obra` (
  `id` int NOT NULL AUTO_INCREMENT,
  `descricao` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `observacao` blob,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Copiando dados para a tabela gop.obra: ~0 rows (aproximadamente)
INSERT INTO `obra` (`id`, `descricao`, `observacao`) VALUES
	(6, 'Revitalização de fachada', _binary 0x5265766974616c697a61c3a7c3a36f2064612066616368616461207072696e636970616c20646f207072c3a964696f);

-- Copiando estrutura para tabela gop.obras_grupo
CREATE TABLE IF NOT EXISTS `obras_grupo` (
  `id` int NOT NULL AUTO_INCREMENT,
  `descricao` varchar(150) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Copiando dados para a tabela gop.obras_grupo: ~0 rows (aproximadamente)
INSERT INTO `obras_grupo` (`id`, `descricao`) VALUES
	(1, 'Marcenaria');

-- Copiando estrutura para tabela gop.obras_insumos
CREATE TABLE IF NOT EXISTS `obras_insumos` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_item` int DEFAULT NULL,
  `id_obra` int DEFAULT NULL,
  `id_unidade` int DEFAULT NULL,
  `quantidade` int DEFAULT NULL,
  `valor_maodeobra` double DEFAULT NULL,
  `valor_material` double DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `FK_obras_insumos_obras_itens` (`id_item`) USING BTREE,
  KEY `FK_obras_insumos_obra` (`id_obra`) USING BTREE,
  KEY `FK_obras_insumos_unidades` (`id_unidade`) USING BTREE,
  CONSTRAINT `FK_obras_insumos_obra` FOREIGN KEY (`id_obra`) REFERENCES `obra` (`id`),
  CONSTRAINT `FK_obras_insumos_obras_itens` FOREIGN KEY (`id_item`) REFERENCES `obras_itens` (`id`),
  CONSTRAINT `FK_obras_insumos_unidades` FOREIGN KEY (`id_unidade`) REFERENCES `unidades` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Copiando dados para a tabela gop.obras_insumos: ~0 rows (aproximadamente)

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
  `id_tipo_ocorrencia` int DEFAULT NULL,
  `texto` blob,
  `texto_fechamento` blob,
  `tempo_minuto` int DEFAULT NULL,
  `tempo_hora` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_ocorrencias_tipo_ocorrencia` (`id_tipo_ocorrencia`),
  CONSTRAINT `FK_ocorrencias_tipo_ocorrencia` FOREIGN KEY (`id_tipo_ocorrencia`) REFERENCES `tipo_ocorrencia` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=79 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Copiando dados para a tabela gop.ocorrencias: ~44 rows (aproximadamente)
INSERT INTO `ocorrencias` (`id`, `descricao`, `id_tipo_ocorrencia`, `texto`, `texto_fechamento`, `tempo_minuto`, `tempo_hora`) VALUES
	(8, 'Desktop - Formatação de Computador', 2, _binary 0x557375c3a172696f203a0d0a50617472696d6f6e696f3a0d0a0d0a446573637269c3a7c3a36f20646f2070726f626c656d613a, _binary 0x4f627365727661c3a7c3b56573, 0, 72),
	(9, 'Desktop - Solicitação de Novo Computador', 2, _binary 0x757375c3a172696f203a0d0a41746976696461646520612073657220657865637574616461203a, _binary '', 0, 72),
	(10, 'Criação de Conta de e-mail', 5, _binary 0x446573637269c3a7c3a36f20646f20652d6d61696c202865782e203c64657363726963616f3e407361626172612e6d672e676f762e62723a0d0a526573706f6e73c3a176656c203a, _binary 0x446573637269c3a7c3a36f20646f20652d6d61696c3a0d0a53656e686120696e696369616f203a, 0, 2),
	(11, 'Bloqueio/Exclusão de Conta de e-mail', 5, _binary 0x446573637269c3a7c3a36f20646f20652d6d61696c3a0d0a6d6f7469766f3a0d0a526573706f6e73c3a176656c203a, _binary '', 0, 2),
	(12, 'Zerar número do Microsoft Authenticator vinculado ao e-mail', 5, _binary 0x446573637269c3a7c3a36f20646f20652d6d61696c203a0d0a526573706f6e736176656c203a, _binary '', 0, 2),
	(13, 'Redefinição de senha de e-mail', 5, _binary 0x446573637269c3a7c3a36f20646f20652d6d61696c3a0d0a526573706f6e73c3a176656c203a, _binary 0x53656e6861207265646566696e6964612070617261203a, 0, 2),
	(14, 'Manutenção de Cameras', 6, _binary 0x4c6f63616c697a61c3a7c3a36f2064612063c3a26d657261203a0d0a446573637269c3a7c3a36f20646f2070726f626c656d61206e612043c3a26d657261203a, _binary '', 0, 48),
	(15, 'Sistema Moderna - Criação de Usuário', 10, _binary 0x4e6f6d6520646f20757375c3a172696f203a0d0a6ec3ba6d65726f20646f20435046203a0d0a4d6f64756c6f7320717565206972c3a120616365737361722028636f6d707261732c206573746f7175652c20636f6e746162696c69646164652c2070726567c3a36f2c20637265646f7265732c2066726f7461732c20707265737461c3a7c3a36f20646520636f6e7461732c2070617472696dc3b46e696f203a0d0a0d0a, _binary 0x557375c3a172696f2064652041636573736f203a0d0a53656e68612064652041636573736f203a0d0a0d0a557375c3a172696f20646f287329206dc3b364756c6f287329203a0d0a53656e686120646f287329206dc3b364756c6f287329203a, 0, 2),
	(16, 'Sistema Moderna - Redefinir Senha', 10, _binary 0x5175616c206f206c6f67696e20646f20757375c3a172696f3f203a, _binary 0x4e6f76612073656e6861207265646566696e696461203a, 30, 0),
	(17, 'Sistema Moderna - Bloqueiro de usuário', 10, _binary 0x5175616c206f20557375c3a172696f203f0d0a4d6f7469766f2064612061c3a7c3a36f3a, _binary '', 30, 0),
	(19, 'Desktop - Lentidão do desktop', 2, _binary 0x50617472696dc3b56e696f20646f20436f6d70757461646f72203a0d0a557375c3a172696f3a, _binary '', 0, 48),
	(20, 'Desktop - Não liga', 2, _binary 0x50617472696dc3b46e696f203a, _binary '', 0, 48),
	(21, 'Desktop - Tela azul', 2, _binary 0x50617472696dc3b46e696f203a0d0a, _binary '', 0, 48),
	(22, 'Desktop - Travamento', 2, _binary 0x50617472696dc3b46e696f203a0d0a, _binary '', 0, 48),
	(23, 'Desktop - Instalação e Desinstalação', 2, _binary 0x50617472696d6f6e696f3a0d0a, _binary '', 0, 2),
	(24, 'Desktop - Incluir desktop na rede', 2, _binary 0x50617472696dc3b46e696f203a, _binary '', 0, 24),
	(25, 'Monitor - Não está Ligando', 11, _binary 0x50617472696dc3b46e696f203a0d0a636865636f75206361626f7320646520656e6572676961202873696d2f6ec3a36f293f, _binary '', 0, 48),
	(26, 'Monitor - Sem Imagem', 11, _binary 0x50617472696dc3b46e696f203a0d0a436865636f75206361626f7320646520656e65726769612065206461646f73202873696d2f6ec3a36f29, _binary '', 0, 48),
	(27, 'Aquisição de Software', 9, _binary 0x45737065636966696361c3a7c3a36f20646f20736f6674776172652061207365722061647175697269646f203a, _binary '', 0, 72),
	(28, 'Instalação de Software', 9, _binary 0x506f73737569204c6963656ec3a7612873696d2f6ec3a36f29203f0d0a446573637269c3a7c3a36f20646f20736f66747761726520612073657220696e7374616c61646f3a, _binary '', 0, 2),
	(29, 'Desenvolvimento de Software', 9, _binary 0x446573637269c3a7c3a36f20646f20536f66747761726520612073657220646573656e766f6c7669646f3a, _binary '', 0, 300),
	(30, 'Solicitação de novo Mouse', 12, _binary 0x50617472696dc3b46e696f20646f20636f6d70757461646f72206f6e646520736572c3a1207574696c697a61646f3a, _binary '', 0, 24),
	(31, 'Substituição de Mouse', 12, _binary 0x50617472696dc3b46e696f20646f20636f6d70757461646f72206f6e646520686176657261206120737562737469747569c3a7c3a36f203a0d0a, _binary '', 0, 24),
	(32, 'Configuração de Teclado', 13, _binary 0x50617472696dc3b46e696f20646f20636f6d70757461646f72206f6e646520c3a9207574696c697a61646f203f, _binary '', 0, 24),
	(33, 'Solicitação de novo teclado', 13, _binary 0x50617472696dc3b46e696f20646f20636f6d70757461646f72206f6e646520736572c3a1207574696c697a61646f203a, _binary '', 0, 24),
	(34, 'Substituição de teclado', 13, _binary 0x50617472696dc3b46e696f20646f20636f6d70757461646f72206f6e646520657374c3a120696e7374616c61646f203a, _binary '', 0, 24),
	(35, 'Impressora - Scanner', 1, _binary 0x53454c4220646120696d70726573736f7261, _binary '', 0, 72),
	(36, 'Impressoras - Instalação', 1, _binary 0x53454c4220646120496d70726573736f7261203a, _binary '', 0, 2),
	(37, 'Impressoras - Falha na impressão', 1, _binary 0x53454c4220646120696d70726573736f7261203a, _binary '', 0, 72),
	(38, 'Impressoras - Não está imprimindo', 1, _binary 0x53454c4220646120496d70726573736f7261203a, _binary '', 0, 72),
	(39, 'Impressoras - Não liga', 1, _binary 0x53454c4220646120696d70726573736f7261, _binary '', 0, 72),
	(40, 'Impressoras - Papel preso/atolamento', 1, _binary 0x53454c4220646120496d70726573736f7261, _binary '', 0, 72),
	(41, 'Impressoras - Solicitação de toner', 1, _binary 0x536520666f7220696d70726573736f726120636f6c6f726964612c207175616c206120636f7220746f20746f6e6572203f3a0d0a53454c4220646120496d70726573736f7261203a, _binary 0x526573706f6e73c3a176656c2070656c6f207472616e73706f7274653a, 30, 0),
	(42, 'Impressoras - Solicitação de troca de equipamento', 1, _binary 0x53454c4220646120696d70726573736f7261, _binary '', 0, 72),
	(43, 'Internet - sem acesso', 7, _binary 0x6c6f63616c203a, _binary '', 0, 3),
	(44, 'internet - Lentidão', 7, _binary 0x6c6f63616c203a, _binary '', 0, 24),
	(45, 'Internet - Desbloqueio de Site', 7, _binary 0x6c6f63616c203a0d0a446573637269c3a7c3a36f20652055524c20646f20736974653a, _binary '', 0, 24),
	(46, 'Modificação de ponto de rede', 3, _binary 0x4c6f63616c203a0d0a4ec3ba6d65726f20646520706f6e746f733a, _binary '', 0, 48),
	(47, 'Exclusão de ponto de rede', 3, _binary 0x4c6f63616c203a0d0a4ec3ba6d65726f20646520506f6e746f73, _binary '', 0, 24),
	(48, 'Instalação de Ponto de rede', 3, _binary 0x4c6f63616c3a0d0a4ec3ba6d65726f20646520706f6e746f73, _binary '', 0, 24),
	(49, 'Instalação de rede wi-fi', 8, _binary 0x4c6f63616c203a, _binary '', 0, 24),
	(50, 'Instalação de Switch', 3, _binary 0x4c6f63616c3a0d0a4e756d65726f20646520706f727461733a, _binary '', 0, 24),
	(51, 'Queda de Link', 3, _binary 0x4c6f63616c203a, _binary '', 0, 24),
	(52, 'Reparo de software', 9, _binary 0x446573637269c3a7c3a36f20646f20736f667477617265203a0d0a506f73737569206c6963656ec3a7613f202873696d2f4ec3a36f29203a20, _binary '', 0, 2),
	(53, 'Configuração de Software', 9, _binary 0x446573637269c3a7c3a36f20646f20736f667477617265203a0d0a506f73737569206c6963656ec3a761203f202873696d2f4ec3a36f29203a, _binary '', 0, 2),
	(54, 'Inclusão de usuários de rede / computador', 14, _binary 0x4e6f6d6520646f20757375c3a172696f203a0d0a5061737461732064652061636573736f206e612072656465203a, _binary 0x4c6f67696e20646f20557375c3a172696f3a0d0a53656e686120496e696369616c203a, 0, 1),
	(55, 'Redefinição de senha de acesso rede / computador', 14, _binary 0x4e6f6d6520646f20757375c3a172696f203a0d0a4c6f67696e20646f20757375c3a172696f203a, _binary 0x4e6f76612073656e686120646f20757375c3a172696f203a, 0, 1),
	(56, 'Redefinição de acessos do usuário na rede', 14, _binary 0x4c6f67696e20646f20757375c3a172696f203a0d0a4e6f766173207061737461732064652061636573736f206e612072656465203a, _binary '', 0, 1),
	(57, 'Exclusão / bloqueio de usuário na rede', 14, _binary 0x4c6f67696e20646f20757375c3a172696f3a0d0a4e6f6d6520646f20757375c3a172696f3a0d0a4d6f7469766f20646f20626c6f71756569726f206f75206578636c7573c3a36f, _binary '', 0, 1),
	(59, 'Acompanhamento de serviço de TI', 15, _binary 0x446573637269c3a7c3a36f20646f205365727669c3a76f, _binary '', 0, 8),
	(60, 'Instalação de Projetores', 16, _binary 0x4c6f63616c203a0d0a526573706f6e73c3a176656c, _binary '', 30, 0),
	(61, 'Manutenção de Projetores', 16, _binary 0x4c6f63616c3a0d0a526573706f6e73c3a176656c, _binary '', 30, 0),
	(62, 'Protocoloweb - Inclusão de novo Usuário', 17, _binary 0x4e6f6d6520646f20557375c3a172696f3a0d0a4350463a0d0a4c6f63616973206465205472616d697461c3a7c3a36f203a, _binary 0x4c6f67696e20646f20557375c3a172696f203a0d0a53656e68612064652041636573736f203a, 30, 0),
	(63, 'Telefonia - Solicitação Instalação', 18, _binary 0x4c6f63616c3a0d0a5265666572c3aa6e6369613a0d0a436f6e7461746f3a, _binary '', 0, 0),
	(64, 'Telefonia - Solicitação Ramal', 18, _binary 0x4c6f63616c3a0d0a5265666572c3aa6e6369613a0d0a436f6e7461746f3a, _binary '', 0, 0),
	(65, 'Telefonia - Manutenção', 18, _binary 0x4ec3ba6d65726f2054656c65666f6e653a0d0a4ec3ba6d65726f2052616d616c3a20, _binary '', 0, 0),
	(66, 'Protocoloweb - Zerar senha', 17, _binary 0x4c6f67696e20646f20557375c3a172696f203a, _binary 0x4e6f76612053656e6861203a, 30, 0),
	(67, 'Protocoloweb - Alteração de locais de tramitação', 17, _binary 0x4c6f67696e20646f20557375c3a172696f203a0d0a4e6f766f73206c6f63616973206465207472616d697461c3a7c3a36f3a0d0a4578636c756972206c6f6361697320616e746572696f726573202873696d2f4ec3a36f29203a, _binary '', 30, 0),
	(68, 'Manutenção de Ponto de Rede', 3, _binary 0x4c6f63616c3a0d0a4ec3ba6d65726f20646520706f6e746f73203a, _binary '', 30, 0),
	(69, 'Acompanhamento de visita técnica', 19, _binary '', _binary '', 0, 0),
	(70, 'Manutenção de Computadores DeskTop', 2, _binary '', _binary 0x436f6e636c7573c3a36f203a, 0, 0),
	(71, 'Telefonia Movel - Solicitacao CHIP', 20, _binary 0x536563726574617269612f476572656e6369613a0d0a557375c3a172696f3a, _binary '', 0, 0),
	(72, 'Telefonia Movel - Indisponível', 20, _binary 0x536563726574617269612f476572656e6369613a0d0a557375c3a172696f3a0d0a54656c65666f6e653a20, _binary '', 0, 0),
	(73, 'Telefonia Movel - Auxilio Configuração (Authenticator)', 20, _binary 0x536563726574617269612f476572656e6369613a0d0a557375c3a172696f3a0d0a4ec3ba6d65726f3a, _binary '', 0, 0),
	(74, 'Sistema Moderna - Ateração de configuração do usuários', 10, _binary 0x4c6f67696e, _binary '', 0, 1),
	(75, 'Instalação', 11, _binary '', _binary '', 0, 1),
	(76, 'Confecção de Cabo de Rede', 3, _binary 0x4c6f63616c206120736572207574696c697a61646f203a0d0a54616d616e686f20656d204d6574726f203a, _binary '', 0, 1),
	(77, 'Instalação do aplicativo no computador', 10, _binary 0x4c6f63616c3a0d0a557375c3a172696f3a, _binary '', 30, 0),
	(78, 'Emprestimo de Projetor', 16, _binary 0x526573706f6e73c3a176656c3a0d0a44617461206520686f72613a0d0a4d6f7469766f0d0a4c6f63616c3a, _binary 0x4465766f6c7669646f20706f723a, 1, 0);

-- Copiando estrutura para tabela gop.oficinas
CREATE TABLE IF NOT EXISTS `oficinas` (
  `id` int NOT NULL AUTO_INCREMENT,
  `descricao` varchar(120) NOT NULL DEFAULT '0',
  `fone1` varchar(25) DEFAULT NULL,
  `fone2` varchar(25) DEFAULT NULL,
  `email` varchar(150) DEFAULT NULL,
  `responsavel` varchar(120) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Copiando dados para a tabela gop.oficinas: ~2 rows (aproximadamente)
INSERT INTO `oficinas` (`id`, `descricao`, `fone1`, `fone2`, `email`, `responsavel`) VALUES
	(1, 'Informática Suporte', '(31) 3672-7688', '(31) 9988-3883', 'glaison26.queiroz@gmail.com', 'Glaison'),
	(26, 'Informática Manutenção', '(31) 3672-7688', '', 'manutencao@sabara.mg.gov.br', 'Edilson'),
	(27, 'Gerência TI', '(31) 3672-7688', '', 'wellington@sabara.mg.gov.br', 'Wellington');

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
  `descritivo` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
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
  `motivo_cancelamento` blob,
  `hora_cancelamento` time DEFAULT NULL,
  `id_resp_cancelamento` int DEFAULT NULL,
  `id_resp_geracao` int DEFAULT NULL,
  `id_resp_conclusao` int DEFAULT NULL,
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
  CONSTRAINT `FK_ordens_usuarios` FOREIGN KEY (`id_solicitante`) REFERENCES `usuarios` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=165 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Copiando dados para a tabela gop.ordens: ~97 rows (aproximadamente)
INSERT INTO `ordens` (`id`, `id_solicitante`, `id_responsavel`, `id_setor`, `id_recurso`, `id_espaco`, `id_oficina`, `data_entrada`, `id_executor_responsavel`, `hora_entrada`, `data_inicio`, `hora_inicio`, `data_conclusao`, `hora_conclusao`, `data_garantia`, `data_entrega`, `hora_entrega`, `data_saida`, `previsao_Horas`, `previsao_minutos`, `tipo`, `numero_nota`, `conclusao`, `valor_material`, `valor_servico`, `tipo_ordem`, `tipo_corretiva`, `tipo_preventiva`, `descritivo`, `mau_uso`, `situacao`, `motivo_naoconformidade`, `data_emissao`, `descricao`, `data_geracao`, `hora_geracao`, `data_previsao`, `hora_previsao`, `status`, `id_solicitacao`, `id_ocorrencia`, `data_cancelamento`, `motivo_cancelamento`, `hora_cancelamento`, `id_resp_cancelamento`, `id_resp_geracao`, `id_resp_conclusao`) VALUES
	(2, 16, 16, 28, 0, 0, 1, NULL, 7, NULL, '2026-03-18', '14:20:24', '2026-03-18', '14:33:00', NULL, NULL, NULL, NULL, NULL, NULL, 'V', NULL, _binary 0x4e6f76612073656e686120646f20757375c3a172696f203a7361626172614032303236, NULL, 0, 'C', 'P', NULL, 'Redefinição de senha de acesso rede / computador', NULL, NULL, NULL, NULL, _binary 0x4e6f6d6520646f20757375c3a172696f203a7265646566696e69c3a7c3a36f2064612073656e686120646120757375c3a1726961204d617269656c6c792e50696e746f0d0a4c6f67696e20646f20757375c3a172696f203a204d617269656c6c792e50696e746f, '2026-03-18', '14:20:00', '2026-03-18', '15:20:00', 'C', 2, 55, NULL, NULL, NULL, NULL, 16, 16),
	(3, 16, 16, 10, 0, 0, 1, NULL, 7, NULL, '2026-03-18', '14:25:45', '2026-03-18', '14:30:00', NULL, NULL, NULL, NULL, NULL, NULL, 'V', NULL, _binary 0x446573637269c3a7c3a36f20646f20652d6d61696c3a72656c61636f6573696e737469747563696f6e6169732e6473407361626172612e6d672e676f762e62720d0a53656e686120696e696369616c203a7361626172614032303236, NULL, 0, 'C', 'P', NULL, 'Criação de Conta de e-mail', NULL, NULL, NULL, NULL, _binary 0x446573637269c3a7c3a36f20646f20652d6d61696c202865782e203c64657363726963616f3e407361626172612e6d672e676f762e62723a2072656c61636f6573696e737469747563696f6e6169732e6473407361626172612e6d672e676f762e62720d0a526573706f6e73c3a176656c203a, '2026-03-18', '14:25:00', '2026-03-18', '16:25:00', 'C', 3, 10, NULL, NULL, NULL, NULL, 16, 16),
	(4, 16, 16, 10, 0, 0, 1, NULL, 7, NULL, '2026-03-18', '14:45:30', '2026-03-18', '15:19:00', NULL, NULL, NULL, NULL, NULL, NULL, 'V', NULL, _binary 0x557375c3a172696f2064652041636573736f203a2072616661656c2e6d6f72656972610d0a53656e68612064652041636573736f203a73616261726140323032360d0a0d0a557375c3a172696f20646f287329206dc3b364756c6f287329203a72616661656c2e6d6f72656972610d0a53656e686120646f287329206dc3b364756c6f287329203a7361626172614032303236, NULL, 0, 'C', 'P', NULL, 'Criação de Usuário', NULL, NULL, NULL, NULL, _binary 0x4e6f6d6520646f20757375c3a172696f203a52616661656c20482e20502e204d6f72656972610d0a4d6f64756c6f7320717565206972c3a120616365737361722028636f6d707261732c206573746f7175652c20636f6e746162696c69646164652c2070726567c3a36f2c20637265646f7265732c2066726f7461732c20707265737461c3a7c3a36f20646520636f6e7461732c2070617472696dc3b46e696f203a0d0a436f6d707261730d0a0d0a, '2026-03-18', '14:45:00', '2026-03-18', '16:45:00', 'C', 4, 15, NULL, NULL, NULL, NULL, 16, 16),
	(5, 28, 28, 6, 0, 0, 1, NULL, 11, NULL, '2026-03-18', '15:09:08', '2026-03-18', '15:10:00', NULL, NULL, NULL, NULL, NULL, NULL, 'V', NULL, _binary 0x496d70726573736f726120696e7374616c61646120636f6d207375636573736f, NULL, 0, 'C', 'P', NULL, 'Impressoras - Instalação', NULL, NULL, NULL, NULL, _binary 0x53454c4220646120496d70726573736f72613a2052564736, '2026-03-18', '15:09:00', '2026-03-21', '15:09:00', 'C', 5, 36, NULL, NULL, NULL, NULL, 28, 28),
	(6, 28, 28, 6, 0, 0, 1, NULL, 11, NULL, '2026-03-18', '15:13:16', '2026-03-18', '15:14:00', NULL, NULL, NULL, NULL, NULL, NULL, 'V', NULL, _binary 0x496d70726573736f726120696e7374616c61646120636f6d207375636573736f, NULL, 0, 'C', 'P', NULL, 'Impressoras - Instalação', NULL, NULL, NULL, NULL, _binary 0x53454c4220646120496d70726573736f7261203a2052475636, '2026-03-18', '15:13:00', '2026-03-21', '15:13:00', 'C', 7, 36, NULL, NULL, NULL, NULL, 28, 28),
	(7, 16, 16, 8, 0, 0, 26, '2026-03-20', 10, '02:28:00', '2026-03-18', '15:24:00', '2026-05-07', '12:09:00', '2026-03-20', '2026-03-20', '02:28:00', '2026-03-20', NULL, NULL, 'V', '', _binary 0x50726f626c656120656cc3a9747269636f20736f6c7563696f6e61646f, 0, 0, 'C', 'P', '', 'Desktop - Instalação e Desinstalação', NULL, 'C', '', NULL, _binary 0x50617472696d6f6e696f3a6ec3a36f20696e666f726d61646f0d0a0d0a4d617175696e61204c696e75782e204e6563657373c3a172696f20636f6e666967757261c3a7c3a36f206e612072656465207061726120656e786572676172206f20646972697665205020646120526564650d0a, '2026-03-18', '15:25:00', '2026-03-18', '17:24:00', 'C', 8, 23, NULL, NULL, NULL, NULL, 16, 16),
	(8, 29, 29, 7, 0, 0, 26, NULL, 10, NULL, '2026-03-18', '15:33:06', '2026-03-18', '15:49:00', NULL, NULL, NULL, NULL, NULL, NULL, 'V', NULL, _binary 0x416775617264616e646f206c6962657261c3a7c3a36f206e6f204669726577616c6c2e, NULL, 0, 'C', 'P', NULL, 'internet - Lentidão', NULL, NULL, NULL, NULL, _binary 0x6c6f63616c203a205665726966696361722050632064612054656f2065204a6f656c6d6120286c656e746964c3a36f20696e7465726e657429, '2026-03-18', '15:33:00', '2026-03-18', '16:33:00', 'C', 12, 44, NULL, NULL, NULL, NULL, 29, 27),
	(9, 29, 29, 7, 0, 0, 26, '2026-04-09', 8, '12:00:00', '2026-03-18', '15:34:00', '2026-04-09', '13:05:00', '2026-04-09', '2026-04-09', '12:00:00', '2026-04-09', NULL, NULL, 'V', '', _binary 0x42757363616d6f73206120696d70726573736f7261206520656c6120736520656e636f6e747261206e612073616c6120646520496e666f726dc3a174696361206e6f2043656e74726f2041646d696e69737472617469766f2e, 0, 0, 'C', 'P', '', 'Impressoras - Instalação', NULL, 'C', '', NULL, _binary 0x53454c4220646120496d70726573736f7261203a20204ec3a36f20496e666f726d61646f0d0a41636f6d70616e68617220726574697261646120646520496d70726573736f726120646f205472616e73706f72746520284f6c6172696129206520696e7374616c6172206e612050726f63757261646f726961204a7572c3ad6469636120287375627374697475697220696d70726573736f7261292e, '2026-03-18', '15:35:00', '2026-04-09', '15:34:00', 'C', 9, 36, NULL, NULL, NULL, NULL, 29, 27),
	(10, 29, 29, 6, 0, 0, 26, NULL, 10, NULL, '2026-03-19', '07:45:10', '2026-03-19', '08:21:00', NULL, NULL, NULL, NULL, NULL, NULL, 'V', NULL, _binary 0x46697a656d6f732061206d7564616ec3a761206465206c6f63616c20646120696d70726573736f72612e20457374c3a12066756e63696f6e616e646f2e, NULL, 0, 'C', 'P', NULL, 'Impressoras - Instalação (Movimentação)', NULL, NULL, NULL, NULL, _binary 0x53454c4220646120496d70726573736f7261203a204e410d0a4d6f76696d656e74617220696d70726573736f726120286d65736d61207365637265746172696129, '2026-03-19', '07:45:00', '2026-03-19', '09:45:00', 'C', 14, 36, NULL, NULL, NULL, NULL, 29, 27),
	(11, 16, 16, 5, 0, 0, 1, NULL, 7, NULL, '2026-03-19', '09:59:11', '2026-03-20', '10:08:00', NULL, NULL, NULL, NULL, NULL, NULL, 'V', NULL, _binary 0x436f6d656e74c3a172696f20646f20416e616c697374613a20466f6920666569746f207465737465206571756970616d656e746f20696d7072696d696e646f206e6f726d616c6d656e7465, NULL, 0, 'C', 'P', NULL, 'Impressoras - Não está imprimindo', NULL, NULL, NULL, NULL, _binary 0x53454c4220646120496d70726573736f7261203a50475a360d0a0d0a4c656e746964c3a36f206e6120696d7072657373c3a36f2e205061737361646f2070656c6f204a6fc3a36f206461205449206461205361c3ba64652e200d0a41626572746f206368616d61646f206e612053656c6265747469206368616d61646f206ec3ba6d65726f203133393531333132, '2026-03-19', '09:59:00', '2026-03-22', '09:59:00', 'C', 15, 38, NULL, NULL, NULL, NULL, 16, 16),
	(12, 27, 27, 6, 0, 0, 26, NULL, 10, NULL, '2026-03-19', '10:47:37', '2026-03-19', '10:48:00', NULL, NULL, NULL, NULL, NULL, NULL, 'V', NULL, _binary 0x4d75646569206120696e7374616c61c3a7c3a36f20646120696d70726573736f72612064612041646d696e6973747261c3a7c3a36f2c20646f20757375c3a172696f205269636172646f2070617261206f2052482e, NULL, 0, 'C', 'P', NULL, 'Impressoras - Instalação', NULL, NULL, NULL, NULL, _binary 0x4d7564617220696e7374616c61c3a7c3a36f20646120696d70726573736f72612064612061646d696e6973747261c3a7c3a36f2070617261206f2052482e, '2026-03-19', '10:47:00', '2026-03-19', '12:47:00', 'C', 16, 36, NULL, NULL, NULL, NULL, 27, 27),
	(13, 16, 16, 8, 0, 0, 26, '2026-03-20', 8, '10:20:00', '2026-03-20', '09:00:00', '2026-03-20', '14:00:00', '2026-03-20', '2026-03-20', '18:54:00', '2026-03-20', NULL, NULL, 'V', '', _binary 0x456665747561646f2061636f6d70616e68616d656e746f20636164617374726f20646520696dc3b37665697320656d20526176656e612e204571756970616d656e746f7320656d2066756e63696f6e616d656e746f206f6b2e, 0, 0, 'C', 'P', '', 'Acompanhamento de serviço de TI', NULL, 'C', '', NULL, _binary 0x446573637269c3a7c3a36f20646f205365727669c3a76f203a2041636f6d70616e68616d656e746f206e6f20436164617374726f20646520696dc3b376656973207265616c697a61646f20656d20726176656e61, '2026-03-20', '09:49:00', '2026-03-20', '14:00:00', 'C', 17, 59, NULL, NULL, NULL, NULL, 16, 26),
	(14, 27, 27, 29, 0, 0, 26, '2026-03-20', 10, '12:57:00', '2026-03-20', '09:56:00', '2026-03-20', '09:58:00', '2026-03-20', '2026-03-20', '12:57:00', '2026-03-20', NULL, NULL, 'V', '', _binary 0x466f6920666569746f206120696e7374616c61c3a7c3a36f20646120696d70726573736f726120656d203520636f6d70757461646f7265732e, 0, 0, 'C', 'P', '', 'Impressoras - Instalação', NULL, 'C', '', NULL, _binary 0x496e7374616c61c3a7c3a36f20646120696d70726573736f726120656d203520636f6d70757461646f726573, '2026-03-20', '09:56:00', '2026-03-20', '11:56:00', 'C', 18, 36, NULL, NULL, NULL, NULL, 27, 27),
	(15, 16, 16, 9, 0, 0, 1, NULL, 7, NULL, '2026-03-20', '10:24:09', '2026-03-20', '10:27:00', NULL, NULL, NULL, NULL, NULL, NULL, 'V', NULL, _binary 0x4c6f67696e20646f20557375c3a172696f3a616c616e2e6d61676e6f0d0a53656e686120496e696369616c203a7361626172614032303236, NULL, 0, 'C', 'P', NULL, 'Inclusão de usuários de rede / computador', NULL, NULL, NULL, NULL, _binary 0x4e6f6d6520646f20757375c3a172696f203a416c616e204d61676e6f20446961732064612053696c7661204a756e696f72c2a00d0a5061737461732064652061636573736f206e612072656465203a53656372657461726961206465206f62726173, '2026-03-20', '10:24:00', '2026-03-20', '11:45:00', 'C', 19, 54, NULL, NULL, NULL, NULL, 16, 16),
	(16, 16, 16, 6, 0, 0, 26, NULL, 10, NULL, '2026-03-20', '11:02:41', '2026-03-20', '11:18:00', NULL, NULL, NULL, NULL, NULL, NULL, 'V', NULL, _binary 0x436f6d70757461646f7220666f69207375627374697475c3ad646f20636f6d20c3aa7869746f2e20, NULL, 0, 'C', 'P', NULL, 'DeskTop - Solicitação de Novo Computador', NULL, NULL, NULL, NULL, _binary 0x757375c3a172696f203a4a65666572736f6e20285248290d0a41746976696461646520612073657220657865637574616461203a53756273746974756972206d617175696e6120646f205248206c696e75782070656c61206d617175696e6120646f2072682071756520656e636f6e7472612d7365206e61206d616e7574656ec3a7c3a36f, '2026-03-20', '11:03:00', '2026-03-20', '12:02:00', 'C', 20, 9, NULL, NULL, NULL, NULL, 16, 27),
	(17, 27, 27, 6, 0, 0, 26, NULL, 10, NULL, '2026-03-20', '12:09:52', '2026-03-20', '12:10:00', NULL, NULL, NULL, NULL, NULL, NULL, 'V', NULL, _binary 0x496e7374616c61646f20757375c3a172696f20646120696d70726573736f72612041444d206e6120696d70726573736f726120646f2052682e, NULL, 0, 'C', 'P', NULL, 'Impressoras - Instalação', NULL, NULL, NULL, NULL, _binary 0x496e7374616c617220757375c3a172696f20646120696d70726573736f726120656d206f7574726120696d70726573736f72612e20496d70726573736f72612041444d20706172612052682e, '2026-03-20', '12:09:00', '2026-03-20', '14:09:00', 'C', 22, 36, NULL, NULL, NULL, NULL, 27, 27),
	(18, 28, 28, 31, 0, 0, 1, NULL, 11, NULL, '2026-03-20', '15:09:25', '2026-03-20', '15:11:00', NULL, NULL, NULL, NULL, NULL, NULL, 'V', NULL, _binary 0x4f204361626f2048444d4920657374c3a120636f6d206d616c20636f6e7461746f, NULL, 0, 'C', 'P', NULL, 'Instalação de Projetores', NULL, NULL, NULL, NULL, _binary 0x4c6f63616c203a2053616c61206465205265756e69c3a36f0d0a526573706f6e73c3a176656c3a204a6f656c6d61, '2026-03-20', '15:09:00', '2026-03-20', '15:39:00', 'C', 23, 60, NULL, NULL, NULL, NULL, 28, 28),
	(19, 16, 16, 7, 0, 0, 1, NULL, 7, NULL, '2026-03-20', '15:38:11', '2026-03-20', '15:38:00', NULL, NULL, NULL, NULL, NULL, NULL, 'V', NULL, _binary 0x5365677565202061636573736f733a0d0a0d0a4d6172696120436c617261206465204f6c6976656972612042726167610d0a0d0a2020202020202020204ac3a120706f737375692061636573736f20696e696369616c20646f2073697374656d612e20557375c3a172696f206d617269612e62726167612e205365206ec3a36f20736f756265722073656e6861202870616472c3a36f207361626172614032303236292061766973617220706172612066617a6572207265736574206461206d65736d610d0a0d0a5375736965204d61636861646f204e756e65730d0ae28082e28082e28082e28082557375c3a172696f2064652061636573736f20696e696369616c20646f2073697374656d612073757369652e6d61636861646f2073656e686120696e696369616c2073616261726140323032360d0a0d0a4c75636173204665726e616e64657320646520416c6d6569646120436f7374610d0ae28082e28082e28082e28082557375c3a172696f2064652061636573736f203a206c756361732e636f7374612073656e686120696e696369616c2073616261726140323032360d0a0d0a4b617269656e6e65204a617175656c696e6520507261646f0d0a0d0a20e28082e28082e28082e280824ac3a120706f737375692061636573736f20616f2073697374656d612e20557375c3a172696f206b617269656e6e652e707261646f2e205365206ec3a36f20736f756265722073656e6861202870616472c3a36f207361626172614032303236292061766973617220706172612066617a6572207265736574206461206d65736d610d0a0d0a52656e61746120646520417261756a6f204665726e616e6465730d0a0d0ae28082e28082e28082e280824ac3a120706f737375692061636573736f20616f2073697374656d612e20557375c3a172696f2072656e6174612e6665726e616e6465732e205365206ec3a36f20736f756265722073656e6861202870616472c3a36f207361626172614032303236292061766973617220706172612066617a6572207265736574206461206d65736d610d0a0d0a4f7320757375c3a172696f732064652061636573736f20616f206dc3b364756c6f20646520706c616e656a616d656e746f20c3a9206f206d65736d6f20646f2061636573736f20696e696369616c2e20546f646f7320636f6d20612073656e686120696e696369616c207361626172614032303236, NULL, 0, 'C', 'P', NULL, 'Criação de Usuário', NULL, NULL, NULL, NULL, _binary 0x4e6f6d6520646f20757375c3a172696f203a0d0a0d0a56656e686f20706f72206d65696f20646573746520736f6c696369746172207375706f7274652070617261206c6962657261c3a7c3a36f2064652061636573736f20616f2073697374656d61205375706572204e6f76612c2062656d20636f6d6f207665726966696361c3a7c3a36f2064652061636573736f20616f206dc3b364756c6f20646520506c616e656a616d656e746f2070617261206f73207365727669646f7265732061626169786f2072656c6163696f6e61646f733a0d0a0d0a4d6172696120436c617261206465204f6c6976656972612042726167610d0a4350463a203132302e3038342e3437362d39330d0a4d617472c3ad63756c613a2032343232380d0a5375736965204d61636861646f204e756e65730d0a4350463a203130392e3035342e3535362d38310d0a4d617472c3ad63756c613a2033323630320d0a0d0a4c75636173204665726e616e64657320646520416c6d6569646120436f7374610d0a4350463a203133352e3631342e3533362d31390d0a4d617472c3ad63756c613a2033333732310d0a0d0a4b617269656e6e65204a617175656c696e6520507261646f0d0a4350463a203038332e3539362e3236362d30300d0a4d617472c3ad63756c613a2033343634320d0a0d0a52656e61746120646520417261756a6f204665726e616e6465730d0a4350463a203036312e3335322e3733362d34370d0a4d617472c3ad63756c613a2033323239320d0a0d0a28417475616c6d656e74652073656d2061636573736f20616f206dc3b364756c6f20646520506c616e656a616d656e746f290d0a4d6f64756c6f7320717565206972c3a120616365737361722028636f6d707261732c206573746f7175652c20636f6e746162696c69646164652c2070726567c3a36f2c20637265646f7265732c2066726f7461732c20707265737461c3a7c3a36f20646520636f6e7461732c2070617472696dc3b46e696f203a0d0a6dc3b364756c6f20646520706c616e656a616d656e746f0d0a, '2026-03-20', '15:38:00', '2026-03-20', '17:38:00', 'C', 21, 15, NULL, NULL, NULL, NULL, 16, 16),
	(20, 28, 28, 31, 0, 0, 1, NULL, 11, NULL, '2026-03-20', '16:16:08', '2026-03-20', '16:18:00', NULL, NULL, NULL, NULL, NULL, NULL, 'V', NULL, _binary 0x466f692072657061737361646f20c3a0207365727669646f7261204c61696c6120636f6d6f20636f6d706163746172206520646573636f6d706163746172206172717569766f73207574696c697a616e646f2057696e726172, NULL, 0, 'C', 'P', NULL, 'Instalação de Software', NULL, NULL, NULL, NULL, _binary 0x506f73737569204c6963656ec3a7612873696d2f6ec3a36f29203f206ec3a36f0d0a446573637269c3a7c3a36f20646f20736f66747761726520612073657220696e7374616c61646f3a2057696e5241522028477261747569746f29, '2026-03-20', '16:16:00', '2026-03-20', '16:46:00', 'C', 24, 28, NULL, NULL, NULL, NULL, 28, 28),
	(21, 28, 28, 6, 0, 0, 1, NULL, 11, NULL, '2026-03-23', '09:13:17', '2026-03-23', '09:15:00', NULL, NULL, NULL, NULL, NULL, NULL, 'V', NULL, _binary 0x466f69207665726966696361646f2071756520612066756e63696f6ec3a1726961206ec3a36f206c69676f75206f206573746162696c697a61646f722e204170c3b373206c69676172206f206571756970616d656e746f206f20636f6d70757461646f722066756e63696f6e6f752070657266656974616d656e7465, NULL, 0, 'C', 'U', NULL, 'Desktop - Não liga', NULL, NULL, NULL, NULL, _binary 0x46756e63696f616ec3a17269612072656c61746120717565206f20636f6d70757461646f72206ec3a36f2071756572206c69676172, '2026-03-23', '09:13:00', '2026-03-23', '09:30:00', 'C', 26, 20, NULL, NULL, NULL, NULL, 28, 28),
	(22, 16, 16, 6, 0, 0, 1, NULL, 7, NULL, '2026-03-23', '09:35:34', '2026-03-23', '09:59:00', NULL, NULL, NULL, NULL, NULL, NULL, 'V', NULL, _binary 0x4c6f67696e20646f20557375c3a172696f203a746861796e6172612e74656978656972610d0a53656e68612064652041636573736f203a313233343536, NULL, 0, 'C', 'P', NULL, 'Inclusão de novo Usuário', NULL, NULL, NULL, NULL, _binary 0x4e6f6d6520646f20557375c3a172696f3a546861796e617261204c61757261206465204f2e2054656978656972610d0a4350463a3133352e3939322e3330362d33330d0a4c6f63616973206465205472616d697461c3a7c3a36f203a50726f746f636f6c6f, '2026-03-23', '09:35:00', '2026-03-23', '10:05:00', 'C', 27, 62, NULL, NULL, NULL, NULL, 16, 16),
	(23, 16, 16, 6, 0, 0, 1, NULL, 7, NULL, '2026-03-23', '10:30:39', '2026-03-23', '10:31:00', NULL, NULL, NULL, NULL, NULL, NULL, 'V', NULL, _binary 0x4c6f67696e20646f20557375c3a172696f3a7468796e6172612e74656978656972610d0a53656e686120496e696369616c203a7361626172614032303236, NULL, 0, 'C', 'P', NULL, 'Inclusão de usuários de rede / computador', NULL, NULL, NULL, NULL, _binary 0x4e6f6d6520646f20757375c3a172696f203a746861796e6172612e74656978656972610d0a5061737461732064652061636573736f206e612072656465203a41646d696e6973747261c3a7c3a36f, '2026-03-23', '10:30:00', '2026-03-23', '11:00:00', 'C', 30, 54, NULL, NULL, NULL, NULL, 16, 16),
	(24, 27, 27, 7, 0, 0, 26, NULL, 10, NULL, '2026-03-23', '12:37:53', '2026-03-25', '07:54:00', NULL, NULL, NULL, NULL, NULL, NULL, 'V', NULL, _binary 0x436f6d70757461646f7265732066696e616c697a61646f733a20504154203131393032312c3131383734372c3131383736332e2046697a206120666f726d617461c3a7c3a36f20652075706772616465206465206d656dc3b37269612065205353442e20, NULL, 0, 'C', 'P', NULL, 'Desktop - Formatação de Computador', NULL, NULL, NULL, NULL, _binary 0x466f726d61746172203420636f6d70757461646f7265732c207061726120736572656d20757361646f73206e6120506f6c696369612e, '2026-03-23', '12:37:00', '2026-03-26', '12:37:00', 'C', 31, 8, NULL, NULL, NULL, NULL, 27, 27),
	(25, 16, 16, 5, 0, 0, 1, NULL, 7, NULL, '2026-03-23', '15:49:08', '2026-03-23', '15:49:00', NULL, NULL, NULL, NULL, NULL, NULL, 'V', NULL, _binary 0x416c74657261646f206c6f63616c206465207472616d697461c3a7c3a36f20706172612053656372657461726961206d756e69636970616c206465205361c3ba6465, NULL, 0, 'C', 'P', NULL, 'Alteração de locais de tramitação no protocolo web', NULL, NULL, NULL, NULL, _binary 0x4c6f67696e20646f20557375c3a172696f203a72616661656c68656c656e6f0d0a4e6f766f73206c6f63616973206465207472616d697461c3a7c3a36f3a52482064612053454d5553410d0a4578636c756972206c6f6361697320616e746572696f726573202873696d2f4ec3a36f29203a53696d, '2026-03-23', '15:49:00', '2026-03-23', '16:19:00', 'C', 32, 67, NULL, NULL, NULL, NULL, 16, 16),
	(26, 16, 16, 28, 0, 0, 1, NULL, 7, NULL, '2026-03-23', '16:33:23', '2026-03-24', '16:50:00', NULL, NULL, NULL, NULL, NULL, NULL, 'V', NULL, _binary 0x466f6920666569746f2074726f6361722064612070656c6963756c6120646120667573616f2e204571756970616d656e746f2066756e63696f6e616c, NULL, 0, 'C', 'P', NULL, 'Impressoras - Não está imprimindo', NULL, NULL, NULL, NULL, _binary 0x53454c4220646120496d70726573736f7261203a544643380d0a4571756970616d656e746f20636f6d2070726f626c656d6173206d6563c3a26e69636f732e20426172756c686f20616f20696d7072696d6972206520656d626f6c616e646f20706170656c2e0d0a4368616d61646f20736f6c6963697461646f2070656c6f2074c3a9636e69636f2064612073656372657461726961206465204564756361c3a7c3a36f, '2026-03-23', '16:33:00', '2026-03-26', '16:33:00', 'C', 33, 38, NULL, NULL, NULL, NULL, 16, 16),
	(27, 28, 28, 6, 0, 0, 1, NULL, 11, NULL, '2026-03-24', '08:36:47', '2026-03-24', '08:37:00', NULL, NULL, NULL, NULL, NULL, NULL, 'V', NULL, _binary 0x466f69206e6563657373c3a172696f207265736574617220612073656e68612064652061646d696e6973747261646f72206c6f63616c2c206174726176c3a97320646520756d2070656e64726976652c207061726120656e74c3a36f207265636f6c6f636172206f20636f6d70757461646f72206e6f20646f6dc3ad6e696f206520617373696d20696e636c7569722061206e6f76612066756e63696f6ec3a172696120616f2061636573736f2e20466f6920636f6e666967757261646f2074616d62c3a96d206120696d70726573736f72612c2066696e616c697a61646f206f73207465737465732065206465766f6c7669646f20616f207365746f722e, NULL, 0, 'C', 'P', NULL, 'Desktop - Incluir desktop na rede', NULL, NULL, NULL, NULL, _binary 0x436f6e6669677572617220636f6d70757461646f7220706172612066756e63696f6ec3a172696120546861796e617261206e6f207365746f722064652050726f746f636f6c6f, '2026-03-24', '08:37:00', '2026-03-25', '08:36:00', 'C', 34, 24, NULL, NULL, NULL, NULL, 28, 28),
	(28, 16, 16, 29, 7, 0, 1, '2026-03-25', 7, '14:17:00', '2026-03-24', '10:49:00', '2026-03-30', '10:13:00', '2026-03-25', '2026-03-25', '14:17:00', '2026-03-25', NULL, NULL, 'R', '', _binary 0x566973697461207265616c697a6164612070656c6f2074c3a9636e69636f2064612064656c6c202e204571756970616d656e746f2074657665207175652073657220666f726d617461646f206520656e636f6e7472612d73652066756e63696f6e616c, 0, 0, 'C', 'P', '', 'Desktop - Não liga', NULL, 'C', '', NULL, _binary 0x50617472696dc3b46e696f203a3131363535310d0a0d0a4d617175696e6120646f20436f726f6e656c2064612044656665736120476f64696e686f0d0a0d0a436f6d70757461646f72207472617661646f206e612074656c6120696e696369616c2064612044454c4c2e20466f69206665697461207669736974612064652074c3a9636e69636f2064612064656c6c207175652074726f636f75206120706c616361206dc3a3652e0d0a4f206571756970616d656e746f20766f6c746f752061206170726573656e746172206f2070726f626c656d6120646f69732064696173206170c3b3732061207669736974612e20, '2026-03-24', '10:49:00', '2026-03-27', '10:49:00', 'C', 25, 20, NULL, NULL, NULL, NULL, 16, 16),
	(29, 28, 28, 29, 0, 0, 1, NULL, 11, NULL, '2026-03-24', '10:57:33', '2026-03-24', '11:02:00', NULL, NULL, NULL, NULL, NULL, NULL, 'V', NULL, _binary 0x696e7374616c61c3a7c3a36f20636f6e636c75c3ad646120636f6d207375636573736f, NULL, 0, 'C', 'P', NULL, 'Impressoras - Instalação', NULL, NULL, NULL, NULL, _binary 0x496e7374616c61c3a7c3a36f20696d70726573736f726120646f205248207061726120757375c3a172696f20446f75676c6173, '2026-03-24', '10:58:00', '2026-03-24', '11:57:00', 'C', 35, 36, NULL, NULL, NULL, NULL, 28, 28),
	(30, 16, 16, 7, 0, 0, 1, NULL, 7, NULL, '2026-03-24', '11:20:30', '2026-03-24', '11:25:00', NULL, NULL, NULL, NULL, NULL, NULL, 'V', NULL, _binary 0x4c6f67696e20646f20557375c3a172696f3a7068696c6c6970652e616d7061726f0d0a53656e686120496e696369616c203a7361626172614032303236, NULL, 0, 'C', 'P', NULL, 'Inclusão de usuários de rede / computador', NULL, NULL, NULL, NULL, _binary 0x4e6f6d6520646f20757375c3a172696f203a7068696c6c6970652e616d7061726f0d0a5061737461732064652061636573736f206e612072656465203a706c616e656a616d656e746f, '2026-03-24', '11:20:00', '2026-03-24', '12:20:00', 'C', 36, 54, NULL, NULL, NULL, NULL, 16, 16),
	(31, 16, 16, 25, 0, 0, 1, NULL, 7, NULL, '2026-03-24', '11:34:59', '2026-03-24', '16:30:00', NULL, NULL, NULL, NULL, NULL, NULL, 'V', NULL, _binary 0x4c6f67696e20646f20557375c3a172696f3a206d617274612e676f6d65730d0a53656e686120496e696369616c203a203132333435360d0a0d0a4c6f67696e20646f20557375c3a172696f3a206269616e63612e6d6178696d6f0d0a53656e686120496e696369616c203a20313233343536, NULL, 0, 'C', 'P', NULL, 'Inclusão de novo Usuário', NULL, NULL, NULL, NULL, _binary 0x4e6f6d6520646f20557375c3a172696f3a7061747269636961204d6172746120476f6d65730d0a4350463a6ec3a36f20696e666f726d61646f0d0a4c6f63616973206465205472616d697461c3a7c3a36f203a726567696f6e616c2066c3a174696d610d0a0d0a4e6f6d6520646f20557375c3a172696f3a6269616e6361204d6178696d6120646f73205265697320416c7665730d0a4350463a0d0a4c6f63616973206465205472616d697461c3a7c3a36f203a20726567696f6e616c20666174696d61, '2026-03-24', '11:35:00', '2026-03-24', '12:04:00', 'C', 37, 62, NULL, NULL, NULL, NULL, 16, 16),
	(32, 16, 16, 25, 0, 0, 1, NULL, 7, NULL, '2026-03-24', '11:37:51', '2026-03-24', '16:29:00', NULL, NULL, NULL, NULL, NULL, NULL, 'V', NULL, _binary 0x4c6f67696e20646f20557375c3a172696f3a206d617274612e676f6d65730d0a53656e686120496e696369616c203a2073616261726140323032360d0a0d0a4c6f67696e20646f20557375c3a172696f3a206269616e63612e6d6178696d6f0d0a53656e686120496e696369616c203a2073616261726140323032360d0a, NULL, 0, 'C', 'P', NULL, 'Inclusão de usuários de rede / computador', NULL, NULL, NULL, NULL, _binary 0x4e6f6d6520646f20757375c3a172696f203a5061747269636961204d6172746120476f6d65730d0a5061737461732064652061636573736f206e612072656465203a526567696f6e616c20666174696d610d0a0d0a4e6f6d6520646f20757375c3a172696f203a4269616e6361204d6178696d6120646f73205265697320416c7665730d0a5061737461732064652061636573736f206e612072656465203a726567696f6e616c20666174696d61, '2026-03-24', '11:37:00', '2026-03-24', '12:37:00', 'C', 38, 54, NULL, NULL, NULL, NULL, 16, 16),
	(33, 29, 29, 6, 0, 0, 26, NULL, 10, NULL, '2026-03-24', '11:48:33', '2026-03-26', '15:21:00', NULL, NULL, NULL, NULL, NULL, NULL, 'V', NULL, _binary 0x436f6d70757461646f722070726563697361206465207065c3a761732c204864206f7520506c616361206dc3a3652c20657374616f20636f6d206465666569746f, NULL, 0, 'C', 'P', NULL, 'Desktop - Lentidão do desktop', NULL, NULL, NULL, NULL, _binary 0x50617472696dc3b46e696f20646f20436f6d70757461646f72203a204e410d0a557375c3a172696f3a2041647269616e6120284a756e746120646f205365727669c3a76f204d696c69746172290d0a0d0a5665726966696361722070726f6772616d61732071756520657374c3a36f2063617573616e646f206c656e746964616f2e2e2e, '2026-03-24', '11:49:00', '2026-03-25', '11:48:00', 'C', 39, 19, NULL, NULL, NULL, NULL, 29, 27),
	(34, 16, 16, 9, 0, 0, 26, NULL, 12, NULL, '2026-03-24', '08:00:49', '2026-03-24', '12:02:00', NULL, NULL, NULL, NULL, NULL, NULL, 'V', NULL, _binary 0x5669736974612074c3a9636e696361207265616c697a616461206a756e746f206120656d707265736120736b206e6f2d627265616b207265616c697a61646120636f6d207375636573736f, NULL, 0, 'C', 'P', NULL, 'Acompanhamento de visita técnica', NULL, NULL, NULL, NULL, _binary 0x41636f6d70616d656e746f20646520766973746f7269612074c3a9636e6963612070617261206d616e7574656ec3a7c3a36f206465206e6f2d627265616b, '2026-03-24', '12:01:00', '2026-03-24', '10:30:00', 'C', 40, 69, NULL, NULL, NULL, NULL, 16, 16),
	(35, 16, 16, 9, 0, 0, 1, NULL, 7, NULL, '2026-03-24', '14:25:40', '2026-03-24', '14:26:00', NULL, NULL, NULL, NULL, NULL, NULL, 'V', NULL, _binary 0x4e6f76612073656e686120646f20757375c3a172696f203a7361626172614032303236, NULL, 0, 'C', 'P', NULL, 'Redefinição de senha de acesso rede / computador', NULL, NULL, NULL, NULL, _binary 0x4e6f6d6520646f20757375c3a172696f203a74617469616e61206d61746961730d0a4c6f67696e20646f20757375c3a172696f203a74617469616e612e6d6174696173, '2026-03-24', '14:25:00', '2026-03-24', '15:25:00', 'C', 41, 55, NULL, NULL, NULL, NULL, 16, 16),
	(36, 16, 16, 10, 0, 0, 26, NULL, 12, NULL, '2026-03-24', '16:18:12', '2026-03-25', '10:35:00', NULL, NULL, NULL, NULL, NULL, NULL, 'V', NULL, _binary 0x41646f626520496e7374616c61646f20636f6d207375636573736f, NULL, 0, 'C', 'P', NULL, 'Instalação de Software', NULL, NULL, NULL, NULL, _binary 0x506f73737569204c6963656ec3a7612873696d2f6ec3a36f29203f206ec3a36f20736f667477617265206c697672650d0a446573637269c3a7c3a36f20646f20736f66747761726520612073657220696e7374616c61646f3a41646f6265207265616465720d0a496e7374616c61c3a7c3a36f206e61206164766f6361636961204d756e69636970616c200d0a0d0a, '2026-03-24', '16:18:00', '2026-03-24', '18:18:00', 'C', 42, 28, NULL, NULL, NULL, NULL, 16, 16),
	(37, 27, 27, 9, 0, 0, 26, NULL, 10, NULL, '2026-03-25', '08:20:00', '2026-03-25', '10:30:00', NULL, NULL, NULL, NULL, NULL, NULL, 'V', NULL, _binary 0x536f6c6963697461c3a7c3a36f20636f6e636c75c3ad64612c206e6f7465626f6f6b20666f6920666f726d617461646f2e, NULL, 0, 'C', 'P', NULL, 'Desktop - Formatação de Computador', NULL, NULL, NULL, NULL, _binary 0x557375c3a172696f203a2053616272696e610d0a50617472696d6f6e696f3a203131393238390d0a0d0a446573637269c3a7c3a36f20646f2070726f626c656d613a20466f726d6174617220636f6d70757461646f722c2057696e646f7773206e206163657373612e, '2026-03-25', '08:20:00', '2026-03-28', '08:20:00', 'C', 43, 8, NULL, NULL, NULL, NULL, 27, 27),
	(38, 16, 16, 5, 0, 0, 1, NULL, 7, NULL, '2026-03-25', '08:53:20', '2026-03-25', '08:53:00', NULL, NULL, NULL, NULL, NULL, NULL, 'V', NULL, _binary 0x4c6f67696e20646f20557375c3a172696f3a7961736d696e2e63617276616c686f0d0a53656e686120496e696369616c203a7361626172614032303232, NULL, 0, 'C', 'P', NULL, 'Inclusão de usuários de rede / computador', NULL, NULL, NULL, NULL, _binary 0x4e6f6d6520646f20757375c3a172696f203a7961736d696e2043617276616c686f202d2072656465206461207361c3ba64650d0a5061737461732064652061636573736f206e612072656465203a2073614661726d61636961, '2026-03-25', '08:53:00', '2026-03-25', '09:53:00', 'C', 44, 54, NULL, NULL, NULL, NULL, 16, 16),
	(39, 16, 16, 5, 0, 0, 1, NULL, 7, NULL, '2026-03-25', '10:42:04', '2026-03-25', '10:48:00', NULL, NULL, NULL, NULL, NULL, NULL, 'V', NULL, _binary 0x4c6f67696e20646f20557375c3a172696f203a206d696368656c6c652e6c6973626f610d0a53656e68612064652041636573736f203a313233343536, NULL, 0, 'C', 'P', NULL, 'Protocoloweb - Inclusão de novo Usuário', NULL, NULL, NULL, NULL, _binary 0x4e6f6d6520646f20557375c3a172696f3a4d696368656c6c652050616d656c6120476f6ec3a7616c76657320646120436f737461204c6973626f610d0a4350463a0d0a4c6f63616973206465205472616d697461c3a7c3a36f203a2053656372657461726961206465207361756465, '2026-03-25', '10:42:00', '2026-03-25', '11:12:00', 'C', 45, 62, NULL, NULL, NULL, NULL, 16, 16),
	(40, 30, 16, 7, 0, 0, 26, NULL, 12, NULL, '2026-03-25', '10:00:10', '2026-03-25', '11:39:00', NULL, NULL, NULL, NULL, NULL, NULL, 'V', NULL, _binary 0x5365727669c3a76f207265666572656e746520612061636f6d70616e68616d656e746f207265616c697a61646f206e6f2064696120313720616f20646961203231206465206d6172c3a76f2e20, NULL, 0, 'C', 'P', NULL, 'Acompanhamento de serviço de TI', NULL, NULL, NULL, NULL, _binary 0x4d6f6e746167656d20646520646f697320706f6e746f73206465206174656e64696d656e746f2070617261207265736f6c7665722070656e64c3aa6e636961732065206573636c6172656365722064c3ba76696461732072656c6163696f6e61646173206120495054552c20436164617374726f20496d6f62696c69c3a172696f20652047656f70726f63657373616d656e746f2c206e612072656769c3a36f2063656e7472616c20646520526176656e612065206e6f20706f766f61646f20646520547261c3ad7261732e, '2026-03-25', '11:34:00', '2026-03-25', '17:00:00', 'C', 47, 59, NULL, NULL, NULL, NULL, 16, 16),
	(41, 30, 16, 11, 0, 0, 26, '2026-03-25', 12, '19:00:00', '2026-03-25', '11:45:00', '2026-03-25', '16:07:00', '2026-03-25', '2026-03-25', '19:00:00', '2026-03-25', NULL, NULL, 'V', '', _binary 0x53697374656d61207265696e7374616c61646f2c2061646420646f6dc3ad6e696f2e2e2e, 0, 0, 'C', 'P', '', 'Desktop - Instalação e Desinstalação', NULL, 'C', '', NULL, _binary 0x50617472696d6f6e696f3a203130353535330d0a50632044656c6c204f707469706c6578333030302c2054414720424d32473652333b207265737461757261c3a7c3a36f20646f2053697374656d61204f7065726163696f6e616c2028313320686f726173293b20696e7374616c61c3a7c3a36f2064652070726f6772616d61733b2061646963696f6e617220616f20646f6dc3ad6e696f3b20696e7374616c61c3a7c3a36f20646520696d70726573736f72613b200d0a, '2026-03-25', '11:47:00', '2026-03-26', '13:45:00', 'C', 46, 23, NULL, NULL, NULL, NULL, 16, 30),
	(42, 29, 29, 14, 0, 0, 26, NULL, 10, NULL, '2026-03-25', '12:03:53', '2026-03-25', '12:46:00', NULL, NULL, NULL, NULL, NULL, NULL, 'V', NULL, _binary 0x4465736c69676172616d206f20706f6e746f20646f207377697463682e2050726f626c656d61207265736f6c7669646f2e, NULL, 0, 'C', 'P', NULL, 'Internet - sem acesso', NULL, NULL, NULL, NULL, _binary 0x6c6f63616c203a2053656372657461726961206465204573706f7274657320285369646572c3ba726769636120202d2053616c6120646f2056697661204d61697329, '2026-03-25', '12:04:00', '2026-03-25', '15:03:00', 'C', 48, 43, NULL, NULL, NULL, NULL, 29, 27),
	(43, 30, 30, 6, 0, 0, 26, NULL, 12, NULL, '2026-03-24', '16:00:04', '2026-03-26', '16:31:00', NULL, NULL, NULL, NULL, NULL, NULL, 'V', NULL, _binary 0x4665697461206c696d70657a612064652063616368652c20626c6f717565696f206465207369746573202870617261206576697461722061647761726573292c206578636c7573c3a36f20646f73206172717569766f732074656d706f72c3a172696f732028757375c3a172696f73202d20415050444154412d206520646f73206e6176656761646f726573292e, NULL, 0, 'C', 'P', NULL, 'Desktop - Lentidão do desktop', NULL, NULL, NULL, NULL, _binary 0x566572696669636172206f207063206461204a554e5441204d494c495441522e0d0a0d0a50617472696dc3b56e696f20646f20436f6d70757461646f72203a0d0a557375c3a172696f3a, '2026-03-25', '15:09:00', '2026-03-27', '15:09:00', 'C', 49, 19, NULL, NULL, NULL, NULL, 30, 30),
	(44, 30, 30, 6, 0, 0, 26, NULL, 12, NULL, '2026-03-25', '15:22:16', '2026-03-25', '17:05:00', NULL, NULL, NULL, NULL, NULL, NULL, 'V', NULL, _binary 0x5265696e7374616c61c3a7c3a36f20646f2053697374656d61204f7065726163696f6e616c2c20696e7374616c61c3a7c3a36f20646f73202270726f6772616d61732070616472c3a36f222c20696e7374616c61c3a7c3a36f20646520696d70726573736f72612c2061646963696f6e617220616f20646f6dc3ad6e696f2c20617475616c697a61c3a7c3b56573206e6563657373c3a172696173206465206472697665732e, NULL, 0, 'C', 'P', NULL, 'Desktop - Instalação e Desinstalação', NULL, NULL, NULL, NULL, _binary 0x50617472696d6f6e696f3a3131393031390d0a0d0a5265696e7374616c61c3a7c3a36f2064652053697374656d61204f7065726163696f6e616c2c20706172612075736f206e6f2052482e0d0a, '2026-03-25', '15:22:00', '2026-03-26', '17:00:00', 'C', 50, 23, NULL, NULL, NULL, NULL, 30, 30),
	(45, 30, 30, 6, 0, 0, 26, '2026-03-25', 12, '18:57:00', '2026-03-25', '08:32:00', '2026-03-25', '15:58:00', '2026-03-25', '2026-03-25', '18:57:00', '2026-03-25', NULL, NULL, 'V', '', _binary 0x66696e616c697a61c3a7c3a36f20646f207375706f727465206520c3a020646973706f7369c3a7c3a36f2070617261206576656e7475616973207175657374696f6e616d656e746f732065207375706f727465, 0, 0, 'C', 'P', '', 'Acompanhamento de visita técnica', NULL, 'C', '', NULL, _binary 0x7375706f7274652074c3a9636e69636f206e61207265646566696e69c3a7c3a36f2064652073656e68612065207265637570657261c3a7c3a36f2064652061636573736f20616f7320652d6d61696c7320646f207365746f72206465205365677572616ec3a76120646f2054726162616c686f2e0d0a0d0a2d20417578696c696172206e61207265646566696e69c3a7c3a36f2064652073656e68612065207265637570657261c3a7c3a36f2064652061636573736f20616f20652d6d61696c206d65646963696e61742e73616261726140676d61696c2e636f6d3b0d0a2d2050726573746172207375706f727465207061726120726573746162656c6563696d656e746f2064652061636573736f20616f2044726976653b0d0a2d205265616c697a6172206120636f6e666967757261c3a7c3a36f2064652063616d616461206465207365677572616ec3a76120646120636f6e746120646520652d6d61696c3b0d0a, '2026-03-25', '15:32:00', '2026-03-25', '11:32:00', 'C', 51, 69, NULL, NULL, NULL, NULL, 30, 30),
	(46, 30, 30, 6, 0, 0, 26, '2026-03-25', 12, '20:01:00', '2026-03-25', '16:56:00', '2026-03-26', '09:15:00', '2026-03-25', '2026-03-25', '20:01:00', '2026-03-25', NULL, NULL, 'V', '', _binary 0x417475616c697a61c3a7c3a36f20646f732064726976657320646f2070632e20, 0, 0, 'C', 'P', '', 'Acompanhamento de visita técnica', NULL, 'C', '', NULL, _binary 0x5665726966696361722061636573736f206120646f63756d656e746f7320636f6d70617274696c6861646f7320284472697665292c206e61204d65646963696e6120646f2054726162616c686f2e, '2026-03-25', '16:56:00', '2026-03-26', '11:00:00', 'C', 52, 69, NULL, NULL, NULL, NULL, 30, 30),
	(47, 16, 16, 13, 0, 0, 1, '2026-03-26', 7, '13:29:00', '2026-03-26', '09:50:00', '2026-03-26', '10:51:00', '2026-03-26', '2026-03-26', '13:29:00', '2026-03-26', NULL, NULL, 'V', '', _binary 0x4e6f76612073656e6861207265646566696e696461203a73616261726140323032360d0a6170656e6173207072696d6569726f2061636573736f2e206e656e68756d612073656e61206465206dc3b364756f20666f69207265646566696e696461, 0, 0, 'C', 'P', '', 'Redefinir Senha', NULL, 'C', '', NULL, _binary 0x5175616c206f206c6f67696e20646f20757375c3a172696f3f203a206c6574c3ad6369612e636f7272616469200d0a53697374656d61206461204d6f6465726e61, '2026-03-26', '09:50:00', '2026-03-26', '10:20:00', 'C', 54, 16, NULL, NULL, NULL, NULL, 16, 16),
	(48, 16, 16, 32, 0, 0, 1, NULL, 7, NULL, '2026-03-26', '09:57:14', '2026-03-26', '10:02:00', NULL, NULL, NULL, NULL, NULL, NULL, 'V', NULL, _binary 0x546f646f73206f7320757375c3a172696f73207469766572616d206f7320736575732061636573736f732072656d6f7669646f732064612070617374612063706164, NULL, 0, 'C', 'P', NULL, 'Redefinição de acessos do usuário na rede', NULL, NULL, NULL, NULL, _binary 0x4c6f67696e20646f20757375c3a172696f203a0d0a0d0a43616d696c612e66656c69780d0a526f647269676f2e6772696c6f0d0a52616661656c2e68656c656e6f0d0a5072697363696c612e626172626f73610d0a5265626563612e736f706869610d0a5261696172612e7261697373610d0a426172626172612e73696c76610d0a4c756361732e766963746f720d0a0d0a4e6f766173207061737461732064652061636573736f206e612072656465203a20526574697261722061636573736f2064612070617374612063706164, '2026-03-26', '09:57:00', '2026-03-26', '10:57:00', 'C', 53, 56, NULL, NULL, NULL, NULL, 16, 16),
	(49, 16, 16, 19, 0, 0, 1, NULL, 7, NULL, '2026-03-26', '10:42:21', '2026-03-26', '13:58:00', NULL, NULL, NULL, NULL, NULL, NULL, 'V', NULL, _binary 0x5265736f6c7669646f2073656d206e6563657373696461646520646520766973697461206669736963612e20466f6920726574697261646f2065207265636f6c6f6361646f206f20746f6e65722070617261207265736f6c75c3a7c3a36f20646f2070726f626c656d61, NULL, 0, 'C', 'P', NULL, 'Impressoras - Não está imprimindo', NULL, NULL, NULL, NULL, _binary 0x53454c4220646120496d70726573736f7261203a646575350d0a54726176616461206e612074656c6120646520737461747573, '2026-03-26', '10:42:00', '2026-03-29', '10:42:00', 'C', 55, 38, NULL, NULL, NULL, NULL, 16, 16),
	(50, 16, 16, 30, 0, 0, 1, NULL, 7, NULL, '2026-03-26', '11:51:27', '2026-03-26', '14:41:00', NULL, NULL, NULL, NULL, NULL, NULL, 'V', NULL, _binary 0x446573637269c3a7c3a36f20646f20652d6d61696c3a766967696c616e63696170617472696d6f6e69616c407361626172612e6d672e676f762e62720d0a53656e686120696e696369616f203a7361626172614032303236, NULL, 0, 'C', 'P', NULL, 'Criação de Conta de e-mail', NULL, NULL, NULL, NULL, _binary 0x446573637269c3a7c3a36f20646f20652d6d61696c202865782e203c64657363726963616f3e407361626172612e6d672e676f762e62723a766967696c616e63696170617472696d6f6e69616c407361626172612e6d672e676f762e62720d0a526573706f6e73c3a176656c203a7365677572616ec3a761207075626c696361, '2026-03-26', '11:51:00', '2026-03-26', '13:51:00', 'C', 56, 10, NULL, NULL, NULL, NULL, 16, 16),
	(51, 16, 16, 12, 0, 0, 1, NULL, 7, NULL, '2026-03-26', '11:55:04', '2026-03-26', '14:24:00', NULL, NULL, NULL, NULL, NULL, NULL, 'V', NULL, _binary 0x557375c3a172696f207261796c616e652e7669746f7269610d0a53656e6861207361626172614032303236, NULL, 0, 'C', 'P', NULL, 'Inclusão de usuários de rede / computador', NULL, NULL, NULL, NULL, _binary 0x4e6f6d6520646f20757375c3a172696f203a5261796c616e6520766974c3b372696120646520536f757a61204665726e616e6465730d0a5061737461732064652061636573736f206e612072656465203a74757269736d6f, '2026-03-26', '11:55:00', '2026-03-26', '12:55:00', 'C', 57, 54, NULL, NULL, NULL, NULL, 16, 16),
	(52, 16, 16, 28, 0, 0, 1, NULL, 7, NULL, '2026-03-26', '11:59:01', '2026-03-26', '14:17:00', NULL, NULL, NULL, NULL, NULL, NULL, 'V', NULL, _binary 0x4e6f76612073656e6861207265646566696e696461203a7361626172614032303236, NULL, 0, 'C', 'P', NULL, 'Sistema Moderna - Redefinir Senha', NULL, NULL, NULL, NULL, _binary 0x5175616c206f206c6f67696e20646f20757375c3a172696f3f203a416e61204b61726c612064652044657573c2a0, '2026-03-26', '11:59:00', '2026-03-26', '12:29:00', 'C', 58, 16, NULL, NULL, NULL, NULL, 16, 16),
	(53, 29, 29, 8, 0, 0, 26, NULL, 12, NULL, '2026-03-27', '09:11:23', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'V', NULL, NULL, NULL, 0, 'C', 'P', NULL, 'Telefonia Movel - Auxilio Configuração (Authenticator)', NULL, NULL, NULL, NULL, _binary 0x536563726574617269612f476572656e6369613a20476162696e65746520536563726574617269612064612046617a656e64610d0a557375c3a172696f3a204d617269612045647561726461202844756461290d0a4ec3ba6d65726f3a0d0a0d0a417578696c696172206e6120696e7374616c61c3a7c3a36f206520636f6e666967757261c3a7c3a36f20646f2041757468656e74696361746f72, '2026-03-27', '09:11:00', '2026-03-27', '09:11:00', 'X', 62, 73, '2026-05-07', _binary 0x41c3a7c3a36f206ec3a36f206e6563657373c3a1726961, '12:11:00', 16, 29, NULL),
	(54, 26, 26, 29, 0, 0, 26, NULL, 8, NULL, '2026-03-27', '10:31:38', '2026-04-06', '13:09:00', NULL, NULL, NULL, NULL, NULL, NULL, 'V', NULL, _binary 0x466569746120612074726f636120646f2048443b207265737461757261646f2053697374656d61204f7065726163696f6e616c3b20696e7374616c61646f202270726f6772616d61732070616472c3a36f223b2061646963696f6e61646f20616f20646f6dc3ad6e696f20504d532e, NULL, 0, 'C', 'P', NULL, 'Desktop - Tela azul', NULL, NULL, NULL, NULL, _binary 0x50617472696dc3b46e696f203a20303933303135204571756970616d656e746f206170726573656e7461646f2074656c6120617a756c0d0a, '2026-03-27', '10:31:00', '2026-03-29', '10:31:00', 'C', 63, 21, NULL, NULL, NULL, NULL, 26, 30),
	(55, 28, 28, 33, 0, 0, 1, NULL, 11, NULL, '2026-03-27', '14:32:54', '2026-03-27', '14:33:00', NULL, NULL, NULL, NULL, NULL, NULL, 'V', NULL, _binary 0x696e7374616c61c3a7c3a36f20636f6e636c75c3ad64612c20746573746573206f6b, NULL, 0, 'C', 'P', NULL, 'Impressoras - Solicitação de toner', NULL, NULL, NULL, NULL, _binary 0x536520666f7220696d70726573736f726120636f6c6f72696461207175616c206120636f7220746f20746f6e6572203f3a206d6167656e74610d0a, '2026-03-27', '14:33:00', '2026-03-27', '15:32:00', 'C', 64, 41, NULL, NULL, NULL, NULL, 28, 28),
	(56, 30, 30, 6, 0, 0, 26, NULL, 12, NULL, '2026-03-30', '08:23:05', '2026-03-30', '08:24:00', NULL, NULL, NULL, NULL, NULL, NULL, 'V', NULL, _binary 0x43c3b36469676f732064652061636573736f20656e766961646f7320706172612063656c756c617220636f72706f72617469766f, NULL, 0, 'C', 'P', NULL, 'Acompanhamento de visita técnica', NULL, NULL, NULL, NULL, _binary 0x41636573736f20616f20656d61696c20646f205265637572736f732048756d616e6f7320285061756c6f29, '2026-03-30', '08:23:00', '2026-03-30', '08:23:00', 'C', 65, 69, NULL, NULL, NULL, NULL, 30, 30),
	(57, 29, 29, 7, 0, 0, 26, NULL, 12, NULL, '2026-03-31', '13:30:55', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'V', NULL, NULL, NULL, NULL, 'C', 'P', NULL, 'Instalação de Projetores', NULL, NULL, NULL, NULL, _binary 0x4c6f63616c203a20496e7374616c6172206e612053616c61206465205265756e69c3a36f0d0a526573706f6e73c3a176656c3a204361726c6f73204564756172646f0d0a0d0a4f62732e3a20696e7374616c61722050726f6a65746f722065204e6f7465626f6f6b206e612053616c61206465205265756e69c3a36f20c3a0732031333a333020646f206469612033312f30332f323032362e0d0a284e6f7465626f6f6b2076657269666963617220636f6d206f204361726c6f73204564756172646f2c2070726f766176656c6d656e7465206f2071756520657374c3a120656d707265737461646f20636f6d2061204d617269616e6129, '2026-03-30', '11:06:00', '2026-03-31', '13:50:00', 'X', 67, 60, '2026-04-06', _binary 0x4ec3a36f20686f7576652061207265666572696461207265756e69c3a36f, '16:32:00', 30, 29, NULL),
	(58, 28, 28, 32, 0, 0, 1, NULL, 11, NULL, '2026-03-30', '14:27:56', '2026-03-30', '16:28:00', NULL, NULL, NULL, NULL, NULL, NULL, 'V', NULL, _binary 0x466f6920726574697261646f20646f20646f6dc3ad6e696f204c696e75782065207265696e636c75c3ad646f2e205265616c697a61646f206f73207465737465732c206f6b2e, NULL, 0, 'C', 'P', NULL, 'Desktop - Incluir desktop na rede', NULL, NULL, NULL, NULL, _binary 0x557375c3a172696f2052616661656c612072656c6174612071756520616f2074656e7461722061636573736172206f20706320636f6d2073657520757375c3a172696f2073656d70726520617061726563653a2022757375c3a172696f206f752073656e686120696e76c3a16c696461222e2045207175616e646f206c6f676120656d2070632057696e646f77732c206f206d65736d6f20657374c3a1206f6b2e, '2026-03-30', '16:28:00', '2026-03-31', '15:30:00', 'C', 68, 24, NULL, NULL, NULL, NULL, 28, 28),
	(59, 16, 30, 7, 0, 0, 26, NULL, 12, NULL, '2026-03-31', '09:00:20', '2026-03-31', '10:05:00', NULL, NULL, NULL, NULL, NULL, NULL, 'V', NULL, _binary 0x50432061646963696f6e61646f20616f20646f6dc3ad6e696f3b20696d70726573736f726120636f6e66696775726164613b20636f6e666967757261646f206f732061636573736f7320c3a0732070617374617320646520726564652065207363616e6e65723b20646f63756d656e746f732f6172717569766f7320636f706961646f733b2074657374657320666569746f732e, NULL, 0, 'C', 'P', NULL, 'Desktop - Incluir desktop na rede', NULL, NULL, NULL, NULL, _binary 0x50617472696dc3b46e696f203a0d0a41646963696f6e6172207063206461207361c3ba6465206e61207265646520706d730d0a0d0a557375c3a172696f2072656e6174612e617261c3ba6a6f, '2026-03-31', '09:56:00', '2026-03-31', '09:30:00', 'C', 69, 24, NULL, NULL, NULL, NULL, 30, 30),
	(60, 28, 28, 29, 0, 0, 1, NULL, 11, NULL, '2026-03-30', '16:57:57', '2026-03-31', '16:59:00', NULL, NULL, NULL, NULL, NULL, NULL, 'V', NULL, _binary 0x436f6e636c7573c3a36f203a20466f692074726f6361646120706c616361206dc3a36520652070726f6365737361646f722070656c6120656d70726573612044656c6c2e204170c3b37320666f69206665697461207265696e7374616c61c3a7c3a36f20646f2077696e646f77732c207265696e7374616c61c3a7c3a36f20646f732070726f6772616d61732c207265696e7374616c61c3a7c3a36f206f66666963652c20696e7374616c61c3a7c3a36f20646120726564652c20696d70726573736f7261732c2074657374657320636f6d20757375c3a172696f2c206f6b, NULL, 0, 'C', 'P', NULL, 'Manutenção', NULL, NULL, NULL, NULL, _binary 0x436f6d70757461646f72207472617661206e612074656c6120646520696e696369616c697a61c3a7c3a36f, '2026-03-31', '16:58:00', '2026-03-31', '16:57:00', 'C', 70, 70, NULL, NULL, NULL, NULL, 28, 28),
	(61, 16, 16, 25, 0, 0, 26, NULL, 10, NULL, '2026-04-06', '09:37:27', '2026-04-09', '13:08:00', NULL, NULL, NULL, NULL, NULL, NULL, 'V', NULL, _binary 0x436f6e636c7573c3a36f203a20436f6d70757461646f72657320636f6c6f6361646f73206e6f20646f6dc3ad6e696f2e20526567696f6e616c207072656369736120636f6d7072617220756d204875622f537769746368206465203820706f727461732c20706172612061646963696f6e6172206d61697320636f6d70757461646f7265732e, NULL, 0, 'C', 'P', NULL, 'Manutenção', NULL, NULL, NULL, NULL, _binary 0x56657269666963617220706f6e746f732064652072656465206520766572696669636172207365206dc3a17175696e617320657374c3a36f206e6f20646f6dc3ad6e696f, '2026-04-06', '09:37:00', '2026-04-06', '17:00:00', 'C', 66, 70, NULL, NULL, NULL, NULL, 16, 27),
	(62, 16, 16, 9, 0, 0, 26, '2026-04-06', 10, '18:25:00', '2026-04-06', '09:38:00', '2026-04-08', '13:10:00', '2026-04-06', '2026-04-06', '18:25:00', '2026-04-06', NULL, NULL, 'V', '', _binary 0x50726f626c656d61207265736f6c7669646f2c20656e64657265c3a76f2049502065737461766120656d20636f6e666c69746f2e, 0, 0, 'C', 'P', '', 'Internet - sem acesso', NULL, 'C', '', NULL, _binary 0x6c6f63616c203a53656372657461726961204d756e69636970616c206465204f627261730d0a536f6c69636974616e7465203a2053616272696e61, '2026-04-06', '09:38:00', '2026-04-07', '12:38:00', 'C', 71, 43, NULL, NULL, NULL, NULL, 16, 27),
	(63, 30, 30, 30, 8, 0, 26, NULL, 12, NULL, '2026-03-31', '11:00:49', '2026-04-08', '09:53:00', NULL, NULL, NULL, NULL, NULL, NULL, 'R', NULL, _binary 0x4f627365727661c3a7c3b565733a20436f6d70757461646f722066756e63696f6e616c20656e766961646f207061726120612073656372657461726961, NULL, 0, 'C', 'P', NULL, 'Desktop - Formatação de Computador', NULL, NULL, NULL, NULL, _binary 0x557375c3a172696f203a20416c657373616e6472610d0a50617472696d6f6e696f3a203131393234350d0a0d0a446573637269c3a7c3a36f20646f2070726f626c656d613a2050632073656d2053697374656d61204f7065726163696f6e616c3b20696e7374616c61c3a7c3a36f20646f2053697374656d61204c696e75784d696e74, '2026-04-06', '13:19:00', '2026-04-06', '13:18:00', 'C', 73, 8, NULL, NULL, NULL, NULL, 30, 16),
	(64, 30, 30, 30, 0, 0, 26, NULL, 10, NULL, '2026-04-06', '13:23:31', '2026-04-06', '13:24:00', NULL, NULL, NULL, NULL, NULL, NULL, 'V', NULL, _binary 0x4361626f73206172726562656e7461646f733b206162657274757261206465206368616d61646f2070617261206120656d707265736120707265737461646f726120646f207365727669c3a76f2e, NULL, 0, 'C', 'P', NULL, 'Internet - sem acesso', NULL, NULL, NULL, NULL, _binary 0x6c6f63616c203a20476572c3aa6e636961206465205472c3a26e7369746f2e20496e746572727570c3a7c3a36f20646f73207365727669c3a76f7320646520696e7465726e65742e203c4a554e494f523e, '2026-04-06', '13:23:00', '2026-04-06', '16:23:00', 'C', 72, 43, NULL, NULL, NULL, NULL, 30, 30),
	(65, 16, 16, 5, 0, 0, 1, NULL, 7, NULL, '2026-04-06', '15:28:20', '2026-04-06', '15:28:00', NULL, NULL, NULL, NULL, NULL, NULL, 'V', NULL, _binary 0x557375c3a172696f2064652041636573736f203a74686961676f2e73616e746f730d0a53656e68612064652041636573736f203a206ac3a12074696e68612073656e6861200d0a0d0a557375c3a172696f20646f287329206dc3b364756c6f287329203a2074686961676f2e73616e746f730d0a53656e686120646f287329206dc3b364756c6f287329203a207361626172614032303236, NULL, 0, 'C', 'P', NULL, 'Sistema Moderna - Criação de Usuário', NULL, NULL, NULL, NULL, _binary 0x4e6f6d6520646f20757375c3a172696f203a74686961676f2e73616e746f730d0a4d6f64756c6f7320717565206972c3a120616365737361722028636f6d707261732c206573746f7175652c20636f6e746162696c69646164652c2070726567c3a36f2c20637265646f7265732c2066726f7461732c20707265737461c3a7c3a36f20646520636f6e7461732c2070617472696dc3b46e696f203a0d0a0d0a53697374656d6120646520636f6e746162696c6964616465206520636f6d707261730d0a0d0a, '2026-04-06', '15:28:00', '2026-04-06', '17:28:00', 'C', 74, 15, NULL, NULL, NULL, NULL, 16, 16),
	(66, 28, 28, 7, 0, 0, 1, NULL, 11, NULL, '2026-04-06', '11:42:39', '2026-04-06', '16:43:00', NULL, NULL, NULL, NULL, NULL, NULL, 'V', NULL, _binary 0x436f6e636c7573c3a36f203a20466f69207265616c697a616461207661727265647572612064652076c3ad727573206e6f20636f6d70757461646f722c20646573696e7374616c61646f206f20476f6f676c65204368726f6d652065207265696e7374616c61646f2e20466f69207465737461646f2070656c6f20757375c3a172696f2065206e6f726d616c697a61646f2e, NULL, 0, 'C', 'P', NULL, 'Manutenção', NULL, NULL, NULL, NULL, _binary 0x417061726563656e646f2076c3a172696f7320706f702d757073206e6f206e6176656761646f7220676f6f676c65204368726f6d6520636f6d20696e666f726d61c3a7c3a36f206465202276c3ad72757322, '2026-04-06', '16:43:00', '2026-04-06', '14:42:00', 'C', 75, 70, NULL, NULL, NULL, NULL, 28, 28),
	(67, 30, 30, 28, 0, 0, 1, '2026-04-07', 12, '13:26:00', '2026-04-07', '09:54:00', '2026-04-07', '11:52:00', '2026-04-07', '2026-04-07', '13:26:00', '2026-04-07', NULL, NULL, 'V', '', _binary 0x526f6d70696d656e746f20646520666962726120736f6c696369696f6e61646f, 0, 0, 'C', 'P', '', 'Internet - sem acesso', NULL, 'C', '', NULL, _binary 0x6c6f63616c203a204573636f6c61204d756e69636970616c204f7264c3a16c69610d0a726f6d70696d656e746f206465206669627261, '2026-04-07', '09:54:00', '2026-04-07', '12:54:00', 'C', 76, 43, NULL, NULL, NULL, NULL, 30, 16),
	(68, 16, 16, 5, 0, 0, 1, '2026-04-07', 7, '13:38:00', '2026-04-07', '10:32:00', '2026-04-07', '10:55:00', '2026-04-07', '2026-04-07', '13:38:00', '2026-04-07', NULL, NULL, 'V', '', _binary 0x557375c3a172696f2064652041636573736f203a666162696f2e6d6167616c686165730d0a53656e68612064652041636573736f203a73616261726140323032360d0a0d0a557375c3a172696f20646f287329206dc3b364756c6f287329203a20666162696f2e6d6167616c686165730d0a53656e686120646f287329206dc3b364756c6f287329203a7361626172614032303236, 0, 0, 'C', 'P', '', 'Sistema Moderna - Criação de Usuário', NULL, 'C', '', NULL, _binary 0x4e6f6d6520646f20757375c3a172696f203a466162696f204a657375697461204d6167616c686165730d0a4350463a38373137303538323630300d0a4d6f64756c6f7320717565206972c3a120616365737361722028636f6d707261732c206573746f7175652c20636f6e746162696c69646164652c2070726567c3a36f2c20637265646f7265732c2066726f7461732c20707265737461c3a7c3a36f20646520636f6e7461732c2070617472696dc3b46e696f203a0d0a434f4d505241532c20434f4e544142494c49444144452c204553544f5155450d0a, '2026-04-07', '10:32:00', '2026-04-07', '12:32:00', 'C', 78, 15, NULL, NULL, NULL, NULL, 16, 16),
	(69, 30, 27, 9, 0, 0, 26, NULL, 10, NULL, '2026-04-07', '11:01:57', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'V', NULL, NULL, NULL, 0, 'C', 'P', NULL, 'Internet - sem acesso', NULL, NULL, NULL, NULL, _binary 0x6c6f63616c203a2e2e2e, '2026-04-07', '11:02:00', '2026-04-07', '14:01:00', 'X', 77, 43, '2026-04-07', _binary 0x32206368616d61646f732061626572746f73, '11:12:00', 27, 27, NULL),
	(70, 30, 30, 8, 0, 0, 26, NULL, 12, NULL, '2026-04-07', '11:15:53', '2026-04-07', '16:16:00', NULL, NULL, NULL, NULL, NULL, NULL, 'V', NULL, _binary 0x6d7564616ec3a761206566657469766164613b2072656f7267616e697a61c3a7c3a36f206465206361626f733b20, NULL, 0, 'C', 'P', NULL, 'Desktop - Instalação e Desinstalação', NULL, NULL, NULL, NULL, _binary 0x50617472696d6f6e696f3a0d0a4c6f63616c3a2073616c612064652047656f50726f63657373616d656e746f3b206d75646172206f20636f6d70757461646f72206465206c75676172206e61206d65736d612073616c612e0d0a, '2026-04-07', '16:16:00', '2026-04-07', '13:15:00', 'C', 79, 23, NULL, NULL, NULL, NULL, 30, 30),
	(71, 28, 28, 6, 0, 0, 1, NULL, 11, NULL, '2026-04-07', '08:33:20', '2026-04-08', '08:45:00', NULL, NULL, NULL, NULL, NULL, NULL, 'V', NULL, _binary 0x496e7374616c61c3a7c3a36f20636f6e636c75c3ad646120636f6d207375636573736f2e20546573746573206f6b, NULL, 0, 'C', 'P', NULL, 'Impressoras - Instalação', NULL, NULL, NULL, NULL, _binary 0x496e7374616c61c3a7c3a36f20696d70726573736f726120646f20524820706172612066756e63696f6ec3a1726961204272756e6120646f207365746f72206465205365727669c3a76f7320476572616973, '2026-04-08', '08:33:00', '2026-04-07', '10:33:00', 'C', 80, 36, NULL, NULL, NULL, NULL, 28, 28),
	(72, 16, 16, 11, 0, 0, 1, NULL, 7, NULL, '2026-04-08', '09:32:18', '2026-04-08', '09:42:00', NULL, NULL, NULL, NULL, NULL, NULL, 'V', NULL, _binary 0x4c6f67696e20646f20557375c3a172696f203a706564726f2e70696572690d0a53656e68612064652041636573736f203a313233343536, NULL, 0, 'C', 'P', NULL, 'Protocoloweb - Inclusão de novo Usuário', NULL, NULL, NULL, NULL, _binary 0x4e6f6d6520646f20557375c3a172696f3a506564726f2048656e72697175652046616c6569726f20646520536f757a612050696572690d0a4350463a3032312e3636332e3539362d39380d0a4c6f63616973206465205472616d697461c3a7c3a36f203a4d65696f20416d6269656e7465, '2026-04-08', '09:32:00', '2026-04-08', '10:02:00', 'C', 83, 62, NULL, NULL, NULL, NULL, 16, 16),
	(73, 16, 16, 11, 0, 0, 1, NULL, 7, NULL, '2026-04-08', '09:32:47', '2026-04-08', '09:38:00', NULL, NULL, NULL, NULL, NULL, NULL, 'V', NULL, _binary 0x4c6f67696e20646f20557375c3a172696f3a706564726f2e70696572690d0a53656e686120496e696369616c203a7361626172614032303236, NULL, 0, 'C', 'P', NULL, 'Inclusão de usuários de rede / computador', NULL, NULL, NULL, NULL, _binary 0x4e6f6d6520646f20757375c3a172696f203a506564726f2048656e72697175652046616c6569726f20646520536f757a612050696572690d0a5061737461732064652061636573736f206e612072656465203a4d65696f20616d6269656e7465, '2026-04-08', '09:32:00', '2026-04-08', '10:32:00', 'C', 82, 54, NULL, NULL, NULL, NULL, 16, 16),
	(74, 16, 16, 5, 0, 0, 1, NULL, 7, NULL, '2026-04-08', '09:33:15', '2026-04-08', '11:13:00', NULL, NULL, NULL, NULL, NULL, NULL, 'V', NULL, _binary 0x557375c3a172696f2064652041636573736f203a4ac3a120706f737375692061636573736f0d0a53656e68612064652041636573736f203a6ac3a120706f737375692061636573730d0a0d0a557375c3a172696f20646f287329206dc3b364756c6f287329203a74686961676f2e72616d6f730d0a53656e686120646f287329206dc3b364756c6f287329203a7361626172614032303236, NULL, 0, 'C', 'P', NULL, 'Sistema Moderna - Criação de Usuário', NULL, NULL, NULL, NULL, _binary 0x4e6f6d6520646f20757375c3a172696f203a54686961676f204665726e616e646f204d617274696e732052616d6f732064652043617276616c686f0d0a6ec3ba6d65726f20646f20435046203a206ec3a36f20696e666f726d61646f0d0a4d6f64756c6f7320717565206972c3a120616365737361722028636f6d707261732c206573746f7175652c20636f6e746162696c69646164652c2070726567c3a36f2c20637265646f7265732c2066726f7461732c20707265737461c3a7c3a36f20646520636f6e7461732c2070617472696dc3b46e696f203a204573746f7175650d0a0d0a, '2026-04-08', '09:33:00', '2026-04-08', '11:33:00', 'C', 81, 15, NULL, NULL, NULL, NULL, 16, 16),
	(75, 16, 16, 8, 0, 0, 1, NULL, 7, NULL, '2026-04-08', '11:20:13', '2026-04-08', '11:20:00', NULL, NULL, NULL, NULL, NULL, NULL, 'V', NULL, _binary 0x4c6f67696e20646f20557375c3a172696f3a61647269616e2e6b61737465720d0a53656e686120496e696369616c203a7361626172614032303236, NULL, 0, 'C', 'P', NULL, 'Inclusão de usuários de rede / computador', NULL, NULL, NULL, NULL, _binary 0x4e6f6d6520646f20757375c3a172696f203a41647269616e204b61727374657220536f757a612053696c76610d0a5061737461732064652061636573736f206e612072656465203a66617a656e646120652066697363616c697a61c3a7c3a36f, '2026-04-08', '11:20:00', '2026-04-08', '12:20:00', 'C', 84, 54, NULL, NULL, NULL, NULL, 16, 16),
	(76, 16, 16, 12, 11, 0, 26, '2026-04-14', 8, '19:29:00', '2026-04-08', '15:38:00', '2026-04-15', '14:07:00', '2026-04-14', '2026-04-14', '19:29:00', '2026-04-14', NULL, NULL, 'R', '', _binary 0x436f6e636c7573c3a36f203a0d0a417475616c697a61c3a7c3a36f2064652042696f73206520647269766572730d0a4f74696d697a61c3a7c3a36f20646520646573656d70656e686f0d0a4f74696d697a61c3a7c3a36f20646520756e69646164657328633a290d0a4578636c7573c3a36f206465206172717569766f732074656d706f72c3a172696f7320, 0, 0, 'C', 'P', '', 'Manutenção', NULL, 'C', '', NULL, _binary 0x436f6d70757461646f7220636f6d2074617276616d656e746f2065206c656e746964c3a36f, '2026-04-08', '15:38:00', '2026-04-15', '15:38:00', 'C', 85, 70, NULL, NULL, NULL, NULL, 16, 26),
	(77, 16, 16, 12, 12, 0, 26, '2026-04-14', 8, '19:29:00', '2026-04-08', '15:41:00', '2026-04-15', '13:53:00', '2026-04-14', '2026-04-14', '19:29:00', '2026-04-14', NULL, NULL, 'R', '', _binary 0x436f6e636c7573c3a36f203a0d0a417475616c697a61c3a7c3a36f2064652042696f73206520647269766572730d0a4f74696d697a61c3a7c3a36f20646520646573656d70656e686f0d0a4f74696d697a61c3a7c3a36f20646520756e69646164657328633a290d0a4578636c7573c3a36f206465206172717569766f732074656d706f72c3a172696f7320, 0, 0, 'C', 'P', '', 'Manutenção', NULL, 'C', '', NULL, _binary 0x436f6d70757461646f7220636f6d2074726176616d656e746f2065204c656e746964c3a36f, '2026-04-08', '15:41:00', '2026-04-15', '15:41:00', 'C', 86, 70, NULL, NULL, NULL, NULL, 16, 26),
	(78, 29, 16, 30, 0, 0, 26, NULL, 9, NULL, '2026-04-08', '16:03:08', '2026-04-14', '14:25:00', NULL, NULL, NULL, NULL, NULL, NULL, 'V', NULL, _binary 0x696e7374616c61c3a7c3a36f20646f20706f6e746f20646520696e7465726e657420652074656c65666f6e6961207265616c697a61646f2070656c612073706565646e65742e204e6563657373c3a172696f2061706172656c686f2074656c6566c3b46e69636f207061726120636f6e666967757261c3a7c3a36f, NULL, 0, 'C', 'P', NULL, 'Telefonia - Solicitação Instalação', NULL, NULL, NULL, NULL, _binary 0x4c6f63616c3a20507261c3a76120476574c3ba6c696f205661726761730d0a5265666572c3aa6e6369613a20506f6e746f20646520546178690d0a436f6e7461746f3a, '2026-04-08', '16:03:00', '2026-04-13', '16:03:00', 'C', 28, 63, NULL, NULL, NULL, NULL, 16, 16),
	(79, 30, 30, 7, 0, 0, 26, NULL, 12, NULL, '2026-04-08', '13:00:25', '2026-04-09', '08:19:00', NULL, NULL, NULL, NULL, NULL, NULL, 'V', NULL, _binary 0x70726f636564696d656e746f207265616c697a61646f, NULL, 0, 'C', 'P', NULL, 'Monitor - Não está Ligando', NULL, NULL, NULL, NULL, _binary 0x50617472696dc3b46e696f203a0d0a636865636f75206361626f7320646520656e6572676961202873696d2f6ec3a36f293f200d0a0d0a41646963696f6e6172206d6f6e69746f7220657874726120616f2070632e2046616c7461206361626f2068646d69206f7520646973706c6179706f72742e0d0a4c6f63616c3a2053494e45, '2026-04-09', '08:18:00', '2026-04-08', '13:10:00', 'C', 60, 25, NULL, NULL, NULL, NULL, 30, 30),
	(80, 30, 30, 8, 13, 0, 26, NULL, 12, NULL, '2026-04-09', '08:39:27', '2026-04-10', '15:03:00', NULL, NULL, NULL, NULL, NULL, NULL, 'R', NULL, _binary 0x50726f636564696d656e746f7320666569746f732e, NULL, 0, 'C', 'P', NULL, 'Desktop - Instalação e Desinstalação', NULL, NULL, NULL, NULL, _binary 0x50617472696d6f6e696f3a203131393331310d0a436f6e666967757261c3a7c3a36f20646f2053697374656d61204f7065726163696f6e616c3b20696e7374616c61c3a7c3a36f206465202270726f6772616d61732070616472c3a36f223b2061646963696f6e617220616f20646f6dc3ad6e696f3b20636f6e6669677572617220696d70726573736f72613b200d0a, '2026-04-09', '08:39:00', '2026-04-09', '10:39:00', 'C', 87, 23, NULL, NULL, NULL, NULL, 30, 30),
	(81, 16, 16, 8, 0, 0, 1, NULL, 7, NULL, '2026-04-09', '09:06:46', '2026-04-09', '09:38:00', NULL, NULL, NULL, NULL, NULL, NULL, 'V', NULL, _binary 0x4c6f67696e20646f20557375c3a172696f3a6b617469612e726f6368610d0a53656e686120496e696369616c203a7361626172614032303236, NULL, 0, 'C', 'P', NULL, 'Inclusão de usuários de rede / computador', NULL, NULL, NULL, NULL, _binary 0x4e6f6d6520646f20757375c3a172696f203a204bc3a17469612056696c656c6120526f6368610d0a5061737461732064652061636573736f206e612072656465203a20436f6e746162696c6964616465, '2026-04-09', '09:07:00', '2026-04-09', '10:06:00', 'C', 88, 54, NULL, NULL, NULL, NULL, 16, 16),
	(82, 16, 16, 8, 0, 0, 1, NULL, 7, NULL, '2026-04-09', '09:17:39', '2026-04-09', '09:36:00', NULL, NULL, NULL, NULL, NULL, NULL, 'V', NULL, _binary 0x557375c3a172696f2064652041636573736f203a6b617469612e726f6368610d0a53656e68612064652041636573736f203a73616261726140323032360d0a0d0a557375c3a172696f20646f287329206dc3b364756c6f287329203a6b617469612e726f6368610d0a53656e686120646f287329206dc3b364756c6f287329203a7361626172614032303236, NULL, 0, 'C', 'P', NULL, 'Sistema Moderna - Criação de Usuário', NULL, NULL, NULL, NULL, _binary 0x4e6f6d6520646f20757375c3a172696f203a4bc3a17469612056696c656c6120526f6368610d0a6ec3ba6d65726f20646f20435046203a2030313530353037333634320d0a4d6f64756c6f7320717565206972c3a120616365737361722028636f6d707261732c206573746f7175652c20636f6e746162696c69646164652c2070726567c3a36f2c20637265646f7265732c2066726f7461732c20707265737461c3a7c3a36f20646520636f6e7461732c2070617472696dc3b46e696f203a436f6e746162696c69646164650d0a0d0a, '2026-04-09', '09:17:00', '2026-04-09', '10:00:00', 'C', 89, 15, NULL, NULL, NULL, NULL, 16, 16),
	(83, 16, 16, 5, 0, 0, 1, NULL, 7, NULL, '2026-04-09', '14:00:07', '2026-04-09', '14:00:00', NULL, NULL, NULL, NULL, NULL, NULL, 'V', NULL, _binary 0x557375c3a172696f2076696e69636975732e62656e746f206ac3a12074696e68612061636573736f20616f206dc3b364756c6f206465206573746f7175652070656469646f2e20666f69207265646566696e69646f2073656e68612070617261207361626172614032303236, NULL, 0, 'C', 'P', NULL, 'Sistema Moderna - Criação de Usuário', NULL, NULL, NULL, NULL, _binary 0x4e6f6d6520646f20757375c3a172696f203a56696e69636975732053696c76612042656e746f0d0a6ec3ba6d65726f20646f20435046203a2031323330373830323632320d0a4d6f64756c6f7320717565206972c3a120616365737361722028636f6d707261732c206573746f7175652c20636f6e746162696c69646164652c2070726567c3a36f2c20637265646f7265732c2066726f7461732c20707265737461c3a7c3a36f20646520636f6e7461732c2070617472696dc3b46e696f203a4573746f7175650d0a0d0a, '2026-04-09', '14:00:00', '2026-04-09', '16:00:00', 'C', 90, 15, NULL, NULL, NULL, NULL, 16, 16),
	(84, 16, 16, 5, 0, 0, 1, '2026-04-09', 7, '19:01:00', '2026-04-09', '15:19:00', '2026-04-09', '16:14:00', '2026-04-09', '2026-04-09', '19:01:00', '2026-04-09', NULL, NULL, 'V', '', _binary 0x557375c3a172696f2072656d6973736f6e2e70657265697261c2a02073656e686120696e696369616c2073616261726140323032360d0a0d0a736f6d656e746520636f6e746162696c69646164652065206573746f717565, 0, 0, 'C', 'P', '', 'Sistema Moderna - Criação de Usuário', NULL, 'C', '', NULL, _binary 0x4e6f6d653a2052656d6973736f6e20536f6172657320506572656972610d0a4350463a2034323534353734393637320d0a434f4e544142494c49444144452065204553544f5155450d0a0d0a, '2026-04-09', '15:19:00', '2026-04-09', '17:19:00', 'C', 91, 15, NULL, NULL, NULL, NULL, 16, 16),
	(85, 30, 30, 32, 14, 0, 26, NULL, 12, NULL, '2026-04-10', '08:18:12', '2026-04-10', '08:31:00', NULL, NULL, NULL, NULL, NULL, NULL, 'R', NULL, _binary 0x536f66747761726520696e7374616c61646f2065206174697661646f, NULL, 0, 'C', 'P', NULL, 'Instalação de Software', NULL, NULL, NULL, NULL, _binary 0x506f73737569204c6963656ec3a7612873696d2f6ec3a36f29203f2073696d20284e4d43524d2d36544a37372d43573746512d364a5644472d4656594658290d0a446573637269c3a7c3a36f20646f20736f66747761726520612073657220696e7374616c61646f3a204d6963726f736f6674204f66666963652032303231, '2026-04-10', '08:18:00', '2026-04-13', '12:00:00', 'C', 92, 28, NULL, NULL, NULL, NULL, 30, 30),
	(86, 30, 30, 7, 15, 0, 26, NULL, 12, NULL, '2026-04-10', '09:20:34', '2026-04-10', '09:21:00', NULL, NULL, NULL, NULL, NULL, NULL, 'R', NULL, _binary 0x44726976657220646520496d70726573736f726120696e7374616c61646f206520636f6e666967757261646f2e, NULL, 0, 'C', 'P', NULL, 'Impressoras - Instalação', NULL, NULL, NULL, NULL, _binary 0x53454c4220646120496d70726573736f7261203a2054464339, '2026-04-10', '09:20:00', '2026-04-10', '11:20:00', 'C', 93, 36, NULL, NULL, NULL, NULL, 30, 30),
	(87, 30, 30, 7, 15, 0, 26, NULL, 12, NULL, '2026-04-10', '09:42:57', '2026-04-10', '09:43:00', NULL, NULL, NULL, NULL, NULL, NULL, 'R', NULL, _binary 0x496e7374616c61c3a7c3a36f206665697461, NULL, 0, 'C', 'P', NULL, 'Sistema Moderna - Ateração de configuração do usuários', NULL, NULL, NULL, NULL, _binary 0x496e7374616c61c3a7c3a36f20646f20476f476c6f62616c2065206174616c686f20646f2053555045524e4f56412d4d4f4445524e41206e6f2070632e, '2026-04-10', '09:43:00', '2026-04-10', '10:42:00', 'C', 94, 74, NULL, NULL, NULL, NULL, 30, 30),
	(88, 30, 30, 6, 16, 0, 26, NULL, 12, NULL, '2026-04-10', '10:45:30', '2026-04-10', '11:20:00', NULL, NULL, NULL, NULL, NULL, NULL, 'R', NULL, _binary 0x496e7374616c61c3a7c3a36f206665697461, NULL, 0, 'C', 'P', NULL, 'Sistema Moderna - Ateração de configuração do usuários', NULL, NULL, NULL, NULL, _binary 0x4c6f67696e207365746f72206465204c6963697461c3a7c3a36f, '2026-04-10', '11:19:00', '2026-04-10', '11:30:00', 'C', 95, 74, NULL, NULL, NULL, NULL, 30, 30),
	(89, 16, 16, 28, 0, 0, 1, NULL, 7, NULL, '2026-04-10', '11:37:15', '2026-04-10', '11:40:00', NULL, NULL, NULL, NULL, NULL, NULL, 'V', NULL, _binary 0x4c6f67696e20646f20557375c3a172696f3a61647269616e612e6c756369610d0a53656e686120496e696369616c203a7361626172614032303236, NULL, 0, 'C', 'P', NULL, 'Inclusão de usuários de rede / computador', NULL, NULL, NULL, NULL, _binary 0x536f6c696369746f2cc2a0706f722067656e74696c657a612c20637269616ec3a7c3a36f206465c2a06c6f67696ec2a0652073656e6861206465c2a061636573736fc2a0287061737461c2a05029c2a070617261205365727669646f72612041647269616e61204cc3ba6369612064612053696c76612c20617373697374656e74652061646d696e69737472617469766f206e61204564756361c3a7c3a36f20285365746f7220646520416c696d656e7461c3a7c3a36f204573636f6c6172292e, '2026-04-10', '11:37:00', '2026-04-10', '12:37:00', 'C', 96, 54, NULL, NULL, NULL, NULL, 16, 16),
	(90, 16, 16, 11, 0, 0, 1, '2026-04-10', 7, '19:19:00', '2026-04-10', '16:18:00', '2026-04-10', '16:21:00', '2026-04-10', '2026-04-10', '19:19:00', '2026-04-10', NULL, NULL, 'V', '', _binary 0x4c6f67696e20646f20557375c3a172696f203a616e612e766173636f6e63656c6f730d0a53656e68612064652041636573736f203a313233343536, 0, 0, 'C', 'P', '', 'Protocoloweb - Inclusão de novo Usuário', NULL, 'C', '', NULL, _binary 0x4e6f6d6520646f20557375c3a172696f3a416e61204265617472697a20436172646f736f20566173636f6e63656c6f7320646f732053616e746f730d0a4350463a31353939333839313639360d0a4c6f63616973206465205472616d697461c3a7c3a36f203a4d65696f20416d6269656e7465, '2026-04-10', '16:18:00', '2026-04-10', '16:48:00', 'C', 97, 62, NULL, NULL, NULL, NULL, 16, 16),
	(91, 16, 16, 6, 0, 0, 1, '2026-04-13', 7, '12:30:00', '2026-04-13', '09:12:00', '2026-04-13', '10:13:00', '2026-04-13', '2026-04-13', '12:30:00', '2026-04-13', NULL, NULL, 'V', '', _binary 0x557375c3a172696f2064652041636573736f203a676c656e69612e70696e746f0d0a53656e68612064652041636573736f203a73616261726140323032360d0a0d0a557375c3a172696f20646f287329206dc3b364756c6f287329203a676c656e69612e70696e746f0d0a53656e686120646f287329206dc3b364756c6f287329203a7361626172614032303236, 0, 0, 'C', 'P', '', 'Sistema Moderna - Criação de Usuário', NULL, 'C', '', NULL, _binary 0x4e6f6d6520646f20757375c3a172696f203a476cc3aa6e6961205061756c612050696e746fc2a00d0a6ec3ba6d65726f20646f20435046203a30383032353435313635380d0a4d6f64756c6f7320717565206972c3a120616365737361722028636f6d707261732c206573746f7175652c20636f6e746162696c69646164652c2070726567c3a36f2c20637265646f7265732c2066726f7461732c20707265737461c3a7c3a36f20646520636f6e7461732c2070617472696dc3b46e696f203a0d0a0d0a436f6d707261730d0a4573746f7175650d0a436f6e746162696c69646164650d0a50617472696dc3b46e696f0d0a50726f746f636f6c6f0d0a0d0a, '2026-04-13', '09:12:00', '2026-04-13', '11:12:00', 'C', 98, 15, NULL, NULL, NULL, NULL, 16, 16),
	(92, 30, 30, 30, 0, 0, 26, NULL, 12, NULL, '2026-04-14', '09:04:03', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'V', NULL, NULL, NULL, NULL, 'C', 'P', NULL, 'Instalação de Software', NULL, NULL, NULL, NULL, _binary 0x506f73737569204c6963656ec3a7612873696d2f6ec3a36f29203f0d0a446573637269c3a7c3a36f20646f20736f66747761726520612073657220696e7374616c61646f3a20736f667477617265207061726120676572656e6369616d656e746f206465206d756c746173, '2026-04-14', '09:04:00', '2026-04-14', '11:04:00', 'X', 61, 28, '2026-05-07', _binary 0x496e747276656ec3a7c3a36f206ec3a36f206e6563657373c3a1726961, '12:11:00', 16, 30, NULL),
	(93, 30, 30, 9, 0, 0, 26, NULL, 12, NULL, '2026-04-14', '09:07:39', '2026-05-07', '12:12:00', NULL, NULL, NULL, NULL, NULL, NULL, 'V', NULL, _binary 0x50726f626c656d6120736f6c7563696f6e61646f, NULL, 0, 'C', 'P', NULL, 'Internet - sem acesso', NULL, NULL, NULL, NULL, _binary 0x6c6f63616c203a2053454d4f42202d2050726f6a65746f732c20706320757361646f2070656c61204761627269656c6c652047616c64696e6f, '2026-04-14', '09:07:00', '2026-04-14', '12:07:00', 'C', 99, 43, NULL, NULL, NULL, NULL, 30, 16),
	(94, 30, 30, 14, 0, 0, 26, NULL, 12, NULL, '2026-04-13', '07:30:03', '2026-04-22', '10:55:00', NULL, NULL, NULL, NULL, NULL, NULL, 'V', NULL, _binary 0x4f732070637320636f6e74696e756172c3a36f2c20706f722074656d706f20696e646566696e69646f2c206e6f206c6f63616c2e, NULL, 0, 'C', 'P', NULL, 'Desktop - Instalação e Desinstalação', NULL, NULL, NULL, NULL, _binary 0x536f6c6963697461206120696e7374616c61c3a7c3a36f206520636f6e666967757261c3a7c3a36f2064652032207063732c206e612073616c61206465207265756e69c3a36f2064612041646d696e6973747261c3a7c3a36f206520636f6e666967757261c3a7c3a36f20646520696d70726573736f7261732c20706172612061706f696f20616f204a454d472e0d0a, '2026-04-14', '09:30:00', '2026-04-17', '17:00:00', 'C', 102, 23, NULL, NULL, NULL, NULL, 30, 30),
	(95, 30, 30, 14, 0, 0, 26, NULL, 12, NULL, '2026-04-14', '11:24:46', '2026-04-16', '09:29:00', NULL, NULL, NULL, NULL, NULL, NULL, 'V', NULL, _binary 0x4c696e6b20617469766f206e6f206c6f63616c, NULL, 0, 'C', 'P', NULL, 'Acompanhamento de visita técnica', NULL, NULL, NULL, NULL, _binary 0x41636f6d70616e68617220706573736f616c2064612053706565644e6574206e6f2043616d706f206461204c696761, '2026-04-14', '11:24:00', '2026-04-14', '11:24:00', 'C', 105, 69, NULL, NULL, NULL, NULL, 30, 16),
	(96, 30, 30, 8, 0, 0, 26, NULL, 12, NULL, '2026-04-14', '15:00:30', '2026-04-14', '16:37:00', NULL, NULL, NULL, NULL, NULL, NULL, 'V', NULL, _binary 0x4d6f6e746167656d2064652030312070633b207265636f6e666967757261c3a7c3a36f20646520495020646120696d70726573736f726120525648313b20636f6e666967757261c3a7c3a36f20646120706f72746120646520696d7072657373c3a36f206e6f7320303320706320646120536563726574617269612064652046617a656e646120457374616475616c2e, NULL, 0, 'C', 'P', NULL, 'Internet - sem acesso', NULL, NULL, NULL, NULL, _binary 0x6c6f63616c203a20534543524554415249412044452046415a454e444120455354414455414c3a202d436f6c6f636172206f2063616265616d656e746f20646520696e7465726e65743b202d636f6e656374617220696d70726573736f72612e, '2026-04-14', '16:32:00', '2026-04-14', '16:10:00', 'C', 103, 43, NULL, NULL, NULL, NULL, 30, 30),
	(97, 30, 30, 7, 0, 0, 26, NULL, 12, NULL, '2026-04-14', '11:14:01', '2026-04-22', '16:33:00', NULL, NULL, NULL, NULL, NULL, NULL, 'V', NULL, _binary 0x456665747561646f206f2061636f6d70616e68616d656e746f2e2050726f626c656d6173206f627365727661646f7320666f72616d2072657061737361646f73207061726120466cc3a176696f204d6169656c6f2e, NULL, 0, 'C', 'P', NULL, 'Acompanhamento de serviço de TI', NULL, NULL, NULL, NULL, _binary 0x446573637269c3a7c3a36f20646f205365727669c3a76f3a41636f6d70616e686172204c61696c6120285365637265746172696120646520476f7665726e6f2920656d20766973697461206120616c67756e73207072c3a964696f732070c3ba626c69636f732c206a756e746f20636f6d20612065717569706520646520746f74656e732e, '2026-04-14', '16:41:00', '2026-04-17', '16:41:00', 'C', 101, 59, NULL, NULL, NULL, NULL, 30, 30),
	(98, 16, 16, 31, 0, 0, 1, NULL, 7, NULL, '2026-04-15', '15:14:08', '2026-04-15', '15:14:00', NULL, NULL, NULL, NULL, NULL, NULL, 'V', NULL, _binary 0x446573637269c3a7c3a36f20646f20652d6d61696c3a72656c61746f72696f73407361626172612e6d672e676f762e62720d0a53656e686120696e696369616f203a7361626172614032303236, NULL, 0, 'C', 'P', NULL, 'Criação de Conta de e-mail', NULL, NULL, NULL, NULL, _binary 0x446573637269c3a7c3a36f20646f20652d6d61696c202865782e203c64657363726963616f3e407361626172612e6d672e676f762e62723a72656c61746f72696f73407361626172612e6d672e676f762e62720d0a526573706f6e73c3a176656c203a4974656c76696e61, '2026-04-15', '15:14:00', '2026-04-15', '16:00:00', 'C', 106, 10, NULL, NULL, NULL, NULL, 16, 16),
	(99, 16, 16, 7, 0, 0, 1, NULL, 7, NULL, '2026-04-15', '15:18:00', '2026-04-15', '15:18:00', NULL, NULL, NULL, NULL, NULL, NULL, 'V', NULL, _binary 0x4c6f67696e20646f20557375c3a172696f3a206d6972656c6c792e706572656972610d0a53656e686120496e696369616c203a7361626172614032303236, NULL, 0, 'C', 'P', NULL, 'Inclusão de usuários de rede / computador', NULL, NULL, NULL, NULL, _binary 0x4e6f6d6520646f20757375c3a172696f203a204d6972656c6c79204775696d6172c3a3657320506572656972610d0a5061737461732064652061636573736f206e612072656465203a706c616e656a616d656e746f, '2026-04-15', '15:18:00', '2026-04-15', '16:18:00', 'C', 107, 54, NULL, NULL, NULL, NULL, 16, 16),
	(100, 30, 30, 7, 0, 0, 26, NULL, 12, NULL, '2026-04-15', '09:00:49', '2026-04-15', '17:37:00', NULL, NULL, NULL, NULL, NULL, NULL, 'V', NULL, _binary 0x4d6f6e746167656d207265616c697a6164613b20746573746573207265616c697a61646f733b207265756e69c3a36f20696e6963696f752d736520c3a073203134682e, NULL, 0, 'C', 'P', NULL, 'Instalação de Projetores', NULL, NULL, NULL, NULL, _binary 0x4c6f63616c203a2073616c61206465207265756e69c3b5657320646f20476162696e6574650d0a526573706f6e73c3a176656c3a204361737369726c656e65205669656972610d0a0d0a4520736f6c696369746172207375706f7274652074c3a9636e69636f207061726120636f6e6578c3a36f20766961206e6f7465626f6f6b2c20706172612061636573736f206520706172746963697061c3a7c3a36f20656d207265756e69c3a36f207669727475616c20646f20436f6e73656c686f204d756e69636970616c20646520486162697461c3a7c3a36f20646520496e7465726573736520536f6369616c202d20434d484953206520646f20477275706f20496e737469747563696f6e616c20646f20506f6465722050c3ba626c69636f202d20474950502e, '2026-04-15', '17:36:00', '2026-04-15', '17:00:00', 'C', 108, 60, NULL, NULL, NULL, NULL, 30, 30),
	(101, 28, 28, 31, 0, 0, 1, NULL, 11, NULL, '2026-04-16', '08:37:56', '2026-04-16', '08:38:00', NULL, NULL, NULL, NULL, NULL, NULL, 'V', NULL, _binary 0x5265616c697a6164612074726f636120646f7320746f6e6e6572732c20746573746573206f6b, NULL, 0, 'C', 'P', NULL, 'Impressoras - Solicitação de toner', NULL, NULL, NULL, NULL, _binary 0x536520666f7220696d70726573736f726120636f6c6f72696461207175616c206120636f7220746f20746f6e6572203f3a20417a756c206520416d6172656c6f0d0a, '2026-04-16', '08:38:00', '2026-04-16', '09:37:00', 'C', 109, 41, NULL, NULL, NULL, NULL, 28, 28),
	(102, 28, 28, 8, 0, 0, 1, NULL, 11, NULL, '2026-04-16', '08:39:46', '2026-04-16', '08:40:00', NULL, NULL, NULL, NULL, NULL, NULL, 'V', NULL, _binary 0x4dc3b364756c6f206461204361697861206ec3a36f2066756e63696f6e6f75206e6f206e6176656761646f7220676f6f676c65204368726f6d652c20696e7374616c61646f206e6f206e6176656761646f722046697265666f782e20546573746573206f6b, NULL, 0, 'C', 'P', NULL, 'Desktop - Instalação e Desinstalação', NULL, NULL, NULL, NULL, _binary 0x496e7374616c61c3a7c3a36f206465206dc3b364756c6f2064612043616978610d0a, '2026-04-16', '08:39:00', '2026-04-16', '10:39:00', 'C', 110, 23, NULL, NULL, NULL, NULL, 28, 28),
	(103, 16, 16, 28, 0, 0, 1, NULL, 7, NULL, '2026-04-16', '09:10:12', '2026-04-16', '09:10:00', NULL, NULL, NULL, NULL, NULL, NULL, 'V', NULL, _binary 0x557375c3a172696f2064652041636573736f203a61647269616e612e6c756369610d0a53656e68612064652041636573736f203a2073616261726140323032360d0a0d0a557375c3a172696f20646f287329206dc3b364756c6f287329203a2061647269616e612e6c756369610d0a53656e686120646f287329206dc3b364756c6f287329203a207361626172614032303236, NULL, 0, 'C', 'P', NULL, 'Sistema Moderna - Criação de Usuário', NULL, NULL, NULL, NULL, _binary 0x4e6f6d6520646f20757375c3a172696f203a41647269616e61204cc3ba6369612064612053696c76610d0a6ec3ba6d65726f20646f20435046203a3036382e3133322e3239362d39390d0a4d6f64756c6f7320717565206972c3a120616365737361722028636f6d707261732c206573746f7175652c20636f6e746162696c69646164652c2070726567c3a36f2c20637265646f7265732c2066726f7461732c20707265737461c3a7c3a36f20646520636f6e7461732c2070617472696dc3b46e696f203a0d0a0d0a, '2026-04-16', '09:10:00', '2026-04-16', '11:10:00', 'C', 111, 15, NULL, NULL, NULL, NULL, 16, 16),
	(104, 30, 16, 34, 0, 0, 26, NULL, 12, NULL, '2026-04-16', '09:33:26', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'V', NULL, NULL, NULL, NULL, 'C', 'P', NULL, 'Modificação de ponto de rede', NULL, NULL, NULL, NULL, _binary 0x4c6f63616c203a2050524f434f4e0d0a4ec3ba6d65726f20646520706f6e746f733a2030320d0a0d0a536f6c69636974612076697374612074c3a9636e6963612061207365646520646f2050524f434f4e20285275613a20446f6d20506564726f2049492c204ec2b02037322c2043656e74726f292c2070617261207175652073656a6120696e7374616c61646f206361626f20646520696e7465726e657420656d20646f697320636f6d70757461646f72657320726563656e74656d656e74652061647175697269646f732070656c6f20c3b37267c3a36f3b20736572c3a1207072656369736f20657374656e646572206f206361626f20646520696e7465726e657420646f732074656c65666f6e65732e20200d0a0d0a4c61726973736120566965697261202d205465636e696361206465206174656e64696d656e746f, '2026-04-16', '09:33:00', '2026-04-18', '09:33:00', 'X', 104, 46, '2026-04-16', _binary 0x4f7264656d2067657261646120696775616c2061206f7264656d203539202d20536f6c6963697461c3a7c3a36f20666569746120656d206475706c69636964616465, '09:33:00', 16, 16, NULL),
	(105, 16, 16, 11, 0, 0, 26, '2026-04-23', 12, '12:58:00', '2026-04-16', '09:37:00', '2026-05-07', '17:24:00', '2026-04-23', '2026-04-23', '12:58:00', '2026-04-23', NULL, NULL, 'V', '', _binary 0x486162696c697461646f206e6f766f20706f6e746f206e612073616c6120646f20536563726574c3a172696f206465204d65696f20416d6269656e7465, 0, 0, 'C', 'P', '', 'Manutenção de Ponto de Rede', NULL, 'C', '', NULL, _binary 0x4c6f63616c3a4d65696f20416d6269656e74650d0a4ec3ba6d65726f20646520706f6e746f73203a3120706f6e746f206361626f20636f6d2070726f626c656d61, '2026-04-16', '09:37:00', '2026-05-04', '10:07:00', 'C', 100, 68, NULL, NULL, NULL, NULL, 16, 30),
	(106, 16, 16, 30, 0, 0, 26, NULL, 8, NULL, '2026-04-16', '10:56:42', '2026-05-07', '12:08:00', NULL, NULL, NULL, NULL, NULL, NULL, 'V', NULL, _binary 0x50726f626c656d6120656cc3a9747269636f207265736f6c7669646f2070656c6f207365746f72206465206f627261732e, NULL, 0, 'C', 'P', NULL, 'Queda de Link', NULL, NULL, NULL, NULL, _binary 0x4c6f63616c203a5072c3a964696f2064612053656372657461726961206465205365677572616ec3a7612070c3ba626c6963610d0a0d0a53696e616c206461204f70657261646f726120206f6b206d6173206ec3a36f207265706c6963612070617261206f20706f6e746f732064652061636573736f2e205665726966696361722070726f626c656d617320696e7465726e6f73206e6f73206571756970616d656e746f73, '2026-04-16', '10:57:00', '2026-04-16', '17:00:00', 'C', 112, 51, NULL, NULL, NULL, NULL, 16, 16),
	(107, 16, 16, 30, 0, 0, 1, NULL, 7, NULL, '2026-04-16', '11:49:04', '2026-04-16', '11:49:00', NULL, NULL, NULL, NULL, NULL, NULL, 'V', NULL, _binary 0x446573637269c3a7c3a36f20646f20652d6d61696c3a0d0a0d0a636f6d756e69636163616f67636d736162617261407361626172612e6d672e676f762e62720d0a706c616e656a616d656e746f6f7065726163696f6e616c67636d736162617261407361626172612e6d672e676f762e62720d0a66697363616c697a6163616f64656f62726173407361626172612e6d672e676f762e62720d0a736563616f74696c6f6769737469636165706573736f616c67636d407361626172612e6d672e676f762e62720d0a636f7272656765646f72696167636d407361626172612e6d672e676f762e62720d0a53656e686120696e696369616c203a207361626172614032303236, NULL, 0, 'C', 'P', NULL, 'Criação de Conta de e-mail', NULL, NULL, NULL, NULL, _binary 0x446573637269c3a7c3a36f20646f20652d6d61696c202865782e203c64657363726963616f3e407361626172612e6d672e676f762e62723a0d0a0d0a636f6d756e69636163616f67636d736162617261407361626172612e6d672e676f762e62720d0a706c616e656a616d656e746f6f7065726163696f6e616c67636d736162617261407361626172612e6d672e676f762e62720d0a66697363616c697a6163616f64656f62726173407361626172612e6d672e676f762e62720d0a736563616f74696c6f6769737469636165706573736f616c67636d407361626172612e6d672e676f762e62720d0a636f7272656765646f72696167636d407361626172612e6d672e676f762e62720d0a0d0a526573706f6e73c3a176656c203a476c69736961, '2026-04-16', '11:49:00', '2026-04-16', '13:49:00', 'C', 113, 10, NULL, NULL, NULL, NULL, 16, 16),
	(108, 16, 16, 11, 0, 0, 1, NULL, 7, NULL, '2026-04-17', '15:26:14', '2026-04-17', '15:26:00', NULL, NULL, NULL, NULL, NULL, NULL, 'V', NULL, _binary 0x4c6f67696e20646f20557375c3a172696f3a6c756361732e6c696d610d0a53656e686120496e696369616c203a7361626172614032303236, NULL, 0, 'C', 'P', NULL, 'Inclusão de usuários de rede / computador', NULL, NULL, NULL, NULL, _binary 0x4e6f6d6520646f20757375c3a172696f203a204c75636173204d61746f7320646f732053616e746f73204c696d610d0a5061737461732064652061636573736f206e612072656465203a4d65696f20416d6269656e7465, '2026-04-17', '15:26:00', '2026-04-17', '16:26:00', 'C', 115, 54, NULL, NULL, NULL, NULL, 16, 16),
	(109, 16, 16, 11, 0, 0, 1, NULL, 7, NULL, '2026-04-17', '15:28:10', '2026-04-17', '15:28:00', NULL, NULL, NULL, NULL, NULL, NULL, 'V', NULL, _binary 0x4c6f67696e20646f20557375c3a172696f203a6c756361732e6c696d610d0a53656e68612064652041636573736f203a313233343536, NULL, 0, 'C', 'P', NULL, 'Protocoloweb - Inclusão de novo Usuário', NULL, NULL, NULL, NULL, _binary 0x4e6f6d6520646f20557375c3a172696f3a204c75636173204d61746f7320646f732053616e746f73204c696d610d0a4350463a206ec3a36f20696e666f726d61646f0d0a4c6f63616973206465205472616d697461c3a7c3a36f203a4d65696f20416d6269656e7465, '2026-04-17', '15:28:00', '2026-04-17', '15:58:00', 'C', 116, 62, NULL, NULL, NULL, NULL, 16, 16),
	(110, 16, 16, 7, 0, 0, 1, NULL, 11, NULL, '2026-04-22', '11:13:08', '2026-04-22', '11:44:00', NULL, NULL, NULL, NULL, NULL, NULL, 'V', NULL, _binary 0x466f6920616c746572616461206120706f727461206e6f207261636b2063656e7472616c2e20546573746573207265616c697a61646f73206f6b, NULL, 0, 'C', 'P', NULL, 'Internet - sem acesso', NULL, NULL, NULL, NULL, _binary 0x6c6f63616c203a436f6d70757461646f72206461204d6172696120436c61726120646f20706c616e656a616d656e746f2073656d20696e7465726e6574, '2026-04-22', '11:13:00', '2026-04-22', '14:13:00', 'C', 117, 43, NULL, NULL, NULL, NULL, 16, 28),
	(111, 16, 16, 6, 0, 0, 1, NULL, 7, NULL, '2026-04-22', '11:38:26', '2026-04-22', '11:38:00', NULL, NULL, NULL, NULL, NULL, NULL, 'V', NULL, _binary 0x4c6f67696e20646f20557375c3a172696f3a206a65616e2e726f7175650d0a53656e686120496e696369616c203a207361626172614032303236, NULL, 0, 'C', 'P', NULL, 'Inclusão de usuários de rede / computador', NULL, NULL, NULL, NULL, _binary 0x4e6f6d6520646f20757375c3a172696f203a4a65616e204361726c6f73204d61636172696f20526f7175650d0a5061737461732064652061636573736f206e612072656465203a41646d696e6973747261c3a7c3a36f2065207472616e73706f727465, '2026-04-22', '11:38:00', '2026-04-22', '12:38:00', 'C', 118, 54, NULL, NULL, NULL, NULL, 16, 16),
	(112, 16, 16, 6, 0, 0, 1, NULL, 7, NULL, '2026-04-22', '11:41:01', '2026-04-22', '11:41:00', NULL, NULL, NULL, NULL, NULL, NULL, 'V', NULL, _binary 0x557375c3a172696f2064652041636573736f203a206a65616e2e726f7175650d0a53656e68612064652041636573736f203a73616261726140323032360d0a0d0a557375c3a172696f20646f287329206dc3b364756c6f287329203a6a65616e2e726f7175650d0a53656e686120646f287329206dc3b364756c6f287329203a7361626172614032303236, NULL, 0, 'C', 'P', NULL, 'Sistema Moderna - Criação de Usuário', NULL, NULL, NULL, NULL, _binary 0x4e6f6d6520646f20757375c3a172696f203a4a65616e204361726c6f73204d61636172696f20526f7175650d0a6ec3ba6d65726f20646f20435046203a203132382e3430392e3536362d35390d0a4d6f64756c6f7320717565206972c3a120616365737361722028636f6d707261732c206573746f7175652c20636f6e746162696c69646164652c2070726567c3a36f2c20637265646f7265732c2066726f7461732c20707265737461c3a7c3a36f20646520636f6e7461732c2070617472696dc3b46e696f203a436f6d707261730d0a0d0a, '2026-04-22', '11:41:00', '2026-04-22', '13:41:00', 'C', 119, 15, NULL, NULL, NULL, NULL, 16, 16),
	(113, 16, 16, 6, 0, 0, 1, NULL, 7, NULL, '2026-04-22', '11:44:25', '2026-04-22', '11:44:00', NULL, NULL, NULL, NULL, NULL, NULL, 'V', NULL, _binary 0x4c6f67696e20646f20557375c3a172696f203a6a65616e2e726f7175650d0a53656e68612064652041636573736f203a313233343536, NULL, 0, 'C', 'P', NULL, 'Protocoloweb - Inclusão de novo Usuário', NULL, NULL, NULL, NULL, _binary 0x4e6f6d6520646f20557375c3a172696f3a204a65616e204361726c6f73204d61636172696f20526f7175650d0a4350463a3132382e3430392e3536362d35390d0a4c6f63616973206465205472616d697461c3a7c3a36f203a5472616e73706f727465, '2026-04-22', '11:44:00', '2026-04-22', '12:14:00', 'C', 120, 62, NULL, NULL, NULL, NULL, 16, 16),
	(114, 30, 30, 11, 17, 0, 26, NULL, 12, NULL, '2026-04-23', '11:08:39', '2026-04-23', '11:18:00', NULL, NULL, NULL, NULL, NULL, NULL, 'R', NULL, _binary 0x61646420616f20646f6dc3ad6e696f, NULL, 0, 'C', 'P', NULL, 'Desktop - Incluir desktop na rede', NULL, NULL, NULL, NULL, _binary 0x50617472696dc3b46e696f203a2039373335340d0a0d0a46616c686120646520636f6e6669616ec3a7612028646f6dc3ad6e696f29, '2026-04-23', '11:08:00', '2026-04-24', '11:08:00', 'C', 121, 24, NULL, NULL, NULL, NULL, 30, 30),
	(115, 30, 30, 14, 0, 0, 26, NULL, 12, NULL, '2026-04-23', '08:00:08', '2026-04-24', '09:07:00', NULL, NULL, NULL, NULL, NULL, NULL, 'V', NULL, _binary 0x41636f6d70616e68616d656e746f20656665747561646f20636f6d207375636573736f, NULL, 0, 'C', 'P', NULL, 'Acompanhamento de serviço de TI', NULL, NULL, NULL, NULL, _binary 0x446573637269c3a7c3a36f20646f205365727669c3a76f3a2041636f6d70616e68616d656e746f206e61206d7564616ec3a761206465206c6f63616c2066c3ad7369636f20646f73206465736b746f70, '2026-04-23', '11:21:00', '2026-04-23', '17:00:00', 'C', 122, 59, NULL, NULL, NULL, NULL, 30, 16),
	(116, 30, 30, 7, 0, 0, 26, NULL, 12, NULL, '2026-04-23', '11:37:39', '2026-04-24', '09:09:00', NULL, NULL, NULL, NULL, NULL, NULL, 'V', NULL, _binary 0x41636f6d70616e68616d656e746f207265616c697a61646f20636f6d207375636573736f, NULL, 0, 'C', 'P', NULL, 'Acompanhamento de serviço de TI', NULL, NULL, NULL, NULL, _binary 0x446573637269c3a7c3a36f20646f205365727669c3a76f3a2041636f6d70616e68616d656e746f206e61206d7564616ec3a761206465206c6f63616c2066c3ad7369636f20646f73206465736b746f702c207365746f72206465204172717569746574757261, '2026-04-23', '11:37:00', '2026-04-23', '19:37:00', 'C', 123, 59, NULL, NULL, NULL, NULL, 30, 16),
	(117, 30, 30, 8, 0, 0, 26, NULL, 12, NULL, '2026-04-23', '08:00:40', '2026-04-24', '09:09:00', NULL, NULL, NULL, NULL, NULL, NULL, 'V', NULL, _binary 0x41636f6d70616d656e746f207265616c697a61646f20636f6d207375636573736f, NULL, 0, 'C', 'P', NULL, 'Acompanhamento de serviço de TI', NULL, NULL, NULL, NULL, _binary 0x446573637269c3a7c3a36f20646f205365727669c3a76f3a2041636f6d70616e68616d656e746f206e61206d7564616ec3a761206465206c6f63616c2066c3ad7369636f20646f73206465736b746f7020287365746f722064652046697363616c697a61c3a7c3a36f29, '2026-04-23', '11:39:00', '2026-04-23', '17:00:00', 'C', 124, 59, NULL, NULL, NULL, NULL, 30, 16),
	(118, 30, 30, 9, 0, 0, 26, '2026-04-27', 12, '13:10:00', '2026-04-23', '11:42:00', '2026-04-28', '14:46:00', '2026-04-27', '2026-04-27', '13:10:00', '2026-04-27', NULL, NULL, 'V', '', _binary 0x5365727669c3a76f207265616c697a61646f20636f6d207375636573736f, 0, 0, 'C', 'P', '', 'Impressora - Scanner', NULL, 'C', '', NULL, _binary 0x53454c4220646120696d70726573736f72613a20436f6e666967757261c3a7c3a36f206465207363616e6e65722c206e6120526567696f6e616c2043656e74726f, '2026-04-23', '11:42:00', '2026-04-27', '11:42:00', 'C', 125, 35, NULL, NULL, NULL, NULL, 30, 16),
	(119, 28, 28, 8, 0, 0, 1, NULL, 11, NULL, '2026-04-23', '14:29:04', '2026-04-23', '14:29:00', NULL, NULL, NULL, NULL, NULL, NULL, 'V', NULL, _binary 0x496e7374616c61c3a7c3a36f207265616c697a61646120636f6d207375636573736f2c20746573746573206f6b, NULL, 0, 'C', 'P', NULL, 'Instalação', NULL, NULL, NULL, NULL, _binary 0x4e6f766f206d6f6e69746f72207061726120436f6e746162696c6964616465, '2026-04-23', '14:29:00', '2026-04-23', '15:29:00', 'C', 126, 75, NULL, NULL, NULL, NULL, 28, 28),
	(120, 16, 16, 9, 0, 0, 26, NULL, 8, NULL, '2026-04-24', '09:15:24', '2026-04-24', '15:00:00', NULL, NULL, NULL, NULL, NULL, NULL, 'V', NULL, _binary 0x4361626f2064652052656465204c6962657261646f, NULL, 0, 'C', 'P', NULL, 'Confecção de Cabo de Rede', NULL, NULL, NULL, NULL, _binary 0x4c6f63616c206120736572207574696c697a61646f203a2053656372657461726961206465204f627261732028416c6578616e647261290d0a54616d616e686f20656d204d6574726f203a2034206d6574726f7320, '2026-04-24', '09:15:00', '2026-04-24', '12:15:00', 'C', 127, 76, NULL, NULL, NULL, NULL, 16, 16),
	(121, 16, 16, 7, 0, 0, 26, NULL, 8, NULL, '2026-04-24', '09:20:26', '2026-04-24', '15:02:00', NULL, NULL, NULL, NULL, NULL, NULL, 'V', NULL, _binary 0x4d616e7574656ec3a7c3a36f20646f20706f6e746f2064652072656465207265616c697a61646120636f6d207375636573736f, NULL, 0, 'C', 'P', NULL, 'Manutenção de Ponto de Rede', NULL, NULL, NULL, NULL, _binary 0x4c6f63616c3a506f6e746f206461206dc3a17175696e61206465204d6172696120436c617261206e6f20706c616e656a616d656e746f0d0a4ec3ba6d65726f20646520706f6e746f73203a31, '2026-04-24', '09:20:00', '2026-04-24', '11:50:00', 'C', 128, 68, NULL, NULL, NULL, NULL, 16, 16),
	(122, 28, 28, 32, 0, 0, 1, NULL, 11, NULL, '2026-04-24', '15:59:49', '2026-04-24', '16:04:00', NULL, NULL, NULL, NULL, NULL, NULL, 'V', NULL, _binary 0x466f72616d20696e7374616c61646f7320646f6973206361626f73202873656e646f203120646520726573657276612920436174203565206465206170726f78696d6164616d656e74652035206d6574726f73206e61206e6f76612073616c6120646f20436f6e74726f6c61646f7220476572616c2e20546573746573206f6b2e, NULL, 0, 'C', 'P', NULL, 'Instalação de Ponto de rede', NULL, NULL, NULL, NULL, _binary 0x4c6f63616c3a2053616c6120646f20436f6e74726f6c61646f720d0a4ec3ba6d65726f20646520706f6e746f733a2032, '2026-04-24', '15:59:00', '2026-04-25', '15:59:00', 'C', 129, 48, NULL, NULL, NULL, NULL, 28, 28),
	(123, 16, 16, 11, 18, 0, 26, NULL, 12, NULL, '2026-04-27', '10:27:45', '2026-04-30', '16:53:00', NULL, NULL, NULL, NULL, NULL, NULL, 'R', NULL, _binary 0x417475616c697a61646f2062696f732c206465667261672064652048642065206c696d70657361206465206172717569766f730d0a0d0a4d617175696e61206c6962657261646120636f6d20626f612066756e63696f6e616c6964616465, NULL, 0, 'C', 'P', NULL, 'Desktop - Lentidão do desktop', NULL, NULL, NULL, NULL, _binary 0x50617472696dc3b56e696f20646f20436f6d70757461646f72203a20696e666f726d61646f206e6f20636164617374726f0d0a557375c3a172696f3a44696f676f204e756e65730d0a0d0a436f6d70757461646f7220636f6d206c656e746964c3a36f206e6563657373c3a172696f20666f726d617461c3a7c3a36f, '2026-04-27', '10:28:00', '2026-04-30', '10:27:00', 'C', 130, 19, NULL, NULL, NULL, NULL, 16, 16),
	(124, 16, 16, 8, 0, 0, 1, NULL, 7, NULL, '2026-04-27', '12:07:46', '2026-04-27', '14:07:00', NULL, NULL, NULL, NULL, NULL, NULL, 'V', NULL, _binary 0x41706c6963617469766f20696e7374616c61646f20636f6d207375636573736f, NULL, 0, 'C', 'P', NULL, 'Instalação do aplicativo no computador', NULL, NULL, NULL, NULL, _binary 0x4c6f63616c3a436f6e746162696c69646164650d0a557375c3a172696f3a4d6172696120476f756c617274, '2026-04-27', '12:07:00', '2026-04-27', '14:37:00', 'C', 131, 77, NULL, NULL, NULL, NULL, 16, 16),
	(125, 16, 16, 30, 19, 0, 26, NULL, 12, NULL, '2026-04-27', '15:58:49', '2026-04-28', '16:44:00', NULL, NULL, NULL, NULL, NULL, NULL, 'R', NULL, _binary 0x436f6e636c7573c3a36f203a2053697374656d61204f7065726163696f6e616c20696e7374616c61646f2c20617475616c697a61646f206520636f6e666967757261646f3b202270726f6772616d61732070616472c3a36f2220696e7374616c61646f733b2061646963696f6e61646f20616f20646f6dc3ad6e696f20504d533b2061646963696f6e61646f20757375c3a172696f2061646d696e6973747261646f722e, NULL, 0, 'C', 'P', NULL, 'Manutenção de Computadores DeskTop', NULL, NULL, NULL, NULL, _binary 0x496e7374616c61c3a7c3a36f206520436f6e666967757261c3a7c3a36f2064652073697374656d61206f7065726163696f6e616c204c696e7578, '2026-04-27', '15:59:00', '2026-04-30', '15:58:00', 'C', 132, 70, NULL, NULL, NULL, NULL, 16, 30),
	(126, 28, 28, 7, 0, 0, 1, NULL, 11, NULL, '2026-04-27', '16:17:12', '2026-04-27', '16:17:00', NULL, NULL, NULL, NULL, NULL, NULL, 'V', NULL, _binary 0x496d70726573736f726120696e7374616c6164612070617261207365727669646f726120456c656d2e20746573746573206f6b21, NULL, 0, 'C', 'P', NULL, 'Impressoras - Instalação', NULL, NULL, NULL, NULL, _binary 0x696e7374616c61c3a7c3a36f20646520696d70726573736f726120646f2052482070617261207365746f722064652066697363616c697a61c3a7c3a36f, '2026-04-27', '16:17:00', '2026-04-27', '18:17:00', 'C', 133, 36, NULL, NULL, NULL, NULL, 28, 28),
	(127, 16, 16, 8, 0, 0, 1, NULL, 7, NULL, '2026-04-27', '16:20:15', '2026-04-27', '16:20:00', NULL, NULL, NULL, NULL, NULL, NULL, 'V', NULL, _binary 0x4c6f67696e20646f20557375c3a172696f3a6d617269612e7861766965720d0a53656e686120496e696369616c203a7361626172614032303236, NULL, 0, 'C', 'P', NULL, 'Inclusão de usuários de rede / computador', NULL, NULL, NULL, NULL, _binary 0x4e6f6d6520646f20757375c3a172696f203a204d61726961204c75697a6120466572726569726120526f64726967756573205861766965720d0a5061737461732064652061636573736f206e612072656465203a6661436164617374726f, '2026-04-27', '16:20:00', '2026-04-27', '17:20:00', 'C', 134, 54, NULL, NULL, NULL, NULL, 16, 16),
	(128, 16, 16, 28, 0, 0, 1, NULL, 7, NULL, '2026-04-28', '09:54:16', '2026-04-28', '09:54:00', NULL, NULL, NULL, NULL, NULL, NULL, 'V', NULL, _binary 0x557375c3a172696f2064652041636573736f203a4ac3a120706f737375690d0a53656e68612064652041636573736f203a4ac3a120706f737375690d0a0d0a557375c3a172696f20646f287329206dc3b364756c6f287329203a206d617269616e612e746f6d617a0d0a53656e686120646f287329206dc3b364756c6f287329203a7361626172614032303236, NULL, 0, 'C', 'P', NULL, 'Sistema Moderna - Criação de Usuário', NULL, NULL, NULL, NULL, _binary 0x4e6f6d6520646f20757375c3a172696f203a4d617269616e612056697267696e696120546f6d617a206465204d616365646f0d0a6ec3ba6d65726f20646f20435046203a203037342e3933302e3530362d31390d0a4d6f64756c6f7320717565206972c3a120616365737361722028636f6d707261732c206573746f7175652c20636f6e746162696c69646164652c2070726567c3a36f2c20637265646f7265732c2066726f7461732c20707265737461c3a7c3a36f20646520636f6e7461732c2070617472696dc3b46e696f203a4573746f7175650d0a0d0a, '2026-04-28', '09:54:00', '2026-04-28', '11:54:00', 'C', 135, 15, NULL, NULL, NULL, NULL, 16, 16),
	(129, 16, 16, 7, 0, 0, 26, NULL, 12, NULL, '2026-04-28', '11:38:06', '2026-04-28', '14:45:00', NULL, NULL, NULL, NULL, NULL, NULL, 'V', NULL, _binary 0x526570617261c3a7c3a36f20666569746120636f6d207375636573736f2e20417475616c697a61c3a7c3a36f2020646f206f666669636520333635, NULL, 0, 'C', 'P', NULL, 'Reparo de software', NULL, NULL, NULL, NULL, _binary 0x446573637269c3a7c3a36f20646f20736f667477617265203a6f66666963650d0a506f73737569206c6963656ec3a7613f202873696d2f4ec3a36f29203a2053696d, '2026-04-28', '11:38:00', '2026-04-28', '13:38:00', 'C', 137, 52, NULL, NULL, NULL, NULL, 16, 16),
	(130, 16, 16, 8, 0, 0, 26, NULL, 12, NULL, '2026-04-29', '10:02:40', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'V', NULL, NULL, NULL, NULL, 'C', 'P', NULL, 'Instalação de Software', NULL, NULL, NULL, NULL, _binary 0x506f73737569204c6963656ec3a7612873696d2f6ec3a36f29203f2073696d0d0a446573637269c3a7c3a36f20646f20736f66747761726520612073657220696e7374616c61646f3a20676572656e636961646f72206465207365677572616ec3a76120646f2042616e636f20646f2042726173696c, '2026-04-29', '10:02:00', '2026-04-29', '12:02:00', 'X', 139, 28, '2026-04-29', _binary 0x536f6674776172652064652067657374c3a36f206465207365677572616ec3a76120646f2062616e636f20646f2062726173696c20766f6c746f7520612066756e63696f6e6172, '10:37:00', 16, 16, NULL),
	(131, 16, 16, 7, 0, 0, 26, '2026-04-29', 8, '14:59:00', '2026-04-29', '11:23:00', '2026-04-30', '16:51:00', '2026-04-29', '2026-04-29', '14:59:00', '2026-04-29', NULL, NULL, 'V', '', _binary 0x32206e6f766f7320706f6e746f7320617469766f730d0a496d70726573736f7261206174697661206e6120726564650d0a3320706373206c696e757820636f6e666967757261646f730d0a706f6e746f732072656174697661646f73206e6f20706174636870616e656c, 0, 0, 'C', 'P', '', 'Instalação de Ponto de rede', NULL, 'C', '', NULL, _binary 0x4c6f63616c3a70726f636f6e0d0a4ec3ba6d65726f20646520706f6e746f73203a203320706f6e746f732064652072656465, '2026-04-29', '11:26:00', '2026-04-29', '17:00:00', 'C', 140, 48, NULL, NULL, NULL, NULL, 16, 16),
	(132, 16, 16, 7, 0, 0, 26, NULL, 8, NULL, '2026-04-29', '12:02:14', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'V', NULL, NULL, NULL, NULL, 'C', 'P', NULL, 'Instalação de Ponto de rede', NULL, NULL, NULL, NULL, _binary 0x4c6f63616c3a2050726f636f6e206465205361626172c3a10d0a4ec3ba6d65726f20646520706f6e746f733a3220706f6e746f732070617261206c69676172203220636f6d70757461646f726573, '2026-04-29', '12:02:00', '2026-04-29', '17:02:00', 'X', 59, 48, '2026-04-29', _binary 0x4f7264656d2067657261646120656d206475706c69636964616465, '12:02:00', 16, 16, NULL),
	(133, 28, 28, 31, 0, 0, 1, NULL, 11, NULL, '2026-04-30', '13:51:03', '2026-04-30', '13:51:00', NULL, NULL, NULL, NULL, NULL, NULL, 'V', NULL, _binary 0x5465737465732064652070696e67206573746176616d206f6b2065207265616c6d656e746520706172616c69736f75206f207365727669c3a76f20646520696e7465726e657420656d2076c3a172696f73206e6176656761646f7265732c206170c3b373207265696ec3ad63696f20646f20636f6d70757461646f72207265616c697a61646f20746573746573206520636f6e6669726d61646f2070656c6f20757375c3a172696f2071756520657374617661206f6b, NULL, 0, 'C', 'P', NULL, 'Internet - sem acesso', NULL, NULL, NULL, NULL, _binary 0x6c6f63616c203a20476162696e65746520646f20507265666569746f2c204c65616e64726f2c20636f6d70757461646f72206170726573656e7461206c656e746964c3a36f20706172612061636573736172207369746573, '2026-04-30', '13:51:00', '2026-04-30', '16:51:00', 'C', 141, 43, NULL, NULL, NULL, NULL, 28, 28),
	(134, 16, 16, 10, 0, 0, 1, NULL, 7, NULL, '2026-04-30', '14:34:20', '2026-04-30', '14:35:00', NULL, NULL, NULL, NULL, NULL, NULL, 'V', NULL, _binary 0x526573706f6e73c3a176656c2070656c6f207472616e73706f7274653a536563726574c3a172696120646f20436172732043617374616e68656972612028506174726963696129, 0, 0, 'C', 'P', NULL, 'Impressoras - Solicitação de toner', NULL, NULL, NULL, NULL, _binary 0x435241532043617374616e686569726173, '2026-04-30', '14:34:00', '2026-04-30', '15:04:00', 'C', 142, 41, NULL, NULL, NULL, NULL, 16, 16),
	(135, 30, 30, 8, 20, 0, 26, NULL, 12, NULL, '2026-05-04', '15:13:19', '2026-05-04', '16:49:00', NULL, NULL, NULL, NULL, NULL, NULL, 'R', NULL, _binary 0x4c696d70657a6173206520617475616c697a61c3a7c3b56573207265616c697a616461732e200d0a28436f6e73696465726f206f20636f6d70757461646f72202266696e616c206465206d6569612d7669646122292e, NULL, 0, 'C', 'P', NULL, 'Desktop - Lentidão do desktop', NULL, NULL, NULL, NULL, _binary 0x50617472696dc3b56e696f20646f20436f6d70757461646f72203a2038333333320d0a557375c3a172696f3a206c756369616e652e6669726d6f0d0a0d0a5043206170726573656e7461206c656e746964c3a36f3b207265616c697a6172206c696d70657a613b207265616c697a617220617475616c697a61c3a7c3a36f20646520647269766572732e, '2026-05-04', '15:13:00', '2026-05-06', '15:13:00', 'C', 143, 19, NULL, NULL, NULL, NULL, 30, 30),
	(136, 16, 16, 6, 0, 0, 1, NULL, 7, NULL, '2026-05-05', '09:36:11', '2026-05-05', '09:36:00', NULL, NULL, NULL, NULL, NULL, NULL, 'V', NULL, _binary 0x4c6f67696e20646f20557375c3a172696f3a4672616e6b6c696e2e68696c6172696f0d0a53656e686120496e696369616c203a205361626172614032303236, NULL, 0, 'C', 'P', NULL, 'Inclusão de usuários de rede / computador', NULL, NULL, NULL, NULL, _binary 0x4e6f6d6520646f20757375c3a172696f203a4672616e6b6c696e2e68696c6172696f0d0a5061737461732064652061636573736f206e612072656465203a2061646d696e6973747261c3a7c3a36f, '2026-05-05', '09:36:00', '2026-05-05', '10:36:00', 'C', 144, 54, NULL, NULL, NULL, NULL, 16, 16),
	(137, 16, 16, 8, 20, 0, 26, NULL, 8, NULL, '2026-05-05', '10:37:58', '2026-05-08', '09:34:00', NULL, NULL, NULL, NULL, NULL, NULL, 'R', NULL, _binary 0x417475616c697a61c3a7c3a36f20646520647269766572733b20, NULL, 0, 'C', 'P', NULL, 'Desktop - Travamento', NULL, NULL, NULL, NULL, _binary 0x50617472696dc3b46e696f203a38333333320d0a, '2026-05-05', '10:38:00', '2026-05-07', '10:37:00', 'C', 145, 22, NULL, NULL, NULL, NULL, 16, 30),
	(138, 16, 16, 5, 0, 0, 27, NULL, 9, NULL, '2026-05-05', '11:39:18', '2026-05-08', '11:35:00', NULL, NULL, NULL, NULL, NULL, NULL, 'V', NULL, _binary 0x466f6920646973706f6e6962696c697a61646f205365727669646f72205669727475616c207061726120696e7374616c61c3a7c3a36f20646f20736f667477617265, NULL, 0, 'C', 'P', NULL, 'Desktop - Solicitação de Novo Computador', NULL, NULL, NULL, NULL, _binary 0x557375c3a172696f203a204f727465700d0a41746976696461646520612073657220657865637574616461203a436f6d70757461646f7220706172612073697374656d61206461204f727465702064652072656cc3b367696f20646520706f6e746f2064612073656372657461726961206465205361c3ba646520, '2026-05-05', '11:39:00', '2026-05-08', '11:39:00', 'C', 146, 9, NULL, NULL, NULL, NULL, 16, 16),
	(139, 16, 16, 29, 0, 0, 1, NULL, 7, NULL, '2026-05-05', '14:37:35', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'V', NULL, NULL, NULL, NULL, 'C', 'P', NULL, 'Emprestimo de Projetor', NULL, NULL, NULL, NULL, _binary 0x526573706f6e73c3a176656c3a4c75646d696c6120646f732053616e746f73204d617274696e730d0a44617461206520686f72613a2032312f30352f323032362c20c3a0732031306830300d0a4d6f7469766f3a7265756e69c3a36f20636f6d20726570726573656e74616e7465732064612056616c6520652044656665736120436976696c2064652053616e7461204c757a69610d0a4c6f63616c3a536f6c617220506164726520636f7272656961, '2026-05-05', '14:37:00', '2026-05-22', '14:38:00', 'A', 147, 78, NULL, NULL, NULL, NULL, 16, NULL),
	(140, 16, 16, 28, 0, 0, 1, NULL, 7, NULL, '2026-05-05', '14:47:35', '2026-05-05', '14:48:00', NULL, NULL, NULL, NULL, NULL, NULL, 'V', NULL, _binary 0x526573706f6e73c3a176656c2070656c6f207472616e73706f7274653a4d6f746f726973746120646120437265636865, 0, 0, 'C', 'P', NULL, 'Impressoras - Solicitação de toner', NULL, NULL, NULL, NULL, _binary 0x536520666f7220696d70726573736f726120636f6c6f726964612c207175616c206120636f7220746f20746f6e6572203f3a0d0a53454c4220646120496d70726573736f7261203a437265636865, '2026-05-05', '14:47:00', '2026-05-05', '15:17:00', 'C', 148, 41, NULL, NULL, NULL, NULL, 16, 16),
	(141, 16, 16, 10, 0, 0, 1, NULL, 11, NULL, '2026-05-05', '16:48:46', '2026-05-05', '16:49:00', NULL, NULL, NULL, NULL, NULL, NULL, 'V', NULL, _binary 0x526573706f6e73c3a176656c2070656c6f207472616e73706f7274653a436f6e73656c686f20547574656c6172, 0, 0, 'C', 'P', NULL, 'Impressoras - Solicitação de toner', NULL, NULL, NULL, NULL, _binary 0x536520666f7220696d70726573736f726120636f6c6f726964612c207175616c206120636f7220746f20746f6e6572203f3a0d0a53454c4220646120496d70726573736f7261203a436f6e73656c686f20547574656c6172, '2026-05-05', '16:48:00', '2026-05-05', '17:18:00', 'C', 149, 41, NULL, NULL, NULL, NULL, 16, 16),
	(142, 16, 16, 28, 0, 0, 1, NULL, 11, NULL, '2026-05-07', '08:59:14', '2026-05-07', '09:00:00', NULL, NULL, NULL, NULL, NULL, NULL, 'V', NULL, _binary 0x526573706f6e73c3a176656c2070656c6f207472616e73706f7274653a41647269616e61, 0, 0, 'C', 'P', NULL, 'Impressoras - Solicitação de toner', NULL, NULL, NULL, NULL, _binary 0x536520666f7220696d70726573736f726120636f6c6f726964612c207175616c206120636f7220746f20746f6e6572203f3a0d0a53454c4220646120496d70726573736f7261203a436569204e616e637920426f72676573, '2026-05-07', '08:59:00', '2026-05-07', '09:29:00', 'C', 150, 41, NULL, NULL, NULL, NULL, 16, 16),
	(143, 16, 16, 7, 0, 0, 26, '2026-05-07', 12, '17:02:00', '2026-05-07', '11:17:00', '2026-05-08', '09:35:00', '2026-05-07', '2026-05-07', '17:02:00', '2026-05-07', NULL, NULL, 'V', '', _binary 0x417475616c697a61c3a7c3a36f20646520647269766572733b2074726f6361206465206361626f205647412e, 0, 0, 'C', 'P', '', 'Monitor - Sem Imagem', NULL, 'C', '', NULL, _binary 0x50617472696dc3b46e696f203a6ec3a36f20696e666f726d61202d20436f6d70757461646f722064612073746166616e790d0a436865636f75206361626f7320646520656e65726769612065206461646f73202873696d2f6ec3a36f29203a2053696d0d0a4361626f2076676120646120736567756e64612074656c6120636f6d2070726f626c656d612e20, '2026-05-07', '11:17:00', '2026-05-09', '11:17:00', 'C', 151, 26, NULL, NULL, NULL, NULL, 16, 30),
	(144, 16, 16, 6, 0, 0, 1, NULL, 7, NULL, '2026-05-07', '11:20:54', '2026-05-07', '11:44:00', NULL, NULL, NULL, NULL, NULL, NULL, 'V', NULL, _binary 0x557375c3a172696f2064652041636573736f203a6a756c69616e612e73616e746f730d0a53656e68612064652041636573736f203a73616261726140323032360d0a0d0a557375c3a172696f20646f287329206dc3b364756c6f287329203a6a756c69616e612e73616e746f730d0a53656e686120646f287329206dc3b364756c6f287329203a7361626172614032303236, NULL, 0, 'C', 'P', NULL, 'Sistema Moderna - Criação de Usuário', NULL, NULL, NULL, NULL, _binary 0x4e6f6d6520646f20757375c3a172696f203a4a756c69616e612053616e746f73206465204d6f72616973c2a00d0a6ec3ba6d65726f20646f20435046203a31303532353736383639360d0a4d6f64756c6f7320717565206972c3a120616365737361722028636f6d707261732c206573746f7175652c20636f6e746162696c69646164652c2070726567c3a36f2c20637265646f7265732c2066726f7461732c20707265737461c3a7c3a36f20646520636f6e7461732c2070617472696dc3b46e696f203a0d0a61636573736f206e6f2050617472696dc3b46e696f202d20436f6e746162696c69646164652065204573746f7175650d0a0d0a, '2026-05-07', '11:21:00', '2026-05-07', '13:20:00', 'C', 152, 15, NULL, NULL, NULL, NULL, 16, 16),
	(145, 16, 16, 28, 0, 0, 26, NULL, 12, NULL, '2026-05-07', '13:56:24', '2026-05-07', '13:57:00', NULL, NULL, NULL, NULL, NULL, NULL, 'V', NULL, _binary 0x526573706f6e73c3a176656c2070656c6f207472616e73706f7274653a526573706f6e73c3a176656c20646120437265636865, 0, 0, 'C', 'P', NULL, 'Impressoras - Solicitação de toner', NULL, NULL, NULL, NULL, _binary 0x536520666f7220696d70726573736f726120636f6c6f726964612c207175616c206120636f7220746f20746f6e6572203f3a0d0a53454c4220646120496d70726573736f7261203a63726563686520506572646967c3a36f20646520526fc3a761204772616e6465, '2026-05-07', '13:56:00', '2026-05-07', '14:26:00', 'C', 153, 41, NULL, NULL, NULL, NULL, 16, 16),
	(146, 28, 28, 7, 0, 0, 1, NULL, 11, NULL, '2026-05-07', '15:16:52', '2026-05-07', '15:17:00', NULL, NULL, NULL, NULL, NULL, NULL, 'V', NULL, _binary 0x466f6920696e7374616c61646120656d2064756173206dc3a17175696e617320646f207365746f722064652047656f206f20736f66747761726520677261747569746f20514749532e2050617261206c65697475726120652063726961c3a7c3a36f206465206d6170617320656d20666f726d61746f2053484150452065204a534f4e2062656d20636f6d6f206c65722061732063616d6164617320637269616461732070656c6120656d707265736120546f706f63617274, NULL, 0, 'C', 'P', NULL, 'Desktop - Instalação e Desinstalação', NULL, NULL, NULL, NULL, _binary 0x50617472696d6f6e696f3a0d0a496e7374616c61c3a7c3a36f20646f20736f667477617265205147495320656d2064756173206dc3a17175696e617320646f207365746f722064652047656f2e, '2026-05-07', '15:16:00', '2026-05-07', '17:16:00', 'C', 154, 23, NULL, NULL, NULL, NULL, 28, 28),
	(147, 30, 30, 7, 0, 0, 26, NULL, 12, NULL, '2026-05-07', '09:30:39', '2026-05-07', '17:18:00', NULL, NULL, NULL, NULL, NULL, NULL, 'V', NULL, _binary 0x466f72616d2074726f6361646f73206f73206361626f7320646520766964656f20285647412f48444d49293b20666f6920666569746120617475616c697a61c3a7c3a36f20646f7320647269766573206461206d617175696e613b207265696e696369616c697a61c3a7c3a36f2e, NULL, 0, 'C', 'P', NULL, 'Monitor - Não está Ligando', NULL, NULL, NULL, NULL, _binary 0x50617472696dc3b46e696f203a0d0a636865636f75206361626f7320646520656e6572676961202873696d2f6ec3a36f293f2073696d0d0a4d6f6e69746f722032206ec3a36f206170726573656e746120766964656f, '2026-05-07', '17:17:00', '2026-05-07', '13:00:00', 'C', 155, 25, NULL, NULL, NULL, NULL, 30, 30),
	(148, 30, 30, 7, 15, 0, 26, NULL, 12, NULL, '2026-05-07', '10:20:16', '2026-05-07', '17:27:00', NULL, NULL, NULL, NULL, NULL, NULL, 'R', NULL, _binary 0x5061636f7465204f6666696365203230313620646573696e7374616c61646f3b207265696e7374616c6c20646f207061636f7465204f666669636520323031363b20696e736572c3a7c3a36f20646f2073657269616c3b20, NULL, 0, 'C', 'P', NULL, 'Reparo de software', NULL, NULL, NULL, NULL, _binary 0x446573637269c3a7c3a36f20646f20736f667477617265203a0d0a506f73737569206c6963656ec3a7613f202873696d2f4ec3a36f29203a2053696d0d0a4f66666963652050726f66657373696f6e616c20506c75732032303136206ec3a36f206573746176612066756e63696f6e616e646f2e, '2026-05-07', '17:26:00', '2026-05-07', '12:40:00', 'C', 156, 52, NULL, NULL, NULL, NULL, 30, 30),
	(149, 16, 16, 18, 0, 0, 26, NULL, 8, NULL, '2026-05-11', '10:23:19', '2026-05-11', '14:12:00', NULL, NULL, NULL, NULL, NULL, NULL, 'V', NULL, _binary 0x466f69207265636f6e666967757261646f206120696d70726573736f7261206520696e7374616c61646f2064726976657273206e6f766f73206e6f7320636f6d70757461646f72657320636f6d206e6f766f2069702065203320636f6d70757461646f72657320646f207365746f72, NULL, 0, 'C', 'P', NULL, 'Impressoras - Não está imprimindo', NULL, NULL, NULL, NULL, _binary 0x53454c4220646120496d70726573736f7261203a526567696f6e616c20416e61204c756369610d0a496d70726573736f7261206170726573656e74616e646f206d656e736167656d206f6666206c696e65, '2026-05-11', '10:23:00', '2026-05-11', '17:00:00', 'C', 157, 38, NULL, NULL, NULL, NULL, 16, 16),
	(150, 16, 16, 10, 0, 0, 1, NULL, 7, NULL, '2026-05-11', '11:54:44', '2026-05-11', '11:55:00', NULL, NULL, NULL, NULL, NULL, NULL, 'V', NULL, _binary 0x526573706f6e73c3a176656c2070656c6f207472616e73706f7274653a4a6f6e617468656e2046656c6978, 0, 0, 'C', 'P', NULL, 'Impressoras - Solicitação de toner', NULL, NULL, NULL, NULL, _binary 0x536520666f7220696d70726573736f726120636f6c6f726964612c207175616c206120636f7220746f20746f6e6572203f3a507265746f0d0a53454c4220646120496d70726573736f7261203a494d343330, '2026-05-11', '11:54:00', '2026-05-11', '12:24:00', 'C', 158, 41, NULL, NULL, NULL, NULL, 16, 16),
	(151, 16, 16, 29, 0, 0, 1, NULL, 7, NULL, '2026-05-11', '14:17:57', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'V', NULL, NULL, NULL, NULL, 'C', 'P', NULL, 'Inclusão de usuários de rede / computador', NULL, NULL, NULL, NULL, _binary 0x5061726120696e736572c3a7c3a36f20646f73207365727669646f726573206e6120726564652064612044656665736120436976696c2c2073656775656d206f73206c6f67696e7320646f7320757375c3a172696f733a0d0a6c75646d696c612e6d617274696e730d0a76697669616e652e6170617265636964610d0a6665726e616e64612e7669746f7269610d0a646f75676c61732e6d617274696e730d0a6775696c6865726d652e6d656e6465730d0a7961736d696e2e7269626569726f0d0a7061756c6f2e726f67c3a972696f0d0a706564726f2e7061756c6f0d0a72616661656c2e616c6d656964610d0a6c65616e64726f2e6564756172646f0d0a6a6f6e617461732e7669616e61, '2026-05-11', '14:18:00', '2026-05-12', '15:17:00', 'A', 159, 54, NULL, NULL, NULL, NULL, 16, NULL),
	(152, 16, 16, 28, 0, 0, 1, NULL, 7, NULL, '2026-05-11', '15:00:02', '2026-05-11', '15:02:00', NULL, NULL, NULL, NULL, NULL, NULL, 'V', NULL, _binary 0x526573706f6e73c3a176656c2070656c6f207472616e73706f7274653a5469206461204564756361c3a7c3a36f, 0, 0, 'C', 'P', NULL, 'Impressoras - Solicitação de toner', NULL, NULL, NULL, NULL, _binary 0x536520666f7220696d70726573736f726120636f6c6f726964612c207175616c206120636f7220746f20746f6e6572203f3a507265746f2065204d617267656e74610d0a53454c4220646120496d70726573736f7261203a4564756361c3a7c3a36f, '2026-05-11', '15:00:00', '2026-05-11', '15:30:00', 'C', 160, 41, NULL, NULL, NULL, NULL, 16, 16),
	(153, 28, 28, 7, 0, 0, 1, NULL, 11, NULL, '2026-05-11', '15:00:33', '2026-05-11', '15:02:00', NULL, NULL, NULL, NULL, NULL, NULL, 'V', NULL, _binary 0x746573746573206f6b, NULL, 0, 'C', 'P', NULL, 'Impressoras - Instalação', NULL, NULL, NULL, NULL, _binary 0x696e7374616c61c3a7c3a36f20696d70726573736f7261205248206e6f207365746f722064652050726f6a65746f73, '2026-05-11', '15:00:00', '2026-05-11', '17:00:00', 'C', 161, 36, NULL, NULL, NULL, NULL, 28, 28),
	(154, 28, 16, 6, 0, 0, 1, NULL, 7, NULL, '2026-05-11', '15:03:30', '2026-05-11', '15:06:00', NULL, NULL, NULL, NULL, NULL, NULL, 'V', NULL, _binary 0x696e7374616c61c3a7c3a36f206520746573746573206f6b, NULL, 0, 'C', 'P', NULL, 'Impressoras - Instalação', NULL, NULL, NULL, NULL, _binary 0x696e7374616c61c3a7c3a36f20696d70726573736f7261205248206e6f207365746f72206465205365727669c3a76f7320476572616973, '2026-05-11', '15:03:00', '2026-05-11', '17:03:00', 'C', 163, 36, NULL, NULL, NULL, NULL, 16, 28),
	(155, 16, 16, 7, 0, 0, 1, NULL, 7, NULL, '2026-05-11', '15:04:26', '2026-05-11', '15:05:00', NULL, NULL, NULL, NULL, NULL, NULL, 'V', NULL, _binary 0x526573706f6e73c3a176656c2070656c6f207472616e73706f7274653a4a656465616e2070617261206f20506564726f20, 0, 0, 'C', 'P', NULL, 'Impressoras - Solicitação de toner', NULL, NULL, NULL, NULL, _binary 0x536520666f7220696d70726573736f726120636f6c6f726964612c207175616c206120636f7220746f20746f6e6572203f3a4d617267656e74610d0a53454c4220646120496d70726573736f7261203a476162696e657465, '2026-05-11', '15:04:00', '2026-05-11', '15:34:00', 'C', 162, 41, NULL, NULL, NULL, NULL, 16, 16),
	(156, 28, 28, 33, 0, 0, 1, NULL, 11, NULL, '2026-05-11', '15:12:42', '2026-05-11', '15:13:00', NULL, NULL, NULL, NULL, NULL, NULL, 'V', NULL, _binary 0x466f72616d20696e7374616c61646f73206f207072696d6569726f2061636573736f2064612053757065726e6f76612070617261206f7320757375c3a172696f732063697461646f732066616c74616e646f206170656e6173206f2073697374656d612064652064c3ad7669646120617469766120612073657220696e7374616c61646f2070656c6f207365727669646f72204c656f6e6172646f, NULL, 0, 'C', 'P', NULL, 'Instalação do aplicativo no computador', NULL, NULL, NULL, NULL, _binary 0x4c6f63616c3a2050726f6a750d0a557375c3a172696f3a20497361736d696e2c2041647269616e612065204272756e6f, '2026-05-11', '15:12:00', '2026-05-11', '15:42:00', 'C', 164, 77, NULL, NULL, NULL, NULL, 28, 28),
	(157, 16, 16, 28, 0, 0, 1, NULL, 7, NULL, '2026-05-11', '16:57:29', '2026-05-11', '16:58:00', NULL, NULL, NULL, NULL, NULL, NULL, 'V', NULL, _binary 0x0d0a0d0a557375c3a172696f20646f287329206dc3b364756c6f287329203a61647269616e612e6c756369610d0a53656e686120646f287329206dc3b364756c6f287329203a7361626172614032303236, NULL, 0, 'C', 'P', NULL, 'Sistema Moderna - Criação de Usuário', NULL, NULL, NULL, NULL, _binary 0x4e6f6d653a2041647269616e61204cc3ba6369612064612053696c76610d0a4350463a203036382e3133322e3239362d39390d0a4d6f64756c6f7320717565206972c3a120616365737361722028636f6d707261732c206573746f7175652c20636f6e746162696c69646164652c2070726567c3a36f2c20637265646f7265732c2066726f7461732c20707265737461c3a7c3a36f20646520636f6e7461732c2070617472696dc3b46e696f203a4573746f7175650d0a0d0a, '2026-05-11', '16:57:00', '2026-05-11', '18:57:00', 'C', 165, 15, NULL, NULL, NULL, NULL, 16, 16),
	(158, 16, 16, 18, 0, 0, 1, NULL, 7, NULL, '2026-05-11', '17:03:51', '2026-05-11', '17:04:00', NULL, NULL, NULL, NULL, NULL, NULL, 'V', NULL, _binary 0x4c6f67696e20646f20557375c3a172696f3a6a6169726f2e6368617665730d0a53656e686120496e696369616c203a7361626172614032303236, NULL, 0, 'C', 'P', NULL, 'Inclusão de usuários de rede / computador', NULL, NULL, NULL, NULL, _binary 0x4e6f6d6520646f20757375c3a172696f203a204a6169726f20436861766573206465204f6c6976656972610d0a5061737461732064652061636573736f206e612072656465203a526567696f6e616973, '2026-05-11', '17:03:00', '2026-05-11', '18:03:00', 'C', 166, 54, NULL, NULL, NULL, NULL, 16, 16),
	(159, 16, 16, 6, 0, 0, 1, NULL, 7, NULL, '2026-05-12', '09:27:13', '2026-05-12', '09:31:00', NULL, NULL, NULL, NULL, NULL, NULL, 'V', NULL, _binary 0x4c6f67696e20646f20557375c3a172696f203a6a756c69616e612e73616e746f730d0a53656e68612064652041636573736f203a313233343536, NULL, 0, 'C', 'P', NULL, 'Protocoloweb - Inclusão de novo Usuário', NULL, NULL, NULL, NULL, _binary 0x4e6f6d6520646f20557375c3a172696f3a4a756c69616e612053616e746f73206465204d6f726169730d0a4350463a6ec3a36f20696e666f726d61646f0d0a4c6f63616973206465205472616d697461c3a7c3a36f203a41646d696e6973747261c3a7c3a36f20652070617472696d6f6e696f, '2026-05-12', '09:27:00', '2026-05-12', '09:57:00', 'C', 167, 62, NULL, NULL, NULL, NULL, 16, 16),
	(160, 16, 16, 10, 0, 0, 1, NULL, 7, NULL, '2026-05-12', '10:10:15', '2026-05-12', '10:14:00', NULL, NULL, NULL, NULL, NULL, NULL, 'V', NULL, _binary 0x757375c3a172696f203a64616e646172612e73616c65730d0a53656e6861207361626172614032303236, NULL, 0, 'C', 'P', NULL, 'Redefinição de senha de acesso rede / computador', NULL, NULL, NULL, NULL, _binary 0x68616973204d617263656c61204c61676573204669616c686f0d0a4350463a2031303633353437373638380d0a0d0a5065726d697469722061636573736f2061204453203e3e20537561730d0a537567657374c3a36f3a2074686169732e6669616c686f, '2026-05-12', '10:10:00', '2026-05-12', '11:10:00', 'C', 168, 55, NULL, NULL, NULL, NULL, 16, 16),
	(161, 16, 16, 10, 0, 0, 1, '2026-05-12', 7, '13:13:00', '2026-05-12', '10:11:00', '2026-05-12', '10:13:00', '2026-05-12', '2026-05-12', '13:13:00', '2026-05-12', NULL, NULL, 'V', '', _binary 0x4c6f67696e20646f20557375c3a172696f3a64616e646172612e73616c65730d0a53656e686120496e696369616c203a7361626172614032303236, 0, 0, 'C', 'P', '', 'Redefinição de senha de acesso rede / computador', NULL, 'C', '', NULL, _binary 0x44616e6461726120526169616e652053616c6573204665727265697261200d0a3036352e3231352e3331362d30330d0a537567657374c3a36f3a2064616e646172612e73616c65730d0a0d0a41636573736f207061737461204453203e3e2043524153, '2026-05-12', '10:11:00', '2026-05-12', '11:11:00', 'C', 169, 54, NULL, NULL, NULL, NULL, 16, 16),
	(162, 16, 16, 33, 0, 0, 26, NULL, 8, NULL, '2026-05-12', '15:39:44', '2026-05-12', '15:40:00', NULL, NULL, NULL, NULL, NULL, NULL, 'V', NULL, _binary 0x5265696e7374616c61646f20647269766520646120706c61636120646520766964656f20646f20736974652064612064656c6c2e204d6f6e69746f722066756e63696f6e616e646f206e6f726d616c6d656e7465, NULL, 0, 'C', 'P', NULL, 'Monitor - Sem Imagem', NULL, NULL, NULL, NULL, _binary 0x50617472696dc3b46e696f203a6a7572696469636f20287375656c69290d0a436865636f75206361626f7320646520656e65726769612065206461646f73202873696d2f6ec3a36f29203a73696d, '2026-05-12', '15:39:00', '2026-05-14', '15:39:00', 'C', 170, 26, NULL, NULL, NULL, NULL, 16, 16),
	(163, 30, 30, 9, 0, 0, 26, NULL, 12, NULL, '2026-05-12', '09:40:48', '2026-05-12', '17:00:00', NULL, NULL, NULL, NULL, NULL, NULL, 'V', NULL, _binary 0x4f20532e4f2e20c3a9204c696e75783b2061646963696f6e6569206f20706320616f20646f6dc3ad6e696f20504d533b20657865637574656920636f6d616e646f73207570646174652f757067726164653b20736f6c696369746569207265646566696e69c3a7c3a36f2064652073656e686120646520646f6dc3ad6e696f2070617261206120757375c3a17269613b20636f6e666967757265692061636573736f20706172612061732070617374617320646520726564653b206578616d696e656920706f6e746f2064652061636573736f206120726564653b2074726f71756569206f20706174636820636f726420646520706f727461206e6f207377697463682e, NULL, 0, 'C', 'P', NULL, 'Desktop - Incluir desktop na rede', NULL, NULL, NULL, NULL, _binary 0x50617472696dc3b46e696f203a0d0a536f6c69636974612073656e686120706172612061636573736172207061737461732f6172717569766f7320646520726564652e0d0a555355c38152494f3a2074617469616e652e6d6174696173, '2026-05-12', '16:59:00', '2026-05-12', '12:20:00', 'C', 171, 24, NULL, NULL, NULL, NULL, 30, 30),
	(164, 30, 30, 9, 21, 0, 26, NULL, 12, NULL, '2026-05-12', '17:11:29', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'R', NULL, NULL, NULL, 0, 'C', 'P', NULL, 'Desktop - Instalação e Desinstalação', NULL, NULL, NULL, NULL, _binary 0x50617472696d6f6e696f3a203130333931300d0a0d0a506320666f69207265646566696e69646f207061726120636f6e666967757261c3a7c3b565732064652066c3a162726963612e0d0a, '2026-05-12', '17:11:00', '2026-05-13', '19:11:00', 'A', 172, 23, NULL, NULL, NULL, NULL, 30, NULL);

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
) ENGINE=InnoDB AUTO_INCREMENT=182 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Copiando dados para a tabela gop.ordens_executores: ~161 rows (aproximadamente)
INSERT INTO `ordens_executores` (`id`, `id_ordem`, `id_executor`, `tempo_horas`, `tempo_minutos`, `valor_hora`, `valor_total`) VALUES
	(1, 3, 7, 2, 0, 0, 0),
	(2, 2, 7, 1, 0, 0, 0),
	(3, 5, 11, 2, 0, 0, 0),
	(4, 4, 7, 2, 0, 0, 0),
	(5, 6, 11, 2, 0, 0, 0),
	(6, 8, 10, 24, 0, 0, 0),
	(7, 8, 8, 24, 0, 0, 0),
	(8, 10, 10, 1, 0, 0, 0),
	(9, 10, 8, 2, 0, 0, 0),
	(10, 12, 10, 2, 0, 0, 0),
	(11, 14, 10, 1, 0, 0, 0),
	(12, 15, 7, 0, 30, 0, 0),
	(13, 16, 10, 1, 0, 0, 0),
	(14, 17, 10, 1, 0, 0, 0),
	(15, 18, 11, 0, 30, 0, 0),
	(16, 19, 7, 2, 0, 0, 0),
	(17, 13, 8, 4, 0, 0, 0),
	(18, 20, 11, 0, 30, 0, 0),
	(19, 21, 11, 0, 30, 0, 0),
	(20, 22, 7, 0, 30, 0, 0),
	(21, 23, 7, 0, 30, 0, 0),
	(22, 25, 7, 0, 30, 0, 0),
	(23, 27, 11, 24, 0, 0, 0),
	(24, 29, 11, 1, 0, 0, 0),
	(25, 30, 7, 1, 0, 0, 0),
	(26, 34, 12, 2, 30, 0, 0),
	(27, 35, 7, 1, 0, 0, 0),
	(28, 32, 7, 1, 0, 0, 0),
	(29, 31, 7, 0, 30, 0, 0),
	(30, 24, 10, 72, 0, 0, 0),
	(31, 37, 10, 72, 0, 0, 0),
	(32, 38, 7, 1, 0, 0, 0),
	(33, 36, 12, 1, 0, 0, 0),
	(34, 39, 7, 0, 30, 0, 0),
	(35, 40, 12, 40, 0, 0, 0),
	(36, 40, 8, 16, 0, 0, 0),
	(37, 42, 10, 3, 0, 0, 0),
	(38, 42, 8, 3, 0, 0, 0),
	(39, 45, 12, 3, 30, 0, 0),
	(40, 41, 12, 2, 0, 0, 0),
	(41, 46, 12, 3, 0, 0, 0),
	(42, 48, 7, 1, 0, 0, 0),
	(43, 47, 7, 0, 30, 0, 0),
	(44, 52, 7, 0, 30, 0, 0),
	(45, 51, 7, 1, 0, 0, 0),
	(46, 50, 7, 2, 0, 0, 0),
	(47, 33, 10, 48, 0, 0, 0),
	(48, 33, 12, 48, 0, 0, 0),
	(49, 33, 8, 48, 0, 0, 0),
	(50, 43, 12, 2, 0, 0, 0),
	(51, 44, 12, 5, 0, 0, 0),
	(52, 54, 8, 48, 0, 0, 0),
	(53, 53, 12, 0, 0, 0, 0),
	(54, 55, 11, 1, 0, 0, 0),
	(55, 56, 12, 0, 15, 0, 0),
	(56, 58, 11, 2, 0, 0, 0),
	(57, 59, 12, 0, 30, 0, 0),
	(58, 60, 11, 24, 0, 0, 0),
	(59, 54, 12, 48, 0, 0, 0),
	(60, 64, 8, 3, 0, 0, 0),
	(61, 64, 12, 3, 0, 0, 0),
	(62, 65, 7, 2, 0, 0, 0),
	(63, 66, 11, 3, 0, 0, 0),
	(64, 68, 7, 1, 0, 0, 0),
	(65, 69, 10, 3, 0, 0, 0),
	(66, 69, 12, 3, 0, 0, 0),
	(67, 69, 8, 3, 0, 0, 0),
	(68, 62, 10, 3, 0, 0, 0),
	(69, 62, 12, 3, 0, 0, 0),
	(70, 62, 8, 3, 0, 0, 0),
	(72, 70, 12, 2, 0, 0, 0),
	(73, 71, 11, 2, 0, 0, 0),
	(74, 71, 11, 2, 0, 0, 0),
	(75, 73, 7, 1, 0, 0, 0),
	(76, 72, 7, 0, 30, 0, 0),
	(77, 63, 12, 104, 0, 0, 0),
	(78, 74, 7, 1, 0, 0, 0),
	(79, 75, 7, 1, 0, 0, 0),
	(80, 79, 12, 48, 0, 0, 0),
	(81, 79, 8, 48, 0, 0, 0),
	(82, 82, 7, 1, 0, 0, 0),
	(83, 81, 7, 1, 0, 0, 0),
	(84, 9, 10, 2, 0, 0, 0),
	(85, 9, 8, 2, 0, 0, 0),
	(86, 9, 12, 2, 0, 0, 0),
	(87, 61, 10, 0, 0, 0, 0),
	(88, 61, 8, 0, 0, 0, 0),
	(89, 61, 12, 0, 0, 0, 0),
	(90, 83, 7, 1, 0, 0, 0),
	(91, 84, 7, 1, 0, 0, 0),
	(92, 85, 12, 2, 0, 0, 0),
	(93, 86, 12, 0, 30, 0, 0),
	(94, 87, 12, 0, 10, 0, 0),
	(95, 88, 12, 0, 10, 0, 0),
	(96, 89, 7, 1, 0, 0, 0),
	(97, 80, 12, 48, 0, 0, 0),
	(98, 90, 7, 0, 30, 0, 0),
	(99, 91, 7, 1, 0, 0, 0),
	(100, 94, 8, 40, 0, 0, 0),
	(101, 94, 12, 40, 0, 0, 0),
	(102, 95, 12, 0, 0, 0, 0),
	(103, 96, 12, 3, 0, 0, 0),
	(105, 77, 8, 8, 0, 0, 0),
	(106, 76, 8, 8, 0, 0, 0),
	(107, 98, 7, 0, 30, 0, 0),
	(108, 99, 7, 1, 0, 0, 0),
	(109, 93, 12, 3, 0, 0, 0),
	(110, 100, 8, 7, 0, 0, 0),
	(111, 100, 12, 7, 0, 0, 0),
	(112, 101, 11, 1, 0, 0, 0),
	(113, 102, 11, 2, 0, 0, 0),
	(114, 103, 7, 1, 0, 0, 0),
	(115, 107, 7, 1, 0, 0, 0),
	(116, 108, 7, 1, 0, 0, 0),
	(117, 109, 7, 0, 30, 0, 0),
	(118, 111, 7, 0, 30, 0, 0),
	(119, 112, 7, 0, 30, 0, 0),
	(120, 110, 11, 3, 0, 0, 0),
	(121, 110, 12, 3, 0, 0, 0),
	(122, 113, 7, 0, 30, 0, 0),
	(123, 97, 8, 8, 0, 0, 0),
	(124, 114, 12, 1, 0, 0, 0),
	(125, 115, 12, 8, 0, 0, 0),
	(126, 115, 8, 8, 0, 0, 0),
	(127, 116, 8, 8, 0, 0, 0),
	(128, 116, 12, 8, 0, 0, 0),
	(129, 117, 8, 8, 0, 0, 0),
	(130, 117, 12, 8, 0, 0, 0),
	(131, 117, 11, 8, 0, 0, 0),
	(132, 119, 11, 1, 0, 0, 0),
	(133, 120, 8, 1, 0, 0, 0),
	(134, 121, 8, 0, 30, 0, 0),
	(135, 122, 11, 24, 0, 0, 0),
	(136, 122, 8, 24, 0, 0, 0),
	(137, 124, 7, 0, 30, 0, 0),
	(138, 126, 11, 2, 0, 0, 0),
	(139, 127, 7, 1, 0, 0, 0),
	(140, 128, 7, 0, 30, 0, 0),
	(141, 129, 12, 1, 0, 0, 0),
	(142, 118, 12, 0, 40, 0, 0),
	(143, 125, 12, 8, 0, 0, 0),
	(144, 133, 11, 3, 0, 0, 0),
	(145, 134, 7, 0, 30, 0, 0),
	(146, 131, 12, 24, 0, 0, 0),
	(147, 131, 8, 24, 0, 0, 0),
	(148, 123, 8, 24, 0, 0, 0),
	(149, 135, 12, 8, 0, 0, 0),
	(150, 136, 7, 1, 0, 0, 0),
	(151, 140, 12, 0, 30, 0, 0),
	(152, 141, 11, 0, 30, 0, 0),
	(153, 142, 11, 0, 30, 0, 0),
	(154, 144, 7, 0, 40, 0, 0),
	(155, 106, 8, 2, 0, 0, 0),
	(156, 106, 12, 2, 0, 0, 0),
	(157, 7, 10, 2, 0, 0, 0),
	(158, 145, 12, 0, 10, 0, 0),
	(159, 146, 11, 2, 0, 0, 0),
	(160, 147, 12, 3, 0, 0, 0),
	(161, 105, 8, 0, 30, 0, 0),
	(162, 105, 12, 0, 30, 0, 0),
	(163, 148, 12, 2, 20, 0, 0),
	(164, 137, 8, 48, 0, 0, 0),
	(165, 143, 12, 48, 0, 0, 0),
	(166, 150, 7, 0, 30, 0, 0),
	(167, 149, 8, 4, 0, 0, 0),
	(168, 149, 12, 4, 0, 0, 0),
	(169, 152, 7, 0, 30, 0, 0),
	(170, 153, 11, 2, 0, 0, 0),
	(171, 155, 7, 0, 30, 0, 0),
	(172, 154, 11, 2, 0, 0, 0),
	(173, 156, 11, 0, 30, 0, 0),
	(174, 157, 7, 0, 40, 0, 0),
	(175, 158, 7, 0, 40, 0, 0),
	(176, 159, 7, 0, 30, 0, 0),
	(177, 161, 7, 0, 20, 0, 0),
	(178, 160, 7, 0, 20, 0, 0),
	(179, 162, 8, 2, 0, 0, 0),
	(180, 163, 12, 24, 0, 0, 0),
	(181, 164, 12, 26, 0, 0, 0);

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
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Copiando dados para a tabela gop.ordens_materiais: ~8 rows (aproximadamente)
INSERT INTO `ordens_materiais` (`id`, `id_ordem`, `id_material`, `id_unidade`, `quantidade`, `valor`, `baixa`) VALUES
	(1, 134, 8, 8, 1, 0, 'S'),
	(2, 140, 8, 8, 1, 0, 'S'),
	(3, 141, 8, 8, 2, 0, 'S'),
	(4, 142, 8, 8, 1, 0, 'S'),
	(5, 145, 8, 8, 1, 0, 'S'),
	(6, 150, 8, 8, 2, 0, 'S'),
	(7, 152, 7, 8, 1, 0, 'S'),
	(8, 152, 4, 8, 1, 0, 'S'),
	(9, 155, 7, 8, 1, 0, 'S');

-- Copiando estrutura para tabela gop.ordens_plano
CREATE TABLE IF NOT EXISTS `ordens_plano` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_plano` int DEFAULT NULL,
  `id_ordem` int DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `FK_ordens_plano_planejamento` (`id_plano`) USING BTREE,
  KEY `FK_ordens_plano_ordens` (`id_ordem`) USING BTREE,
  CONSTRAINT `FK_ordens_plano_ordens` FOREIGN KEY (`id_ordem`) REFERENCES `ordens` (`id`),
  CONSTRAINT `FK_ordens_plano_planejamento` FOREIGN KEY (`id_plano`) REFERENCES `planejamento` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Copiando dados para a tabela gop.ordens_plano: ~0 rows (aproximadamente)
INSERT INTO `ordens_plano` (`id`, `id_plano`, `id_ordem`) VALUES
	(1, 2, 53);

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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Copiando dados para a tabela gop.ordens_pop: ~0 rows (aproximadamente)
INSERT INTO `ordens_pop` (`id`, `id_ordem`, `id_pop`) VALUES
	(1, 53, 12);

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
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Copiando dados para a tabela gop.ordens_prestadores: ~0 rows (aproximadamente)
INSERT INTO `ordens_prestadores` (`id`, `id_ordem`, `id_prestador`, `tempo_horas`, `tempo_minutos`, `valor_hora`, `valor_total`) VALUES
	(9, 11, 1, 24, 0, 0, 0),
	(10, 26, 1, 72, 0, 0, 0),
	(11, 49, 1, 72, 0, 0, 0),
	(12, 28, 2, 48, 0, 0, 0),
	(13, 67, 3, 3, 0, 0, 0),
	(14, 78, 3, 0, 0, 0, 0),
	(15, 138, 4, 24, 0, 0, 0);

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
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Copiando dados para a tabela gop.ordens_suspensao: ~10 rows (aproximadamente)
INSERT INTO `ordens_suspensao` (`id`, `id_ordem`, `data_suspensao`, `hora_suspensao`, `data_retirada`, `hora_retirada`, `motivo`) VALUES
	(2, 9, '2026-03-23', '09:21:00', '2026-05-07', '12:12:00', _binary 0x50726f706c656d6120656cc3a9747269636f20666f692064657465637461646f206e6f207072c3a964696f2e20416775617264616e646f20696e74657276656ec3a7c3a36f20646f20456c65747269636973746120646f204f62726173),
	(3, 7, '2026-03-23', '09:22:00', '2026-05-07', '12:12:00', _binary 0x50726f706c656d6120656cc3a9747269636f20666f692064657465637461646f206e6f207072c3a964696f2e20416775617264616e646f20696e74657276656ec3a7c3a36f20646f20456c65747269636973746120646f204f62726173),
	(4, 57, '2026-04-01', '09:26:00', '2026-05-07', '12:12:00', _binary 0x50726f706c656d6120656cc3a9747269636f20666f692064657465637461646f206e6f207072c3a964696f2e20416775617264616e646f20696e74657276656ec3a7c3a36f20646f20456c65747269636973746120646f204f62726173),
	(5, 53, '2026-04-01', '09:34:00', '2026-05-07', '12:12:00', _binary 0x50726f706c656d6120656cc3a9747269636f20666f692064657465637461646f206e6f207072c3a964696f2e20416775617264616e646f20696e74657276656ec3a7c3a36f20646f20456c65747269636973746120646f204f62726173),
	(6, 61, '2026-04-06', '16:27:00', '2026-05-07', '12:12:00', _binary 0x50726f706c656d6120656cc3a9747269636f20666f692064657465637461646f206e6f207072c3a964696f2e20416775617264616e646f20696e74657276656ec3a7c3a36f20646f20456c65747269636973746120646f204f62726173),
	(7, 61, '2026-04-06', '16:38:00', '2026-05-07', '12:12:00', _binary 0x50726f706c656d6120656cc3a9747269636f20666f692064657465637461646f206e6f207072c3a964696f2e20416775617264616e646f20696e74657276656ec3a7c3a36f20646f20456c65747269636973746120646f204f62726173),
	(8, 92, '2026-04-14', '09:04:00', '2026-05-07', '12:12:00', _binary 0x50726f706c656d6120656cc3a9747269636f20666f692064657465637461646f206e6f207072c3a964696f2e20416775617264616e646f20696e74657276656ec3a7c3a36f20646f20456c65747269636973746120646f204f62726173),
	(9, 97, '2026-04-14', '16:44:00', '2026-05-07', '12:12:00', _binary 0x50726f706c656d6120656cc3a9747269636f20666f692064657465637461646f206e6f207072c3a964696f2e20416775617264616e646f20696e74657276656ec3a7c3a36f20646f20456c65747269636973746120646f204f62726173),
	(10, 93, '2026-04-16', '09:31:00', '2026-05-07', '12:12:00', _binary 0x50726f706c656d6120656cc3a9747269636f20666f692064657465637461646f206e6f207072c3a964696f2e20416775617264616e646f20696e74657276656ec3a7c3a36f20646f20456c65747269636973746120646f204f62726173),
	(11, 106, '2026-04-16', '11:54:00', '2026-05-07', '12:12:00', _binary 0x50726f706c656d6120656cc3a9747269636f20666f692064657465637461646f206e6f207072c3a964696f2e20416775617264616e646f20696e74657276656ec3a7c3a36f20646f20456c65747269636973746120646f204f62726173);

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
  `gera_os` char(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Copiando dados para a tabela gop.perfil_usuarios: ~2 rows (aproximadamente)
INSERT INTO `perfil_usuarios` (`id`, `descricao`, `cadastros_recursosfisicos`, `cadastros_espacosfisicos`, `cadastros_fornecedores`, `cadastros_fabricantes`, `cadastros_executores`, `cadastros_cargosfuncoes`, `cadastros_oficinas`, `cadastro_centrosdecusto`, `cadastros_setores`, `cadastros_ferramentas`, `cadastros_grupos`, `cadastros_marcas`, `cadastros_pop`, `cadastros_checklist`, `cadastros_tipos`, `cadastros_prestadores`, `servicos_solicitacoes`, `servicos_ordens`, `servicos_preventivas`, `servicos_agenda`, `servicos_ocorrencias_padroes`, `servicos_plano_acao`, `almoxarifado_cotacoes`, `almoxarifado_pedidodecompra`, `almoxarifado_materiais`, `almoxarifado_unidadesmedidas`, `indicadores_ocorrencias`, `indicadores_comparativos`, `custos_ocorrencias`, `custos_comparativos`, `custos`, `obras`, `gera_os`) VALUES
	(1, 'Perfil padrão', 'S', 'S', 'S', 'S', 'S', 'S', 'S', 'S', 'S', 'S', 'S', 'S', 'S', 'S', 'S', 'S', 'S', 'S', 'S', 'S', 'S', 'N', 'S', 'S', 'S', 'S', 'S', 'S', 'S', 'S', NULL, 'N', 'S'),
	(2, 'Prefeitura', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'S', 'N', 'N', 'N', 'S', 'S', 'N', NULL, 'N', 'N', 'N', NULL, 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', 'N', NULL, 'N', NULL);

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
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Copiando dados para a tabela gop.pops: ~7 rows (aproximadamente)
INSERT INTO `pops` (`id`, `id_recurso`, `id_espaco`, `id_oficina`, `tipo`, `descricao`, `revisado`, `preparado`, `resultadoesperado`, `materialnecessario`, `descritivo`, `atividadecritica`, `cuidados`, `anc`, `data`, `dataemissao`, `processo`, `objetivo`, `risco`, `refbibliografica`) VALUES
	(5, 5, 6, 1, '1', 'Instalação de Acesso ao sistema de Gestão da Moderna', '', 'Glaison Queiroz', _binary 0x41636573736f20616f2073697374656d6120, _binary 0x496e7374616c61646f7220666f726e656369646f2070656c61204d6f6465726e6120656d20616e65786f, _binary 0x496e7374616c61c3a7c3a36f2064652041636573736f20616f20736f6674776172652064652047657374c3a36f206461204d6f6465726e61202873757065726e6f7661290d0a656d206dc3a17175696e6120636f6d2073697374656d61206f7065726163696f6e616c2077696e646f7773, _binary 0x4ec3a36f2073652061706c696361, _binary 0x56657269666963617220636f6e6578c3a36f20636f6d20696e7465726e6574, _binary 0x4ec3a36f2073652061706c69636120656d206f7574726f732073697374656d6173206f7065726163696f6e6169732e0d0a0d0a50617261206f7574726f732073697374656d61206f7065726163696f6e6169732061636573736172206c696e6b20766961206e6176656761646f203a0d0a0d0a68747470733a2f2f7765627361626172612e73757065726e6f76612e636f6d2e62723a3439312f7361626172612e68746d6c, '2025-11-28', NULL, _binary 0x2d20616365737365203139322e3136382e382e382f7574696c732f73757065726e6f76610d0a2d20636f7069652073757065726e6f76612e7a69700d0a2d20646573636f6d70616374617220656d20633a0d0a2d2065786563757461722073757065726e6f76612e6261740d0a2d20736f6c6963697465207573756172696f207465737461722061636573736f206e6976656c20312065206465706f697320616f206d6f64756c6f2071756520646573656a610d0a2d2066696d, _binary 0x41636573736f20616f2073697374656d6120455250206461204d6f6465726e61, _binary 0x4ec3a36f2073652061706c696361, _binary ''),
	(6, 5, 6, 1, '1', 'Administração do  AD', '', 'Welligton Jardins', _binary 0x4d616e7574656ec3a7c3a36f20646f2041442064612072656465, _binary 0x2d20557375c3a172696f20652073656e68612064652041646d696e6973747261646f720d0a2d2041636573736f206c6962657261646f20616f207365727669646f7220646f2041442e, _binary 0x476572656e6369616d656e746f20646f2041642e20646120707265666569747572612c207065726d6974696e646f20696e636c7573c3a36f20646520757375c3a172696f73206520736575730d0a7265737065637469766f732061636573736f732c20616c74657261c3a7c3a36f2064652061636573736f732c20616c74657261c3a7c3a36f2064652073656e6861732c20626c6f717565696f2064650d0a61636573736f2065206578636c7573c3a36f0d0a, _binary 0x41636573736f2064657665207365722065787465726d616d656e746520726573747269746f20, _binary 0x56616c6964617220746f646f73206f732070656469646f7320646520696e636c7573c3a36f2065206d616e7574656ec3a7c3a36f206465207573c3a172696f7320766961200d0a652d6d61696c206f752061706c6963617469766f2064652067617374c3a36f206465207365727669c3a76f73, _binary 0x50617373617220616f20476573746f722064652072656465, '2025-11-28', NULL, _binary 0x41636573736172207365727669646f7220646f2061642061747276c3a97320646f20737368206f7520707574747920652073656775697220696e73747275c3a7c3b56573200d0a646f20646f63756d656e746f20656d20616e65786f, _binary 0x4d616e7574656ec3a7c3a36f20646520646f7320757375c3a172696f7320646f2041442e2064612072656465206520736575732061636573736f73, _binary 0x41636573736f2064657665207365722065787465726d616d656e746520726573747269746f20, _binary 0x656d20616e65786f),
	(7, 5, 6, 1, '3', 'Instalação de Impressora Im 430', 'Glaison Queiroz', 'Ederson', _binary 0x496d7072657373c3a36f2065207363616e65722066756e63696f616e646f20656d2072656465, _binary 0x44726976657220646120696d70726573736f726120656d20616e65786f, _binary 0x4f20646f63756d656e746f20656d20616e65786f20646573637265766520726f74696e61207061726120696e7374616c61c3a7c3a36f20646520696d70726573736f72610d0a5269636f6820696d2034333020652074616d62c3a96d20636f6e666967757261c3a7c3a36f20646f205363616e657220656d2072656465, _binary 0x4ec3a36f2073652061706c696361, _binary 0x417475616c697a61c3a7c3a36f20646f20647269766572, _binary 0x4ec3a36f2073652061706c696361, '2025-11-28', NULL, _binary 0x50726f636573736f20696e636c75736f206e6f20646f63756d656e746f20656d20616e65786f, _binary 0x496e7374616c61c3a7c3a36f20646520696d70726573736f72612064652072656465, _binary 0x4ec3a36f2073652061706c696361, _binary 0x68747470733a2f2f737570706f72742e7269636f682e636f6d2f62625f76316f692f7075625f652f6f692f303030313037382f303030313037383937352f5644304134377878785f30362f4430413437373236415f62702e706466),
	(8, 5, 6, 1, '1', 'Administração de Usuário wi-fi (Sabará HotSpot)', '', 'Glaison Queiroz', _binary 0x41636573736f20646f20757375c3a172696f206120726564652077692d66692028686f745f73706f7429, _binary 0x557375c3a172696f20652073656e68612064652061646d696e6973747261646f72206e6f20697020687474703a2f2f31302e312e3230302e312f, _binary 0x41646d696e6973747261c3a7c3a36f20646f7320757375c3a172696f20646120726564652077692d66692028686f742d73706f7429, _binary 0x6ec3a36f2073652061706c696361, _binary 0x6ec3a36f2073652061706c696361, _binary 0x6ec3a36f2073652061706c696361, '2025-11-28', NULL, _binary 0x50726f636573736f7320646520676572c3aa6e6369616d656e746f206e6f20646f63756d656e746f20656d20616e65786f, _binary 0x4461722061636573736f206120757375c3a172696f732064612070726566656974757261206f7520707265737461646f726573206465207365727669c3a76f20610d0a726564652077692d6669206461207370656564206e65742028686f742073706f7429, _binary 0x6ec3a36f2073652061706c696361, _binary 0x6ec3a36f2073652061706c696361),
	(9, 5, 6, 1, '1', 'Solicitação de Formatação de Computador', '', 'Ederson Fernandes', _binary '', _binary '', _binary 0x446573637269c3a7c3a36f20646520736f6c6963697461c3a7c3a36f20646520666f726d617461c3a7c3a36f20646520636f6d70757461646f726573, _binary '', _binary '', _binary '', '2025-10-16', NULL, _binary 0x50726f636573736f20646573637269746f206e6f20646f63756d656e746f20656d20616e65786f, _binary '', _binary '', _binary ''),
	(10, 5, 6, 1, '1', 'Instalação de Certificado Digital A1', '', 'Ederson Fernandes', _binary '', _binary '', _binary 0x496e7374616c61c3a7c3a36f20646520436572746966696361646f204469676974616c204121, _binary '', _binary '', _binary '', '2025-10-16', NULL, _binary 0x28436572746966696361646f206469676974616c2920696e7374616c61722061310d0a2d206261697865207066780d0a2d206162726120636572746d67722e6d73630d0a2d20696d706f727465207061726120706573736f616c0d0a2d206d617263617220636f6d6f206e616f206578706f72746176656c0d0a2d2066696e616c697a650d0a2d20746573746520656361630d0a2d204f7269656e746520677561726461722070667820636f6d207365677572616ec3a761, _binary '', _binary '', _binary ''),
	(11, 5, 6, 1, '1', 'Configurar Computador no domínio da Prefeitura', '', 'Glaison Queiroz', _binary 0x41636573736f20646f20636f6d70757461646f72206120696e7465726e6574206520726564652064612070726566656974757261, _binary 0x557375c3a172696f20652073656e68612064652061646d696e6973747261646f72, _binary 0x50726f636564696d656e746f73207061726120636f6e66696775726120636f6d70757461646f726573206e6f20446f6d696e696f2064612070726566656974757261, _binary 0x4ec3a36f2073652061706c696361, _binary 0x6ec3a36f2073652061706c696361, _binary 0x4ec3a36f2073652061706c696361, '2025-11-28', NULL, _binary 0x50726f636573736f73207061726120636f6e666967757261c3a7c3a36f206e6f20646f63756d656e746f20656d20616e65786f, _binary 0x436f6c6f636172206571756970616d656e746f206e6f20646f6d696e696f20706172612061636573736f206120696e7465726e65742065206173207061737461732064652072656465, _binary '', _binary 0x4ec3a36f2073652061706c696361),
	(12, 5, 6, 1, '1', 'Instalação do Microsoft Authenticator para e-mail coorporativo', '', 'Glaison Queiroz', _binary 0x41636573736f2073656775726f20616f20652d6d61696c20636f6f72706f72617469766f, _binary 0x446973706f73697469766f2063656c756c617220636f6f72706f72617469766f2028646120707265666572656e63696129, _binary 0x436f6e666967757261c3a7c3a36f20646f204d6963726f736f66742041757468656e74696361746f72, _binary 0x4ec3a36f2073652061706c696361, _binary 0x4ec3a36f2073652061706c6c696361, _binary 0x4ec3a36f2073652061706c696361, '2025-11-28', NULL, _binary 0x50726f636573736f7320646520696e7374616c61c3a7c3a36f202f20636f6e666967757261c3a7c3a36f206e6f20646f63756d656e746f20656d20616e65786f, _binary 0x41636573736f2073656775726f20616f20652d6d61696c20636f6f72706f72617469766f, _binary 0x6ec3a36f2073652061706c696361, _binary ''),
	(13, 5, 6, 1, '1', 'Instalação e configuração linux ', 'Lucio Machado', 'Lucio Machado', _binary 0x46756e63696f6e616d656e746f20646520436f6d70757461646f726573206e6120726564652064612070726566656974757261207574696c697a616e646f204c696e757820636f6d6f2073697374656d61206f7065726163696f6e616c, _binary 0x50656e20647269766520636f6d206f2073697374656d61206f7065726163696f6e616c, _binary 0x506f70207061726120696e7374616c61c3a7c3a36f206520636f6e666967757261c3a7c3a36f2064652073697374656d61206f7065726163696f6e616c204c696e7578206e6f7320636f6d70757461646f7265732064612050726566656974757261, _binary 0x6ec3a36f2073652061706c696361, _binary 0x6ec3a36f2073652061706c696361, _binary 0x6ec3a36f2073652061706c696361, '2026-01-28', NULL, _binary 0x456d20616e65786f, _binary 0x436f6d707561646f7220636c69656e7465206e6120726564652064612070726566656974757261, _binary 0x6ec3a36f2073652061706c696361, _binary 0x496e7465726e6574),
	(14, 5, 6, 1, '1', 'PJEOffice', '', 'Lucio Machado', _binary '', _binary '', _binary 0x4572726f20646f20504a45206e6f2062726f777365723a2022504a454f6666696365206ec3a36f20657374c3a120656d206578656375c3a7c3a36f22, _binary '', _binary '', _binary '', '2026-02-10', NULL, _binary 0x2d204c696d7061722063616368653b0d0a2d207265696e69636961722070632e, _binary '', _binary '', _binary '');

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
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Copiando dados para a tabela gop.pop_anexos: ~8 rows (aproximadamente)
INSERT INTO `pop_anexos` (`id`, `id_pop`, `descricao`, `path`, `data`, `responsavel`) VALUES
	(1, 5, NULL, 'anexos/Supernova.zip', '2025-10-08', NULL),
	(3, 7, 'Manual de Intalação', 'anexos/Como instalar impressora de rede.docx', '2025-10-16', 'Glaison Queiroz'),
	(4, 8, 'Manual', 'anexos/Procedimentos para administrar os usuários na Rede wi.docx', '2025-10-16', 'Glaison Queiroz'),
	(5, 9, NULL, 'anexos/formulario_formatacao_pcs.docx', '2025-10-16', NULL),
	(6, 11, NULL, 'anexos/Colocar Computador no domínio da Prefeitura.docx', '2025-10-16', NULL),
	(8, 7, 'Driver de Impressora atualizado em 28/11/2025', 'anexos/drive im430.zip', '2025-11-28', 'Glaison Queiroz'),
	(9, 12, 'Guia Microsoft Autenticator', 'anexos/Guia-Microsoft-Authenticator-PMS.pdf', '2025-11-28', 'Glaison Queiroz'),
	(10, 5, NULL, 'anexos/config_email.jpg', '2025-11-28', NULL),
	(11, 13, NULL, 'anexos/documentação LInuxMint.doc', '2026-01-28', NULL);

-- Copiando estrutura para tabela gop.prestadores
CREATE TABLE IF NOT EXISTS `prestadores` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_tipo` int DEFAULT NULL,
  `razao_social` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `nome` varchar(200) DEFAULT NULL,
  `contato` varchar(120) DEFAULT NULL,
  `telefone1` varchar(25) DEFAULT NULL,
  `telefone2` varchar(25) DEFAULT NULL,
  `email` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
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
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Copiando dados para a tabela gop.prestadores: ~0 rows (aproximadamente)
INSERT INTO `prestadores` (`id`, `id_tipo`, `razao_social`, `nome`, `contato`, `telefone1`, `telefone2`, `email`, `site`, `endereco`, `bairro`, `cep`, `cidade`, `uf`, `cnpj`, `contrato`, `valor_contrato`, `valor_visita`, `ativa`, `observacao`) VALUES
	(1, 3, 'Selbetti', 'Selbetti', 'Eliezer', '(47) 3441-6000', '', '', '', '', '', '', '', 'MG', '83483230000186', NULL, 0, 0, 'S', _binary ''),
	(2, 3, 'Dell Computadores SA', 'Dell Suporte', 'Dell', '(31) 3672-7688', '', '', '', '', '', '', '', 'MG', '72381189000110', NULL, 0, 0, 'S', _binary ''),
	(3, 3, 'SpeedNet', 'SpeedNet', 'Suporte', '(99) 9999999-9999', '', '', '', '', '', '', '', 'MG', '22886816000105', NULL, 0, 0, 'S', _binary ''),
	(4, 3, 'Flavio Maielo', 'Flavio Maielo', 'Flavo Maielo', '(31) 3672-7688', '', '', '', '', '', '', '', 'MG', '83483230000186', NULL, 0, 0, 'S', _binary '');

-- Copiando estrutura para tabela gop.preventivas
CREATE TABLE IF NOT EXISTS `preventivas` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_recurso` int DEFAULT NULL,
  `id_espaco` int DEFAULT NULL,
  `id_oficina` int DEFAULT NULL,
  `id_ocorrencia` int DEFAULT NULL,
  `id_setor` int DEFAULT NULL,
  `id_executor` int DEFAULT NULL,
  `tipo` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'R = recurso E +espaco fisico / Edificação',
  `tipo_preventiva` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'sistema\r\npreditiva\r\nrotina',
  `data_cadastro` date NOT NULL,
  `periodicidade_geracao` int NOT NULL,
  `data_prox_realizacao` date DEFAULT NULL,
  `data_ult_realizacao` date DEFAULT NULL,
  `descritivo` blob,
  `gerar` char(3) DEFAULT NULL,
  `prazo_atendimento` int DEFAULT NULL,
  KEY `id` (`id`),
  KEY `FK_preventivas_recursos` (`id_recurso`),
  KEY `FK_preventivas_espacos` (`id_espaco`),
  KEY `FK_preventivas_oficinas` (`id_oficina`),
  KEY `FK_preventivas_ocorrencias` (`id_ocorrencia`),
  KEY `FK_preventivas_setores` (`id_setor`),
  KEY `FK_preventivas_executores` (`id_executor`),
  CONSTRAINT `FK_preventivas_espacos` FOREIGN KEY (`id_espaco`) REFERENCES `espacos` (`id`),
  CONSTRAINT `FK_preventivas_executores` FOREIGN KEY (`id_executor`) REFERENCES `executores` (`id`),
  CONSTRAINT `FK_preventivas_ocorrencias` FOREIGN KEY (`id_ocorrencia`) REFERENCES `ocorrencias` (`id`),
  CONSTRAINT `FK_preventivas_oficinas` FOREIGN KEY (`id_oficina`) REFERENCES `oficinas` (`id`),
  CONSTRAINT `FK_preventivas_recursos` FOREIGN KEY (`id_recurso`) REFERENCES `recursos` (`id`),
  CONSTRAINT `FK_preventivas_setores` FOREIGN KEY (`id_setor`) REFERENCES `setores` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

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
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Copiando dados para a tabela gop.recursos: ~12 rows (aproximadamente)
INSERT INTO `recursos` (`id`, `id_espacofisico`, `id_fabricante`, `id_fornecedor`, `id_tipo`, `id_centrodecusto`, `id_oficina`, `id_setor`, `id_marca`, `descricao`, `patrimonio`, `modelo`, `numeroserie`, `estado`, `notafiscal`, `datacadastro`, `datagarantia`, `valoraquisicao`, `valordepreciado`, `ultimapreventiva`, `ultimamanutencao`, `dataaquisicao`, `ativo`, `motivoinativo`, `reganvisa`, `obs`, `tipo_comodato`, `tipo_medico`, `tipo_alugado`, `empresa_locacao`, `medico`, `empresa_comodato`, `mantenabilidade`, `treinamento`) VALUES
	(5, 6, 5, 3, 4, 6, 1, 27, 99, 'DeskTop Workstation Precision 3660', '116549', 'WorkStation', '00000', 'Ótimo', '00000', '2025-10-02', '2025-10-02', 0, 0, '2025-10-02', '2025-10-02', '2025-10-02', 'S', '', '', _binary 0x3136206d62206465204d656d6f7269610d0a53534420646520353030206d62, 'N', 'N', 'N', '', '', '', 'A', 'A'),
	(6, 6, 7, 3, 4, 6, 26, 25, 100, 'Computador Positivo', '455555', 'Positivo ', '', 'Bom', '00000', '2026-03-18', '2026-03-18', 0, 0, '2026-03-18', '2026-03-18', '2026-03-18', 'S', '', '', _binary '', 'N', 'N', 'N', '', '', '', 'A', 'A'),
	(7, 6, 5, 3, 4, 6, 26, 29, 99, 'DeskTop WorkStation Precison 3660', '116551', 'Work Station', '000000', 'Ótimo', '000000', '2026-03-23', '2026-03-23', 0, 0, '2026-03-23', '2026-03-23', '2026-03-23', 'S', '', '', _binary '', 'N', 'N', 'N', '', '', '', 'A', 'A'),
	(8, 6, 7, 3, 4, 6, 26, 30, 100, 'Positivo Master D480', '119245', 'Positivo master', '1af73jn50', '', '0000000', '2026-03-31', '2026-03-31', 0, 0, '2026-03-31', '2026-03-31', '2026-03-31', 'S', '', '', _binary '', 'N', 'N', 'N', '', '', '', 'A', 'A'),
	(9, 6, 5, 3, 4, 6, 26, 30, 99, 'Computador', '093015', 'DELL', '81KNVN2', 'Ótimo', '0000000', '2026-03-31', '2026-03-31', 0, 0, '2026-03-31', '2026-03-31', '2026-03-31', 'S', '', '', _binary '', 'N', 'N', 'N', '', '', '', 'A', 'A'),
	(10, 6, 5, 3, 4, 6, 26, 6, 99, 'Computador DELL Optiplex 3050', '091878', 'DELL', '8KCRCK2', 'Ótimo', '0000000', '2026-03-31', '2026-03-31', 0, 0, '2026-03-31', '2026-03-31', '2026-03-31', 'S', '', '', _binary 0x456d2075736f206e61204a756e7461204d696c69746172, 'N', 'N', 'N', '', '', '', 'A', 'A'),
	(11, 6, 5, 3, 4, 6, 26, 12, 99, 'Computador DeskTop Optiplex 3050', '093042', 'DeskTop', '0000000', '', '00000', '2026-04-08', '2026-04-08', 0, 0, '2026-04-08', '2026-04-08', '2026-04-08', 'S', '', '', _binary '', 'N', 'N', 'N', '', '', '', 'A', 'A'),
	(12, 6, 5, 3, 4, 6, 26, 12, 99, 'Computador DELL Optiplex 3050', '093034', 'DeskTop', '00000', '', '000', '2026-04-08', '2026-04-08', 0, 0, '2026-04-08', '2026-04-08', '2026-04-08', 'S', '', '', _binary '', 'N', 'N', 'N', '', '', '', 'A', 'A'),
	(13, 6, 6, 3, 4, 6, 26, 8, 110, 'Computador Lenovo', '119311', 'M10AH', 'PE01MT7U', 'Razoável', '0000000', '2026-04-09', '2026-04-09', 0, 0, '2026-04-09', '2026-04-09', '2026-01-01', 'S', '', '', _binary '', 'N', 'N', 'N', '', '', '', 'A', 'A'),
	(14, 6, 5, 3, 4, 6, 26, 32, 99, 'Computador', '105826', 'DELL Optiplex 3000', '', 'Muito Bom', '000000', '2026-04-10', '2026-04-10', 0, 0, '2026-04-10', '2026-04-10', '2026-04-10', 'S', '', '', _binary '', 'N', 'N', 'N', '', '', '', 'A', 'A'),
	(15, 6, 5, 3, 4, 6, 26, 7, 99, 'Computador', '95088', 'DELL Optiplex 3050', '525KYR2', 'Ótimo', '000000', '2026-04-10', '2026-04-10', 0, 0, '2026-04-10', '2026-04-10', '2026-04-10', 'S', '', '', _binary '', 'N', 'N', 'N', '', '', '', 'A', 'A'),
	(16, 6, 5, 3, 4, 6, 26, 7, 99, 'Computador', '91887', 'DELL Optiplex 3050 Small Form Factor', '8KKQCK2', '', '000000', '2026-04-10', '2026-04-10', 0, 0, '2026-04-10', '2026-04-10', '2026-04-10', 'S', '', '', _binary '', 'N', 'N', 'N', '', '', '', 'A', 'A'),
	(17, 6, 5, 3, 4, 6, 26, 11, 99, 'Computador', '97354', 'Optiplex3070', '960CH73', '', '000000', '2026-04-23', '2026-04-23', 0, 0, '2026-04-23', '2026-04-23', '2026-04-23', 'S', '', '', _binary '', 'N', 'N', 'N', '', '', '', 'A', 'A'),
	(18, 6, 5, 3, 4, 6, 26, 11, 99, 'Computador OptiPlex', '097349', 'DeskTop', '6893726223', '', '000000', '2026-04-27', '2026-04-27', 0, 0, '2026-04-27', '2026-04-27', '2026-04-27', 'S', '', '', _binary '', 'N', 'N', 'N', '', '', '', 'A', 'A'),
	(19, 6, 7, 3, 4, 6, 26, 30, 100, 'Computador positivo Master', '119220', 'positivo master', '00000', '', '', '2026-04-27', '2026-04-27', 0, 0, '2026-04-27', '2026-04-27', '2026-04-27', 'S', '', '', _binary '', 'N', 'N', 'N', '', '', '', 'A', 'A'),
	(20, 6, 9, 3, 4, 6, 26, 8, 102, 'Computador', '83332', 'HP Compaq 8200', '', '', '000000', '2026-05-04', '2026-05-04', 0, 0, '2026-05-04', '2026-05-04', '2026-05-04', 'S', '', '', _binary '', 'N', 'N', 'N', '', '', '', 'A', 'A'),
	(21, 6, 5, 3, 4, 6, 26, 9, 99, 'Computador', '103910', 'Precision3650', '', '', '0000000', '2026-05-12', '2026-05-12', 0, 0, '2026-05-12', '2026-05-12', '2026-05-12', 'S', '', '', _binary '', 'N', 'N', 'N', '', '', '', 'A', 'A');

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
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Copiando dados para a tabela gop.setores: ~18 rows (aproximadamente)
INSERT INTO `setores` (`id`, `descricao`, `id_centrodecusto`, `Responsavel`, `fone1`, `fone2`, `email`, `prioritario`, `nivelprioridade`) VALUES
	(5, 'Secretaria Municipal de Saúde', 5, 'pms', '', '', '', 'SIM', '1'),
	(6, 'Secretaria Municipal de Administração', 5, 'pms', '', '', '', 'SIM', '1'),
	(7, 'Secretaria de Planejamento', 5, 'pms', '', '', '', 'SIM', '1'),
	(8, 'Secretaria Municipal de Fazenda', 5, 'pms', '', '', '', 'SIM', '1'),
	(9, 'Secretaria de Obras', 5, 'pms', '', '', '', 'SIM', '1'),
	(10, 'Seretaria Municipal de Desenvolvimento Social', 5, 'pms', '', '', '', 'SIM', '1'),
	(11, 'Secretaria Municipal de Meio Ambiente', 5, 'pms', '', '', '', 'SIM', '1'),
	(12, 'Secretaria Municipal de Turismo', 5, 'pms', '', '', '', 'SIM', '1'),
	(13, 'Secretaria Municipal de Cultura', 5, 'pms', '', '', '', 'SIM', '1'),
	(14, 'Secretaria Municipal de Esportes', 5, 'pms', '', '', '', 'SIM', '1'),
	(15, 'Regional Roça Grande', 5, 'pms', '', '', '', 'SIM', '1'),
	(16, 'Regional General Carneiro', 5, 'pms', '', '', '', 'SIM', '1'),
	(17, 'Regional Borges', 5, 'pms', '', '', '', 'SIM', '1'),
	(18, 'Regional Ana Lucia', 5, 'pms', '', '', '', 'SIM', '1'),
	(19, 'Regional Ravena', 5, 'pms', '', '', '', 'SIM', '1'),
	(20, 'CRAS Roça Grande', 5, 'pms', '', '', '', 'SIM', '1'),
	(21, 'CRAS Fátima', 5, 'pms', '', '', '', 'SIM', '1'),
	(22, 'CRAS General Carneiro', 5, 'pms', '', '', '', 'SIM', '1'),
	(23, 'CRAS Alvorada', 5, 'pms', '', '', '', 'SIM', '1'),
	(24, 'UPA', 5, 'pms', '', '', '', 'SIM', '1'),
	(25, 'Regional Fátima', 5, 'pms', '', '', '', 'SIM', '1'),
	(27, 'Coordenação de Informática', 6, 'Welligton jardim', '(31) 3672-7688', '', '', 'SIM', '1'),
	(28, 'Secretaria Municipal de Educação', 6, 'Prefeitura', '', '', '', 'SIM', '1'),
	(29, 'Secretaria de Defesa Civil', 6, 'pms', '', '', '', 'SIM', '1'),
	(30, 'Secretaria de Segurança Pública', 6, 'pms', '', '', '', 'SIM', '1'),
	(31, 'Gabinete', 6, 'PMS', '', '', '', 'SIM', '1'),
	(32, 'Controladoria Municipal', 6, 'pms', '', '', '', 'SIM', '1'),
	(33, 'Procuradoria Juridica', 6, 'pms', '(31) 3672-7688', '', '', 'SIM', '1'),
	(34, 'PROCON', 6, 'pms', '', '', '', 'SIM', '1');

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
  `conclusao` blob,
  `classificacao` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `id_ordem` int DEFAULT NULL,
  `prazo_data` date DEFAULT NULL,
  `prazo_hora` time DEFAULT NULL,
  `data_conclusao` date DEFAULT NULL,
  `hora_conclusao` time DEFAULT NULL,
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
) ENGINE=InnoDB AUTO_INCREMENT=173 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Copiando dados para a tabela gop.solicitacao: ~92 rows (aproximadamente)
INSERT INTO `solicitacao` (`id`, `id_setor`, `id_solicitante`, `id_recursos`, `id_espaco`, `id_ocorrencia`, `data_abertura`, `hora_abertura`, `status`, `tipo`, `descricao`, `conclusao`, `classificacao`, `id_ordem`, `prazo_data`, `prazo_hora`, `data_conclusao`, `hora_conclusao`) VALUES
	(2, 28, 16, NULL, NULL, 55, '2026-03-18', '14:12:00', 'C', 'P', _binary 0x4e6f6d6520646f20757375c3a172696f203a7265646566696e69c3a7c3a36f2064612073656e686120646120757375c3a1726961204d617269656c6c792e50696e746f0d0a4c6f67696e20646f20757375c3a172696f203a204d617269656c6c792e50696e746f0d0a0d0a434f4e434c5553c3834f203a0d0a0d0a4e6f76612073656e686120646f20757375c3a172696f203a7361626172614032303236, _binary '', 'V', 2, '2026-03-18', '15:20:00', '2026-03-18', '14:33:00'),
	(3, 10, 16, NULL, NULL, 10, '2026-03-18', '14:23:00', 'C', 'P', _binary 0x446573637269c3a7c3a36f20646f20652d6d61696c202865782e203c64657363726963616f3e407361626172612e6d672e676f762e62723a2072656c61636f6573696e737469747563696f6e6169732e6473407361626172612e6d672e676f762e62720d0a526573706f6e73c3a176656c203a0d0a0d0a434f4e434c5553c3834f203a0d0a0d0a446573637269c3a7c3a36f20646f20652d6d61696c3a72656c61636f6573696e737469747563696f6e6169732e6473407361626172612e6d672e676f762e62720d0a53656e686120696e696369616c203a7361626172614032303236, _binary '', 'V', 3, '2026-03-18', '16:25:00', '2026-03-18', '14:30:00'),
	(4, 10, 16, NULL, NULL, 15, '2026-03-18', '14:45:00', 'C', 'P', _binary 0x4e6f6d6520646f20757375c3a172696f203a52616661656c20482e20502e204d6f72656972610d0a4d6f64756c6f7320717565206972c3a120616365737361722028636f6d707261732c206573746f7175652c20636f6e746162696c69646164652c2070726567c3a36f2c20637265646f7265732c2066726f7461732c20707265737461c3a7c3a36f20646520636f6e7461732c2070617472696dc3b46e696f203a0d0a436f6d707261730d0a0d0a0d0a0d0a434f4e434c5553c3834f203a0d0a0d0a557375c3a172696f2064652041636573736f203a2072616661656c2e6d6f72656972610d0a53656e68612064652041636573736f203a73616261726140323032360d0a0d0a557375c3a172696f20646f287329206dc3b364756c6f287329203a72616661656c2e6d6f72656972610d0a53656e686120646f287329206dc3b364756c6f287329203a7361626172614032303236, _binary '', 'V', 4, '2026-03-18', '16:45:00', '2026-03-18', '15:19:00'),
	(5, 6, 28, NULL, NULL, 36, '2026-03-18', '15:08:00', 'C', 'P', _binary 0x53454c4220646120496d70726573736f72613a20525647360d0a0d0a434f4e434c5553c3834f203a0d0a0d0a496d70726573736f726120696e7374616c61646120636f6d207375636573736f, _binary '', 'V', 5, '2026-03-21', '15:09:00', '2026-03-18', '15:10:00'),
	(7, 6, 28, NULL, NULL, 36, '2026-03-18', '15:11:00', 'C', 'P', _binary 0x53454c4220646120496d70726573736f7261203a20524756360d0a0d0a434f4e434c5553c3834f203a0d0a0d0a496d70726573736f726120696e7374616c61646120636f6d207375636573736f, _binary '', 'V', 6, '2026-03-21', '15:13:00', '2026-03-18', '15:14:00'),
	(8, 8, 16, NULL, NULL, 23, '2026-03-18', '15:15:00', 'C', 'P', _binary 0x50617472696d6f6e696f3a6ec3a36f20696e666f726d61646f0d0a, _binary 0x50726f626c656120656cc3a9747269636f20736f6c7563696f6e61646f, 'V', 7, '2026-03-18', '17:24:00', '2026-05-07', '12:09:00'),
	(9, 7, 29, NULL, NULL, 36, '2026-03-18', '15:31:00', 'C', 'P', _binary 0x53454c4220646120496d70726573736f7261203a20204ec3a36f20496e666f726d61646f0d0a41636f6d70616e68617220726574697261646120646520496d70726573736f726120646f205472616e73706f72746520284f6c6172696129206520696e7374616c6172206e612050726f63757261646f726961204a7572c3ad6469636120287375627374697475697220696d70726573736f7261292e0d0a0d0a434f4e434c5553c3834f203a0d0a0d0a42757363616d6f73206120696d70726573736f7261206520656c6120736520656e636f6e747261206e612073616c6120646520496e666f726dc3a174696361206e6f2043656e74726f2041646d696e69737472617469766f2e, _binary '', 'V', 9, '2026-03-21', '15:34:00', '2026-04-09', '13:05:00'),
	(12, 7, 29, NULL, NULL, 44, '2026-03-18', '15:32:00', 'C', 'P', _binary 0x6c6f63616c203a205665726966696361722050632064612054656f2065204a6f656c6d6120286c656e746964c3a36f20696e7465726e6574290d0a0d0a434f4e434c5553c3834f203a0d0a0d0a416775617264616e646f206c6962657261c3a7c3a36f206e6f204669726577616c6c2e, _binary '', 'V', 8, '2026-03-18', '16:33:00', '2026-03-18', '15:49:00'),
	(14, 6, 29, NULL, NULL, 36, '2026-03-19', '07:44:00', 'C', 'P', _binary 0x53454c4220646120496d70726573736f7261203a204e410d0a4d6f76696d656e74617220696d70726573736f726120286d65736d612073656372657461726961290d0a0d0a434f4e434c5553c3834f203a0d0a0d0a46697a656d6f732061206d7564616ec3a761206465206c6f63616c20646120696d70726573736f72612e20457374c3a12066756e63696f6e616e646f2e, _binary '', 'V', 10, '2026-03-19', '09:45:00', '2026-03-19', '08:21:00'),
	(15, 5, 16, NULL, NULL, 38, '2026-03-19', '09:54:00', 'C', 'P', _binary 0x53454c4220646120496d70726573736f7261203a50475a360d0a0d0a4c656e746964c3a36f206e6120696d7072657373c3a36f2e205061737361646f2070656c6f204a6fc3a36f206461205449206461205361c3ba64652e200d0a41626572746f206368616d61646f206e612053656c6265747469206368616d61646f206ec3ba6d65726f2031333935313331320d0a0d0a434f4e434c5553c3834f203a0d0a0d0a436f6d656e74c3a172696f20646f20416e616c697374613a20466f6920666569746f207465737465206571756970616d656e746f20696d7072696d696e646f206e6f726d616c6d656e7465, _binary '', 'V', 11, '2026-03-22', '09:59:00', '2026-03-20', '10:08:00'),
	(16, 6, 27, NULL, NULL, 36, '2026-03-19', '10:46:00', 'C', 'P', _binary 0x4d7564617220696e7374616c61c3a7c3a36f20646120696d70726573736f72612064612061646d696e6973747261c3a7c3a36f2070617261206f2052482e0d0a0d0a434f4e434c5553c3834f203a0d0a0d0a4d75646569206120696e7374616c61c3a7c3a36f20646120696d70726573736f72612064612041646d696e6973747261c3a7c3a36f2c20646f20757375c3a172696f205269636172646f2070617261206f2052482e, _binary '', 'V', 12, '2026-03-19', '12:47:00', '2026-03-19', '10:48:00'),
	(17, 8, 16, NULL, NULL, 59, '2026-03-20', '09:47:00', 'C', 'P', _binary 0x446573637269c3a7c3a36f20646f205365727669c3a76f203a2041636f6d70616e68616d656e746f206e6f20436164617374726f20646520696dc3b376656973207265616c697a61646f20656d20726176656e610d0a0d0a434f4e434c5553c3834f203a0d0a0d0a456665747561646f2061636f6d70616e68616d656e746f20636164617374726f20646520696dc3b37665697320656d20526176656e612e204571756970616d656e746f7320656d2066756e63696f6e616d656e746f206f6b2e, _binary '', 'V', 13, '2026-03-20', '17:00:00', '2026-03-20', '14:00:00'),
	(18, 29, 27, NULL, NULL, 36, '2026-03-20', '09:55:00', 'C', 'P', _binary 0x466f6920666569746f206120696e7374616c61c3a7c3a36f20646120696d70726573736f726120656d203520636f6d70757461646f7265732e0d0a0d0a434f4e434c5553c3834f203a0d0a0d0a466f6920666569746f206120696e7374616c61c3a7c3a36f20646120696d70726573736f726120656d203520636f6d70757461646f7265732e, _binary '', 'V', 14, '2026-03-20', '11:56:00', '2026-03-20', '09:58:00'),
	(19, 9, 16, NULL, NULL, 54, '2026-03-20', '10:19:00', 'C', 'P', _binary 0x4e6f6d6520646f20757375c3a172696f203a416c616e204d61676e6f20446961732064612053696c7661204a756e696f72c2a00d0a5061737461732064652061636573736f206e612072656465203a53656372657461726961206465206f627261730d0a0d0a434f4e434c5553c3834f203a0d0a0d0a4c6f67696e20646f20557375c3a172696f3a616c616e2e6d61676e6f0d0a53656e686120496e696369616c203a7361626172614032303236, _binary '', 'V', 15, '2026-03-20', '11:45:00', '2026-03-20', '10:27:00'),
	(20, 6, 16, NULL, NULL, 9, '2026-03-20', '10:33:00', 'C', 'P', _binary 0x757375c3a172696f203a4a65666572736f6e20285248290d0a41746976696461646520612073657220657865637574616461203a53756273746974756972206d617175696e6120646f205248206c696e75782070656c61206d617175696e6120646f2072682071756520656e636f6e7472612d7365206e61206d616e7574656ec3a7c3a36f0d0a0d0a434f4e434c5553c3834f203a0d0a0d0a436f6d70757461646f7220666f69207375627374697475c3ad646f20636f6d20c3aa7869746f2e20, _binary '', 'V', 16, '2026-03-20', '12:02:00', '2026-03-20', '11:18:00'),
	(21, 7, 16, NULL, NULL, 15, '2026-03-20', '11:55:00', 'C', 'P', _binary 0x4e6f6d6520646f20757375c3a172696f203a0d0a0d0a56656e686f20706f72206d65696f20646573746520736f6c696369746172207375706f7274652070617261206c6962657261c3a7c3a36f2064652061636573736f20616f2073697374656d61205375706572204e6f76612c2062656d20636f6d6f207665726966696361c3a7c3a36f2064652061636573736f20616f206dc3b364756c6f20646520506c616e656a616d656e746f2070617261206f73207365727669646f7265732061626169786f2072656c6163696f6e61646f733a0d0a0d0a4d6172696120436c617261206465204f6c6976656972612042726167610d0a4350463a203132302e3038342e3437362d39330d0a4d617472c3ad63756c613a2032343232380d0a5375736965204d61636861646f204e756e65730d0a4350463a203130392e3035342e3535362d38310d0a4d617472c3ad63756c613a2033323630320d0a0d0a4c75636173204665726e616e64657320646520416c6d6569646120436f7374610d0a4350463a203133352e3631342e3533362d31390d0a4d617472c3ad63756c613a2033333732310d0a0d0a4b617269656e6e65204a617175656c696e6520507261646f0d0a4350463a203038332e3539362e3236362d30300d0a4d617472c3ad63756c613a2033343634320d0a0d0a52656e61746120646520417261756a6f204665726e616e6465730d0a4350463a203036312e3335322e3733362d34370d0a4d617472c3ad63756c613a2033323239320d0a0d0a28417475616c6d656e74652073656d2061636573736f20616f206dc3b364756c6f20646520506c616e656a616d656e746f290d0a4d6f64756c6f7320717565206972c3a120616365737361722028636f6d707261732c206573746f7175652c20636f6e746162696c69646164652c2070726567c3a36f2c20637265646f7265732c2066726f7461732c20707265737461c3a7c3a36f20646520636f6e7461732c2070617472696dc3b46e696f203a0d0a6dc3b364756c6f20646520706c616e656a616d656e746f0d0a0d0a0d0a434f4e434c5553c3834f203a0d0a0d0a5365677565202061636573736f733a0d0a0d0a4d6172696120436c617261206465204f6c6976656972612042726167610d0a0d0a2020202020202020204ac3a120706f737375692061636573736f20696e696369616c20646f2073697374656d612e20557375c3a172696f206d617269612e62726167612e205365206ec3a36f20736f756265722073656e6861202870616472c3a36f207361626172614032303236292061766973617220706172612066617a6572207265736574206461206d65736d610d0a0d0a5375736965204d61636861646f204e756e65730d0ae28082e28082e28082e28082557375c3a172696f2064652061636573736f20696e696369616c20646f2073697374656d612073757369652e6d61636861646f2073656e686120696e696369616c2073616261726140323032360d0a0d0a4c75636173204665726e616e64657320646520416c6d6569646120436f7374610d0ae28082e28082e28082e28082557375c3a172696f2064652061636573736f203a206c756361732e636f7374612073656e686120696e696369616c2073616261726140323032360d0a0d0a4b617269656e6e65204a617175656c696e6520507261646f0d0a0d0a20e28082e28082e28082e280824ac3a120706f737375692061636573736f20616f2073697374656d612e20557375c3a172696f206b617269656e6e652e707261646f2e205365206ec3a36f20736f756265722073656e6861202870616472c3a36f207361626172614032303236292061766973617220706172612066617a6572207265736574206461206d65736d610d0a0d0a52656e61746120646520417261756a6f204665726e616e6465730d0a0d0ae28082e28082e28082e280824ac3a120706f737375692061636573736f20616f2073697374656d612e20557375c3a172696f2072656e6174612e6665726e616e6465732e205365206ec3a36f20736f756265722073656e6861202870616472c3a36f207361626172614032303236292061766973617220706172612066617a6572207265736574206461206d65736d610d0a0d0a4f7320757375c3a172696f732064652061636573736f20616f206dc3b364756c6f20646520706c616e656a616d656e746f20c3a9206f206d65736d6f20646f2061636573736f20696e696369616c2e20546f646f7320636f6d20612073656e686120696e696369616c207361626172614032303236, _binary '', 'V', 19, '2026-03-20', '17:38:00', '2026-03-20', '15:38:00'),
	(22, 6, 27, NULL, NULL, 36, '2026-03-20', '12:09:00', 'C', 'P', _binary 0x496e7374616c617220757375c3a172696f20646120696d70726573736f726120656d206f7574726120696d70726573736f72612e20496d70726573736f72612041444d20706172612052682e0d0a0d0a434f4e434c5553c3834f203a0d0a0d0a496e7374616c61646f20757375c3a172696f20646120696d70726573736f72612041444d206e6120696d70726573736f726120646f2052682e, _binary '', 'V', 17, '2026-03-20', '14:09:00', '2026-03-20', '12:10:00'),
	(23, 31, 28, NULL, NULL, 60, '2026-03-20', '15:08:00', 'C', 'P', _binary 0x4c6f63616c203a2053616c61206465205265756e69c3a36f0d0a526573706f6e73c3a176656c3a204a6f656c6d610d0a0d0a434f4e434c5553c3834f203a0d0a0d0a4f204361626f2048444d4920657374c3a120636f6d206d616c20636f6e7461746f, _binary '', 'V', 18, '2026-03-20', '15:39:00', '2026-03-20', '15:11:00'),
	(24, 31, 28, NULL, NULL, 28, '2026-03-20', '16:15:00', 'C', 'P', _binary 0x506f73737569204c6963656ec3a7612873696d2f6ec3a36f29203f206ec3a36f0d0a446573637269c3a7c3a36f20646f20736f66747761726520612073657220696e7374616c61646f3a2057696e5241522028477261747569746f290d0a0d0a434f4e434c5553c3834f203a0d0a0d0a466f692072657061737361646f20c3a0207365727669646f7261204c61696c6120636f6d6f20636f6d706163746172206520646573636f6d706163746172206172717569766f73207574696c697a616e646f2057696e726172, _binary '', 'V', 20, '2026-03-20', '16:46:00', '2026-03-20', '16:18:00'),
	(25, 29, 16, 7, NULL, 20, '2026-03-23', '08:54:00', 'C', 'P', _binary 0x50617472696dc3b46e696f203a3131363535310d0a0d0a436f6d70757461646f72207472617661646f206e612074656c6120696e696369616c2064612044454c4c2e20466f69206665697461207669736974612064652074c3a9636e69636f2064612064656c6c207175652074726f636f75206120706c616361206dc3a3652e0d0a4f206571756970616d656e746f20766f6c746f752061206170726573656e746172206f2070726f626c656d6120646f69732064696173206170c3b3732061207669736974612e200d0a0d0a434f4e434c5553c3834f203a0d0a0d0a566973697461207265616c697a6164612070656c6f2074c3a9636e69636f2064612064656c6c202e204571756970616d656e746f2074657665207175652073657220666f726d617461646f206520656e636f6e7472612d73652066756e63696f6e616c, _binary '', 'R', 28, '2026-03-26', '10:49:00', '2026-03-30', '10:13:00'),
	(26, 6, 28, NULL, NULL, 20, '2026-03-23', '09:12:00', 'C', 'U', _binary 0x46756e63696f616ec3a17269612072656c61746120717565206f20636f6d70757461646f72206ec3a36f2071756572206c696761720d0a0d0a434f4e434c5553c3834f203a0d0a0d0a466f69207665726966696361646f2071756520612066756e63696f6ec3a1726961206ec3a36f206c69676f75206f206573746162696c697a61646f722e204170c3b373206c69676172206f206571756970616d656e746f206f20636f6d70757461646f722066756e63696f6e6f752070657266656974616d656e7465, _binary '', 'V', 21, '2026-03-23', '09:30:00', '2026-03-23', '09:15:00'),
	(27, 6, 16, NULL, NULL, 62, '2026-03-23', '09:34:00', 'C', 'P', _binary 0x4e6f6d6520646f20557375c3a172696f3a546861796e617261204c61757261206465204f2e2054656978656972610d0a4350463a3133352e3939322e3330362d33330d0a4c6f63616973206465205472616d697461c3a7c3a36f203a50726f746f636f6c6f0d0a0d0a434f4e434c5553c3834f203a0d0a0d0a4c6f67696e20646f20557375c3a172696f203a746861796e6172612e74656978656972610d0a53656e68612064652041636573736f203a313233343536, _binary '', 'V', 22, '2026-03-23', '10:05:00', '2026-03-23', '09:59:00'),
	(28, 30, 29, NULL, NULL, 63, '2026-03-23', '09:49:00', 'C', 'P', _binary 0x4c6f63616c3a20507261c3a76120476574c3ba6c696f205661726761730d0a5265666572c3aa6e6369613a20506f6e746f20646520546178690d0a436f6e7461746f3a, _binary 0x696e7374616c61c3a7c3a36f20646f20706f6e746f20646520696e7465726e657420652074656c65666f6e6961207265616c697a61646f2070656c612073706565646e65742e204e6563657373c3a172696f2061706172656c686f2074656c6566c3b46e69636f207061726120636f6e666967757261c3a7c3a36f, 'V', 78, '2026-04-13', '16:03:00', '2026-04-14', '14:25:00'),
	(29, 32, 16, NULL, NULL, 48, '2026-03-23', '10:12:00', 'A', 'P', _binary 0x4c6f63616c3a435041440d0a4ec3ba6d65726f20646520706f6e746f733a203120706f6e746f0d0a436f6e7461746f203a20416e6472c3a961204e2e204e65766573, _binary '', 'V', NULL, NULL, NULL, NULL, NULL),
	(30, 6, 16, NULL, NULL, 54, '2026-03-23', '10:30:00', 'C', 'P', _binary 0x4e6f6d6520646f20757375c3a172696f203a746861796e6172612e74656978656972610d0a5061737461732064652061636573736f206e612072656465203a41646d696e6973747261c3a7c3a36f0d0a0d0a434f4e434c5553c3834f203a0d0a0d0a4c6f67696e20646f20557375c3a172696f3a7468796e6172612e74656978656972610d0a53656e686120496e696369616c203a7361626172614032303236, _binary '', 'V', 23, '2026-03-23', '11:00:00', '2026-03-23', '10:31:00'),
	(31, 7, 27, NULL, NULL, 8, '2026-03-23', '12:37:00', 'C', 'P', _binary 0x466f726d61746172203420636f6d70757461646f7265732c207061726120736572656d20757361646f73206e6120506f6c696369612e0d0a0d0a434f4e434c5553c3834f203a0d0a0d0a436f6d70757461646f7265732066696e616c697a61646f733a20504154203131393032312c3131383734372c3131383736332e2046697a206120666f726d617461c3a7c3a36f20652075706772616465206465206d656dc3b37269612065205353442e20, _binary '', 'V', 24, '2026-03-26', '12:37:00', '2026-03-25', '07:54:00'),
	(32, 5, 16, NULL, NULL, 67, '2026-03-23', '15:31:00', 'C', 'P', _binary 0x4c6f67696e20646f20557375c3a172696f203a72616661656c68656c656e6f0d0a4e6f766f73206c6f63616973206465207472616d697461c3a7c3a36f3a52482064612053454d5553410d0a4578636c756972206c6f6361697320616e746572696f726573202873696d2f4ec3a36f29203a53696d0d0a0d0a434f4e434c5553c3834f203a0d0a0d0a416c74657261646f206c6f63616c206465207472616d697461c3a7c3a36f20706172612053656372657461726961206d756e69636970616c206465205361c3ba6465, _binary '', 'V', 25, '2026-03-23', '16:19:00', '2026-03-23', '15:49:00'),
	(33, 28, 16, NULL, NULL, 38, '2026-03-23', '16:33:00', 'C', 'P', _binary 0x53454c4220646120496d70726573736f7261203a544643380d0a4571756970616d656e746f20636f6d2070726f626c656d6173206d6563c3a26e69636f732e20426172756c686f20616f20696d7072696d6972206520656d626f6c616e646f20706170656c2e0d0a4368616d61646f20736f6c6963697461646f2070656c6f2074c3a9636e69636f2064612073656372657461726961206465204564756361c3a7c3a36f0d0a0d0a434f4e434c5553c3834f203a0d0a0d0a466f6920666569746f2074726f6361722064612070656c6963756c6120646120667573616f2e204571756970616d656e746f2066756e63696f6e616c, _binary '', 'V', 26, '2026-03-26', '16:33:00', '2026-03-24', '16:50:00'),
	(34, 6, 28, NULL, NULL, 24, '2026-03-24', '08:36:00', 'C', 'P', _binary 0x436f6e6669677572617220636f6d70757461646f7220706172612066756e63696f6ec3a172696120546861796e617261206e6f207365746f722064652050726f746f636f6c6f0d0a0d0a434f4e434c5553c3834f203a0d0a0d0a466f69206e6563657373c3a172696f207265736574617220612073656e68612064652061646d696e6973747261646f72206c6f63616c2c206174726176c3a97320646520756d2070656e64726976652c207061726120656e74c3a36f207265636f6c6f636172206f20636f6d70757461646f72206e6f20646f6dc3ad6e696f206520617373696d20696e636c7569722061206e6f76612066756e63696f6ec3a172696120616f2061636573736f2e20466f6920636f6e666967757261646f2074616d62c3a96d206120696d70726573736f72612c2066696e616c697a61646f206f73207465737465732065206465766f6c7669646f20616f207365746f722e, _binary '', 'V', 27, '2026-03-25', '08:36:00', '2026-03-24', '08:37:00'),
	(35, 29, 28, NULL, NULL, 36, '2026-03-24', '10:52:00', 'C', 'P', _binary 0x496e7374616c61c3a7c3a36f20696d70726573736f726120646f205248207061726120757375c3a172696f20446f75676c61730d0a0d0a434f4e434c5553c3834f203a0d0a0d0a696e7374616c61c3a7c3a36f20636f6e636c75c3ad646120636f6d207375636573736f, _binary '', 'V', 29, '2026-03-24', '11:57:00', '2026-03-24', '11:02:00'),
	(36, 7, 16, NULL, NULL, 54, '2026-03-24', '11:20:00', 'C', 'P', _binary 0x4e6f6d6520646f20757375c3a172696f203a7068696c6c6970652e616d7061726f0d0a5061737461732064652061636573736f206e612072656465203a706c616e656a616d656e746f0d0a0d0a434f4e434c5553c3834f203a0d0a0d0a4c6f67696e20646f20557375c3a172696f3a7068696c6c6970652e616d7061726f0d0a53656e686120496e696369616c203a7361626172614032303236, _binary '', 'V', 30, '2026-03-24', '12:20:00', '2026-03-24', '11:25:00'),
	(37, 25, 16, NULL, NULL, 62, '2026-03-24', '11:34:00', 'C', 'P', _binary 0x4e6f6d6520646f20557375c3a172696f3a7061747269636961204d6172746120476f6d65730d0a4350463a6ec3a36f20696e666f726d61646f0d0a4c6f63616973206465205472616d697461c3a7c3a36f203a726567696f6e616c2066c3a174696d610d0a0d0a4e6f6d6520646f20557375c3a172696f3a6269616e6361204d6178696d6120646f73205265697320416c7665730d0a4350463a0d0a4c6f63616973206465205472616d697461c3a7c3a36f203a20726567696f6e616c20666174696d610d0a0d0a434f4e434c5553c3834f203a0d0a0d0a4c6f67696e20646f20557375c3a172696f3a206d617274612e676f6d65730d0a53656e686120496e696369616c203a203132333435360d0a0d0a4c6f67696e20646f20557375c3a172696f3a206269616e63612e6d6178696d6f0d0a53656e686120496e696369616c203a20313233343536, _binary '', 'V', 31, '2026-03-24', '12:04:00', '2026-03-24', '16:30:00'),
	(38, 25, 16, NULL, NULL, 54, '2026-03-24', '11:37:00', 'C', 'P', _binary 0x4e6f6d6520646f20757375c3a172696f203a5061747269636961204d6172746120476f6d65730d0a5061737461732064652061636573736f206e612072656465203a526567696f6e616c20666174696d610d0a0d0a4e6f6d6520646f20757375c3a172696f203a4269616e6361204d6178696d6120646f73205265697320416c7665730d0a5061737461732064652061636573736f206e612072656465203a726567696f6e616c20666174696d610d0a0d0a434f4e434c5553c3834f203a0d0a0d0a4c6f67696e20646f20557375c3a172696f3a206d617274612e676f6d65730d0a53656e686120496e696369616c203a2073616261726140323032360d0a0d0a4c6f67696e20646f20557375c3a172696f3a206269616e63612e6d6178696d6f0d0a53656e686120496e696369616c203a2073616261726140323032360d0a, _binary '', 'V', 32, '2026-03-24', '12:37:00', '2026-03-24', '16:29:00'),
	(39, 6, 29, NULL, NULL, 19, '2026-03-24', '11:48:00', 'C', 'P', _binary 0x50617472696dc3b46e696f20646f20436f6d70757461646f72203a204e410d0a557375c3a172696f3a2041647269616e6120284a756e746120646f205365727669c3a76f204d696c69746172290d0a0d0a5665726966696361722070726f6772616d61732071756520657374c3a36f2063617573616e646f206c656e746964616f2e2e2e0d0a0d0a434f4e434c5553c3834f203a0d0a0d0a436f6d70757461646f722070726563697361206465207065c3a761732c204864206f7520506c616361206dc3a3652c20657374616f20636f6d206465666569746f, _binary '', 'V', 33, '2026-03-25', '11:48:00', '2026-03-26', '15:21:00'),
	(40, 9, 16, NULL, NULL, 69, '2026-03-24', '12:00:00', 'C', 'P', _binary 0x41636f6d70616d656e746f20646520766973746f7269612074c3a9636e6963612070617261206d616e7574656ec3a7c3a36f206465206e6f2d627265616b0d0a0d0a434f4e434c5553c3834f203a0d0a0d0a5669736974612074c3a9636e696361207265616c697a616461206a756e746f206120656d707265736120736b206e6f2d627265616b207265616c697a61646120636f6d207375636573736f, _binary '', 'V', 34, '2026-03-24', '10:30:00', '2026-03-24', '12:02:00'),
	(41, 9, 16, NULL, NULL, 55, '2026-03-24', '14:25:00', 'C', 'P', _binary 0x4e6f6d6520646f20757375c3a172696f203a74617469616e61206d61746961730d0a4c6f67696e20646f20757375c3a172696f203a74617469616e612e6d61746961730d0a0d0a434f4e434c5553c3834f203a0d0a0d0a4e6f76612073656e686120646f20757375c3a172696f203a7361626172614032303236, _binary '', 'V', 35, '2026-03-24', '15:25:00', '2026-03-24', '14:26:00'),
	(42, 10, 16, NULL, NULL, 28, '2026-03-24', '16:13:00', 'C', 'P', _binary 0x506f73737569204c6963656ec3a7612873696d2f6ec3a36f29203f206ec3a36f20736f667477617265206c697672650d0a446573637269c3a7c3a36f20646f20736f66747761726520612073657220696e7374616c61646f3a41646f6265207265616465720d0a496e7374616c61c3a7c3a36f206e61206164766f6361636961204d756e69636970616c200d0a0d0a0d0a0d0a434f4e434c5553c3834f203a0d0a0d0a41646f626520496e7374616c61646f20636f6d207375636573736f, _binary '', 'V', 36, '2026-03-24', '18:18:00', '2026-03-25', '10:35:00'),
	(43, 9, 27, NULL, NULL, 8, '2026-03-25', '08:19:00', 'C', 'P', _binary 0x557375c3a172696f203a2053616272696e610d0a50617472696d6f6e696f3a203131393238390d0a0d0a446573637269c3a7c3a36f20646f2070726f626c656d613a20466f726d6174617220636f6d70757461646f722c2057696e646f7773206e206163657373612e0d0a0d0a434f4e434c5553c3834f203a0d0a0d0a536f6c6963697461c3a7c3a36f20636f6e636c75c3ad64612c206e6f7465626f6f6b20666f6920666f726d617461646f2e, _binary '', 'V', 37, '2026-03-28', '08:20:00', '2026-03-25', '10:30:00'),
	(44, 5, 16, NULL, NULL, 54, '2026-03-25', '08:53:00', 'C', 'P', _binary 0x4e6f6d6520646f20757375c3a172696f203a7961736d696e2043617276616c686f202d2072656465206461207361c3ba64650d0a5061737461732064652061636573736f206e612072656465203a2073614661726d616369610d0a0d0a434f4e434c5553c3834f203a0d0a0d0a4c6f67696e20646f20557375c3a172696f3a7961736d696e2e63617276616c686f0d0a53656e686120496e696369616c203a7361626172614032303232, _binary '', 'V', 38, '2026-03-25', '09:53:00', '2026-03-25', '08:53:00'),
	(45, 5, 16, NULL, NULL, 62, '2026-03-25', '10:41:00', 'C', 'P', _binary 0x4e6f6d6520646f20557375c3a172696f3a4d696368656c6c652050616d656c6120476f6ec3a7616c76657320646120436f737461204c6973626f610d0a4350463a0d0a4c6f63616973206465205472616d697461c3a7c3a36f203a20536563726574617269612064652073617564650d0a0d0a434f4e434c5553c3834f203a0d0a0d0a4c6f67696e20646f20557375c3a172696f203a206d696368656c6c652e6c6973626f610d0a53656e68612064652041636573736f203a313233343536, _binary '', 'V', 39, '2026-03-25', '11:12:00', '2026-03-25', '10:48:00'),
	(46, 11, 30, NULL, NULL, 23, '2026-03-25', '10:43:00', 'C', 'P', _binary 0x50617472696d6f6e696f3a203130353535330d0a50632044656c6c204f707469706c6578333030302c2054414720424d32473652333b207265737461757261c3a7c3a36f20646f2053697374656d61204f7065726163696f6e616c2028313320686f726173293b20696e7374616c61c3a7c3a36f2064652070726f6772616d61733b2061646963696f6e617220616f20646f6dc3ad6e696f3b20696e7374616c61c3a7c3a36f20646520696d70726573736f72613b200d0a0d0a0d0a434f4e434c5553c3834f203a0d0a0d0a53697374656d61207265696e7374616c61646f2c2061646420646f6dc3ad6e696f2e2e2e, _binary '', 'V', 41, '2026-03-26', '13:45:00', '2026-03-25', '16:07:00'),
	(47, 7, 30, NULL, NULL, 59, '2026-03-25', '10:58:00', 'C', 'P', _binary 0x4d6f6e746167656d20646520646f697320706f6e746f73206465206174656e64696d656e746f2070617261207265736f6c7665722070656e64c3aa6e636961732065206573636c6172656365722064c3ba76696461732072656c6163696f6e61646173206120495054552c20436164617374726f20496d6f62696c69c3a172696f20652047656f70726f63657373616d656e746f2c206e612072656769c3a36f2063656e7472616c20646520526176656e612065206e6f20706f766f61646f20646520547261c3ad7261732e0d0a0d0a434f4e434c5553c3834f203a0d0a0d0a5365727669c3a76f207265666572656e746520612061636f6d70616e68616d656e746f207265616c697a61646f206e6f2064696120313720616f20646961203231206465206d6172c3a76f2e20, _binary '', 'V', 40, '2026-03-25', '17:00:00', '2026-03-25', '11:39:00'),
	(48, 14, 29, NULL, NULL, 43, '2026-03-25', '11:54:00', 'C', 'P', _binary 0x6c6f63616c203a2053656372657461726961206465204573706f7274657320285369646572c3ba726769636120202d2053616c6120646f2056697661204d616973290d0a0d0a434f4e434c5553c3834f203a0d0a0d0a4465736c69676172616d206f20706f6e746f20646f207377697463682e2050726f626c656d61207265736f6c7669646f2e, _binary '', 'V', 42, '2026-03-25', '15:03:00', '2026-03-25', '12:46:00'),
	(49, 6, 30, NULL, NULL, 19, '2026-03-25', '15:08:00', 'C', 'P', _binary 0x566572696669636172206f207063206461204a554e5441204d494c495441522e0d0a0d0a50617472696dc3b56e696f20646f20436f6d70757461646f72203a0d0a557375c3a172696f3a0d0a0d0a434f4e434c5553c3834f203a0d0a0d0a4665697461206c696d70657a612064652063616368652c20626c6f717565696f206465207369746573202870617261206576697461722061647761726573292c206578636c7573c3a36f20646f73206172717569766f732074656d706f72c3a172696f732028757375c3a172696f73202d20415050444154412d206520646f73206e6176656761646f726573292e, _binary '', 'V', 43, '2026-03-27', '15:09:00', '2026-03-26', '16:31:00'),
	(50, 6, 30, NULL, NULL, 23, '2026-03-25', '15:17:00', 'C', 'P', _binary 0x50617472696d6f6e696f3a3131393031390d0a0d0a5265696e7374616c61c3a7c3a36f2064652053697374656d61204f7065726163696f6e616c2c20706172612075736f206e6f2052482e0d0a0d0a0d0a434f4e434c5553c3834f203a0d0a0d0a5265696e7374616c61c3a7c3a36f20646f2053697374656d61204f7065726163696f6e616c2c20696e7374616c61c3a7c3a36f20646f73202270726f6772616d61732070616472c3a36f222c20696e7374616c61c3a7c3a36f20646520696d70726573736f72612c2061646963696f6e617220616f20646f6dc3ad6e696f2c20617475616c697a61c3a7c3b56573206e6563657373c3a172696173206465206472697665732e, _binary '', 'V', 44, '2026-03-26', '17:00:00', '2026-03-25', '17:05:00'),
	(51, 6, 30, NULL, NULL, 69, '2026-03-25', '15:30:00', 'C', 'P', _binary 0x7375706f7274652074c3a9636e69636f206e61207265646566696e69c3a7c3a36f2064652073656e68612065207265637570657261c3a7c3a36f2064652061636573736f20616f7320652d6d61696c7320646f207365746f72206465205365677572616ec3a76120646f2054726162616c686f0d0a0d0a434f4e434c5553c3834f203a0d0a0d0a66696e616c697a61c3a7c3a36f20646f207375706f727465206520c3a020646973706f7369c3a7c3a36f2070617261206576656e7475616973207175657374696f6e616d656e746f732065207375706f727465, _binary '', 'V', 45, '2026-03-25', '11:32:00', '2026-03-25', '15:58:00'),
	(52, 6, 30, NULL, NULL, 69, '2026-03-25', '16:55:00', 'C', 'P', _binary 0x5665726966696361722061636573736f206120646f63756d656e746f7320636f6d70617274696c6861646f7320284472697665290d0a0d0a434f4e434c5553c3834f203a0d0a0d0a417475616c697a61c3a7c3a36f20646f732064726976657320646f2070632e20, _binary '', 'V', 46, '2026-03-26', '11:00:00', '2026-03-26', '09:15:00'),
	(53, 32, 16, NULL, NULL, 56, '2026-03-26', '09:08:00', 'C', 'P', _binary 0x4c6f67696e20646f20757375c3a172696f203a0d0a0d0a43616d696c612e66656c69780d0a526f647269676f2e6772696c6f0d0a52616661656c2e68656c656e6f0d0a5072697363696c612e626172626f73610d0a5265626563612e736f706869610d0a5261696172612e7261697373610d0a426172626172612e73696c76610d0a4c756361732e766963746f720d0a0d0a4e6f766173207061737461732064652061636573736f206e612072656465203a20526574697261722061636573736f20646120706173746120637061640d0a0d0a434f4e434c5553c3834f203a0d0a0d0a546f646f73206f7320757375c3a172696f73207469766572616d206f7320736575732061636573736f732072656d6f7669646f732064612070617374612063706164, _binary '', 'V', 48, '2026-03-26', '10:57:00', '2026-03-26', '10:02:00'),
	(54, 13, 16, NULL, NULL, 16, '2026-03-26', '09:12:00', 'C', 'P', _binary 0x5175616c206f206c6f67696e20646f20757375c3a172696f3f203a206c6574c3ad6369612e636f7272616469200d0a0d0a434f4e434c5553c3834f203a0d0a0d0a4e6f76612073656e6861207265646566696e696461203a73616261726140323032360d0a6170656e6173207072696d6569726f2061636573736f2e206e656e68756d612073656e61206465206dc3b364756f20666f69207265646566696e696461, _binary '', 'V', 47, '2026-03-26', '10:20:00', '2026-03-26', '10:51:00'),
	(55, 19, 16, NULL, NULL, 38, '2026-03-26', '10:41:00', 'C', 'P', _binary 0x53454c4220646120496d70726573736f7261203a646575350d0a54726176616461206e612074656c61206465207374617475730d0a0d0a434f4e434c5553c3834f203a0d0a0d0a5265736f6c7669646f2073656d206e6563657373696461646520646520766973697461206669736963612e20466f6920726574697261646f2065207265636f6c6f6361646f206f20746f6e65722070617261207265736f6c75c3a7c3a36f20646f2070726f626c656d61, _binary '', 'V', 49, '2026-03-29', '10:42:00', '2026-03-26', '13:58:00'),
	(56, 30, 16, NULL, NULL, 10, '2026-03-26', '11:50:00', 'C', 'P', _binary 0x446573637269c3a7c3a36f20646f20652d6d61696c202865782e203c64657363726963616f3e407361626172612e6d672e676f762e62723a766967696c616e63696170617472696d6f6e69616c407361626172612e6d672e676f762e62720d0a526573706f6e73c3a176656c203a7365677572616ec3a761207075626c6963610d0a0d0a434f4e434c5553c3834f203a0d0a0d0a446573637269c3a7c3a36f20646f20652d6d61696c3a766967696c616e63696170617472696d6f6e69616c407361626172612e6d672e676f762e62720d0a53656e686120696e696369616f203a7361626172614032303236, _binary '', 'V', 50, '2026-03-26', '13:51:00', '2026-03-26', '14:41:00'),
	(57, 12, 16, NULL, NULL, 54, '2026-03-26', '11:54:00', 'C', 'P', _binary 0x4e6f6d6520646f20757375c3a172696f203a5261796c616e6520766974c3b372696120646520536f757a61204665726e616e6465730d0a5061737461732064652061636573736f206e612072656465203a74757269736d6f0d0a0d0a434f4e434c5553c3834f203a0d0a0d0a557375c3a172696f207261796c616e652e7669746f7269610d0a53656e6861207361626172614032303236, _binary '', 'V', 51, '2026-03-26', '12:55:00', '2026-03-26', '14:24:00'),
	(58, 28, 16, NULL, NULL, 16, '2026-03-26', '11:58:00', 'C', 'P', _binary 0x5175616c206f206c6f67696e20646f20757375c3a172696f3f203a416e61204b61726c612064652044657573c2a00d0a0d0a434f4e434c5553c3834f203a0d0a0d0a4e6f76612073656e6861207265646566696e696461203a7361626172614032303236, _binary '', 'V', 52, '2026-03-26', '12:29:00', '2026-03-26', '14:17:00'),
	(59, 7, 16, NULL, NULL, 48, '2026-03-26', '12:03:00', 'X', 'P', _binary 0x4c6f63616c3a2050726f636f6e206465205361626172c3a10d0a4ec3ba6d65726f20646520706f6e746f733a3220706f6e746f732070617261206c69676172203220636f6d70757461646f726573, _binary '', 'V', 132, '2026-04-29', '17:02:00', NULL, NULL),
	(60, 7, 30, NULL, NULL, 25, '2026-03-26', '16:29:00', 'C', 'P', _binary 0x50617472696dc3b46e696f203a0d0a636865636f75206361626f7320646520656e6572676961202873696d2f6ec3a36f293f200d0a0d0a41646963696f6e6172206d6f6e69746f7220657874726120616f2070632e2046616c7461206361626f2068646d69206f7520646973706c6179706f72742e0d0a4c6f63616c3a2053494e450d0a0d0a434f4e434c5553c3834f203a0d0a0d0a70726f636564696d656e746f207265616c697a61646f, _binary '', 'V', 79, '2026-04-08', '13:10:00', '2026-04-09', '08:19:00'),
	(61, 30, 30, NULL, NULL, 28, '2026-03-26', '21:59:00', 'X', 'P', _binary 0x506f73737569204c6963656ec3a7612873696d2f6ec3a36f29203f0d0a446573637269c3a7c3a36f20646f20736f66747761726520612073657220696e7374616c61646f3a20736f667477617265207061726120676572656e6369616d656e746f206465206d756c746173, _binary '', 'V', 92, '2026-04-14', '11:04:00', NULL, NULL),
	(62, 8, 29, NULL, NULL, 73, '2026-03-27', '09:11:00', 'X', 'P', _binary 0x536563726574617269612f476572656e6369613a20476162696e65746520536563726574617269612064612046617a656e64610d0a557375c3a172696f3a204d617269612045647561726461202844756461290d0a4ec3ba6d65726f3a0d0a0d0a417578696c696172206e6120696e7374616c61c3a7c3a36f206520636f6e666967757261c3a7c3a36f20646f2041757468656e74696361746f72, _binary '', 'V', 53, '2026-03-27', '09:11:00', NULL, NULL),
	(63, 29, 26, NULL, NULL, 21, '2026-03-27', '10:30:00', 'C', 'P', _binary 0x50617472696dc3b46e696f203a20303933303135204571756970616d656e746f206170726573656e7461646f2074656c6120617a756c0d0a0d0a0d0a434f4e434c5553c3834f203a0d0a0d0a466569746120612074726f636120646f2048443b207265737461757261646f2053697374656d61204f7065726163696f6e616c3b20696e7374616c61646f202270726f6772616d61732070616472c3a36f223b2061646963696f6e61646f20616f20646f6dc3ad6e696f20504d532e, _binary '', 'V', 54, '2026-03-29', '10:31:00', '2026-04-06', '13:09:00'),
	(64, 33, 28, NULL, NULL, 41, '2026-03-27', '14:32:00', 'C', 'P', _binary 0x536520666f7220696d70726573736f726120636f6c6f72696461207175616c206120636f7220746f20746f6e6572203f3a206d6167656e74610d0a0d0a0d0a434f4e434c5553c3834f203a0d0a0d0a696e7374616c61c3a7c3a36f20636f6e636c75c3ad64612c20746573746573206f6b, _binary '', 'V', 55, '2026-03-27', '15:32:00', '2026-03-27', '14:33:00'),
	(65, 6, 30, NULL, NULL, 69, '2026-03-30', '08:22:00', 'C', 'P', _binary 0x41636573736f20616f20656d61696c20646f205265637572736f732048756d616e6f7320285061756c6f290d0a0d0a434f4e434c5553c3834f203a0d0a0d0a43c3b36469676f732064652061636573736f20656e766961646f7320706172612063656c756c617220636f72706f72617469766f, _binary '', 'V', 56, '2026-03-30', '08:23:00', '2026-03-30', '08:24:00'),
	(66, 25, 16, NULL, NULL, 70, '2026-03-30', '10:17:00', 'C', 'P', _binary 0x56657269666963617220706f6e746f732064652072656465206520766572696669636172207365206dc3a17175696e617320657374c3a36f206e6f20646f6dc3ad6e696f0d0a0d0a434f4e434c5553c3834f203a0d0a0d0a436f6e636c7573c3a36f203a20436f6d70757461646f72657320636f6c6f6361646f73206e6f20646f6dc3ad6e696f2e20526567696f6e616c207072656369736120636f6d7072617220756d204875622f537769746368206465203820706f727461732c20706172612061646963696f6e6172206d61697320636f6d70757461646f7265732e, _binary '', 'V', 61, '2026-04-06', '17:00:00', '2026-04-09', '13:08:00'),
	(67, 7, 29, NULL, NULL, 60, '2026-03-30', '11:04:00', 'X', 'P', _binary 0x4c6f63616c203a20496e7374616c6172206e612053616c61206465205265756e69c3a36f0d0a526573706f6e73c3a176656c3a204361726c6f73204564756172646f0d0a0d0a4f62732e3a20696e7374616c61722050726f6a65746f722065204e6f7465626f6f6b206e612053616c61206465205265756e69c3a36f20c3a0732031333a333020646f206469612033312f30332f323032362e0d0a284e6f7465626f6f6b2076657269666963617220636f6d206f204361726c6f73204564756172646f2c2070726f766176656c6d656e7465206f2071756520657374c3a120656d707265737461646f20636f6d2061204d617269616e6129, _binary '', 'V', 57, '2026-03-31', '13:50:00', NULL, NULL),
	(68, 32, 28, NULL, NULL, 24, '2026-03-30', '16:27:00', 'C', 'P', _binary 0x557375c3a172696f2052616661656c612072656c6174612071756520616f2074656e7461722061636573736172206f20706320636f6d2073657520757375c3a172696f2073656d70726520617061726563653a2022757375c3a172696f206f752073656e686120696e76c3a16c696461222e2045207175616e646f206c6f676120656d2070632057696e646f77732c206f206d65736d6f20657374c3a1206f6b2e0d0a0d0a434f4e434c5553c3834f203a0d0a0d0a466f6920726574697261646f20646f20646f6dc3ad6e696f204c696e75782065207265696e636c75c3ad646f2e205265616c697a61646f206f73207465737465732c206f6b2e, _binary '', 'V', 58, '2026-03-31', '15:30:00', '2026-03-30', '16:28:00'),
	(69, 7, 16, NULL, NULL, 24, '2026-03-31', '09:47:00', 'C', 'P', _binary 0x50617472696dc3b46e696f203a0d0a41646963696f6e6172207063206461207361c3ba6465206e61207265646520706d730d0a0d0a557375c3a172696f2072656e6174612e617261c3ba6a6f0d0a0d0a434f4e434c5553c3834f203a0d0a0d0a50432061646963696f6e61646f20616f20646f6dc3ad6e696f3b20696d70726573736f726120636f6e66696775726164613b20636f6e666967757261646f206f732061636573736f7320c3a0732070617374617320646520726564652065207363616e6e65723b20646f63756d656e746f732f6172717569766f7320636f706961646f733b2074657374657320666569746f732e, _binary '', 'V', 59, '2026-03-31', '09:30:00', '2026-03-31', '10:05:00'),
	(70, 29, 28, NULL, NULL, 70, '2026-03-31', '16:57:00', 'C', 'P', _binary 0x436f6d70757461646f72207472617661206e612074656c6120646520696e696369616c697a61c3a7c3a36f0d0a0d0a434f4e434c5553c3834f203a0d0a0d0a436f6e636c7573c3a36f203a20466f692074726f6361646120706c616361206dc3a36520652070726f6365737361646f722070656c6120656d70726573612044656c6c2e204170c3b37320666f69206665697461207265696e7374616c61c3a7c3a36f20646f2077696e646f77732c207265696e7374616c61c3a7c3a36f20646f732070726f6772616d61732c207265696e7374616c61c3a7c3a36f206f66666963652c20696e7374616c61c3a7c3a36f20646120726564652c20696d70726573736f7261732c2074657374657320636f6d20757375c3a172696f2c206f6b, _binary '', 'V', 60, '2026-03-31', '16:57:00', '2026-03-31', '16:59:00'),
	(71, 9, 16, NULL, NULL, 43, '2026-04-06', '09:31:00', 'C', 'P', _binary 0x6c6f63616c203a53656372657461726961204d756e69636970616c206465204f627261730d0a536f6c69636974616e7465203a2053616272696e610d0a0d0a434f4e434c5553c3834f203a0d0a0d0a50726f626c656d61207265736f6c7669646f2c20656e64657265c3a76f2049502065737461766120656d20636f6e666c69746f2e, _binary '', 'V', 62, '2026-04-06', '12:38:00', '2026-04-08', '13:10:00'),
	(72, 30, 30, NULL, NULL, 43, '2026-04-06', '09:41:00', 'C', 'P', _binary 0x6c6f63616c203a20476572c3aa6e636961206465205472c3a26e7369746f2e20496e746572727570c3a7c3a36f20646f73207365727669c3a76f7320646520696e7465726e65742e203c4a554e494f523e0d0a0d0a434f4e434c5553c3834f203a0d0a0d0a4361626f73206172726562656e7461646f733b206162657274757261206465206368616d61646f2070617261206120656d707265736120707265737461646f726120646f207365727669c3a76f2e, _binary '', 'V', 64, '2026-04-06', '16:23:00', '2026-04-06', '13:24:00'),
	(73, 30, 30, 8, NULL, 8, '2026-04-06', '13:17:00', 'C', 'P', _binary 0x557375c3a172696f203a20416c657373616e6472610d0a50617472696d6f6e696f3a203131393234350d0a0d0a446573637269c3a7c3a36f20646f2070726f626c656d613a2050632073656d2053697374656d61204f7065726163696f6e616c3b20696e7374616c61c3a7c3a36f20646f2053697374656d61204c696e75784d696e740d0a0d0a434f4e434c5553c3834f203a0d0a0d0a4f627365727661c3a7c3b565733a20436f6d70757461646f722066756e63696f6e616c20656e766961646f207061726120612073656372657461726961, _binary '', 'R', 63, '2026-04-06', '13:18:00', '2026-04-08', '09:53:00'),
	(74, 5, 16, NULL, NULL, 15, '2026-04-06', '15:28:00', 'C', 'P', _binary 0x4e6f6d6520646f20757375c3a172696f203a74686961676f2e73616e746f730d0a4d6f64756c6f7320717565206972c3a120616365737361722028636f6d707261732c206573746f7175652c20636f6e746162696c69646164652c2070726567c3a36f2c20637265646f7265732c2066726f7461732c20707265737461c3a7c3a36f20646520636f6e7461732c2070617472696dc3b46e696f203a0d0a0d0a53697374656d6120646520636f6e746162696c6964616465206520636f6d707261730d0a0d0a0d0a0d0a434f4e434c5553c3834f203a0d0a0d0a557375c3a172696f2064652041636573736f203a74686961676f2e73616e746f730d0a53656e68612064652041636573736f203a206ac3a12074696e68612073656e6861200d0a0d0a557375c3a172696f20646f287329206dc3b364756c6f287329203a2074686961676f2e73616e746f730d0a53656e686120646f287329206dc3b364756c6f287329203a207361626172614032303236, _binary '', 'V', 65, '2026-04-06', '17:28:00', '2026-04-06', '15:28:00'),
	(75, 7, 28, NULL, NULL, 70, '2026-04-06', '16:42:00', 'C', 'P', _binary 0x417061726563656e646f2076c3a172696f7320706f702d757073206e6f206e6176656761646f7220676f6f676c65204368726f6d6520636f6d20696e666f726d61c3a7c3a36f206465202276c3ad727573220d0a0d0a434f4e434c5553c3834f203a0d0a0d0a436f6e636c7573c3a36f203a20466f69207265616c697a616461207661727265647572612064652076c3ad727573206e6f20636f6d70757461646f722c20646573696e7374616c61646f206f20476f6f676c65204368726f6d652065207265696e7374616c61646f2e20466f69207465737461646f2070656c6f20757375c3a172696f2065206e6f726d616c697a61646f2e, _binary '', 'V', 66, '2026-04-06', '14:42:00', '2026-04-06', '16:43:00'),
	(76, 28, 30, NULL, NULL, 43, '2026-04-07', '09:54:00', 'C', 'P', _binary 0x6c6f63616c203a204573636f6c61204d756e69636970616c204f7264c3a16c69610d0a0d0a0d0a434f4e434c5553c3834f203a0d0a0d0a526f6d70696d656e746f20646520666962726120736f6c696369696f6e61646f, _binary '', 'V', 67, '2026-04-07', '12:54:00', '2026-04-07', '11:52:00'),
	(77, 9, 30, NULL, NULL, 43, '2026-04-07', '10:09:00', 'X', 'P', _binary 0x6c6f63616c203a2e2e2e, _binary '', 'V', 69, '2026-04-07', '14:01:00', NULL, NULL),
	(78, 5, 16, NULL, NULL, 15, '2026-04-07', '10:29:00', 'C', 'P', _binary 0x4e6f6d6520646f20757375c3a172696f203a466162696f204a657375697461204d6167616c686165730d0a4350463a3837312e3730352e3832362d30300d0a4d6f64756c6f7320717565206972c3a120616365737361722028636f6d707261732c206573746f7175652c20636f6e746162696c69646164652c2070726567c3a36f2c20637265646f7265732c2066726f7461732c20707265737461c3a7c3a36f20646520636f6e7461732c2070617472696dc3b46e696f203a0d0a0d0a0d0a0d0a434f4e434c5553c3834f203a0d0a0d0a557375c3a172696f2064652041636573736f203a666162696f2e6d6167616c686165730d0a53656e68612064652041636573736f203a73616261726140323032360d0a0d0a557375c3a172696f20646f287329206dc3b364756c6f287329203a20666162696f2e6d6167616c686165730d0a53656e686120646f287329206dc3b364756c6f287329203a7361626172614032303236, _binary '', 'V', 68, '2026-04-07', '12:32:00', '2026-04-07', '10:55:00'),
	(79, 8, 30, NULL, NULL, 23, '2026-04-07', '16:15:00', 'C', 'P', _binary 0x50617472696d6f6e696f3a0d0a4c6f63616c3a2073616c612064652047656f50726f63657373616d656e746f3b206d75646172206f20636f6d70757461646f72206465206c75676172206e61206d65736d612073616c612e0d0a0d0a0d0a434f4e434c5553c3834f203a0d0a0d0a6d7564616ec3a761206566657469766164613b2072656f7267616e697a61c3a7c3a36f206465206361626f733b20, _binary '', 'V', 70, '2026-04-07', '13:15:00', '2026-04-07', '16:16:00'),
	(80, 6, 28, NULL, NULL, 36, '2026-04-08', '08:33:00', 'C', 'P', _binary 0x496e7374616c61c3a7c3a36f20696d70726573736f726120646f20524820706172612066756e63696f6ec3a1726961204272756e6120646f207365746f72206465205365727669c3a76f73204765726169730d0a0d0a434f4e434c5553c3834f203a0d0a0d0a496e7374616c61c3a7c3a36f20636f6e636c75c3ad646120636f6d207375636573736f2e20546573746573206f6b, _binary '', 'V', 71, '2026-04-07', '10:33:00', '2026-04-08', '08:45:00'),
	(81, 5, 16, NULL, NULL, 15, '2026-04-08', '09:29:00', 'C', 'P', _binary 0x4e6f6d6520646f20757375c3a172696f203a54686961676f204665726e616e646f204d617274696e732052616d6f732064652043617276616c686f0d0a6ec3ba6d65726f20646f20435046203a206ec3a36f20696e666f726d61646f0d0a4d6f64756c6f7320717565206972c3a120616365737361722028636f6d707261732c206573746f7175652c20636f6e746162696c69646164652c2070726567c3a36f2c20637265646f7265732c2066726f7461732c20707265737461c3a7c3a36f20646520636f6e7461732c2070617472696dc3b46e696f203a204573746f7175650d0a0d0a0d0a0d0a434f4e434c5553c3834f203a0d0a0d0a557375c3a172696f2064652041636573736f203a4ac3a120706f737375692061636573736f0d0a53656e68612064652041636573736f203a6ac3a120706f737375692061636573730d0a0d0a557375c3a172696f20646f287329206dc3b364756c6f287329203a74686961676f2e72616d6f730d0a53656e686120646f287329206dc3b364756c6f287329203a7361626172614032303236, _binary '', 'V', 74, '2026-04-08', '11:33:00', '2026-04-08', '11:13:00'),
	(82, 11, 16, NULL, NULL, 54, '2026-04-08', '09:31:00', 'C', 'P', _binary 0x4e6f6d6520646f20757375c3a172696f203a506564726f2048656e72697175652046616c6569726f20646520536f757a612050696572690d0a5061737461732064652061636573736f206e612072656465203a4d65696f20616d6269656e74650d0a0d0a434f4e434c5553c3834f203a0d0a0d0a4c6f67696e20646f20557375c3a172696f3a706564726f2e70696572690d0a53656e686120496e696369616c203a7361626172614032303236, _binary '', 'V', 73, '2026-04-08', '10:32:00', '2026-04-08', '09:38:00'),
	(83, 11, 16, NULL, NULL, 62, '2026-04-08', '09:32:00', 'C', 'P', _binary 0x4e6f6d6520646f20557375c3a172696f3a506564726f2048656e72697175652046616c6569726f20646520536f757a612050696572690d0a4350463a3032312e3636332e3539362d39380d0a4c6f63616973206465205472616d697461c3a7c3a36f203a4d65696f20416d6269656e74650d0a0d0a434f4e434c5553c3834f203a0d0a0d0a4c6f67696e20646f20557375c3a172696f203a706564726f2e70696572690d0a53656e68612064652041636573736f203a313233343536, _binary '', 'V', 72, '2026-04-08', '10:02:00', '2026-04-08', '09:42:00'),
	(84, 8, 16, NULL, NULL, 54, '2026-04-08', '11:20:00', 'C', 'P', _binary 0x4e6f6d6520646f20757375c3a172696f203a41647269616e204b61727374657220536f757a612053696c76610d0a5061737461732064652061636573736f206e612072656465203a66617a656e646120652066697363616c697a61c3a7c3a36f0d0a0d0a434f4e434c5553c3834f203a0d0a0d0a4c6f67696e20646f20557375c3a172696f3a61647269616e2e6b61737465720d0a53656e686120496e696369616c203a7361626172614032303236, _binary '', 'V', 75, '2026-04-08', '12:20:00', '2026-04-08', '11:20:00'),
	(85, 12, 16, 11, NULL, 70, '2026-04-08', '15:38:00', 'C', 'P', _binary 0x436f6d70757461646f7220636f6d2074617276616d656e746f2065206c656e746964c3a36f, _binary 0x436f6e636c7573c3a36f203a0d0a417475616c697a61c3a7c3a36f2064652042696f73206520647269766572730d0a4f74696d697a61c3a7c3a36f20646520646573656d70656e686f0d0a4f74696d697a61c3a7c3a36f20646520756e69646164657328633a290d0a4578636c7573c3a36f206465206172717569766f732074656d706f72c3a172696f7320, 'R', 76, '2026-04-13', '15:38:00', '2026-04-15', '14:07:00'),
	(86, 12, 16, 12, NULL, 70, '2026-04-08', '15:41:00', 'C', 'P', _binary 0x436f6d70757461646f7220636f6d2074726176616d656e746f2065204c656e746964c3a36f, _binary 0x436f6e636c7573c3a36f203a0d0a417475616c697a61c3a7c3a36f2064652042696f73206520647269766572730d0a4f74696d697a61c3a7c3a36f20646520646573656d70656e686f0d0a4f74696d697a61c3a7c3a36f20646520756e69646164657328633a290d0a4578636c7573c3a36f206465206172717569766f732074656d706f72c3a172696f7320, 'R', 77, '2026-04-13', '15:41:00', '2026-04-15', '13:53:00'),
	(87, 8, 30, 13, NULL, 23, '2026-04-09', '08:39:00', 'C', 'P', _binary 0x50617472696d6f6e696f3a203131393331310d0a436f6e666967757261c3a7c3a36f20646f2053697374656d61204f7065726163696f6e616c3b20696e7374616c61c3a7c3a36f206465202270726f6772616d61732070616472c3a36f223b2061646963696f6e617220616f20646f6dc3ad6e696f3b20636f6e6669677572617220696d70726573736f72613b200d0a, _binary 0x50726f636564696d656e746f7320666569746f732e, 'R', 80, '2026-04-09', '10:39:00', '2026-04-10', '15:03:00'),
	(88, 8, 16, NULL, NULL, 54, '2026-04-09', '09:06:00', 'C', 'P', _binary 0x4e6f6d6520646f20757375c3a172696f203a204bc3a17469612056696c656c6120526f6368610d0a5061737461732064652061636573736f206e612072656465203a20436f6e746162696c69646164650d0a0d0a434f4e434c5553c3834f203a0d0a0d0a4c6f67696e20646f20557375c3a172696f3a6b617469612e726f6368610d0a53656e686120496e696369616c203a7361626172614032303236, _binary '', 'V', 81, '2026-04-09', '10:06:00', '2026-04-09', '09:38:00'),
	(89, 8, 16, NULL, NULL, 15, '2026-04-09', '09:08:00', 'C', 'P', _binary 0x4e6f6d6520646f20757375c3a172696f203a4bc3a17469612056696c656c6120526f6368610d0a6ec3ba6d65726f20646f20435046203a2030313530353037333634320d0a4d6f64756c6f7320717565206972c3a120616365737361722028636f6d707261732c206573746f7175652c20636f6e746162696c69646164652c2070726567c3a36f2c20637265646f7265732c2066726f7461732c20707265737461c3a7c3a36f20646520636f6e7461732c2070617472696dc3b46e696f203a436f6e746162696c69646164650d0a0d0a0d0a0d0a434f4e434c5553c3834f203a0d0a0d0a557375c3a172696f2064652041636573736f203a6b617469612e726f6368610d0a53656e68612064652041636573736f203a73616261726140323032360d0a0d0a557375c3a172696f20646f287329206dc3b364756c6f287329203a6b617469612e726f6368610d0a53656e686120646f287329206dc3b364756c6f287329203a7361626172614032303236, _binary '', 'V', 82, '2026-04-09', '10:00:00', '2026-04-09', '09:36:00'),
	(90, 5, 16, NULL, NULL, 15, '2026-04-09', '12:04:00', 'C', 'P', _binary 0x4e6f6d6520646f20757375c3a172696f203a56696e69636975732053696c76612042656e746f0d0a6ec3ba6d65726f20646f20435046203a2031323330373830323632320d0a4d6f64756c6f7320717565206972c3a120616365737361722028636f6d707261732c206573746f7175652c20636f6e746162696c69646164652c2070726567c3a36f2c20637265646f7265732c2066726f7461732c20707265737461c3a7c3a36f20646520636f6e7461732c2070617472696dc3b46e696f203a4573746f7175650d0a0d0a0d0a0d0a434f4e434c5553c3834f203a0d0a0d0a557375c3a172696f2076696e69636975732e62656e746f206ac3a12074696e68612061636573736f20616f206dc3b364756c6f206465206573746f7175652070656469646f2e20666f69207265646566696e69646f2073656e68612070617261207361626172614032303236, _binary '', 'V', 83, '2026-04-09', '16:00:00', '2026-04-09', '14:00:00'),
	(91, 5, 16, NULL, NULL, 15, '2026-04-09', '15:19:00', 'C', 'P', _binary 0x4e6f6d653a2052656d6973736f6e20536f6172657320506572656972610d0a4350463a203432352e3435372e3439362d37320d0a434f4e544142494c49444144452065204553544f5155450d0a0d0a0d0a0d0a434f4e434c5553c3834f203a0d0a0d0a557375c3a172696f2072656d6973736f6e2e70657265697261c2a02073656e686120696e696369616c2073616261726140323032360d0a0d0a736f6d656e746520636f6e746162696c69646164652065206573746f717565, _binary '', 'V', 84, '2026-04-09', '17:19:00', '2026-04-09', '16:14:00'),
	(92, 32, 30, 14, NULL, 28, '2026-04-10', '08:17:00', 'C', 'P', _binary 0x506f73737569204c6963656ec3a7612873696d2f6ec3a36f29203f2073696d20284e4d43524d2d36544a37372d43573746512d364a5644472d4656594658290d0a446573637269c3a7c3a36f20646f20736f66747761726520612073657220696e7374616c61646f3a204d6963726f736f6674204f666669636520323032310d0a0d0a434f4e434c5553c3834f203a0d0a0d0a536f66747761726520696e7374616c61646f2065206174697661646f, _binary '', 'R', 85, '2026-04-13', '12:00:00', '2026-04-10', '08:31:00'),
	(93, 7, 30, 15, NULL, 36, '2026-04-10', '09:19:00', 'C', 'P', _binary 0x53454c4220646120496d70726573736f7261203a20544643390d0a0d0a434f4e434c5553c3834f203a0d0a0d0a44726976657220646520496d70726573736f726120696e7374616c61646f206520636f6e666967757261646f2e, _binary '', 'R', 86, '2026-04-10', '11:20:00', '2026-04-10', '09:21:00'),
	(94, 7, 30, 15, NULL, 74, '2026-04-10', '09:41:00', 'C', 'P', _binary 0x496e7374616c61c3a7c3a36f20646f20476f476c6f62616c2065206174616c686f20646f2053555045524e4f56412d4d4f4445524e41206e6f2070632e0d0a0d0a434f4e434c5553c3834f203a0d0a0d0a496e7374616c61c3a7c3a36f206665697461, _binary '', 'R', 87, '2026-04-10', '10:42:00', '2026-04-10', '09:43:00'),
	(95, 6, 30, 16, NULL, 74, '2026-04-10', '11:18:00', 'C', 'P', _binary 0x4c6f67696e207365746f72206465204c6963697461c3a7c3a36f, _binary 0x496e7374616c61c3a7c3a36f206665697461, 'R', 88, '2026-04-10', '11:30:00', '2026-04-10', '11:20:00'),
	(96, 28, 16, NULL, NULL, 54, '2026-04-10', '11:37:00', 'C', 'P', _binary 0x536f6c696369746f2cc2a0706f722067656e74696c657a612c20637269616ec3a7c3a36f206465c2a06c6f67696ec2a0652073656e6861206465c2a061636573736fc2a0287061737461c2a05029c2a070617261205365727669646f72612041647269616e61204cc3ba6369612064612053696c76612c20617373697374656e74652061646d696e69737472617469766f206e61204564756361c3a7c3a36f20285365746f7220646520416c696d656e7461c3a7c3a36f204573636f6c6172292e, _binary 0x4c6f67696e20646f20557375c3a172696f3a61647269616e612e6c756369610d0a53656e686120496e696369616c203a7361626172614032303236, 'V', 89, '2026-04-10', '12:37:00', '2026-04-10', '11:40:00'),
	(97, 11, 16, NULL, NULL, 62, '2026-04-10', '15:25:00', 'C', 'P', _binary 0x4e6f6d6520646f20557375c3a172696f3a416e61204265617472697a20436172646f736f20566173636f6e63656c6f7320646f732053616e746f730d0a4350463a3135392e3933382e3931362d39360d0a4c6f63616973206465205472616d697461c3a7c3a36f203a4d65696f20416d6269656e7465, _binary 0x4c6f67696e20646f20557375c3a172696f203a616e612e766173636f6e63656c6f730d0a53656e68612064652041636573736f203a313233343536, 'V', 90, '2026-04-10', '16:48:00', '2026-04-10', '16:21:00'),
	(98, 6, 16, NULL, NULL, 15, '2026-04-13', '09:03:00', 'C', 'P', _binary 0x4e6f6d6520646f20757375c3a172696f203a476cc3aa6e6961205061756c612050696e746fc2a00d0a6ec3ba6d65726f20646f20435046203a30383032353432313635380d0a4d6f64756c6f7320717565206972c3a120616365737361722028636f6d707261732c206573746f7175652c20636f6e746162696c69646164652c2070726567c3a36f2c20637265646f7265732c2066726f7461732c20707265737461c3a7c3a36f20646520636f6e7461732c2070617472696dc3b46e696f203a0d0a0d0a436f6d707261730d0a4573746f7175650d0a436f6e746162696c69646164650d0a50617472696dc3b46e696f0d0a50726f746f636f6c6f0d0a0d0a, _binary 0x557375c3a172696f2064652041636573736f203a676c656e69612e70696e746f0d0a53656e68612064652041636573736f203a73616261726140323032360d0a0d0a557375c3a172696f20646f287329206dc3b364756c6f287329203a676c656e69612e70696e746f0d0a53656e686120646f287329206dc3b364756c6f287329203a7361626172614032303236, 'V', 91, '2026-04-13', '11:12:00', '2026-04-13', '10:13:00'),
	(99, 9, 30, NULL, NULL, 43, '2026-04-14', '09:07:00', 'C', 'P', _binary 0x6c6f63616c203a2053454d4f42202d2050726f6a65746f732c20706320757361646f2070656c61204761627269656c6c652047616c64696e6f, _binary 0x50726f626c656d6120736f6c7563696f6e61646f, 'V', 93, '2026-04-14', '12:07:00', '2026-05-07', '12:12:00'),
	(100, 11, 16, NULL, NULL, 68, '2026-04-14', '09:19:00', 'C', 'P', _binary 0x4c6f63616c3a4d65696f20416d6269656e74650d0a4ec3ba6d65726f20646520706f6e746f73203a3120706f6e746f206361626f20636f6d2070726f626c656d61, _binary 0x486162696c697461646f206e6f766f20706f6e746f206e612073616c6120646f20536563726574c3a172696f206465204d65696f20416d6269656e7465, 'V', 105, '2026-04-22', '10:07:00', '2026-05-07', '17:24:00'),
	(101, 7, 30, NULL, NULL, 59, '2026-04-14', '09:25:00', 'C', 'P', _binary 0x446573637269c3a7c3a36f20646f205365727669c3a76f3a41636f6d70616e686172204c61696c6120285365637265746172696120646520476f7665726e6f2920656d20766973697461206120616c67756e73207072c3a964696f732070c3ba626c69636f732c206a756e746f20636f6d20612065717569706520646520746f74656e732e, _binary 0x456665747561646f206f2061636f6d70616e68616d656e746f2e2050726f626c656d6173206f627365727661646f7320666f72616d2072657061737361646f73207061726120466cc3a176696f204d6169656c6f2e, 'V', 97, '2026-04-17', '16:41:00', '2026-04-22', '16:33:00'),
	(102, 14, 30, NULL, NULL, 23, '2026-04-14', '09:29:00', 'C', 'P', _binary 0x536f6c6963697461206120696e7374616c61c3a7c3a36f206520636f6e666967757261c3a7c3a36f2064652032207063732c206e612073616c61206465207265756e69c3a36f2064612041646d696e6973747261c3a7c3a36f206520636f6e666967757261c3a7c3a36f20646520696d70726573736f7261732c20706172612061706f696f20616f204a454d472e0d0a, _binary 0x4f732070637320636f6e74696e756172c3a36f2c20706f722074656d706f20696e646566696e69646f2c206e6f206c6f63616c2e, 'V', 94, '2026-04-17', '17:00:00', '2026-04-22', '10:55:00'),
	(103, 8, 30, NULL, NULL, 43, '2026-04-14', '11:03:00', 'C', 'P', _binary 0x6c6f63616c203a20534543524554415249412044452046415a454e444120455354414455414c3a202d436f6c6f636172206f2063616265616d656e746f20646520696e7465726e65743b202d636f6e656374617220696d70726573736f72612e, _binary 0x4d6f6e746167656d2064652030312070633b207265636f6e666967757261c3a7c3a36f20646520495020646120696d70726573736f726120525648313b20636f6e666967757261c3a7c3a36f20646120706f72746120646520696d7072657373c3a36f206e6f7320303320706320646120536563726574617269612064652046617a656e646120457374616475616c2e, 'V', 96, '2026-04-14', '16:10:00', '2026-04-14', '16:37:00'),
	(104, 34, 30, NULL, NULL, 46, '2026-04-14', '11:14:00', 'X', 'P', _binary 0x4c6f63616c203a2050524f434f4e0d0a4ec3ba6d65726f20646520706f6e746f733a2030320d0a0d0a536f6c69636974612076697374612074c3a9636e6963612061207365646520646f2050524f434f4e20285275613a20446f6d20506564726f2049492c204ec2b02037322c2043656e74726f292c2070617261207175652073656a6120696e7374616c61646f206361626f20646520696e7465726e657420656d20646f697320636f6d70757461646f72657320726563656e74656d656e74652061647175697269646f732070656c6f20c3b37267c3a36f3b20736572c3a1207072656369736f20657374656e646572206f206361626f20646520696e7465726e657420646f732074656c65666f6e65732e20200d0a0d0a4c61726973736120566965697261202d205465636e696361206465206174656e64696d656e746f, NULL, 'V', 104, '2026-04-18', '09:33:00', NULL, NULL),
	(105, 14, 30, NULL, NULL, 69, '2026-04-14', '11:24:00', 'C', 'P', _binary 0x41636f6d70616e68617220706573736f616c2064612053706565644e6574206e6f2043616d706f206461204c696761, _binary 0x4c696e6b20617469766f206e6f206c6f63616c, 'V', 95, '2026-04-14', '11:24:00', '2026-04-16', '09:29:00'),
	(106, 31, 16, NULL, NULL, 10, '2026-04-15', '15:13:00', 'C', 'P', _binary 0x446573637269c3a7c3a36f20646f20652d6d61696c202865782e203c64657363726963616f3e407361626172612e6d672e676f762e62723a72656c61746f72696f73407361626172612e6d672e676f762e62720d0a526573706f6e73c3a176656c203a4974656c76696e61, _binary 0x446573637269c3a7c3a36f20646f20652d6d61696c3a72656c61746f72696f73407361626172612e6d672e676f762e62720d0a53656e686120696e696369616f203a7361626172614032303236, 'V', 98, '2026-04-15', '16:00:00', '2026-04-15', '15:14:00'),
	(107, 7, 16, NULL, NULL, 54, '2026-04-15', '15:16:00', 'C', 'P', _binary 0x4e6f6d6520646f20757375c3a172696f203a204d6972656c6c79204775696d6172c3a3657320506572656972610d0a5061737461732064652061636573736f206e612072656465203a706c616e656a616d656e746f, _binary 0x4c6f67696e20646f20557375c3a172696f3a206d6972656c6c792e706572656972610d0a53656e686120496e696369616c203a7361626172614032303236, 'V', 99, '2026-04-15', '16:18:00', '2026-04-15', '15:18:00'),
	(108, 7, 30, NULL, NULL, 60, '2026-04-15', '17:35:00', 'C', 'P', _binary 0x4c6f63616c203a2073616c61206465207265756e69c3b5657320646f20476162696e6574650d0a526573706f6e73c3a176656c3a204361737369726c656e65205669656972610d0a0d0a4520736f6c696369746172207375706f7274652074c3a9636e69636f207061726120636f6e6578c3a36f20766961206e6f7465626f6f6b2c20706172612061636573736f206520706172746963697061c3a7c3a36f20656d207265756e69c3a36f207669727475616c20646f20436f6e73656c686f204d756e69636970616c20646520486162697461c3a7c3a36f20646520496e7465726573736520536f6369616c202d20434d484953206520646f20477275706f20496e737469747563696f6e616c20646f20506f6465722050c3ba626c69636f202d20474950502e, _binary 0x4d6f6e746167656d207265616c697a6164613b20746573746573207265616c697a61646f733b207265756e69c3a36f20696e6963696f752d736520c3a073203134682e, 'V', 100, '2026-04-15', '17:00:00', '2026-04-15', '17:37:00'),
	(109, 31, 28, NULL, NULL, 41, '2026-04-16', '08:37:00', 'C', 'P', _binary 0x536520666f7220696d70726573736f726120636f6c6f72696461207175616c206120636f7220746f20746f6e6572203f3a20417a756c206520416d6172656c6f0d0a, _binary 0x5265616c697a6164612074726f636120646f7320746f6e6e6572732c20746573746573206f6b, 'V', 101, '2026-04-16', '09:37:00', '2026-04-16', '08:38:00'),
	(110, 8, 28, NULL, NULL, 23, '2026-04-16', '08:39:00', 'C', 'P', _binary 0x496e7374616c61c3a7c3a36f206465206dc3b364756c6f2064612043616978610d0a, _binary 0x4dc3b364756c6f206461204361697861206ec3a36f2066756e63696f6e6f75206e6f206e6176656761646f7220676f6f676c65204368726f6d652c20696e7374616c61646f206e6f206e6176656761646f722046697265666f782e20546573746573206f6b, 'V', 102, '2026-04-16', '10:39:00', '2026-04-16', '08:40:00'),
	(111, 28, 16, NULL, NULL, 15, '2026-04-16', '09:10:00', 'C', 'P', _binary 0x4e6f6d6520646f20757375c3a172696f203a41647269616e61204cc3ba6369612064612053696c76610d0a6ec3ba6d65726f20646f20435046203a3036382e3133322e3239362d39390d0a4d6f64756c6f7320717565206972c3a120616365737361722028636f6d707261732c206573746f7175652c20636f6e746162696c69646164652c2070726567c3a36f2c20637265646f7265732c2066726f7461732c20707265737461c3a7c3a36f20646520636f6e7461732c2070617472696dc3b46e696f203a0d0a0d0a, _binary 0x557375c3a172696f2064652041636573736f203a61647269616e612e6c756369610d0a53656e68612064652041636573736f203a2073616261726140323032360d0a0d0a557375c3a172696f20646f287329206dc3b364756c6f287329203a2061647269616e612e6c756369610d0a53656e686120646f287329206dc3b364756c6f287329203a207361626172614032303236, 'V', 103, '2026-04-16', '11:10:00', '2026-04-16', '09:10:00'),
	(112, 30, 16, NULL, NULL, 51, '2026-04-16', '10:56:00', 'C', 'P', _binary 0x4c6f63616c203a5072c3a964696f2064612053656372657461726961206465205365677572616ec3a7612070c3ba626c6963610d0a0d0a53696e616c206461204f70657261646f726120206f6b206d6173206ec3a36f207265706c6963612070617261206f20706f6e746f732064652061636573736f2e205665726966696361722070726f626c656d617320696e7465726e6f73206e6f73206571756970616d656e746f73, _binary 0x50726f626c656d6120656cc3a9747269636f207265736f6c7669646f2070656c6f207365746f72206465206f627261732e, 'V', 106, '2026-04-16', '17:00:00', '2026-05-07', '12:08:00'),
	(113, 30, 16, NULL, NULL, 10, '2026-04-16', '11:48:00', 'C', 'P', _binary 0x446573637269c3a7c3a36f20646f20652d6d61696c202865782e203c64657363726963616f3e407361626172612e6d672e676f762e62723a0d0a0d0a636f6d756e69636163616f67636d736162617261407361626172612e6d672e676f762e62720d0a706c616e656a616d656e746f6f7065726163696f6e616c67636d736162617261407361626172612e6d672e676f762e62720d0a66697363616c697a6163616f64656f62726173407361626172612e6d672e676f762e62720d0a736563616f74696c6f6769737469636165706573736f616c67636d407361626172612e6d672e676f762e62720d0a636f7272656765646f72696167636d407361626172612e6d672e676f762e62720d0a0d0a526573706f6e73c3a176656c203a476c69736961, _binary 0x446573637269c3a7c3a36f20646f20652d6d61696c3a0d0a0d0a636f6d756e69636163616f67636d736162617261407361626172612e6d672e676f762e62720d0a706c616e656a616d656e746f6f7065726163696f6e616c67636d736162617261407361626172612e6d672e676f762e62720d0a66697363616c697a6163616f64656f62726173407361626172612e6d672e676f762e62720d0a736563616f74696c6f6769737469636165706573736f616c67636d407361626172612e6d672e676f762e62720d0a636f7272656765646f72696167636d407361626172612e6d672e676f762e62720d0a53656e686120696e696369616c203a207361626172614032303236, 'V', 107, '2026-04-16', '13:49:00', '2026-04-16', '11:49:00'),
	(114, 30, 16, NULL, NULL, 63, '2026-04-16', '11:51:00', 'A', 'P', _binary 0x4c6f63616c3a50617472756c686120477561726469c3a3206461204d756c6865720d0a5265666572c3aa6e6369613a7072c3b378696d6f206120677561726461204d756e69636970616c0d0a436f6e7461746f3a476c69736961, NULL, 'V', NULL, NULL, NULL, NULL, NULL),
	(115, 11, 16, NULL, NULL, 54, '2026-04-17', '15:26:00', 'C', 'P', _binary 0x4e6f6d6520646f20757375c3a172696f203a204c75636173204d61746f7320646f732053616e746f73204c696d610d0a5061737461732064652061636573736f206e612072656465203a4d65696f20416d6269656e7465, _binary 0x4c6f67696e20646f20557375c3a172696f3a6c756361732e6c696d610d0a53656e686120496e696369616c203a7361626172614032303236, 'V', 108, '2026-04-17', '16:26:00', '2026-04-17', '15:26:00'),
	(116, 11, 16, NULL, NULL, 62, '2026-04-17', '15:28:00', 'C', 'P', _binary 0x4e6f6d6520646f20557375c3a172696f3a204c75636173204d61746f7320646f732053616e746f73204c696d610d0a4350463a206ec3a36f20696e666f726d61646f0d0a4c6f63616973206465205472616d697461c3a7c3a36f203a4d65696f20416d6269656e7465, _binary 0x4c6f67696e20646f20557375c3a172696f203a6c756361732e6c696d610d0a53656e68612064652041636573736f203a313233343536, 'V', 109, '2026-04-17', '15:58:00', '2026-04-17', '15:28:00'),
	(117, 7, 16, NULL, NULL, 43, '2026-04-22', '11:12:00', 'C', 'P', _binary 0x6c6f63616c203a436f6d70757461646f72206461204d6172696120436c61726120646f20706c616e656a616d656e746f2073656d20696e7465726e6574, _binary 0x466f6920616c746572616461206120706f727461206e6f207261636b2063656e7472616c2e20546573746573207265616c697a61646f73206f6b, 'V', 110, '2026-04-22', '14:13:00', '2026-04-22', '11:44:00'),
	(118, 6, 16, NULL, NULL, 54, '2026-04-22', '11:38:00', 'C', 'P', _binary 0x4e6f6d6520646f20757375c3a172696f203a4a65616e204361726c6f73204d61636172696f20526f7175650d0a5061737461732064652061636573736f206e612072656465203a41646d696e6973747261c3a7c3a36f2065207472616e73706f727465, _binary 0x4c6f67696e20646f20557375c3a172696f3a206a65616e2e726f7175650d0a53656e686120496e696369616c203a207361626172614032303236, 'V', 111, '2026-04-22', '12:38:00', '2026-04-22', '11:38:00'),
	(119, 6, 16, NULL, NULL, 15, '2026-04-22', '11:40:00', 'C', 'P', _binary 0x4e6f6d6520646f20757375c3a172696f203a4a65616e204361726c6f73204d61636172696f20526f7175650d0a6ec3ba6d65726f20646f20435046203a203132382e3430392e3536362d35390d0a4d6f64756c6f7320717565206972c3a120616365737361722028636f6d707261732c206573746f7175652c20636f6e746162696c69646164652c2070726567c3a36f2c20637265646f7265732c2066726f7461732c20707265737461c3a7c3a36f20646520636f6e7461732c2070617472696dc3b46e696f203a436f6d707261730d0a0d0a, _binary 0x557375c3a172696f2064652041636573736f203a206a65616e2e726f7175650d0a53656e68612064652041636573736f203a73616261726140323032360d0a0d0a557375c3a172696f20646f287329206dc3b364756c6f287329203a6a65616e2e726f7175650d0a53656e686120646f287329206dc3b364756c6f287329203a7361626172614032303236, 'V', 112, '2026-04-22', '13:41:00', '2026-04-22', '11:41:00'),
	(120, 6, 16, NULL, NULL, 62, '2026-04-22', '11:44:00', 'C', 'P', _binary 0x4e6f6d6520646f20557375c3a172696f3a204a65616e204361726c6f73204d61636172696f20526f7175650d0a4350463a3132382e3430392e3536362d35390d0a4c6f63616973206465205472616d697461c3a7c3a36f203a5472616e73706f727465, _binary 0x4c6f67696e20646f20557375c3a172696f203a6a65616e2e726f7175650d0a53656e68612064652041636573736f203a313233343536, 'V', 113, '2026-04-22', '12:14:00', '2026-04-22', '11:44:00'),
	(121, 11, 30, 17, NULL, 24, '2026-04-23', '11:08:00', 'C', 'P', _binary 0x50617472696dc3b46e696f203a2039373335340d0a0d0a46616c686120646520636f6e6669616ec3a7612028646f6dc3ad6e696f29, _binary 0x61646420616f20646f6dc3ad6e696f, 'R', 114, '2026-04-24', '11:08:00', '2026-04-23', '11:18:00'),
	(122, 14, 30, NULL, NULL, 59, '2026-04-23', '11:20:00', 'C', 'P', _binary 0x446573637269c3a7c3a36f20646f205365727669c3a76f3a2041636f6d70616e68616d656e746f206e61206d7564616ec3a761206465206c6f63616c2066c3ad7369636f20646f73206465736b746f70, _binary 0x41636f6d70616e68616d656e746f20656665747561646f20636f6d207375636573736f, 'V', 115, '2026-04-23', '17:00:00', '2026-04-24', '09:07:00'),
	(123, 7, 30, NULL, NULL, 59, '2026-04-23', '11:37:00', 'C', 'P', _binary 0x446573637269c3a7c3a36f20646f205365727669c3a76f3a2041636f6d70616e68616d656e746f206e61206d7564616ec3a761206465206c6f63616c2066c3ad7369636f20646f73206465736b746f702c207365746f72206465204172717569746574757261, _binary 0x41636f6d70616e68616d656e746f207265616c697a61646f20636f6d207375636573736f, 'V', 116, '2026-04-23', '19:37:00', '2026-04-24', '09:09:00'),
	(124, 8, 30, NULL, NULL, 59, '2026-04-23', '11:39:00', 'C', 'P', _binary 0x446573637269c3a7c3a36f20646f205365727669c3a76f3a2041636f6d70616e68616d656e746f206e61206d7564616ec3a761206465206c6f63616c2066c3ad7369636f20646f73206465736b746f7020287365746f722064652046697363616c697a61c3a7c3a36f29, _binary 0x41636f6d70616d656e746f207265616c697a61646f20636f6d207375636573736f, 'V', 117, '2026-04-23', '17:00:00', '2026-04-24', '09:09:00'),
	(125, 9, 30, NULL, NULL, 35, '2026-04-23', '11:42:00', 'C', 'P', _binary 0x53454c4220646120696d70726573736f72613a20436f6e666967757261c3a7c3a36f206465207363616e6e65722c206e6120526567696f6e616c2043656e74726f, _binary 0x5365727669c3a76f207265616c697a61646f20636f6d207375636573736f, 'V', 118, '2026-04-26', '11:42:00', '2026-04-28', '14:46:00'),
	(126, 8, 28, NULL, NULL, 75, '2026-04-23', '14:28:00', 'C', 'P', _binary 0x4e6f766f206d6f6e69746f72207061726120436f6e746162696c6964616465, _binary 0x496e7374616c61c3a7c3a36f207265616c697a61646120636f6d207375636573736f2c20746573746573206f6b, 'V', 119, '2026-04-23', '15:29:00', '2026-04-23', '14:29:00'),
	(127, 9, 16, NULL, NULL, 76, '2026-04-24', '09:15:00', 'C', 'P', _binary 0x4c6f63616c206120736572207574696c697a61646f203a2053656372657461726961206465204f627261732028416c6578616e647261290d0a54616d616e686f20656d204d6574726f203a2034206d6574726f7320, _binary 0x4361626f2064652052656465204c6962657261646f, 'V', 120, '2026-04-24', '12:15:00', '2026-04-24', '15:00:00'),
	(128, 7, 16, NULL, NULL, 68, '2026-04-24', '09:20:00', 'C', 'P', _binary 0x4c6f63616c3a506f6e746f206461206dc3a17175696e61206465204d6172696120436c617261206e6f20706c616e656a616d656e746f0d0a4ec3ba6d65726f20646520706f6e746f73203a31, _binary 0x4d616e7574656ec3a7c3a36f20646f20706f6e746f2064652072656465207265616c697a61646120636f6d207375636573736f, 'V', 121, '2026-04-24', '11:50:00', '2026-04-24', '15:02:00'),
	(129, 32, 28, NULL, NULL, 48, '2026-04-24', '15:59:00', 'C', 'P', _binary 0x4c6f63616c3a2053616c6120646f20436f6e74726f6c61646f720d0a4ec3ba6d65726f20646520706f6e746f733a2032, _binary 0x466f72616d20696e7374616c61646f7320646f6973206361626f73202873656e646f203120646520726573657276612920436174203565206465206170726f78696d6164616d656e74652035206d6574726f73206e61206e6f76612073616c6120646f20436f6e74726f6c61646f7220476572616c2e20546573746573206f6b2e, 'V', 122, '2026-04-25', '15:59:00', '2026-04-24', '16:04:00'),
	(130, 11, 16, 18, NULL, 19, '2026-04-27', '10:27:00', 'C', 'P', _binary 0x50617472696dc3b56e696f20646f20436f6d70757461646f72203a20696e666f726d61646f206e6f20636164617374726f0d0a557375c3a172696f3a44696f676f204e756e65730d0a0d0a436f6d70757461646f7220636f6d206c656e746964c3a36f206e6563657373c3a172696f20666f726d617461c3a7c3a36f, _binary 0x417475616c697a61646f2062696f732c206465667261672064652048642065206c696d70657361206465206172717569766f730d0a0d0a4d617175696e61206c6962657261646120636f6d20626f612066756e63696f6e616c6964616465, 'R', 123, '2026-04-30', '10:27:00', '2026-04-30', '16:53:00'),
	(131, 8, 16, NULL, NULL, 77, '2026-04-27', '12:07:00', 'C', 'P', _binary 0x4c6f63616c3a436f6e746162696c69646164650d0a557375c3a172696f3a4d6172696120476f756c617274, _binary 0x41706c6963617469766f20696e7374616c61646f20636f6d207375636573736f, 'V', 124, '2026-04-27', '14:37:00', '2026-04-27', '14:07:00'),
	(132, 30, 16, 19, NULL, 70, '2026-04-27', '15:58:00', 'C', 'P', _binary 0x496e7374616c61c3a7c3a36f206520436f6e666967757261c3a7c3a36f2064652073697374656d61206f7065726163696f6e616c204c696e7578, _binary 0x436f6e636c7573c3a36f203a2053697374656d61204f7065726163696f6e616c20696e7374616c61646f2c20617475616c697a61646f206520636f6e666967757261646f3b202270726f6772616d61732070616472c3a36f2220696e7374616c61646f733b2061646963696f6e61646f20616f20646f6dc3ad6e696f20504d533b2061646963696f6e61646f20757375c3a172696f2061646d696e6973747261646f722e, 'R', 125, '2026-04-30', '15:58:00', '2026-04-28', '16:44:00'),
	(133, 7, 28, NULL, NULL, 36, '2026-04-27', '16:17:00', 'C', 'P', _binary 0x696e7374616c61c3a7c3a36f20646520696d70726573736f726120646f2052482070617261207365746f722064652066697363616c697a61c3a7c3a36f, _binary 0x496d70726573736f726120696e7374616c6164612070617261207365727669646f726120456c656d2e20746573746573206f6b21, 'V', 126, '2026-04-27', '18:17:00', '2026-04-27', '16:17:00'),
	(134, 8, 16, NULL, NULL, 54, '2026-04-27', '16:20:00', 'C', 'P', _binary 0x4e6f6d6520646f20757375c3a172696f203a204d61726961204c75697a6120466572726569726120526f64726967756573205861766965720d0a5061737461732064652061636573736f206e612072656465203a6661436164617374726f, _binary 0x4c6f67696e20646f20557375c3a172696f3a6d617269612e7861766965720d0a53656e686120496e696369616c203a7361626172614032303236, 'V', 127, '2026-04-27', '17:20:00', '2026-04-27', '16:20:00'),
	(135, 28, 16, NULL, NULL, 15, '2026-04-28', '09:53:00', 'C', 'P', _binary 0x4e6f6d6520646f20757375c3a172696f203a4d617269616e612056697267696e696120546f6d617a206465204d616365646f0d0a6ec3ba6d65726f20646f20435046203a203037342e3933302e3530362d31390d0a4d6f64756c6f7320717565206972c3a120616365737361722028636f6d707261732c206573746f7175652c20636f6e746162696c69646164652c2070726567c3a36f2c20637265646f7265732c2066726f7461732c20707265737461c3a7c3a36f20646520636f6e7461732c2070617472696dc3b46e696f203a4573746f7175650d0a0d0a, _binary 0x557375c3a172696f2064652041636573736f203a4ac3a120706f737375690d0a53656e68612064652041636573736f203a4ac3a120706f737375690d0a0d0a557375c3a172696f20646f287329206dc3b364756c6f287329203a206d617269616e612e746f6d617a0d0a53656e686120646f287329206dc3b364756c6f287329203a7361626172614032303236, 'V', 128, '2026-04-28', '11:54:00', '2026-04-28', '09:54:00'),
	(137, 7, 16, NULL, NULL, 52, '2026-04-28', '11:37:00', 'C', 'P', _binary 0x446573637269c3a7c3a36f20646f20736f667477617265203a6f66666963650d0a506f73737569206c6963656ec3a7613f202873696d2f4ec3a36f29203a2053696d, _binary 0x526570617261c3a7c3a36f20666569746120636f6d207375636573736f2e20417475616c697a61c3a7c3a36f2020646f206f666669636520333635, 'V', 129, '2026-04-28', '13:38:00', '2026-04-28', '14:45:00'),
	(138, 10, 16, NULL, NULL, 64, '2026-04-29', '09:05:00', 'A', 'P', _binary 0x4c6f63616c3a4164766f6361636961204d756e69636970616c0d0a5265666572c3aa6e6369613a5365746f72206465204164766f6361636961204d756e69636970616c0d0a436f6e7461746f3a49736162656c20426f6d74656d706f, NULL, 'V', NULL, NULL, NULL, NULL, NULL),
	(139, 8, 16, NULL, NULL, 28, '2026-04-29', '10:02:00', 'X', 'P', _binary 0x506f73737569204c6963656ec3a7612873696d2f6ec3a36f29203f2073696d0d0a446573637269c3a7c3a36f20646f20736f66747761726520612073657220696e7374616c61646f3a20676572656e636961646f72206465207365677572616ec3a76120646f2042616e636f20646f2042726173696c, NULL, 'V', 130, '2026-04-29', '12:02:00', NULL, NULL),
	(140, 7, 16, NULL, NULL, 48, '2026-04-29', '11:22:00', 'C', 'P', _binary 0x4c6f63616c3a70726f636f6e0d0a4ec3ba6d65726f20646520706f6e746f73203a203320706f6e746f732064652072656465, _binary 0x32206e6f766f7320706f6e746f7320617469766f730d0a496d70726573736f7261206174697661206e6120726564650d0a3320706373206c696e757820636f6e666967757261646f730d0a706f6e746f732072656174697661646f73206e6f20706174636870616e656c, 'V', 131, '2026-04-29', '11:23:00', '2026-04-30', '16:51:00'),
	(141, 31, 28, NULL, NULL, 43, '2026-04-30', '13:50:00', 'C', 'P', _binary 0x6c6f63616c203a20476162696e65746520646f20507265666569746f2c204c65616e64726f2c20636f6d70757461646f72206170726573656e7461206c656e746964c3a36f20706172612061636573736172207369746573, _binary 0x5465737465732064652070696e67206573746176616d206f6b2065207265616c6d656e746520706172616c69736f75206f207365727669c3a76f20646520696e7465726e657420656d2076c3a172696f73206e6176656761646f7265732c206170c3b373207265696ec3ad63696f20646f20636f6d70757461646f72207265616c697a61646f20746573746573206520636f6e6669726d61646f2070656c6f20757375c3a172696f2071756520657374617661206f6b, 'V', 133, '2026-04-30', '16:51:00', '2026-04-30', '13:51:00'),
	(142, 10, 16, NULL, NULL, 41, '2026-04-30', '14:34:00', 'C', 'P', _binary 0x435241532043617374616e686569726173, _binary 0x526573706f6e73c3a176656c2070656c6f207472616e73706f7274653a536563726574c3a172696120646f20436172732043617374616e68656972612028506174726963696129, 'V', 134, '2026-04-30', '15:04:00', '2026-04-30', '14:35:00'),
	(143, 8, 30, 20, NULL, 19, '2026-05-04', '15:12:00', 'C', 'P', _binary 0x50617472696dc3b56e696f20646f20436f6d70757461646f72203a2038333333320d0a557375c3a172696f3a206c756369616e652e6669726d6f0d0a0d0a5043206170726573656e7461206c656e746964c3a36f3b207265616c697a6172206c696d70657a613b207265616c697a617220617475616c697a61c3a7c3a36f20646520647269766572732e, _binary 0x4c696d70657a6173206520617475616c697a61c3a7c3b56573207265616c697a616461732e200d0a28436f6e73696465726f206f20636f6d70757461646f72202266696e616c206465206d6569612d7669646122292e, 'R', 135, '2026-05-06', '15:13:00', '2026-05-04', '16:49:00'),
	(144, 6, 16, NULL, NULL, 54, '2026-05-05', '09:35:00', 'C', 'P', _binary 0x4e6f6d6520646f20757375c3a172696f203a4672616e6b6c696e2e68696c6172696f0d0a5061737461732064652061636573736f206e612072656465203a2061646d696e6973747261c3a7c3a36f, _binary 0x4c6f67696e20646f20557375c3a172696f3a4672616e6b6c696e2e68696c6172696f0d0a53656e686120496e696369616c203a205361626172614032303236, 'V', 136, '2026-05-05', '10:36:00', '2026-05-05', '09:36:00'),
	(145, 8, 16, 20, NULL, 22, '2026-05-05', '10:37:00', 'C', 'P', _binary 0x50617472696dc3b46e696f203a38333333320d0a, _binary 0x417475616c697a61c3a7c3a36f20646520647269766572733b20, 'R', 137, '2026-05-07', '10:37:00', '2026-05-08', '09:34:00'),
	(146, 5, 16, NULL, NULL, 9, '2026-05-05', '11:37:00', 'C', 'P', _binary 0x557375c3a172696f203a204f727465700d0a41746976696461646520612073657220657865637574616461203a436f6d70757461646f7220706172612073697374656d61206461204f727465702064652072656cc3b367696f20646520706f6e746f2064612073656372657461726961206465205361c3ba646520, _binary 0x466f6920646973706f6e6962696c697a61646f205365727669646f72205669727475616c207061726120696e7374616c61c3a7c3a36f20646f20736f667477617265, 'V', 138, '2026-05-08', '11:39:00', '2026-05-08', '11:35:00'),
	(147, 29, 16, NULL, NULL, 78, '2026-05-05', '14:37:00', 'E', 'P', _binary 0x526573706f6e73c3a176656c3a4c75646d696c6120646f732053616e746f73204d617274696e730d0a44617461206520686f72613a2032312f30352f323032362c20c3a0732031306830300d0a4d6f7469766f3a7265756e69c3a36f20636f6d20726570726573656e74616e7465732064612056616c6520652044656665736120436976696c2064652053616e7461204c757a69610d0a4c6f63616c3a536f6c617220506164726520636f7272656961, NULL, 'V', 139, '2026-05-22', '14:38:00', NULL, NULL),
	(148, 28, 16, NULL, NULL, 41, '2026-05-05', '14:47:00', 'C', 'P', _binary 0x536520666f7220696d70726573736f726120636f6c6f726964612c207175616c206120636f7220746f20746f6e6572203f3a0d0a53454c4220646120496d70726573736f7261203a437265636865, _binary 0x526573706f6e73c3a176656c2070656c6f207472616e73706f7274653a4d6f746f726973746120646120437265636865, 'V', 140, '2026-05-05', '15:17:00', '2026-05-05', '14:48:00'),
	(149, 10, 16, NULL, NULL, 41, '2026-05-05', '16:48:00', 'C', 'P', _binary 0x536520666f7220696d70726573736f726120636f6c6f726964612c207175616c206120636f7220746f20746f6e6572203f3a0d0a53454c4220646120496d70726573736f7261203a436f6e73656c686f20547574656c6172, _binary 0x526573706f6e73c3a176656c2070656c6f207472616e73706f7274653a436f6e73656c686f20547574656c6172, 'V', 141, '2026-05-05', '17:18:00', '2026-05-05', '16:49:00'),
	(150, 28, 16, NULL, NULL, 41, '2026-05-07', '08:59:00', 'C', 'P', _binary 0x536520666f7220696d70726573736f726120636f6c6f726964612c207175616c206120636f7220746f20746f6e6572203f3a0d0a53454c4220646120496d70726573736f7261203a436569204e616e637920426f72676573, _binary 0x526573706f6e73c3a176656c2070656c6f207472616e73706f7274653a41647269616e61, 'V', 142, '2026-05-07', '09:29:00', '2026-05-07', '09:00:00'),
	(151, 7, 16, NULL, NULL, 26, '2026-05-07', '11:16:00', 'C', 'P', _binary 0x50617472696dc3b46e696f203a6ec3a36f20696e666f726d610d0a436865636f75206361626f7320646520656e65726769612065206461646f73202873696d2f6ec3a36f29203a2053696d, _binary 0x417475616c697a61c3a7c3a36f20646520647269766572733b2074726f6361206465206361626f205647412e, 'V', 143, '2026-05-09', '11:17:00', '2026-05-08', '09:35:00'),
	(152, 6, 16, NULL, NULL, 15, '2026-05-07', '11:20:00', 'C', 'P', _binary 0x4e6f6d6520646f20757375c3a172696f203a4a756c69616e612053616e746f73206465204d6f72616973c2a00d0a6ec3ba6d65726f20646f20435046203a31303532353736383639360d0a4d6f64756c6f7320717565206972c3a120616365737361722028636f6d707261732c206573746f7175652c20636f6e746162696c69646164652c2070726567c3a36f2c20637265646f7265732c2066726f7461732c20707265737461c3a7c3a36f20646520636f6e7461732c2070617472696dc3b46e696f203a0d0a61636573736f206e6f2050617472696dc3b46e696f202d20436f6e746162696c69646164652065204573746f7175650d0a0d0a, _binary 0x557375c3a172696f2064652041636573736f203a6a756c69616e612e73616e746f730d0a53656e68612064652041636573736f203a73616261726140323032360d0a0d0a557375c3a172696f20646f287329206dc3b364756c6f287329203a6a756c69616e612e73616e746f730d0a53656e686120646f287329206dc3b364756c6f287329203a7361626172614032303236, 'V', 144, '2026-05-07', '13:20:00', '2026-05-07', '11:44:00'),
	(153, 28, 16, NULL, NULL, 41, '2026-05-07', '13:56:00', 'C', 'P', _binary 0x536520666f7220696d70726573736f726120636f6c6f726964612c207175616c206120636f7220746f20746f6e6572203f3a0d0a53454c4220646120496d70726573736f7261203a63726563686520506572646967c3a36f20646520526fc3a761204772616e6465, _binary 0x526573706f6e73c3a176656c2070656c6f207472616e73706f7274653a526573706f6e73c3a176656c20646120437265636865, 'V', 145, '2026-05-07', '14:26:00', '2026-05-07', '13:57:00'),
	(154, 7, 28, NULL, NULL, 23, '2026-05-07', '15:16:00', 'C', 'P', _binary 0x50617472696d6f6e696f3a0d0a496e7374616c61c3a7c3a36f20646f20736f667477617265205147495320656d2064756173206dc3a17175696e617320646f207365746f722064652047656f2e, _binary 0x466f6920696e7374616c61646120656d2064756173206dc3a17175696e617320646f207365746f722064652047656f206f20736f66747761726520677261747569746f20514749532e2050617261206c65697475726120652063726961c3a7c3a36f206465206d6170617320656d20666f726d61746f2053484150452065204a534f4e2062656d20636f6d6f206c65722061732063616d6164617320637269616461732070656c6120656d707265736120546f706f63617274, 'V', 146, '2026-05-07', '17:16:00', '2026-05-07', '15:17:00'),
	(155, 7, 30, NULL, NULL, 25, '2026-05-07', '17:16:00', 'C', 'P', _binary 0x50617472696dc3b46e696f203a0d0a636865636f75206361626f7320646520656e6572676961202873696d2f6ec3a36f293f2073696d0d0a4d6f6e69746f722032206ec3a36f206170726573656e746120766964656f, _binary 0x466f72616d2074726f6361646f73206f73206361626f7320646520766964656f20285647412f48444d49293b20666f6920666569746120617475616c697a61c3a7c3a36f20646f7320647269766573206461206d617175696e613b207265696e696369616c697a61c3a7c3a36f2e, 'V', 147, '2026-05-07', '13:00:00', '2026-05-07', '17:18:00'),
	(156, 7, 30, 15, NULL, 52, '2026-05-07', '17:21:00', 'C', 'P', _binary 0x446573637269c3a7c3a36f20646f20736f667477617265203a0d0a506f73737569206c6963656ec3a7613f202873696d2f4ec3a36f29203a2053696d0d0a4f66666963652050726f66657373696f6e616c20506c75732032303136206ec3a36f206573746176612066756e63696f6e616e646f2e, _binary 0x5061636f7465204f6666696365203230313620646573696e7374616c61646f3b207265696e7374616c6c20646f207061636f7465204f666669636520323031363b20696e736572c3a7c3a36f20646f2073657269616c3b20, 'R', 148, '2026-05-07', '12:40:00', '2026-05-07', '17:27:00'),
	(157, 18, 16, NULL, NULL, 38, '2026-05-11', '10:22:00', 'C', 'P', _binary 0x53454c4220646120496d70726573736f7261203a526567696f6e616c20416e61204c756369610d0a496d70726573736f7261206170726573656e74616e646f206d656e736167656d206f6666206c696e65, _binary 0x466f69207265636f6e666967757261646f206120696d70726573736f7261206520696e7374616c61646f2064726976657273206e6f766f73206e6f7320636f6d70757461646f72657320636f6d206e6f766f2069702065203320636f6d70757461646f72657320646f207365746f72, 'V', 149, '2026-05-11', '17:00:00', '2026-05-11', '14:12:00'),
	(158, 10, 16, NULL, NULL, 41, '2026-05-11', '11:54:00', 'C', 'P', _binary 0x536520666f7220696d70726573736f726120636f6c6f726964612c207175616c206120636f7220746f20746f6e6572203f3a507265746f0d0a53454c4220646120496d70726573736f7261203a494d343330, _binary 0x526573706f6e73c3a176656c2070656c6f207472616e73706f7274653a4a6f6e617468656e2046656c6978, 'V', 150, '2026-05-11', '12:24:00', '2026-05-11', '11:55:00'),
	(159, 29, 16, NULL, NULL, 54, '2026-05-11', '14:17:00', 'E', 'P', _binary 0x5061726120696e736572c3a7c3a36f20646f73207365727669646f726573206e6120726564652064612044656665736120436976696c2c2073656775656d206f73206c6f67696e7320646f7320757375c3a172696f733a0d0a6c75646d696c612e6d617274696e730d0a76697669616e652e6170617265636964610d0a6665726e616e64612e7669746f7269610d0a646f75676c61732e6d617274696e730d0a6775696c6865726d652e6d656e6465730d0a7961736d696e2e7269626569726f0d0a7061756c6f2e726f67c3a972696f0d0a706564726f2e7061756c6f0d0a72616661656c2e616c6d656964610d0a6c65616e64726f2e6564756172646f0d0a6a6f6e617461732e7669616e61, NULL, 'V', 151, '2026-05-12', '15:17:00', NULL, NULL),
	(160, 28, 16, NULL, NULL, 41, '2026-05-11', '14:59:00', 'C', 'P', _binary 0x536520666f7220696d70726573736f726120636f6c6f726964612c207175616c206120636f7220746f20746f6e6572203f3a507265746f2065204d617267656e74610d0a53454c4220646120496d70726573736f7261203a4564756361c3a7c3a36f, _binary 0x526573706f6e73c3a176656c2070656c6f207472616e73706f7274653a5469206461204564756361c3a7c3a36f, 'V', 152, '2026-05-11', '15:30:00', '2026-05-11', '15:02:00'),
	(161, 7, 28, NULL, NULL, 36, '2026-05-11', '15:00:00', 'C', 'P', _binary 0x696e7374616c61c3a7c3a36f20696d70726573736f7261205248206e6f207365746f722064652050726f6a65746f73, _binary 0x746573746573206f6b, 'V', 153, '2026-05-11', '17:00:00', '2026-05-11', '15:02:00'),
	(162, 7, 16, NULL, NULL, 41, '2026-05-11', '15:03:00', 'C', 'P', _binary 0x536520666f7220696d70726573736f726120636f6c6f726964612c207175616c206120636f7220746f20746f6e6572203f3a4d617267656e74610d0a53454c4220646120496d70726573736f7261203a476162696e657465, _binary 0x526573706f6e73c3a176656c2070656c6f207472616e73706f7274653a4a656465616e2070617261206f20506564726f20, 'V', 155, '2026-05-11', '15:34:00', '2026-05-11', '15:05:00'),
	(163, 6, 28, NULL, NULL, 36, '2026-05-11', '15:03:00', 'C', 'P', _binary 0x696e7374616c61c3a7c3a36f20696d70726573736f7261205248206e6f207365746f72206465205365727669c3a76f7320476572616973, _binary 0x696e7374616c61c3a7c3a36f206520746573746573206f6b, 'V', 154, '2026-05-11', '17:03:00', '2026-05-11', '15:06:00'),
	(164, 33, 28, NULL, NULL, 77, '2026-05-11', '15:12:00', 'C', 'P', _binary 0x4c6f63616c3a2050726f6a750d0a557375c3a172696f3a20497361736d696e2c2041647269616e612065204272756e6f, _binary 0x466f72616d20696e7374616c61646f73206f207072696d6569726f2061636573736f2064612053757065726e6f76612070617261206f7320757375c3a172696f732063697461646f732066616c74616e646f206170656e6173206f2073697374656d612064652064c3ad7669646120617469766120612073657220696e7374616c61646f2070656c6f207365727669646f72204c656f6e6172646f, 'V', 156, '2026-05-11', '15:42:00', '2026-05-11', '15:13:00'),
	(165, 28, 16, NULL, NULL, 15, '2026-05-11', '16:57:00', 'C', 'P', _binary 0x4e6f6d653a2041647269616e61204cc3ba6369612064612053696c76610d0a4350463a203036382e3133322e3239362d39390d0a4d6f64756c6f7320717565206972c3a120616365737361722028636f6d707261732c206573746f7175652c20636f6e746162696c69646164652c2070726567c3a36f2c20637265646f7265732c2066726f7461732c20707265737461c3a7c3a36f20646520636f6e7461732c2070617472696dc3b46e696f203a4573746f7175650d0a0d0a, _binary 0x0d0a0d0a557375c3a172696f20646f287329206dc3b364756c6f287329203a61647269616e612e6c756369610d0a53656e686120646f287329206dc3b364756c6f287329203a7361626172614032303236, 'V', 157, '2026-05-11', '18:57:00', '2026-05-11', '16:58:00'),
	(166, 18, 16, NULL, NULL, 54, '2026-05-11', '17:03:00', 'C', 'P', _binary 0x4e6f6d6520646f20757375c3a172696f203a204a6169726f20436861766573206465204f6c6976656972610d0a5061737461732064652061636573736f206e612072656465203a526567696f6e616973, _binary 0x4c6f67696e20646f20557375c3a172696f3a6a6169726f2e6368617665730d0a53656e686120496e696369616c203a7361626172614032303236, 'V', 158, '2026-05-11', '18:03:00', '2026-05-11', '17:04:00'),
	(167, 6, 16, NULL, NULL, 62, '2026-05-12', '09:26:00', 'C', 'P', _binary 0x4e6f6d6520646f20557375c3a172696f3a4a756c69616e612053616e746f73206465204d6f726169730d0a4350463a6ec3a36f20696e666f726d61646f0d0a4c6f63616973206465205472616d697461c3a7c3a36f203a41646d696e6973747261c3a7c3a36f20652070617472696d6f6e696f, _binary 0x4c6f67696e20646f20557375c3a172696f203a6a756c69616e612e73616e746f730d0a53656e68612064652041636573736f203a313233343536, 'V', 159, '2026-05-12', '09:57:00', '2026-05-12', '09:31:00'),
	(168, 10, 16, NULL, NULL, 55, '2026-05-12', '10:09:00', 'C', 'P', _binary 0x68616973204d617263656c61204c61676573204669616c686f0d0a4350463a2031303633353437373638380d0a0d0a5065726d697469722061636573736f2061204453203e3e20537561730d0a537567657374c3a36f3a2074686169732e6669616c686f, _binary 0x757375c3a172696f203a64616e646172612e73616c65730d0a53656e6861207361626172614032303236, 'V', 160, '2026-05-12', '11:10:00', '2026-05-12', '10:14:00'),
	(169, 10, 16, NULL, NULL, 55, '2026-05-12', '10:11:00', 'C', 'P', _binary 0x44616e6461726120526169616e652053616c6573204665727265697261200d0a3036352e3231352e3331362d30330d0a537567657374c3a36f3a2064616e646172612e73616c65730d0a0d0a41636573736f207061737461204453203e3e2043524153, _binary 0x4c6f67696e20646f20557375c3a172696f3a64616e646172612e73616c65730d0a53656e686120496e696369616c203a7361626172614032303236, 'V', 161, '2026-05-12', '11:11:00', '2026-05-12', '10:13:00'),
	(170, 33, 16, NULL, NULL, 26, '2026-05-12', '15:39:00', 'C', 'P', _binary 0x50617472696dc3b46e696f203a6a7572696469636f20287375656c69290d0a436865636f75206361626f7320646520656e65726769612065206461646f73202873696d2f6ec3a36f29203a73696d, _binary 0x5265696e7374616c61646f20647269766520646120706c61636120646520766964656f20646f20736974652064612064656c6c2e204d6f6e69746f722066756e63696f6e616e646f206e6f726d616c6d656e7465, 'V', 162, '2026-05-14', '15:39:00', '2026-05-12', '15:40:00'),
	(171, 9, 30, NULL, NULL, 24, '2026-05-12', '16:29:00', 'C', 'P', _binary 0x50617472696dc3b46e696f203a0d0a536f6c69636974612073656e686120706172612061636573736172207061737461732f6172717569766f7320646520726564652e0d0a555355c38152494f3a2074617469616e652e6d6174696173, _binary 0x4f20532e4f2e20c3a9204c696e75783b2061646963696f6e6569206f20706320616f20646f6dc3ad6e696f20504d533b20657865637574656920636f6d616e646f73207570646174652f757067726164653b20736f6c696369746569207265646566696e69c3a7c3a36f2064652073656e686120646520646f6dc3ad6e696f2070617261206120757375c3a17269613b20636f6e666967757265692061636573736f20706172612061732070617374617320646520726564653b206578616d696e656920706f6e746f2064652061636573736f206120726564653b2074726f71756569206f20706174636820636f726420646520706f727461206e6f207377697463682e, 'V', 163, '2026-05-12', '12:20:00', '2026-05-12', '17:00:00'),
	(172, 9, 30, 21, NULL, 23, '2026-05-12', '17:08:00', 'E', 'P', _binary 0x50617472696d6f6e696f3a203130333931300d0a0d0a506320666f69207265646566696e69646f207061726120636f6e666967757261c3a7c3b565732064652066c3a162726963612e0d0a, NULL, 'R', 164, '2026-05-13', '19:11:00', NULL, NULL);

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
) ENGINE=InnoDB AUTO_INCREMENT=153 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Copiando dados para a tabela gop.temp_horas: ~5 rows (aproximadamente)
INSERT INTO `temp_horas` (`id`, `horas`, `minutos`, `executor`, `tempo_grafico`) VALUES
	(148, 225, 0, 'Edilson Fernandes da Cruz', 225),
	(149, 18, 60, 'Glaison Queiroz', 19),
	(150, 31, 30, 'Jedean Moisés do Carmo', 31.5),
	(151, 145, 30, 'Jerônimo Mayer dos Santos', 145.5),
	(152, 106, 60, 'Lucio Machado', 107);

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

-- Copiando estrutura para tabela gop.tipo_ocorrencia
CREATE TABLE IF NOT EXISTS `tipo_ocorrencia` (
  `id` int NOT NULL AUTO_INCREMENT,
  `descricao` varchar(150) DEFAULT NULL,
  `tipo` char(1) DEFAULT NULL,
  KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Copiando dados para a tabela gop.tipo_ocorrencia: ~13 rows (aproximadamente)
INSERT INTO `tipo_ocorrencia` (`id`, `descricao`, `tipo`) VALUES
	(1, 'Impressoras e scanners', '0'),
	(2, 'Computadores', NULL),
	(3, 'Rede - Conectividade', NULL),
	(5, 'e-mail corporativo', NULL),
	(6, 'Câmeras', NULL),
	(7, 'Internet', NULL),
	(8, 'Rede wi-fi', NULL),
	(9, 'software', NULL),
	(10, 'Sistema Moderna (supernova)', NULL),
	(11, 'Monitor', NULL),
	(12, 'Mouse', NULL),
	(13, 'Teclado', NULL),
	(14, 'Usuários de Rede / Computador', NULL),
	(15, 'Plantão de Suporte de TI', NULL),
	(16, 'Projetores', NULL),
	(17, 'Protocolo WEB', NULL),
	(18, 'Telefonia', NULL),
	(19, 'Outros', NULL),
	(20, 'Telefonia Movel', NULL);

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
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Copiando dados para a tabela gop.usuarios: ~11 rows (aproximadamente)
INSERT INTO `usuarios` (`id`, `id_perfil`, `id_setor`, `nome`, `login`, `senha`, `ativo`, `cpf`, `tipo`, `email`) VALUES
	(16, 1, NULL, 'Glaison Queiroz', 'Glaison', 'dGFpb2JhQDMxNjMxOA==', 'S', '695.510.226-53', 'Administrador', 'glaison26.queiroz@gmail.com'),
	(22, 1, 27, 'Solicitante', 'Solicitante', 'dGFpb2JhQDMxNjMxOA==', 'S', '69551022653', 'Solicitante', 'glaison26.queiroz@gmail.com'),
	(25, 2, NULL, 'Informatica', 'informatica', 'U2FiYXJhQDIwMjY=', 'S', '69551022653', 'Operador', 'suporte@sabara.mg.gov.br'),
	(26, 1, NULL, 'Jerônimo Mayer dos Santos', 'jeronimo.mayer', 'SjI0MTcwMCM=', 'S', '79017711604', 'Operador', 'manutencao@sabara.mg.gov.br'),
	(27, 1, NULL, 'Edilson Fernandes da Cruz', 'edilson.fernandes', 'RWQmbHNvbjE4MDE4Ng==', 'S', '07364181644', 'Operador', 'manutencao@sabara.mg.gov.br'),
	(28, 1, NULL, 'Jedean Moisés do Carmo', 'Jedean', 'TnVtZXJvMDU4Lg==', 'S', '04071055650', 'Operador', 'jedean@sabara.mg.gov.br'),
	(29, 1, NULL, 'Wellington Alves Jardim da Silva', 'wellington.jardim', 'UmFmYWVsYS41OA==', 'S', '95752560691', 'Administrador', 'wellington@sabara.mg.gov.br'),
	(30, 1, NULL, 'Lucio Machado', 'lucio.machado', 'cm9nZXBvMWNA', 'S', '03153248648', 'Operador', 'manutencao@sabara.mg.gov.br'),
	(31, 1, NULL, 'Flavio Maielo', 'flavio.maielo', 'ZmxhdmlvQDIwMjY=', 'S', '69551022653', 'Operador', 'suporte@sabara.mg.gov.br'),
	(32, 1, 33, 'Juridico', 'Juridico', 'anVyaWRpY29AMjAyNg==', 'S', '69551022653', 'Solicitante', 'suporte@sabara.mg.gov.br'),
	(33, 1, 32, 'Controladoria', 'Controladoria', 'Y29udHJvbGFkb3JpYUAyMDI2', 'S', '69551022653', 'Solicitante', 'suporte@sabara.mg.gov.br');

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
