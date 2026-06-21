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

-- Copiando estrutura para tabela gop.artigos
CREATE TABLE IF NOT EXISTS `artigos` (
  `id` int NOT NULL AUTO_INCREMENT,
  `titulo` varchar(150) DEFAULT NULL,
  `breve_descricao` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `id_categoria` int DEFAULT NULL,
  `tags` varchar(50) DEFAULT NULL,
  `cenario_sitoma` blob,
  `causa_raiz` blob,
  `passo_a_passo` blob,
  `requisitos` varchar(150) DEFAULT NULL,
  `id_autor` int DEFAULT NULL,
  `data_criacao` date DEFAULT NULL,
  `data_atualizacao` date DEFAULT NULL,
  `versao` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_artigos_executores` (`id_autor`),
  KEY `FK_artigos_artigos_categoria` (`id_categoria`),
  CONSTRAINT `FK_artigos_artigos_categoria` FOREIGN KEY (`id_categoria`) REFERENCES `artigos_categoria` (`id`),
  CONSTRAINT `FK_artigos_executores` FOREIGN KEY (`id_autor`) REFERENCES `executores` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Copiando dados para a tabela gop.artigos: ~0 rows (aproximadamente)
INSERT INTO `artigos` (`id`, `titulo`, `breve_descricao`, `id_categoria`, `tags`, `cenario_sitoma`, `causa_raiz`, `passo_a_passo`, `requisitos`, `id_autor`, `data_criacao`, `data_atualizacao`, `versao`) VALUES
	(1, 'Criação de Usuário', 'Criação de Usuário do sistema', 8, 'Usuários', _binary 0x417573656e6369612064652041636573736f, _binary 0x53656d20636164617374726f20706172612061636573736f, NULL, NULL, NULL, NULL, NULL, NULL),
	(3, 'Usuário travado no Aplicativo da Supernova', 'Travamento no sistema moderna', 8, 'moderna', _binary 0x557375c3a172696f207472617661646f206e6f207365727669646f72206461206d6f6465726e61, _binary 0x557375c3a172696f207472617661646f206e6f2073697374656d6120656d20616c67756d612074656c61206f752072656c6174c3b372696f206ec3a36f20616469616e74616e646f20726573657461722061206dc3a17175696e61, _binary 0x456e7472617220656d20636f6e7461746f20636f6d2074c3a9636e69636f7320646120656d7072657361206d6f6465726e612070656c6f2077686174617070206f752074656c65666f6e65, 'Contatos por whatapp com a empresa', 7, '2026-06-21', '2026-06-21', NULL);

-- Copiando estrutura para tabela gop.artigos_categoria
CREATE TABLE IF NOT EXISTS `artigos_categoria` (
  `id` int NOT NULL AUTO_INCREMENT,
  `descricao` varchar(150) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Copiando dados para a tabela gop.artigos_categoria: ~5 rows (aproximadamente)
INSERT INTO `artigos_categoria` (`id`, `descricao`) VALUES
	(1, 'Redes'),
	(2, 'Computadores'),
	(8, 'Aplicativo Moderna (super Nova)');

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
