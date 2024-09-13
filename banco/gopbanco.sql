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

-- Copiando dados para a tabela gop.centrodecusto: ~2 rows (aproximadamente)
INSERT INTO `centrodecusto` (`id`, `descricao`, `codigo`, `id_espacofisico`, `endereco`, `bairro`, `cidade`, `cep`, `fone1`, `fone2`, `email`, `responsavel`, `rateio`) VALUES
	(1, 'Meio Ambiente', NULL, 4, '', '', '', '', '(31)4442-3423', '(31)4423-4234', '', 'Prefeitura', 0),
	(2, 'Almoxarifado Saúde', NULL, 1, '', '', '', '', '(31)3323-4124', '(31)1223-4123', '', 'Prefeitura', 0),
	(3, 'Estacionamento de Ambulancia', NULL, 2, '', '', '', '', '(31)3434-1344', '(31)3242-1342', '', 'Manoel', 0);

-- Copiando estrutura para tabela gop.checklist
CREATE TABLE IF NOT EXISTS `checklist` (
  `id` int NOT NULL AUTO_INCREMENT,
  `descricao` varchar(150) NOT NULL DEFAULT '0',
  `descritivo` blob,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Copiando dados para a tabela gop.checklist: ~0 rows (aproximadamente)
INSERT INTO `checklist` (`id`, `descricao`, `descritivo`) VALUES
	(1, 'Instalação de Memória SSD', _binary 0x2d2043686176652064652046656e64610d0a2d2050656e20447269766520636f6d2053697374656d61204f7065726163696f6e616c0d0a2d20446973636f2065787465726e6f2070617261206261636b7570),
	(2, 'Instalação de Ponto de Rede', _binary 0x312043686176652064652066656e64610d0a32205465737461646f72206465204361626f);

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
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Copiando dados para a tabela gop.espacos: ~2 rows (aproximadamente)
INSERT INTO `espacos` (`id`, `descricao`, `tipo`, `medida`, `endereco`, `bairro`, `cidade`, `cep`, `responsavel`, `email`, `fone1`, `fone2`) VALUES
	(1, 'Meio Ambiente', 'Instalação', '30', 'Rua da Itendencia 316', 'Centro', 'Sabará', '34505480', 'Prefeitura', 'teste@gmail.com', '', ''),
	(2, 'Prédio Saúde', 'Edificação', '0', '0', '0', '0', '0', 'Prefeitura', '0', '(31)9855-5555', '(31)5555-8888');

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

-- Copiando dados para a tabela gop.executores: ~2 rows (aproximadamente)
INSERT INTO `executores` (`id`, `id_oficina`, `id_funcao`, `nome`, `endereco`, `bairro`, `cep`, `cidade`, `uf`, `contato`, `tipo`, `cpf_cnpj`, `email`, `url`, `fone1`, `fone2`, `fone3`, `salario`, `horastrab`, `valorhora`, `escolaridade`, `formacao`, `obs`) VALUES
	(5, 1, 2, 'Glaison Queiroz', 'Rua da Itendencia 316', 'Centro', '34.505-480', 'Sabará', 'AC', 'Shay lin', 'F', '695.510.226-53', 'suporte@sabara.mg.gov.br', '', '(31)3672-7688', '', '', 0, 0, 0, 'Primário', '', _binary 0x7465737465),
	(6, 1, 2, 'Maria da Silva', 'Rua da Itendencia 316', 'Centro', '34.505-480', 'Sabará', 'MG', 'Antonio Dias', 'F', '695.510.226-53', 'suporte@sabara.mg.gov.br', '', '', '', '', 0, 0, 0, 'Primário', '', _binary '');

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

-- Copiando dados para a tabela gop.fabricantes: ~2 rows (aproximadamente)
INSERT INTO `fabricantes` (`id`, `descricao`, `razaosocial`, `tipo`, `cep`, `endereco`, `bairro`, `cidade`, `estado`, `cnpj_cpf`, `insc_estad`, `insc_munic`, `fone1`, `fone2`, `contato`, `email`, `url`, `obs`) VALUES
	(2, 'Epson', 'Epson Ltda', 'Juridica', '', '', '', '', 'MG', '01.846.742/0001-03', '', '', '(23)4143-2412', '(31)5555-8888', 'Shay lin', '', '', _binary 0x7465737465),
	(3, 'Samsung', 'Samsung do Brasil', 'Juridica', '', '', '', '', 'SP', '01.846.742/0001-03', '', '', '(11)4654-6546', '(11)4565-8789', 'Antonio Dias', '', '', _binary '');

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

-- Copiando dados para a tabela gop.ferramentas: ~3 rows (aproximadamente)
INSERT INTO `ferramentas` (`id`, `descricao`, `patrimonio`, `serie`, `id_fabricante`, `id_fornecedor`, `notafiscal`, `data_aquisicao`, `valor_aquisicao`, `data_garantia`, `id_marca`, `id_oficina`, `conservacao`, `obs`) VALUES
	(1, 'Martelo', '3434', '3434', 2, 1, '3423', '2023-01-18', 0, '2023-01-18', 8, 3, 'Bom', _binary 0x7465737465),
	(5, 'Serra de Madeira', '9000', '452345', 3, 2, '', '2023-01-21', 0, '2023-01-21', 6, 1, 'Ótimo', _binary ''),
	(6, 'Multimetro', '312222', '2334445', 3, 1, '93993', '2023-01-20', 900, '2024-01-20', 6, 2, 'Ótimo', _binary 0x7465737465);

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

-- Copiando dados para a tabela gop.fornecedores: ~2 rows (aproximadamente)
INSERT INTO `fornecedores` (`id`, `id_grupo`, `descricao`, `razaosocial`, `cnpj_cpf`, `insc_estad`, `insc_munic`, `tipo`, `endereco`, `bairro`, `cep`, `cidade`, `estado`, `fone1`, `fone2`, `email`, `site`, `contato`, `obs`) VALUES
	(1, 3, 'Simpress', 'Simpress do Brasil Ltda', '01.846.742/0001-03', '', '', 'Juridica', '', '', '', '', 'MG', '(31)3334-4444', '(31)2444-4444', '', '', 'Antonio Dias da Silva', _binary ''),
	(2, 1, 'Glaison Queiroz', 'Método Informática SA', '22.998.344/0001-99', '', '', 'Juridica', 'Rua da Intendência', '', '34505-480', 'Sabará', 'MG', '(31)3454-3333', '(31)2453-3332', 'glaison26.queiroz@gmail.com', '', 'Guilherme', _binary 0x7465737465);

-- Copiando estrutura para tabela gop.funcoes
CREATE TABLE IF NOT EXISTS `funcoes` (
  `id` int NOT NULL AUTO_INCREMENT,
  `descricao` varchar(120) NOT NULL,
  `ValorHora` double DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Copiando dados para a tabela gop.funcoes: ~5 rows (aproximadamente)
INSERT INTO `funcoes` (`id`, `descricao`, `ValorHora`) VALUES
	(1, 'Técnico em Manutenção', 150),
	(2, 'Coordenador de Sistemas', 16.4),
	(4, 'Programador', 0),
	(5, 'Analista de Sistemas', 200),
	(6, 'Eletricista', 200);

-- Copiando estrutura para tabela gop.grupos
CREATE TABLE IF NOT EXISTS `grupos` (
  `id` int NOT NULL AUTO_INCREMENT,
  `descricao` varchar(120) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Copiando dados para a tabela gop.grupos: ~6 rows (aproximadamente)
INSERT INTO `grupos` (`id`, `descricao`) VALUES
	(1, 'Computadores Desktop'),
	(2, 'NoteBooks'),
	(3, 'Impressoras'),
	(4, 'Equipamento de rede'),
	(5, 'Analista de Sistemas'),
	(7, 'Câmeras de Vigilancia'),
	(9, 'Equipamentos Médicos');

-- Copiando estrutura para tabela gop.marcas
CREATE TABLE IF NOT EXISTS `marcas` (
  `id` int NOT NULL AUTO_INCREMENT,
  `descricao` varchar(120) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=99 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Copiando dados para a tabela gop.marcas: ~9 rows (aproximadamente)
INSERT INTO `marcas` (`id`, `descricao`) VALUES
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
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Copiando dados para a tabela gop.materiais: ~2 rows (aproximadamente)
INSERT INTO `materiais` (`id`, `descricao`, `id_grupo`, `id_marca`, `custo`, `qtdmin`, `qtdmax`, `id_unidadeEntrada`, `id_unidadeSaida`, `fator`, `ultimasaida`, `ultimaentrada`, `data_validade`, `quantidadeatual`, `obs`) VALUES
	(2, 'Parafusos Sextavados', 5, 6, 12.85, 0, 0, 2, 2, 1, '2023-01-26', '2023-01-26', '2023-01-26', 50, _binary 0x20),
	(3, 'Cabos de rede', 4, 4, 4.5, 0, 0, 1, 1, 1, '2023-01-26', '2023-01-26', '2023-01-26', 12, _binary 0x746573746520);

-- Copiando estrutura para tabela gop.ocorrencias
CREATE TABLE IF NOT EXISTS `ocorrencias` (
  `id` int NOT NULL AUTO_INCREMENT,
  `descricao` varchar(150) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Copiando dados para a tabela gop.ocorrencias: ~3 rows (aproximadamente)
INSERT INTO `ocorrencias` (`id`, `descricao`) VALUES
	(1, 'Falta de Material'),
	(2, 'Atraso de Projetos'),
	(3, 'Manutenção Elétrica'),
	(5, 'Falta de energia elétrica');

-- Copiando estrutura para tabela gop.oficinas
CREATE TABLE IF NOT EXISTS `oficinas` (
  `id` int NOT NULL AUTO_INCREMENT,
  `descricao` varchar(120) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Copiando dados para a tabela gop.oficinas: ~5 rows (aproximadamente)
INSERT INTO `oficinas` (`id`, `descricao`) VALUES
	(1, 'Elétrica'),
	(2, 'Eletrônica'),
	(3, 'Informática'),
	(6, 'Marcenaria 1'),
	(7, 'Alvenaria'),
	(8, 'Equipamentos Médicos');

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
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Copiando dados para a tabela gop.ordens: ~4 rows (aproximadamente)
INSERT INTO `ordens` (`id`, `id_solicitante`, `id_responsavel`, `id_setor`, `id_recurso`, `id_espaco`, `id_oficina`, `data_entrada`, `hora_entrada`, `data_inicio`, `hora_inicio`, `data_conclucao`, `hora_conclusao`, `data_garantia`, `data_entrega`, `hora_entrega`, `data_saida`, `previsao_Horas`, `previsao_minutos`, `tipo`, `numero_nota`, `valor_material`, `valor_servico`, `tipo_ordem`, `tipo_corretiva`, `tipo_preventiva`, `descritivo`, `mau_uso`, `situacao`, `motivo_naoconformidade`, `data_emissao`, `descricao`, `data_geracao`, `hora_geracao`, `data_previsao`, `hora_previsao`, `status`, `id_solicitacao`) VALUES
	(8, 16, 16, 1, 1, 0, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'R', NULL, NULL, NULL, 'C', 'U', NULL, 'teste 3', NULL, NULL, NULL, NULL, _binary 0x7465737465, '2024-09-11', '17:41:00', '2024-09-11', '18:41:00', 'A', 12),
	(9, 16, 16, 1, 2, 0, 7, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'R', NULL, NULL, NULL, 'C', 'P', NULL, 'teste4', NULL, NULL, NULL, NULL, _binary 0x637364736466736461667364667364766664, '2024-09-11', '17:44:00', '2024-09-11', '18:44:00', 'A', 4),
	(10, 16, 16, 1, 3, 0, 7, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'R', NULL, NULL, NULL, 'C', 'P', NULL, '', NULL, NULL, NULL, NULL, _binary 0x4573746162696c697a61646f204465736c6967616e646f20736f7a696e686f, '2024-09-11', '18:11:00', '2024-09-11', '18:11:00', 'A', 5),
	(11, 16, 16, 1, 3, 0, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'R', NULL, NULL, NULL, 'C', 'P', NULL, 'Estabilizador com problema', NULL, NULL, NULL, NULL, _binary 0x7465737465, '2024-09-11', '18:12:00', '2024-09-19', '23:12:00', 'A', 6),
	(12, 16, 16, 1, 0, 1, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'E', NULL, NULL, NULL, 'C', 'P', NULL, 'teste de espaco fisico', NULL, NULL, NULL, NULL, _binary 0x496e7374616c61c3a7c3a36f206465206e6f7661206573747275747572612064652072656465, '2024-09-12', '12:23:00', '2024-09-12', '12:22:00', 'A', 9),
	(13, 16, 16, 3, 3, 0, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'R', NULL, NULL, NULL, 'C', 'P', NULL, 'os com outro setor', NULL, NULL, NULL, NULL, _binary 0x7465737465, '2024-09-13', '16:38:00', '2024-09-13', '18:38:00', 'A', 25);

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
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Copiando dados para a tabela gop.pops: ~0 rows (aproximadamente)
INSERT INTO `pops` (`id`, `id_recurso`, `id_espaco`, `id_oficina`, `tipo`, `descricao`, `revisado`, `preparado`, `resultadoesperado`, `materialnecessario`, `descritivo`, `atividadecritica`, `cuidados`, `anc`, `data`, `dataemissao`, `processo`, `objetivo`, `risco`, `refbibliografica`) VALUES
	(2, 1, 2, 3, '1', 'Instalação Super Nova', 'Marcos', 'Glaison', _binary 0x61636573736f20616f207365727669646f722064612073757065726e6f766120652061636573736f20616f207265737065637469766f73206dc3b364756c6f73, _binary 0x706173746120636f6d206f206172717569766f20646520696e7374616c61c3a7c3a36f20646973706f6ec3ad76656c206e61207061737461207574696c73, _binary 0x496e7374616c61c3a7c3a36f2070617261206f2061636573736f20646f2073697374656d612073757065726e6f7661206e6f20706320636c69656e746520, _binary 0x6e656e68756d61, _binary 0x696e7374616c6172206e6f206c6f67696e20646f20757375c3a172696f20717565206972c3a1207574696c697a6172206f2073697374656d61, _binary 0x5061737361722070617261206f207375706f72746520646520746920646120656d707265736120496e6f7661, '2024-09-04', NULL, _binary 0x2d20636f7069617220612070617374612073757065726e6f766120646973706f6e6976656c206e61207061737461207574696c7320646120726564650d0a2d20496e7374616c61206f2061706c6963617469766f20617070636f6e74726f6c65720d0a2d206372696172206174616c686f206e6120c3a17265612064652074726162616c686f, _binary 0x41636573736f20616f2073697374656d6120646f2073757065726e6f7661, _binary '', _binary 0x6e656e68756d61);

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
INSERT INTO `recursos` (`id`, `id_espacofisico`, `id_fabricante`, `id_fornecedor`, `id_grupo`, `id_centrodecusto`, `id_oficina`, `id_setor`, `id_marca`, `descricao`, `patrimonio`, `modelo`, `numeroserie`, `estado`, `notafiscal`, `datacadastro`, `datagarantia`, `valoraquisicao`, `valordepreciado`, `ultimapreventiva`, `ultimamanutencao`, `dataaquisicao`, `ativo`, `motivoinativo`, `reganvisa`, `obs`) VALUES
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
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Copiando dados para a tabela gop.setores: ~0 rows (aproximadamente)
INSERT INTO `setores` (`id`, `descricao`, `id_centrodecusto`, `Responsavel`, `fone1`, `fone2`, `email`, `prioritario`, `nivelprioridade`) VALUES
	(1, 'Poda e Corte de Árvores', 1, 'Prefeitura', '(31)3672-9844', '(42)3423-4234', '', 'NÃO', '4'),
	(3, 'Secretaria de Saúde', 2, 'Patricia', '(31) 3-3333', '', 'glaison26.queiroz@gmail.com', 'SIM', '1');

-- Copiando estrutura para tabela gop.solicitacao
CREATE TABLE IF NOT EXISTS `solicitacao` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_setor` int DEFAULT NULL,
  `id_solicitante` int NOT NULL,
  `id_recursos` int DEFAULT NULL,
  `id_espaco` int DEFAULT NULL,
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
  CONSTRAINT `FK_solicitacao_espacos` FOREIGN KEY (`id_espaco`) REFERENCES `espacos` (`id`),
  CONSTRAINT `FK_solicitacao_recursos` FOREIGN KEY (`id_recursos`) REFERENCES `recursos` (`id`),
  CONSTRAINT `FK_solicitacao_setores` FOREIGN KEY (`id_setor`) REFERENCES `setores` (`id`),
  CONSTRAINT `FK_solicitacao_usuarios` FOREIGN KEY (`id_solicitante`) REFERENCES `usuarios` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Copiando dados para a tabela gop.solicitacao: ~10 rows (aproximadamente)
INSERT INTO `solicitacao` (`id`, `id_setor`, `id_solicitante`, `id_recursos`, `id_espaco`, `data_abertura`, `hora_abertura`, `status`, `tipo`, `descricao`, `classificacao`, `id_ordem`) VALUES
	(4, 1, 16, 2, NULL, '2024-09-06', '17:26:00', 'E', 'P', _binary 0x637364736466736461667364667364766664, 'R', NULL),
	(5, 1, 16, 3, NULL, '2024-09-06', '18:13:00', 'E', 'P', _binary 0x4573746162696c697a61646f204465736c6967616e646f20736f7a696e686f, 'R', NULL),
	(6, 1, 16, 3, NULL, '2024-09-06', '18:21:00', 'E', 'P', _binary 0x7465737465, 'R', NULL),
	(7, 1, 16, 3, NULL, '2024-09-06', '18:22:00', 'A', 'P', _binary 0x4573746162696c697a61646f7220517565696d61646f, 'R', NULL),
	(8, 3, 16, 3, NULL, '2024-09-06', '18:27:00', 'E', 'P', _binary 0x5375706572206171756563696d656e746f2065206465736c6967616e646f, 'R', NULL),
	(9, 1, 16, NULL, 1, '2024-09-06', '23:03:00', 'E', 'P', _binary 0x496e7374616c61c3a7c3a36f206465206e6f7661206573747275747572612064652072656465, 'E', NULL),
	(10, 3, 16, NULL, NULL, '2024-09-06', '23:34:00', 'A', 'P', _binary 0x5472616e73706f727465206465204d65646963616d656e746f2070617261206e6f76612073616c61, 'V', NULL),
	(11, 3, 16, 3, NULL, '2024-09-07', '12:26:00', 'C', 'P', _binary 0x5375706572204171756563696d656e746f, 'R', NULL),
	(12, 1, 16, 1, NULL, '2024-09-08', '11:17:00', 'E', 'U', _binary 0x7465737465, 'R', NULL),
	(13, 3, 16, NULL, NULL, '2024-09-09', '19:52:00', 'A', 'P', _binary 0x496e7374616c61c3a7c3a36f2064652053697374656d61206465204661726dc3a1636961, 'V', NULL),
	(14, 1, 16, 1, NULL, '2024-09-13', '14:26:00', 'A', 'P', _binary 0x746573746520636f6d20656d61696c, 'R', NULL),
	(15, 1, 16, 1, NULL, '2024-09-13', '14:28:00', 'A', 'P', _binary 0x746573746520636f6d20656d61696c, 'R', NULL),
	(16, 1, 16, 1, NULL, '2024-09-13', '14:30:00', 'A', 'P', _binary 0x746573746520636f6d20656d61696c, 'R', NULL),
	(17, 1, 16, 1, NULL, '2024-09-13', '14:31:00', 'A', 'P', _binary 0x746573746520636f6d20656d61696c, 'R', NULL),
	(18, 1, 16, 1, NULL, '2024-09-13', '14:31:00', 'A', 'P', _binary 0x746573746520636f6d20656d61696c, 'R', NULL),
	(19, 1, 16, 1, NULL, '2024-09-13', '14:35:00', 'A', 'P', _binary 0x746573746520646520656d61696c, 'R', NULL),
	(20, 1, 16, 1, NULL, '2024-09-13', '14:46:00', 'A', 'P', _binary 0x746573746520646520656d61696c, 'R', NULL),
	(21, 1, 16, 2, NULL, '2024-09-13', '14:51:00', 'A', 'P', _binary 0x5365727669646f7220636f6d206465666569746f, 'R', NULL),
	(22, 1, 16, 3, NULL, '2024-09-13', '15:02:00', 'A', 'P', _binary 0x4573746162696c697a61646f72206ec3a36f20636f6e736567756520736567757261722074656e73c3a36f206461207265646520656cc3a97472696361, 'R', NULL),
	(23, 1, 16, 1, NULL, '2024-09-13', '15:04:00', 'A', 'P', _binary 0x466f726d617461c3a7c3a36f206520696e7374616c61c3a7c3a36f20646f2077696e646f7773203130, 'R', NULL),
	(24, 1, 16, 1, NULL, '2024-09-13', '15:30:00', 'A', 'P', _binary 0x54726f636120646120666f6e746520646520616c696d656e7461c3a7c3a36f, 'R', NULL),
	(25, 3, 16, 3, NULL, '2024-09-13', '16:29:00', 'E', 'P', _binary 0x7465737465, 'R', NULL);

-- Copiando estrutura para tabela gop.unidades
CREATE TABLE IF NOT EXISTS `unidades` (
  `id` int NOT NULL AUTO_INCREMENT,
  `descricao` varchar(120) NOT NULL DEFAULT '0',
  `abreviatura` varchar(6) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Copiando dados para a tabela gop.unidades: ~6 rows (aproximadamente)
INSERT INTO `unidades` (`id`, `descricao`, `abreviatura`) VALUES
	(1, 'Metro Quadrado', 'M2'),
	(2, 'Centímetro', 'cm'),
	(3, 'Kilo', 'KG'),
	(4, 'Hora', 'H'),
	(5, 'Litro', 'LT'),
	(8, 'Unidade', 'UN'),
	(9, 'Metro Cúbico', 'M3');

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
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Copiando dados para a tabela gop.usuarios: ~3 rows (aproximadamente)
INSERT INTO `usuarios` (`id`, `id_perfil`, `id_setor`, `nome`, `login`, `senha`, `ativo`, `cpf`, `tipo`, `email`) VALUES
	(16, NULL, NULL, 'Glaison Queiroz', 'Glaison', 'dGFpb2JhMjYxMA==', 'S', '695.510.226-53', 'Administrador', 'glaison26.queiroz@gmail.com'),
	(17, NULL, NULL, 'Manoel da Silva Braga', 'ManuelBraga', 'MTIzNDU2ZmRnZGZnc2Y=', 'N', '695.510.226-53', 'Administrador', NULL),
	(19, NULL, NULL, 'Itamar Franco', 'Franco', 'OTk5OTk5OTk5', 'S', '695.510.226-53', 'Administrador', NULL),
	(21, NULL, NULL, 'Manoel de Nobrega', 'Manoel', 'dGFpb2JhMTIz', 'S', '695.510.226-53', 'Operador', 'manoel@gmail.com');

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
