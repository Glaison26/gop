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

-- Copiando dados para a tabela gop.centrodecusto: ~1 rows (aproximadamente)

-- Copiando estrutura para tabela gop.checklist
CREATE TABLE IF NOT EXISTS `checklist` (
  `id` int NOT NULL AUTO_INCREMENT,
  `descricao` varchar(150) NOT NULL DEFAULT '0',
  `descritivo` blob,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Copiando dados para a tabela gop.checklist: ~0 rows (aproximadamente)

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

-- Copiando dados para a tabela gop.espacos: ~0 rows (aproximadamente)

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

-- Copiando estrutura para tabela gop.ocorrencias
CREATE TABLE IF NOT EXISTS `ocorrencias` (
  `id` int NOT NULL AUTO_INCREMENT,
  `descricao` varchar(150) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Copiando dados para a tabela gop.ocorrencias: ~0 rows (aproximadamente)

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

-- Copiando dados para a tabela gop.oficinas: ~5 rows (aproximadamente)
INSERT INTO `oficinas` (`id`, `descricao`, `fone1`, `fone2`, `email`, `responsavel`) VALUES
	(1, 'Elétrica', '(31) 3672-7688', '(31) 9988-3883', 'eletrica@gmail.com', 'Israel'),
	(2, 'Eletrônica', '(31) 3672-7688', '(31) 9984-2655', 'glaison26.queiroz@gmail.com', 'Glaison'),
	(3, 'Informática', '(31) 3672-7688', '(31) 3672-7642', 'Jedean@gmail.com', 'Jedean da Silva'),
	(8, 'Equipamentos Médicos', '(31) 3672-7688', '(31) 9984-2655', 'glaison26.queiroz@gmail.com', 'Homero'),
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
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

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

-- Copiando dados para a tabela gop.ordens_imagens: ~2 rows (aproximadamente)
INSERT INTO `ordens_imagens` (`id`, `id_ordem`, `caminho`, `data`, `comentario`) VALUES
	(3, 38, 'img/computador.jpeg', '2024-10-04', 'Primeira manutenção do equipamento'),
	(4, 38, 'img/placamae.jpeg', '2024-10-04', 'Imagem da placa mãe');

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

-- Copiando dados para a tabela gop.recursos: ~1 rows (aproximadamente)

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Copiando dados para a tabela gop.solicitacao: ~0 rows (aproximadamente)

-- Copiando estrutura para tabela gop.unidades
CREATE TABLE IF NOT EXISTS `unidades` (
  `id` int NOT NULL AUTO_INCREMENT,
  `descricao` varchar(120) NOT NULL DEFAULT '0',
  `abreviatura` varchar(6) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Copiando dados para a tabela gop.unidades: ~8 rows (aproximadamente)
INSERT INTO `unidades` (`id`, `descricao`, `abreviatura`) VALUES
	(1, 'Metro Quadrado', 'M2'),
	(2, 'Centímetro', 'cm'),
	(3, 'Kilo', 'KG'),
	(4, 'Hora', 'H'),
	(5, 'Litro', 'LT'),
	(8, 'Unidade', 'UN'),
	(9, 'Metro Cúbico', 'M3'),
	(10, 'Metro', 'm');

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
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Copiando dados para a tabela gop.usuarios: ~6 rows (aproximadamente)
INSERT INTO `usuarios` (`id`, `id_perfil`, `id_setor`, `nome`, `login`, `senha`, `ativo`, `cpf`, `tipo`, `email`) VALUES
	(16, NULL, NULL, 'Glaison Queiroz', 'Glaison', 'dGFpb2JhMjYxMA==', 'S', '695.510.226-53', 'Administrador', 'glaison26.queiroz@gmail.com'),
	(17, NULL, NULL, 'Manoel da Silva Braga', 'ManuelBraga', 'MTIzNDU2ZmRnZGZnc2Y=', 'N', '695.510.226-53', 'Administrador', NULL),
	(19, NULL, NULL, 'Itamar Franco', 'Franco', 'OTk5OTk5OTk5', 'S', '695.510.226-53', 'Administrador', NULL),
	(21, NULL, NULL, 'Manoel de Nobrega', 'Manoel', 'dGFpb2JhMTIz', 'S', '695.510.226-53', 'Operador', 'manoel@gmail.com'),
	(22, NULL, NULL, 'Solicitante', 'Solicitante', 'MTIzNDU2Nzg=', 'S', '69551022653', 'Solicitante', 'glaison26.queiroz@gmail.com'),
	(23, NULL, NULL, 'Adm', 'Adm', 'MTIzNDU2Nzg=', 'S', '69551022653', 'Administrador', 'glaison26.queiroz@gmail.com');

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
