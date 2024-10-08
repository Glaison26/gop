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
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Copiando dados para a tabela gop.centrodecusto: ~3 rows (aproximadamente)
REPLACE INTO `centrodecusto` (`id`, `descricao`, `codigo`, `id_espacofisico`, `endereco`, `bairro`, `cidade`, `cep`, `fone1`, `fone2`, `email`, `responsavel`, `rateio`) VALUES
	(1, 'Meio Ambiente', NULL, 4, '', '', '', '', '(31)4442-3423', '(31)4423-4234', '', 'Prefeitura', 0),
	(2, 'Almoxarifado Saúde', NULL, 1, '', '', '', '', '(31)3323-4124', '(31)1223-4123', '', 'Prefeitura', 0),
	(3, 'Estacionamento de Ambulancia', NULL, 2, '', '', '', '', '(31)3434-1344', '(31)3242-1342', '', 'Manoel', 0);

-- Copiando estrutura para tabela gop.checklist
CREATE TABLE IF NOT EXISTS `checklist` (
  `id` int NOT NULL AUTO_INCREMENT,
  `descricao` varchar(150) NOT NULL DEFAULT '0',
  `descritivo` blob,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Copiando dados para a tabela gop.checklist: ~4 rows (aproximadamente)
REPLACE INTO `checklist` (`id`, `descricao`, `descritivo`) VALUES
	(1, 'Instalação de Memória SSD', _binary 0x2d2043686176652064652046656e64610d0a2d2050656e20447269766520636f6d2053697374656d61204f7065726163696f6e616c0d0a2d20446973636f2065787465726e6f2070617261206261636b7570),
	(2, 'Instalação de Ponto de Rede', _binary 0x312043686176652064652066656e64610d0a32205465737461646f72206465204361626f),
	(3, 'checklist roteador de rede', _binary 0x46657272616d656e746173);

-- Copiando estrutura para tabela gop.diretrizes
CREATE TABLE IF NOT EXISTS `diretrizes` (
  `id` int NOT NULL AUTO_INCREMENT,
  `descricao` varchar(150) NOT NULL DEFAULT '',
  `texto` blob,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Copiando dados para a tabela gop.diretrizes: ~3 rows (aproximadamente)
REPLACE INTO `diretrizes` (`id`, `descricao`, `texto`) VALUES
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
REPLACE INTO `diretriz_estrategia` (`id`, `id_estrategia`, `id_diretriz`) VALUES
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
REPLACE INTO `enderecos` (`id`, `logradouro`, `numero`, `usuario_id`) VALUES
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

-- Copiando dados para a tabela gop.espacos: ~4 rows (aproximadamente)
REPLACE INTO `espacos` (`id`, `descricao`, `tipo`, `medida`, `endereco`, `bairro`, `cidade`, `cep`, `responsavel`, `email`, `fone1`, `fone2`) VALUES
	(1, 'Meio Ambiente', 'Instalação', '30', 'Rua da Itendencia 316', 'Centro', 'Sabará', '34505480', 'Prefeitura', 'teste@gmail.com', '', ''),
	(2, 'Prédio Saúde', 'Edificação', '0', '0', '0', '0', '0', 'Prefeitura', '0', '(31)9855-5555', '(31)5555-8888'),
	(5, 'Predio da Fazenda segundo andar', 'Instalação', '', 'Rua da Intendência', 'Centro', 'Sabará', '34505-480', 'Sonia Almeida', 'glaison26.queiroz@gmail.com', '(31) 3672-7688', '');

-- Copiando estrutura para tabela gop.estrategias
CREATE TABLE IF NOT EXISTS `estrategias` (
  `id` int NOT NULL AUTO_INCREMENT,
  `descricao` varchar(150) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Copiando dados para a tabela gop.estrategias: ~2 rows (aproximadamente)
REPLACE INTO `estrategias` (`id`, `descricao`) VALUES
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
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Copiando dados para a tabela gop.executores: ~4 rows (aproximadamente)
REPLACE INTO `executores` (`id`, `id_oficina`, `id_funcao`, `nome`, `endereco`, `bairro`, `cep`, `cidade`, `uf`, `contato`, `tipo`, `cpf_cnpj`, `email`, `url`, `fone1`, `fone2`, `fone3`, `salario`, `horastrab`, `valorhora`, `escolaridade`, `formacao`, `obs`) VALUES
	(5, 7, 5, 'Glaison Queiroz', 'Rua da Itendencia 316', 'Centro', '34.505-480', 'Sabará', 'AC', 'Shay lin', 'F', '695.510.226-53', 'suporte@sabara.mg.gov.br', '', '(31)3672-7688', '', '', 0, 0, 150.9, 'Primário', '', _binary 0x7465737465),
	(6, 1, 2, 'Maria da Silva', 'Rua da Itendencia 316', 'Centro', '34.505-480', 'Sabará', 'MG', 'Antonio Dias', 'F', '695.510.226-53', 'suporte@sabara.mg.gov.br', '', '', '', '', 0, 0, 0, 'Primário', '', _binary ''),
	(7, 7, 5, 'Juliana Almeida', 'Rua da Intendência', 'Centro', '34505-480', 'Sabará', 'AC', 'Juliana', 'F', '695.510.226-53', 'glaison26.queiroz@gmail.com', '', '(31) 3672-7688', '', '', 0, 0, 0, 'Primário', '', _binary '');

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

-- Copiando dados para a tabela gop.fabricantes: ~2 rows (aproximadamente)
REPLACE INTO `fabricantes` (`id`, `descricao`, `razaosocial`, `tipo`, `cep`, `endereco`, `bairro`, `cidade`, `estado`, `cnpj_cpf`, `insc_estad`, `insc_munic`, `fone1`, `fone2`, `contato`, `email`, `url`, `obs`) VALUES
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

-- Copiando dados para a tabela gop.ferramentas: ~5 rows (aproximadamente)
REPLACE INTO `ferramentas` (`id`, `descricao`, `patrimonio`, `serie`, `id_fabricante`, `id_fornecedor`, `notafiscal`, `data_aquisicao`, `valor_aquisicao`, `data_garantia`, `id_marca`, `id_oficina`, `conservacao`, `obs`) VALUES
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

-- Copiando dados para a tabela gop.fornecedores: ~4 rows (aproximadamente)
REPLACE INTO `fornecedores` (`id`, `id_grupo`, `descricao`, `razaosocial`, `cnpj_cpf`, `insc_estad`, `insc_munic`, `tipo`, `endereco`, `bairro`, `cep`, `cidade`, `estado`, `fone1`, `fone2`, `email`, `site`, `contato`, `obs`) VALUES
	(1, 3, 'Simpress', 'Simpress do Brasil Ltda', '01.846.742/0001-03', '', '', 'Juridica', '', '', '', '', 'MG', '(31)3334-4444', '(31)2444-4444', '', '', 'Antonio Dias da Silva', _binary ''),
	(2, 1, 'Glaison Queiroz', 'Método Informática SA', '22.998.344/0001-99', '', '', 'Juridica', 'Rua da Intendência', '', '34505-480', 'Sabará', 'MG', '(31)3454-3333', '(31)2453-3332', 'glaison26.queiroz@gmail.com', '', 'Guilherme', _binary 0x7465737465),
	(3, 7, 'Vilafort', 'vilafort sa.', '23.451.301/0001-37', '', '', 'Juridica', 'Rua da Intendência', 'Centro', '34505-480', 'Sabará', 'MG', '(31) 3672-7688', '', 'glaison26.queiroz@gmail.com', '', 'José', _binary '');

-- Copiando estrutura para tabela gop.funcoes
CREATE TABLE IF NOT EXISTS `funcoes` (
  `id` int NOT NULL AUTO_INCREMENT,
  `descricao` varchar(120) NOT NULL,
  `ValorHora` double DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Copiando dados para a tabela gop.funcoes: ~7 rows (aproximadamente)
REPLACE INTO `funcoes` (`id`, `descricao`, `ValorHora`) VALUES
	(1, 'Técnico em Manutenção', 150),
	(2, 'Coordenador de Sistemas', 16.4),
	(4, 'Programador', 0),
	(5, 'Analista de Sistemas', 200),
	(6, 'Eletricista', 200),
	(7, 'Encanador', 90);

-- Copiando estrutura para tabela gop.grupos
CREATE TABLE IF NOT EXISTS `grupos` (
  `id` int NOT NULL AUTO_INCREMENT,
  `descricao` varchar(120) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Copiando dados para a tabela gop.grupos: ~9 rows (aproximadamente)
REPLACE INTO `grupos` (`id`, `descricao`) VALUES
	(1, 'Computadores Desktop'),
	(2, 'NoteBooks'),
	(3, 'Impressoras'),
	(4, 'Equipamento de rede'),
	(5, 'Analista de Sistemas'),
	(7, 'Câmeras de Vigilancia'),
	(9, 'Equipamentos Médicos'),
	(10, 'Insumo');

-- Copiando estrutura para tabela gop.marcas
CREATE TABLE IF NOT EXISTS `marcas` (
  `id` int NOT NULL AUTO_INCREMENT,
  `descricao` varchar(120) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=100 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Copiando dados para a tabela gop.marcas: ~10 rows (aproximadamente)
REPLACE INTO `marcas` (`id`, `descricao`) VALUES
	(1, 'Dell'),
	(2, 'samsung'),
	(3, 'HP'),
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
REPLACE INTO `materiais` (`id`, `descricao`, `id_grupo`, `id_marca`, `custo`, `qtdmin`, `qtdmax`, `id_unidadeEntrada`, `id_unidadeSaida`, `fator`, `ultimasaida`, `ultimaentrada`, `data_validade`, `quantidadeatual`, `obs`) VALUES
	(2, 'Parafusos Sextavados', 5, 6, 12.85, 0, 0, 2, 2, 1, '2023-01-26', '2023-01-26', '2023-01-26', 50, _binary 0x20),
	(3, 'Cabos de rede', 4, 4, 4.5, 0, 0, 8, 1, 1, '2023-01-26', '2023-01-26', '2023-01-26', 12, _binary 0x74657374652020),
	(4, 'Fita Isolante', 5, 6, 3.5, 0, 0, 8, 2, 1, '2024-10-02', '2024-10-02', '2029-06-22', 10, _binary 0x2020);

-- Copiando estrutura para tabela gop.ocorrencias
CREATE TABLE IF NOT EXISTS `ocorrencias` (
  `id` int NOT NULL AUTO_INCREMENT,
  `descricao` varchar(150) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Copiando dados para a tabela gop.ocorrencias: ~8 rows (aproximadamente)
REPLACE INTO `ocorrencias` (`id`, `descricao`) VALUES
	(1, 'Manutenção de Impressoras'),
	(2, 'Manutenção PC'),
	(3, 'Manutenção Elétrica'),
	(5, 'Criação de conta de email'),
	(6, 'Telefonia'),
	(7, 'Criação de Usuários de Rede'),
	(8, 'Manutenção Eletrônica');

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
REPLACE INTO `oficinas` (`id`, `descricao`, `fone1`, `fone2`, `email`, `responsavel`) VALUES
	(1, 'Elétrica', '(31) 3672-7688', '(31) 9988-3883', 'eletrica@gmail.com', 'Israel'),
	(2, 'Eletrônica', '(31) 3672-7688', '(31) 9984-2655', 'glaison26.queiroz@gmail.com', 'Glaison'),
	(3, 'Informática', '(31) 3672-7688', '(31) 3672-7642', 'Jedean@gmail.com', 'Jedean da Silva'),
	(6, 'Marcenaria 1', NULL, NULL, NULL, NULL),
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
) ENGINE=InnoDB AUTO_INCREMENT=47 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Copiando dados para a tabela gop.ordens: ~8 rows (aproximadamente)
REPLACE INTO `ordens` (`id`, `id_solicitante`, `id_responsavel`, `id_setor`, `id_recurso`, `id_espaco`, `id_oficina`, `data_entrada`, `hora_entrada`, `data_inicio`, `hora_inicio`, `data_conclucao`, `hora_conclusao`, `data_garantia`, `data_entrega`, `hora_entrega`, `data_saida`, `previsao_Horas`, `previsao_minutos`, `tipo`, `numero_nota`, `conclusao`, `valor_material`, `valor_servico`, `tipo_ordem`, `tipo_corretiva`, `tipo_preventiva`, `descritivo`, `mau_uso`, `situacao`, `motivo_naoconformidade`, `data_emissao`, `descricao`, `data_geracao`, `hora_geracao`, `data_previsao`, `hora_previsao`, `status`, `id_solicitacao`, `id_ocorrencia`) VALUES
	(38, 16, 16, 4, 1, NULL, 1, '2024-10-02', '19:24:00', '2024-10-02', '15:00:00', NULL, NULL, '2024-10-02', '2024-10-02', '19:24:00', '2024-10-02', NULL, NULL, 'R', '', NULL, 0, 0, 'C', 'P', '', 'Tomadas elétricas', NULL, 'C', '', NULL, _binary 0x56617272656475726120646520616e7469207669727573, '2024-10-01', '14:41:00', '2024-10-03', '15:00:00', 'A', NULL, 2),
	(39, 16, 16, 4, NULL, 1, 1, '2024-10-02', '19:24:00', '2024-10-02', '15:00:00', NULL, NULL, '2024-10-02', '2024-10-02', '19:24:00', '2024-10-02', NULL, NULL, 'E', '', NULL, 0, 0, 'C', 'P', '', 'Tomadas elétricas', NULL, 'C', '', NULL, _binary 0x496e737065c3a7c3a36f20456cc3a9747269636120646f207072c3a964696f, '2024-10-01', '14:41:00', '2024-10-03', '15:00:00', 'A', NULL, 3),
	(40, 16, 16, 4, NULL, 2, 1, '2024-10-02', '19:24:00', '2024-10-02', '15:00:00', NULL, NULL, '2024-10-02', '2024-10-02', '19:24:00', '2024-10-02', NULL, NULL, 'E', '', NULL, 0, 0, 'C', 'P', '', 'Tomadas elétricas', NULL, 'C', '', NULL, _binary 0x4d616e7574656ec3a7c3a36f20646520726f74696e61206e61207265646520656cc3a9747269636120646f2067616c70c3a36f20646f20616c6d6f786172696661646f206461207361c3ba6465, '2024-10-02', '15:13:00', '2024-10-03', '15:00:00', 'A', NULL, 3),
	(41, 16, 16, 4, 1, 0, 1, '2024-10-02', '19:24:00', '2024-10-02', '15:00:00', NULL, NULL, '2024-10-02', '2024-10-02', '19:24:00', '2024-10-02', NULL, NULL, 'R', '', NULL, 39.5, 311.66666666667, 'C', 'P', '', 'Tomadas elétricas', NULL, 'C', '', NULL, _binary 0x496e7374616c61c3a7c3a36f20646520546f6d61646120656cc3a97472696361, '2024-10-02', '16:01:00', '2024-10-03', '15:00:00', 'A', 39, 3),
	(43, 16, 16, 4, 1, NULL, 7, NULL, NULL, '2024-10-03', '16:02:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'R', NULL, NULL, 26, 105, 'P', NULL, 'R', 'Preventiva de computador DeskTop', NULL, NULL, NULL, NULL, _binary 0x546573746520636f6d2067657261c3a7c3a36f20636f6d706574612064612070726576656e74697661, '2024-10-03', '16:02:00', NULL, NULL, 'A', NULL, 5),
	(44, 16, 16, 4, 1, NULL, 7, NULL, NULL, '2024-10-03', '16:06:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'R', NULL, NULL, 30, 400, 'P', NULL, 'R', 'Preventiva de computador DeskTop', NULL, NULL, NULL, NULL, _binary 0x546573746520636f6d2067657261c3a7c3a36f20636f6d706574612064612070726576656e74697661, '2024-10-03', '16:06:00', NULL, NULL, 'A', NULL, 5),
	(45, 16, 16, 1, 3, NULL, 2, NULL, NULL, '2024-10-03', '16:20:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'R', NULL, NULL, NULL, NULL, 'P', NULL, 'P', 'Preventiva de Estabilizador Z3', NULL, NULL, NULL, NULL, _binary 0x43686563616167656d20646f2061706172656c686f0d0a736567756e64612067657261c3a7c3a36f2064652070726576656e74697661, '2024-10-03', '16:20:00', NULL, NULL, 'A', NULL, 8),
	(46, 16, 16, 3, NULL, 2, 1, NULL, NULL, '2024-10-03', '16:20:00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'E', NULL, NULL, NULL, NULL, 'P', NULL, 'R', 'Preventiva de Prédio Saúde', NULL, NULL, NULL, NULL, _binary 0x496e737065c3a7c3a36f20456cc3a9747269636120646f207072c3a964696f0d0a736567756e64612067657261c3a7c3a36f2064652070726576656e7469766120636f6d2065737061c3a76f2066697369636f, '2024-10-03', '16:20:00', NULL, NULL, 'A', NULL, 3);

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
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Copiando dados para a tabela gop.ordens_check: ~6 rows (aproximadamente)
REPLACE INTO `ordens_check` (`id`, `id_ordem`, `id_check`) VALUES
	(4, 24, 2),
	(7, 24, 1),
	(8, 41, 1),
	(11, 44, 1),
	(12, 44, 3),
	(13, 43, 3);

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
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Copiando dados para a tabela gop.ordens_executores: ~9 rows (aproximadamente)
REPLACE INTO `ordens_executores` (`id`, `id_ordem`, `id_executor`, `tempo_horas`, `tempo_minutos`, `valor_hora`, `valor_total`) VALUES
	(6, 24, 6, 4, 30, 15, 67.5),
	(7, 24, 5, 12, 20, 150, 1850),
	(9, 24, 5, 3, 35, 140, 501.66666666667),
	(10, 24, 5, 2, 30, 20, 50),
	(11, 38, 6, 2, 30, 150, 375),
	(12, 41, 7, 3, 40, 85, 311.66666666667),
	(17, 44, 5, 2, 40, 150, 400),
	(18, 44, 7, NULL, NULL, NULL, NULL),
	(19, 43, 7, 1, 30, 70, 105);

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
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Copiando dados para a tabela gop.ordens_ferramentas: ~4 rows (aproximadamente)
REPLACE INTO `ordens_ferramentas` (`id`, `id_ordem`, `id_ferramenta`) VALUES
	(1, 24, 6),
	(4, 41, 6),
	(5, 44, 6),
	(6, 44, 1);

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
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Copiando dados para a tabela gop.ordens_imagens: ~3 rows (aproximadamente)
REPLACE INTO `ordens_imagens` (`id`, `id_ordem`, `caminho`, `data`, `comentario`) VALUES
	(3, 38, 'img/computador.jpeg', '2024-10-04', 'Primeira manutenção do equipamento'),
	(4, 38, 'img/placamae.jpeg', '2024-10-04', 'Imagem da placa mãe'),
	(5, 43, 'img/computador.jpeg', '2024-10-08', 'Situação do equipamento no atendimento');

-- Copiando estrutura para tabela gop.ordens_materiais
CREATE TABLE IF NOT EXISTS `ordens_materiais` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_ordem` int DEFAULT NULL,
  `id_material` int DEFAULT NULL,
  `id_unidade` int DEFAULT NULL,
  `quantidade` double DEFAULT NULL,
  `valor` double DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_ordens_materiais_materiais` (`id_material`),
  KEY `FK_ordens_materiais_unidades` (`id_unidade`),
  KEY `FK_ordens_materiais_ordens` (`id_ordem`),
  CONSTRAINT `FK_ordens_materiais_materiais` FOREIGN KEY (`id_material`) REFERENCES `materiais` (`id`),
  CONSTRAINT `FK_ordens_materiais_ordens` FOREIGN KEY (`id_ordem`) REFERENCES `ordens` (`id`),
  CONSTRAINT `FK_ordens_materiais_unidades` FOREIGN KEY (`id_unidade`) REFERENCES `unidades` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Copiando dados para a tabela gop.ordens_materiais: ~10 rows (aproximadamente)
REPLACE INTO `ordens_materiais` (`id`, `id_ordem`, `id_material`, `id_unidade`, `quantidade`, `valor`) VALUES
	(8, 24, 2, 8, 100, 1.5),
	(13, 24, 3, 10, 2, 17.5),
	(14, 38, 3, 2, 1, 120),
	(15, 38, 2, 8, 6, 1.5),
	(16, 41, 4, 8, 10, 1.7),
	(17, 41, 2, 8, 15, 1.5),
	(22, 44, 4, 10, 5, 6),
	(23, 44, 2, 8, 120, NULL),
	(24, 43, 4, 10, 1, 3.5),
	(25, 43, 2, 8, 15, 1.5);

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
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Copiando dados para a tabela gop.ordens_pop: ~6 rows (aproximadamente)
REPLACE INTO `ordens_pop` (`id`, `id_ordem`, `id_pop`) VALUES
	(1, 24, 2),
	(5, 24, 4),
	(7, 41, 4),
	(10, 44, 2),
	(11, 44, 4),
	(13, 43, 2);

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Copiando dados para a tabela gop.planejamento: ~0 rows (aproximadamente)

-- Copiando estrutura para tabela gop.planejamento_diretrizes
CREATE TABLE IF NOT EXISTS `planejamento_diretrizes` (
  `id` int NOT NULL,
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
  CONSTRAINT `FK_planejamento_diretrizes_planejamento_diretrizes` FOREIGN KEY (`id_planejamento`) REFERENCES `planejamento_diretrizes` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Copiando dados para a tabela gop.planejamento_diretrizes: ~0 rows (aproximadamente)

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
REPLACE INTO `pops` (`id`, `id_recurso`, `id_espaco`, `id_oficina`, `tipo`, `descricao`, `revisado`, `preparado`, `resultadoesperado`, `materialnecessario`, `descritivo`, `atividadecritica`, `cuidados`, `anc`, `data`, `dataemissao`, `processo`, `objetivo`, `risco`, `refbibliografica`) VALUES
	(2, 1, 2, 3, '1', 'Instalação Super Nova', 'Marcos', 'Glaison', _binary 0x61636573736f20616f207365727669646f722064612073757065726e6f766120652061636573736f20616f207265737065637469766f73206dc3b364756c6f73, _binary 0x706173746120636f6d206f206172717569766f20646520696e7374616c61c3a7c3a36f20646973706f6ec3ad76656c206e61207061737461207574696c73, _binary 0x496e7374616c61c3a7c3a36f2070617261206f2061636573736f20646f2073697374656d612073757065726e6f7661206e6f20706320636c69656e746520, _binary 0x6e656e68756d61, _binary 0x696e7374616c6172206e6f206c6f67696e20646f20757375c3a172696f20717565206972c3a1207574696c697a6172206f2073697374656d61, _binary 0x5061737361722070617261206f207375706f72746520646520746920646120656d707265736120496e6f7661, '2024-09-04', NULL, _binary 0x2d20636f7069617220612070617374612073757065726e6f766120646973706f6e6976656c206e61207061737461207574696c7320646120726564650d0a2d20496e7374616c61206f2061706c6963617469766f20617070636f6e74726f6c65720d0a2d206372696172206174616c686f206e6120c3a17265612064652074726162616c686f, _binary 0x41636573736f20616f2073697374656d6120646f2073757065726e6f7661, _binary '', _binary 0x6e656e68756d61),
	(4, 1, 1, 7, '1', 'Configurar PC no Dominio', '', '', _binary '', _binary '', _binary '', _binary '', _binary '', _binary '', '2024-09-22', NULL, _binary '', _binary '', _binary '', _binary '');

-- Copiando estrutura para tabela gop.preventivas
CREATE TABLE IF NOT EXISTS `preventivas` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_recurso` int DEFAULT NULL,
  `id_espaco` int DEFAULT NULL,
  `id_oficina` int DEFAULT NULL,
  `id_centrodecusto` int DEFAULT NULL,
  `id_ocorrencia` int DEFAULT NULL,
  `id_setor` int DEFAULT NULL,
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
  KEY `FK_preventivas_setores` (`id_setor`),
  CONSTRAINT `FK_preventivas_centrodecusto` FOREIGN KEY (`id_centrodecusto`) REFERENCES `centrodecusto` (`id`),
  CONSTRAINT `FK_preventivas_espacos` FOREIGN KEY (`id_espaco`) REFERENCES `espacos` (`id`),
  CONSTRAINT `FK_preventivas_ocorrencias` FOREIGN KEY (`id_ocorrencia`) REFERENCES `ocorrencias` (`id`),
  CONSTRAINT `FK_preventivas_oficinas` FOREIGN KEY (`id_oficina`) REFERENCES `oficinas` (`id`),
  CONSTRAINT `FK_preventivas_recursos` FOREIGN KEY (`id_recurso`) REFERENCES `recursos` (`id`),
  CONSTRAINT `FK_preventivas_setores` FOREIGN KEY (`id_setor`) REFERENCES `setores` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Copiando dados para a tabela gop.preventivas: ~6 rows (aproximadamente)
REPLACE INTO `preventivas` (`id`, `id_recurso`, `id_espaco`, `id_oficina`, `id_centrodecusto`, `id_ocorrencia`, `id_setor`, `tipo`, `tipo_preventiva`, `data_cadastro`, `periodicidade_geracao`, `data_prox_realizacao`, `data_ult_realizacao`, `calibracao`, `descritivo`, `gerar`) VALUES
	(4, 1, NULL, 3, 2, 2, 3, 'R', 'R', '2024-10-01', 30, '2024-10-13', '2024-09-13', 'N', _binary 0x56617272656475726120646520616e7469207669727573, 'Sim'),
	(5, NULL, 2, 1, 2, 3, 3, 'E', 'R', '2024-10-01', 20, '2024-10-12', '2024-09-22', 'N', _binary 0x496e737065c3a7c3a36f20456cc3a9747269636120646f207072c3a964696f0d0a736567756e64612067657261c3a7c3a36f2064652070726576656e7469766120636f6d2065737061c3a76f2066697369636f, 'Sim'),
	(6, 1, NULL, 7, 2, 3, 4, 'R', 'R', '2024-10-02', 20, '2024-10-22', '2024-10-02', 'N', _binary 0x7465737465, 'Sim'),
	(7, NULL, 2, 1, 2, 3, 4, 'E', 'R', '2024-10-02', 20, '2024-10-14', '2024-09-24', 'N', _binary 0x4d616e7574656ec3a7c3a36f20646520726f74696e61206e61207265646520656cc3a9747269636120646f2067616c70c3a36f20646f20616c6d6f786172696661646f206461207361c3ba6465, 'Sim'),
	(8, 1, NULL, 7, 2, 5, 4, 'R', 'R', '2024-10-02', 30, '2024-11-01', '2024-10-02', 'N', _binary 0x546573746520636f6d2067657261c3a7c3a36f20636f6d706574612064612070726576656e74697661, 'Sim'),
	(9, 3, NULL, 2, 1, 8, 1, 'R', 'P', '2024-10-02', 45, '2024-11-06', '2024-09-22', 'N', _binary 0x43686563616167656d20646f2061706172656c686f0d0a736567756e64612067657261c3a7c3a36f2064652070726576656e74697661, 'Sim'),
	(10, 3, NULL, 3, 2, 8, 4, 'R', 'S', '2024-10-04', 30, '2024-08-31', '2024-08-01', 'N', _binary 0x636865636167656d2064652074656e73c3a36f, 'Sim');

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
REPLACE INTO `preventivas_checklist` (`id`, `id_check`, `id_preventiva`) VALUES
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
REPLACE INTO `preventivas_executores` (`id`, `id_preventiva`, `id_executor`) VALUES
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
REPLACE INTO `preventivas_ferramentas` (`id`, `id_ferramenta`, `id_preventiva`) VALUES
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
REPLACE INTO `preventivas_materiais` (`id`, `id_preventiva`, `id_material`, `id_unidade`, `quantidade`) VALUES
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
REPLACE INTO `preventivas_pop` (`id`, `id_pop`, `id_preventiva`) VALUES
	(1, 2, 8),
	(3, 4, 8);

-- Copiando estrutura para tabela gop.recursos
CREATE TABLE IF NOT EXISTS `recursos` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_espacofisico` int NOT NULL DEFAULT '0',
  `id_fabricante` int NOT NULL DEFAULT '0',
  `id_fornecedor` int NOT NULL DEFAULT '0',
  `id_grupo` int NOT NULL DEFAULT '0',
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
  PRIMARY KEY (`id`),
  KEY `FK_recursos_espacos` (`id_espacofisico`),
  KEY `FK_recursos_fabricantes` (`id_fabricante`),
  KEY `FK_recursos_fornecedores` (`id_fornecedor`),
  KEY `FK_recursos_grupos` (`id_grupo`),
  KEY `FK_recursos_centrodecusto` (`id_centrodecusto`),
  KEY `FK_recursos_oficinas` (`id_oficina`),
  KEY `FK_recursos_setores` (`id_setor`),
  KEY `FK_recursos_marcas` (`id_marca`),
  CONSTRAINT `FK_recursos_centrodecusto` FOREIGN KEY (`id_centrodecusto`) REFERENCES `centrodecusto` (`id`),
  CONSTRAINT `FK_recursos_espacos` FOREIGN KEY (`id_espacofisico`) REFERENCES `espacos` (`id`),
  CONSTRAINT `FK_recursos_fabricantes` FOREIGN KEY (`id_fabricante`) REFERENCES `fabricantes` (`id`),
  CONSTRAINT `FK_recursos_fornecedores` FOREIGN KEY (`id_fornecedor`) REFERENCES `fornecedores` (`id`),
  CONSTRAINT `FK_recursos_grupos` FOREIGN KEY (`id_grupo`) REFERENCES `grupos` (`id`),
  CONSTRAINT `FK_recursos_marcas` FOREIGN KEY (`id_marca`) REFERENCES `marcas` (`id`),
  CONSTRAINT `FK_recursos_oficinas` FOREIGN KEY (`id_oficina`) REFERENCES `oficinas` (`id`),
  CONSTRAINT `FK_recursos_setores` FOREIGN KEY (`id_setor`) REFERENCES `setores` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Copiando dados para a tabela gop.recursos: ~3 rows (aproximadamente)
REPLACE INTO `recursos` (`id`, `id_espacofisico`, `id_fabricante`, `id_fornecedor`, `id_grupo`, `id_centrodecusto`, `id_oficina`, `id_setor`, `id_marca`, `descricao`, `patrimonio`, `modelo`, `numeroserie`, `estado`, `notafiscal`, `datacadastro`, `datagarantia`, `valoraquisicao`, `valordepreciado`, `ultimapreventiva`, `ultimamanutencao`, `dataaquisicao`, `ativo`, `motivoinativo`, `reganvisa`, `obs`) VALUES
	(1, 2, 3, 1, 1, 3, 1, 1, 6, 'computador DeskTop', '1222', 'asdA', '3423234', 'Razoável', '234', '2023-02-08', '2023-02-08', 3000, 23, '2023-02-08', '2023-02-08', '2023-02-08', 'S', 'DDD', '3333', _binary ''),
	(2, 1, 3, 2, 7, 2, 3, 1, 6, 'Servidor Dell 15456', '54654654', 'ALtPLAN', '546546', 'Ótimo', '324444', '2009-02-23', '2023-02-09', 0, 0, '2023-02-09', '2023-02-09', '2023-02-09', 'S', '', '', NULL),
	(3, 1, 2, 2, 7, 2, 1, 1, 6, 'Estabilizador Z3', '84848484', 'ALtPLAN', '546546', 'Ótimo', '412324', '2023-09-02', '2023-02-09', 0, 0, '2023-02-09', '2023-02-09', '2023-02-09', 'S', '', '', NULL);

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

-- Copiando dados para a tabela gop.setores: ~4 rows (aproximadamente)
REPLACE INTO `setores` (`id`, `descricao`, `id_centrodecusto`, `Responsavel`, `fone1`, `fone2`, `email`, `prioritario`, `nivelprioridade`) VALUES
	(1, 'Poda e Corte de Árvores', 1, 'Prefeitura', '(31)3672-9844', '(42)3423-4234', '', 'NÃO', '4'),
	(3, 'Secretaria de Saúde', 2, 'Patricia', '(31) 3-3333', '', 'glaison26.queiroz@gmail.com', 'SIM', '1'),
	(4, 'Almoxarifado da Saúde', 2, 'Alexandra', '(31) 3672-7688', '', '', 'SIM', '1');

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
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Copiando dados para a tabela gop.solicitacao: ~8 rows (aproximadamente)
REPLACE INTO `solicitacao` (`id`, `id_setor`, `id_solicitante`, `id_recursos`, `id_espaco`, `id_ocorrencia`, `data_abertura`, `hora_abertura`, `status`, `tipo`, `descricao`, `classificacao`, `id_ordem`) VALUES
	(31, 3, 16, 1, NULL, 2, '2024-09-18', '16:14:00', 'E', 'P', _binary 0x466f726d617461c3a7c3a36f20646f205043, 'R', NULL),
	(32, 3, 16, 1, NULL, 2, '2024-09-18', '16:31:00', 'E', 'P', _binary 0x466f6d617461c3a7c3a36f, 'R', NULL),
	(33, 1, 16, NULL, 1, 3, '2024-09-18', '16:34:00', 'E', 'P', _binary 0x746f6d61646173, 'E', NULL),
	(34, 3, 16, NULL, NULL, 5, '2024-09-18', '16:36:00', 'E', 'P', _binary 0x43726961c3a7c3a36f20646520636f6e746120646520656d61696c20207465737465407361626172612e636f6d2e6272, 'V', NULL),
	(35, 3, 16, NULL, NULL, 7, '2024-09-18', '20:13:00', 'E', 'P', _binary 0x43726961c3a7c3a36f20646520757375c3a172696f207061726120616365737361207061737461206461207361c3ba64650d0a0d0a4d617269612064652046c3a174696d61206d6174726963756c612030303039333933, 'V', NULL),
	(36, 3, 16, 3, NULL, 1, '2024-09-18', '20:36:00', 'E', 'P', _binary 0x496d70726573736f726120626f7272616e646f, 'R', NULL),
	(37, 1, 16, NULL, 1, 1, '2024-09-18', '20:39:00', 'E', 'P', _binary 0x496d70726573736f7261, 'E', NULL),
	(38, 1, 16, NULL, NULL, 2, '2024-09-18', '20:40:00', 'A', 'P', _binary 0x63726961c3a7c3a36f20646520656d61696c20706f6461407361626172612e6d672e676f762e6272, 'V', NULL),
	(39, 4, 16, 1, NULL, 3, '2024-10-02', '15:53:00', 'E', 'P', _binary 0x496e7374616c61c3a7c3a36f20646520546f6d61646120656cc3a97472696361, 'R', NULL),
	(40, 4, 16, NULL, NULL, 7, '2024-10-02', '16:03:00', 'A', 'P', _binary 0x557375c3a172696f206e6f766f206465202072656465, 'V', NULL);

-- Copiando estrutura para tabela gop.unidades
CREATE TABLE IF NOT EXISTS `unidades` (
  `id` int NOT NULL AUTO_INCREMENT,
  `descricao` varchar(120) NOT NULL DEFAULT '0',
  `abreviatura` varchar(6) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Copiando dados para a tabela gop.unidades: ~9 rows (aproximadamente)
REPLACE INTO `unidades` (`id`, `descricao`, `abreviatura`) VALUES
	(1, 'Metro Quadrado', 'M2'),
	(2, 'Centímetro', 'cm'),
	(3, 'Kilo', 'KG'),
	(4, 'Hora', 'H'),
	(5, 'Litro', 'LT'),
	(8, 'Unidade', 'UN'),
	(9, 'Metro Cúbico', 'M3'),
	(10, 'Metro', 'm'),
	(11, 'Milimetro', 'MM');

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
  CONSTRAINT `FK_usuarios_setores` FOREIGN KEY (`id_setor`) REFERENCES `setores` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Copiando dados para a tabela gop.usuarios: ~6 rows (aproximadamente)
REPLACE INTO `usuarios` (`id`, `id_perfil`, `id_setor`, `nome`, `login`, `senha`, `ativo`, `cpf`, `tipo`, `email`) VALUES
	(16, NULL, NULL, 'Glaison Queiroz', 'Glaison', 'dGFpb2JhMjYxMA==', 'S', '695.510.226-53', 'Administrador', 'glaison26.queiroz@gmail.com'),
	(17, NULL, NULL, 'Manoel da Silva Braga', 'ManuelBraga', 'MTIzNDU2ZmRnZGZnc2Y=', 'N', '695.510.226-53', 'Administrador', NULL),
	(19, NULL, NULL, 'Itamar Franco', 'Franco', 'OTk5OTk5OTk5', 'S', '695.510.226-53', 'Administrador', NULL),
	(21, NULL, NULL, 'Manoel de Nobrega', 'Manoel', 'dGFpb2JhMTIz', 'S', '695.510.226-53', 'Operador', 'manoel@gmail.com'),
	(22, NULL, NULL, 'Solicitante', 'Solicitante', 'MTIzNDU2Nzg=', 'S', '69551022653', 'Solicitante', 'glaison26.queiroz@gmail.com'),
	(23, NULL, NULL, 'Adm', 'Adm', 'MTIzNDU2Nzg=', 'S', '69551022653', 'Administrador', 'glaison26.queiroz@gmail.com'),
	(24, NULL, NULL, 'Maria Joana', 'MJ', 'MTIzNDU2Nzg=', 'S', '69551022653', 'Solicitante', 'glaison26.queiroz@gmail.com');

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
