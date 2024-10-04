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
	(3, 'Informática', '(31) 3672-7688', '(31) 3672-7642', 'Jedean@gmail.com', 'Jedean da Silva'),
	(6, 'Marcenaria 1', NULL, NULL, NULL, NULL),
	(7, 'Alvenaria', NULL, NULL, NULL, NULL),
	(8, 'Equipamentos Médicos', NULL, NULL, NULL, NULL),
	(21, 'Hidráulico', '(31) 3672-7688', '(31) 9984-2655', 'Welligton Jardins', 'suporte@sabara.mg.gov.br');

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
