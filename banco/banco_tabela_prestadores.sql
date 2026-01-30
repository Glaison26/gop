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

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
