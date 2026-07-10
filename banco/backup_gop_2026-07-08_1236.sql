-- MySQL dump 10.13  Distrib 8.0.30, for Win64 (x86_64)
--
-- Host: localhost    Database: gop
-- ------------------------------------------------------
-- Server version	8.0.30

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Current Database: `gop`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `gop` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;

USE `gop`;

--
-- Table structure for table `anexos`
--

DROP TABLE IF EXISTS `anexos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `anexos` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_solicitacao` int DEFAULT NULL,
  `id_usuario` int DEFAULT NULL,
  `data` date DEFAULT NULL,
  `hora` time DEFAULT NULL,
  `arquivo` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `FK_anexos_solicitacao` (`id_solicitacao`) USING BTREE,
  KEY `FK_anexos_usuarios` (`id_usuario`) USING BTREE,
  CONSTRAINT `FK_anexos_solicitacao` FOREIGN KEY (`id_solicitacao`) REFERENCES `solicitacao` (`id`),
  CONSTRAINT `FK_anexos_usuarios` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `anexos`
--

LOCK TABLES `anexos` WRITE;
/*!40000 ALTER TABLE `anexos` DISABLE KEYS */;
INSERT INTO `anexos` VALUES (6,183,22,'2026-05-18','12:51:59','uploads/anexos/1779108719_CNDFGTSCNPJ0001-86-Vencimento22-04-2026.pdf'),(8,204,37,'2026-05-25','13:35:24','uploads/anexos/1779716124_ERROSUPERNOVA.pdf'),(9,238,43,'2026-06-08','17:08:09','uploads/anexos/1780938489_WhatsAppImage2026-06-08at13.58.37.jpeg'),(10,240,43,'2026-06-09','12:40:01','uploads/anexos/1781008801_WhatsAppImage2026-06-09at09.31.55.jpeg'),(11,269,22,'2026-06-16','13:22:32','uploads/anexos/1781616152_CNDEstadualSCCNPJ0001-86-Vencimento11-06-2026.pdf'),(12,274,22,'2026-06-16','18:15:19','uploads/anexos/1781633719_CNDEstadualSCCNPJ0001-86-Vencimento11-06-2026.pdf'),(13,276,22,'2026-06-17','17:24:49','uploads/anexos/1781717089_CNDEstadualSCCNPJ0001-86-Vencimento11-06-2026.pdf'),(14,280,39,'2026-06-23','12:19:17','uploads/anexos/1782217157_WhatsAppImage2026-06-23at09.15.35.jpeg'),(15,294,49,'2026-06-23','17:48:14','uploads/anexos/1782236894_INFORMATICA.pdf'),(16,297,22,'2026-06-24','12:21:12','uploads/anexos/1782303672_INFORMATICA.pdf'),(17,301,22,'2026-06-25','13:44:03','uploads/anexos/1782395043_edital-002-2026.pdf'),(18,337,49,'2026-07-08','14:36:08','uploads/anexos/1783521368_WhatsAppImage2026-07-08at11.30.50.jpeg'),(19,337,49,'2026-07-08','14:36:27','uploads/anexos/1783521387_WhatsAppImage2026-07-08at11.30.50.jpeg');
/*!40000 ALTER TABLE `anexos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `artigos`
--

DROP TABLE IF EXISTS `artigos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `artigos` (
  `id` int NOT NULL AUTO_INCREMENT,
  `titulo` varchar(150) DEFAULT NULL,
  `breve_descricao` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `id_categoria` int DEFAULT NULL,
  `id_subcategoria` int DEFAULT NULL,
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
  KEY `FK_artigos_artigos_subcategoria` (`id_subcategoria`),
  CONSTRAINT `FK_artigos_artigos_categoria` FOREIGN KEY (`id_categoria`) REFERENCES `artigos_categoria` (`id`),
  CONSTRAINT `FK_artigos_artigos_subcategoria` FOREIGN KEY (`id_subcategoria`) REFERENCES `artigos_subcategoria` (`id`),
  CONSTRAINT `FK_artigos_executores` FOREIGN KEY (`id_autor`) REFERENCES `executores` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `artigos`
--

LOCK TABLES `artigos` WRITE;
/*!40000 ALTER TABLE `artigos` DISABLE KEYS */;
/*!40000 ALTER TABLE `artigos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `artigos_categoria`
--

DROP TABLE IF EXISTS `artigos_categoria`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `artigos_categoria` (
  `id` int NOT NULL AUTO_INCREMENT,
  `descricao` varchar(150) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `artigos_categoria`
--

LOCK TABLES `artigos_categoria` WRITE;
/*!40000 ALTER TABLE `artigos_categoria` DISABLE KEYS */;
INSERT INTO `artigos_categoria` VALUES (1,'Rede'),(2,'Computadores');
/*!40000 ALTER TABLE `artigos_categoria` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `centrodecusto`
--

DROP TABLE IF EXISTS `centrodecusto`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `centrodecusto` (
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
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `centrodecusto`
--

LOCK TABLES `centrodecusto` WRITE;
/*!40000 ALTER TABLE `centrodecusto` DISABLE KEYS */;
INSERT INTO `centrodecusto` VALUES (5,'Modelo',NULL,5,'','','','','(41) 23442-3424','','','modelo',0),(6,'Prefeitura Municipal de Sabará',NULL,6,'','','','','','','','pms',0);
/*!40000 ALTER TABLE `centrodecusto` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `checklist`
--

DROP TABLE IF EXISTS `checklist`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `checklist` (
  `id` int NOT NULL AUTO_INCREMENT,
  `descricao` varchar(150) NOT NULL DEFAULT '0',
  `descritivo` blob,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `checklist`
--

LOCK TABLES `checklist` WRITE;
/*!40000 ALTER TABLE `checklist` DISABLE KEYS */;
/*!40000 ALTER TABLE `checklist` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `compras`
--

DROP TABLE IF EXISTS `compras`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `compras` (
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
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `compras`
--

LOCK TABLES `compras` WRITE;
/*!40000 ALTER TABLE `compras` DISABLE KEYS */;
INSERT INTO `compras` VALUES (1,4,'2026-05-08','Operacionais','0000','0000','2026-05-08','0000','000',0,'C','M','Entrada de Tonner',0,NULL,''),(2,4,'2026-05-11','Operacionais','0','0','2026-05-11','0','0',0,'C','M','Toner colorido para impressora',0,NULL,''),(3,4,'2026-05-18','Avulsas Internas','0','0','2026-05-18','0','0',0,'C','M','Tonner para impressoras',0,NULL,''),(6,4,'2026-05-25','Operacionais','0','0','2026-05-25','0','0',0,'C','M','Tonner Colorido',0,NULL,''),(7,4,'2026-06-29','Avulsas Internas','','0','2026-06-29','-','0',0,'C','M','Tonner C2000',0,NULL,''),(8,4,'2026-07-06','Operacionais','26099','-','2026-07-06','-','-',0,'C','M','Entrada de Tonner',0,NULL,'');
/*!40000 ALTER TABLE `compras` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `compras_materiais`
--

DROP TABLE IF EXISTS `compras_materiais`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `compras_materiais` (
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
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `compras_materiais`
--

LOCK TABLES `compras_materiais` WRITE;
/*!40000 ALTER TABLE `compras_materiais` DISABLE KEYS */;
INSERT INTO `compras_materiais` VALUES (4,3,4,8,2,15,30,NULL,1,NULL,NULL),(5,3,3,8,2,20,40,NULL,1,NULL,NULL),(6,3,2,8,10,17,170,NULL,1,NULL,NULL),(7,1,4,8,1,0,0,NULL,1,'S','S'),(8,2,5,8,2,0,0,NULL,1,'S','S'),(9,2,4,8,2,0,0,NULL,1,'S','S'),(10,3,5,8,2,0,0,NULL,1,'S','S'),(11,3,6,8,2,0,0,NULL,1,'S','S'),(12,3,7,8,4,0,0,NULL,1,'S','S'),(13,6,5,8,6,0,0,NULL,1,'S','S'),(14,6,6,8,6,0,0,NULL,1,'S','S'),(15,6,7,8,4,0,0,NULL,1,'S','S'),(16,6,4,8,6,0,0,NULL,1,'S','S'),(17,7,4,8,3,0,0,NULL,1,'S','S'),(18,7,5,8,3,0,0,NULL,1,'S','S'),(19,7,7,8,3,0,0,NULL,1,'S','S'),(20,7,6,8,3,0,0,NULL,1,'S','S'),(21,8,8,8,6,0,0,NULL,1,'S','S');
/*!40000 ALTER TABLE `compras_materiais` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `configuracoes`
--

DROP TABLE IF EXISTS `configuracoes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `configuracoes` (
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
  `filtra_por_executor` char(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `configuracoes`
--

LOCK TABLES `configuracoes` WRITE;
/*!40000 ALTER TABLE `configuracoes` DISABLE KEYS */;
INSERT INTO `configuracoes` VALUES (1,'Prefeitura Municipal de Sabará','22886816000105','Glaison','(31) 3672-7688','(31) 2121-2223','sabara.mg.gov.br','suporte@sabara.mg.gov.br','manutencao@sabara.mg.gov.br','glaison@sabara.mg.gov.br','gop.servicos.gop@gmail.com','smtp.gmail.com','465','laeo mhep ampd bdei','N','N','S',5,'N');
/*!40000 ALTER TABLE `configuracoes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `contratos`
--

DROP TABLE IF EXISTS `contratos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `contratos` (
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
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `contratos`
--

LOCK TABLES `contratos` WRITE;
/*!40000 ALTER TABLE `contratos` DISABLE KEYS */;
/*!40000 ALTER TABLE `contratos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `contratos_lancamentos`
--

DROP TABLE IF EXISTS `contratos_lancamentos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `contratos_lancamentos` (
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
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `contratos_lancamentos`
--

LOCK TABLES `contratos_lancamentos` WRITE;
/*!40000 ALTER TABLE `contratos_lancamentos` DISABLE KEYS */;
/*!40000 ALTER TABLE `contratos_lancamentos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `contratos_parametros`
--

DROP TABLE IF EXISTS `contratos_parametros`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `contratos_parametros` (
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
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `contratos_parametros`
--

LOCK TABLES `contratos_parametros` WRITE;
/*!40000 ALTER TABLE `contratos_parametros` DISABLE KEYS */;
/*!40000 ALTER TABLE `contratos_parametros` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cotacao`
--

DROP TABLE IF EXISTS `cotacao`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cotacao` (
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
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cotacao`
--

LOCK TABLES `cotacao` WRITE;
/*!40000 ALTER TABLE `cotacao` DISABLE KEYS */;
/*!40000 ALTER TABLE `cotacao` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cotacao_fornecedor`
--

DROP TABLE IF EXISTS `cotacao_fornecedor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cotacao_fornecedor` (
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
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cotacao_fornecedor`
--

LOCK TABLES `cotacao_fornecedor` WRITE;
/*!40000 ALTER TABLE `cotacao_fornecedor` DISABLE KEYS */;
/*!40000 ALTER TABLE `cotacao_fornecedor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cotacao_materiais`
--

DROP TABLE IF EXISTS `cotacao_materiais`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cotacao_materiais` (
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
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cotacao_materiais`
--

LOCK TABLES `cotacao_materiais` WRITE;
/*!40000 ALTER TABLE `cotacao_materiais` DISABLE KEYS */;
/*!40000 ALTER TABLE `cotacao_materiais` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cotacao_materiais_fornecedor`
--

DROP TABLE IF EXISTS `cotacao_materiais_fornecedor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cotacao_materiais_fornecedor` (
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
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cotacao_materiais_fornecedor`
--

LOCK TABLES `cotacao_materiais_fornecedor` WRITE;
/*!40000 ALTER TABLE `cotacao_materiais_fornecedor` DISABLE KEYS */;
/*!40000 ALTER TABLE `cotacao_materiais_fornecedor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cotacao_servicos`
--

DROP TABLE IF EXISTS `cotacao_servicos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cotacao_servicos` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_cotacao` int DEFAULT NULL,
  `descricao` blob,
  PRIMARY KEY (`id`),
  KEY `FK_cotacao_servicos_cotacao` (`id_cotacao`),
  CONSTRAINT `FK_cotacao_servicos_cotacao` FOREIGN KEY (`id_cotacao`) REFERENCES `cotacao` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cotacao_servicos`
--

LOCK TABLES `cotacao_servicos` WRITE;
/*!40000 ALTER TABLE `cotacao_servicos` DISABLE KEYS */;
/*!40000 ALTER TABLE `cotacao_servicos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cotacao_servicos_fornecedores`
--

DROP TABLE IF EXISTS `cotacao_servicos_fornecedores`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cotacao_servicos_fornecedores` (
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
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cotacao_servicos_fornecedores`
--

LOCK TABLES `cotacao_servicos_fornecedores` WRITE;
/*!40000 ALTER TABLE `cotacao_servicos_fornecedores` DISABLE KEYS */;
INSERT INTO `cotacao_servicos_fornecedores` VALUES (2,3,2,4,50,1,'2024-10-31'),(3,3,1,6,65,NULL,'2024-11-07');
/*!40000 ALTER TABLE `cotacao_servicos_fornecedores` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `diretriz_estrategia`
--

DROP TABLE IF EXISTS `diretriz_estrategia`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `diretriz_estrategia` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_estrategia` int DEFAULT NULL,
  `id_diretriz` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK__estrategias` (`id_estrategia`),
  KEY `FK__diretrizes` (`id_diretriz`),
  CONSTRAINT `FK__diretrizes` FOREIGN KEY (`id_diretriz`) REFERENCES `diretrizes` (`id`),
  CONSTRAINT `FK__estrategias` FOREIGN KEY (`id_estrategia`) REFERENCES `estrategias` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `diretriz_estrategia`
--

LOCK TABLES `diretriz_estrategia` WRITE;
/*!40000 ALTER TABLE `diretriz_estrategia` DISABLE KEYS */;
INSERT INTO `diretriz_estrategia` VALUES (1,1,2),(2,2,4);
/*!40000 ALTER TABLE `diretriz_estrategia` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `diretrizes`
--

DROP TABLE IF EXISTS `diretrizes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `diretrizes` (
  `id` int NOT NULL AUTO_INCREMENT,
  `descricao` varchar(150) NOT NULL DEFAULT '',
  `texto` blob,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `diretrizes`
--

LOCK TABLES `diretrizes` WRITE;
/*!40000 ALTER TABLE `diretrizes` DISABLE KEYS */;
INSERT INTO `diretrizes` VALUES (2,'PLANEJAMENTO OPERACIONAL DE SERVIÇOS E OBRAS',_binary 'Planejamento Operacional de Serviços e obras'),(4,'Planejamento para Aquisição de Novos Servidores',_binary 'Aquisição de novos servidores para serem\nutilizados no  armazenamento de arquivos da rede'),(5,'Planejamento para Instalação de novos servidores',_binary 'Planejamento para Instalação de\n novos servidores');
/*!40000 ALTER TABLE `diretrizes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `enderecos`
--

DROP TABLE IF EXISTS `enderecos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `enderecos` (
  `id` int NOT NULL AUTO_INCREMENT,
  `logradouro` varchar(220) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `numero` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `usuario_id` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `enderecos`
--

LOCK TABLES `enderecos` WRITE;
/*!40000 ALTER TABLE `enderecos` DISABLE KEYS */;
INSERT INTO `enderecos` VALUES (1,'Avenida Winston Churchill','936',1),(2,'Avenida Winston Churchill','936',2),(3,'Avenida Winston Churchill','936',3),(4,'Avenida Winston Churchill','936',4),(5,'Avenida Winston Churchill','936',5),(6,'Avenida Winston Churchill','936',6),(7,'Avenida Winston Churchill','936',7),(8,'Avenida Winston Churchill','936',8),(9,'Avenida Winston Churchill','936',9),(10,'Avenida Winston Churchill','936',10),(11,'Avenida Winston Churchill','936',11),(12,'Avenida Winston Churchill','936',12),(13,'Avenida Winston Churchill','936',13),(14,'Avenida Winston Churchill','936',14),(15,'Avenida Winston Churchill','936',15);
/*!40000 ALTER TABLE `enderecos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `espacos`
--

DROP TABLE IF EXISTS `espacos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `espacos` (
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
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `espacos`
--

LOCK TABLES `espacos` WRITE;
/*!40000 ALTER TABLE `espacos` DISABLE KEYS */;
INSERT INTO `espacos` VALUES (6,'Prefeitura Municipal de Sabará','Instalação','','Rua Comendador Viana 122','--','--','34505480','Glaison','teste@gmail.com','','');
/*!40000 ALTER TABLE `espacos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `estrategias`
--

DROP TABLE IF EXISTS `estrategias`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `estrategias` (
  `id` int NOT NULL AUTO_INCREMENT,
  `descricao` varchar(150) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `estrategias`
--

LOCK TABLES `estrategias` WRITE;
/*!40000 ALTER TABLE `estrategias` DISABLE KEYS */;
INSERT INTO `estrategias` VALUES (1,'Estrategia I'),(2,'Estratégia II');
/*!40000 ALTER TABLE `estrategias` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `executores`
--

DROP TABLE IF EXISTS `executores`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `executores` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_oficina` int DEFAULT NULL,
  `id_funcao` int DEFAULT NULL,
  `id_usuario` int DEFAULT NULL,
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
  KEY `FK_executores_usuarios` (`id_usuario`),
  CONSTRAINT `FK_executores_funcoes` FOREIGN KEY (`id_funcao`) REFERENCES `funcoes` (`id`),
  CONSTRAINT `FK_executores_oficinas` FOREIGN KEY (`id_oficina`) REFERENCES `oficinas` (`id`),
  CONSTRAINT `FK_executores_usuarios` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `executores`
--

LOCK TABLES `executores` WRITE;
/*!40000 ALTER TABLE `executores` DISABLE KEYS */;
INSERT INTO `executores` VALUES (7,1,16,16,'Glaison Queiroz','Rua da Intendencia 316','Centro','34505480','Sabará','MG','','F','695.510.226-53','','','(31) 3672-7688','','',0,0,0,'Primário','','','Sim'),(8,26,8,26,'Jerônimo Mayer dos Santos','Rua Marques de Sapucai,179','Centro','34505480','Sabará','MG','','F','79017711604','manutencao@sabara.mg.gov.br','','(31) 3672-7688','','',0,0,0,'Primário','','','Sim'),(9,27,8,29,'Wellington Alves Jardim da Silva','Rua Comendador Viana 122','Centro','34505480','Sabará','MG','','F','790.177.116-04','manutencao@sabara.mg.gov.br','','(31) 3672-7688','','',0,0,0,'Primário','','','Sim'),(10,26,8,27,'Edilson Fernandes da Cruz','Rua Marques de Sapucai,179','Centro','34505480','Sabará','MG','','F','073.641.816-44','manutencao@sabara.mg.gov.br','','(31) 3672-7688','','',0,0,0,'Primário','','','Sim'),(11,1,8,28,'Jedean Moisés do Carmo','Rua Marques de Sapucaí 197','Centro','34505480','Sabará','MG','','F','040.710.556-50','jedean@sabara.mg.gov.br','','(31) 3672-7688','','',0,0,0,'Primário','','','Sim'),(12,26,8,30,'Lucio Machado','Rua Marques de Sapucai,179','Centro','34505480','Sabará','MG','','F','031.532.486-48','manutencao@sabara.mg.gov.br','','(31) 3672-7688','','',0,0,0,'Primário','','','Sim'),(13,26,17,35,'Ruan Pablo Alves do Espirito Santo','-','-','-','-','MG','','F','695.510.226-53','','','(31) 3672-7688','','',0,0,0,'Primário','','','Sim'),(14,26,17,50,'Pedro Reis','Rua Marquês de Sapucaí, 317 – Centro, Sabará – MG','Centro','34505480','Sabará','MG','Pedro Reis','F','695.510.226-53','manutencao@sabara.mg.gov.br','','(31) 3672-7688','','',0,0,0,'','','','Sim');
/*!40000 ALTER TABLE `executores` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fabricantes`
--

DROP TABLE IF EXISTS `fabricantes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `fabricantes` (
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
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fabricantes`
--

LOCK TABLES `fabricantes` WRITE;
/*!40000 ALTER TABLE `fabricantes` DISABLE KEYS */;
INSERT INTO `fabricantes` VALUES (5,'Dell','Dell Computadores','Física','','','','','MG','695.510.226-53','','','','','Glaison','','',''),(6,'Lenovo','Lenovo','Juridica','','','','','MG','../-','','','','','','','',''),(7,'Positivo','Positivo','Juridica','','','','','MG','../-','','','','','','','',''),(8,'Acer','Acer','Juridica','','','','','MG','../-','','','','','','','',''),(9,'HP','HP','Juridica','','','','','MG','../-','','','','','','','',''),(10,'GigaByte','GigaByte','Juridica','','','','','MG','../-','','','','','','','',''),(11,'Samsung','Samsung','Juridica','','','','','MG','../-','','','','','','','',''),(12,'Sony Vaio','Sony Vaio','Juridica','','','','','MG','../-','','','','','','','','');
/*!40000 ALTER TABLE `fabricantes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ferramentas`
--

DROP TABLE IF EXISTS `ferramentas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ferramentas` (
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
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ferramentas`
--

LOCK TABLES `ferramentas` WRITE;
/*!40000 ALTER TABLE `ferramentas` DISABLE KEYS */;
/*!40000 ALTER TABLE `ferramentas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fornecedores`
--

DROP TABLE IF EXISTS `fornecedores`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `fornecedores` (
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
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fornecedores`
--

LOCK TABLES `fornecedores` WRITE;
/*!40000 ALTER TABLE `fornecedores` DISABLE KEYS */;
INSERT INTO `fornecedores` VALUES (3,3,'Fornecedor de Computadores','Fornecedor de Computadores','695.510.226-53','','','Física','','','','','MG','(31) 98426-2508','','','','Glaison',''),(4,3,'SELBETTI GESTÃO DE DOCUMENTOS S.A.','SELBETTI GESTÃO DE DOCUMENTOS S.A.','83..48.3.2/30.0-00','','','Juridica','','','','','MG','(31) 3672-7688','','','','Eliezer','');
/*!40000 ALTER TABLE `fornecedores` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `funcoes`
--

DROP TABLE IF EXISTS `funcoes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `funcoes` (
  `id` int NOT NULL AUTO_INCREMENT,
  `descricao` varchar(120) NOT NULL,
  `ValorHora` double DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `funcoes`
--

LOCK TABLES `funcoes` WRITE;
/*!40000 ALTER TABLE `funcoes` DISABLE KEYS */;
INSERT INTO `funcoes` VALUES (8,'Supervisor de Sistemas',0),(9,'Técnico em Eletrônica',0),(10,'Técnico em Informática',0),(16,'Programador de Sistemas',0),(17,'Estagiário',0);
/*!40000 ALTER TABLE `funcoes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `grupos`
--

DROP TABLE IF EXISTS `grupos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `grupos` (
  `id` int NOT NULL AUTO_INCREMENT,
  `descricao` varchar(120) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `grupos`
--

LOCK TABLES `grupos` WRITE;
/*!40000 ALTER TABLE `grupos` DISABLE KEYS */;
INSERT INTO `grupos` VALUES (13,'Insumos de Informática');
/*!40000 ALTER TABLE `grupos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `grupos_fornecedores`
--

DROP TABLE IF EXISTS `grupos_fornecedores`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `grupos_fornecedores` (
  `id` int NOT NULL AUTO_INCREMENT,
  `descricao` varchar(140) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `grupos_fornecedores`
--

LOCK TABLES `grupos_fornecedores` WRITE;
/*!40000 ALTER TABLE `grupos_fornecedores` DISABLE KEYS */;
INSERT INTO `grupos_fornecedores` VALUES (1,'Material de Construção'),(2,'Materiais Elétricos'),(3,'Equipamentos de Informática');
/*!40000 ALTER TABLE `grupos_fornecedores` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `marcas`
--

DROP TABLE IF EXISTS `marcas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `marcas` (
  `id` int NOT NULL AUTO_INCREMENT,
  `descricao` varchar(120) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=116 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `marcas`
--

LOCK TABLES `marcas` WRITE;
/*!40000 ALTER TABLE `marcas` DISABLE KEYS */;
INSERT INTO `marcas` VALUES (99,'Dell'),(100,'Positivo'),(101,'Acer'),(102,'HP'),(103,'RICOH'),(104,'Samsung'),(105,'IntelBras'),(106,'Compaq'),(107,'Toshiba'),(108,'Epson'),(109,'Apple'),(110,'Lenovo'),(111,'ASUS'),(112,'LG'),(113,'Multilazer'),(114,'VAIO'),(115,'GIGABYTE');
/*!40000 ALTER TABLE `marcas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `materiais`
--

DROP TABLE IF EXISTS `materiais`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `materiais` (
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
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `materiais`
--

LOCK TABLES `materiais` WRITE;
/*!40000 ALTER TABLE `materiais` DISABLE KEYS */;
INSERT INTO `materiais` VALUES (4,'Toner Ricoh C2000 Preto',13,103,0,2,4,8,8,1,'2026-04-27','2026-06-29','2026-04-27',9,_binary '   '),(5,'Toner Ricoh C2000 Amarelo',13,103,0,2,4,8,8,1,'2026-04-27','2026-06-29','2026-04-27',13,_binary ' '),(6,'Toner Ricoh C2000 Ciano',13,103,0,2,4,8,8,1,'2026-04-27','2026-06-29','2026-04-27',12,_binary '  '),(7,'Toner Ricoh C2000 Margenta',13,103,0,2,4,8,8,1,'2026-04-27','2026-06-29','2026-04-27',8,_binary '  '),(8,'Ricoh IM 430 Preto',13,103,0,4,40,8,8,1,'2026-04-27','2026-07-06','2026-04-27',22,_binary '   '),(9,'Toner 311 cp Preto',13,103,0,2,10,8,8,1,'2026-04-28','2026-04-28','2026-04-28',2,_binary '  '),(10,'Toner 601 / 501 Preto',13,103,0,2,10,8,8,1,'2026-04-28','2026-04-28','2026-04-28',3,_binary '   ');
/*!40000 ALTER TABLE `materiais` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mensagens`
--

DROP TABLE IF EXISTS `mensagens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `mensagens` (
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
) ENGINE=InnoDB AUTO_INCREMENT=40 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mensagens`
--

LOCK TABLES `mensagens` WRITE;
/*!40000 ALTER TABLE `mensagens` DISABLE KEYS */;
INSERT INTO `mensagens` VALUES (2,66,16,_binary 'teste','0','2026-04-03','09:59:24','N'),(3,138,16,_binary 'teste','0','2026-05-08','14:48:37','N'),(4,138,16,_binary 'teste','0','2026-05-08','14:58:06','N'),(5,178,16,_binary 'Favor enviar Oficio com solicitação de Nova Impressora. O oficio deve conter a necessitada para a locação de nova impressora. \r\nApós a formalização do mesmo iremos repassar para secretaria de planejamento que aprova o não o pedido','0','2026-05-15','11:48:58','N'),(6,183,22,_binary 'você esqueceu de preenche ro cpf','1','2026-05-18','09:49:26','N'),(7,197,16,_binary 'Bom dia,\r\n\r\nFoi pedido redefinicção de pasta do usuário. O usuário natalya.duarte já se encontra-se cadastrado na rede na pasta do juridico. Ela não está conseguindo acessar?. Glaison Queiroz','0','2026-05-21','10:04:06','N'),(8,198,16,_binary 'A respeito da solicitação não está abrindo um arquivo especifico ou qualquer arquivo?','0','2026-05-21','10:39:51','N'),(9,235,16,_binary 'Boa tarde\r\n\r\nRecebemos solicitação de manutenção de cabo de rede na solicitação de serviço no. 235. Gostaria de saber a metragem para confecção de um novo\r\n\r\nGlaison Queiroz','0','2026-06-08','13:55:44','N'),(10,238,16,_binary 'Olá. sobre o e-mail ele tá pedindo authenticação no celular. Abra o microsoft authenticator no celular que está instalado e vinculado o e-mail e dê autorização','0','2026-06-08','14:14:30','N'),(11,238,43,_binary 'Prezado, ela não tem acesso a esse telefone pra onde foi encaminhada a autenticação. Como proceder?','1','2026-06-08','14:31:39','N'),(12,238,16,_binary 'Tenho que zerar o telefone aqui e instalar em outro aparelho. Todos os e-mails da prefeitura tem que estar vinculados a algum telefone.\r\nPosso zerar? \r\nGlaison','0','2026-06-08','14:33:55','N'),(13,260,16,_binary 'Sobre a solicitação de serviço número 260 está havendo uma manutenção da cemig nos postes da região e alguns lugares estão sem internet / telefonenia, deve voltar gradualmente o sinal','0','2026-06-12','10:19:46','N'),(14,261,16,_binary 'Sabe a metragem do Cabo?','0','2026-06-12','14:05:27','N'),(15,264,32,_binary 'Glayson, bom dia.\r\n\r\nContinuo sem conseguir acessar o super nova, mesmo apos a troca da senha. \r\nEsta aparecendo uma mensagem que teve muitas tentativas. \r\nPode me ajudar?','1','2026-06-15','11:39:35','N'),(16,264,16,_binary 'Tenta novamente por favor','0','2026-06-15','11:42:38','N'),(17,269,22,_binary 'Cpf veio incorreto','1','2026-06-16','10:21:49','N'),(18,274,22,_binary 'esse e-mail ja','1','2026-06-16','15:14:40','N'),(19,275,30,_binary 'Tentei atualizar os drivers do pc, configurar msconfig e excluir arquivos temporários para deixar o pc \"mais rápido\". Infelizmente sem resultado satisfatório.\r\nFiz cópia dos arquivos e, ao reiniciar o pc, as atualizações baixadas começaram a ser executadas. \r\nAgora estou aguardando o término dessa etapa, para poder ver nas configurações do Painel de Controle se há programas específicos a serem reinstalados.','0','2026-06-17','12:46:49','N'),(20,277,48,_binary 'O nome do usuário foi passado errado, o nome correto é iara.lopes','1','2026-06-17','14:57:04','N'),(21,280,16,_binary 'Boa tarde. Não temos estabilizador no momento. Tem como anexar foto da saida cabo de força para ver o padrão?','0','2026-06-18','14:08:39','N'),(22,284,48,_binary 'Poderiam em informar o usuário de acesso a rede da Poliana?','1','2026-06-19','11:43:28','N'),(23,284,16,_binary 'usuário de rede ->poliana.martins','0','2026-06-19','11:50:24','N'),(24,291,27,_binary 'Ola, enviar o computador para o setor de Informática, na Sede Administrativa.','0','2026-06-23','09:49:34','N'),(25,280,39,_binary 'Foi informado para o servidor que veio atender a solicitação o local do servidor, e enviado uma foto por aqui da saida de internet','1','2026-06-23','16:54:45','N'),(26,297,22,_binary 'Cpf inválido favor enviar o correto','1','2026-06-24','09:20:08','N'),(27,280,39,_binary 'o servidor Alvin Starlink, está precisando apenas da internet, já conseguiu as outras coisas, e está como cabo de internet, porém a mesma não está funcionando, precisando no momento apenas da liberação da rede','1','2026-06-24','13:36:38','N'),(28,280,16,_binary 'Segundo o Lucio que eteve ai ,o problema é no swich de rede que não tem mais portas funcionando para incluir outro computador para acessar rede e internet','0','2026-06-24','14:21:30','N'),(29,303,16,_binary 'Foi aberta Ordem de serviço na selbetti para manutenção do equipamento','0','2026-06-26','11:43:31','N'),(30,306,16,_binary 'Qual computador não está conseguindo imprimir','0','2026-06-29','09:03:41','N'),(31,322,16,_binary 'No momento infelizmente não temos nenhum mouse para reposição.','0','2026-07-03','09:49:08','N'),(32,324,16,_binary 'Usuário de Rede?','0','2026-07-03','10:55:00','N'),(33,327,16,_binary 'Qual Usuário?','0','2026-07-06','08:54:45','N'),(34,331,42,_binary 'Gentileza acrescentar:  DF SECRETARIA MUNCIPAL DE DEFESA SOCIAL','1','2026-07-06','13:51:15','N'),(35,331,16,_binary 'Secretaria foi acrescentada no seu usuário','0','2026-07-06','13:53:52','N'),(36,333,16,_binary 'Foi aberto como formatação de computador e não é essa a ocorrência. Quanto não tiver tipo da ocorrência desejada abra como \"outros\" e descreva o problema. obrigado','0','2026-07-07','09:09:57','N'),(37,334,16,_binary 'Não há nenhum problema no usuário. O problema deve estar na máquina ou cabeamento de rede. Já checaram os cabos?','0','2026-07-07','14:50:27','N'),(38,334,40,_binary 'Imaginei mesmo, porém, realizei a checagem do cabo para analisar se estava bem conectado, e aparentemente deu sinal.','1','2026-07-07','16:21:07','N'),(39,334,16,_binary 'O pessoal vai ai porque o usuário aqui entrou normalmente','0','2026-07-07','16:47:39','N');
/*!40000 ALTER TABLE `mensagens` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `obra`
--

DROP TABLE IF EXISTS `obra`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `obra` (
  `id` int NOT NULL AUTO_INCREMENT,
  `descricao` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `observacao` blob,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `obra`
--

LOCK TABLES `obra` WRITE;
/*!40000 ALTER TABLE `obra` DISABLE KEYS */;
INSERT INTO `obra` VALUES (6,'Revitalização de fachada',_binary 'Revitalização da fachada principal do prédio');
/*!40000 ALTER TABLE `obra` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `obras_grupo`
--

DROP TABLE IF EXISTS `obras_grupo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `obras_grupo` (
  `id` int NOT NULL AUTO_INCREMENT,
  `descricao` varchar(150) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `obras_grupo`
--

LOCK TABLES `obras_grupo` WRITE;
/*!40000 ALTER TABLE `obras_grupo` DISABLE KEYS */;
INSERT INTO `obras_grupo` VALUES (1,'Marcenaria');
/*!40000 ALTER TABLE `obras_grupo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `obras_insumos`
--

DROP TABLE IF EXISTS `obras_insumos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `obras_insumos` (
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
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `obras_insumos`
--

LOCK TABLES `obras_insumos` WRITE;
/*!40000 ALTER TABLE `obras_insumos` DISABLE KEYS */;
/*!40000 ALTER TABLE `obras_insumos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `obras_itens`
--

DROP TABLE IF EXISTS `obras_itens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `obras_itens` (
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
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `obras_itens`
--

LOCK TABLES `obras_itens` WRITE;
/*!40000 ALTER TABLE `obras_itens` DISABLE KEYS */;
/*!40000 ALTER TABLE `obras_itens` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ocorrencias`
--

DROP TABLE IF EXISTS `ocorrencias`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ocorrencias` (
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
) ENGINE=InnoDB AUTO_INCREMENT=83 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ocorrencias`
--

LOCK TABLES `ocorrencias` WRITE;
/*!40000 ALTER TABLE `ocorrencias` DISABLE KEYS */;
INSERT INTO `ocorrencias` VALUES (8,'Desktop - Formatação de Computador',2,_binary 'Usuário :\r\nPatrimonio:\r\n\r\nDescrição do problema:',_binary 'Observações',0,72),(9,'Desktop - Solicitação de Novo Computador',2,_binary 'usuário :\r\nAtividade a ser executada :','',0,0),(10,'Criação de Conta de e-mail',5,_binary 'Descrição do e-mail (ex. <descricao>@sabara.mg.gov.br:\r\nResponsável :',_binary 'Descrição do e-mail:\r\nSenha inicial :',0,2),(11,'Bloqueio/Exclusão de Conta de e-mail',5,_binary 'Descrição do e-mail:\r\nmotivo:\r\nResponsável :','',0,2),(12,'Zerar número do Microsoft Authenticator vinculado ao e-mail',5,_binary 'Descrição do e-mail :\r\nResponsavel :','',0,2),(13,'Redefinição de senha de e-mail',5,_binary 'Descrição do e-mail:\r\nResponsável :',_binary 'Senha redefinida para :',0,2),(14,'Manutenção de Cameras',6,_binary 'Localização da câmera :\r\nDescrição do problema na Câmera :','',0,48),(15,'Sistema Moderna - Criação de Usuário',10,_binary 'Nome do usuário :\r\nnúmero do CPF :\r\nModulos que irá acessar (compras, estoque, contabilidade, pregão, credores, frotas, prestação de contas, patrimônio :\r\n\r\n',_binary 'Usuário de Acesso :\r\nSenha de Acesso :\r\n\r\nUsuário do(s) módulo(s) :\r\nSenha do(s) módulo(s) :',0,2),(16,'Sistema Moderna - Redefinir Senha',10,_binary 'Qual o login do usuário? :',_binary 'Nova senha redefinida :',30,0),(17,'Sistema Moderna - Bloqueiro de usuário',10,_binary 'Qual o Usuário ?\r\nMotivo da ação:','',30,0),(19,'Desktop - Lentidão do desktop',2,_binary 'Patrimõnio do Computador :\r\nUsuário:','',0,48),(20,'Desktop - Não liga',2,_binary 'Patrimônio :\r\nlocal / usuário :','',0,48),(21,'Desktop - Tela azul',2,_binary 'Patrimônio :\r\n','',0,48),(22,'Desktop - Travamento',2,_binary 'Patrimônio :\r\nUsuário :\r\n','',0,48),(23,'Desktop - Instalação e Desinstalação',2,_binary 'Patrimonio:\r\nLocal:\r\nNome do solicitante:\r\n','',0,2),(24,'Desktop - Incluir desktop na rede',2,_binary 'Patrimônio :','',0,24),(25,'Monitor - Não está Ligando',11,_binary 'Patrimônio :\r\nchecou cabos de energia (sim/não)?','',0,48),(26,'Monitor - Sem Imagem',11,_binary 'Patrimônio :\r\nChecou cabos de energia e dados (sim/não)\r\nLocal / usuário','',0,48),(27,'Aquisição de Software',9,_binary 'Especificação do software a ser adquirido :','',0,0),(28,'Instalação de Software',9,_binary 'Possui Licença(sim/não) ?\r\nDescrição do software a ser instalado:','',0,2),(29,'Desenvolvimento de Software',9,_binary 'Descrição do Software a ser desenvolvido:','',0,0),(30,'Solicitação de novo Mouse',12,_binary 'Patrimônio do computador onde será utilizado:\r\nUsuário do computador :','',0,24),(31,'Substituição de Mouse',12,_binary 'Patrimônio do computador onde havera a substituição :\r\n','',0,24),(32,'Configuração de Teclado',13,_binary 'Patrimônio do computador onde é utilizado ?\r\nlocal / Usuário :','',0,1),(33,'Solicitação de novo teclado',13,_binary 'Patrimônio do computador onde será utilizado :','',0,24),(34,'Substituição de teclado',13,_binary 'Patrimônio do computador onde está instalado :','',0,24),(35,'Impressora - Scanner',1,_binary 'SELB da impressora','',0,72),(36,'Impressoras - Instalação',1,_binary 'SELB da Impressora :','',0,2),(37,'Impressoras - Falha na impressão',1,_binary 'SELB da impressora :','',0,72),(38,'Impressoras - Não está imprimindo',1,_binary 'SELB da Impressora :','',0,72),(39,'Impressoras - Não liga',1,_binary 'SELB da impressora','',0,72),(40,'Impressoras - Papel preso/atolamento',1,_binary 'SELB da Impressora','',0,72),(41,'Impressoras - Solicitação de toner',1,_binary 'Se for impressora colorida, qual a cor to toner ?:\r\nSELB da Impressora :',_binary 'Responsável pelo transporte:',30,0),(42,'Impressoras - Solicitação de troca de equipamento',1,_binary 'SELB da impressora','',0,72),(43,'Internet - sem acesso',7,_binary 'local :','',0,3),(44,'internet - Lentidão',7,_binary 'local :','',0,24),(45,'Internet - Desbloqueio de Site',7,_binary 'local :\r\nDescrição e URL do site:','',0,24),(46,'Modificação de ponto de rede',3,_binary 'Local :\r\nNúmero de pontos:','',0,48),(47,'Exclusão de ponto de rede',3,_binary 'Local :\r\nNúmero de Pontos','',0,24),(48,'Instalação de Ponto de rede',3,_binary 'Local:\r\nNúmero de pontos','',0,24),(49,'Instalação de rede wi-fi',8,_binary 'Local :','',0,24),(50,'Instalação de Switch',3,_binary 'Local:\r\nNumero de portas:','',0,24),(51,'Queda de Link',3,_binary 'Local :','',0,24),(52,'Reparo de software',9,_binary 'Descrição do software :\r\nPossui licença? (sim/Não) : ','',0,2),(53,'Configuração de Software',9,_binary 'Descrição do software :\r\nPossui licença ? (sim/Não) :\r\nUsuário / Computador:','',0,2),(54,'Inclusão de usuários de rede / computador',14,_binary 'Nome do usuário :\r\nPastas de acesso na rede :',_binary 'Login do Usuário:\r\nSenha Inicial :',0,1),(55,'Redefinição de senha de acesso rede / computador',14,_binary 'Nome do usuário :\r\nLogin do usuário :',_binary 'Nova senha do usuário :',0,1),(56,'Redefinição de acessos do usuário na rede',14,_binary 'Login do usuário :\r\nNovas pastas de acesso na rede :','',0,1),(57,'Exclusão / bloqueio de usuário na rede',14,_binary 'Login do usuário:\r\nNome do usuário:\r\nMotivo do bloqueiro ou exclusão','',0,1),(59,'Acompanhamento de serviço de TI',15,_binary 'Descrição do Serviço','',0,8),(60,'Instalação de Projetores',16,_binary 'Local :\r\nResponsável','',30,0),(61,'Manutenção de Projetores',16,_binary 'Local:\r\nResponsável','',30,0),(62,'Protocoloweb - Inclusão de novo Usuário',17,_binary 'Nome do Usuário:\r\nCPF:\r\nLocais de Tramitação :',_binary 'Login do Usuário :\r\nSenha de Acesso :',30,0),(63,'Telefonia - Solicitação Instalação',18,_binary 'Local:\r\nReferência:\r\nContato:','',0,0),(64,'Telefonia - Solicitação Ramal',18,_binary 'Local:\r\nReferência:\r\nContato:','',0,0),(65,'Telefonia - Manutenção',18,_binary 'Número Telefone:\r\nNúmero Ramal: \r\nOutro Telefone fixo ou celular para contato :','',0,0),(66,'Protocoloweb - Zerar senha',17,_binary 'Login do Usuário :',_binary 'Nova Senha :',30,0),(67,'Protocoloweb - Alteração de locais de tramitação',17,_binary 'Login do Usuário :\r\nNovos locais de tramitação:\r\nExcluir locais anteriores (sim/Não) :','',30,0),(68,'Manutenção de Ponto de Rede',3,_binary 'Local:\r\nNúmero de pontos :','',30,0),(69,'Acompanhamento de visita técnica',19,'','',0,0),(70,'Manutenção de Computadores DeskTop',2,'',_binary 'Conclusão :',0,0),(71,'Telefonia Movel - Solicitacao CHIP',20,_binary 'Secretaria/Gerencia:\r\nUsuário:','',0,0),(72,'Telefonia Movel - Indisponível',20,_binary 'Secretaria/Gerencia:\r\nUsuário:\r\nTelefone: ','',0,0),(73,'Telefonia Movel - Auxilio Configuração (Authenticator)',20,_binary 'Secretaria/Gerencia:\r\nUsuário:\r\nNúmero:','',0,0),(74,'Sistema Moderna - Ateração de configuração do usuários',10,_binary 'Login','',0,1),(75,'Instalação de Monitor',11,_binary 'Local / Usuário:\r\n','',0,1),(76,'Confecção de Cabo de Rede',3,_binary 'Local a ser utilizado :\r\nMetragem :','',0,1),(77,'Instalação do aplicativo no computador',10,_binary 'Local:\r\nUsuário:','',30,0),(78,'Emprestimo de Projetor',16,_binary 'Responsável:\r\nData e hora:\r\nMotivo\r\nLocal:',_binary 'Devolvido por:',1,0),(79,'Inclusão de usuário na rede wi fi',8,_binary 'Nome completo :\r\n',_binary 'Login :\r\nSenha :',30,0),(80,'Reset de Senha de wi fi',8,_binary 'Login do Usuário :',_binary 'Login do usuários :\r\nNova Senha :',20,0),(81,'Restaurar Arquivo de Backup',21,_binary 'Caminho  e Nome da pasta onde estava localizado o arquivo:\r\nNome do arquivo :',_binary 'Local onde foi restaurado ou enviado o arquivo :',0,5),(82,'Outros',19,'','',0,0);
/*!40000 ALTER TABLE `ocorrencias` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oficinas`
--

DROP TABLE IF EXISTS `oficinas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `oficinas` (
  `id` int NOT NULL AUTO_INCREMENT,
  `descricao` varchar(120) NOT NULL DEFAULT '0',
  `fone1` varchar(25) DEFAULT NULL,
  `fone2` varchar(25) DEFAULT NULL,
  `email` varchar(150) DEFAULT NULL,
  `responsavel` varchar(120) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oficinas`
--

LOCK TABLES `oficinas` WRITE;
/*!40000 ALTER TABLE `oficinas` DISABLE KEYS */;
INSERT INTO `oficinas` VALUES (1,'Informática Suporte','(31) 3672-7688','(31) 9988-3883','manutencao@sabara.mg.gov.br','Glaison'),(26,'Informática Manutenção','(31) 3672-7688','','manutencao@sabara.mg.gov.br','Edilson'),(27,'Gerência TI','(31) 3672-7688','','wellington@sabara.mg.gov.br','Wellington');
/*!40000 ALTER TABLE `oficinas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ordens`
--

DROP TABLE IF EXISTS `ordens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ordens` (
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
) ENGINE=InnoDB AUTO_INCREMENT=334 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ordens`
--

LOCK TABLES `ordens` WRITE;
/*!40000 ALTER TABLE `ordens` DISABLE KEYS */;
INSERT INTO `ordens` VALUES (2,16,16,28,0,0,1,NULL,7,NULL,'2026-03-18','14:20:24','2026-03-18','14:33:00',NULL,NULL,NULL,NULL,NULL,NULL,'V',NULL,_binary 'Nova senha do usuário :sabara@2026',NULL,0,'C','P',NULL,'Redefinição de senha de acesso rede / computador',NULL,NULL,NULL,NULL,_binary 'Nome do usuário :redefinição da senha da usuária Marielly.Pinto\r\nLogin do usuário : Marielly.Pinto','2026-03-18','14:20:00','2026-03-18','15:20:00','C',2,55,NULL,NULL,NULL,NULL,16,16),(3,16,16,10,0,0,1,NULL,7,NULL,'2026-03-18','14:25:45','2026-03-18','14:30:00',NULL,NULL,NULL,NULL,NULL,NULL,'V',NULL,_binary 'Descrição do e-mail:relacoesinstitucionais.ds@sabara.mg.gov.br\r\nSenha inicial :sabara@2026',NULL,0,'C','P',NULL,'Criação de Conta de e-mail',NULL,NULL,NULL,NULL,_binary 'Descrição do e-mail (ex. <descricao>@sabara.mg.gov.br: relacoesinstitucionais.ds@sabara.mg.gov.br\r\nResponsável :','2026-03-18','14:25:00','2026-03-18','16:25:00','C',3,10,NULL,NULL,NULL,NULL,16,16),(4,16,16,10,0,0,1,NULL,7,NULL,'2026-03-18','14:45:30','2026-03-18','15:19:00',NULL,NULL,NULL,NULL,NULL,NULL,'V',NULL,_binary 'Usuário de Acesso : rafael.moreira\r\nSenha de Acesso :sabara@2026\r\n\r\nUsuário do(s) módulo(s) :rafael.moreira\r\nSenha do(s) módulo(s) :sabara@2026',NULL,0,'C','P',NULL,'Criação de Usuário',NULL,NULL,NULL,NULL,_binary 'Nome do usuário :Rafael H. P. Moreira\r\nModulos que irá acessar (compras, estoque, contabilidade, pregão, credores, frotas, prestação de contas, patrimônio :\r\nCompras\r\n\r\n','2026-03-18','14:45:00','2026-03-18','16:45:00','C',4,15,NULL,NULL,NULL,NULL,16,16),(5,28,28,6,0,0,1,NULL,11,NULL,'2026-03-18','15:09:08','2026-03-18','15:10:00',NULL,NULL,NULL,NULL,NULL,NULL,'V',NULL,_binary 'Impressora instalada com sucesso',NULL,0,'C','P',NULL,'Impressoras - Instalação',NULL,NULL,NULL,NULL,_binary 'SELB da Impressora: RVG6','2026-03-18','15:09:00','2026-03-21','15:09:00','C',5,36,NULL,NULL,NULL,NULL,28,28),(6,28,28,6,0,0,1,NULL,11,NULL,'2026-03-18','15:13:16','2026-03-18','15:14:00',NULL,NULL,NULL,NULL,NULL,NULL,'V',NULL,_binary 'Impressora instalada com sucesso',NULL,0,'C','P',NULL,'Impressoras - Instalação',NULL,NULL,NULL,NULL,_binary 'SELB da Impressora : RGV6','2026-03-18','15:13:00','2026-03-21','15:13:00','C',7,36,NULL,NULL,NULL,NULL,28,28),(7,16,16,8,0,0,26,'2026-03-20',10,'02:28:00','2026-03-18','15:24:00','2026-05-07','12:09:00','2026-03-20','2026-03-20','02:28:00','2026-03-20',NULL,NULL,'V','',_binary 'Problea elétrico solucionado',0,0,'C','P','','Desktop - Instalação e Desinstalação',NULL,'C','',NULL,_binary 'Patrimonio:não informado\r\n\r\nMaquina Linux. Necessário configuração na rede para enxergar o dirive P da Rede\r\n','2026-03-18','15:25:00','2026-03-18','17:24:00','C',8,23,NULL,NULL,NULL,NULL,16,16),(8,29,29,7,0,0,26,NULL,10,NULL,'2026-03-18','15:33:06','2026-03-18','15:49:00',NULL,NULL,NULL,NULL,NULL,NULL,'V',NULL,_binary 'Aguardando liberação no Firewall.',NULL,0,'C','P',NULL,'internet - Lentidão',NULL,NULL,NULL,NULL,_binary 'local : Verificar Pc da Teo e Joelma (lentidão internet)','2026-03-18','15:33:00','2026-03-18','16:33:00','C',12,44,NULL,NULL,NULL,NULL,29,27),(9,29,29,7,0,0,26,'2026-04-09',8,'12:00:00','2026-03-18','15:34:00','2026-04-09','13:05:00','2026-04-09','2026-04-09','12:00:00','2026-04-09',NULL,NULL,'V','',_binary 'Buscamos a impressora e ela se encontra na sala de Informática no Centro Administrativo.',0,0,'C','P','','Impressoras - Instalação',NULL,'C','',NULL,_binary 'SELB da Impressora :  Não Informado\r\nAcompanhar retirada de Impressora do Transporte (Olaria) e instalar na Procuradoria Jurídica (substituir impressora).','2026-03-18','15:35:00','2026-04-09','15:34:00','C',9,36,NULL,NULL,NULL,NULL,29,27),(10,29,29,6,0,0,26,NULL,10,NULL,'2026-03-19','07:45:10','2026-03-19','08:21:00',NULL,NULL,NULL,NULL,NULL,NULL,'V',NULL,_binary 'Fizemos a mudança de local da impressora. Está funcionando.',NULL,0,'C','P',NULL,'Impressoras - Instalação (Movimentação)',NULL,NULL,NULL,NULL,_binary 'SELB da Impressora : NA\r\nMovimentar impressora (mesma secretaria)','2026-03-19','07:45:00','2026-03-19','09:45:00','C',14,36,NULL,NULL,NULL,NULL,29,27),(11,16,16,5,0,0,1,NULL,7,NULL,'2026-03-19','09:59:11','2026-03-20','10:08:00',NULL,NULL,NULL,NULL,NULL,NULL,'V',NULL,_binary 'Comentário do Analista: Foi feito teste equipamento imprimindo normalmente',NULL,0,'C','P',NULL,'Impressoras - Não está imprimindo',NULL,NULL,NULL,NULL,_binary 'SELB da Impressora :PGZ6\r\n\r\nLentidão na impressão. Passado pelo João da TI da Saúde. \r\nAberto chamado na Selbetti chamado número 13951312','2026-03-19','09:59:00','2026-03-22','09:59:00','C',15,38,NULL,NULL,NULL,NULL,16,16),(12,27,27,6,0,0,26,NULL,10,NULL,'2026-03-19','10:47:37','2026-03-19','10:48:00',NULL,NULL,NULL,NULL,NULL,NULL,'V',NULL,_binary 'Mudei a instalação da impressora da Administração, do usuário Ricardo para o RH.',NULL,0,'C','P',NULL,'Impressoras - Instalação',NULL,NULL,NULL,NULL,_binary 'Mudar instalação da impressora da administração para o RH.','2026-03-19','10:47:00','2026-03-19','12:47:00','C',16,36,NULL,NULL,NULL,NULL,27,27),(13,16,16,8,0,0,26,'2026-03-20',8,'10:20:00','2026-03-20','09:00:00','2026-03-20','14:00:00','2026-03-20','2026-03-20','18:54:00','2026-03-20',NULL,NULL,'V','',_binary 'Efetuado acompanhamento cadastro de imóveis em Ravena. Equipamentos em funcionamento ok.',0,0,'C','P','','Acompanhamento de serviço de TI',NULL,'C','',NULL,_binary 'Descrição do Serviço : Acompanhamento no Cadastro de imóveis realizado em ravena','2026-03-20','09:49:00','2026-03-20','14:00:00','C',17,59,NULL,NULL,NULL,NULL,16,26),(14,27,27,29,0,0,26,'2026-03-20',10,'12:57:00','2026-03-20','09:56:00','2026-03-20','09:58:00','2026-03-20','2026-03-20','12:57:00','2026-03-20',NULL,NULL,'V','',_binary 'Foi feito a instalação da impressora em 5 computadores.',0,0,'C','P','','Impressoras - Instalação',NULL,'C','',NULL,_binary 'Instalação da impressora em 5 computadores','2026-03-20','09:56:00','2026-03-20','11:56:00','C',18,36,NULL,NULL,NULL,NULL,27,27),(15,16,16,9,0,0,1,NULL,7,NULL,'2026-03-20','10:24:09','2026-03-20','10:27:00',NULL,NULL,NULL,NULL,NULL,NULL,'V',NULL,_binary 'Login do Usuário:alan.magno\r\nSenha Inicial :sabara@2026',NULL,0,'C','P',NULL,'Inclusão de usuários de rede / computador',NULL,NULL,NULL,NULL,_binary 'Nome do usuário :Alan Magno Dias da Silva Junior \r\nPastas de acesso na rede :Secretaria de obras','2026-03-20','10:24:00','2026-03-20','11:45:00','C',19,54,NULL,NULL,NULL,NULL,16,16),(16,16,16,6,0,0,26,NULL,10,NULL,'2026-03-20','11:02:41','2026-03-20','11:18:00',NULL,NULL,NULL,NULL,NULL,NULL,'V',NULL,_binary 'Computador foi substituído com êxito. ',NULL,0,'C','P',NULL,'DeskTop - Solicitação de Novo Computador',NULL,NULL,NULL,NULL,_binary 'usuário :Jeferson (RH)\r\nAtividade a ser executada :Substituir maquina do RH linux pela maquina do rh que encontra-se na manutenção','2026-03-20','11:03:00','2026-03-20','12:02:00','C',20,9,NULL,NULL,NULL,NULL,16,27),(17,27,27,6,0,0,26,NULL,10,NULL,'2026-03-20','12:09:52','2026-03-20','12:10:00',NULL,NULL,NULL,NULL,NULL,NULL,'V',NULL,_binary 'Instalado usuário da impressora ADM na impressora do Rh.',NULL,0,'C','P',NULL,'Impressoras - Instalação',NULL,NULL,NULL,NULL,_binary 'Instalar usuário da impressora em outra impressora. Impressora ADM para Rh.','2026-03-20','12:09:00','2026-03-20','14:09:00','C',22,36,NULL,NULL,NULL,NULL,27,27),(18,28,28,31,0,0,1,NULL,11,NULL,'2026-03-20','15:09:25','2026-03-20','15:11:00',NULL,NULL,NULL,NULL,NULL,NULL,'V',NULL,_binary 'O Cabo HDMI está com mal contato',NULL,0,'C','P',NULL,'Instalação de Projetores',NULL,NULL,NULL,NULL,_binary 'Local : Sala de Reunião\r\nResponsável: Joelma','2026-03-20','15:09:00','2026-03-20','15:39:00','C',23,60,NULL,NULL,NULL,NULL,28,28),(19,16,16,7,0,0,1,NULL,7,NULL,'2026-03-20','15:38:11','2026-03-20','15:38:00',NULL,NULL,NULL,NULL,NULL,NULL,'V',NULL,_binary 'Segue  acessos:\r\n\r\nMaria Clara de Oliveira Braga\r\n\r\n         Já possui acesso inicial do sistema. Usuário maria.braga. Se não souber senha (padrão sabara@2026) avisar para fazer reset da mesma\r\n\r\nSusie Machado Nunes\r\n    Usuário de acesso inicial do sistema susie.machado senha inicial sabara@2026\r\n\r\nLucas Fernandes de Almeida Costa\r\n    Usuário de acesso : lucas.costa senha inicial sabara@2026\r\n\r\nKarienne Jaqueline Prado\r\n\r\n     Já possui acesso ao sistema. Usuário karienne.prado. Se não souber senha (padrão sabara@2026) avisar para fazer reset da mesma\r\n\r\nRenata de Araujo Fernandes\r\n\r\n    Já possui acesso ao sistema. Usuário renata.fernandes. Se não souber senha (padrão sabara@2026) avisar para fazer reset da mesma\r\n\r\nOs usuários de acesso ao módulo de planejamento é o mesmo do acesso inicial. Todos com a senha inicial sabara@2026',NULL,0,'C','P',NULL,'Criação de Usuário',NULL,NULL,NULL,NULL,_binary 'Nome do usuário :\r\n\r\nVenho por meio deste solicitar suporte para liberação de acesso ao sistema Super Nova, bem como verificação de acesso ao módulo de Planejamento para os servidores abaixo relacionados:\r\n\r\nMaria Clara de Oliveira Braga\r\nCPF: 120.084.476-93\r\nMatrícula: 24228\r\nSusie Machado Nunes\r\nCPF: 109.054.556-81\r\nMatrícula: 32602\r\n\r\nLucas Fernandes de Almeida Costa\r\nCPF: 135.614.536-19\r\nMatrícula: 33721\r\n\r\nKarienne Jaqueline Prado\r\nCPF: 083.596.266-00\r\nMatrícula: 34642\r\n\r\nRenata de Araujo Fernandes\r\nCPF: 061.352.736-47\r\nMatrícula: 32292\r\n\r\n(Atualmente sem acesso ao módulo de Planejamento)\r\nModulos que irá acessar (compras, estoque, contabilidade, pregão, credores, frotas, prestação de contas, patrimônio :\r\nmódulo de planejamento\r\n','2026-03-20','15:38:00','2026-03-20','17:38:00','C',21,15,NULL,NULL,NULL,NULL,16,16),(20,28,28,31,0,0,1,NULL,11,NULL,'2026-03-20','16:16:08','2026-03-20','16:18:00',NULL,NULL,NULL,NULL,NULL,NULL,'V',NULL,_binary 'Foi repassado à servidora Laila como compactar e descompactar arquivos utilizando Winrar',NULL,0,'C','P',NULL,'Instalação de Software',NULL,NULL,NULL,NULL,_binary 'Possui Licença(sim/não) ? não\r\nDescrição do software a ser instalado: WinRAR (Gratuito)','2026-03-20','16:16:00','2026-03-20','16:46:00','C',24,28,NULL,NULL,NULL,NULL,28,28),(21,28,28,6,0,0,1,NULL,11,NULL,'2026-03-23','09:13:17','2026-03-23','09:15:00',NULL,NULL,NULL,NULL,NULL,NULL,'V',NULL,_binary 'Foi verificado que a funcionária não ligou o estabilizador. Após ligar o equipamento o computador funcionou perfeitamente',NULL,0,'C','U',NULL,'Desktop - Não liga',NULL,NULL,NULL,NULL,_binary 'Funcioanária relata que o computador não quer ligar','2026-03-23','09:13:00','2026-03-23','09:30:00','C',26,20,NULL,NULL,NULL,NULL,28,28),(22,16,16,6,0,0,1,NULL,7,NULL,'2026-03-23','09:35:34','2026-03-23','09:59:00',NULL,NULL,NULL,NULL,NULL,NULL,'V',NULL,_binary 'Login do Usuário :thaynara.teixeira\r\nSenha de Acesso :123456',NULL,0,'C','P',NULL,'Inclusão de novo Usuário',NULL,NULL,NULL,NULL,_binary 'Nome do Usuário:Thaynara Laura de O. Teixeira\r\nCPF:135.992.306-33\r\nLocais de Tramitação :Protocolo','2026-03-23','09:35:00','2026-03-23','10:05:00','C',27,62,NULL,NULL,NULL,NULL,16,16),(23,16,16,6,0,0,1,NULL,7,NULL,'2026-03-23','10:30:39','2026-03-23','10:31:00',NULL,NULL,NULL,NULL,NULL,NULL,'V',NULL,_binary 'Login do Usuário:thynara.teixeira\r\nSenha Inicial :sabara@2026',NULL,0,'C','P',NULL,'Inclusão de usuários de rede / computador',NULL,NULL,NULL,NULL,_binary 'Nome do usuário :thaynara.teixeira\r\nPastas de acesso na rede :Administração','2026-03-23','10:30:00','2026-03-23','11:00:00','C',30,54,NULL,NULL,NULL,NULL,16,16),(24,27,27,7,0,0,26,NULL,10,NULL,'2026-03-23','12:37:53','2026-03-25','07:54:00',NULL,NULL,NULL,NULL,NULL,NULL,'V',NULL,_binary 'Computadores finalizados: PAT 119021,118747,118763. Fiz a formatação e upgrade de memória e SSD. ',NULL,0,'C','P',NULL,'Desktop - Formatação de Computador',NULL,NULL,NULL,NULL,_binary 'Formatar 4 computadores, para serem usados na Policia.','2026-03-23','12:37:00','2026-03-26','12:37:00','C',31,8,NULL,NULL,NULL,NULL,27,27),(25,16,16,5,0,0,1,NULL,7,NULL,'2026-03-23','15:49:08','2026-03-23','15:49:00',NULL,NULL,NULL,NULL,NULL,NULL,'V',NULL,_binary 'Alterado local de tramitação para Secretaria municipal de Saúde',NULL,0,'C','P',NULL,'Alteração de locais de tramitação no protocolo web',NULL,NULL,NULL,NULL,_binary 'Login do Usuário :rafaelheleno\r\nNovos locais de tramitação:RH da SEMUSA\r\nExcluir locais anteriores (sim/Não) :Sim','2026-03-23','15:49:00','2026-03-23','16:19:00','C',32,67,NULL,NULL,NULL,NULL,16,16),(26,16,16,28,0,0,1,NULL,7,NULL,'2026-03-23','16:33:23','2026-03-24','16:50:00',NULL,NULL,NULL,NULL,NULL,NULL,'V',NULL,_binary 'Foi feito trocar da pelicula da fusao. Equipamento funcional',NULL,0,'C','P',NULL,'Impressoras - Não está imprimindo',NULL,NULL,NULL,NULL,_binary 'SELB da Impressora :TFC8\r\nEquipamento com problemas mecânicos. Barulho ao imprimir e embolando papel.\r\nChamado solicitado pelo técnico da secretaria de Educação','2026-03-23','16:33:00','2026-03-26','16:33:00','C',33,38,NULL,NULL,NULL,NULL,16,16),(27,28,28,6,0,0,1,NULL,11,NULL,'2026-03-24','08:36:47','2026-03-24','08:37:00',NULL,NULL,NULL,NULL,NULL,NULL,'V',NULL,_binary 'Foi necessário resetar a senha de administrador local, através de um pendrive, para então recolocar o computador no domínio e assim incluir a nova funcionária ao acesso. Foi configurado também a impressora, finalizado os testes e devolvido ao setor.',NULL,0,'C','P',NULL,'Desktop - Incluir desktop na rede',NULL,NULL,NULL,NULL,_binary 'Configurar computador para funcionária Thaynara no setor de Protocolo','2026-03-24','08:37:00','2026-03-25','08:36:00','C',34,24,NULL,NULL,NULL,NULL,28,28),(28,16,16,29,7,0,1,'2026-03-25',7,'14:17:00','2026-03-24','10:49:00','2026-03-30','10:13:00','2026-03-25','2026-03-25','14:17:00','2026-03-25',NULL,NULL,'R','',_binary 'Visita realizada pelo técnico da dell . Equipamento teve que ser formatado e encontra-se funcional',0,0,'C','P','','Desktop - Não liga',NULL,'C','',NULL,_binary 'Patrimônio :116551\r\n\r\nMaquina do Coronel da Defesa Godinho\r\n\r\nComputador travado na tela inicial da DELL. Foi feita visita de técnico da dell que trocou a placa mãe.\r\nO equipamento voltou a apresentar o problema dois dias após a visita. ','2026-03-24','10:49:00','2026-03-27','10:49:00','C',25,20,NULL,NULL,NULL,NULL,16,16),(29,28,28,29,0,0,1,NULL,11,NULL,'2026-03-24','10:57:33','2026-03-24','11:02:00',NULL,NULL,NULL,NULL,NULL,NULL,'V',NULL,_binary 'instalação concluída com sucesso',NULL,0,'C','P',NULL,'Impressoras - Instalação',NULL,NULL,NULL,NULL,_binary 'Instalação impressora do RH para usuário Douglas','2026-03-24','10:58:00','2026-03-24','11:57:00','C',35,36,NULL,NULL,NULL,NULL,28,28),(30,16,16,7,0,0,1,NULL,7,NULL,'2026-03-24','11:20:30','2026-03-24','11:25:00',NULL,NULL,NULL,NULL,NULL,NULL,'V',NULL,_binary 'Login do Usuário:phillipe.amparo\r\nSenha Inicial :sabara@2026',NULL,0,'C','P',NULL,'Inclusão de usuários de rede / computador',NULL,NULL,NULL,NULL,_binary 'Nome do usuário :phillipe.amparo\r\nPastas de acesso na rede :planejamento','2026-03-24','11:20:00','2026-03-24','12:20:00','C',36,54,NULL,NULL,NULL,NULL,16,16),(31,16,16,25,0,0,1,NULL,7,NULL,'2026-03-24','11:34:59','2026-03-24','16:30:00',NULL,NULL,NULL,NULL,NULL,NULL,'V',NULL,_binary 'Login do Usuário: marta.gomes\r\nSenha Inicial : 123456\r\n\r\nLogin do Usuário: bianca.maximo\r\nSenha Inicial : 123456',NULL,0,'C','P',NULL,'Inclusão de novo Usuário',NULL,NULL,NULL,NULL,_binary 'Nome do Usuário:patricia Marta Gomes\r\nCPF:não informado\r\nLocais de Tramitação :regional fátima\r\n\r\nNome do Usuário:bianca Maxima dos Reis Alves\r\nCPF:\r\nLocais de Tramitação : regional fatima','2026-03-24','11:35:00','2026-03-24','12:04:00','C',37,62,NULL,NULL,NULL,NULL,16,16),(32,16,16,25,0,0,1,NULL,7,NULL,'2026-03-24','11:37:51','2026-03-24','16:29:00',NULL,NULL,NULL,NULL,NULL,NULL,'V',NULL,_binary 'Login do Usuário: marta.gomes\r\nSenha Inicial : sabara@2026\r\n\r\nLogin do Usuário: bianca.maximo\r\nSenha Inicial : sabara@2026\r\n',NULL,0,'C','P',NULL,'Inclusão de usuários de rede / computador',NULL,NULL,NULL,NULL,_binary 'Nome do usuário :Patricia Marta Gomes\r\nPastas de acesso na rede :Regional fatima\r\n\r\nNome do usuário :Bianca Maxima dos Reis Alves\r\nPastas de acesso na rede :regional fatima','2026-03-24','11:37:00','2026-03-24','12:37:00','C',38,54,NULL,NULL,NULL,NULL,16,16),(33,29,29,6,0,0,26,NULL,10,NULL,'2026-03-24','11:48:33','2026-03-26','15:21:00',NULL,NULL,NULL,NULL,NULL,NULL,'V',NULL,_binary 'Computador precisa de peças, Hd ou Placa mãe, estao com defeito',NULL,0,'C','P',NULL,'Desktop - Lentidão do desktop',NULL,NULL,NULL,NULL,_binary 'Patrimônio do Computador : NA\r\nUsuário: Adriana (Junta do Serviço Militar)\r\n\r\nVerificar programas que estão causando lentidao...','2026-03-24','11:49:00','2026-03-25','11:48:00','C',39,19,NULL,NULL,NULL,NULL,29,27),(34,16,16,9,0,0,26,NULL,12,NULL,'2026-03-24','08:00:49','2026-03-24','12:02:00',NULL,NULL,NULL,NULL,NULL,NULL,'V',NULL,_binary 'Visita técnica realizada junto a empresa sk no-break realizada com sucesso',NULL,0,'C','P',NULL,'Acompanhamento de visita técnica',NULL,NULL,NULL,NULL,_binary 'Acompamento de vistoria técnica para manutenção de no-break','2026-03-24','12:01:00','2026-03-24','10:30:00','C',40,69,NULL,NULL,NULL,NULL,16,16),(35,16,16,9,0,0,1,NULL,7,NULL,'2026-03-24','14:25:40','2026-03-24','14:26:00',NULL,NULL,NULL,NULL,NULL,NULL,'V',NULL,_binary 'Nova senha do usuário :sabara@2026',NULL,0,'C','P',NULL,'Redefinição de senha de acesso rede / computador',NULL,NULL,NULL,NULL,_binary 'Nome do usuário :tatiana matias\r\nLogin do usuário :tatiana.matias','2026-03-24','14:25:00','2026-03-24','15:25:00','C',41,55,NULL,NULL,NULL,NULL,16,16),(36,16,16,10,0,0,26,NULL,12,NULL,'2026-03-24','16:18:12','2026-03-25','10:35:00',NULL,NULL,NULL,NULL,NULL,NULL,'V',NULL,_binary 'Adobe Instalado com sucesso',NULL,0,'C','P',NULL,'Instalação de Software',NULL,NULL,NULL,NULL,_binary 'Possui Licença(sim/não) ? não software livre\r\nDescrição do software a ser instalado:Adobe reader\r\nInstalação na advocacia Municipal \r\n\r\n','2026-03-24','16:18:00','2026-03-24','18:18:00','C',42,28,NULL,NULL,NULL,NULL,16,16),(37,27,27,9,0,0,26,NULL,10,NULL,'2026-03-25','08:20:00','2026-03-25','10:30:00',NULL,NULL,NULL,NULL,NULL,NULL,'V',NULL,_binary 'Solicitação concluída, notebook foi formatado.',NULL,0,'C','P',NULL,'Desktop - Formatação de Computador',NULL,NULL,NULL,NULL,_binary 'Usuário : Sabrina\r\nPatrimonio: 119289\r\n\r\nDescrição do problema: Formatar computador, Windows n acessa.','2026-03-25','08:20:00','2026-03-28','08:20:00','C',43,8,NULL,NULL,NULL,NULL,27,27),(38,16,16,5,0,0,1,NULL,7,NULL,'2026-03-25','08:53:20','2026-03-25','08:53:00',NULL,NULL,NULL,NULL,NULL,NULL,'V',NULL,_binary 'Login do Usuário:yasmin.carvalho\r\nSenha Inicial :sabara@2022',NULL,0,'C','P',NULL,'Inclusão de usuários de rede / computador',NULL,NULL,NULL,NULL,_binary 'Nome do usuário :yasmin Carvalho - rede da saúde\r\nPastas de acesso na rede : saFarmacia','2026-03-25','08:53:00','2026-03-25','09:53:00','C',44,54,NULL,NULL,NULL,NULL,16,16),(39,16,16,5,0,0,1,NULL,7,NULL,'2026-03-25','10:42:04','2026-03-25','10:48:00',NULL,NULL,NULL,NULL,NULL,NULL,'V',NULL,_binary 'Login do Usuário : michelle.lisboa\r\nSenha de Acesso :123456',NULL,0,'C','P',NULL,'Protocoloweb - Inclusão de novo Usuário',NULL,NULL,NULL,NULL,_binary 'Nome do Usuário:Michelle Pamela Gonçalves da Costa Lisboa\r\nCPF:\r\nLocais de Tramitação : Secretaria de saude','2026-03-25','10:42:00','2026-03-25','11:12:00','C',45,62,NULL,NULL,NULL,NULL,16,16),(40,30,16,7,0,0,26,NULL,12,NULL,'2026-03-25','10:00:10','2026-03-25','11:39:00',NULL,NULL,NULL,NULL,NULL,NULL,'V',NULL,_binary 'Serviço referente a acompanhamento realizado no dia 17 ao dia 21 de março. ',NULL,0,'C','P',NULL,'Acompanhamento de serviço de TI',NULL,NULL,NULL,NULL,_binary 'Montagem de dois pontos de atendimento para resolver pendências e esclarecer dúvidas relacionadas a IPTU, Cadastro Imobiliário e Geoprocessamento, na região central de Ravena e no povoado de Traíras.','2026-03-25','11:34:00','2026-03-25','17:00:00','C',47,59,NULL,NULL,NULL,NULL,16,16),(41,30,16,11,0,0,26,'2026-03-25',12,'19:00:00','2026-03-25','11:45:00','2026-03-25','16:07:00','2026-03-25','2026-03-25','19:00:00','2026-03-25',NULL,NULL,'V','',_binary 'Sistema reinstalado, add domínio...',0,0,'C','P','','Desktop - Instalação e Desinstalação',NULL,'C','',NULL,_binary 'Patrimonio: 105553\r\nPc Dell Optiplex3000, TAG BM2G6R3; restauração do Sistema Operacional (13 horas); instalação de programas; adicionar ao domínio; instalação de impressora; \r\n','2026-03-25','11:47:00','2026-03-26','13:45:00','C',46,23,NULL,NULL,NULL,NULL,16,30),(42,29,29,14,0,0,26,NULL,10,NULL,'2026-03-25','12:03:53','2026-03-25','12:46:00',NULL,NULL,NULL,NULL,NULL,NULL,'V',NULL,_binary 'Desligaram o ponto do switch. Problema resolvido.',NULL,0,'C','P',NULL,'Internet - sem acesso',NULL,NULL,NULL,NULL,_binary 'local : Secretaria de Esportes (Siderúrgica  - Sala do Viva Mais)','2026-03-25','12:04:00','2026-03-25','15:03:00','C',48,43,NULL,NULL,NULL,NULL,29,27),(43,30,30,6,0,0,26,NULL,12,NULL,'2026-03-24','16:00:04','2026-03-26','16:31:00',NULL,NULL,NULL,NULL,NULL,NULL,'V',NULL,_binary 'Feita limpeza de cache, bloqueio de sites (para evitar adwares), exclusão dos arquivos temporários (usuários - APPDATA- e dos navegadores).',NULL,0,'C','P',NULL,'Desktop - Lentidão do desktop',NULL,NULL,NULL,NULL,_binary 'Verificar o pc da JUNTA MILITAR.\r\n\r\nPatrimõnio do Computador :\r\nUsuário:','2026-03-25','15:09:00','2026-03-27','15:09:00','C',49,19,NULL,NULL,NULL,NULL,30,30),(44,30,30,6,0,0,26,NULL,12,NULL,'2026-03-25','15:22:16','2026-03-25','17:05:00',NULL,NULL,NULL,NULL,NULL,NULL,'V',NULL,_binary 'Reinstalação do Sistema Operacional, instalação dos \"programas padrão\", instalação de impressora, adicionar ao domínio, atualizações necessárias de drives.',NULL,0,'C','P',NULL,'Desktop - Instalação e Desinstalação',NULL,NULL,NULL,NULL,_binary 'Patrimonio:119019\r\n\r\nReinstalação de Sistema Operacional, para uso no RH.\r\n','2026-03-25','15:22:00','2026-03-26','17:00:00','C',50,23,NULL,NULL,NULL,NULL,30,30),(45,30,30,6,0,0,26,'2026-03-25',12,'18:57:00','2026-03-25','08:32:00','2026-03-25','15:58:00','2026-03-25','2026-03-25','18:57:00','2026-03-25',NULL,NULL,'V','',_binary 'finalização do suporte e à disposição para eventuais questionamentos e suporte',0,0,'C','P','','Acompanhamento de visita técnica',NULL,'C','',NULL,_binary 'suporte técnico na redefinição de senha e recuperação de acesso aos e-mails do setor de Segurança do Trabalho.\r\n\r\n- Auxiliar na redefinição de senha e recuperação de acesso ao e-mail medicinat.sabara@gmail.com;\r\n- Prestar suporte para restabelecimento de acesso ao Drive;\r\n- Realizar a configuração de camada de segurança da conta de e-mail;\r\n','2026-03-25','15:32:00','2026-03-25','11:32:00','C',51,69,NULL,NULL,NULL,NULL,30,30),(46,30,30,6,0,0,26,'2026-03-25',12,'20:01:00','2026-03-25','16:56:00','2026-03-26','09:15:00','2026-03-25','2026-03-25','20:01:00','2026-03-25',NULL,NULL,'V','',_binary 'Atualização dos drives do pc. ',0,0,'C','P','','Acompanhamento de visita técnica',NULL,'C','',NULL,_binary 'Verificar acesso a documentos compartilhados (Drive), na Medicina do Trabalho.','2026-03-25','16:56:00','2026-03-26','11:00:00','C',52,69,NULL,NULL,NULL,NULL,30,30),(47,16,16,13,0,0,1,'2026-03-26',7,'13:29:00','2026-03-26','09:50:00','2026-03-26','10:51:00','2026-03-26','2026-03-26','13:29:00','2026-03-26',NULL,NULL,'V','',_binary 'Nova senha redefinida :sabara@2026\r\napenas primeiro acesso. nenhuma sena de móduo foi redefinida',0,0,'C','P','','Redefinir Senha',NULL,'C','',NULL,_binary 'Qual o login do usuário? : letícia.corradi \r\nSistema da Moderna','2026-03-26','09:50:00','2026-03-26','10:20:00','C',54,16,NULL,NULL,NULL,NULL,16,16),(48,16,16,32,0,0,1,NULL,7,NULL,'2026-03-26','09:57:14','2026-03-26','10:02:00',NULL,NULL,NULL,NULL,NULL,NULL,'V',NULL,_binary 'Todos os usuários tiveram os seus acessos removidos da pasta cpad',NULL,0,'C','P',NULL,'Redefinição de acessos do usuário na rede',NULL,NULL,NULL,NULL,_binary 'Login do usuário :\r\n\r\nCamila.felix\r\nRodrigo.grilo\r\nRafael.heleno\r\nPriscila.barbosa\r\nRebeca.sophia\r\nRaiara.raissa\r\nBarbara.silva\r\nLucas.victor\r\n\r\nNovas pastas de acesso na rede : Retirar acesso da pasta cpad','2026-03-26','09:57:00','2026-03-26','10:57:00','C',53,56,NULL,NULL,NULL,NULL,16,16),(49,16,16,19,0,0,1,NULL,7,NULL,'2026-03-26','10:42:21','2026-03-26','13:58:00',NULL,NULL,NULL,NULL,NULL,NULL,'V',NULL,_binary 'Resolvido sem necessidade de visita fisica. Foi retirado e recolocado o toner para resolução do problema',NULL,0,'C','P',NULL,'Impressoras - Não está imprimindo',NULL,NULL,NULL,NULL,_binary 'SELB da Impressora :deu5\r\nTravada na tela de status','2026-03-26','10:42:00','2026-03-29','10:42:00','C',55,38,NULL,NULL,NULL,NULL,16,16),(50,16,16,30,0,0,1,NULL,7,NULL,'2026-03-26','11:51:27','2026-03-26','14:41:00',NULL,NULL,NULL,NULL,NULL,NULL,'V',NULL,_binary 'Descrição do e-mail:vigilanciapatrimonial@sabara.mg.gov.br\r\nSenha iniciao :sabara@2026',NULL,0,'C','P',NULL,'Criação de Conta de e-mail',NULL,NULL,NULL,NULL,_binary 'Descrição do e-mail (ex. <descricao>@sabara.mg.gov.br:vigilanciapatrimonial@sabara.mg.gov.br\r\nResponsável :segurança publica','2026-03-26','11:51:00','2026-03-26','13:51:00','C',56,10,NULL,NULL,NULL,NULL,16,16),(51,16,16,12,0,0,1,NULL,7,NULL,'2026-03-26','11:55:04','2026-03-26','14:24:00',NULL,NULL,NULL,NULL,NULL,NULL,'V',NULL,_binary 'Usuário raylane.vitoria\r\nSenha sabara@2026',NULL,0,'C','P',NULL,'Inclusão de usuários de rede / computador',NULL,NULL,NULL,NULL,_binary 'Nome do usuário :Raylane vitória de Souza Fernandes\r\nPastas de acesso na rede :turismo','2026-03-26','11:55:00','2026-03-26','12:55:00','C',57,54,NULL,NULL,NULL,NULL,16,16),(52,16,16,28,0,0,1,NULL,7,NULL,'2026-03-26','11:59:01','2026-03-26','14:17:00',NULL,NULL,NULL,NULL,NULL,NULL,'V',NULL,_binary 'Nova senha redefinida :sabara@2026',NULL,0,'C','P',NULL,'Sistema Moderna - Redefinir Senha',NULL,NULL,NULL,NULL,_binary 'Qual o login do usuário? :Ana Karla de Deus ','2026-03-26','11:59:00','2026-03-26','12:29:00','C',58,16,NULL,NULL,NULL,NULL,16,16),(53,29,29,8,0,0,26,NULL,12,NULL,'2026-03-27','09:11:23',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'V',NULL,NULL,NULL,0,'C','P',NULL,'Telefonia Movel - Auxilio Configuração (Authenticator)',NULL,NULL,NULL,NULL,_binary 'Secretaria/Gerencia: Gabinete Secretaria da Fazenda\r\nUsuário: Maria Eduarda (Duda)\r\nNúmero:\r\n\r\nAuxiliar na instalação e configuração do Authenticator','2026-03-27','09:11:00','2026-03-27','09:11:00','X',62,73,'2026-05-07',_binary 'Ação não necessária','12:11:00',16,29,NULL),(54,26,26,29,0,0,26,NULL,8,NULL,'2026-03-27','10:31:38','2026-04-06','13:09:00',NULL,NULL,NULL,NULL,NULL,NULL,'V',NULL,_binary 'Feita a troca do HD; restaurado Sistema Operacional; instalado \"programas padrão\"; adicionado ao domínio PMS.',NULL,0,'C','P',NULL,'Desktop - Tela azul',NULL,NULL,NULL,NULL,_binary 'Patrimônio : 093015 Equipamento apresentado tela azul\r\n','2026-03-27','10:31:00','2026-03-29','10:31:00','C',63,21,NULL,NULL,NULL,NULL,26,30),(55,28,28,33,0,0,1,NULL,11,NULL,'2026-03-27','14:32:54','2026-03-27','14:33:00',NULL,NULL,NULL,NULL,NULL,NULL,'V',NULL,_binary 'instalação concluída, testes ok',NULL,0,'C','P',NULL,'Impressoras - Solicitação de toner',NULL,NULL,NULL,NULL,_binary 'Se for impressora colorida qual a cor to toner ?: magenta\r\n','2026-03-27','14:33:00','2026-03-27','15:32:00','C',64,41,NULL,NULL,NULL,NULL,28,28),(56,30,30,6,0,0,26,NULL,12,NULL,'2026-03-30','08:23:05','2026-03-30','08:24:00',NULL,NULL,NULL,NULL,NULL,NULL,'V',NULL,_binary 'Códigos de acesso enviados para celular corporativo',NULL,0,'C','P',NULL,'Acompanhamento de visita técnica',NULL,NULL,NULL,NULL,_binary 'Acesso ao email do Recursos Humanos (Paulo)','2026-03-30','08:23:00','2026-03-30','08:23:00','C',65,69,NULL,NULL,NULL,NULL,30,30),(57,29,29,7,0,0,26,NULL,12,NULL,'2026-03-31','13:30:55',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'V',NULL,NULL,NULL,NULL,'C','P',NULL,'Instalação de Projetores',NULL,NULL,NULL,NULL,_binary 'Local : Instalar na Sala de Reunião\r\nResponsável: Carlos Eduardo\r\n\r\nObs.: instalar Projetor e Notebook na Sala de Reunião às 13:30 do dia 31/03/2026.\r\n(Notebook verificar com o Carlos Eduardo, provavelmente o que está emprestado com a Mariana)','2026-03-30','11:06:00','2026-03-31','13:50:00','X',67,60,'2026-04-06',_binary 'Não houve a referida reunião','16:32:00',30,29,NULL),(58,28,28,32,0,0,1,NULL,11,NULL,'2026-03-30','14:27:56','2026-03-30','16:28:00',NULL,NULL,NULL,NULL,NULL,NULL,'V',NULL,_binary 'Foi retirado do domínio Linux e reincluído. Realizado os testes, ok.',NULL,0,'C','P',NULL,'Desktop - Incluir desktop na rede',NULL,NULL,NULL,NULL,_binary 'Usuário Rafaela relata que ao tentar acessar o pc com seu usuário sempre aparece: \"usuário ou senha inválida\". E quando loga em pc Windows, o mesmo está ok.','2026-03-30','16:28:00','2026-03-31','15:30:00','C',68,24,NULL,NULL,NULL,NULL,28,28),(59,16,30,7,0,0,26,NULL,12,NULL,'2026-03-31','09:00:20','2026-03-31','10:05:00',NULL,NULL,NULL,NULL,NULL,NULL,'V',NULL,_binary 'PC adicionado ao domínio; impressora configurada; configurado os acessos às pastas de rede e scanner; documentos/arquivos copiados; testes feitos.',NULL,0,'C','P',NULL,'Desktop - Incluir desktop na rede',NULL,NULL,NULL,NULL,_binary 'Patrimônio :\r\nAdicionar pc da saúde na rede pms\r\n\r\nUsuário renata.araújo','2026-03-31','09:56:00','2026-03-31','09:30:00','C',69,24,NULL,NULL,NULL,NULL,30,30),(60,28,28,29,0,0,1,NULL,11,NULL,'2026-03-30','16:57:57','2026-03-31','16:59:00',NULL,NULL,NULL,NULL,NULL,NULL,'V',NULL,_binary 'Conclusão : Foi trocada placa mãe e processador pela empresa Dell. Após foi feita reinstalação do windows, reinstalação dos programas, reinstalação office, instalação da rede, impressoras, testes com usuário, ok',NULL,0,'C','P',NULL,'Manutenção',NULL,NULL,NULL,NULL,_binary 'Computador trava na tela de inicialização','2026-03-31','16:58:00','2026-03-31','16:57:00','C',70,70,NULL,NULL,NULL,NULL,28,28),(61,16,16,25,0,0,26,NULL,10,NULL,'2026-04-06','09:37:27','2026-04-09','13:08:00',NULL,NULL,NULL,NULL,NULL,NULL,'V',NULL,_binary 'Conclusão : Computadores colocados no domínio. Regional precisa comprar um Hub/Switch de 8 portas, para adicionar mais computadores.',NULL,0,'C','P',NULL,'Manutenção',NULL,NULL,NULL,NULL,_binary 'Verificar pontos de rede e verificar se máquinas estão no domínio','2026-04-06','09:37:00','2026-04-06','17:00:00','C',66,70,NULL,NULL,NULL,NULL,16,27),(62,16,16,9,0,0,26,'2026-04-06',10,'18:25:00','2026-04-06','09:38:00','2026-04-08','13:10:00','2026-04-06','2026-04-06','18:25:00','2026-04-06',NULL,NULL,'V','',_binary 'Problema resolvido, endereço IP estava em conflito.',0,0,'C','P','','Internet - sem acesso',NULL,'C','',NULL,_binary 'local :Secretaria Municipal de Obras\r\nSolicitante : Sabrina','2026-04-06','09:38:00','2026-04-07','12:38:00','C',71,43,NULL,NULL,NULL,NULL,16,27),(63,30,30,30,8,0,26,NULL,12,NULL,'2026-03-31','11:00:49','2026-04-08','09:53:00',NULL,NULL,NULL,NULL,NULL,NULL,'R',NULL,_binary 'Observações: Computador funcional enviado para a secretaria',NULL,0,'C','P',NULL,'Desktop - Formatação de Computador',NULL,NULL,NULL,NULL,_binary 'Usuário : Alessandra\r\nPatrimonio: 119245\r\n\r\nDescrição do problema: Pc sem Sistema Operacional; instalação do Sistema LinuxMint','2026-04-06','13:19:00','2026-04-06','13:18:00','C',73,8,NULL,NULL,NULL,NULL,30,16),(64,30,30,30,0,0,26,NULL,10,NULL,'2026-04-06','13:23:31','2026-04-06','13:24:00',NULL,NULL,NULL,NULL,NULL,NULL,'V',NULL,_binary 'Cabos arrebentados; abertura de chamado para a empresa prestadora do serviço.',NULL,0,'C','P',NULL,'Internet - sem acesso',NULL,NULL,NULL,NULL,_binary 'local : Gerência de Trânsito. Interrupção dos serviços de internet. <JUNIOR>','2026-04-06','13:23:00','2026-04-06','16:23:00','C',72,43,NULL,NULL,NULL,NULL,30,30),(65,16,16,5,0,0,1,NULL,7,NULL,'2026-04-06','15:28:20','2026-04-06','15:28:00',NULL,NULL,NULL,NULL,NULL,NULL,'V',NULL,_binary 'Usuário de Acesso :thiago.santos\r\nSenha de Acesso : já tinha senha \r\n\r\nUsuário do(s) módulo(s) : thiago.santos\r\nSenha do(s) módulo(s) : sabara@2026',NULL,0,'C','P',NULL,'Sistema Moderna - Criação de Usuário',NULL,NULL,NULL,NULL,_binary 'Nome do usuário :thiago.santos\r\nModulos que irá acessar (compras, estoque, contabilidade, pregão, credores, frotas, prestação de contas, patrimônio :\r\n\r\nSistema de contabilidade e compras\r\n\r\n','2026-04-06','15:28:00','2026-04-06','17:28:00','C',74,15,NULL,NULL,NULL,NULL,16,16),(66,28,28,7,0,0,1,NULL,11,NULL,'2026-04-06','11:42:39','2026-04-06','16:43:00',NULL,NULL,NULL,NULL,NULL,NULL,'V',NULL,_binary 'Conclusão : Foi realizada varredura de vírus no computador, desinstalado o Google Chrome e reinstalado. Foi testado pelo usuário e normalizado.',NULL,0,'C','P',NULL,'Manutenção',NULL,NULL,NULL,NULL,_binary 'Aparecendo vários pop-ups no navegador google Chrome com informação de \"vírus\"','2026-04-06','16:43:00','2026-04-06','14:42:00','C',75,70,NULL,NULL,NULL,NULL,28,28),(67,30,30,28,0,0,1,'2026-04-07',12,'13:26:00','2026-04-07','09:54:00','2026-04-07','11:52:00','2026-04-07','2026-04-07','13:26:00','2026-04-07',NULL,NULL,'V','',_binary 'Rompimento de fibra soliciionado',0,0,'C','P','','Internet - sem acesso',NULL,'C','',NULL,_binary 'local : Escola Municipal Ordália\r\nrompimento de fibra','2026-04-07','09:54:00','2026-04-07','12:54:00','C',76,43,NULL,NULL,NULL,NULL,30,16),(68,16,16,5,0,0,1,'2026-04-07',7,'13:38:00','2026-04-07','10:32:00','2026-04-07','10:55:00','2026-04-07','2026-04-07','13:38:00','2026-04-07',NULL,NULL,'V','',_binary 'Usuário de Acesso :fabio.magalhaes\r\nSenha de Acesso :sabara@2026\r\n\r\nUsuário do(s) módulo(s) : fabio.magalhaes\r\nSenha do(s) módulo(s) :sabara@2026',0,0,'C','P','','Sistema Moderna - Criação de Usuário',NULL,'C','',NULL,_binary 'Nome do usuário :Fabio Jesuita Magalhaes\r\nCPF:87170582600\r\nModulos que irá acessar (compras, estoque, contabilidade, pregão, credores, frotas, prestação de contas, patrimônio :\r\nCOMPRAS, CONTABILIDADE, ESTOQUE\r\n','2026-04-07','10:32:00','2026-04-07','12:32:00','C',78,15,NULL,NULL,NULL,NULL,16,16),(69,30,27,9,0,0,26,NULL,10,NULL,'2026-04-07','11:01:57',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'V',NULL,NULL,NULL,0,'C','P',NULL,'Internet - sem acesso',NULL,NULL,NULL,NULL,_binary 'local :...','2026-04-07','11:02:00','2026-04-07','14:01:00','X',77,43,'2026-04-07',_binary '2 chamados abertos','11:12:00',27,27,NULL),(70,30,30,8,0,0,26,NULL,12,NULL,'2026-04-07','11:15:53','2026-04-07','16:16:00',NULL,NULL,NULL,NULL,NULL,NULL,'V',NULL,_binary 'mudança efetivada; reorganização de cabos; ',NULL,0,'C','P',NULL,'Desktop - Instalação e Desinstalação',NULL,NULL,NULL,NULL,_binary 'Patrimonio:\r\nLocal: sala de GeoProcessamento; mudar o computador de lugar na mesma sala.\r\n','2026-04-07','16:16:00','2026-04-07','13:15:00','C',79,23,NULL,NULL,NULL,NULL,30,30),(71,28,28,6,0,0,1,NULL,11,NULL,'2026-04-07','08:33:20','2026-04-08','08:45:00',NULL,NULL,NULL,NULL,NULL,NULL,'V',NULL,_binary 'Instalação concluída com sucesso. Testes ok',NULL,0,'C','P',NULL,'Impressoras - Instalação',NULL,NULL,NULL,NULL,_binary 'Instalação impressora do RH para funcionária Bruna do setor de Serviços Gerais','2026-04-08','08:33:00','2026-04-07','10:33:00','C',80,36,NULL,NULL,NULL,NULL,28,28),(72,16,16,11,0,0,1,NULL,7,NULL,'2026-04-08','09:32:18','2026-04-08','09:42:00',NULL,NULL,NULL,NULL,NULL,NULL,'V',NULL,_binary 'Login do Usuário :pedro.pieri\r\nSenha de Acesso :123456',NULL,0,'C','P',NULL,'Protocoloweb - Inclusão de novo Usuário',NULL,NULL,NULL,NULL,_binary 'Nome do Usuário:Pedro Henrique Faleiro de Souza Pieri\r\nCPF:021.663.596-98\r\nLocais de Tramitação :Meio Ambiente','2026-04-08','09:32:00','2026-04-08','10:02:00','C',83,62,NULL,NULL,NULL,NULL,16,16),(73,16,16,11,0,0,1,NULL,7,NULL,'2026-04-08','09:32:47','2026-04-08','09:38:00',NULL,NULL,NULL,NULL,NULL,NULL,'V',NULL,_binary 'Login do Usuário:pedro.pieri\r\nSenha Inicial :sabara@2026',NULL,0,'C','P',NULL,'Inclusão de usuários de rede / computador',NULL,NULL,NULL,NULL,_binary 'Nome do usuário :Pedro Henrique Faleiro de Souza Pieri\r\nPastas de acesso na rede :Meio ambiente','2026-04-08','09:32:00','2026-04-08','10:32:00','C',82,54,NULL,NULL,NULL,NULL,16,16),(74,16,16,5,0,0,1,NULL,7,NULL,'2026-04-08','09:33:15','2026-04-08','11:13:00',NULL,NULL,NULL,NULL,NULL,NULL,'V',NULL,_binary 'Usuário de Acesso :Já possui acesso\r\nSenha de Acesso :já possui acess\r\n\r\nUsuário do(s) módulo(s) :thiago.ramos\r\nSenha do(s) módulo(s) :sabara@2026',NULL,0,'C','P',NULL,'Sistema Moderna - Criação de Usuário',NULL,NULL,NULL,NULL,_binary 'Nome do usuário :Thiago Fernando Martins Ramos de Carvalho\r\nnúmero do CPF : não informado\r\nModulos que irá acessar (compras, estoque, contabilidade, pregão, credores, frotas, prestação de contas, patrimônio : Estoque\r\n\r\n','2026-04-08','09:33:00','2026-04-08','11:33:00','C',81,15,NULL,NULL,NULL,NULL,16,16),(75,16,16,8,0,0,1,NULL,7,NULL,'2026-04-08','11:20:13','2026-04-08','11:20:00',NULL,NULL,NULL,NULL,NULL,NULL,'V',NULL,_binary 'Login do Usuário:adrian.kaster\r\nSenha Inicial :sabara@2026',NULL,0,'C','P',NULL,'Inclusão de usuários de rede / computador',NULL,NULL,NULL,NULL,_binary 'Nome do usuário :Adrian Karster Souza Silva\r\nPastas de acesso na rede :fazenda e fiscalização','2026-04-08','11:20:00','2026-04-08','12:20:00','C',84,54,NULL,NULL,NULL,NULL,16,16),(76,16,16,12,11,0,26,'2026-04-14',8,'19:29:00','2026-04-08','15:38:00','2026-04-15','14:07:00','2026-04-14','2026-04-14','19:29:00','2026-04-14',NULL,NULL,'R','',_binary 'Conclusão :\r\nAtualização de Bios e drivers\r\nOtimização de desempenho\r\nOtimização de unidades(c:)\r\nExclusão de arquivos temporários ',0,0,'C','P','','Manutenção',NULL,'C','',NULL,_binary 'Computador com tarvamento e lentidão','2026-04-08','15:38:00','2026-04-15','15:38:00','C',85,70,NULL,NULL,NULL,NULL,16,26),(77,16,16,12,12,0,26,'2026-04-14',8,'19:29:00','2026-04-08','15:41:00','2026-04-15','13:53:00','2026-04-14','2026-04-14','19:29:00','2026-04-14',NULL,NULL,'R','',_binary 'Conclusão :\r\nAtualização de Bios e drivers\r\nOtimização de desempenho\r\nOtimização de unidades(c:)\r\nExclusão de arquivos temporários ',0,0,'C','P','','Manutenção',NULL,'C','',NULL,_binary 'Computador com travamento e Lentidão','2026-04-08','15:41:00','2026-04-15','15:41:00','C',86,70,NULL,NULL,NULL,NULL,16,26),(78,29,16,30,0,0,26,NULL,9,NULL,'2026-04-08','16:03:08','2026-04-14','14:25:00',NULL,NULL,NULL,NULL,NULL,NULL,'V',NULL,_binary 'instalação do ponto de internet e telefonia realizado pela speednet. Necessário aparelho telefônico para configuração',NULL,0,'C','P',NULL,'Telefonia - Solicitação Instalação',NULL,NULL,NULL,NULL,_binary 'Local: Praça Getúlio Vargas\r\nReferência: Ponto de Taxi\r\nContato:','2026-04-08','16:03:00','2026-04-13','16:03:00','C',28,63,NULL,NULL,NULL,NULL,16,16),(79,30,30,7,0,0,26,NULL,12,NULL,'2026-04-08','13:00:25','2026-04-09','08:19:00',NULL,NULL,NULL,NULL,NULL,NULL,'V',NULL,_binary 'procedimento realizado',NULL,0,'C','P',NULL,'Monitor - Não está Ligando',NULL,NULL,NULL,NULL,_binary 'Patrimônio :\r\nchecou cabos de energia (sim/não)? \r\n\r\nAdicionar monitor extra ao pc. Falta cabo hdmi ou displayport.\r\nLocal: SINE','2026-04-09','08:18:00','2026-04-08','13:10:00','C',60,25,NULL,NULL,NULL,NULL,30,30),(80,30,30,8,13,0,26,NULL,12,NULL,'2026-04-09','08:39:27','2026-04-10','15:03:00',NULL,NULL,NULL,NULL,NULL,NULL,'R',NULL,_binary 'Procedimentos feitos.',NULL,0,'C','P',NULL,'Desktop - Instalação e Desinstalação',NULL,NULL,NULL,NULL,_binary 'Patrimonio: 119311\r\nConfiguração do Sistema Operacional; instalação de \"programas padrão\"; adicionar ao domínio; configurar impressora; \r\n','2026-04-09','08:39:00','2026-04-09','10:39:00','C',87,23,NULL,NULL,NULL,NULL,30,30),(81,16,16,8,0,0,1,NULL,7,NULL,'2026-04-09','09:06:46','2026-04-09','09:38:00',NULL,NULL,NULL,NULL,NULL,NULL,'V',NULL,_binary 'Login do Usuário:katia.rocha\r\nSenha Inicial :sabara@2026',NULL,0,'C','P',NULL,'Inclusão de usuários de rede / computador',NULL,NULL,NULL,NULL,_binary 'Nome do usuário : Kátia Vilela Rocha\r\nPastas de acesso na rede : Contabilidade','2026-04-09','09:07:00','2026-04-09','10:06:00','C',88,54,NULL,NULL,NULL,NULL,16,16),(82,16,16,8,0,0,1,NULL,7,NULL,'2026-04-09','09:17:39','2026-04-09','09:36:00',NULL,NULL,NULL,NULL,NULL,NULL,'V',NULL,_binary 'Usuário de Acesso :katia.rocha\r\nSenha de Acesso :sabara@2026\r\n\r\nUsuário do(s) módulo(s) :katia.rocha\r\nSenha do(s) módulo(s) :sabara@2026',NULL,0,'C','P',NULL,'Sistema Moderna - Criação de Usuário',NULL,NULL,NULL,NULL,_binary 'Nome do usuário :Kátia Vilela Rocha\r\nnúmero do CPF : 01505073642\r\nModulos que irá acessar (compras, estoque, contabilidade, pregão, credores, frotas, prestação de contas, patrimônio :Contabilidade\r\n\r\n','2026-04-09','09:17:00','2026-04-09','10:00:00','C',89,15,NULL,NULL,NULL,NULL,16,16),(83,16,16,5,0,0,1,NULL,7,NULL,'2026-04-09','14:00:07','2026-04-09','14:00:00',NULL,NULL,NULL,NULL,NULL,NULL,'V',NULL,_binary 'Usuário vinicius.bento já tinha acesso ao módulo de estoque pedido. foi redefinido senha para sabara@2026',NULL,0,'C','P',NULL,'Sistema Moderna - Criação de Usuário',NULL,NULL,NULL,NULL,_binary 'Nome do usuário :Vinicius Silva Bento\r\nnúmero do CPF : 12307802622\r\nModulos que irá acessar (compras, estoque, contabilidade, pregão, credores, frotas, prestação de contas, patrimônio :Estoque\r\n\r\n','2026-04-09','14:00:00','2026-04-09','16:00:00','C',90,15,NULL,NULL,NULL,NULL,16,16),(84,16,16,5,0,0,1,'2026-04-09',7,'19:01:00','2026-04-09','15:19:00','2026-04-09','16:14:00','2026-04-09','2026-04-09','19:01:00','2026-04-09',NULL,NULL,'V','',_binary 'Usuário remisson.pereira  senha inicial sabara@2026\r\n\r\nsomente contabilidade e estoque',0,0,'C','P','','Sistema Moderna - Criação de Usuário',NULL,'C','',NULL,_binary 'Nome: Remisson Soares Pereira\r\nCPF: 42545749672\r\nCONTABILIDADE e ESTOQUE\r\n\r\n','2026-04-09','15:19:00','2026-04-09','17:19:00','C',91,15,NULL,NULL,NULL,NULL,16,16),(85,30,30,32,14,0,26,NULL,12,NULL,'2026-04-10','08:18:12','2026-04-10','08:31:00',NULL,NULL,NULL,NULL,NULL,NULL,'R',NULL,_binary 'Software instalado e ativado',NULL,0,'C','P',NULL,'Instalação de Software',NULL,NULL,NULL,NULL,_binary 'Possui Licença(sim/não) ? sim (NMCRM-6TJ77-CW7FQ-6JVDG-FVYFX)\r\nDescrição do software a ser instalado: Microsoft Office 2021','2026-04-10','08:18:00','2026-04-13','12:00:00','C',92,28,NULL,NULL,NULL,NULL,30,30),(86,30,30,7,15,0,26,NULL,12,NULL,'2026-04-10','09:20:34','2026-04-10','09:21:00',NULL,NULL,NULL,NULL,NULL,NULL,'R',NULL,_binary 'Driver de Impressora instalado e configurado.',NULL,0,'C','P',NULL,'Impressoras - Instalação',NULL,NULL,NULL,NULL,_binary 'SELB da Impressora : TFC9','2026-04-10','09:20:00','2026-04-10','11:20:00','C',93,36,NULL,NULL,NULL,NULL,30,30),(87,30,30,7,15,0,26,NULL,12,NULL,'2026-04-10','09:42:57','2026-04-10','09:43:00',NULL,NULL,NULL,NULL,NULL,NULL,'R',NULL,_binary 'Instalação feita',NULL,0,'C','P',NULL,'Sistema Moderna - Ateração de configuração do usuários',NULL,NULL,NULL,NULL,_binary 'Instalação do GoGlobal e atalho do SUPERNOVA-MODERNA no pc.','2026-04-10','09:43:00','2026-04-10','10:42:00','C',94,74,NULL,NULL,NULL,NULL,30,30),(88,30,30,6,16,0,26,NULL,12,NULL,'2026-04-10','10:45:30','2026-04-10','11:20:00',NULL,NULL,NULL,NULL,NULL,NULL,'R',NULL,_binary 'Instalação feita',NULL,0,'C','P',NULL,'Sistema Moderna - Ateração de configuração do usuários',NULL,NULL,NULL,NULL,_binary 'Login setor de Licitação','2026-04-10','11:19:00','2026-04-10','11:30:00','C',95,74,NULL,NULL,NULL,NULL,30,30),(89,16,16,28,0,0,1,NULL,7,NULL,'2026-04-10','11:37:15','2026-04-10','11:40:00',NULL,NULL,NULL,NULL,NULL,NULL,'V',NULL,_binary 'Login do Usuário:adriana.lucia\r\nSenha Inicial :sabara@2026',NULL,0,'C','P',NULL,'Inclusão de usuários de rede / computador',NULL,NULL,NULL,NULL,_binary 'Solicito, por gentileza, crianção de login e senha de acesso (pasta P) para Servidora Adriana Lúcia da Silva, assistente administrativo na Educação (Setor de Alimentação Escolar).','2026-04-10','11:37:00','2026-04-10','12:37:00','C',96,54,NULL,NULL,NULL,NULL,16,16),(90,16,16,11,0,0,1,'2026-04-10',7,'19:19:00','2026-04-10','16:18:00','2026-04-10','16:21:00','2026-04-10','2026-04-10','19:19:00','2026-04-10',NULL,NULL,'V','',_binary 'Login do Usuário :ana.vasconcelos\r\nSenha de Acesso :123456',0,0,'C','P','','Protocoloweb - Inclusão de novo Usuário',NULL,'C','',NULL,_binary 'Nome do Usuário:Ana Beatriz Cardoso Vasconcelos dos Santos\r\nCPF:15993891696\r\nLocais de Tramitação :Meio Ambiente','2026-04-10','16:18:00','2026-04-10','16:48:00','C',97,62,NULL,NULL,NULL,NULL,16,16),(91,16,16,6,0,0,1,'2026-04-13',7,'12:30:00','2026-04-13','09:12:00','2026-04-13','10:13:00','2026-04-13','2026-04-13','12:30:00','2026-04-13',NULL,NULL,'V','',_binary 'Usuário de Acesso :glenia.pinto\r\nSenha de Acesso :sabara@2026\r\n\r\nUsuário do(s) módulo(s) :glenia.pinto\r\nSenha do(s) módulo(s) :sabara@2026',0,0,'C','P','','Sistema Moderna - Criação de Usuário',NULL,'C','',NULL,_binary 'Nome do usuário :Glênia Paula Pinto \r\nnúmero do CPF :08025451658\r\nModulos que irá acessar (compras, estoque, contabilidade, pregão, credores, frotas, prestação de contas, patrimônio :\r\n\r\nCompras\r\nEstoque\r\nContabilidade\r\nPatrimônio\r\nProtocolo\r\n\r\n','2026-04-13','09:12:00','2026-04-13','11:12:00','C',98,15,NULL,NULL,NULL,NULL,16,16),(92,30,30,30,0,0,26,NULL,12,NULL,'2026-04-14','09:04:03',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'V',NULL,NULL,NULL,NULL,'C','P',NULL,'Instalação de Software',NULL,NULL,NULL,NULL,_binary 'Possui Licença(sim/não) ?\r\nDescrição do software a ser instalado: software para gerenciamento de multas','2026-04-14','09:04:00','2026-04-14','11:04:00','X',61,28,'2026-05-07',_binary 'Intrvenção não necessária','12:11:00',16,30,NULL),(93,30,30,9,0,0,26,NULL,12,NULL,'2026-04-14','09:07:39','2026-05-07','12:12:00',NULL,NULL,NULL,NULL,NULL,NULL,'V',NULL,_binary 'Problema solucionado',NULL,0,'C','P',NULL,'Internet - sem acesso',NULL,NULL,NULL,NULL,_binary 'local : SEMOB - Projetos, pc usado pela Gabrielle Galdino','2026-04-14','09:07:00','2026-04-14','12:07:00','C',99,43,NULL,NULL,NULL,NULL,30,16),(94,30,30,14,0,0,26,NULL,12,NULL,'2026-04-13','07:30:03','2026-04-22','10:55:00',NULL,NULL,NULL,NULL,NULL,NULL,'V',NULL,_binary 'Os pcs continuarão, por tempo indefinido, no local.',NULL,0,'C','P',NULL,'Desktop - Instalação e Desinstalação',NULL,NULL,NULL,NULL,_binary 'Solicita a instalação e configuração de 2 pcs, na sala de reunião da Administração e configuração de impressoras, para apoio ao JEMG.\r\n','2026-04-14','09:30:00','2026-04-17','17:00:00','C',102,23,NULL,NULL,NULL,NULL,30,30),(95,30,30,14,0,0,26,NULL,12,NULL,'2026-04-14','11:24:46','2026-04-16','09:29:00',NULL,NULL,NULL,NULL,NULL,NULL,'V',NULL,_binary 'Link ativo no local',NULL,0,'C','P',NULL,'Acompanhamento de visita técnica',NULL,NULL,NULL,NULL,_binary 'Acompanhar pessoal da SpeedNet no Campo da Liga','2026-04-14','11:24:00','2026-04-14','11:24:00','C',105,69,NULL,NULL,NULL,NULL,30,16),(96,30,30,8,0,0,26,NULL,12,NULL,'2026-04-14','15:00:30','2026-04-14','16:37:00',NULL,NULL,NULL,NULL,NULL,NULL,'V',NULL,_binary 'Montagem de 01 pc; reconfiguração de IP da impressora RVH1; configuração da porta de impressão nos 03 pc da Secretaria de Fazenda Estadual.',NULL,0,'C','P',NULL,'Internet - sem acesso',NULL,NULL,NULL,NULL,_binary 'local : SECRETARIA DE FAZENDA ESTADUAL: -Colocar o cabeamento de internet; -conectar impressora.','2026-04-14','16:32:00','2026-04-14','16:10:00','C',103,43,NULL,NULL,NULL,NULL,30,30),(97,30,30,7,0,0,26,NULL,12,NULL,'2026-04-14','11:14:01','2026-04-22','16:33:00',NULL,NULL,NULL,NULL,NULL,NULL,'V',NULL,_binary 'Efetuado o acompanhamento. Problemas observados foram repassados para Flávio Maielo.',NULL,0,'C','P',NULL,'Acompanhamento de serviço de TI',NULL,NULL,NULL,NULL,_binary 'Descrição do Serviço:Acompanhar Laila (Secretaria de Governo) em visita a alguns prédios públicos, junto com a equipe de totens.','2026-04-14','16:41:00','2026-04-17','16:41:00','C',101,59,NULL,NULL,NULL,NULL,30,30),(98,16,16,31,0,0,1,NULL,7,NULL,'2026-04-15','15:14:08','2026-04-15','15:14:00',NULL,NULL,NULL,NULL,NULL,NULL,'V',NULL,_binary 'Descrição do e-mail:relatorios@sabara.mg.gov.br\r\nSenha iniciao :sabara@2026',NULL,0,'C','P',NULL,'Criação de Conta de e-mail',NULL,NULL,NULL,NULL,_binary 'Descrição do e-mail (ex. <descricao>@sabara.mg.gov.br:relatorios@sabara.mg.gov.br\r\nResponsável :Itelvina','2026-04-15','15:14:00','2026-04-15','16:00:00','C',106,10,NULL,NULL,NULL,NULL,16,16),(99,16,16,7,0,0,1,NULL,7,NULL,'2026-04-15','15:18:00','2026-04-15','15:18:00',NULL,NULL,NULL,NULL,NULL,NULL,'V',NULL,_binary 'Login do Usuário: mirelly.pereira\r\nSenha Inicial :sabara@2026',NULL,0,'C','P',NULL,'Inclusão de usuários de rede / computador',NULL,NULL,NULL,NULL,_binary 'Nome do usuário : Mirelly Guimarães Pereira\r\nPastas de acesso na rede :planejamento','2026-04-15','15:18:00','2026-04-15','16:18:00','C',107,54,NULL,NULL,NULL,NULL,16,16),(100,30,30,7,0,0,26,NULL,12,NULL,'2026-04-15','09:00:49','2026-04-15','17:37:00',NULL,NULL,NULL,NULL,NULL,NULL,'V',NULL,_binary 'Montagem realizada; testes realizados; reunião iniciou-se às 14h.',NULL,0,'C','P',NULL,'Instalação de Projetores',NULL,NULL,NULL,NULL,_binary 'Local : sala de reuniões do Gabinete\r\nResponsável: Cassirlene Vieira\r\n\r\nE solicitar suporte técnico para conexão via notebook, para acesso e participação em reunião virtual do Conselho Municipal de Habitação de Interesse Social - CMHIS e do Grupo Institucional do Poder Público - GIPP.','2026-04-15','17:36:00','2026-04-15','17:00:00','C',108,60,NULL,NULL,NULL,NULL,30,30),(101,28,28,31,0,0,1,NULL,11,NULL,'2026-04-16','08:37:56','2026-04-16','08:38:00',NULL,NULL,NULL,NULL,NULL,NULL,'V',NULL,_binary 'Realizada troca dos tonners, testes ok',NULL,0,'C','P',NULL,'Impressoras - Solicitação de toner',NULL,NULL,NULL,NULL,_binary 'Se for impressora colorida qual a cor to toner ?: Azul e Amarelo\r\n','2026-04-16','08:38:00','2026-04-16','09:37:00','C',109,41,NULL,NULL,NULL,NULL,28,28),(102,28,28,8,0,0,1,NULL,11,NULL,'2026-04-16','08:39:46','2026-04-16','08:40:00',NULL,NULL,NULL,NULL,NULL,NULL,'V',NULL,_binary 'Módulo da Caixa não funcionou no navegador google Chrome, instalado no navegador Firefox. Testes ok',NULL,0,'C','P',NULL,'Desktop - Instalação e Desinstalação',NULL,NULL,NULL,NULL,_binary 'Instalação de módulo da Caixa\r\n','2026-04-16','08:39:00','2026-04-16','10:39:00','C',110,23,NULL,NULL,NULL,NULL,28,28),(103,16,16,28,0,0,1,NULL,7,NULL,'2026-04-16','09:10:12','2026-04-16','09:10:00',NULL,NULL,NULL,NULL,NULL,NULL,'V',NULL,_binary 'Usuário de Acesso :adriana.lucia\r\nSenha de Acesso : sabara@2026\r\n\r\nUsuário do(s) módulo(s) : adriana.lucia\r\nSenha do(s) módulo(s) : sabara@2026',NULL,0,'C','P',NULL,'Sistema Moderna - Criação de Usuário',NULL,NULL,NULL,NULL,_binary 'Nome do usuário :Adriana Lúcia da Silva\r\nnúmero do CPF :068.132.296-99\r\nModulos que irá acessar (compras, estoque, contabilidade, pregão, credores, frotas, prestação de contas, patrimônio :\r\n\r\n','2026-04-16','09:10:00','2026-04-16','11:10:00','C',111,15,NULL,NULL,NULL,NULL,16,16),(104,30,16,34,0,0,26,NULL,12,NULL,'2026-04-16','09:33:26',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'V',NULL,NULL,NULL,NULL,'C','P',NULL,'Modificação de ponto de rede',NULL,NULL,NULL,NULL,_binary 'Local : PROCON\r\nNúmero de pontos: 02\r\n\r\nSolicita vista técnica a sede do PROCON (Rua: Dom Pedro II, N° 72, Centro), para que seja instalado cabo de internet em dois computadores recentemente adquiridos pelo órgão; será preciso estender o cabo de internet dos telefones.  \r\n\r\nLarissa Vieira - Tecnica de atendimento','2026-04-16','09:33:00','2026-04-18','09:33:00','X',104,46,'2026-04-16',_binary 'Ordem gerada igual a ordem 59 - Solicitação feita em duplicidade','09:33:00',16,16,NULL),(105,16,16,11,0,0,26,'2026-04-23',12,'12:58:00','2026-04-16','09:37:00','2026-05-07','17:24:00','2026-04-23','2026-04-23','12:58:00','2026-04-23',NULL,NULL,'V','',_binary 'Habilitado novo ponto na sala do Secretário de Meio Ambiente',0,0,'C','P','','Manutenção de Ponto de Rede',NULL,'C','',NULL,_binary 'Local:Meio Ambiente\r\nNúmero de pontos :1 ponto cabo com problema','2026-04-16','09:37:00','2026-05-04','10:07:00','C',100,68,NULL,NULL,NULL,NULL,16,30),(106,16,16,30,0,0,26,NULL,8,NULL,'2026-04-16','10:56:42','2026-05-07','12:08:00',NULL,NULL,NULL,NULL,NULL,NULL,'V',NULL,_binary 'Problema elétrico resolvido pelo setor de obras.',NULL,0,'C','P',NULL,'Queda de Link',NULL,NULL,NULL,NULL,_binary 'Local :Prédio da Secretaria de Segurança pública\r\n\r\nSinal da Operadora  ok mas não replica para o pontos de acesso. Verificar problemas internos nos equipamentos','2026-04-16','10:57:00','2026-04-16','17:00:00','C',112,51,NULL,NULL,NULL,NULL,16,16),(107,16,16,30,0,0,1,NULL,7,NULL,'2026-04-16','11:49:04','2026-04-16','11:49:00',NULL,NULL,NULL,NULL,NULL,NULL,'V',NULL,_binary 'Descrição do e-mail:\r\n\r\ncomunicacaogcmsabara@sabara.mg.gov.br\r\nplanejamentooperacionalgcmsabara@sabara.mg.gov.br\r\nfiscalizacaodeobras@sabara.mg.gov.br\r\nsecaotilogisticaepessoalgcm@sabara.mg.gov.br\r\ncorregedoriagcm@sabara.mg.gov.br\r\nSenha inicial : sabara@2026',NULL,0,'C','P',NULL,'Criação de Conta de e-mail',NULL,NULL,NULL,NULL,_binary 'Descrição do e-mail (ex. <descricao>@sabara.mg.gov.br:\r\n\r\ncomunicacaogcmsabara@sabara.mg.gov.br\r\nplanejamentooperacionalgcmsabara@sabara.mg.gov.br\r\nfiscalizacaodeobras@sabara.mg.gov.br\r\nsecaotilogisticaepessoalgcm@sabara.mg.gov.br\r\ncorregedoriagcm@sabara.mg.gov.br\r\n\r\nResponsável :Glisia','2026-04-16','11:49:00','2026-04-16','13:49:00','C',113,10,NULL,NULL,NULL,NULL,16,16),(108,16,16,11,0,0,1,NULL,7,NULL,'2026-04-17','15:26:14','2026-04-17','15:26:00',NULL,NULL,NULL,NULL,NULL,NULL,'V',NULL,_binary 'Login do Usuário:lucas.lima\r\nSenha Inicial :sabara@2026',NULL,0,'C','P',NULL,'Inclusão de usuários de rede / computador',NULL,NULL,NULL,NULL,_binary 'Nome do usuário : Lucas Matos dos Santos Lima\r\nPastas de acesso na rede :Meio Ambiente','2026-04-17','15:26:00','2026-04-17','16:26:00','C',115,54,NULL,NULL,NULL,NULL,16,16),(109,16,16,11,0,0,1,NULL,7,NULL,'2026-04-17','15:28:10','2026-04-17','15:28:00',NULL,NULL,NULL,NULL,NULL,NULL,'V',NULL,_binary 'Login do Usuário :lucas.lima\r\nSenha de Acesso :123456',NULL,0,'C','P',NULL,'Protocoloweb - Inclusão de novo Usuário',NULL,NULL,NULL,NULL,_binary 'Nome do Usuário: Lucas Matos dos Santos Lima\r\nCPF: não informado\r\nLocais de Tramitação :Meio Ambiente','2026-04-17','15:28:00','2026-04-17','15:58:00','C',116,62,NULL,NULL,NULL,NULL,16,16),(110,16,16,7,0,0,1,NULL,11,NULL,'2026-04-22','11:13:08','2026-04-22','11:44:00',NULL,NULL,NULL,NULL,NULL,NULL,'V',NULL,_binary 'Foi alterada a porta no rack central. Testes realizados ok',NULL,0,'C','P',NULL,'Internet - sem acesso',NULL,NULL,NULL,NULL,_binary 'local :Computador da Maria Clara do planejamento sem internet','2026-04-22','11:13:00','2026-04-22','14:13:00','C',117,43,NULL,NULL,NULL,NULL,16,28),(111,16,16,6,0,0,1,NULL,7,NULL,'2026-04-22','11:38:26','2026-04-22','11:38:00',NULL,NULL,NULL,NULL,NULL,NULL,'V',NULL,_binary 'Login do Usuário: jean.roque\r\nSenha Inicial : sabara@2026',NULL,0,'C','P',NULL,'Inclusão de usuários de rede / computador',NULL,NULL,NULL,NULL,_binary 'Nome do usuário :Jean Carlos Macario Roque\r\nPastas de acesso na rede :Administração e transporte','2026-04-22','11:38:00','2026-04-22','12:38:00','C',118,54,NULL,NULL,NULL,NULL,16,16),(112,16,16,6,0,0,1,NULL,7,NULL,'2026-04-22','11:41:01','2026-04-22','11:41:00',NULL,NULL,NULL,NULL,NULL,NULL,'V',NULL,_binary 'Usuário de Acesso : jean.roque\r\nSenha de Acesso :sabara@2026\r\n\r\nUsuário do(s) módulo(s) :jean.roque\r\nSenha do(s) módulo(s) :sabara@2026',NULL,0,'C','P',NULL,'Sistema Moderna - Criação de Usuário',NULL,NULL,NULL,NULL,_binary 'Nome do usuário :Jean Carlos Macario Roque\r\nnúmero do CPF : 128.409.566-59\r\nModulos que irá acessar (compras, estoque, contabilidade, pregão, credores, frotas, prestação de contas, patrimônio :Compras\r\n\r\n','2026-04-22','11:41:00','2026-04-22','13:41:00','C',119,15,NULL,NULL,NULL,NULL,16,16),(113,16,16,6,0,0,1,NULL,7,NULL,'2026-04-22','11:44:25','2026-04-22','11:44:00',NULL,NULL,NULL,NULL,NULL,NULL,'V',NULL,_binary 'Login do Usuário :jean.roque\r\nSenha de Acesso :123456',NULL,0,'C','P',NULL,'Protocoloweb - Inclusão de novo Usuário',NULL,NULL,NULL,NULL,_binary 'Nome do Usuário: Jean Carlos Macario Roque\r\nCPF:128.409.566-59\r\nLocais de Tramitação :Transporte','2026-04-22','11:44:00','2026-04-22','12:14:00','C',120,62,NULL,NULL,NULL,NULL,16,16),(114,30,30,11,17,0,26,NULL,12,NULL,'2026-04-23','11:08:39','2026-04-23','11:18:00',NULL,NULL,NULL,NULL,NULL,NULL,'R',NULL,_binary 'add ao domínio',NULL,0,'C','P',NULL,'Desktop - Incluir desktop na rede',NULL,NULL,NULL,NULL,_binary 'Patrimônio : 97354\r\n\r\nFalha de confiança (domínio)','2026-04-23','11:08:00','2026-04-24','11:08:00','C',121,24,NULL,NULL,NULL,NULL,30,30),(115,30,30,14,0,0,26,NULL,12,NULL,'2026-04-23','08:00:08','2026-04-24','09:07:00',NULL,NULL,NULL,NULL,NULL,NULL,'V',NULL,_binary 'Acompanhamento efetuado com sucesso',NULL,0,'C','P',NULL,'Acompanhamento de serviço de TI',NULL,NULL,NULL,NULL,_binary 'Descrição do Serviço: Acompanhamento na mudança de local físico dos desktop','2026-04-23','11:21:00','2026-04-23','17:00:00','C',122,59,NULL,NULL,NULL,NULL,30,16),(116,30,30,7,0,0,26,NULL,12,NULL,'2026-04-23','11:37:39','2026-04-24','09:09:00',NULL,NULL,NULL,NULL,NULL,NULL,'V',NULL,_binary 'Acompanhamento realizado com sucesso',NULL,0,'C','P',NULL,'Acompanhamento de serviço de TI',NULL,NULL,NULL,NULL,_binary 'Descrição do Serviço: Acompanhamento na mudança de local físico dos desktop, setor de Arquitetura','2026-04-23','11:37:00','2026-04-23','19:37:00','C',123,59,NULL,NULL,NULL,NULL,30,16),(117,30,30,8,0,0,26,NULL,12,NULL,'2026-04-23','08:00:40','2026-04-24','09:09:00',NULL,NULL,NULL,NULL,NULL,NULL,'V',NULL,_binary 'Acompamento realizado com sucesso',NULL,0,'C','P',NULL,'Acompanhamento de serviço de TI',NULL,NULL,NULL,NULL,_binary 'Descrição do Serviço: Acompanhamento na mudança de local físico dos desktop (setor de Fiscalização)','2026-04-23','11:39:00','2026-04-23','17:00:00','C',124,59,NULL,NULL,NULL,NULL,30,16),(118,30,30,9,0,0,26,'2026-04-27',12,'13:10:00','2026-04-23','11:42:00','2026-04-28','14:46:00','2026-04-27','2026-04-27','13:10:00','2026-04-27',NULL,NULL,'V','',_binary 'Serviço realizado com sucesso',0,0,'C','P','','Impressora - Scanner',NULL,'C','',NULL,_binary 'SELB da impressora: Configuração de scanner, na Regional Centro','2026-04-23','11:42:00','2026-04-27','11:42:00','C',125,35,NULL,NULL,NULL,NULL,30,16),(119,28,28,8,0,0,1,NULL,11,NULL,'2026-04-23','14:29:04','2026-04-23','14:29:00',NULL,NULL,NULL,NULL,NULL,NULL,'V',NULL,_binary 'Instalação realizada com sucesso, testes ok',NULL,0,'C','P',NULL,'Instalação',NULL,NULL,NULL,NULL,_binary 'Novo monitor para Contabilidade','2026-04-23','14:29:00','2026-04-23','15:29:00','C',126,75,NULL,NULL,NULL,NULL,28,28),(120,16,16,9,0,0,26,NULL,8,NULL,'2026-04-24','09:15:24','2026-04-24','15:00:00',NULL,NULL,NULL,NULL,NULL,NULL,'V',NULL,_binary 'Cabo de Rede Liberado',NULL,0,'C','P',NULL,'Confecção de Cabo de Rede',NULL,NULL,NULL,NULL,_binary 'Local a ser utilizado : Secretaria de Obras (Alexandra)\r\nTamanho em Metro : 4 metros ','2026-04-24','09:15:00','2026-04-24','12:15:00','C',127,76,NULL,NULL,NULL,NULL,16,16),(121,16,16,7,0,0,26,NULL,8,NULL,'2026-04-24','09:20:26','2026-04-24','15:02:00',NULL,NULL,NULL,NULL,NULL,NULL,'V',NULL,_binary 'Manutenção do ponto de rede realizada com sucesso',NULL,0,'C','P',NULL,'Manutenção de Ponto de Rede',NULL,NULL,NULL,NULL,_binary 'Local:Ponto da máquina de Maria Clara no planejamento\r\nNúmero de pontos :1','2026-04-24','09:20:00','2026-04-24','11:50:00','C',128,68,NULL,NULL,NULL,NULL,16,16),(122,28,28,32,0,0,1,NULL,11,NULL,'2026-04-24','15:59:49','2026-04-24','16:04:00',NULL,NULL,NULL,NULL,NULL,NULL,'V',NULL,_binary 'Foram instalados dois cabos (sendo 1 de reserva) Cat 5e de aproximadamente 5 metros na nova sala do Controlador Geral. Testes ok.',NULL,0,'C','P',NULL,'Instalação de Ponto de rede',NULL,NULL,NULL,NULL,_binary 'Local: Sala do Controlador\r\nNúmero de pontos: 2','2026-04-24','15:59:00','2026-04-25','15:59:00','C',129,48,NULL,NULL,NULL,NULL,28,28),(123,16,16,11,18,0,26,NULL,12,NULL,'2026-04-27','10:27:45','2026-04-30','16:53:00',NULL,NULL,NULL,NULL,NULL,NULL,'R',NULL,_binary 'Atualizado bios, defrag de Hd e limpesa de arquivos\r\n\r\nMaquina liberada com boa funcionalidade',NULL,0,'C','P',NULL,'Desktop - Lentidão do desktop',NULL,NULL,NULL,NULL,_binary 'Patrimõnio do Computador : informado no cadastro\r\nUsuário:Diogo Nunes\r\n\r\nComputador com lentidão necessário formatação','2026-04-27','10:28:00','2026-04-30','10:27:00','C',130,19,NULL,NULL,NULL,NULL,16,16),(124,16,16,8,0,0,1,NULL,7,NULL,'2026-04-27','12:07:46','2026-04-27','14:07:00',NULL,NULL,NULL,NULL,NULL,NULL,'V',NULL,_binary 'Aplicativo instalado com sucesso',NULL,0,'C','P',NULL,'Instalação do aplicativo no computador',NULL,NULL,NULL,NULL,_binary 'Local:Contabilidade\r\nUsuário:Maria Goulart','2026-04-27','12:07:00','2026-04-27','14:37:00','C',131,77,NULL,NULL,NULL,NULL,16,16),(125,16,16,30,19,0,26,NULL,12,NULL,'2026-04-27','15:58:49','2026-04-28','16:44:00',NULL,NULL,NULL,NULL,NULL,NULL,'R',NULL,_binary 'Conclusão : Sistema Operacional instalado, atualizado e configurado; \"programas padrão\" instalados; adicionado ao domínio PMS; adicionado usuário administrador.',NULL,0,'C','P',NULL,'Manutenção de Computadores DeskTop',NULL,NULL,NULL,NULL,_binary 'Instalação e Configuração de sistema operacional Linux','2026-04-27','15:59:00','2026-04-30','15:58:00','C',132,70,NULL,NULL,NULL,NULL,16,30),(126,28,28,7,0,0,1,NULL,11,NULL,'2026-04-27','16:17:12','2026-04-27','16:17:00',NULL,NULL,NULL,NULL,NULL,NULL,'V',NULL,_binary 'Impressora instalada para servidora Elem. testes ok!',NULL,0,'C','P',NULL,'Impressoras - Instalação',NULL,NULL,NULL,NULL,_binary 'instalação de impressora do RH para setor de fiscalização','2026-04-27','16:17:00','2026-04-27','18:17:00','C',133,36,NULL,NULL,NULL,NULL,28,28),(127,16,16,8,0,0,1,NULL,7,NULL,'2026-04-27','16:20:15','2026-04-27','16:20:00',NULL,NULL,NULL,NULL,NULL,NULL,'V',NULL,_binary 'Login do Usuário:maria.xavier\r\nSenha Inicial :sabara@2026',NULL,0,'C','P',NULL,'Inclusão de usuários de rede / computador',NULL,NULL,NULL,NULL,_binary 'Nome do usuário : Maria Luiza Ferreira Rodrigues Xavier\r\nPastas de acesso na rede :faCadastro','2026-04-27','16:20:00','2026-04-27','17:20:00','C',134,54,NULL,NULL,NULL,NULL,16,16),(128,16,16,28,0,0,1,NULL,7,NULL,'2026-04-28','09:54:16','2026-04-28','09:54:00',NULL,NULL,NULL,NULL,NULL,NULL,'V',NULL,_binary 'Usuário de Acesso :Já possui\r\nSenha de Acesso :Já possui\r\n\r\nUsuário do(s) módulo(s) : mariana.tomaz\r\nSenha do(s) módulo(s) :sabara@2026',NULL,0,'C','P',NULL,'Sistema Moderna - Criação de Usuário',NULL,NULL,NULL,NULL,_binary 'Nome do usuário :Mariana Virginia Tomaz de Macedo\r\nnúmero do CPF : 074.930.506-19\r\nModulos que irá acessar (compras, estoque, contabilidade, pregão, credores, frotas, prestação de contas, patrimônio :Estoque\r\n\r\n','2026-04-28','09:54:00','2026-04-28','11:54:00','C',135,15,NULL,NULL,NULL,NULL,16,16),(129,16,16,7,0,0,26,NULL,12,NULL,'2026-04-28','11:38:06','2026-04-28','14:45:00',NULL,NULL,NULL,NULL,NULL,NULL,'V',NULL,_binary 'Reparação feita com sucesso. Atualização  do office 365',NULL,0,'C','P',NULL,'Reparo de software',NULL,NULL,NULL,NULL,_binary 'Descrição do software :office\r\nPossui licença? (sim/Não) : Sim','2026-04-28','11:38:00','2026-04-28','13:38:00','C',137,52,NULL,NULL,NULL,NULL,16,16),(130,16,16,8,0,0,26,NULL,12,NULL,'2026-04-29','10:02:40',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'V',NULL,NULL,NULL,NULL,'C','P',NULL,'Instalação de Software',NULL,NULL,NULL,NULL,_binary 'Possui Licença(sim/não) ? sim\r\nDescrição do software a ser instalado: gerenciador de segurança do Banco do Brasil','2026-04-29','10:02:00','2026-04-29','12:02:00','X',139,28,'2026-04-29',_binary 'Software de gestão de segurança do banco do brasil voltou a funcionar','10:37:00',16,16,NULL),(131,16,16,7,0,0,26,'2026-04-29',8,'14:59:00','2026-04-29','11:23:00','2026-04-30','16:51:00','2026-04-29','2026-04-29','14:59:00','2026-04-29',NULL,NULL,'V','',_binary '2 novos pontos ativos\r\nImpressora ativa na rede\r\n3 pcs linux configurados\r\npontos reativados no patchpanel',0,0,'C','P','','Instalação de Ponto de rede',NULL,'C','',NULL,_binary 'Local:procon\r\nNúmero de pontos : 3 pontos de rede','2026-04-29','11:26:00','2026-04-29','17:00:00','C',140,48,NULL,NULL,NULL,NULL,16,16),(132,16,16,7,0,0,26,NULL,8,NULL,'2026-04-29','12:02:14',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'V',NULL,NULL,NULL,NULL,'C','P',NULL,'Instalação de Ponto de rede',NULL,NULL,NULL,NULL,_binary 'Local: Procon de Sabará\r\nNúmero de pontos:2 pontos para ligar 2 computadores','2026-04-29','12:02:00','2026-04-29','17:02:00','X',59,48,'2026-04-29',_binary 'Ordem gerada em duplicidade','12:02:00',16,16,NULL),(133,28,28,31,0,0,1,NULL,11,NULL,'2026-04-30','13:51:03','2026-04-30','13:51:00',NULL,NULL,NULL,NULL,NULL,NULL,'V',NULL,_binary 'Testes de ping estavam ok e realmente paralisou o serviço de internet em vários navegadores, após reinício do computador realizado testes e confirmado pelo usuário que estava ok',NULL,0,'C','P',NULL,'Internet - sem acesso',NULL,NULL,NULL,NULL,_binary 'local : Gabinete do Prefeito, Leandro, computador apresenta lentidão para acessar sites','2026-04-30','13:51:00','2026-04-30','16:51:00','C',141,43,NULL,NULL,NULL,NULL,28,28),(134,16,16,10,0,0,1,NULL,7,NULL,'2026-04-30','14:34:20','2026-04-30','14:35:00',NULL,NULL,NULL,NULL,NULL,NULL,'V',NULL,_binary 'Responsável pelo transporte:Secretária do Cars Castanheira (Patricia)',0,0,'C','P',NULL,'Impressoras - Solicitação de toner',NULL,NULL,NULL,NULL,_binary 'CRAS Castanheiras','2026-04-30','14:34:00','2026-04-30','15:04:00','C',142,41,NULL,NULL,NULL,NULL,16,16),(135,30,30,8,20,0,26,NULL,12,NULL,'2026-05-04','15:13:19','2026-05-04','16:49:00',NULL,NULL,NULL,NULL,NULL,NULL,'R',NULL,_binary 'Limpezas e atualizações realizadas. \r\n(Considero o computador \"final de meia-vida\").',NULL,0,'C','P',NULL,'Desktop - Lentidão do desktop',NULL,NULL,NULL,NULL,_binary 'Patrimõnio do Computador : 83332\r\nUsuário: luciane.firmo\r\n\r\nPC apresenta lentidão; realizar limpeza; realizar atualização de drivers.','2026-05-04','15:13:00','2026-05-06','15:13:00','C',143,19,NULL,NULL,NULL,NULL,30,30),(136,16,16,6,0,0,1,NULL,7,NULL,'2026-05-05','09:36:11','2026-05-05','09:36:00',NULL,NULL,NULL,NULL,NULL,NULL,'V',NULL,_binary 'Login do Usuário:Franklin.hilario\r\nSenha Inicial : Sabara@2026',NULL,0,'C','P',NULL,'Inclusão de usuários de rede / computador',NULL,NULL,NULL,NULL,_binary 'Nome do usuário :Franklin.hilario\r\nPastas de acesso na rede : administração','2026-05-05','09:36:00','2026-05-05','10:36:00','C',144,54,NULL,NULL,NULL,NULL,16,16),(137,16,16,8,20,0,26,NULL,8,NULL,'2026-05-05','10:37:58','2026-05-08','09:34:00',NULL,NULL,NULL,NULL,NULL,NULL,'R',NULL,_binary 'Atualização de drivers; ',NULL,0,'C','P',NULL,'Desktop - Travamento',NULL,NULL,NULL,NULL,_binary 'Patrimônio :83332\r\n','2026-05-05','10:38:00','2026-05-07','10:37:00','C',145,22,NULL,NULL,NULL,NULL,16,30),(138,16,16,5,0,0,27,NULL,9,NULL,'2026-05-05','11:39:18','2026-05-08','11:35:00',NULL,NULL,NULL,NULL,NULL,NULL,'V',NULL,_binary 'Foi disponibilizado Servidor Virtual para instalação do software',NULL,0,'C','P',NULL,'Desktop - Solicitação de Novo Computador',NULL,NULL,NULL,NULL,_binary 'Usuário : Ortep\r\nAtividade a ser executada :Computador para sistema da Ortep de relógio de ponto da secretaria de Saúde ','2026-05-05','11:39:00','2026-05-08','11:39:00','C',146,9,NULL,NULL,NULL,NULL,16,16),(139,16,16,29,0,0,1,NULL,7,NULL,'2026-05-05','14:37:35',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'V',NULL,NULL,NULL,NULL,'C','P',NULL,'Emprestimo de Projetor',NULL,NULL,NULL,NULL,_binary 'Responsável:Ludmila dos Santos Martins\r\nData e hora: 21/05/2026, às 10h00\r\nMotivo:reunião com representantes da Vale e Defesa Civil de Santa Luzia\r\nLocal:Solar Padre correia','2026-05-05','14:37:00','2026-05-22','14:38:00','X',147,78,'2026-05-22',_binary 'Evento foi cancelado','15:40:00',16,16,NULL),(140,16,16,28,0,0,1,NULL,7,NULL,'2026-05-05','14:47:35','2026-05-05','14:48:00',NULL,NULL,NULL,NULL,NULL,NULL,'V',NULL,_binary 'Responsável pelo transporte:Motorista da Creche',0,0,'C','P',NULL,'Impressoras - Solicitação de toner',NULL,NULL,NULL,NULL,_binary 'Se for impressora colorida, qual a cor to toner ?:\r\nSELB da Impressora :Creche','2026-05-05','14:47:00','2026-05-05','15:17:00','C',148,41,NULL,NULL,NULL,NULL,16,16),(141,16,16,10,0,0,1,NULL,11,NULL,'2026-05-05','16:48:46','2026-05-05','16:49:00',NULL,NULL,NULL,NULL,NULL,NULL,'V',NULL,_binary 'Responsável pelo transporte:Conselho Tutelar',0,0,'C','P',NULL,'Impressoras - Solicitação de toner',NULL,NULL,NULL,NULL,_binary 'Se for impressora colorida, qual a cor to toner ?:\r\nSELB da Impressora :Conselho Tutelar','2026-05-05','16:48:00','2026-05-05','17:18:00','C',149,41,NULL,NULL,NULL,NULL,16,16),(142,16,16,28,0,0,1,NULL,11,NULL,'2026-05-07','08:59:14','2026-05-07','09:00:00',NULL,NULL,NULL,NULL,NULL,NULL,'V',NULL,_binary 'Responsável pelo transporte:Adriana',0,0,'C','P',NULL,'Impressoras - Solicitação de toner',NULL,NULL,NULL,NULL,_binary 'Se for impressora colorida, qual a cor to toner ?:\r\nSELB da Impressora :Cei Nancy Borges','2026-05-07','08:59:00','2026-05-07','09:29:00','C',150,41,NULL,NULL,NULL,NULL,16,16),(143,16,16,7,0,0,26,'2026-05-07',12,'17:02:00','2026-05-07','11:17:00','2026-05-08','09:35:00','2026-05-07','2026-05-07','17:02:00','2026-05-07',NULL,NULL,'V','',_binary 'Atualização de drivers; troca de cabo VGA.',0,0,'C','P','','Monitor - Sem Imagem',NULL,'C','',NULL,_binary 'Patrimônio :não informa - Computador da stafany\r\nChecou cabos de energia e dados (sim/não) : Sim\r\nCabo vga da segunda tela com problema. ','2026-05-07','11:17:00','2026-05-09','11:17:00','C',151,26,NULL,NULL,NULL,NULL,16,30),(144,16,16,6,0,0,1,NULL,7,NULL,'2026-05-07','11:20:54','2026-05-07','11:44:00',NULL,NULL,NULL,NULL,NULL,NULL,'V',NULL,_binary 'Usuário de Acesso :juliana.santos\r\nSenha de Acesso :sabara@2026\r\n\r\nUsuário do(s) módulo(s) :juliana.santos\r\nSenha do(s) módulo(s) :sabara@2026',NULL,0,'C','P',NULL,'Sistema Moderna - Criação de Usuário',NULL,NULL,NULL,NULL,_binary 'Nome do usuário :Juliana Santos de Morais \r\nnúmero do CPF :10525768696\r\nModulos que irá acessar (compras, estoque, contabilidade, pregão, credores, frotas, prestação de contas, patrimônio :\r\nacesso no Patrimônio - Contabilidade e Estoque\r\n\r\n','2026-05-07','11:21:00','2026-05-07','13:20:00','C',152,15,NULL,NULL,NULL,NULL,16,16),(145,16,16,28,0,0,26,NULL,12,NULL,'2026-05-07','13:56:24','2026-05-07','13:57:00',NULL,NULL,NULL,NULL,NULL,NULL,'V',NULL,_binary 'Responsável pelo transporte:Responsável da Creche',0,0,'C','P',NULL,'Impressoras - Solicitação de toner',NULL,NULL,NULL,NULL,_binary 'Se for impressora colorida, qual a cor to toner ?:\r\nSELB da Impressora :creche Perdigão de Roça Grande','2026-05-07','13:56:00','2026-05-07','14:26:00','C',153,41,NULL,NULL,NULL,NULL,16,16),(146,28,28,7,0,0,1,NULL,11,NULL,'2026-05-07','15:16:52','2026-05-07','15:17:00',NULL,NULL,NULL,NULL,NULL,NULL,'V',NULL,_binary 'Foi instalada em duas máquinas do setor de Geo o software gratuito QGIS. Para leitura e criação de mapas em formato SHAPE e JSON bem como ler as camadas criadas pela empresa Topocart',NULL,0,'C','P',NULL,'Desktop - Instalação e Desinstalação',NULL,NULL,NULL,NULL,_binary 'Patrimonio:\r\nInstalação do software QGIS em duas máquinas do setor de Geo.','2026-05-07','15:16:00','2026-05-07','17:16:00','C',154,23,NULL,NULL,NULL,NULL,28,28),(147,30,30,7,0,0,26,NULL,12,NULL,'2026-05-07','09:30:39','2026-05-07','17:18:00',NULL,NULL,NULL,NULL,NULL,NULL,'V',NULL,_binary 'Foram trocados os cabos de video (VGA/HDMI); foi feita atualização dos drives da maquina; reinicialização.',NULL,0,'C','P',NULL,'Monitor - Não está Ligando',NULL,NULL,NULL,NULL,_binary 'Patrimônio :\r\nchecou cabos de energia (sim/não)? sim\r\nMonitor 2 não apresenta video','2026-05-07','17:17:00','2026-05-07','13:00:00','C',155,25,NULL,NULL,NULL,NULL,30,30),(148,30,30,7,15,0,26,NULL,12,NULL,'2026-05-07','10:20:16','2026-05-07','17:27:00',NULL,NULL,NULL,NULL,NULL,NULL,'R',NULL,_binary 'Pacote Office 2016 desinstalado; reinstall do pacote Office 2016; inserção do serial; ',NULL,0,'C','P',NULL,'Reparo de software',NULL,NULL,NULL,NULL,_binary 'Descrição do software :\r\nPossui licença? (sim/Não) : Sim\r\nOffice Professional Plus 2016 não estava funcionando.','2026-05-07','17:26:00','2026-05-07','12:40:00','C',156,52,NULL,NULL,NULL,NULL,30,30),(149,16,16,18,0,0,26,NULL,8,NULL,'2026-05-11','10:23:19','2026-05-11','14:12:00',NULL,NULL,NULL,NULL,NULL,NULL,'V',NULL,_binary 'Foi reconfigurado a impressora e instalado drivers novos nos computadores com novo ip e 3 computadores do setor',NULL,0,'C','P',NULL,'Impressoras - Não está imprimindo',NULL,NULL,NULL,NULL,_binary 'SELB da Impressora :Regional Ana Lucia\r\nImpressora apresentando mensagem off line','2026-05-11','10:23:00','2026-05-11','17:00:00','C',157,38,NULL,NULL,NULL,NULL,16,16),(150,16,16,10,0,0,1,NULL,7,NULL,'2026-05-11','11:54:44','2026-05-11','11:55:00',NULL,NULL,NULL,NULL,NULL,NULL,'V',NULL,_binary 'Responsável pelo transporte:Jonathen Felix',0,0,'C','P',NULL,'Impressoras - Solicitação de toner',NULL,NULL,NULL,NULL,_binary 'Se for impressora colorida, qual a cor to toner ?:Preto\r\nSELB da Impressora :IM430','2026-05-11','11:54:00','2026-05-11','12:24:00','C',158,41,NULL,NULL,NULL,NULL,16,16),(151,16,16,29,0,0,1,NULL,7,NULL,'2026-05-11','14:17:57','2026-05-13','09:33:00',NULL,NULL,NULL,NULL,NULL,NULL,'V',NULL,_binary 'Foi criado novo mapeamento na rede para a defesa civil (DefesaCivil) e usuários forma remanejados para o novo compartilamento de rede',NULL,0,'C','P',NULL,'Inclusão de usuários de rede / computador',NULL,NULL,NULL,NULL,_binary 'Para inserção dos servidores na rede da Defesa Civil, seguem os logins dos usuários:\r\nludmila.martins\r\nviviane.aparecida\r\nfernanda.vitoria\r\ndouglas.martins\r\nguilherme.mendes\r\nyasmin.ribeiro\r\npaulo.rogério\r\npedro.paulo\r\nrafael.almeida\r\nleandro.eduardo\r\njonatas.viana','2026-05-11','14:18:00','2026-05-12','15:17:00','C',159,54,NULL,NULL,NULL,NULL,16,16),(152,16,16,28,0,0,1,NULL,7,NULL,'2026-05-11','15:00:02','2026-05-11','15:02:00',NULL,NULL,NULL,NULL,NULL,NULL,'V',NULL,_binary 'Responsável pelo transporte:Ti da Educação',0,0,'C','P',NULL,'Impressoras - Solicitação de toner',NULL,NULL,NULL,NULL,_binary 'Se for impressora colorida, qual a cor to toner ?:Preto e Margenta\r\nSELB da Impressora :Educação','2026-05-11','15:00:00','2026-05-11','15:30:00','C',160,41,NULL,NULL,NULL,NULL,16,16),(153,28,28,7,0,0,1,NULL,11,NULL,'2026-05-11','15:00:33','2026-05-11','15:02:00',NULL,NULL,NULL,NULL,NULL,NULL,'V',NULL,_binary 'testes ok',NULL,0,'C','P',NULL,'Impressoras - Instalação',NULL,NULL,NULL,NULL,_binary 'instalação impressora RH no setor de Projetos','2026-05-11','15:00:00','2026-05-11','17:00:00','C',161,36,NULL,NULL,NULL,NULL,28,28),(154,28,16,6,0,0,1,NULL,7,NULL,'2026-05-11','15:03:30','2026-05-11','15:06:00',NULL,NULL,NULL,NULL,NULL,NULL,'V',NULL,_binary 'instalação e testes ok',NULL,0,'C','P',NULL,'Impressoras - Instalação',NULL,NULL,NULL,NULL,_binary 'instalação impressora RH no setor de Serviços Gerais','2026-05-11','15:03:00','2026-05-11','17:03:00','C',163,36,NULL,NULL,NULL,NULL,16,28),(155,16,16,7,0,0,1,NULL,7,NULL,'2026-05-11','15:04:26','2026-05-11','15:05:00',NULL,NULL,NULL,NULL,NULL,NULL,'V',NULL,_binary 'Responsável pelo transporte:Jedean para o Pedro ',0,0,'C','P',NULL,'Impressoras - Solicitação de toner',NULL,NULL,NULL,NULL,_binary 'Se for impressora colorida, qual a cor to toner ?:Margenta\r\nSELB da Impressora :Gabinete','2026-05-11','15:04:00','2026-05-11','15:34:00','C',162,41,NULL,NULL,NULL,NULL,16,16),(156,28,28,33,0,0,1,NULL,11,NULL,'2026-05-11','15:12:42','2026-05-11','15:13:00',NULL,NULL,NULL,NULL,NULL,NULL,'V',NULL,_binary 'Foram instalados o primeiro acesso da Supernova para os usuários citados faltando apenas o sistema de dívida ativa a ser instalado pelo servidor Leonardo',NULL,0,'C','P',NULL,'Instalação do aplicativo no computador',NULL,NULL,NULL,NULL,_binary 'Local: Proju\r\nUsuário: Isasmin, Adriana e Bruno','2026-05-11','15:12:00','2026-05-11','15:42:00','C',164,77,NULL,NULL,NULL,NULL,28,28),(157,16,16,28,0,0,1,NULL,7,NULL,'2026-05-11','16:57:29','2026-05-11','16:58:00',NULL,NULL,NULL,NULL,NULL,NULL,'V',NULL,_binary '\r\n\r\nUsuário do(s) módulo(s) :adriana.lucia\r\nSenha do(s) módulo(s) :sabara@2026',NULL,0,'C','P',NULL,'Sistema Moderna - Criação de Usuário',NULL,NULL,NULL,NULL,_binary 'Nome: Adriana Lúcia da Silva\r\nCPF: 068.132.296-99\r\nModulos que irá acessar (compras, estoque, contabilidade, pregão, credores, frotas, prestação de contas, patrimônio :Estoque\r\n\r\n','2026-05-11','16:57:00','2026-05-11','18:57:00','C',165,15,NULL,NULL,NULL,NULL,16,16),(158,16,16,18,0,0,1,NULL,7,NULL,'2026-05-11','17:03:51','2026-05-11','17:04:00',NULL,NULL,NULL,NULL,NULL,NULL,'V',NULL,_binary 'Login do Usuário:jairo.chaves\r\nSenha Inicial :sabara@2026',NULL,0,'C','P',NULL,'Inclusão de usuários de rede / computador',NULL,NULL,NULL,NULL,_binary 'Nome do usuário : Jairo Chaves de Oliveira\r\nPastas de acesso na rede :Regionais','2026-05-11','17:03:00','2026-05-11','18:03:00','C',166,54,NULL,NULL,NULL,NULL,16,16),(159,16,16,6,0,0,1,NULL,7,NULL,'2026-05-12','09:27:13','2026-05-12','09:31:00',NULL,NULL,NULL,NULL,NULL,NULL,'V',NULL,_binary 'Login do Usuário :juliana.santos\r\nSenha de Acesso :123456',NULL,0,'C','P',NULL,'Protocoloweb - Inclusão de novo Usuário',NULL,NULL,NULL,NULL,_binary 'Nome do Usuário:Juliana Santos de Morais\r\nCPF:não informado\r\nLocais de Tramitação :Administração e patrimonio','2026-05-12','09:27:00','2026-05-12','09:57:00','C',167,62,NULL,NULL,NULL,NULL,16,16),(160,16,16,10,0,0,1,NULL,7,NULL,'2026-05-12','10:10:15','2026-05-12','10:14:00',NULL,NULL,NULL,NULL,NULL,NULL,'V',NULL,_binary 'usuário :dandara.sales\r\nSenha sabara@2026',NULL,0,'C','P',NULL,'Redefinição de senha de acesso rede / computador',NULL,NULL,NULL,NULL,_binary 'hais Marcela Lages Fialho\r\nCPF: 10635477688\r\n\r\nPermitir acesso a DS >> Suas\r\nSugestão: thais.fialho','2026-05-12','10:10:00','2026-05-12','11:10:00','C',168,55,NULL,NULL,NULL,NULL,16,16),(161,16,16,10,0,0,1,'2026-05-12',7,'13:13:00','2026-05-12','10:11:00','2026-05-12','10:13:00','2026-05-12','2026-05-12','13:13:00','2026-05-12',NULL,NULL,'V','',_binary 'Login do Usuário:dandara.sales\r\nSenha Inicial :sabara@2026',0,0,'C','P','','Redefinição de senha de acesso rede / computador',NULL,'C','',NULL,_binary 'Dandara Raiane Sales Ferreira \r\n065.215.316-03\r\nSugestão: dandara.sales\r\n\r\nAcesso pasta DS >> CRAS','2026-05-12','10:11:00','2026-05-12','11:11:00','C',169,54,NULL,NULL,NULL,NULL,16,16),(162,16,16,33,0,0,26,NULL,8,NULL,'2026-05-12','15:39:44','2026-05-12','15:40:00',NULL,NULL,NULL,NULL,NULL,NULL,'V',NULL,_binary 'Reinstalado drive da placa de video do site da dell. Monitor funcionando normalmente',NULL,0,'C','P',NULL,'Monitor - Sem Imagem',NULL,NULL,NULL,NULL,_binary 'Patrimônio :juridico (sueli)\r\nChecou cabos de energia e dados (sim/não) :sim','2026-05-12','15:39:00','2026-05-14','15:39:00','C',170,26,NULL,NULL,NULL,NULL,16,16),(163,30,30,9,0,0,26,NULL,12,NULL,'2026-05-12','09:40:48','2026-05-12','17:00:00',NULL,NULL,NULL,NULL,NULL,NULL,'V',NULL,_binary 'O S.O. é Linux; adicionei o pc ao domínio PMS; executei comandos update/upgrade; solicitei redefinição de senha de domínio para a usuária; configurei acesso para as pastas de rede; examinei ponto de acesso a rede; troquei o patch cord de porta no switch.',NULL,0,'C','P',NULL,'Desktop - Incluir desktop na rede',NULL,NULL,NULL,NULL,_binary 'Patrimônio :\r\nSolicita senha para acessar pastas/arquivos de rede.\r\nUSUÁRIO: tatiane.matias','2026-05-12','16:59:00','2026-05-12','12:20:00','C',171,24,NULL,NULL,NULL,NULL,30,30),(164,30,30,9,21,0,26,NULL,12,NULL,'2026-05-12','17:11:29','2026-05-15','15:31:00',NULL,NULL,NULL,NULL,NULL,NULL,'R',NULL,_binary 'Maquina atualizada, intalado office',NULL,0,'C','P',NULL,'Desktop - Instalação e Desinstalação',NULL,NULL,NULL,NULL,_binary 'Patrimonio: 103910\r\n\r\nPc foi redefinido para configurações de fábrica.\r\n','2026-05-12','17:11:00','2026-05-13','19:11:00','C',172,23,NULL,NULL,NULL,NULL,30,16),(165,16,16,32,0,0,1,NULL,7,NULL,'2026-05-13','10:49:31',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'V',NULL,NULL,NULL,NULL,'C','P',NULL,'Instalação de Ponto de rede',NULL,NULL,NULL,NULL,_binary 'Local:CPAD\r\nNúmero de pontos: 1 ponto\r\nContato : Andréa N. Neves','2026-05-13','10:49:00','2026-05-14','10:49:00','X',29,48,'2026-05-13',_binary 'Instalação não necessária','10:49:00',16,16,NULL),(166,16,16,6,22,0,26,NULL,10,NULL,'2026-05-13','11:51:17','2026-05-14','09:48:00',NULL,NULL,NULL,NULL,NULL,NULL,'R',NULL,_binary 'Mau contato nos conectores da placa mãe.',NULL,0,'C','P',NULL,'Desktop - Não liga',NULL,NULL,NULL,NULL,_binary 'Patrimônio :081940','2026-05-13','11:51:00','2026-05-18','11:51:00','C',173,20,NULL,NULL,NULL,NULL,16,27),(167,16,16,30,0,0,1,NULL,7,NULL,'2026-05-14','09:32:57',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'V',NULL,NULL,NULL,NULL,'C','P',NULL,'Telefonia - Solicitação Instalação',NULL,NULL,NULL,NULL,_binary 'Local:Patrulha Guardiã da Mulher\r\nReferência:próximo a guarda Municipal\r\nContato:Glisia','2026-05-14','09:33:00','2026-05-14','09:32:00','S',114,63,NULL,NULL,NULL,NULL,16,NULL),(168,16,16,10,0,0,1,NULL,7,NULL,'2026-05-14','09:33:27',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'V',NULL,NULL,NULL,NULL,'C','P',NULL,'Telefonia - Solicitação Ramal',NULL,NULL,NULL,NULL,_binary 'Local:Advocacia Municipal\r\nReferência:Setor de Advocacia Municipal\r\nContato:Isabel Bomtempo','2026-05-14','09:33:00','2026-05-14','09:33:00','S',138,64,NULL,NULL,NULL,NULL,16,NULL),(169,27,27,6,0,0,26,NULL,10,NULL,'2026-05-14','09:43:48','2026-05-14','09:54:00',NULL,NULL,NULL,NULL,NULL,NULL,'V',NULL,_binary 'Conclusão : Foi instalado um pente de 4GB de memória no computador da Bruna. Totalizando 8GB',NULL,0,'C','P',NULL,'Manutenção de Computadores DeskTop',NULL,NULL,NULL,NULL,_binary 'Instalar mais memória no computador da Bruna ','2026-05-14','09:44:00','2026-05-14','10:43:00','C',174,70,NULL,NULL,NULL,NULL,27,27),(170,27,27,6,0,0,26,NULL,10,NULL,'2026-05-13','09:46:31','2026-05-14','09:51:00',NULL,NULL,NULL,NULL,NULL,NULL,'V',NULL,_binary 'Conclusão : Realizei a clonagem de um HD para SSD, instalei o SSD e instalei mais 4GB de memória RAM.',NULL,0,'C','P',NULL,'Manutenção de Computadores DeskTop',NULL,NULL,NULL,NULL,_binary 'Realizar clonagem de um  HD para SSD, e instalar mais memória.','2026-05-14','09:46:00','2026-05-14','10:46:00','C',175,70,NULL,NULL,NULL,NULL,27,27),(171,16,16,7,0,0,26,NULL,8,NULL,'2026-05-14','10:36:29','2026-05-15','15:29:00',NULL,NULL,NULL,NULL,NULL,NULL,'V',NULL,_binary 'mudança realizada',NULL,0,'C','P',NULL,'Desktop - Instalação e Desinstalação',NULL,NULL,NULL,NULL,_binary 'Patrimonio:não informado\r\nComputador utilizado pela livia do planejamento. Mudança de Local\r\n','2026-05-14','10:36:00','2026-05-14','12:36:00','C',176,23,NULL,NULL,NULL,NULL,16,16),(172,32,16,33,0,0,1,NULL,7,NULL,'2026-05-15','11:41:13',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'V',NULL,NULL,NULL,NULL,'C','P',NULL,'Impressora - Scanner',NULL,NULL,NULL,NULL,_binary 'Solicito por gentileza que verifiquem se há possibilidade de disponibilizar 1 impressora tamanho comum/pequena.','2026-05-15','11:41:00','2026-05-22','11:41:00','X',178,35,'2026-05-21',_binary 'Usuário orientado a protocolar requisição junto a secretaria de planejamento como responsável pelo contrato de \r\nimpressoras. A Prefeitura não possui impressoras, todas são locadas junto a empresa Selbetti','21:34:00',16,16,NULL),(173,16,16,33,0,0,1,NULL,7,NULL,'2026-05-15','11:42:09','2026-05-15','11:43:00',NULL,NULL,NULL,NULL,NULL,NULL,'V',NULL,_binary 'Responsável pelo transporte:jedean',0,0,'C','P',NULL,'Impressoras - Solicitação de toner',NULL,NULL,NULL,NULL,_binary 'Se for impressora colorida, qual a cor to toner ?: Preto\r\nSELB da Impressora :Juridico','2026-05-15','11:42:00','2026-05-15','12:12:00','C',177,41,NULL,NULL,NULL,NULL,16,16),(174,33,16,32,0,0,1,NULL,7,NULL,'2026-05-15','12:04:31','2026-05-15','12:07:00',NULL,NULL,NULL,NULL,NULL,NULL,'V',NULL,_binary 'usuário do wi-fi lindaiane.almeida senha 1234 ',NULL,0,'C','U',NULL,'Instalação de rede wi-fi',NULL,NULL,NULL,NULL,_binary 'Local : Venho solicitar login de acesso a rede HOTSPOT, para:\r\n\r\nLindaiane Almeida \r\nCPF: 14232046623\r\nMatricula: 32550\r\n','2026-05-15','12:04:00','2026-05-16','12:04:00','C',179,49,NULL,NULL,NULL,NULL,16,16),(175,16,16,7,23,0,26,NULL,10,NULL,'2026-05-15','14:47:40','2026-05-19','08:55:00',NULL,NULL,NULL,NULL,NULL,NULL,'R',NULL,_binary 'Problema resolvido, foi feito uma limpeza nos componentes.',NULL,0,'C','P',NULL,'Desktop - Não liga',NULL,NULL,NULL,NULL,_binary 'Patrimônio :119306\r\n\r\nComputador não liga','2026-05-15','14:48:00','2026-05-19','14:47:00','C',180,20,NULL,NULL,NULL,NULL,16,27),(176,16,16,7,0,0,1,NULL,7,NULL,'2026-05-15','15:05:17','2026-05-15','15:05:00',NULL,NULL,NULL,NULL,NULL,NULL,'V',NULL,_binary 'Login do Usuário:poliana.torres\r\nSenha Inicial :sabara@2026',NULL,0,'C','P',NULL,'Inclusão de usuários de rede / computador',NULL,NULL,NULL,NULL,_binary 'Nome do usuário :Poliana Torres Frias Siqueira\r\nPastas de acesso na rede :pl, plAprovacao','2026-05-15','15:05:00','2026-05-15','16:05:00','C',181,54,NULL,NULL,NULL,NULL,16,16),(177,30,30,10,24,0,26,'2026-05-18',12,'18:11:00','2026-05-15','16:52:00','2026-05-20','09:53:00','2026-05-18','2026-05-18','18:11:00','2026-05-18',NULL,NULL,'R','',_binary 'Equipamento OK',0,0,'C','P','','Desktop - Lentidão do desktop',NULL,'C','',NULL,_binary 'Patrimõnio do Computador : 92784\r\nUsuário: Déborah\r\n\r\nComputador lento.','2026-05-15','16:52:00','2026-05-20','16:52:00','C',182,19,NULL,NULL,NULL,NULL,30,16),(178,22,16,27,0,0,1,NULL,7,NULL,'2026-05-18','09:54:39',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'V',NULL,NULL,NULL,NULL,'C','P',NULL,'Sistema Moderna - Bloqueiro de usuário',NULL,NULL,NULL,NULL,_binary 'Qual o Usuário ?\r\nMotivo da ação:','2026-05-18','09:55:00','2026-05-19','10:24:00','X',183,17,'2026-05-18',_binary 'teste de sistema','11:00:00',16,16,NULL),(179,16,16,7,0,0,1,NULL,11,NULL,'2026-05-18','10:56:40','2026-05-18','10:57:00',NULL,NULL,NULL,NULL,NULL,NULL,'V',NULL,_binary 'Responsável pelo transporte:Pedro Neves',0,0,'C','P',NULL,'Impressoras - Solicitação de toner',NULL,NULL,NULL,NULL,_binary 'Se for impressora colorida, qual a cor to toner ?: Preto\r\nSELB da Impressora :Planejamento','2026-05-18','10:56:00','2026-05-18','11:26:00','C',186,41,NULL,NULL,NULL,NULL,16,16),(180,22,16,27,0,0,1,NULL,7,NULL,'2026-05-18','11:18:47',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'V',NULL,NULL,NULL,NULL,'C','P',NULL,'Restaurar Arquivo de Backup',NULL,NULL,NULL,NULL,_binary 'Caminho  e Nome da pasta onde estava localizado o arquivo:\r\nNome do arquivo :','2026-05-18','11:19:00','2026-05-18','16:18:00','X',185,81,'2026-05-18',_binary 'teste de sistema','11:19:00',16,16,NULL),(181,22,16,27,0,0,1,NULL,7,NULL,'2026-05-18','11:19:47',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'V',NULL,NULL,NULL,NULL,'C','P',NULL,'Restaurar Arquivo de Backup',NULL,NULL,NULL,NULL,_binary 'Caminho  e Nome da pasta onde estava localizado o arquivo:\r\nNome do arquivo :','2026-05-18','11:19:00','2026-05-18','16:19:00','X',184,81,'2026-05-18',_binary 'teste de sistema','11:20:00',16,16,NULL),(182,16,16,5,0,0,1,NULL,7,NULL,'2026-05-18','11:27:13','2026-05-18','11:28:00',NULL,NULL,NULL,NULL,NULL,NULL,'V',NULL,_binary 'Responsável pelo transporte:Clayson',0,0,'C','P',NULL,'Impressoras - Solicitação de toner',NULL,NULL,NULL,NULL,_binary 'Se for impressora colorida, qual a cor to toner ?:Apena preto\r\nSELB da Impressora :Saúde','2026-05-18','11:27:00','2026-05-18','11:57:00','C',187,41,NULL,NULL,NULL,NULL,16,16),(183,27,27,7,0,0,26,NULL,10,NULL,'2026-05-18','12:19:57','2026-05-18','12:20:00',NULL,NULL,NULL,NULL,NULL,NULL,'V',NULL,_binary 'Computador não ligava, foi feito a limpeza e foi feito a formatação do computador.',NULL,0,'C','P',NULL,'Desktop - Não liga',NULL,NULL,NULL,NULL,_binary 'Patrimônio :119306\r\n\r\nComputador não esta ligando.','2026-05-18','12:20:00','2026-05-20','12:19:00','C',188,20,NULL,NULL,NULL,NULL,27,27),(184,16,16,8,0,0,26,'2026-05-18',12,'19:50:00','2026-05-18','16:49:00','2026-05-20','13:55:00','2026-05-18','2026-05-18','19:50:00','2026-05-18',NULL,NULL,'V','',_binary 'Conclusão : feitos update && upgrade; configuração de impressora; adicionados locais de rede (fa/publico); configuração de token virtual (inicialmente com erro de acesso).',0,0,'C','P','','Manutenção de Computadores DeskTop',NULL,'C','',NULL,_binary 'Estou com problema para logar no meu usuário através da minha máquina Linux. Quando insiro o usuário e digito a senha, aparece senha incorreta. Não obstante, quando insiro o mesmo usuário e senha numa máquina sistema windoms, o usuário entra normalmente. \r\n\r\nPodem me ajudar?\r\n\r\nAtenciosamente,\r\n\r\nMaria Luiza','2026-05-18','16:49:00','2026-05-19','16:49:00','C',189,70,NULL,NULL,NULL,NULL,16,30),(185,32,16,33,0,0,26,NULL,10,NULL,'2026-05-19','10:38:30','2026-05-19','12:05:00',NULL,NULL,NULL,NULL,NULL,NULL,'V',NULL,_binary 'Pje configurado corretamente. Foi detectado uso de certificado virtual da \"vidaas\" certicação em nuvem\r\nNecessário autenticação via celular do Procurador Municipal',NULL,0,'C','P',NULL,'Reparo de software',NULL,NULL,NULL,NULL,_binary 'Descrição do software :\r\nPossui licença? (sim/Não) : \r\nEstou tentando acessar o pje, quando aperto em certificado digital, após carregar por muito tempo, aparece erro \"Operação cancelada\".','2026-05-19','10:38:00','2026-05-19','12:38:00','C',190,52,NULL,NULL,NULL,NULL,16,16),(186,16,16,5,0,0,1,NULL,7,NULL,'2026-05-19','11:43:00','2026-05-19','11:43:00',NULL,NULL,NULL,NULL,NULL,NULL,'V',NULL,_binary 'Usuário do(s) módulo(s) :rafael.moreira\r\nSenha do(s) módulo(s) :sabara@2026',NULL,0,'C','P',NULL,'Sistema Moderna - Criação de Usuário',NULL,NULL,NULL,NULL,_binary 'Nome do usuário :Rafael Moreira\r\nnúmero do CPF : 08825117698\r\nModulos que irá acessar (compras, estoque, contabilidade, pregão, credores, frotas, prestação de contas, patrimônio) :\r\nContabilidade, credores, Prestação de Contas\r\n\r\n','2026-05-19','11:43:00','2026-05-19','13:43:00','C',191,15,NULL,NULL,NULL,NULL,16,16),(187,16,16,7,0,0,1,NULL,7,NULL,'2026-05-19','15:13:20','2026-05-19','15:13:00',NULL,NULL,NULL,NULL,NULL,NULL,'V',NULL,_binary 'Login do Usuário:ana.dutra e bianca.figueiredo\r\nSenha Inicial : sabara@2026',NULL,0,'C','P',NULL,'Inclusão de usuários de rede / computador',NULL,NULL,NULL,NULL,_binary 'Nome do usuário :Ana Luiza Dutra da Silva e Bianca Izabele Leão Figueiredo\r\nPastas de acesso na rede :pl, plReurb e plAprovacao','2026-05-19','15:13:00','2026-05-19','16:13:00','C',192,54,NULL,NULL,NULL,NULL,16,16),(188,16,16,34,0,0,26,NULL,12,NULL,'2026-05-20','15:02:51','2026-05-20','16:29:00',NULL,NULL,NULL,NULL,NULL,NULL,'V',NULL,_binary 'Configuração de impressora, alteração de local do telefone, verificação de dois pontos de rede',NULL,0,'C','P',NULL,'Internet - sem acesso',NULL,NULL,NULL,NULL,_binary 'local :Prédio do procom. Sem internet em compudador e consequentemente telefone','2026-05-20','15:03:00','2026-05-20','18:02:00','C',193,43,NULL,NULL,NULL,NULL,16,16),(189,32,16,33,0,0,1,NULL,7,NULL,'2026-05-20','15:51:41','2026-05-20','15:53:00',NULL,NULL,NULL,NULL,NULL,NULL,'V',NULL,_binary 'Nova senha de entrada : sabara@2026',NULL,0,'C','U',NULL,'Sistema Moderna - Bloqueiro de usuário',NULL,NULL,NULL,NULL,_binary 'Qual o Usuário ? jessica.barbosa\r\nMotivo da ação: erro de senha','2026-05-20','15:51:00','2026-05-20','16:21:00','C',194,17,NULL,NULL,NULL,NULL,16,16),(190,16,16,13,0,0,26,NULL,8,NULL,'2026-05-20','16:42:39','2026-05-22','15:39:00',NULL,NULL,NULL,NULL,NULL,NULL,'V',NULL,_binary 'Computador teve a bios atualizada e foi colocado no dominio de rede',NULL,0,'C','P',NULL,'Desktop - Incluir desktop na rede',NULL,NULL,NULL,NULL,_binary 'Patrimônio :099484','2026-05-20','16:42:00','2026-05-22','16:42:00','C',195,24,NULL,NULL,NULL,NULL,16,16),(191,16,16,28,0,0,1,NULL,7,NULL,'2026-05-21','08:53:59','2026-05-21','08:57:00',NULL,NULL,NULL,NULL,NULL,NULL,'V',NULL,_binary 'Responsável pelo transporte:Lucio Machado',0,0,'C','P',NULL,'Impressoras - Solicitação de toner',NULL,NULL,NULL,NULL,_binary 'Se for impressora colorida, qual a cor to toner ?:Preto\r\nSELB da Impressora :im430 Educação','2026-05-21','08:54:00','2026-05-21','09:23:00','C',196,41,NULL,NULL,NULL,NULL,16,16),(192,32,16,33,0,0,1,NULL,7,NULL,'2026-05-21','09:54:08','2026-05-21','10:10:00',NULL,NULL,NULL,NULL,NULL,NULL,'V',NULL,_binary 'Nova senha para computador / rede : sabara@2026',NULL,0,'C','U',NULL,'Redefinição de acessos do usuário na rede',NULL,NULL,NULL,NULL,_binary 'Login do usuário : natalya.duarte\r\nNovas pastas de acesso na rede : acesso ao computador e rede juridico','2026-05-21','09:54:00','2026-05-21','10:54:00','C',197,56,NULL,NULL,NULL,NULL,16,16),(193,32,16,33,0,0,26,NULL,12,NULL,'2026-05-21','10:49:22','2026-05-21','15:49:00',NULL,NULL,NULL,NULL,NULL,NULL,'V',NULL,_binary 'Problema de compatibilidade com o documento e o Microsoft Office 2019. O documento abriu no Writer - LibreOffice.',NULL,0,'C','P',NULL,'Acompanhamento de visita técnica',NULL,NULL,NULL,NULL,_binary 'Solicito suporte técnico devido a erro do word, arquivo não está abrindo. ','2026-05-21','10:49:00','2026-05-21','16:55:00','C',198,69,NULL,NULL,NULL,NULL,16,30),(194,16,16,30,0,0,1,NULL,7,NULL,'2026-05-21','15:05:20','2026-05-21','15:12:00',NULL,NULL,NULL,NULL,NULL,NULL,'V',NULL,_binary 'Responsável pelo transporte:Luizinho',0,0,'C','P',NULL,'Impressoras - Solicitação de toner',NULL,NULL,NULL,NULL,_binary 'Se for impressora colorida, qual a cor to toner ?:\r\nSELB da Impressora :Segurança Pública','2026-05-21','15:05:00','2026-05-21','15:35:00','C',199,41,NULL,NULL,NULL,NULL,16,16),(195,30,30,8,0,0,26,NULL,12,NULL,'2026-05-21','11:00:43','2026-05-21','16:02:00',NULL,NULL,NULL,NULL,NULL,NULL,'V',NULL,_binary 'Solicitação concluida. \r\nVerificação do usuário de rede;\r\nInstalação do módulo SUPERNOVA - MODERNA.',NULL,0,'C','P',NULL,'Desktop - Instalação e Desinstalação',NULL,NULL,NULL,NULL,_binary 'Patrimonio:\r\n\r\nVerificação da montagem do pc; verificação da instalação de programas padrão; configuração de impressoras (13.240 e 13.241)','2026-05-21','16:01:00','2026-05-21','11:50:00','C',200,23,NULL,NULL,NULL,NULL,30,30),(196,27,27,6,0,0,26,NULL,10,NULL,'2026-05-22','09:33:36','2026-05-22','09:34:00',NULL,NULL,NULL,NULL,NULL,NULL,'V',NULL,_binary 'Foi feito a formatação do computador e limpeza interna.',NULL,0,'C','P',NULL,'Reparo de software',NULL,NULL,NULL,NULL,_binary 'Descrição do software : Formatar computador RH\r\nPossui licença? (sim/Não) :\r\n\r\nPatrimônio 119037: ','2026-05-22','09:33:00','2026-05-22','11:33:00','C',201,52,NULL,NULL,NULL,NULL,27,27),(197,32,28,33,0,0,1,NULL,11,NULL,'2026-05-25','09:42:29','2026-05-25','09:43:00',NULL,NULL,NULL,NULL,NULL,NULL,'V',NULL,_binary 'O aparelho pertence à Secretaria de Planejamento no qual a funcionária Jéssica (Jurídico) tomou a iniciativa ao devolver o aparelho. Chamado encerrado',NULL,0,'C','P',NULL,'Telefonia - Manutenção',NULL,NULL,NULL,NULL,_binary 'Número Telefone:\r\nNúmero Ramal: \r\nCom a mudança de local, um dos telefones da Procuradoria estão recebendo chamadas que seriam destinadas à Secretaria de Planejamento. Solicito por gentileza que verifique.','2026-05-25','09:42:00','2026-05-25','09:42:00','C',202,65,NULL,NULL,NULL,NULL,28,28),(198,37,27,35,0,0,1,NULL,7,NULL,'2026-05-25','11:45:44','2026-05-25','11:47:00',NULL,NULL,NULL,NULL,NULL,NULL,'V',NULL,_binary 'Foi feio a reinstalação do supernova no computador.',NULL,0,'C','U',NULL,'Instalação do aplicativo no computador',NULL,NULL,NULL,NULL,_binary 'Local:RH\r\nUsuário:paulo.castro\r\n\r\nO SISTEMA SUPERNOVA NÃO ESTÁ ENTRANDO, DANDO MENSAGEM DE ERRO.\r\n\r\nASS. PAULO H','2026-05-25','11:46:00','2026-05-25','12:15:00','C',204,77,NULL,NULL,NULL,NULL,27,27),(199,34,16,29,0,0,26,NULL,8,NULL,'2026-05-25','15:19:00','2026-05-25','11:01:00',NULL,NULL,NULL,NULL,NULL,NULL,'V',NULL,_binary 'Desktop POSITIVO MASTER D480 esquentando o gabinete. Foi relatada melhora na performance do equipamento após reinício. \r\nO detalhe da máquina é aquecimento.',NULL,0,'C','P',NULL,'Desktop - Travamento',NULL,NULL,NULL,NULL,_binary 'Patrimônio :119304\r\n','2026-05-25','15:19:00','2026-05-26','15:19:00','C',203,22,NULL,NULL,NULL,NULL,16,30),(200,32,16,33,0,0,27,NULL,9,NULL,'2026-05-25','15:23:28','2026-05-25','16:38:00',NULL,NULL,NULL,NULL,NULL,NULL,'V',NULL,_binary 'Foi feito alteração do ip da impressora. Funcionando normalmente',NULL,0,'C','P',NULL,'Impressoras - Falha na impressão',NULL,NULL,NULL,NULL,_binary 'SELB da impressora :\r\nesta dando erro na fila de impressão de alguns computadores','2026-05-25','15:23:00','2026-05-28','15:23:00','C',205,37,NULL,NULL,NULL,NULL,16,16),(201,30,27,31,0,0,1,NULL,7,NULL,'2026-05-26','10:06:07','2026-05-26','10:07:00',NULL,NULL,NULL,NULL,NULL,NULL,'V',NULL,_binary 'Chamado resolvido, instalado a Impressora no computador.',NULL,0,'C','P',NULL,'Impressoras - Instalação',NULL,NULL,NULL,NULL,_binary 'SELB da Impressora :\r\n\r\nConfigurar os computadores com a impressora do setor Jurídico.\r\nUSUÁRIO: Etelvina Lana','2026-05-26','10:06:00','2026-05-26','12:06:00','C',206,36,NULL,NULL,NULL,NULL,27,27),(202,27,27,31,0,0,26,NULL,10,NULL,'2026-05-26','10:29:42','2026-05-26','10:31:00',NULL,NULL,NULL,NULL,NULL,NULL,'V',NULL,_binary 'Foi feita a instalação configuração da impressora no computador.',NULL,0,'C','P',NULL,'Impressoras - Instalação',NULL,NULL,NULL,NULL,_binary 'SELB da Impressora : Instalar impressora no computador Jéssica, gabinete.','2026-05-26','10:29:00','2026-05-26','12:29:00','C',208,36,NULL,NULL,NULL,NULL,27,27),(203,27,27,31,0,0,26,NULL,10,NULL,'2026-05-26','10:30:13','2026-05-26','10:30:00',NULL,NULL,NULL,NULL,NULL,NULL,'V',NULL,_binary 'Foi feito a instalação no computador.',NULL,0,'C','P',NULL,'Impressoras - Instalação',NULL,NULL,NULL,NULL,_binary 'SELB da Impressora : Instalar impressora no computador da Joelma, Gabinete.','2026-05-26','10:30:00','2026-05-26','12:30:00','C',207,36,NULL,NULL,NULL,NULL,27,27),(204,16,16,8,0,0,26,NULL,10,NULL,'2026-05-26','11:48:13','2026-05-26','11:49:00',NULL,NULL,NULL,NULL,NULL,NULL,'V',NULL,_binary 'Responsável pelo transporte:Edilson',0,0,'C','P',NULL,'Impressoras - Solicitação de toner',NULL,NULL,NULL,NULL,_binary 'Se for impressora colorida, qual a cor to toner ?:\r\nSELB da Impressora :Fazenda','2026-05-26','11:48:00','2026-05-26','12:18:00','C',209,41,NULL,NULL,NULL,NULL,16,16),(205,16,16,11,0,0,1,NULL,7,NULL,'2026-05-26','15:25:33','2026-05-26','15:27:00',NULL,NULL,NULL,NULL,NULL,NULL,'V',NULL,_binary 'Responsável pelo transporte:Meio Ambiente',0,0,'C','P',NULL,'Impressoras - Solicitação de toner',NULL,NULL,NULL,NULL,_binary 'Se for impressora colorida, qual a cor to toner ?:\r\nSELB da Impressora :IM 430','2026-05-26','15:25:00','2026-05-26','15:55:00','C',213,41,NULL,NULL,NULL,NULL,16,16),(206,16,16,7,0,0,1,NULL,7,NULL,'2026-05-26','15:25:55','2026-05-26','15:31:00',NULL,NULL,NULL,NULL,NULL,NULL,'V',NULL,_binary 'Erick Elias Usuário de rede e acesso ao supernova erick.elias  senha sabara@2026\r\nProtocoloweb erick.elias senha 123456\r\n\r\nIsmael Elias\r\n\r\nUsuário protocolo web ismael.elias senha 123456\r\nUsuário supernova acesso ismael.santos senha sabara@2026',NULL,0,'C','P',NULL,'Inclusão de usuários de rede / computador',NULL,NULL,NULL,NULL,_binary 'Nome do usuário :Erick Elias e Ismael Santos\r\nPastas de acesso na rede :Planejamento e Alvaras','2026-05-26','15:25:00','2026-05-26','16:25:00','C',212,54,NULL,NULL,NULL,NULL,16,16),(207,16,16,7,0,0,1,NULL,7,NULL,'2026-05-26','15:26:15','2026-05-26','15:30:00',NULL,NULL,NULL,NULL,NULL,NULL,'V',NULL,_binary 'Erick Elias Usuário de rede e acesso ao supernova erick.elias  senha sabara@2026\r\nProtocoloweb erick.elias senha 123456\r\n\r\nIsmael Elias\r\n\r\nUsuário protocolo web ismael.elias senha 123456\r\nUsuário supernova acesso ismael.santos senha sabara@2026',NULL,0,'C','P',NULL,'Protocoloweb - Inclusão de novo Usuário',NULL,NULL,NULL,NULL,_binary 'Nome do Usuário::Ismael dos Santos e Erick.elias\r\nCPF:182.728.986.40\r\nLocais de Tramitação :Planejamento','2026-05-26','15:26:00','2026-05-26','15:56:00','C',211,62,NULL,NULL,NULL,NULL,16,16),(208,16,16,7,0,0,1,NULL,7,NULL,'2026-05-26','15:26:34','2026-05-26','15:29:00',NULL,NULL,NULL,NULL,NULL,NULL,'V',NULL,_binary 'Erick Elias Usuário de rede e acesso ao supernova erick.elias  senha sabara@2026\r\nProtocoloweb erick.elias senha 123456\r\n\r\nIsmael Elias\r\n\r\nUsuário protocolo web ismael.elias senha 123456\r\nUsuário supernova acesso ismael.santos senha sabara@2026',NULL,0,'C','P',NULL,'Sistema Moderna - Criação de Usuário',NULL,NULL,NULL,NULL,_binary 'Nome do usuário :Ismael dos Santos e Erick.elias\r\nnúmero do CPF : 182.728.986.40 (Erick)\r\nModulos que irá acessar (compras, estoque, contabilidade, pregão, credores, frotas, prestação de contas, patrimônio :Acesso inicial\r\n\r\n','2026-05-26','15:26:00','2026-05-26','17:26:00','C',210,15,NULL,NULL,NULL,NULL,16,16),(209,16,16,9,0,0,1,NULL,7,NULL,'2026-05-27','11:41:03','2026-05-27','11:42:00',NULL,NULL,NULL,NULL,NULL,NULL,'V',NULL,_binary 'Responsável pelo transporte:Secretaria de Obras',0,0,'C','P',NULL,'Impressoras - Solicitação de toner',NULL,NULL,NULL,NULL,_binary 'Se for impressora colorida, qual a cor to toner ?:Margenta\r\nSELB da Impressora :Obras','2026-05-27','11:41:00','2026-05-27','12:11:00','C',214,41,NULL,NULL,NULL,NULL,16,16),(210,33,16,32,0,0,26,NULL,8,NULL,'2026-05-27','16:29:08','2026-05-28','09:31:00',NULL,NULL,NULL,NULL,NULL,NULL,'V',NULL,_binary 'Problema relatado não está relacionado a rede. Problema no notebook  do controlador que não está aceitando conexão via cabo.\r\n\r\nComputador será avalidado devido a não ser máquina da Prefeitura',NULL,0,'C','U',NULL,'Manutenção de Ponto de Rede',NULL,NULL,NULL,NULL,_binary 'Local: Sala do Controlador Dr. Samuel\r\nprecisa de ajuda quanto a um ponto de rede que parece que nao esta passando rede','2026-05-27','16:29:00','2026-05-27','17:59:00','C',215,68,NULL,NULL,NULL,NULL,16,16),(211,16,16,19,0,0,1,NULL,7,NULL,'2026-05-27','16:31:50','2026-05-27','16:32:00',NULL,NULL,NULL,NULL,NULL,NULL,'V',NULL,_binary 'Responsável pelo transporte:Regional Ravena',0,0,'C','P',NULL,'Impressoras - Solicitação de toner',NULL,NULL,NULL,NULL,_binary 'Se for impressora colorida, qual a cor to toner ?:\r\nSELB da Impressora :Reginal ravena','2026-05-27','16:31:00','2026-05-27','17:01:00','C',216,41,NULL,NULL,NULL,NULL,16,16),(212,16,16,10,0,0,26,NULL,12,NULL,'2026-05-28','13:55:21','2026-05-28','13:58:00',NULL,NULL,NULL,NULL,NULL,NULL,'V',NULL,_binary 'Responsável pelo transporte:Jonathan',0,0,'C','P',NULL,'Impressoras - Solicitação de toner',NULL,NULL,NULL,NULL,_binary 'Se for impressora colorida, qual a cor to toner ?:preto\r\nSELB da Impressora :Desenvolvimento Social\r\n','2026-05-28','13:55:00','2026-05-28','14:25:00','C',217,41,NULL,NULL,NULL,NULL,16,16),(213,16,16,28,0,0,1,NULL,7,NULL,'2026-05-28','16:52:25','2026-05-28','16:53:00',NULL,NULL,NULL,NULL,NULL,NULL,'V',NULL,_binary 'Responsável pelo transporte:Cei',0,0,'C','P',NULL,'Impressoras - Solicitação de toner',NULL,NULL,NULL,NULL,_binary 'Se for impressora colorida, qual a cor to toner ?:\r\nSELB da Impressora :Cei ','2026-05-28','16:52:00','2026-05-28','17:22:00','C',218,41,NULL,NULL,NULL,NULL,16,16),(214,30,30,7,0,0,1,NULL,7,NULL,'2026-06-01','08:42:19','2026-06-01','09:20:00',NULL,NULL,NULL,NULL,NULL,NULL,'V',NULL,_binary 'Nova senha do usuário :sabara@2026',NULL,0,'C','U',NULL,'Redefinição de senha de acesso rede / computador',NULL,NULL,NULL,NULL,_binary 'Redefinição de senha para lucio.machado','2026-06-01','08:43:00','2026-06-01','09:42:00','C',220,55,NULL,NULL,NULL,NULL,30,16),(215,30,30,32,0,0,26,NULL,12,NULL,'2026-06-27','08:00:00','2026-06-02','09:17:00',NULL,NULL,NULL,NULL,NULL,NULL,'V',NULL,_binary 'Serviço realizado com sucesso.',NULL,0,'C','P',NULL,'Modificação de ponto de rede',NULL,NULL,NULL,NULL,_binary 'Local : \r\nNúmero de pontos: 07','2026-06-01','08:47:00','2026-06-29','17:00:00','C',221,46,NULL,NULL,NULL,NULL,30,27),(216,30,30,31,0,0,26,NULL,10,NULL,'2026-06-27','08:00:02','2026-06-02','09:17:00',NULL,NULL,NULL,NULL,NULL,NULL,'V',NULL,_binary 'Ponto de rede instalado.',NULL,0,'C','P',NULL,'Modificação de ponto de rede',NULL,NULL,NULL,NULL,_binary 'Local : mesa da secretária (Jéssica)\r\nNúmero de pontos: 01','2026-06-01','08:53:00','2026-06-29','17:00:00','C',222,46,NULL,NULL,NULL,NULL,30,27),(217,38,16,6,0,0,1,NULL,7,NULL,'2026-06-01','14:01:09','2026-06-01','14:03:00',NULL,NULL,NULL,NULL,NULL,NULL,'V',NULL,_binary 'Descrição do e-mail:clayton.peixoto@sabara.mg.gov.br\r\nSenha inicial :sabara@2026\r\n\r\nobs.:necessário instalação do microsoft autenticator no celular',NULL,0,'C','U',NULL,'Criação de Conta de e-mail',NULL,NULL,NULL,NULL,_binary 'Descrição do e-mail (ex. <descricao>@sabara.mg.gov.br:  clayton.peixoto@sabara.mg.gov.br\r\nResponsável : Clayton Luiz Lima Peixoto - Cpf: 07463714624 ( Secretário Administração )','2026-06-01','14:01:00','2026-06-01','16:01:00','C',223,10,NULL,NULL,NULL,NULL,16,16),(218,16,16,30,0,0,26,NULL,10,NULL,'2026-06-01','16:00:32',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'V',NULL,NULL,NULL,NULL,'C','P',NULL,'Impressora - Scanner',NULL,NULL,NULL,NULL,_binary 'SELB da impressora: Impressora da Guarda\r\n\r\nConfiguração de scanner da Maquina da Aexandra.','2026-06-01','16:00:00','2026-06-04','16:00:00','X',224,35,'2026-06-02',_binary 'Duplicidade no chamado','10:45:00',16,16,NULL),(219,30,30,6,0,0,26,NULL,12,NULL,'2026-05-27','08:00:07','2026-06-02','09:19:00',NULL,NULL,NULL,NULL,NULL,NULL,'V',NULL,_binary 'Os pontos foram modificados, e as mesas foram reposicionadas.',NULL,0,'C','P',NULL,'Modificação de ponto de rede',NULL,NULL,NULL,NULL,_binary 'Local : setor de Patrimônio\r\nNúmero de pontos: 08 pontos','2026-06-01','16:12:00','2026-05-29','17:00:00','C',225,46,NULL,NULL,NULL,NULL,30,27),(220,38,16,6,0,0,1,NULL,7,NULL,'2026-06-01','16:11:10','2026-06-01','16:33:00',NULL,NULL,NULL,NULL,NULL,NULL,'V',NULL,_binary 'Login do Usuário:clayton.peixoto\r\nSenha Inicial :sabara@2026\r\n\r\nOBS :Usuário já possuia cadastro na rede vinculado a secretaria de Obras. Foi Alterado o perfil para as pastas da secretaria de Administração',NULL,0,'C','U',NULL,'Inclusão de usuários de rede / computador',NULL,NULL,NULL,NULL,_binary 'Nome do usuário : Clayton Peixoto\r\nPastas de acesso na rede : Administração, Transporte, RH, Patrimônio, Serviços Gerais','2026-06-01','16:15:00','2026-06-02','09:00:00','C',226,54,NULL,NULL,NULL,NULL,16,16),(221,30,30,33,0,0,26,NULL,12,NULL,'2026-05-27','08:00:52','2026-06-02','09:18:00',NULL,NULL,NULL,NULL,NULL,NULL,'V',NULL,_binary 'Pontos foram modificados, estão em pleno funcionamento.',NULL,0,'C','P',NULL,'Modificação de ponto de rede',NULL,NULL,NULL,NULL,_binary 'Local : Jurídico\r\nNúmero de pontos: 18 pontos','2026-06-01','16:51:00','2026-05-29','17:00:00','C',227,46,NULL,NULL,NULL,NULL,30,27),(222,30,30,10,0,0,26,NULL,10,NULL,'2026-05-27','08:00:14','2026-06-02','09:18:00',NULL,NULL,NULL,NULL,NULL,NULL,'V',NULL,_binary 'Pontos modificados, mesas reposicionadas.',NULL,0,'C','P',NULL,'Modificação de ponto de rede',NULL,NULL,NULL,NULL,_binary 'Local : Advocacia Municipal\r\nNúmero de pontos: 11 pontos\r\n\r\nTroca para nova sala; modificação da posição das mesas','2026-06-01','16:56:00','2026-05-29','17:00:00','C',228,46,NULL,NULL,NULL,NULL,30,27),(223,30,30,6,0,0,26,NULL,12,NULL,'2026-05-28','16:40:59','2026-06-01','17:04:00',NULL,NULL,NULL,NULL,NULL,NULL,'V',NULL,_binary 'Feita a troca; restaurado o bkp; feitas as configurações necessárias; configurada a tela de scanner.\r\nTérmino: 28/05/2026, às 21h30min.',NULL,0,'C','P',NULL,'Impressoras - Solicitação de troca de equipamento',NULL,NULL,NULL,NULL,_binary 'SELB da impressora DER06\r\n\r\nTroca da unidade fusora da impressora SELB DER06 pela unidade fusora da impressora SELB 120Q.\r\nTroca da impressora SELB DER06 pela impressora SELB 120Q.\r\nColocação da impressora 120Q na Secretaria de Administração;\r\nFazer bkp.','2026-06-01','17:02:00','2026-05-28','21:32:00','C',219,42,NULL,NULL,NULL,NULL,30,30),(224,32,16,33,0,0,1,NULL,7,NULL,'2026-06-02','09:32:07','2026-06-02','09:34:00',NULL,NULL,NULL,NULL,NULL,NULL,'V',NULL,_binary 'Por questão de controle e segurança os usuários e senhas do módulo de divida ativa e iptu são criados pelo Sr. Leonardo ou Sr. Arísio da secretaria de fazenda. Solicitamos que seja feito contato com os mesmos para essa demanda',NULL,0,'C','P',NULL,'Sistema Moderna - Criação de Usuário',NULL,NULL,NULL,NULL,_binary 'Nome do usuário : Natalya Duarte\r\nnúmero do CPF : 018.968.716-90\r\nModulos que irá acessar (compras, estoque, contabilidade, pregão, credores, frotas, prestação de contas, patrimônio : Dívida ativa\r\n\r\n','2026-06-02','09:32:00','2026-06-02','11:32:00','C',229,15,NULL,NULL,NULL,NULL,16,16),(225,42,16,30,0,0,26,NULL,10,NULL,'2026-06-02','09:48:04','2026-06-02','14:47:00',NULL,NULL,NULL,NULL,NULL,NULL,'V',NULL,_binary 'o Scanner foi configurado no computador.',NULL,0,'C','U',NULL,'Impressora - Scanner',NULL,NULL,NULL,NULL,_binary 'SELB da impressora\r\n\r\nPrezados,\r\n\r\nSolicito a gentileza de realizar a configuração do scanner em meu computador, uma vez que o equipamento não se encontra disponível para utilização ou necessita de ajustes para seu correto funcionamento.\r\n\r\nA configuração é necessária para o desempenho das atividades administrativas desta Secretaria, especialmente para digitalização e tramitação de documentos.','2026-06-02','09:48:00','2026-06-02','17:48:00','C',230,35,NULL,NULL,NULL,NULL,16,27),(226,43,16,36,0,0,26,NULL,12,NULL,'2026-06-02','16:04:44','2026-06-08','16:02:00',NULL,NULL,NULL,NULL,NULL,NULL,'V',NULL,_binary 'Observações: Sistema operacional Windows instalado (sem ativação); programas padrão instalados e configurados; driver de impressora instalado e configurado;',NULL,0,'C','P',NULL,'Desktop - Formatação de Computador',NULL,NULL,NULL,NULL,_binary 'Usuário : Laysa\r\nPatrimonio: 096564\r\n\r\nDescrição do problema: O computador já foi encaminhado para manutenção na data de hoje.','2026-06-02','16:05:00','2026-06-08','16:04:00','C',231,8,NULL,NULL,NULL,NULL,16,30),(227,42,16,30,0,0,1,NULL,7,NULL,'2026-06-03','14:08:56','2026-06-03','14:09:00',NULL,NULL,NULL,NULL,NULL,NULL,'V',NULL,_binary 'Senha redefinida para :sabara@2026\r\n\r\nQuanto ao computador o mesmo deve ser enviado para nossa oficina na sede administrativa para avaliação, configuração e \r\ninstalação e sistemas',NULL,0,'C','P',NULL,'Redefinição de senha de e-mail',NULL,NULL,NULL,NULL,_binary 'Descrição do e-mail: elianefatima@sabara.mg.gov.br\r\nResponsável : Eliane de Fatima\r\n\r\nSolicito a gentileza de providenciar a configuração de computador na rede da Prefeitura, incluindo acesso aos sistemas e recursos institucionais necessários ao desempenho das atividades funcionais.\r\nRedefinição da senha do e-mail corporativo da servidora Eliane, tendo em vista que a mesma encontra-se sem acesso à sua conta de e-mail institucional, impossibilitando o recebimento e envio de mensagens relacionadas às suas atividades laborais.\r\n\r\nAtenciosamente,','2026-06-03','14:09:00','2026-06-03','16:08:00','C',232,13,NULL,NULL,NULL,NULL,16,16),(228,16,16,29,0,0,1,NULL,7,NULL,'2026-06-03','14:44:42','2026-06-03','14:45:00',NULL,NULL,NULL,NULL,NULL,NULL,'V',NULL,_binary 'Responsável pelo transporte:Funcionário da Guarda Civil',0,0,'C','P',NULL,'Impressoras - Solicitação de toner',NULL,NULL,NULL,NULL,_binary 'Se for impressora colorida, qual a cor to toner ?:Guarda\r\nSELB da Impressora :im 430','2026-06-03','14:44:00','2026-06-03','15:14:00','C',233,41,NULL,NULL,NULL,NULL,16,16),(229,34,16,29,0,0,1,NULL,7,NULL,'2026-06-08','11:57:18','2026-06-08','11:58:00',NULL,NULL,NULL,NULL,NULL,NULL,'V',NULL,_binary 'Login do Usuário:aline.magalhaes\r\nSenha Inicial :sabara@2026',NULL,0,'C','P',NULL,'Inclusão de usuários de rede / computador',NULL,NULL,NULL,NULL,_binary 'Nome do usuário : Aline Magalhães \r\nPastas de acesso na rede : Defesa Civil\r\n','2026-06-08','11:57:00','2026-06-08','12:57:00','C',234,54,NULL,NULL,NULL,NULL,16,16),(230,43,16,36,0,0,1,NULL,7,NULL,'2026-06-08','13:51:43','2026-06-08','13:52:00',NULL,NULL,NULL,NULL,NULL,NULL,'V',NULL,_binary 'Senha redefinida para :sabara@2026',NULL,0,'C','P',NULL,'Redefinição de senha de e-mail',NULL,NULL,NULL,NULL,_binary 'Descrição do e-mail: elem.colchete@sabara\r\nResponsável : Elem (31) 998932246\r\n\r\nO usuário não consegue acessar o e-mail. Consta erro de senha. ','2026-06-08','13:51:00','2026-06-08','15:51:00','C',236,13,NULL,NULL,NULL,NULL,16,16),(231,32,16,33,0,0,1,NULL,7,NULL,'2026-06-08','14:17:09','2026-06-08','14:18:00',NULL,NULL,NULL,NULL,NULL,NULL,'V',NULL,_binary 'Usuário de Acesso :natalya.duarte\r\nSenha de Acesso :sabara@2026\r\n\r\n',NULL,0,'C','P',NULL,'Sistema Moderna - Criação de Usuário',NULL,NULL,NULL,NULL,_binary 'Nome do usuário : Natalya Duarte\r\nnúmero do CPF : 018.968.716-90\r\nModulos que irá acessar (compras, estoque, contabilidade, pregão, credores, frotas, prestação de contas, patrimônio : Dívida ativa.\r\nPrecisa de login para que o Leo libere acesso\r\n\r\n','2026-06-08','14:17:00','2026-06-08','16:17:00','C',237,15,NULL,NULL,NULL,NULL,16,16),(232,34,16,29,0,0,26,NULL,8,NULL,'2026-06-08','14:19:56',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'V',NULL,NULL,NULL,NULL,'C','U',NULL,'Outros',NULL,NULL,NULL,NULL,_binary 'Solicito por gentileza a manutenção de um cabo de rede de internet.','2026-06-08','14:20:00','2026-06-09','08:00:00','S',235,82,NULL,NULL,NULL,NULL,16,NULL),(233,43,16,36,0,0,1,NULL,7,NULL,'2026-06-08','16:03:26',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'V',NULL,NULL,NULL,NULL,'C','P',NULL,'Redefinição de senha de e-mail',NULL,NULL,NULL,NULL,_binary 'Descrição do e-mail: elem.colchete@sabara \r\nResponsável : Elem (31) 998932246 \r\n\r\nPrezados, mesmo após a redefinição da senha, não consigo acesso. Em anexo a mensagem que aparece \"solicitação negada\". ','2026-06-08','16:03:00','2026-06-09','18:03:00','S',238,13,NULL,NULL,NULL,NULL,16,NULL),(234,16,16,28,0,0,1,NULL,7,NULL,'2026-06-08','21:47:19','2026-06-08','21:48:00',NULL,NULL,NULL,NULL,NULL,NULL,'V',NULL,_binary 'Responsável pelo transporte:Educação',0,0,'C','P',NULL,'Impressoras - Solicitação de toner',NULL,NULL,NULL,NULL,_binary 'Se for impressora colorida, qual a cor to toner ?:-\r\nSELB da Impressora :Educação','2026-06-08','21:47:00','2026-06-08','22:17:00','C',239,41,NULL,NULL,NULL,NULL,16,16),(235,43,16,36,0,0,26,'2026-06-09',12,'14:45:00','2026-06-09','09:46:00','2026-06-09','16:03:00','2026-06-09','2026-06-09','14:45:00','2026-06-09',NULL,NULL,'V','',_binary 'Observações: Problema de acesso ao dominio resolvido após visita técnica',0,0,'C','P','','Desktop - Formatação de Computador',NULL,'C','',NULL,_binary 'Usuário : maria.xavier\r\nPatrimonio: 118220\r\n\r\nDescrição do problema: o computador veio da formatação mas eu não consigo fazer o login no meu usuário. Coloquei em anexo a informação que aparece na tela.','2026-06-09','09:47:00','2026-06-09','17:00:00','C',240,8,NULL,NULL,NULL,NULL,16,16),(236,16,16,8,0,0,1,NULL,7,NULL,'2026-06-09','10:03:29','2026-06-09','10:04:00',NULL,NULL,NULL,NULL,NULL,NULL,'V',NULL,_binary 'Responsável pelo transporte:Fazenda',0,0,'C','P',NULL,'Impressoras - Solicitação de toner',NULL,NULL,NULL,NULL,_binary 'Se for impressora colorida, qual a cor to toner ?:501\r\nSELB da Impressora :Fazenda 501','2026-06-09','10:03:00','2026-06-09','10:33:00','C',241,41,NULL,NULL,NULL,NULL,16,16),(237,30,30,31,0,0,26,NULL,12,NULL,'2026-06-09','11:00:47','2026-06-09','17:02:00',NULL,NULL,NULL,NULL,NULL,NULL,'V',NULL,_binary 'acompanhamento de mudança das mesas da recepção; confecção de novo cabeamento; solicitação de ligação elétrica para o novo local da mesa da recepção.',NULL,0,'C','P',NULL,'Confecção de Cabo de Rede',NULL,NULL,NULL,NULL,_binary 'Local a ser utilizado : recepção\r\nMetragem : 2,5m','2026-06-09','17:01:00','2026-06-09','11:47:00','C',242,76,NULL,NULL,NULL,NULL,30,30),(238,30,30,31,0,0,26,NULL,12,NULL,'2026-06-09','09:00:38','2026-06-09','17:11:00',NULL,NULL,NULL,NULL,NULL,NULL,'V',NULL,_binary 'Acessos regularizados',NULL,0,'C','P',NULL,'Impressora - Scanner',NULL,NULL,NULL,NULL,_binary 'SELB da impressora: TFD2\r\nReconfiguração de acesso para a pasta SCANNER - GO ','2026-06-09','17:10:00','2026-06-09','09:40:00','C',243,35,NULL,NULL,NULL,NULL,30,30),(239,27,27,8,0,0,26,NULL,10,NULL,'2026-06-10','08:21:00','2026-06-10','08:21:00',NULL,NULL,NULL,NULL,NULL,NULL,'V',NULL,_binary 'Foi colocado o Scanner na rede.',NULL,0,'C','P',NULL,'Desktop - Incluir desktop na rede',NULL,NULL,NULL,NULL,_binary 'Patrimônio :Instalar scanner Duda, da Sec. Fazenda.','2026-06-10','08:21:00','2026-06-11','08:21:00','C',244,24,NULL,NULL,NULL,NULL,27,27),(240,30,30,8,0,0,26,NULL,12,NULL,'2026-06-10','12:57:23',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'V',NULL,NULL,0,0,'C','P',NULL,'Outros',NULL,NULL,NULL,NULL,_binary 'Acionar a Regional Centro pra vistoriar rede elétrica no setor de GeoProcessamento','2026-06-10','12:57:00','2026-06-17','17:00:00','S',245,82,NULL,NULL,NULL,NULL,30,NULL),(241,16,16,18,0,0,1,NULL,7,NULL,'2026-06-10','14:02:49','2026-06-10','14:05:00',NULL,NULL,NULL,NULL,NULL,NULL,'V',NULL,_binary 'Responsável pelo transporte:Reginal Ana Lucia',0,0,'C','P',NULL,'Impressoras - Solicitação de toner',NULL,NULL,NULL,NULL,_binary 'Se for impressora colorida, qual a cor to toner ?:\r\nSELB da Impressora :58YL','2026-06-10','14:03:00','2026-06-10','14:32:00','C',246,41,NULL,NULL,NULL,NULL,16,16),(242,43,16,36,0,0,1,NULL,7,NULL,'2026-06-10','14:35:12','2026-06-10','14:40:00',NULL,NULL,NULL,NULL,NULL,NULL,'V',NULL,_binary 'Login do Usuário :maria.xavier\r\nSenha de Acesso :123456',NULL,0,'C','P',NULL,'Protocoloweb - Inclusão de novo Usuário',NULL,NULL,NULL,NULL,_binary 'Nome do Usuário: maria.xavier - Maria Luiza Ferreira Rodrigues Xavier\r\nCPF: 130.088.836-99\r\nLocais de Tramitação : Gerência de Fiscalização de Tributos\r\n\r\n','2026-06-10','14:35:00','2026-06-10','15:05:00','C',248,62,NULL,NULL,NULL,NULL,16,16),(243,43,16,36,0,0,1,NULL,7,NULL,'2026-06-10','14:35:41','2026-06-10','14:39:00',NULL,NULL,NULL,NULL,NULL,NULL,'V',NULL,_binary 'Foi incluido novo local como solicitado',NULL,0,'C','P',NULL,'Protocoloweb - Alteração de locais de tramitação',NULL,NULL,NULL,NULL,_binary 'Login do Usuário :laysasantos\r\nNovos locais de tramitação: gerencia de tributos \r\nExcluir locais anteriores (sim/Não) : NÃO','2026-06-10','14:35:00','2026-06-10','15:05:00','C',247,67,NULL,NULL,NULL,NULL,16,16),(244,16,16,7,0,0,1,NULL,7,NULL,'2026-06-10','14:58:54','2026-06-10','14:59:00',NULL,NULL,NULL,NULL,NULL,NULL,'V',NULL,_binary 'Responsável pelo transporte:Pedro Neves',0,0,'C','P',NULL,'Impressoras - Solicitação de toner',NULL,NULL,NULL,NULL,_binary 'Se for impressora colorida, qual a cor to toner ?:Preto \r\nSELB da Impressora :C2000 do Planejamento','2026-06-10','14:58:00','2026-06-10','15:28:00','C',249,41,NULL,NULL,NULL,NULL,16,16),(245,34,16,29,0,0,1,NULL,7,NULL,'2026-06-10','16:01:07','2026-06-10','16:04:00',NULL,NULL,NULL,NULL,NULL,NULL,'V',NULL,_binary 'Login do Usuário:lidia.ribeiro\r\nSenha Inicial :sabara@2026',NULL,0,'C','P',NULL,'Inclusão de usuários de rede / computador',NULL,NULL,NULL,NULL,_binary 'Nome do usuário :Lidia Ribeiro\r\n\r\nPastas de acesso na rede :Defesa Civil ','2026-06-10','16:01:00','2026-06-10','17:01:00','C',250,54,NULL,NULL,NULL,NULL,16,16),(246,16,16,8,0,0,26,NULL,8,NULL,'2026-06-10','16:19:30','2026-06-10','21:22:00',NULL,NULL,NULL,NULL,NULL,NULL,'V',NULL,_binary 'Office registrado e funcional',NULL,0,'C','P',NULL,'Reparo de software',NULL,NULL,NULL,NULL,_binary 'Descrição do software :Office\r\nPossui licença? (sim/Não) : sim','2026-06-10','16:19:00','2026-06-10','18:19:00','C',251,52,NULL,NULL,NULL,NULL,16,16),(247,30,30,14,0,0,26,NULL,12,NULL,'2026-06-10','15:03:26','2026-06-12','16:04:00',NULL,NULL,NULL,NULL,NULL,NULL,'V',NULL,_binary 'Serviço na  realizado com sucesso',NULL,0,'C','P',NULL,'internet - Lentidão',NULL,NULL,NULL,NULL,_binary 'local : Campo da Liga Municipal de Desportos\r\nInstalar programas','2026-06-10','17:03:00','2026-06-11','17:00:00','C',252,44,NULL,NULL,NULL,NULL,30,16),(248,27,27,28,0,0,26,NULL,10,NULL,'2026-06-11','09:20:13','2026-06-11','09:21:00',NULL,NULL,NULL,NULL,NULL,NULL,'V',NULL,_binary 'Foi configurados os computadores na rede.',NULL,0,'C','P',NULL,'Desktop - Incluir desktop na rede',NULL,NULL,NULL,NULL,_binary 'Patrimônio : Configurar computadores pra ingressar na rede. Sec. de Educação (SEMED)','2026-06-11','09:20:00','2026-06-12','09:20:00','C',254,24,NULL,NULL,NULL,NULL,27,27),(249,27,27,31,0,0,26,NULL,10,NULL,'2026-06-11','09:22:00','2026-06-11','09:22:00',NULL,NULL,NULL,NULL,NULL,NULL,'V',NULL,_binary 'Foi instalado os Totens no Centro Administrativo.',NULL,0,'C','P',NULL,'Desktop - Instalação e Desinstalação',NULL,NULL,NULL,NULL,_binary 'Patrimonio: Instalação de TOTENS no Prédio Administrativo.\r\n','2026-06-11','09:22:00','2026-06-11','11:22:00','C',253,23,NULL,NULL,NULL,NULL,27,27),(250,38,16,6,0,0,1,NULL,7,NULL,'2026-06-11','10:55:22','2026-06-11','11:05:00',NULL,NULL,NULL,NULL,NULL,NULL,'V',NULL,_binary 'Usuário de acesso ao supernova e ao módulos de compras, contabilidade, estoque, patrimonio e frotas: clayton.peixoto senha sabara@2026\r\n- Usuário Protocolo web clayton.peixoto senha inicial sabara@2026\r\n- O sistema de Rh deve ser cadastrado pelo Sr. Nilo no RH',NULL,0,'C','U',NULL,'Outros',NULL,NULL,NULL,NULL,_binary 'SOLICITO POR GENTILEZA A LIBERAÇÃO DE CESSO AO SITEMA SUPERNOVA PARA O SECRETÁRIO DE ADMINISTRAÇÃO CLAYTON LUIZ LIMA PEIXOTO MATRICULA 34693. \r\nSOLICITO OS SEGUINTES ACESSOS:\r\n\r\nCompras\r\nEstoque\r\nContabilidade\r\nPatrimônio\r\nProtocolo\r\nFrotas\r\nRh\r\n\r\nObrigada\r\n','2026-06-11','10:55:00','2026-06-11','14:00:00','C',255,82,NULL,NULL,NULL,NULL,16,16),(251,37,16,35,0,0,1,NULL,7,NULL,'2026-06-11','14:58:17','2026-06-11','15:05:00',NULL,NULL,NULL,NULL,NULL,NULL,'V',NULL,_binary 'Acesso ao Ssistema de Compras\r\nUsuário :raissa.coelho\r\nSenha : sabara@2026\r\n',NULL,0,'C','P',NULL,'Sistema Moderna - Ateração de configuração do usuários',NULL,NULL,NULL,NULL,_binary 'Solicito a inclusão do Módulo Compras (execução de procedimentos) para a Servidora: Raissa Aparecida da Silva Coelho, matrícula: 34234, cpf: 127.728.096.76.\r\n1º login no sistema supernova: raissa.coelho','2026-06-11','14:58:00','2026-06-11','15:58:00','C',256,74,NULL,NULL,NULL,NULL,16,16),(252,33,16,32,0,0,1,NULL,11,NULL,'2026-06-11','15:09:46','2026-06-11','15:10:00',NULL,NULL,NULL,NULL,NULL,NULL,'V',NULL,_binary 'Responsável pelo transporte:Jedean Moises',0,0,'C','U',NULL,'Impressoras - Solicitação de toner',NULL,NULL,NULL,NULL,_binary 'Se for impressora colorida, qual a cor to toner ?: Magenta\r\nSELB da Impressora : não sei ','2026-06-11','15:09:00','2026-06-11','15:39:00','C',257,41,NULL,NULL,NULL,NULL,16,16),(253,16,16,30,0,0,1,NULL,7,NULL,'2026-06-11','16:20:50','2026-06-11','16:22:00',NULL,NULL,NULL,NULL,NULL,NULL,'V',NULL,_binary 'Responsável pelo transporte:Guada Municipal',0,0,'C','P',NULL,'Impressoras - Solicitação de toner',NULL,NULL,NULL,NULL,_binary 'Se for impressora colorida, qual a cor to toner ?:Não\r\nSELB da Impressora : Guarda','2026-06-11','16:20:00','2026-06-11','16:50:00','C',258,41,NULL,NULL,NULL,NULL,16,16),(254,30,30,7,0,0,26,NULL,10,NULL,'2026-06-11','15:30:27','2026-06-15','12:26:00',NULL,NULL,NULL,NULL,NULL,NULL,'V',NULL,_binary 'Pontos necessários, foram instalados.',NULL,0,'C','P',NULL,'Instalação de Ponto de rede',NULL,NULL,NULL,NULL,_binary 'Local: Centro Adminitrativo - Comunicação\r\nNúmero de pontos: 06 ','2026-06-12','08:41:00','2026-06-16','17:00:00','C',259,48,NULL,NULL,NULL,NULL,30,27),(255,43,16,36,0,0,1,NULL,7,NULL,'2026-06-12','10:21:38','2026-06-12','10:43:00',NULL,NULL,NULL,NULL,NULL,NULL,'V',NULL,_binary 'Manutenção Feita na linha pela SpeedNet. Linha testada e funcionando normalmente',NULL,0,'C','P',NULL,'Telefonia - Manutenção',NULL,NULL,NULL,NULL,_binary 'Número Telefone:3672-7876\r\nNúmero Ramal: 1221\r\nOutro Telefone fixo ou celular para contato : 31992653413,  pessoal pois não temos outro telefone. Laysa','2026-06-12','10:22:00','2026-06-12','17:00:00','C',260,65,NULL,NULL,NULL,NULL,16,16),(256,39,16,13,0,0,26,NULL,8,NULL,'2026-06-12','14:09:48','2026-06-12','16:10:00',NULL,NULL,NULL,NULL,NULL,NULL,'V',NULL,_binary 'Cabo danificado trocado no local',NULL,0,'C','P',NULL,'Internet - sem acesso',NULL,NULL,NULL,NULL,_binary 'local : na sala que funciona a gerencia de fomento, o cabo que liga o computador da servidora Karoline, se partiu, por esse motivo ela se encontra sem acesso a internet pela rede.','2026-06-12','14:09:00','2026-06-12','17:09:00','C',261,43,NULL,NULL,NULL,NULL,16,16),(257,30,30,9,0,0,26,NULL,12,NULL,'2026-06-12','07:15:48','2026-06-12','16:59:00',NULL,NULL,NULL,NULL,NULL,NULL,'V',NULL,_binary 'Informada a demanda aos coordenadores; acionada a empresa responsável;\r\n(houve troca de postes da rede elétrica, próximos ao local);\r\n-Restabelecidas as conexões.',NULL,0,'C','P',NULL,'Internet - sem acesso',NULL,NULL,NULL,NULL,_binary 'local : Regional Centro\r\n','2026-06-12','16:59:00','2026-06-12','12:00:00','C',262,43,NULL,NULL,NULL,NULL,30,30),(258,38,16,6,0,0,1,NULL,7,NULL,'2026-06-15','09:05:54','2026-06-15','09:07:00',NULL,NULL,NULL,NULL,NULL,NULL,'V',NULL,_binary 'Login do Usuário:tayla.siqueira\r\nSenha Inicial :sabara@2026',NULL,0,'C','U',NULL,'Inclusão de usuários de rede / computador',NULL,NULL,NULL,NULL,_binary ' Nome do usuário : TAYLA DE SIQUEIRA\r\nPastas de acesso na rede : Solicito que seja feito o cadastro da estagiária em usuários de rede/computador. ela fará estágio no setor de trasnporte.','2026-06-15','09:06:00','2026-06-15','10:05:00','C',263,54,NULL,NULL,NULL,NULL,16,16),(259,32,16,33,0,0,1,NULL,7,NULL,'2026-06-15','11:19:29','2026-06-15','11:20:00',NULL,NULL,NULL,NULL,NULL,NULL,'V',NULL,_binary 'Nova senha redefinida : sabara@2026',NULL,0,'C','U',NULL,'Sistema Moderna - Redefinir Senha',NULL,NULL,NULL,NULL,_binary 'Qual o login do usuário? : jessica.barbosa','2026-06-15','11:19:00','2026-06-15','11:49:00','C',264,16,NULL,NULL,NULL,NULL,16,16),(260,16,16,35,0,0,1,NULL,7,NULL,'2026-06-15','16:09:26','2026-06-15','16:10:00',NULL,NULL,NULL,NULL,NULL,NULL,'V',NULL,_binary 'Responsável pelo transporte:Jedean Moises',0,0,'C','P',NULL,'Impressoras - Solicitação de toner',NULL,NULL,NULL,NULL,_binary 'Se for impressora colorida, qual a cor to toner ?:\r\nSELB da Impressora :Recursos Humanos','2026-06-15','16:09:00','2026-06-15','16:39:00','C',265,41,NULL,NULL,NULL,NULL,16,16),(261,27,27,7,0,0,26,NULL,10,NULL,'2026-06-16','08:16:51','2026-06-16','11:20:00',NULL,NULL,NULL,NULL,NULL,NULL,'V',NULL,_binary 'Foi corrigido o erro de tela preta, foi feito o Clear Cmos. A computador foi atualizado, e o defeito foi corrigido.',NULL,0,'C','P',NULL,'Desktop - Travamento',NULL,NULL,NULL,NULL,_binary 'Patrimônio :\r\nUsuário : Sec.Thiago\r\n','2026-06-16','08:16:00','2026-06-18','08:16:00','C',266,22,NULL,NULL,NULL,NULL,27,27),(262,16,16,7,0,0,1,NULL,7,NULL,'2026-06-16','11:54:34','2026-06-16','11:56:00',NULL,NULL,NULL,NULL,NULL,NULL,'V',NULL,_binary 'Responsável pelo transporte:Lucio Machado',0,0,'C','P',NULL,'Impressoras - Solicitação de toner',NULL,NULL,NULL,NULL,_binary 'Se for impressora colorida, qual a cor to toner ?:\r\nSELB da Impressora :planejmento','2026-06-16','11:54:00','2026-06-16','12:24:00','C',271,41,NULL,NULL,NULL,NULL,16,16),(263,22,16,27,0,0,1,NULL,7,NULL,'2026-06-16','11:56:46',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'V',NULL,NULL,NULL,NULL,'C','P',NULL,'Sistema Moderna - Criação de Usuário',NULL,NULL,NULL,NULL,_binary 'Nome do usuário :jose da silva\r\nnúmero do CPF :08098-09809\r\nModulos que irá acessar (compras, estoque, contabilidade, pregão, credores, frotas, prestação de contas, patrimônio :compras\r\n\r\n\r\n\r\n','2026-06-16','11:56:00','2026-06-16','13:56:00','X',269,15,'2026-06-16',_binary 'Teste para treinamento de sistema','11:57:00',16,16,NULL),(264,43,16,36,0,0,26,NULL,12,NULL,'2026-06-16','11:57:58','2026-06-17','09:38:00',NULL,NULL,NULL,NULL,NULL,NULL,'V',NULL,_binary 'Impressora instalada; teste de impressão \"OK\".',NULL,0,'C','P',NULL,'Impressoras - Instalação',NULL,NULL,NULL,NULL,_binary 'SELB da Impressora : DEU7 \r\n\r\nA impressora da Receita, na Secretaria de Fazenda, não está configurada para impressão na minha minha máquina e não sei adicioná-la através das configurações.','2026-06-16','11:58:00','2026-06-16','17:57:00','C',270,36,NULL,NULL,NULL,NULL,16,30),(265,16,16,11,0,0,1,NULL,7,NULL,'2026-06-16','12:02:32','2026-06-16','14:09:00',NULL,NULL,NULL,NULL,NULL,NULL,'V',NULL,_binary 'Login do Usuário:luiza.arcanjo\r\nSenha Inicial :sabara@2026',NULL,0,'C','P',NULL,'Inclusão de usuários de rede / computador',NULL,NULL,NULL,NULL,_binary 'Nome do usuário :Luiza Cristina Santiago Arcanjo\r\nPastas de acesso na rede :Meio Ambiente','2026-06-16','12:02:00','2026-06-16','14:30:00','C',272,54,NULL,NULL,NULL,NULL,16,16),(266,16,16,11,0,0,1,NULL,7,NULL,'2026-06-16','13:59:49','2026-06-16','14:00:00',NULL,NULL,NULL,NULL,NULL,NULL,'V',NULL,_binary 'Login do Usuário :luiza.arcanjo\r\nSenha de Acesso :123456',NULL,0,'C','P',NULL,'Protocoloweb - Inclusão de novo Usuário',NULL,NULL,NULL,NULL,_binary 'Nome do Usuário:Luiza Cristina Santiago Arcanjo\r\nLocais de Tramitação :Meio Ambiente','2026-06-16','13:59:00','2026-06-16','14:29:00','C',273,62,NULL,NULL,NULL,NULL,16,16),(267,22,16,27,0,0,1,NULL,7,NULL,'2026-06-16','15:24:26',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'V',NULL,NULL,NULL,NULL,'C','P',NULL,'Criação de Conta de e-mail',NULL,NULL,NULL,NULL,_binary 'Descrição do e-mail (ex. <descricao>@sabara.mg.gov.br:teste@sabara.mg.gov.br\r\nResponsável :jose da silva\r\n\r\n','2026-06-16','15:24:00','2026-06-16','17:24:00','X',274,10,'2026-06-16',_binary 'Teste para demonstração de sistema','15:26:00',16,16,NULL),(268,30,30,30,26,0,26,NULL,12,NULL,'2026-06-16','10:47:24','2026-06-18','11:00:00',NULL,NULL,NULL,NULL,NULL,NULL,'R',NULL,_binary 'Atualização de drivers; remoção de arquivos temporários; backup de arquivos/documentos; reinstalação de Sistema Operacional (Win10); instalação e configuração de \"programas padrão\"; instalação de driver de impressora IM430f.',NULL,0,'C','P',NULL,'Desktop - Lentidão do desktop',NULL,NULL,NULL,NULL,_binary 'Patrimõnio do Computador : 97353\r\nUsuário: Mauricio Mendes','2026-06-17','12:48:00','2026-06-19','17:00:00','C',275,19,NULL,NULL,NULL,NULL,30,30),(269,22,16,27,0,0,1,NULL,7,NULL,'2026-06-17','14:32:22',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'V',NULL,NULL,NULL,NULL,'C','P',NULL,'Instalação de Ponto de rede',NULL,NULL,NULL,NULL,_binary 'Local:\r\nNúmero de pontos','2026-06-17','14:37:00','2026-06-18','14:32:00','X',276,48,'2026-06-17',_binary 'Demosntração de sistema','14:38:00',16,16,NULL),(270,48,16,7,0,0,26,NULL,10,NULL,'2026-06-17','16:18:12',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'V',NULL,NULL,NULL,NULL,'C','P',NULL,'Manutenção de Computadores DeskTop',NULL,NULL,NULL,NULL,_binary 'Usuário: iara.fonseca\r\nPatrimônio: 096563\r\n\r\nA máquina necessita de um ssd.\r\n','2026-06-17','16:18:00','2026-06-22','16:18:00','S',277,70,NULL,NULL,NULL,NULL,16,NULL),(271,33,16,32,0,0,1,NULL,7,NULL,'2026-06-17','16:33:56','2026-06-17','16:34:00',NULL,NULL,NULL,NULL,NULL,NULL,'V',NULL,_binary 'Nova senha redefinida :sabara@2026',NULL,0,'C','U',NULL,'Sistema Moderna - Redefinir Senha',NULL,NULL,NULL,NULL,_binary 'Qual o login do usuário? : lindaiane.silva','2026-06-17','16:34:00','2026-06-17','17:03:00','C',278,16,NULL,NULL,NULL,NULL,16,16),(272,30,16,34,0,0,26,NULL,12,NULL,'2026-06-18','09:45:40','2026-06-19','11:35:00',NULL,NULL,NULL,NULL,NULL,NULL,'V',NULL,_binary 'Remoção de dispositivos impressora não utilizados; configuração de impressora padrão PROCON.',NULL,0,'C','P',NULL,'Impressoras - Não está imprimindo',NULL,NULL,NULL,NULL,_binary 'SELB da Impressora :\r\n','2026-06-18','09:45:00','2026-06-22','09:45:00','C',268,38,NULL,NULL,NULL,NULL,16,30),(273,30,16,34,0,0,26,NULL,12,NULL,'2026-06-18','09:46:27','2026-06-19','11:35:00',NULL,NULL,NULL,NULL,NULL,NULL,'V',NULL,_binary 'Patrimônio 119204\r\nUpdate && upgrade; verificação das configurações de impressora e usuário.\r\nNenhum problema elétrico detectado.',NULL,0,'C','P',NULL,'Desktop - Não liga',NULL,NULL,NULL,NULL,_binary 'Patrimônio :\r\n','2026-06-18','09:46:00','2026-06-22','09:46:00','C',267,20,NULL,NULL,NULL,NULL,16,30),(274,39,16,13,0,0,1,NULL,7,NULL,'2026-06-18','14:04:54','2026-06-18','14:06:00',NULL,NULL,NULL,NULL,NULL,NULL,'V',NULL,_binary 'Login do Usuário:kamily.quites\r\nSenha Inicial :sabara@2026',NULL,0,'C','P',NULL,'Inclusão de usuários de rede / computador',NULL,NULL,NULL,NULL,_binary 'Nome do usuário : Kamily Vitoria Zunzarrem Quites\r\nPastas de acesso na rede : P da cultura','2026-06-18','14:05:00','2026-06-18','15:04:00','C',279,54,NULL,NULL,NULL,NULL,16,16),(275,48,16,7,0,0,26,NULL,10,NULL,'2026-06-18','14:40:28','2026-06-18','15:28:00',NULL,NULL,NULL,NULL,NULL,NULL,'V',NULL,_binary 'Foi resetado o driver de áudio. o áudio está funcionando.',NULL,0,'C','P',NULL,'Outros',NULL,NULL,NULL,NULL,_binary 'A servidora Paula Scoralick relatou que há um problema no aúdio do computador dela, o fone não aparece nas configurações de aúdio. ','2026-06-18','14:40:00','2026-06-18','17:00:00','C',281,82,NULL,NULL,NULL,NULL,16,27),(276,27,27,9,0,0,26,NULL,10,NULL,'2026-06-17','14:59:12','2026-06-18','14:59:00',NULL,NULL,NULL,NULL,NULL,NULL,'V',NULL,_binary 'Observações: Foi instalado o Sistema Operacional, computador segue funcionando normal.',NULL,0,'C','P',NULL,'Desktop - Formatação de Computador',NULL,NULL,NULL,NULL,_binary 'Usuário :\r\nPatrimonio: 119260\r\n\r\nDescrição do problema: Computador está sem sistema operacional ','2026-06-18','14:59:00','2026-06-21','14:59:00','C',282,8,NULL,NULL,NULL,NULL,27,27),(277,39,16,13,0,0,26,NULL,12,NULL,'2026-06-18','16:06:33',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'V',NULL,NULL,NULL,0,'C','P',NULL,'Desktop - Instalação e Desinstalação',NULL,NULL,NULL,NULL,_binary 'Patrimonio: 103889\r\n\r\nInstalação do computador do novo servidor lotado na secretaria de cultura, o computador precisa de um cabo rede (longo), estabilizador, cabo de força do computador, extensão. ','2026-06-18','16:06:00','2026-06-22','18:06:00','S',280,23,NULL,NULL,NULL,NULL,16,NULL),(278,37,16,35,0,0,26,NULL,13,NULL,'2026-06-19','11:04:00','2026-06-19','11:42:00',NULL,NULL,NULL,NULL,NULL,NULL,'V',NULL,_binary 'Sistema instalado com sucesso',NULL,0,'C','U',NULL,'Instalação do aplicativo no computador',NULL,NULL,NULL,NULL,_binary 'Local: RH\r\nUsuário: aron.silva\r\n\r\nINSTALAÇÃO DO SISTEMA SUPERNOVA COMPUTADOR','2026-06-19','11:04:00','2026-06-19','11:34:00','C',283,77,NULL,NULL,NULL,NULL,16,16),(279,48,16,7,0,0,1,NULL,7,NULL,'2026-06-19','11:06:48','2026-06-19','11:41:00',NULL,NULL,NULL,NULL,NULL,NULL,'V',NULL,_binary 'Nova senha do usuário :sabara@2026',NULL,0,'C','P',NULL,'Redefinição de senha de acesso rede / computador',NULL,NULL,NULL,NULL,_binary 'Prezados, \r\nA servidora Poliana Martins Ribeiro Leite, voltou de licença hoje e está necessitando do seu usuário e senha de acesso. \r\n\r\nAtenciosamente, \r\nPedro Neves','2026-06-19','11:06:00','2026-06-19','12:06:00','C',284,55,NULL,NULL,NULL,NULL,16,16),(280,48,16,7,0,0,26,NULL,13,NULL,'2026-06-19','11:27:08','2026-06-19','11:37:00',NULL,NULL,NULL,NULL,NULL,NULL,'V',NULL,_binary 'usuario de entrada: poliana.martins\r\nusuario modulos: polianamartins\r\nNova senha redefinida : sabara@2026',NULL,0,'C','P',NULL,'Sistema Moderna - Redefinir Senha',NULL,NULL,NULL,NULL,_binary 'Qual o login do usuário? : \r\nA servidora Poliana Martins Ribeiro Leite, necessita da mudança da senha de acesso nos sistemas geral da Supernova, no compras e no orçamento e também necessita de saber o seu usuário.','2026-06-19','11:27:00','2026-06-19','11:57:00','C',285,16,NULL,NULL,NULL,NULL,16,16),(281,30,30,7,0,0,26,NULL,12,NULL,'2026-06-22','08:40:50','2026-06-22','09:15:00',NULL,NULL,NULL,NULL,NULL,NULL,'V',NULL,_binary 'Configuração feita; vistoria das configurações de impressora.',NULL,0,'C','P',NULL,'Instalação do aplicativo no computador',NULL,NULL,NULL,NULL,_binary 'Local: Planejamento\r\nUsuário: Poliana ','2026-06-22','09:15:00','2026-06-22','09:12:00','C',286,77,NULL,NULL,NULL,NULL,30,30),(282,16,16,32,0,0,26,NULL,12,NULL,'2026-06-22','11:14:29','2026-06-22','12:40:00',NULL,NULL,NULL,NULL,NULL,NULL,'V',NULL,_binary 'Não foi possível a configuração por não conseguir acessar algum usuário com direitos administrativos. \r\nSolução paliativa: criação de usuário de rede para o colaborador da MAPZER.',NULL,0,'C','P',NULL,'Impressoras - Instalação',NULL,NULL,NULL,NULL,_binary 'SELB da Impressora :Controladoria\r\n\r\nInstalação de impressora em computador de terceirizado','2026-06-22','11:14:00','2026-06-22','13:14:00','C',287,36,NULL,NULL,NULL,NULL,16,30),(283,46,16,7,0,0,1,NULL,11,NULL,'2026-06-22','14:07:00','2026-06-22','15:24:00',NULL,NULL,NULL,NULL,NULL,NULL,'V',NULL,_binary 'Monitou funcionando normalmente após instalação do Cabo de energia',NULL,0,'C','U',NULL,'Monitor - Não está Ligando',NULL,NULL,NULL,NULL,_binary 'Patrimônio : \r\nchecou cabos de energia (sim/não)?','2026-06-22','14:07:00','2026-06-22','15:07:00','C',288,25,NULL,NULL,NULL,NULL,16,16),(284,46,16,7,0,0,1,NULL,11,NULL,'2026-06-22','16:44:06','2026-06-22','16:48:00',NULL,NULL,NULL,NULL,NULL,NULL,'V',NULL,_binary 'Mal contato na conexão do cabo. Problema resolvido no computador',NULL,0,'C','U',NULL,'Monitor - Não está Ligando',NULL,NULL,NULL,NULL,_binary 'o cabo que foi colocado esta com defeito, a tela esta desligando','2026-06-22','16:44:00','2026-06-23','16:44:00','C',290,25,NULL,NULL,NULL,NULL,16,16),(285,16,16,7,0,0,1,NULL,11,NULL,'2026-06-22','16:45:18','2026-06-22','16:46:00',NULL,NULL,NULL,NULL,NULL,NULL,'V',NULL,_binary 'Feito o esvaziamento do recepiente. Impressora funcional',NULL,0,'C','P',NULL,'Impressoras - Não está imprimindo',NULL,NULL,NULL,NULL,_binary 'SELB da Impressora :Impressora do Planejamento\r\n\r\nRecipiente de residuos de toner cheio','2026-06-22','16:45:00','2026-06-22','16:45:00','C',289,38,NULL,NULL,NULL,NULL,16,16),(286,49,16,10,0,0,1,NULL,7,NULL,'2026-06-23','15:09:18',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'V',NULL,NULL,NULL,NULL,'C','P',NULL,'Sistema Moderna - Criação de Usuário',NULL,NULL,NULL,NULL,_binary 'Nome do usuário :jose da silva\r\nnúmero do CPF :66363636363\r\nModulos que irá acessar (compras, estoque, contabilidade, pregão, credores, frotas, prestação de contas, patrimônio : Estoque\r\n\r\n','2026-06-23','15:09:00','2026-06-23','17:09:00','X',294,15,'2026-06-23',_binary 'Ordem de serviço cancela. Treinamento de pessoal','15:09:00',16,16,NULL),(287,37,16,35,0,0,1,NULL,7,NULL,'2026-06-23','15:10:42','2026-06-23','15:13:00',NULL,NULL,NULL,NULL,NULL,NULL,'V',NULL,_binary 'Login do Usuário :beatriz.perdigao\r\nSenha de Acesso :123456',NULL,0,'C','P',NULL,'Protocoloweb - Inclusão de novo Usuário',NULL,NULL,NULL,NULL,_binary 'Nome do Usuário: beatriz.perdigao\r\nCPF: 152.439.596-00\r\nLocais de Tramitação : RH','2026-06-23','15:10:00','2026-06-23','15:40:00','C',293,62,NULL,NULL,NULL,NULL,16,16),(288,45,16,31,0,0,1,NULL,7,NULL,'2026-06-23','16:10:24','2026-06-23','16:12:00',NULL,NULL,NULL,NULL,NULL,NULL,'V',NULL,_binary 'Nova senha redefinida :sabara@2026',NULL,0,'C','P',NULL,'Sistema Moderna - Redefinir Senha',NULL,NULL,NULL,NULL,_binary 'Qual o login do usuário? : laila.negreiros','2026-06-23','16:10:00','2026-06-23','16:40:00','C',296,16,NULL,NULL,NULL,NULL,16,16),(289,32,16,33,0,0,1,NULL,7,NULL,'2026-06-23','16:13:31','2026-06-23','16:14:00',NULL,NULL,NULL,NULL,NULL,NULL,'V',NULL,_binary 'Nova senha redefinida :sabara@2026',NULL,0,'C','U',NULL,'Sistema Moderna - Redefinir Senha',NULL,NULL,NULL,NULL,_binary 'Qual o login do usuário? :bruno.sette','2026-06-23','16:13:00','2026-06-23','16:43:00','C',295,16,NULL,NULL,NULL,NULL,16,16),(290,30,16,12,0,0,26,NULL,12,NULL,'2026-06-23','16:22:26',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'V',NULL,NULL,NULL,NULL,'C','P',NULL,'Manutenção de Computadores DeskTop',NULL,NULL,NULL,NULL,_binary 'Computador Lenovo ThinkCentre M70q, tipo 11DU.\r\nOBS.: aguardando fonte de alimentação específica para ser feita a avaliação do PC','2026-06-23','16:22:00','2026-06-23','16:22:00','S',292,70,NULL,NULL,NULL,NULL,16,NULL),(291,22,16,27,0,0,1,NULL,7,NULL,'2026-06-24','09:28:29',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'V',NULL,NULL,NULL,NULL,'C','P',NULL,'Sistema Moderna - Criação de Usuário',NULL,NULL,NULL,NULL,_binary 'Nome do usuário :jose da silva\r\nnúmero do CPF :34534552345\r\nModulos que irá acessar (compras, estoque, contabilidade, pregão, credores, frotas, prestação de contas, patrimônio :compras\r\n\r\n\r\n\r\n','2026-06-24','09:28:00','2026-06-24','11:28:00','X',297,15,'2026-06-24',_binary 'Ordem de serviço utilizada para treinamento de usuário','09:28:00',16,16,NULL),(292,49,16,33,0,0,1,NULL,7,NULL,'2026-06-24','10:41:11','2026-06-24','10:46:00',NULL,NULL,NULL,NULL,NULL,NULL,'V',NULL,_binary 'Login do Usuário:ana.saraiva\r\nSenha Inicial :sabara@2026',NULL,0,'C','U',NULL,'Inclusão de usuários de rede / computador',NULL,NULL,NULL,NULL,_binary 'Nome do usuário : ana luiza saraiva fernandes\r\nPastas de acesso na rede : ds advocacia\r\n\r\ncpf 13573701647','2026-06-24','10:41:00','2026-06-24','11:41:00','C',298,54,NULL,NULL,NULL,NULL,16,16),(293,49,16,33,0,0,1,NULL,7,NULL,'2026-06-24','14:15:05','2026-06-24','14:16:00',NULL,NULL,NULL,NULL,NULL,NULL,'V',NULL,_binary 'Login do Usuário:isadora.torres\r\nSenha Inicial :sabara@2026',NULL,0,'C','U',NULL,'Inclusão de usuários de rede / computador',NULL,NULL,NULL,NULL,_binary 'Nome do usuário :Isadora Mirella dos Santos Torres\r\nPastas de acesso na rede :DS Advocacia\r\n\r\nCPF:13738709665','2026-06-24','14:15:00','2026-06-24','15:15:00','C',299,54,NULL,NULL,NULL,NULL,16,16),(294,39,27,13,0,0,26,NULL,10,NULL,'2026-06-25','09:04:36','2026-06-26','09:54:00',NULL,NULL,NULL,NULL,NULL,NULL,'V',NULL,_binary 'Computador foi formatado, mas necessita de um SSD.',NULL,0,'C','P',NULL,'Desktop - Lentidão do desktop',NULL,NULL,NULL,NULL,_binary 'Patrimõnio do Computador : 091865\r\nUsuário: kamily.quites\r\n\r\n\r\nComputador apresentação lentidão para qualquer funcionalidade que se tenta fazer nele.','2026-06-25','09:04:00','2026-06-27','09:04:00','C',291,19,NULL,NULL,NULL,NULL,27,27),(295,22,16,27,0,0,1,NULL,7,NULL,'2026-06-25','10:52:31',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'V',NULL,NULL,NULL,NULL,'C','P',NULL,'Desktop - Não liga',NULL,NULL,NULL,NULL,_binary 'Patrimônio :9595995\r\n\r\n','2026-06-25','10:52:00','2026-06-27','10:52:00','X',301,20,'2026-06-25',_binary 'treinamento de usuário','10:52:00',16,16,NULL),(296,44,29,31,0,0,27,'2026-06-25',9,'14:31:00','2026-06-25','11:30:00','2026-06-26','17:21:00','2026-06-25','2026-06-25','14:31:00','2026-06-25',NULL,NULL,'V','',_binary 'Entregue para Etelvina. Chip corporativo.',0,0,'C','P','','Telefonia Movel - Solicitacao CHIP',NULL,'C','',NULL,_binary 'Secretaria/Gerencia: Gabinete do Prefeito \r\nUsuário: Camila Ferreira Abel ','2026-06-25','11:30:00','2026-06-25','11:30:00','C',300,71,NULL,NULL,NULL,NULL,29,29),(297,27,27,15,0,0,26,NULL,10,NULL,'2026-06-25','13:02:49','2026-06-26','11:55:00',NULL,NULL,NULL,NULL,NULL,NULL,'V',NULL,_binary 'Computadores, estavam com os HDs ruins, os mesmos foram substituídos.',NULL,0,'C','P',NULL,'Desktop - Lentidão do desktop',NULL,NULL,NULL,NULL,_binary 'Patrimõnio do Computador : 091864\r\nUsuário:\r\nSão 2 computadores, da regional Roça grande. Um esta com tela preta e o outro está com lentidão.','2026-06-25','13:02:00','2026-06-27','13:02:00','C',302,19,NULL,NULL,NULL,NULL,27,27),(298,51,16,7,0,0,1,NULL,7,NULL,'2026-06-26','11:42:09','2026-06-29','19:25:00',NULL,NULL,NULL,NULL,NULL,NULL,'V',NULL,_binary 'Manutenção realizad pelo Técnico Eliezer da Selbetti',NULL,0,'C','P',NULL,'Impressora - Scanner',NULL,NULL,NULL,NULL,_binary 'SELB da impressora: 56FN máquina MP601\r\nA impressora está no setor da Sala Mineira, ao escanear utilizando a parte superior (que puxa a folha), o resultado do escaneamento vem com uma lista no meio, assim não conseguimos digitalizar dessa forma que é mais rápida.\r\nPoderia também configurar a máquina para que todas as digitalizações fossem feitas coloridas, sem necessidade de parametrizar (porque no atual está para preto e branco).','2026-06-26','11:42:00','2026-06-29','11:42:00','C',303,35,NULL,NULL,NULL,NULL,16,16),(299,49,16,33,0,0,26,NULL,8,NULL,'2026-06-26','15:47:40','2026-06-26','16:03:00',NULL,NULL,NULL,NULL,NULL,NULL,'V',NULL,_binary 'Monitor sem problemas. Problema no office que deverá ser restaurado. Provavelmente incompatibilidades no windows 7 já que não tem mais suporte ou vírus',NULL,0,'C','U',NULL,'Monitor - Sem Imagem',NULL,NULL,NULL,NULL,_binary 'Patrimônio :\r\nChecou cabos de energia e dados (sim/não)','2026-06-26','15:48:00','2026-06-26','17:00:00','C',304,26,NULL,NULL,NULL,NULL,16,16),(300,46,16,7,0,0,26,NULL,8,NULL,'2026-06-29','09:06:42','2026-06-30','09:20:00',NULL,NULL,NULL,NULL,NULL,NULL,'V',NULL,_binary 'Impressora instalada no usuário',NULL,0,'C','U',NULL,'Impressoras - Falha na impressão',NULL,NULL,NULL,NULL,_binary 'Nao estou conseguindo imprimir la na impressora do gabinete.','2026-06-29','09:11:00','2026-07-29','12:06:00','C',306,37,NULL,NULL,NULL,NULL,16,16),(301,35,35,6,0,0,26,NULL,13,NULL,'2026-06-30','09:17:50','2026-06-30','09:18:00',NULL,NULL,NULL,NULL,NULL,NULL,'V',NULL,_binary 'desktop não ligava porque a fonte estava conectada somente na energia e não no desktop',NULL,0,'C','P',NULL,'Desktop - Não liga',NULL,NULL,NULL,NULL,_binary 'Patrimônio :computador nao esta ligando','2026-06-30','09:18:00','2026-07-02','09:17:00','C',307,20,NULL,NULL,NULL,NULL,35,35),(302,35,35,6,0,0,26,NULL,13,NULL,'2026-06-30','09:22:25','2026-06-30','09:23:00',NULL,NULL,NULL,NULL,NULL,NULL,'V',NULL,_binary 'telefone foi trocado de local',NULL,0,'C','P',NULL,'Telefonia - Solicitação Instalação',NULL,NULL,NULL,NULL,_binary 'Local: centro adminstrativo\r\nReferência:\r\nContato:\r\n\r\nmudança de local do telefone','2026-06-30','09:22:00','2026-06-30','09:22:00','C',308,63,NULL,NULL,NULL,NULL,35,35),(303,30,16,14,0,0,26,NULL,12,NULL,'2026-06-30','10:15:52','2026-06-30','10:16:00',NULL,NULL,NULL,NULL,NULL,NULL,'V',NULL,_binary 'Instalação de impressora na rede cabeada e na rede sem fio',NULL,0,'C','P',NULL,'Impressoras - Instalação',NULL,NULL,NULL,NULL,_binary 'SELB da Impressora :\r\nImpressora HP m130fw\r\nConfiguração de IP; teste de impressão','2026-06-30','10:16:00','2026-06-30','12:15:00','C',305,36,NULL,NULL,NULL,NULL,16,16),(304,30,30,14,0,0,26,NULL,12,NULL,'2026-06-30','11:35:53','2026-07-03','09:05:00',NULL,NULL,NULL,NULL,NULL,NULL,'V',NULL,_binary 'Scaner e impressora ok',NULL,0,'C','P',NULL,'Impressora - Scanner',NULL,NULL,NULL,NULL,_binary 'Impressora HP M130 offline; scanner não funciona.','2026-06-30','11:36:00','2026-07-03','11:35:00','C',310,35,NULL,NULL,NULL,NULL,30,16),(305,49,16,33,0,0,26,NULL,14,NULL,'2026-06-30','14:40:41','2026-06-30','16:16:00',NULL,NULL,NULL,NULL,NULL,NULL,'V',NULL,_binary 'Deu tudo certo.',NULL,0,'C','U',NULL,'Instalação de Software',NULL,NULL,NULL,NULL,_binary 'Instalação dos Softwares Libre Office e Libre Office Calc, para edição de textos e planilhas.\r\n','2026-06-30','14:40:00','2026-06-30','16:40:00','C',311,28,NULL,NULL,NULL,NULL,16,50),(306,42,16,30,0,0,1,NULL,7,NULL,'2026-06-30','14:41:30','2026-06-30','15:06:00',NULL,NULL,NULL,NULL,NULL,NULL,'V',NULL,_binary 'Usuário já possuia acesso. foi configurado para ter acesso a opção de Execução/emenda parlamentar',NULL,0,'C','P',NULL,'Sistema Moderna - Criação de Usuário',NULL,NULL,NULL,NULL,_binary 'Nome do usuário :Alessandra.lima\r\nnúmero do CPF : 033.807.876-20\r\nModulos que irá acessar (compras,contabilidade, credores, prestação de contas, transparência, patrimônio :\r\n\r\n','2026-06-30','14:41:00','2026-06-30','16:41:00','C',312,15,NULL,NULL,NULL,NULL,16,16),(307,38,16,6,0,0,27,NULL,9,NULL,'2026-06-30','15:44:26',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'V',NULL,NULL,NULL,NULL,'C','P',NULL,'Telefonia - Solicitação Instalação',NULL,NULL,NULL,NULL,_binary 'Local: Setor de Patrimônio\r\nReferência: Solicitação de novo aparelho de telefone fixo para atender as demandas do Setor\r\nContato: 1079 ramal\r\n\r\nBruna Góes','2026-06-30','15:44:00','2026-07-06','15:44:00','S',309,63,NULL,NULL,NULL,NULL,16,NULL),(308,37,16,6,0,0,26,NULL,10,NULL,'2026-07-01','10:16:09','2026-07-01','11:11:00',NULL,NULL,NULL,NULL,NULL,NULL,'V',NULL,_binary 'Foi transferido o computador e instalado.',NULL,0,'C','P',NULL,'Desktop - Instalação e Desinstalação',NULL,NULL,NULL,NULL,_binary 'Transferir um computador da secretaria de governo pra a secretaria de administração.','2026-07-01','10:16:00','2026-07-01','12:16:00','C',313,23,NULL,NULL,NULL,NULL,16,27),(309,27,27,9,0,0,26,NULL,10,NULL,'2026-07-01','10:40:30','2026-07-01','12:00:00',NULL,NULL,NULL,NULL,NULL,NULL,'V',NULL,_binary 'Foi feita a instalação do computador da Alexandra, aplicativos e a instalação da impressora.',NULL,0,'C','P',NULL,'Desktop - Instalação e Desinstalação',NULL,NULL,NULL,NULL,_binary 'Patrimonio:\r\nLocal: Regional Ana Lucia\r\nNome solicitante: Marisa\r\n\r\n\r\ninstalar computador, aplicativos, impressora.','2026-07-01','10:40:00','2026-07-01','12:40:00','C',314,23,NULL,NULL,NULL,NULL,27,27),(310,49,16,33,0,0,26,NULL,13,NULL,'2026-07-01','10:51:11','2026-07-01','11:09:00',NULL,NULL,NULL,NULL,NULL,NULL,'V',NULL,_binary 'Foi instalado o aplicativo no computador.',NULL,0,'C','U',NULL,'Instalação de Software',NULL,NULL,NULL,NULL,_binary 'Possui Licença(sim/não) ? \r\nDescrição do software a ser instalado:\r\nUrgência para instalar libre office completo para a estagiaria ANA LUIZA. Está sem acesso a qualquer tipo de documento em Word, wordpad ou libre Office. \r\n\r\nAdvocacia Municipal ','2026-07-01','10:51:00','2026-07-01','12:51:00','C',315,28,NULL,NULL,NULL,NULL,16,27),(311,34,16,29,0,0,26,NULL,8,NULL,'2026-07-01','15:41:54','2026-07-01','16:00:00',NULL,NULL,NULL,NULL,NULL,NULL,'V',NULL,_binary 'Impressora instalada.',NULL,0,'C','P',NULL,'Impressoras - Instalação',NULL,NULL,NULL,NULL,_binary 'SELB da Impressora : instalar a opção de consguir imprimir  no not de uma colaboradora ','2026-07-01','15:42:00','2026-07-01','17:41:00','C',316,36,NULL,NULL,NULL,NULL,16,50),(312,28,28,9,0,0,1,NULL,11,NULL,'2026-07-01','16:02:07','2026-07-01','16:03:00',NULL,NULL,NULL,NULL,NULL,NULL,'V',NULL,_binary 'Responsável pelo transporte:',0,0,'C','P',NULL,'Impressoras - Solicitação de toner',NULL,NULL,NULL,NULL,_binary 'Se for impressora colorida, qual a cor to toner ?: Amarelo\r\n','2026-07-01','16:02:00','2026-07-01','16:32:00','C',317,41,NULL,NULL,NULL,NULL,28,28),(313,28,28,7,0,0,1,NULL,11,NULL,'2026-07-01','16:08:11','2026-07-01','17:04:00',NULL,NULL,NULL,NULL,NULL,NULL,'V',NULL,_binary 'Responsável pelo transporte:',0,0,'C','P',NULL,'Impressoras - Solicitação de toner',NULL,NULL,NULL,NULL,_binary 'Se for impressora colorida, qual a cor to toner ?: Magenta\r\n','2026-07-01','16:08:00','2026-07-01','16:38:00','C',318,41,NULL,NULL,NULL,NULL,28,16),(314,34,16,29,0,0,26,'2026-07-02',8,'14:44:00','2026-07-01','16:10:00',NULL,NULL,'2026-07-02','2026-07-02','14:44:00','2026-07-02',NULL,NULL,'V','',NULL,0,0,'C','U','','Desktop - Não liga',NULL,'C','',NULL,_binary 'Patrimônio : 119315','2026-07-01','16:10:00','2026-07-03','17:10:00','S',319,20,NULL,NULL,NULL,NULL,16,NULL),(315,33,16,32,0,0,1,NULL,7,NULL,'2026-07-02','09:03:58','2026-07-02','09:16:00',NULL,NULL,NULL,NULL,NULL,NULL,'V',NULL,_binary 'Login do Usuário:rosimeire.rocha\r\nconfiguração do usuário alterado para controladoria e cpad no drive (S). Necessário reiniciar computador',NULL,0,'C','U',NULL,'Inclusão de usuários de rede / computador',NULL,NULL,NULL,NULL,_binary 'Nome do usuário : Rosimeire Rocha\r\nPastas de acesso na rede : cpad (S:)','2026-07-02','09:04:00','2026-07-02','10:03:00','C',320,54,NULL,NULL,NULL,NULL,16,16),(316,44,16,31,0,0,27,NULL,9,NULL,'2026-07-03','09:03:27','2026-07-06','10:52:00',NULL,NULL,NULL,NULL,NULL,NULL,'V',NULL,_binary 'Ocorrência foi passada para empresa de telefonia (speedNet) que irá tomar as providências técnicas necessárias',NULL,0,'C','P',NULL,'Telefonia - Manutenção',NULL,NULL,NULL,NULL,_binary 'Número Telefone: 36727672\r\nNúmero Ramal: 1055\r\nOutro Telefone fixo ou celular para contato : 36727699 ou 975718723 \r\n\r\nObservação:  O telefone da recepção tem recebido diversas ligações do 156 de Belo Horizonte, gentileza averiguar a situação.  ','2026-07-03','09:03:00','2026-07-07','09:03:00','C',321,65,NULL,NULL,NULL,NULL,16,16),(317,46,16,7,0,0,1,NULL,7,NULL,'2026-07-03','09:49:28',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'V',NULL,NULL,NULL,0,'C','P',NULL,'Solicitação de novo Mouse',NULL,NULL,NULL,NULL,_binary 'o meu esta com defeito','2026-07-03','09:49:00','2026-07-06','09:49:00','S',322,30,NULL,NULL,NULL,NULL,16,NULL),(318,38,35,6,0,0,26,NULL,13,NULL,'2026-07-03','10:36:45','2026-07-03','10:41:00',NULL,NULL,NULL,NULL,NULL,NULL,'V',NULL,_binary 'cabo de rede estava conectado apenas no pc e fora do ponto de rede ',NULL,0,'C','U',NULL,'Manutenção de Ponto de Rede',NULL,NULL,NULL,NULL,_binary 'Local: Setor de Patrimônio, Computador da colaboradora Fiama\r\n\r\n\r\nA nossa colaboradora está sem acesso à REDE e precisa da mesma para dar continuidade ao trabalho, solicitamos visita técnica com urgência.\r\n\r\nObrigada, Bruna.','2026-07-03','10:37:00','2026-07-03','11:06:00','C',323,68,NULL,NULL,NULL,NULL,35,35),(319,32,16,33,0,0,1,NULL,7,NULL,'2026-07-03','11:15:37','2026-07-03','11:16:00',NULL,NULL,NULL,NULL,NULL,NULL,'V',NULL,_binary 'Topico correto usuário de rede / computador e reset de senha . Foi passado para usuário nova senha sabara@2026',NULL,0,'C','P',NULL,'Manutenção de Computadores DeskTop',NULL,NULL,NULL,NULL,_binary 'Prezado(a), bom dia!!\r\n\r\nSolicito por gentileza que resete a senha do usuário abaixo para sabara@2026:\r\n\r\nRenata.Ferreira\r\n\r\nAtenciosamente,\r\nBruno Sette Marra\r\n','2026-07-03','11:15:00','2026-07-03','11:15:00','C',324,70,NULL,NULL,NULL,NULL,16,16),(320,37,16,35,0,0,1,NULL,7,NULL,'2026-07-06','08:48:27','2026-07-06','08:52:00',NULL,NULL,NULL,NULL,NULL,NULL,'V',NULL,_binary 'Login do Usuário:fabio.jesuita\r\nSenha Inicial :sabara@2026',NULL,0,'C','P',NULL,'Inclusão de usuários de rede / computador',NULL,NULL,NULL,NULL,_binary 'Nome do usuário : Fabio Jesuita Magalhães - cpf: 871.705.826-00\r\nPastas de acesso na rede : acesso a rede do RH','2026-07-06','08:48:00','2026-07-06','09:48:00','C',326,54,NULL,NULL,NULL,NULL,16,16),(321,37,16,35,0,0,1,NULL,7,NULL,'2026-07-06','09:22:54','2026-07-06','09:30:00',NULL,NULL,NULL,NULL,NULL,NULL,'V',NULL,_binary 'usuário não foi informado. Abrir como criação de usuário para esse tipo de ocorrência. Como o usuário já possui acesso ao supernova\r\npedir ao Sr. Nilo a criação de usuário no módulo de RH',NULL,0,'C','U',NULL,'Sistema Moderna - Ateração de configuração do usuários',NULL,NULL,NULL,NULL,_binary 'Acesso ao Sistema Supernova para folha de pagamento','2026-07-06','09:23:00','2026-07-06','10:22:00','C',327,74,NULL,NULL,NULL,NULL,16,16),(322,27,27,6,0,0,26,NULL,10,NULL,'2026-07-06','09:45:08','2026-07-06','09:45:00',NULL,NULL,NULL,NULL,NULL,NULL,'V',NULL,_binary 'Foi instalado o scanner, no computador do Leandro.',NULL,0,'C','P',NULL,'Impressora - Scanner',NULL,NULL,NULL,NULL,_binary 'SELB da impressora\r\n\r\nInstalar scanner na impressora.','2026-07-06','09:45:00','2026-07-09','09:45:00','C',328,35,NULL,NULL,NULL,NULL,27,27),(323,34,16,29,0,0,1,NULL,7,NULL,'2026-07-06','10:16:25','2026-07-06','10:40:00',NULL,NULL,NULL,NULL,NULL,NULL,'V',NULL,_binary 'Usuário de Acesso :douglas.martins\r\nSenha de Acesso :sabara@2026\r\n\r\nUsuário do(s) módulo(s) :douglas.martins\r\nSenha do(s) módulo(s) :sabara@2026',NULL,0,'C','P',NULL,'Sistema Moderna - Criação de Usuário',NULL,NULL,NULL,NULL,_binary 'Nome do usuário :Douglas Roberto Martins, matrícula 7311, \r\nnúmero do CPF : CPF 051.352.376-66.\r\nModulos que irá acessar (compras, orçamentário.)\r\npatrimônio : 118309\r\n\r\n\r\n','2026-07-06','10:16:00','2026-07-06','12:16:00','C',329,15,NULL,NULL,NULL,NULL,16,16),(324,52,16,9,0,0,1,NULL,7,NULL,'2026-07-06','11:05:06','2026-07-06','14:21:00',NULL,NULL,NULL,NULL,NULL,NULL,'V',NULL,_binary 'Impressora instalado e dados do novo e-mail repassados. Intalação da impressora feita pelo Jonathan do desenvolvimento social',NULL,0,'C','U',NULL,'Impressoras - Não está imprimindo',NULL,NULL,NULL,NULL,_binary 'SELB da Impressora :bom dia aqui marco Antônio não estou conseguindo imprimir a caixa de impressão encontra a impressora, obrigado peço também criar um email so para abrir chamada, que pode ser manutensão_semob.mg.gov.br','2026-07-06','11:05:00','2026-07-06','17:00:00','C',325,38,NULL,NULL,NULL,NULL,16,16),(325,35,35,35,0,0,26,NULL,13,NULL,'2026-07-06','11:22:28','2026-07-06','11:23:00',NULL,NULL,NULL,NULL,NULL,NULL,'V',NULL,_binary 'aplicativo instalado ',NULL,0,'C','P',NULL,'Instalação do aplicativo no computador',NULL,NULL,NULL,NULL,_binary 'Local: setor de rh\r\nUsuário:fabio.jesuita','2026-07-06','11:22:00','2026-07-06','11:52:00','C',330,77,NULL,NULL,NULL,NULL,35,35),(326,42,16,30,0,0,1,NULL,7,NULL,'2026-07-06','12:04:17','2026-07-06','12:05:00',NULL,NULL,NULL,NULL,NULL,NULL,'V',NULL,_binary 'Novos locais COORDENAÇÃO DE APOIO A SEGURANÇA PUBLICA	CDFSA e GERENCIA DE SEGURANÇA GDFS foram incluidos ao perfil do usuário e anteriores excluido no sistema de protocoloWEB',NULL,0,'C','P',NULL,'Protocoloweb - Alteração de locais de tramitação',NULL,NULL,NULL,NULL,_binary 'Login do Usuário :Alessandralima\r\nNovos locais de tramitação: Secretaria Municipal de segurança Publica\r\nExcluir locais anteriores (sim/Não) : sim','2026-07-06','12:04:00','2026-07-06','12:34:00','C',331,67,NULL,NULL,NULL,NULL,16,16),(327,33,16,32,0,0,26,NULL,10,NULL,'2026-07-06','14:51:55','2026-07-06','15:11:00',NULL,NULL,NULL,NULL,NULL,NULL,'V',NULL,_binary 'Foi reiniciado o adaptador de internet.',NULL,0,'C','U',NULL,'Queda de Link',NULL,NULL,NULL,NULL,_binary 'Local :Sala do Controlador Samuel\r\nA rede parou','2026-07-06','14:52:00','2026-07-06','15:51:00','C',332,51,NULL,NULL,NULL,NULL,16,27),(328,47,16,8,0,0,1,NULL,11,NULL,'2026-07-07','09:08:03','2026-07-07','09:48:00',NULL,NULL,NULL,NULL,NULL,NULL,'V',NULL,_binary 'Na verdade estava com um erro no sistema de Supernova quando na emissão de arquivo PDF. Informamos o novo procedimento para execução bem como instalado programa Foxit Reader. Testes ok',NULL,0,'C','U',NULL,'Desktop - Formatação de Computador',NULL,NULL,NULL,NULL,_binary 'Usuário : Luciene Firmo\r\nPatrimonio:0833332\r\n\r\nDescrição do problema: Erro ao salvar relatório de conciliação bancária.','2026-07-07','09:08:00','2026-07-07','09:08:00','C',333,8,NULL,NULL,NULL,NULL,16,28),(329,40,16,12,0,0,26,NULL,8,NULL,'2026-07-07','15:21:23',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'V',NULL,NULL,NULL,NULL,'C','P',NULL,'Redefinição de senha de acesso rede / computador',NULL,NULL,NULL,NULL,_binary 'Nome do usuário : Raylane Vitoria de Souza Fernandes\r\nLogin do usuário : raylane.vitoria\r\n\r\nObs: Servidora questiona que o login fornecido no dia 01 de Julho não lhe da acesso a maquina na qual esta trabalhando. Situação comprovada pela gerência imediata. Conseguem nos ajudar? Desde já muito grato.','2026-07-07','15:21:00','2026-07-08','16:21:00','A',334,55,NULL,NULL,NULL,NULL,16,NULL),(330,34,16,29,0,0,1,NULL,7,NULL,'2026-07-08','09:15:48','2026-07-08','09:33:00',NULL,NULL,NULL,NULL,NULL,NULL,'V',NULL,_binary 'Login do Usuário:laura.lima\r\nSenha Inicial :sabara@2026',NULL,0,'C','P',NULL,'Inclusão de usuários de rede / computador',NULL,NULL,NULL,NULL,_binary 'Nome do usuário : laura.lima\r\nPastas de acesso na rede : DFCIVIL','2026-07-08','09:15:00','2026-07-08','10:15:00','C',335,54,NULL,NULL,NULL,NULL,16,16),(331,37,16,35,0,0,1,NULL,7,NULL,'2026-07-08','11:28:38','2026-07-08','11:31:00',NULL,NULL,NULL,NULL,NULL,NULL,'V',NULL,_binary 'Local de tramitação alterado para secretaria de Recursos Humanos',NULL,0,'C','P',NULL,'Protocoloweb - Alteração de locais de tramitação',NULL,NULL,NULL,NULL,_binary 'Login do Usuário : fabio.magalhaes\r\n\r\nNovos locais de tramitação: RH\r\n\r\nExcluir locais anteriores (sim/Não) :\r\n\r\nAdicionar a este usuário a possibilidade de aceitar e tramitar processos do RH\r\n\r\n\r\n\r\n','2026-07-08','11:28:00','2026-07-08','11:58:00','C',336,67,NULL,NULL,NULL,NULL,16,16),(332,49,16,33,0,0,1,NULL,11,NULL,'2026-07-08','11:37:26',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'V',NULL,NULL,NULL,NULL,'C','P',NULL,'Reparo de software',NULL,NULL,NULL,NULL,_binary 'Antivírus expirou e computador está notificando que foram encontrados 7 vírus. Computador travado, a servidora não consegue ne, fechar a tela.','2026-07-08','11:37:00','2026-07-08','13:37:00','A',337,52,NULL,NULL,NULL,NULL,16,NULL),(333,16,16,28,0,0,1,NULL,7,NULL,'2026-07-08','11:57:17','2026-07-08','11:58:00',NULL,NULL,NULL,NULL,NULL,NULL,'V',NULL,_binary 'Responsável pelo transporte:Iana funcionária da CEI',0,0,'C','P',NULL,'Impressoras - Solicitação de toner',NULL,NULL,NULL,NULL,_binary 'Se for impressora colorida, qual a cor to toner ?:Não\r\nSELB da Impressora :im430 CEI','2026-07-08','11:57:00','2026-07-08','12:27:00','C',338,41,NULL,NULL,NULL,NULL,16,16);
/*!40000 ALTER TABLE `ordens` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ordens_check`
--

DROP TABLE IF EXISTS `ordens_check`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ordens_check` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_ordem` int DEFAULT NULL,
  `id_check` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_ordens_check_ordens` (`id_ordem`),
  KEY `FK_ordens_check_checklist` (`id_check`),
  CONSTRAINT `FK_ordens_check_checklist` FOREIGN KEY (`id_check`) REFERENCES `checklist` (`id`),
  CONSTRAINT `FK_ordens_check_ordens` FOREIGN KEY (`id_ordem`) REFERENCES `ordens` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ordens_check`
--

LOCK TABLES `ordens_check` WRITE;
/*!40000 ALTER TABLE `ordens_check` DISABLE KEYS */;
/*!40000 ALTER TABLE `ordens_check` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ordens_executores`
--

DROP TABLE IF EXISTS `ordens_executores`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ordens_executores` (
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
) ENGINE=InnoDB AUTO_INCREMENT=369 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ordens_executores`
--

LOCK TABLES `ordens_executores` WRITE;
/*!40000 ALTER TABLE `ordens_executores` DISABLE KEYS */;
INSERT INTO `ordens_executores` VALUES (1,3,7,2,0,0,0),(2,2,7,1,0,0,0),(3,5,11,2,0,0,0),(4,4,7,2,0,0,0),(5,6,11,2,0,0,0),(6,8,10,24,0,0,0),(7,8,8,24,0,0,0),(8,10,10,1,0,0,0),(9,10,8,2,0,0,0),(10,12,10,2,0,0,0),(11,14,10,1,0,0,0),(12,15,7,0,30,0,0),(13,16,10,1,0,0,0),(14,17,10,1,0,0,0),(15,18,11,0,30,0,0),(16,19,7,2,0,0,0),(17,13,8,4,0,0,0),(18,20,11,0,30,0,0),(19,21,11,0,30,0,0),(20,22,7,0,30,0,0),(21,23,7,0,30,0,0),(22,25,7,0,30,0,0),(23,27,11,24,0,0,0),(24,29,11,1,0,0,0),(25,30,7,1,0,0,0),(26,34,12,2,30,0,0),(27,35,7,1,0,0,0),(28,32,7,1,0,0,0),(29,31,7,0,30,0,0),(30,24,10,72,0,0,0),(31,37,10,72,0,0,0),(32,38,7,1,0,0,0),(33,36,12,1,0,0,0),(34,39,7,0,30,0,0),(35,40,12,40,0,0,0),(36,40,8,16,0,0,0),(37,42,10,3,0,0,0),(38,42,8,3,0,0,0),(39,45,12,3,30,0,0),(40,41,12,2,0,0,0),(41,46,12,3,0,0,0),(42,48,7,1,0,0,0),(43,47,7,0,30,0,0),(44,52,7,0,30,0,0),(45,51,7,1,0,0,0),(46,50,7,2,0,0,0),(47,33,10,48,0,0,0),(48,33,12,48,0,0,0),(49,33,8,48,0,0,0),(50,43,12,2,0,0,0),(51,44,12,5,0,0,0),(52,54,8,48,0,0,0),(53,53,12,0,0,0,0),(54,55,11,1,0,0,0),(55,56,12,0,15,0,0),(56,58,11,2,0,0,0),(57,59,12,0,30,0,0),(58,60,11,24,0,0,0),(59,54,12,48,0,0,0),(60,64,8,3,0,0,0),(61,64,12,3,0,0,0),(62,65,7,2,0,0,0),(63,66,11,3,0,0,0),(64,68,7,1,0,0,0),(65,69,10,3,0,0,0),(66,69,12,3,0,0,0),(67,69,8,3,0,0,0),(68,62,10,3,0,0,0),(69,62,12,3,0,0,0),(70,62,8,3,0,0,0),(72,70,12,2,0,0,0),(73,71,11,2,0,0,0),(74,71,11,2,0,0,0),(75,73,7,1,0,0,0),(76,72,7,0,30,0,0),(77,63,12,104,0,0,0),(78,74,7,1,0,0,0),(79,75,7,1,0,0,0),(80,79,12,48,0,0,0),(81,79,8,48,0,0,0),(82,82,7,1,0,0,0),(83,81,7,1,0,0,0),(84,9,10,2,0,0,0),(85,9,8,2,0,0,0),(86,9,12,2,0,0,0),(87,61,10,0,0,0,0),(88,61,8,0,0,0,0),(89,61,12,0,0,0,0),(90,83,7,1,0,0,0),(91,84,7,1,0,0,0),(92,85,12,2,0,0,0),(93,86,12,0,30,0,0),(94,87,12,0,10,0,0),(95,88,12,0,10,0,0),(96,89,7,1,0,0,0),(97,80,12,48,0,0,0),(98,90,7,0,30,0,0),(99,91,7,1,0,0,0),(100,94,8,40,0,0,0),(101,94,12,40,0,0,0),(102,95,12,0,0,0,0),(103,96,12,3,0,0,0),(105,77,8,8,0,0,0),(106,76,8,8,0,0,0),(107,98,7,0,30,0,0),(108,99,7,1,0,0,0),(109,93,12,3,0,0,0),(110,100,8,7,0,0,0),(111,100,12,7,0,0,0),(112,101,11,1,0,0,0),(113,102,11,2,0,0,0),(114,103,7,1,0,0,0),(115,107,7,1,0,0,0),(116,108,7,1,0,0,0),(117,109,7,0,30,0,0),(118,111,7,0,30,0,0),(119,112,7,0,30,0,0),(120,110,11,3,0,0,0),(121,110,12,3,0,0,0),(122,113,7,0,30,0,0),(123,97,8,8,0,0,0),(124,114,12,1,0,0,0),(125,115,12,8,0,0,0),(126,115,8,8,0,0,0),(127,116,8,8,0,0,0),(128,116,12,8,0,0,0),(129,117,8,8,0,0,0),(130,117,12,8,0,0,0),(131,117,11,8,0,0,0),(132,119,11,1,0,0,0),(133,120,8,1,0,0,0),(134,121,8,0,30,0,0),(135,122,11,24,0,0,0),(136,122,8,24,0,0,0),(137,124,7,0,30,0,0),(138,126,11,2,0,0,0),(139,127,7,1,0,0,0),(140,128,7,0,30,0,0),(141,129,12,1,0,0,0),(142,118,12,0,40,0,0),(143,125,12,8,0,0,0),(144,133,11,3,0,0,0),(145,134,7,0,30,0,0),(146,131,12,24,0,0,0),(147,131,8,24,0,0,0),(148,123,8,24,0,0,0),(149,135,12,8,0,0,0),(150,136,7,1,0,0,0),(151,140,12,0,30,0,0),(152,141,11,0,30,0,0),(153,142,11,0,30,0,0),(154,144,7,0,40,0,0),(155,106,8,2,0,0,0),(156,106,12,2,0,0,0),(157,7,10,2,0,0,0),(158,145,12,0,10,0,0),(159,146,11,2,0,0,0),(160,147,12,3,0,0,0),(161,105,8,0,30,0,0),(162,105,12,0,30,0,0),(163,148,12,2,20,0,0),(164,137,8,48,0,0,0),(165,143,12,48,0,0,0),(166,150,7,0,30,0,0),(167,149,8,4,0,0,0),(168,149,12,4,0,0,0),(169,152,7,0,30,0,0),(170,153,11,2,0,0,0),(171,155,7,0,30,0,0),(172,154,11,2,0,0,0),(173,156,11,0,30,0,0),(174,157,7,0,40,0,0),(175,158,7,0,40,0,0),(176,159,7,0,30,0,0),(177,161,7,0,20,0,0),(178,160,7,0,20,0,0),(179,162,8,2,0,0,0),(180,163,12,24,0,0,0),(181,164,12,26,0,0,0),(182,151,9,1,0,0,0),(183,170,10,8,0,0,0),(184,166,10,24,0,0,0),(185,166,8,24,0,0,0),(186,169,10,2,0,0,0),(187,173,11,0,30,0,0),(188,174,7,0,10,0,0),(189,176,7,0,20,0,0),(190,171,8,1,0,0,0),(191,177,12,48,0,0,0),(192,179,11,0,30,0,0),(193,182,7,0,30,0,0),(194,183,10,48,0,0,0),(195,175,10,24,0,0,0),(196,186,7,1,0,0,0),(197,185,10,1,0,0,0),(198,187,7,0,30,0,0),(199,184,12,0,0,0,0),(200,189,7,0,30,0,0),(201,188,12,1,0,0,0),(202,191,7,0,30,0,0),(203,192,7,1,0,0,0),(204,194,7,0,15,0,0),(205,193,12,0,15,0,0),(206,195,12,1,0,0,0),(207,196,10,6,0,0,0),(208,190,8,24,0,0,0),(209,197,11,0,30,0,0),(210,198,8,0,30,0,0),(211,198,10,0,30,0,0),(212,200,9,1,0,0,0),(213,199,12,0,10,0,0),(214,201,10,2,0,0,0),(215,201,8,2,0,0,0),(216,203,10,2,0,0,0),(217,203,8,2,0,0,0),(218,202,10,2,0,0,0),(219,202,8,2,0,0,0),(220,204,10,0,10,0,0),(221,205,8,0,30,0,0),(222,208,7,0,30,0,0),(223,207,7,0,30,0,0),(224,206,7,0,30,0,0),(225,209,7,0,30,0,0),(226,211,7,0,30,0,0),(227,210,8,0,30,0,0),(228,212,12,0,30,0,0),(229,213,7,0,30,0,0),(230,215,10,48,0,0,0),(231,215,8,48,0,0,0),(232,215,12,48,0,0,0),(233,215,13,48,0,0,0),(234,216,10,48,0,0,0),(235,216,8,48,0,0,0),(236,216,12,48,0,0,0),(237,216,13,48,0,0,0),(238,214,7,0,15,0,0),(239,217,7,0,15,0,0),(240,219,10,48,0,0,0),(241,219,8,48,0,0,0),(242,219,12,48,0,0,0),(243,219,13,48,0,0,0),(244,220,7,0,30,0,0),(245,221,10,48,0,0,0),(246,221,8,48,0,0,0),(247,221,11,48,0,0,0),(248,221,12,48,0,0,0),(249,221,13,48,0,0,0),(250,222,10,48,0,0,0),(251,222,8,48,0,0,0),(252,222,12,48,0,0,0),(253,222,13,48,0,0,0),(254,223,12,4,0,0,0),(255,224,7,0,30,0,0),(256,225,10,72,0,0,0),(257,225,8,72,0,0,0),(258,225,8,72,0,0,0),(259,227,7,0,30,0,0),(260,228,7,0,5,0,0),(261,229,7,1,10,0,0),(262,226,12,72,0,0,0),(263,230,7,0,10,0,0),(264,231,7,0,15,0,0),(265,234,7,0,5,0,0),(266,236,7,0,10,0,0),(267,235,12,1,0,0,0),(268,237,12,1,0,0,0),(269,238,12,0,40,0,0),(270,239,10,24,0,0,0),(271,239,8,24,0,0,0),(272,240,12,0,0,0,0),(273,241,7,0,10,0,0),(274,243,7,0,30,0,0),(275,242,7,0,30,0,0),(276,244,7,0,10,0,0),(277,245,7,1,0,0,0),(278,246,8,1,0,0,0),(279,248,10,3,0,0,0),(280,248,8,3,0,0,0),(281,249,10,5,0,0,0),(282,249,8,5,0,0,0),(283,250,7,1,0,0,0),(284,251,7,0,30,0,0),(285,252,11,0,20,0,0),(286,253,7,0,5,0,0),(287,247,12,0,0,0,0),(288,247,10,0,0,0,0),(289,247,11,0,0,0,0),(290,254,8,0,0,0,0),(291,254,12,0,0,0,0),(292,254,13,0,0,0,0),(293,254,10,0,0,0,0),(294,247,8,0,0,0,0),(295,256,8,1,0,0,0),(296,256,10,1,0,0,0),(297,257,12,0,0,0,0),(298,258,7,0,15,0,0),(299,259,7,0,30,0,0),(300,260,11,0,10,0,0),(301,261,10,6,0,0,0),(302,261,8,48,0,0,0),(303,262,12,0,10,0,0),(304,266,7,0,30,0,0),(305,265,7,0,30,0,0),(306,264,12,0,20,0,0),(307,268,12,0,0,0,0),(308,268,8,0,0,0,0),(309,271,7,0,30,0,0),(310,274,7,0,10,0,0),(311,276,10,72,0,0,0),(312,275,10,1,0,0,0),(313,279,7,0,30,0,0),(314,277,12,0,0,0,0),(315,280,13,0,30,0,0),(316,278,13,0,30,0,0),(317,273,10,2,0,0,0),(318,273,8,2,0,0,0),(319,273,12,2,0,0,0),(320,272,10,0,15,0,0),(321,272,8,0,15,0,0),(322,272,12,0,15,0,0),(323,281,12,0,10,0,0),(324,282,12,2,0,0,0),(325,283,14,0,20,0,0),(326,285,11,0,30,0,0),(327,284,11,0,30,0,0),(328,287,7,0,30,0,0),(329,288,7,0,30,0,0),(330,289,7,0,30,0,0),(331,292,7,0,30,0,0),(332,293,7,0,30,0,0),(333,294,10,48,0,0,0),(334,297,8,48,0,0,0),(335,297,10,48,0,0,0),(336,299,8,0,30,0,0),(337,296,9,4,0,0,0),(338,301,13,48,0,0,0),(339,300,8,1,0,0,0),(340,302,13,0,0,0,0),(341,303,12,5,0,0,0),(342,306,7,0,10,0,0),(343,305,14,1,0,0,0),(344,309,10,2,0,0,0),(345,309,8,2,0,0,0),(346,310,10,2,0,0,0),(347,308,10,2,0,0,0),(348,308,8,2,0,0,0),(349,308,13,2,0,0,0),(350,311,8,0,30,0,0),(351,312,11,0,30,0,0),(352,313,11,0,30,0,0),(353,315,7,0,30,0,0),(354,304,12,1,0,0,0),(355,318,13,0,30,0,0),(356,319,7,0,10,0,0),(357,320,7,0,30,0,0),(358,321,7,0,1,0,0),(359,322,10,72,0,0,0),(360,323,7,0,40,0,0),(361,325,13,0,30,0,0),(362,326,7,0,30,0,0),(363,324,7,1,0,0,0),(364,327,10,24,0,0,0),(365,317,7,0,30,0,0),(366,328,11,72,0,0,0),(367,330,7,0,30,0,0),(368,331,7,0,30,0,0);
/*!40000 ALTER TABLE `ordens_executores` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ordens_ferramentas`
--

DROP TABLE IF EXISTS `ordens_ferramentas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ordens_ferramentas` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_ordem` int DEFAULT NULL,
  `id_ferramenta` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_ordens_ferramentas_ordens` (`id_ordem`),
  KEY `FK_ordens_ferramentas_ferramentas` (`id_ferramenta`),
  CONSTRAINT `FK_ordens_ferramentas_ferramentas` FOREIGN KEY (`id_ferramenta`) REFERENCES `ferramentas` (`id`),
  CONSTRAINT `FK_ordens_ferramentas_ordens` FOREIGN KEY (`id_ordem`) REFERENCES `ordens` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ordens_ferramentas`
--

LOCK TABLES `ordens_ferramentas` WRITE;
/*!40000 ALTER TABLE `ordens_ferramentas` DISABLE KEYS */;
/*!40000 ALTER TABLE `ordens_ferramentas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ordens_imagens`
--

DROP TABLE IF EXISTS `ordens_imagens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ordens_imagens` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_ordem` int DEFAULT NULL,
  `caminho` varchar(250) DEFAULT NULL,
  `data` date DEFAULT NULL,
  `comentario` varchar(120) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_ordens_imagens_ordens` (`id_ordem`),
  CONSTRAINT `FK_ordens_imagens_ordens` FOREIGN KEY (`id_ordem`) REFERENCES `ordens` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ordens_imagens`
--

LOCK TABLES `ordens_imagens` WRITE;
/*!40000 ALTER TABLE `ordens_imagens` DISABLE KEYS */;
/*!40000 ALTER TABLE `ordens_imagens` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ordens_materiais`
--

DROP TABLE IF EXISTS `ordens_materiais`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ordens_materiais` (
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
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ordens_materiais`
--

LOCK TABLES `ordens_materiais` WRITE;
/*!40000 ALTER TABLE `ordens_materiais` DISABLE KEYS */;
INSERT INTO `ordens_materiais` VALUES (1,134,8,8,1,0,'S'),(2,140,8,8,1,0,'S'),(3,141,8,8,2,0,'S'),(4,142,8,8,1,0,'S'),(5,145,8,8,1,0,'S'),(6,150,8,8,2,0,'S'),(7,152,7,8,1,0,'S'),(8,152,4,8,1,0,'S'),(9,155,7,8,1,0,'S'),(10,173,4,8,1,0,'S'),(11,179,4,8,1,0,'S'),(12,182,8,8,1,0,'S'),(13,191,8,8,1,0,'S'),(14,194,8,8,1,0,'S'),(15,204,8,8,2,0,'S'),(16,205,8,8,1,0,'S'),(17,209,7,8,1,0,'S'),(18,211,8,8,1,0,'S'),(19,212,10,8,1,0,'S'),(20,212,8,8,1,0,'S'),(21,213,8,8,1,0,'S'),(22,228,8,8,1,0,'S'),(23,234,8,8,1,0,'S'),(24,236,10,8,1,0,'S'),(25,241,8,8,1,0,'S'),(26,244,4,8,1,0,'S'),(27,252,7,8,1,0,'S'),(28,253,8,8,1,0,'S'),(29,260,8,8,1,0,'S'),(30,262,4,8,1,0,'S'),(31,262,6,8,1,0,'S'),(32,262,5,8,1,0,'S'),(34,312,5,8,1,0,'S'),(35,313,7,8,1,0,'S'),(36,333,8,8,1,0,'S');
/*!40000 ALTER TABLE `ordens_materiais` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ordens_plano`
--

DROP TABLE IF EXISTS `ordens_plano`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ordens_plano` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_plano` int DEFAULT NULL,
  `id_ordem` int DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `FK_ordens_plano_planejamento` (`id_plano`) USING BTREE,
  KEY `FK_ordens_plano_ordens` (`id_ordem`) USING BTREE,
  CONSTRAINT `FK_ordens_plano_ordens` FOREIGN KEY (`id_ordem`) REFERENCES `ordens` (`id`),
  CONSTRAINT `FK_ordens_plano_planejamento` FOREIGN KEY (`id_plano`) REFERENCES `planejamento` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ordens_plano`
--

LOCK TABLES `ordens_plano` WRITE;
/*!40000 ALTER TABLE `ordens_plano` DISABLE KEYS */;
INSERT INTO `ordens_plano` VALUES (1,2,53);
/*!40000 ALTER TABLE `ordens_plano` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ordens_pop`
--

DROP TABLE IF EXISTS `ordens_pop`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ordens_pop` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_ordem` int DEFAULT NULL,
  `id_pop` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_ordens_pop_ordens` (`id_ordem`),
  KEY `FK_ordens_pop_pops` (`id_pop`),
  CONSTRAINT `FK_ordens_pop_ordens` FOREIGN KEY (`id_ordem`) REFERENCES `ordens` (`id`),
  CONSTRAINT `FK_ordens_pop_pops` FOREIGN KEY (`id_pop`) REFERENCES `pops` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ordens_pop`
--

LOCK TABLES `ordens_pop` WRITE;
/*!40000 ALTER TABLE `ordens_pop` DISABLE KEYS */;
INSERT INTO `ordens_pop` VALUES (1,53,12);
/*!40000 ALTER TABLE `ordens_pop` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ordens_prestadores`
--

DROP TABLE IF EXISTS `ordens_prestadores`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ordens_prestadores` (
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
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ordens_prestadores`
--

LOCK TABLES `ordens_prestadores` WRITE;
/*!40000 ALTER TABLE `ordens_prestadores` DISABLE KEYS */;
INSERT INTO `ordens_prestadores` VALUES (9,11,1,24,0,0,0),(10,26,1,72,0,0,0),(11,49,1,72,0,0,0),(12,28,2,48,0,0,0),(13,67,3,3,0,0,0),(14,78,3,0,0,0,0),(15,138,4,24,0,0,0),(16,255,3,0,30,0,0),(17,298,1,1,0,0,0),(18,316,3,0,0,0,0),(19,333,1,0,0,0,0);
/*!40000 ALTER TABLE `ordens_prestadores` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ordens_suspensao`
--

DROP TABLE IF EXISTS `ordens_suspensao`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ordens_suspensao` (
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
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ordens_suspensao`
--

LOCK TABLES `ordens_suspensao` WRITE;
/*!40000 ALTER TABLE `ordens_suspensao` DISABLE KEYS */;
INSERT INTO `ordens_suspensao` VALUES (2,9,'2026-03-23','09:21:00','2026-05-07','12:12:00',_binary 'Proplema elétrico foi detectado no prédio. Aguardando intervenção do Eletricista do Obras'),(3,7,'2026-03-23','09:22:00','2026-05-07','12:12:00',_binary 'Proplema elétrico foi detectado no prédio. Aguardando intervenção do Eletricista do Obras'),(4,57,'2026-04-01','09:26:00','2026-05-07','12:12:00',_binary 'Proplema elétrico foi detectado no prédio. Aguardando intervenção do Eletricista do Obras'),(5,53,'2026-04-01','09:34:00','2026-05-07','12:12:00',_binary 'Proplema elétrico foi detectado no prédio. Aguardando intervenção do Eletricista do Obras'),(6,61,'2026-04-06','16:27:00','2026-05-07','12:12:00',_binary 'Proplema elétrico foi detectado no prédio. Aguardando intervenção do Eletricista do Obras'),(7,61,'2026-04-06','16:38:00','2026-05-07','12:12:00',_binary 'Proplema elétrico foi detectado no prédio. Aguardando intervenção do Eletricista do Obras'),(8,92,'2026-04-14','09:04:00','2026-05-07','12:12:00',_binary 'Proplema elétrico foi detectado no prédio. Aguardando intervenção do Eletricista do Obras'),(9,97,'2026-04-14','16:44:00','2026-05-07','12:12:00',_binary 'Proplema elétrico foi detectado no prédio. Aguardando intervenção do Eletricista do Obras'),(10,93,'2026-04-16','09:31:00','2026-05-07','12:12:00',_binary 'Proplema elétrico foi detectado no prédio. Aguardando intervenção do Eletricista do Obras'),(11,106,'2026-04-16','11:54:00','2026-05-07','12:12:00',_binary 'Proplema elétrico foi detectado no prédio. Aguardando intervenção do Eletricista do Obras'),(12,168,'2026-05-14','09:33:00',NULL,NULL,_binary 'Aguardando disponibilidades de linha junto a speednet'),(13,167,'2026-05-14','09:34:00',NULL,NULL,_binary 'Aguardando disponibilidade de linha junto a speednet'),(14,232,'2026-06-09','16:09:00',NULL,NULL,_binary 'Aguardando usuário posicionar sobre onde é para colocar novo cabo e metragem'),(15,233,'2026-06-09','16:16:00',NULL,NULL,_binary 'Aguardando posicionamento do usuário sobre celular com microsftauthenticator para acessar ao e-mail. Senha já foi trocada como solicitado\r\n'),(16,240,'2026-06-18','14:09:00',NULL,NULL,_binary 'Aguardando posicionamento da regional sobre a rede elétrica'),(17,277,'2026-06-23','16:20:00',NULL,NULL,_binary 'Aguardando definição de local e usuário que irá utilizar'),(18,270,'2026-06-23','16:21:00',NULL,NULL,_binary 'Aguardando compra de SSd para instalação no equipamento'),(19,290,'2026-06-23','16:22:00',NULL,NULL,_binary 'Aguardando compra de fonte de alimentação'),(20,314,'2026-07-03','12:22:00',NULL,NULL,_binary 'Aguardando reposição do computador.'),(21,317,'2026-07-06','16:54:00',NULL,NULL,_binary 'Falta de insumo para reposição no momento. Aguardando compra pela secretaria'),(22,307,'2026-07-06','16:56:00',NULL,NULL,_binary 'Aguardando aditivo do contrato para solicitar novas linhas');
/*!40000 ALTER TABLE `ordens_suspensao` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pa_diretrizes`
--

DROP TABLE IF EXISTS `pa_diretrizes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pa_diretrizes` (
  `id` int NOT NULL,
  `descricao` varchar(150) NOT NULL,
  `texto` blob,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pa_diretrizes`
--

LOCK TABLES `pa_diretrizes` WRITE;
/*!40000 ALTER TABLE `pa_diretrizes` DISABLE KEYS */;
/*!40000 ALTER TABLE `pa_diretrizes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `perfil_usuarios`
--

DROP TABLE IF EXISTS `perfil_usuarios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `perfil_usuarios` (
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
  `gerenciar_ordem` char(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `perfil_usuarios`
--

LOCK TABLES `perfil_usuarios` WRITE;
/*!40000 ALTER TABLE `perfil_usuarios` DISABLE KEYS */;
INSERT INTO `perfil_usuarios` VALUES (1,'Perfil padrão','S','S','S','S','S','S','S','S','S','S','S','S','S','S','S','S','S','S','S','S','S','N','S','S','S','S','S','S','S','S',NULL,'N','S','S'),(2,'Prefeitura','N','N','N','N','N','N','N','N','S','N','N','N','S','S','N',NULL,'N','N','N',NULL,'N','N','N','N','N','N','N','N','N','N',NULL,'N',NULL,NULL);
/*!40000 ALTER TABLE `perfil_usuarios` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `planejamento`
--

DROP TABLE IF EXISTS `planejamento`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `planejamento` (
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
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `planejamento`
--

LOCK TABLES `planejamento` WRITE;
/*!40000 ALTER TABLE `planejamento` DISABLE KEYS */;
INSERT INTO `planejamento` VALUES (2,6,'2024-10-09','CPLMS','Implantação do 1doc',_binary 'Implantação do sistema 1doc para gestão de documentos');
/*!40000 ALTER TABLE `planejamento` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `planejamento_diretrizes`
--

DROP TABLE IF EXISTS `planejamento_diretrizes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `planejamento_diretrizes` (
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
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `planejamento_diretrizes`
--

LOCK TABLES `planejamento_diretrizes` WRITE;
/*!40000 ALTER TABLE `planejamento_diretrizes` DISABLE KEYS */;
INSERT INTO `planejamento_diretrizes` VALUES (1,2,2,1,'30 dias','Regional Ravena','Patricia',1400,'N',_binary 'Obra de contenção',_binary 'Padrão ISO9000',_binary 'teste de diretiva');
/*!40000 ALTER TABLE `planejamento_diretrizes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pop_anexos`
--

DROP TABLE IF EXISTS `pop_anexos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pop_anexos` (
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
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pop_anexos`
--

LOCK TABLES `pop_anexos` WRITE;
/*!40000 ALTER TABLE `pop_anexos` DISABLE KEYS */;
INSERT INTO `pop_anexos` VALUES (1,5,NULL,'anexos/Supernova.zip','2025-10-08',NULL),(3,7,'Manual de Intalação','anexos/Como instalar impressora de rede.docx','2025-10-16','Glaison Queiroz'),(4,8,'Manual','anexos/Procedimentos para administrar os usuários na Rede wi.docx','2025-10-16','Glaison Queiroz'),(5,9,NULL,'anexos/formulario_formatacao_pcs.docx','2025-10-16',NULL),(6,11,NULL,'anexos/Colocar Computador no domínio da Prefeitura.docx','2025-10-16',NULL),(8,7,'Driver de Impressora atualizado em 28/11/2025','anexos/drive im430.zip','2025-11-28','Glaison Queiroz'),(9,12,'Guia Microsoft Autenticator','anexos/Guia-Microsoft-Authenticator-PMS.pdf','2025-11-28','Glaison Queiroz'),(10,5,NULL,'anexos/config_email.jpg','2025-11-28',NULL),(11,13,NULL,'anexos/documentação LInuxMint.doc','2026-01-28',NULL);
/*!40000 ALTER TABLE `pop_anexos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pops`
--

DROP TABLE IF EXISTS `pops`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pops` (
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
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pops`
--

LOCK TABLES `pops` WRITE;
/*!40000 ALTER TABLE `pops` DISABLE KEYS */;
INSERT INTO `pops` VALUES (5,5,6,1,'1','Instalação de Acesso ao sistema de Gestão da Moderna','','Glaison Queiroz',_binary 'Acesso ao sistema ',_binary 'Instalador fornecido pela Moderna em anexo',_binary 'Instalação de Acesso ao software de Gestão da Moderna (supernova)\r\nem máquina com sistema operacional windows',_binary 'Não se aplica',_binary 'Verificar conexão com internet',_binary 'Não se aplica em outros sistemas operacionais.\r\n\r\nPara outros sistema operacionais acessar link via navegado :\r\n\r\nhttps://websabara.supernova.com.br:491/sabara.html','2025-11-28',NULL,_binary '- acesse 192.168.8.8/utils/supernova\r\n- copie supernova.zip\r\n- descompactar em c:\r\n- executar supernova.bat\r\n- solicite usuario testar acesso nivel 1 e depois ao modulo que deseja\r\n- fim',_binary 'Acesso ao sistema ERP da Moderna',_binary 'Não se aplica',''),(6,5,6,1,'1','Administração do  AD','','Welligton Jardins',_binary 'Manutenção do AD da rede',_binary '- Usuário e senha de Administrador\r\n- Acesso liberado ao servidor do AD.',_binary 'Gerenciamento do Ad. da prefeitura, permitindo inclusão de usuários e seus\r\nrespectivos acessos, alteração de acessos, alteração de senhas, bloqueio de\r\nacesso e exclusão\r\n',_binary 'Acesso deve ser extermamente restrito ',_binary 'Validar todos os pedidos de inclusão e manutenção de usários via \r\ne-mail ou aplicativo de gastão de serviços',_binary 'Passar ao Gestor de rede','2025-11-28',NULL,_binary 'Acessar servidor do ad atrvés do ssh ou putty e seguir instruções \r\ndo documento em anexo',_binary 'Manutenção de dos usuários do AD. da rede e seus acessos',_binary 'Acesso deve ser extermamente restrito ',_binary 'em anexo'),(7,5,6,1,'3','Instalação de Impressora Im 430','Glaison Queiroz','Ederson',_binary 'Impressão e scaner funcioando em rede',_binary 'Driver da impressora em anexo',_binary 'O documento em anexo descreve rotina para instalação de impressora\r\nRicoh im 430 e também configuração do Scaner em rede',_binary 'Não se aplica',_binary 'Atualização do driver',_binary 'Não se aplica','2025-11-28',NULL,_binary 'Processo incluso no documento em anexo',_binary 'Instalação de impressora de rede',_binary 'Não se aplica',_binary 'https://support.ricoh.com/bb_v1oi/pub_e/oi/0001078/0001078975/VD0A47xxx_06/D0A47726A_bp.pdf'),(8,5,6,1,'1','Administração de Usuário wi-fi (Sabará HotSpot)','','Glaison Queiroz',_binary 'Acesso do usuário a rede wi-fi (hot_spot)',_binary 'Usuário e senha de administrador no ip http://10.1.200.1/',_binary 'Administração dos usuário da rede wi-fi (hot-spot)',_binary 'não se aplica',_binary 'não se aplica',_binary 'não se aplica','2025-11-28',NULL,_binary 'Processos de gerênciamento no documento em anexo',_binary 'Dar acesso a usuários da prefeitura ou prestadores de serviço a\r\nrede wi-fi da speed net (hot spot)',_binary 'não se aplica',_binary 'não se aplica'),(9,5,6,1,'1','Solicitação de Formatação de Computador','','Ederson Fernandes','','',_binary 'Descrição de solicitação de formatação de computadores','','','','2025-10-16',NULL,_binary 'Processo descrito no documento em anexo','','',''),(10,5,6,1,'1','Instalação de Certificado Digital A1','','Ederson Fernandes','','',_binary 'Instalação de Certificado Digital A!','','','','2025-10-16',NULL,_binary '(Certificado digital) instalar a1\r\n- baixe pfx\r\n- abra certmgr.msc\r\n- importe para pessoal\r\n- marcar como nao exportavel\r\n- finalize\r\n- teste ecac\r\n- Oriente guardar pfx com segurança','','',''),(11,5,6,1,'1','Configurar Computador no domínio da Prefeitura','','Glaison Queiroz',_binary 'Acesso do computador a internet e rede da prefeitura',_binary 'Usuário e senha de administrador',_binary 'Procedimentos para configura computadores no Dominio da prefeitura',_binary 'Não se aplica',_binary 'não se aplica',_binary 'Não se aplica','2025-11-28',NULL,_binary 'Processos para configuração no documento em anexo',_binary 'Colocar equipamento no dominio para acesso a internet e as pastas de rede','',_binary 'Não se aplica'),(12,5,6,1,'1','Instalação do Microsoft Authenticator para e-mail coorporativo','','Glaison Queiroz',_binary 'Acesso seguro ao e-mail coorporativo',_binary 'Dispositivo celular coorporativo (da preferencia)',_binary 'Configuração do Microsoft Authenticator',_binary 'Não se aplica',_binary 'Não se apllica',_binary 'Não se aplica','2025-11-28',NULL,_binary 'Processos de instalação / configuração no documento em anexo',_binary 'Acesso seguro ao e-mail coorporativo',_binary 'não se aplica',''),(13,5,6,1,'1','Instalação e configuração linux ','Lucio Machado','Lucio Machado',_binary 'Funcionamento de Computadores na rede da prefeitura utilizando Linux como sistema operacional',_binary 'Pen drive com o sistema operacional',_binary 'Pop para instalação e configuração de sistema operacional Linux nos computadores da Prefeitura',_binary 'não se aplica',_binary 'não se aplica',_binary 'não se aplica','2026-01-28',NULL,_binary 'Em anexo',_binary 'Compuador cliente na rede da prefeitura',_binary 'não se aplica',_binary 'Internet'),(14,5,6,1,'1','PJEOffice','','Lucio Machado','','',_binary 'Erro do PJE no browser: \"PJEOffice não está em execução\"','','','','2026-02-10',NULL,_binary '- Limpar cache;\r\n- reiniciar pc.','','','');
/*!40000 ALTER TABLE `pops` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `prestadores`
--

DROP TABLE IF EXISTS `prestadores`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `prestadores` (
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
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `prestadores`
--

LOCK TABLES `prestadores` WRITE;
/*!40000 ALTER TABLE `prestadores` DISABLE KEYS */;
INSERT INTO `prestadores` VALUES (1,3,'Selbetti','Selbetti','Eliezer','(47) 3441-6000','','','','','','','','MG','83483230000186',NULL,0,0,'S',''),(2,3,'Dell Computadores SA','Dell Suporte','Dell','(31) 3672-7688','','','','','','','','MG','72381189000110',NULL,0,0,'S',''),(3,3,'SpeedNet','SpeedNet','Suporte','(99) 9999999-9999','','','','','','','','MG','22886816000105',NULL,0,0,'S',''),(4,3,'Flavio Maielo','Flavio Maielo','Flavo Maielo','(31) 3672-7688','','','','','','','','MG','83483230000186',NULL,0,0,'S','');
/*!40000 ALTER TABLE `prestadores` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `preventivas`
--

DROP TABLE IF EXISTS `preventivas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `preventivas` (
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
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `preventivas`
--

LOCK TABLES `preventivas` WRITE;
/*!40000 ALTER TABLE `preventivas` DISABLE KEYS */;
/*!40000 ALTER TABLE `preventivas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `preventivas_checklist`
--

DROP TABLE IF EXISTS `preventivas_checklist`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `preventivas_checklist` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_check` int DEFAULT NULL,
  `id_preventiva` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_preventivas_checklist_checklist` (`id_check`),
  KEY `FK_preventivas_checklist_preventivas` (`id_preventiva`),
  CONSTRAINT `FK_preventivas_checklist_checklist` FOREIGN KEY (`id_check`) REFERENCES `checklist` (`id`),
  CONSTRAINT `FK_preventivas_checklist_preventivas` FOREIGN KEY (`id_preventiva`) REFERENCES `preventivas` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `preventivas_checklist`
--

LOCK TABLES `preventivas_checklist` WRITE;
/*!40000 ALTER TABLE `preventivas_checklist` DISABLE KEYS */;
/*!40000 ALTER TABLE `preventivas_checklist` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `preventivas_executores`
--

DROP TABLE IF EXISTS `preventivas_executores`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `preventivas_executores` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_preventiva` int DEFAULT NULL,
  `id_executor` int DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `FK_preventivas_executores_preventivas` (`id_preventiva`) USING BTREE,
  KEY `FK_preventivas_executores_executores` (`id_executor`) USING BTREE,
  CONSTRAINT `FK_preventivas_executores_executores` FOREIGN KEY (`id_executor`) REFERENCES `executores` (`id`),
  CONSTRAINT `FK_preventivas_executores_preventivas` FOREIGN KEY (`id_preventiva`) REFERENCES `preventivas` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `preventivas_executores`
--

LOCK TABLES `preventivas_executores` WRITE;
/*!40000 ALTER TABLE `preventivas_executores` DISABLE KEYS */;
/*!40000 ALTER TABLE `preventivas_executores` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `preventivas_ferramentas`
--

DROP TABLE IF EXISTS `preventivas_ferramentas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `preventivas_ferramentas` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_ferramenta` int DEFAULT NULL,
  `id_preventiva` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK__ferramentas` (`id_ferramenta`),
  KEY `FK__preventivas` (`id_preventiva`),
  CONSTRAINT `FK__ferramentas` FOREIGN KEY (`id_ferramenta`) REFERENCES `ferramentas` (`id`),
  CONSTRAINT `FK__preventivas` FOREIGN KEY (`id_preventiva`) REFERENCES `preventivas` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `preventivas_ferramentas`
--

LOCK TABLES `preventivas_ferramentas` WRITE;
/*!40000 ALTER TABLE `preventivas_ferramentas` DISABLE KEYS */;
/*!40000 ALTER TABLE `preventivas_ferramentas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `preventivas_materiais`
--

DROP TABLE IF EXISTS `preventivas_materiais`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `preventivas_materiais` (
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
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `preventivas_materiais`
--

LOCK TABLES `preventivas_materiais` WRITE;
/*!40000 ALTER TABLE `preventivas_materiais` DISABLE KEYS */;
/*!40000 ALTER TABLE `preventivas_materiais` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `preventivas_pop`
--

DROP TABLE IF EXISTS `preventivas_pop`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `preventivas_pop` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_pop` int DEFAULT NULL,
  `id_preventiva` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_preventivas_pop_pops` (`id_pop`),
  KEY `FK_preventivas_pop_preventivas` (`id_preventiva`),
  CONSTRAINT `FK_preventivas_pop_pops` FOREIGN KEY (`id_pop`) REFERENCES `pops` (`id`),
  CONSTRAINT `FK_preventivas_pop_preventivas` FOREIGN KEY (`id_preventiva`) REFERENCES `preventivas` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `preventivas_pop`
--

LOCK TABLES `preventivas_pop` WRITE;
/*!40000 ALTER TABLE `preventivas_pop` DISABLE KEYS */;
/*!40000 ALTER TABLE `preventivas_pop` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `recursos`
--

DROP TABLE IF EXISTS `recursos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `recursos` (
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
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `recursos`
--

LOCK TABLES `recursos` WRITE;
/*!40000 ALTER TABLE `recursos` DISABLE KEYS */;
INSERT INTO `recursos` VALUES (5,6,5,3,4,6,1,27,99,'DeskTop Workstation Precision 3660','116549','WorkStation','00000','Ótimo','00000','2025-10-02','2025-10-02',0,0,'2025-10-02','2025-10-02','2025-10-02','S','','',_binary '16 mb de Memoria\r\nSSD de 500 mb','N','N','N','','','','A','A'),(6,6,7,3,4,6,26,25,100,'Computador Positivo','455555','Positivo ','','Bom','00000','2026-03-18','2026-03-18',0,0,'2026-03-18','2026-03-18','2026-03-18','S','','','','N','N','N','','','','A','A'),(7,6,5,3,4,6,26,29,99,'DeskTop WorkStation Precison 3660','116551','Work Station','000000','Ótimo','000000','2026-03-23','2026-03-23',0,0,'2026-03-23','2026-03-23','2026-03-23','S','','','','N','N','N','','','','A','A'),(8,6,7,3,4,6,26,30,100,'Positivo Master D480','119245','Positivo master','1af73jn50','','0000000','2026-03-31','2026-03-31',0,0,'2026-03-31','2026-03-31','2026-03-31','S','','','','N','N','N','','','','A','A'),(9,6,5,3,4,6,26,30,99,'Computador','093015','DELL','81KNVN2','Ótimo','0000000','2026-03-31','2026-03-31',0,0,'2026-03-31','2026-03-31','2026-03-31','S','','','','N','N','N','','','','A','A'),(10,6,5,3,4,6,26,6,99,'Computador DELL Optiplex 3050','091878','DELL','8KCRCK2','Ótimo','0000000','2026-03-31','2026-03-31',0,0,'2026-03-31','2026-03-31','2026-03-31','S','','',_binary 'Em uso na Junta Militar','N','N','N','','','','A','A'),(11,6,5,3,4,6,26,12,99,'Computador DeskTop Optiplex 3050','093042','DeskTop','0000000','','00000','2026-04-08','2026-04-08',0,0,'2026-04-08','2026-04-08','2026-04-08','S','','','','N','N','N','','','','A','A'),(12,6,5,3,4,6,26,12,99,'Computador DELL Optiplex 3050','093034','DeskTop','00000','','000','2026-04-08','2026-04-08',0,0,'2026-04-08','2026-04-08','2026-04-08','S','','','','N','N','N','','','','A','A'),(13,6,6,3,4,6,26,8,110,'Computador Lenovo','119311','M10AH','PE01MT7U','Razoável','0000000','2026-04-09','2026-04-09',0,0,'2026-04-09','2026-04-09','2026-01-01','S','','','','N','N','N','','','','A','A'),(14,6,5,3,4,6,26,32,99,'Computador','105826','DELL Optiplex 3000','','Muito Bom','000000','2026-04-10','2026-04-10',0,0,'2026-04-10','2026-04-10','2026-04-10','S','','','','N','N','N','','','','A','A'),(15,6,5,3,4,6,26,7,99,'Computador','95088','DELL Optiplex 3050','525KYR2','Ótimo','000000','2026-04-10','2026-04-10',0,0,'2026-04-10','2026-04-10','2026-04-10','S','','','','N','N','N','','','','A','A'),(16,6,5,3,4,6,26,7,99,'Computador','91887','DELL Optiplex 3050 Small Form Factor','8KKQCK2','','000000','2026-04-10','2026-04-10',0,0,'2026-04-10','2026-04-10','2026-04-10','S','','','','N','N','N','','','','A','A'),(17,6,5,3,4,6,26,11,99,'Computador','97354','Optiplex3070','960CH73','','000000','2026-04-23','2026-04-23',0,0,'2026-04-23','2026-04-23','2026-04-23','S','','','','N','N','N','','','','A','A'),(18,6,5,3,4,6,26,11,99,'Computador OptiPlex','097349','DeskTop','6893726223','','000000','2026-04-27','2026-04-27',0,0,'2026-04-27','2026-04-27','2026-04-27','S','','','','N','N','N','','','','A','A'),(19,6,7,3,4,6,26,30,100,'Computador positivo Master','119220','positivo master','00000','','','2026-04-27','2026-04-27',0,0,'2026-04-27','2026-04-27','2026-04-27','S','','','','N','N','N','','','','A','A'),(20,6,9,3,4,6,26,8,102,'Computador','83332','HP Compaq 8200','','','000000','2026-05-04','2026-05-04',0,0,'2026-05-04','2026-05-04','2026-05-04','S','','','','N','N','N','','','','A','A'),(21,6,5,3,4,6,26,9,99,'Computador','103910','Precision3650','','','0000000','2026-05-12','2026-05-12',0,0,'2026-05-12','2026-05-12','2026-05-12','S','','','','N','N','N','','','','A','A'),(22,6,9,3,4,6,26,6,102,'Desktop HP','081940','DeskTop','00000','','0000','2026-05-13','2026-05-13',0,0,'2026-05-13','2026-05-13','2026-05-13','S','','','','N','N','N','','','','A','A'),(23,6,6,3,4,6,26,7,110,'Desktop ThinkPad','119306','ThinkPad','000','','00000','2026-05-15','2026-05-15',0,0,'2026-05-15','2026-05-15','2026-05-15','S','','','','N','N','N','','','','A','A'),(24,6,5,3,4,6,26,10,99,'Computador','92784','Optiplex3050','','','000000','2026-05-15','2026-05-15',0,0,'2026-05-15','2026-05-15','2026-05-15','S','','',_binary 'PC da Advocacia Municipal','N','N','N','','','','A','A'),(25,6,6,3,4,6,26,13,110,'LeNovo ThinkCenter','099484','DeskTop','000','Bom','000000000','2026-05-20','2026-05-20',0,0,'2026-05-20','2026-05-20','2026-05-20','S','','','','N','N','N','','','','A','A'),(26,6,5,3,4,6,26,30,99,'Computador','97353','Dell Optiplex3050','','','000000','2026-06-17','2026-06-17',0,0,'2026-06-17','2026-06-17','2026-06-17','S','','','','N','N','N','','','','A','A'),(27,6,5,3,4,6,26,12,99,'Computador','095088','Dell Optiplex3050','','','000000','2026-06-23','2026-06-23',0,0,'2026-06-23','2026-06-23','2026-06-23','S','','','','N','N','N','','','','A','A'),(28,6,5,3,4,6,26,12,99,'Computador','093038','Dell Optiplex3050','','','000000','2026-06-23','2026-06-23',0,0,'2026-06-23','2026-06-23','2026-06-23','S','','','','N','N','N','','','','A','A');
/*!40000 ALTER TABLE `recursos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `servico_instalacao`
--

DROP TABLE IF EXISTS `servico_instalacao`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `servico_instalacao` (
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
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `servico_instalacao`
--

LOCK TABLES `servico_instalacao` WRITE;
/*!40000 ALTER TABLE `servico_instalacao` DISABLE KEYS */;
/*!40000 ALTER TABLE `servico_instalacao` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `setores`
--

DROP TABLE IF EXISTS `setores`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `setores` (
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
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `setores`
--

LOCK TABLES `setores` WRITE;
/*!40000 ALTER TABLE `setores` DISABLE KEYS */;
INSERT INTO `setores` VALUES (5,'Secretaria Municipal de Saúde',5,'pms','','','','SIM','1'),(6,'Secretaria Municipal de Administração',5,'pms','','','','SIM','1'),(7,'Secretaria de Planejamento',5,'pms','','','','SIM','1'),(8,'Secretaria Municipal de Fazenda',5,'pms','','','','SIM','1'),(9,'Secretaria de Obras',5,'pms','','','','SIM','1'),(10,'Secretaria Municipal de Desenvolvimento Social',5,'pms','','','','SIM','1'),(11,'Secretaria Municipal de Meio Ambiente',5,'pms','','','','SIM','1'),(12,'Secretaria Municipal de Turismo',5,'pms','','','','SIM','1'),(13,'Secretaria Municipal de Cultura',5,'pms','','','','SIM','1'),(14,'Secretaria Municipal de Esportes',5,'pms','','','','SIM','1'),(15,'Regional Roça Grande',5,'pms','','','','SIM','1'),(16,'Regional General Carneiro',5,'pms','','','','SIM','1'),(17,'Regional Borges',5,'pms','','','','SIM','1'),(18,'Regional Ana Lucia',5,'pms','','','','SIM','1'),(19,'Regional Ravena',5,'pms','','','','SIM','1'),(20,'CRAS Roça Grande',5,'pms','','','','SIM','1'),(21,'CRAS Fátima',5,'pms','','','','SIM','1'),(22,'CRAS General Carneiro',5,'pms','','','','SIM','1'),(23,'CRAS Alvorada',5,'pms','','','','SIM','1'),(24,'UPA',5,'pms','','','','SIM','1'),(25,'Regional Fátima',5,'pms','','','','SIM','1'),(27,'Coordenação de Informática',6,'Welligton jardim','(31) 3672-7688','','','SIM','1'),(28,'Secretaria Municipal de Educação',6,'Prefeitura','','','','SIM','1'),(29,'Secretaria de Defesa Civil',6,'pms','','','','SIM','1'),(30,'Secretaria de Segurança Pública',6,'pms','','','','SIM','1'),(31,'Gabinete',6,'PMS','','','','SIM','1'),(32,'Controladoria Municipal',6,'pms','','','','SIM','1'),(33,'Procuradoria Juridica',6,'pms','(31) 3672-7688','','','SIM','1'),(34,'PROCON',6,'pms','','','','SIM','1'),(35,'Recursos Humanos',6,'Reinaldo','','','rh@sabara.mg.gov.br','SIM','1'),(36,'Secretaria de Fazenda - Tributos',6,'Glaison','(31) 3672-7688','','issonline@sabara.mg.gov.br','SIM','1');
/*!40000 ALTER TABLE `setores` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `solicitacao`
--

DROP TABLE IF EXISTS `solicitacao`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `solicitacao` (
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
) ENGINE=InnoDB AUTO_INCREMENT=339 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `solicitacao`
--

LOCK TABLES `solicitacao` WRITE;
/*!40000 ALTER TABLE `solicitacao` DISABLE KEYS */;
INSERT INTO `solicitacao` VALUES (2,28,16,NULL,NULL,55,'2026-03-18','14:12:00','C','P',_binary 'Nome do usuário :redefinição da senha da usuária Marielly.Pinto\r\nLogin do usuário : Marielly.Pinto\r\n\r\nCONCLUSÃO :\r\n\r\nNova senha do usuário :sabara@2026','','V',2,'2026-03-18','15:20:00','2026-03-18','14:33:00'),(3,10,16,NULL,NULL,10,'2026-03-18','14:23:00','C','P',_binary 'Descrição do e-mail (ex. <descricao>@sabara.mg.gov.br: relacoesinstitucionais.ds@sabara.mg.gov.br\r\nResponsável :\r\n\r\nCONCLUSÃO :\r\n\r\nDescrição do e-mail:relacoesinstitucionais.ds@sabara.mg.gov.br\r\nSenha inicial :sabara@2026','','V',3,'2026-03-18','16:25:00','2026-03-18','14:30:00'),(4,10,16,NULL,NULL,15,'2026-03-18','14:45:00','C','P',_binary 'Nome do usuário :Rafael H. P. Moreira\r\nModulos que irá acessar (compras, estoque, contabilidade, pregão, credores, frotas, prestação de contas, patrimônio :\r\nCompras\r\n\r\n\r\n\r\nCONCLUSÃO :\r\n\r\nUsuário de Acesso : rafael.moreira\r\nSenha de Acesso :sabara@2026\r\n\r\nUsuário do(s) módulo(s) :rafael.moreira\r\nSenha do(s) módulo(s) :sabara@2026','','V',4,'2026-03-18','16:45:00','2026-03-18','15:19:00'),(5,6,28,NULL,NULL,36,'2026-03-18','15:08:00','C','P',_binary 'SELB da Impressora: RVG6\r\n\r\nCONCLUSÃO :\r\n\r\nImpressora instalada com sucesso','','V',5,'2026-03-21','15:09:00','2026-03-18','15:10:00'),(7,6,28,NULL,NULL,36,'2026-03-18','15:11:00','C','P',_binary 'SELB da Impressora : RGV6\r\n\r\nCONCLUSÃO :\r\n\r\nImpressora instalada com sucesso','','V',6,'2026-03-21','15:13:00','2026-03-18','15:14:00'),(8,8,16,NULL,NULL,23,'2026-03-18','15:15:00','C','P',_binary 'Patrimonio:não informado\r\n',_binary 'Problea elétrico solucionado','V',7,'2026-03-18','17:24:00','2026-05-07','12:09:00'),(9,7,29,NULL,NULL,36,'2026-03-18','15:31:00','C','P',_binary 'SELB da Impressora :  Não Informado\r\nAcompanhar retirada de Impressora do Transporte (Olaria) e instalar na Procuradoria Jurídica (substituir impressora).\r\n\r\nCONCLUSÃO :\r\n\r\nBuscamos a impressora e ela se encontra na sala de Informática no Centro Administrativo.','','V',9,'2026-03-21','15:34:00','2026-04-09','13:05:00'),(12,7,29,NULL,NULL,44,'2026-03-18','15:32:00','C','P',_binary 'local : Verificar Pc da Teo e Joelma (lentidão internet)\r\n\r\nCONCLUSÃO :\r\n\r\nAguardando liberação no Firewall.','','V',8,'2026-03-18','16:33:00','2026-03-18','15:49:00'),(14,6,29,NULL,NULL,36,'2026-03-19','07:44:00','C','P',_binary 'SELB da Impressora : NA\r\nMovimentar impressora (mesma secretaria)\r\n\r\nCONCLUSÃO :\r\n\r\nFizemos a mudança de local da impressora. Está funcionando.','','V',10,'2026-03-19','09:45:00','2026-03-19','08:21:00'),(15,5,16,NULL,NULL,38,'2026-03-19','09:54:00','C','P',_binary 'SELB da Impressora :PGZ6\r\n\r\nLentidão na impressão. Passado pelo João da TI da Saúde. \r\nAberto chamado na Selbetti chamado número 13951312\r\n\r\nCONCLUSÃO :\r\n\r\nComentário do Analista: Foi feito teste equipamento imprimindo normalmente','','V',11,'2026-03-22','09:59:00','2026-03-20','10:08:00'),(16,6,27,NULL,NULL,36,'2026-03-19','10:46:00','C','P',_binary 'Mudar instalação da impressora da administração para o RH.\r\n\r\nCONCLUSÃO :\r\n\r\nMudei a instalação da impressora da Administração, do usuário Ricardo para o RH.','','V',12,'2026-03-19','12:47:00','2026-03-19','10:48:00'),(17,8,16,NULL,NULL,59,'2026-03-20','09:47:00','C','P',_binary 'Descrição do Serviço : Acompanhamento no Cadastro de imóveis realizado em ravena\r\n\r\nCONCLUSÃO :\r\n\r\nEfetuado acompanhamento cadastro de imóveis em Ravena. Equipamentos em funcionamento ok.','','V',13,'2026-03-20','17:00:00','2026-03-20','14:00:00'),(18,29,27,NULL,NULL,36,'2026-03-20','09:55:00','C','P',_binary 'Foi feito a instalação da impressora em 5 computadores.\r\n\r\nCONCLUSÃO :\r\n\r\nFoi feito a instalação da impressora em 5 computadores.','','V',14,'2026-03-20','11:56:00','2026-03-20','09:58:00'),(19,9,16,NULL,NULL,54,'2026-03-20','10:19:00','C','P',_binary 'Nome do usuário :Alan Magno Dias da Silva Junior \r\nPastas de acesso na rede :Secretaria de obras\r\n\r\nCONCLUSÃO :\r\n\r\nLogin do Usuário:alan.magno\r\nSenha Inicial :sabara@2026','','V',15,'2026-03-20','11:45:00','2026-03-20','10:27:00'),(20,6,16,NULL,NULL,9,'2026-03-20','10:33:00','C','P',_binary 'usuário :Jeferson (RH)\r\nAtividade a ser executada :Substituir maquina do RH linux pela maquina do rh que encontra-se na manutenção\r\n\r\nCONCLUSÃO :\r\n\r\nComputador foi substituído com êxito. ','','V',16,'2026-03-20','12:02:00','2026-03-20','11:18:00'),(21,7,16,NULL,NULL,15,'2026-03-20','11:55:00','C','P',_binary 'Nome do usuário :\r\n\r\nVenho por meio deste solicitar suporte para liberação de acesso ao sistema Super Nova, bem como verificação de acesso ao módulo de Planejamento para os servidores abaixo relacionados:\r\n\r\nMaria Clara de Oliveira Braga\r\nCPF: 120.084.476-93\r\nMatrícula: 24228\r\nSusie Machado Nunes\r\nCPF: 109.054.556-81\r\nMatrícula: 32602\r\n\r\nLucas Fernandes de Almeida Costa\r\nCPF: 135.614.536-19\r\nMatrícula: 33721\r\n\r\nKarienne Jaqueline Prado\r\nCPF: 083.596.266-00\r\nMatrícula: 34642\r\n\r\nRenata de Araujo Fernandes\r\nCPF: 061.352.736-47\r\nMatrícula: 32292\r\n\r\n(Atualmente sem acesso ao módulo de Planejamento)\r\nModulos que irá acessar (compras, estoque, contabilidade, pregão, credores, frotas, prestação de contas, patrimônio :\r\nmódulo de planejamento\r\n\r\n\r\nCONCLUSÃO :\r\n\r\nSegue  acessos:\r\n\r\nMaria Clara de Oliveira Braga\r\n\r\n         Já possui acesso inicial do sistema. Usuário maria.braga. Se não souber senha (padrão sabara@2026) avisar para fazer reset da mesma\r\n\r\nSusie Machado Nunes\r\n    Usuário de acesso inicial do sistema susie.machado senha inicial sabara@2026\r\n\r\nLucas Fernandes de Almeida Costa\r\n    Usuário de acesso : lucas.costa senha inicial sabara@2026\r\n\r\nKarienne Jaqueline Prado\r\n\r\n     Já possui acesso ao sistema. Usuário karienne.prado. Se não souber senha (padrão sabara@2026) avisar para fazer reset da mesma\r\n\r\nRenata de Araujo Fernandes\r\n\r\n    Já possui acesso ao sistema. Usuário renata.fernandes. Se não souber senha (padrão sabara@2026) avisar para fazer reset da mesma\r\n\r\nOs usuários de acesso ao módulo de planejamento é o mesmo do acesso inicial. Todos com a senha inicial sabara@2026','','V',19,'2026-03-20','17:38:00','2026-03-20','15:38:00'),(22,6,27,NULL,NULL,36,'2026-03-20','12:09:00','C','P',_binary 'Instalar usuário da impressora em outra impressora. Impressora ADM para Rh.\r\n\r\nCONCLUSÃO :\r\n\r\nInstalado usuário da impressora ADM na impressora do Rh.','','V',17,'2026-03-20','14:09:00','2026-03-20','12:10:00'),(23,31,28,NULL,NULL,60,'2026-03-20','15:08:00','C','P',_binary 'Local : Sala de Reunião\r\nResponsável: Joelma\r\n\r\nCONCLUSÃO :\r\n\r\nO Cabo HDMI está com mal contato','','V',18,'2026-03-20','15:39:00','2026-03-20','15:11:00'),(24,31,28,NULL,NULL,28,'2026-03-20','16:15:00','C','P',_binary 'Possui Licença(sim/não) ? não\r\nDescrição do software a ser instalado: WinRAR (Gratuito)\r\n\r\nCONCLUSÃO :\r\n\r\nFoi repassado à servidora Laila como compactar e descompactar arquivos utilizando Winrar','','V',20,'2026-03-20','16:46:00','2026-03-20','16:18:00'),(25,29,16,7,NULL,20,'2026-03-23','08:54:00','C','P',_binary 'Patrimônio :116551\r\n\r\nComputador travado na tela inicial da DELL. Foi feita visita de técnico da dell que trocou a placa mãe.\r\nO equipamento voltou a apresentar o problema dois dias após a visita. \r\n\r\nCONCLUSÃO :\r\n\r\nVisita realizada pelo técnico da dell . Equipamento teve que ser formatado e encontra-se funcional','','R',28,'2026-03-26','10:49:00','2026-03-30','10:13:00'),(26,6,28,NULL,NULL,20,'2026-03-23','09:12:00','C','U',_binary 'Funcioanária relata que o computador não quer ligar\r\n\r\nCONCLUSÃO :\r\n\r\nFoi verificado que a funcionária não ligou o estabilizador. Após ligar o equipamento o computador funcionou perfeitamente','','V',21,'2026-03-23','09:30:00','2026-03-23','09:15:00'),(27,6,16,NULL,NULL,62,'2026-03-23','09:34:00','C','P',_binary 'Nome do Usuário:Thaynara Laura de O. Teixeira\r\nCPF:135.992.306-33\r\nLocais de Tramitação :Protocolo\r\n\r\nCONCLUSÃO :\r\n\r\nLogin do Usuário :thaynara.teixeira\r\nSenha de Acesso :123456','','V',22,'2026-03-23','10:05:00','2026-03-23','09:59:00'),(28,30,29,NULL,NULL,63,'2026-03-23','09:49:00','C','P',_binary 'Local: Praça Getúlio Vargas\r\nReferência: Ponto de Taxi\r\nContato:',_binary 'instalação do ponto de internet e telefonia realizado pela speednet. Necessário aparelho telefônico para configuração','V',78,'2026-04-13','16:03:00','2026-04-14','14:25:00'),(29,32,16,NULL,NULL,48,'2026-03-23','10:12:00','X','P',_binary 'Local:CPAD\r\nNúmero de pontos: 1 ponto\r\nContato : Andréa N. Neves','','V',165,'2026-05-14','10:49:00',NULL,NULL),(30,6,16,NULL,NULL,54,'2026-03-23','10:30:00','C','P',_binary 'Nome do usuário :thaynara.teixeira\r\nPastas de acesso na rede :Administração\r\n\r\nCONCLUSÃO :\r\n\r\nLogin do Usuário:thynara.teixeira\r\nSenha Inicial :sabara@2026','','V',23,'2026-03-23','11:00:00','2026-03-23','10:31:00'),(31,7,27,NULL,NULL,8,'2026-03-23','12:37:00','C','P',_binary 'Formatar 4 computadores, para serem usados na Policia.\r\n\r\nCONCLUSÃO :\r\n\r\nComputadores finalizados: PAT 119021,118747,118763. Fiz a formatação e upgrade de memória e SSD. ','','V',24,'2026-03-26','12:37:00','2026-03-25','07:54:00'),(32,5,16,NULL,NULL,67,'2026-03-23','15:31:00','C','P',_binary 'Login do Usuário :rafaelheleno\r\nNovos locais de tramitação:RH da SEMUSA\r\nExcluir locais anteriores (sim/Não) :Sim\r\n\r\nCONCLUSÃO :\r\n\r\nAlterado local de tramitação para Secretaria municipal de Saúde','','V',25,'2026-03-23','16:19:00','2026-03-23','15:49:00'),(33,28,16,NULL,NULL,38,'2026-03-23','16:33:00','C','P',_binary 'SELB da Impressora :TFC8\r\nEquipamento com problemas mecânicos. Barulho ao imprimir e embolando papel.\r\nChamado solicitado pelo técnico da secretaria de Educação\r\n\r\nCONCLUSÃO :\r\n\r\nFoi feito trocar da pelicula da fusao. Equipamento funcional','','V',26,'2026-03-26','16:33:00','2026-03-24','16:50:00'),(34,6,28,NULL,NULL,24,'2026-03-24','08:36:00','C','P',_binary 'Configurar computador para funcionária Thaynara no setor de Protocolo\r\n\r\nCONCLUSÃO :\r\n\r\nFoi necessário resetar a senha de administrador local, através de um pendrive, para então recolocar o computador no domínio e assim incluir a nova funcionária ao acesso. Foi configurado também a impressora, finalizado os testes e devolvido ao setor.','','V',27,'2026-03-25','08:36:00','2026-03-24','08:37:00'),(35,29,28,NULL,NULL,36,'2026-03-24','10:52:00','C','P',_binary 'Instalação impressora do RH para usuário Douglas\r\n\r\nCONCLUSÃO :\r\n\r\ninstalação concluída com sucesso','','V',29,'2026-03-24','11:57:00','2026-03-24','11:02:00'),(36,7,16,NULL,NULL,54,'2026-03-24','11:20:00','C','P',_binary 'Nome do usuário :phillipe.amparo\r\nPastas de acesso na rede :planejamento\r\n\r\nCONCLUSÃO :\r\n\r\nLogin do Usuário:phillipe.amparo\r\nSenha Inicial :sabara@2026','','V',30,'2026-03-24','12:20:00','2026-03-24','11:25:00'),(37,25,16,NULL,NULL,62,'2026-03-24','11:34:00','C','P',_binary 'Nome do Usuário:patricia Marta Gomes\r\nCPF:não informado\r\nLocais de Tramitação :regional fátima\r\n\r\nNome do Usuário:bianca Maxima dos Reis Alves\r\nCPF:\r\nLocais de Tramitação : regional fatima\r\n\r\nCONCLUSÃO :\r\n\r\nLogin do Usuário: marta.gomes\r\nSenha Inicial : 123456\r\n\r\nLogin do Usuário: bianca.maximo\r\nSenha Inicial : 123456','','V',31,'2026-03-24','12:04:00','2026-03-24','16:30:00'),(38,25,16,NULL,NULL,54,'2026-03-24','11:37:00','C','P',_binary 'Nome do usuário :Patricia Marta Gomes\r\nPastas de acesso na rede :Regional fatima\r\n\r\nNome do usuário :Bianca Maxima dos Reis Alves\r\nPastas de acesso na rede :regional fatima\r\n\r\nCONCLUSÃO :\r\n\r\nLogin do Usuário: marta.gomes\r\nSenha Inicial : sabara@2026\r\n\r\nLogin do Usuário: bianca.maximo\r\nSenha Inicial : sabara@2026\r\n','','V',32,'2026-03-24','12:37:00','2026-03-24','16:29:00'),(39,6,29,NULL,NULL,19,'2026-03-24','11:48:00','C','P',_binary 'Patrimônio do Computador : NA\r\nUsuário: Adriana (Junta do Serviço Militar)\r\n\r\nVerificar programas que estão causando lentidao...\r\n\r\nCONCLUSÃO :\r\n\r\nComputador precisa de peças, Hd ou Placa mãe, estao com defeito','','V',33,'2026-03-25','11:48:00','2026-03-26','15:21:00'),(40,9,16,NULL,NULL,69,'2026-03-24','12:00:00','C','P',_binary 'Acompamento de vistoria técnica para manutenção de no-break\r\n\r\nCONCLUSÃO :\r\n\r\nVisita técnica realizada junto a empresa sk no-break realizada com sucesso','','V',34,'2026-03-24','10:30:00','2026-03-24','12:02:00'),(41,9,16,NULL,NULL,55,'2026-03-24','14:25:00','C','P',_binary 'Nome do usuário :tatiana matias\r\nLogin do usuário :tatiana.matias\r\n\r\nCONCLUSÃO :\r\n\r\nNova senha do usuário :sabara@2026','','V',35,'2026-03-24','15:25:00','2026-03-24','14:26:00'),(42,10,16,NULL,NULL,28,'2026-03-24','16:13:00','C','P',_binary 'Possui Licença(sim/não) ? não software livre\r\nDescrição do software a ser instalado:Adobe reader\r\nInstalação na advocacia Municipal \r\n\r\n\r\n\r\nCONCLUSÃO :\r\n\r\nAdobe Instalado com sucesso','','V',36,'2026-03-24','18:18:00','2026-03-25','10:35:00'),(43,9,27,NULL,NULL,8,'2026-03-25','08:19:00','C','P',_binary 'Usuário : Sabrina\r\nPatrimonio: 119289\r\n\r\nDescrição do problema: Formatar computador, Windows n acessa.\r\n\r\nCONCLUSÃO :\r\n\r\nSolicitação concluída, notebook foi formatado.','','V',37,'2026-03-28','08:20:00','2026-03-25','10:30:00'),(44,5,16,NULL,NULL,54,'2026-03-25','08:53:00','C','P',_binary 'Nome do usuário :yasmin Carvalho - rede da saúde\r\nPastas de acesso na rede : saFarmacia\r\n\r\nCONCLUSÃO :\r\n\r\nLogin do Usuário:yasmin.carvalho\r\nSenha Inicial :sabara@2022','','V',38,'2026-03-25','09:53:00','2026-03-25','08:53:00'),(45,5,16,NULL,NULL,62,'2026-03-25','10:41:00','C','P',_binary 'Nome do Usuário:Michelle Pamela Gonçalves da Costa Lisboa\r\nCPF:\r\nLocais de Tramitação : Secretaria de saude\r\n\r\nCONCLUSÃO :\r\n\r\nLogin do Usuário : michelle.lisboa\r\nSenha de Acesso :123456','','V',39,'2026-03-25','11:12:00','2026-03-25','10:48:00'),(46,11,30,NULL,NULL,23,'2026-03-25','10:43:00','C','P',_binary 'Patrimonio: 105553\r\nPc Dell Optiplex3000, TAG BM2G6R3; restauração do Sistema Operacional (13 horas); instalação de programas; adicionar ao domínio; instalação de impressora; \r\n\r\n\r\nCONCLUSÃO :\r\n\r\nSistema reinstalado, add domínio...','','V',41,'2026-03-26','13:45:00','2026-03-25','16:07:00'),(47,7,30,NULL,NULL,59,'2026-03-25','10:58:00','C','P',_binary 'Montagem de dois pontos de atendimento para resolver pendências e esclarecer dúvidas relacionadas a IPTU, Cadastro Imobiliário e Geoprocessamento, na região central de Ravena e no povoado de Traíras.\r\n\r\nCONCLUSÃO :\r\n\r\nServiço referente a acompanhamento realizado no dia 17 ao dia 21 de março. ','','V',40,'2026-03-25','17:00:00','2026-03-25','11:39:00'),(48,14,29,NULL,NULL,43,'2026-03-25','11:54:00','C','P',_binary 'local : Secretaria de Esportes (Siderúrgica  - Sala do Viva Mais)\r\n\r\nCONCLUSÃO :\r\n\r\nDesligaram o ponto do switch. Problema resolvido.','','V',42,'2026-03-25','15:03:00','2026-03-25','12:46:00'),(49,6,30,NULL,NULL,19,'2026-03-25','15:08:00','C','P',_binary 'Verificar o pc da JUNTA MILITAR.\r\n\r\nPatrimõnio do Computador :\r\nUsuário:\r\n\r\nCONCLUSÃO :\r\n\r\nFeita limpeza de cache, bloqueio de sites (para evitar adwares), exclusão dos arquivos temporários (usuários - APPDATA- e dos navegadores).','','V',43,'2026-03-27','15:09:00','2026-03-26','16:31:00'),(50,6,30,NULL,NULL,23,'2026-03-25','15:17:00','C','P',_binary 'Patrimonio:119019\r\n\r\nReinstalação de Sistema Operacional, para uso no RH.\r\n\r\n\r\nCONCLUSÃO :\r\n\r\nReinstalação do Sistema Operacional, instalação dos \"programas padrão\", instalação de impressora, adicionar ao domínio, atualizações necessárias de drives.','','V',44,'2026-03-26','17:00:00','2026-03-25','17:05:00'),(51,6,30,NULL,NULL,69,'2026-03-25','15:30:00','C','P',_binary 'suporte técnico na redefinição de senha e recuperação de acesso aos e-mails do setor de Segurança do Trabalho\r\n\r\nCONCLUSÃO :\r\n\r\nfinalização do suporte e à disposição para eventuais questionamentos e suporte','','V',45,'2026-03-25','11:32:00','2026-03-25','15:58:00'),(52,6,30,NULL,NULL,69,'2026-03-25','16:55:00','C','P',_binary 'Verificar acesso a documentos compartilhados (Drive)\r\n\r\nCONCLUSÃO :\r\n\r\nAtualização dos drives do pc. ','','V',46,'2026-03-26','11:00:00','2026-03-26','09:15:00'),(53,32,16,NULL,NULL,56,'2026-03-26','09:08:00','C','P',_binary 'Login do usuário :\r\n\r\nCamila.felix\r\nRodrigo.grilo\r\nRafael.heleno\r\nPriscila.barbosa\r\nRebeca.sophia\r\nRaiara.raissa\r\nBarbara.silva\r\nLucas.victor\r\n\r\nNovas pastas de acesso na rede : Retirar acesso da pasta cpad\r\n\r\nCONCLUSÃO :\r\n\r\nTodos os usuários tiveram os seus acessos removidos da pasta cpad','','V',48,'2026-03-26','10:57:00','2026-03-26','10:02:00'),(54,13,16,NULL,NULL,16,'2026-03-26','09:12:00','C','P',_binary 'Qual o login do usuário? : letícia.corradi \r\n\r\nCONCLUSÃO :\r\n\r\nNova senha redefinida :sabara@2026\r\napenas primeiro acesso. nenhuma sena de móduo foi redefinida','','V',47,'2026-03-26','10:20:00','2026-03-26','10:51:00'),(55,19,16,NULL,NULL,38,'2026-03-26','10:41:00','C','P',_binary 'SELB da Impressora :deu5\r\nTravada na tela de status\r\n\r\nCONCLUSÃO :\r\n\r\nResolvido sem necessidade de visita fisica. Foi retirado e recolocado o toner para resolução do problema','','V',49,'2026-03-29','10:42:00','2026-03-26','13:58:00'),(56,30,16,NULL,NULL,10,'2026-03-26','11:50:00','C','P',_binary 'Descrição do e-mail (ex. <descricao>@sabara.mg.gov.br:vigilanciapatrimonial@sabara.mg.gov.br\r\nResponsável :segurança publica\r\n\r\nCONCLUSÃO :\r\n\r\nDescrição do e-mail:vigilanciapatrimonial@sabara.mg.gov.br\r\nSenha iniciao :sabara@2026','','V',50,'2026-03-26','13:51:00','2026-03-26','14:41:00'),(57,12,16,NULL,NULL,54,'2026-03-26','11:54:00','C','P',_binary 'Nome do usuário :Raylane vitória de Souza Fernandes\r\nPastas de acesso na rede :turismo\r\n\r\nCONCLUSÃO :\r\n\r\nUsuário raylane.vitoria\r\nSenha sabara@2026','','V',51,'2026-03-26','12:55:00','2026-03-26','14:24:00'),(58,28,16,NULL,NULL,16,'2026-03-26','11:58:00','C','P',_binary 'Qual o login do usuário? :Ana Karla de Deus \r\n\r\nCONCLUSÃO :\r\n\r\nNova senha redefinida :sabara@2026','','V',52,'2026-03-26','12:29:00','2026-03-26','14:17:00'),(59,7,16,NULL,NULL,48,'2026-03-26','12:03:00','X','P',_binary 'Local: Procon de Sabará\r\nNúmero de pontos:2 pontos para ligar 2 computadores','','V',132,'2026-04-29','17:02:00',NULL,NULL),(60,7,30,NULL,NULL,25,'2026-03-26','16:29:00','C','P',_binary 'Patrimônio :\r\nchecou cabos de energia (sim/não)? \r\n\r\nAdicionar monitor extra ao pc. Falta cabo hdmi ou displayport.\r\nLocal: SINE\r\n\r\nCONCLUSÃO :\r\n\r\nprocedimento realizado','','V',79,'2026-04-08','13:10:00','2026-04-09','08:19:00'),(61,30,30,NULL,NULL,28,'2026-03-26','21:59:00','X','P',_binary 'Possui Licença(sim/não) ?\r\nDescrição do software a ser instalado: software para gerenciamento de multas','','V',92,'2026-04-14','11:04:00',NULL,NULL),(62,8,29,NULL,NULL,73,'2026-03-27','09:11:00','X','P',_binary 'Secretaria/Gerencia: Gabinete Secretaria da Fazenda\r\nUsuário: Maria Eduarda (Duda)\r\nNúmero:\r\n\r\nAuxiliar na instalação e configuração do Authenticator','','V',53,'2026-03-27','09:11:00',NULL,NULL),(63,29,26,NULL,NULL,21,'2026-03-27','10:30:00','C','P',_binary 'Patrimônio : 093015 Equipamento apresentado tela azul\r\n\r\n\r\nCONCLUSÃO :\r\n\r\nFeita a troca do HD; restaurado Sistema Operacional; instalado \"programas padrão\"; adicionado ao domínio PMS.','','V',54,'2026-03-29','10:31:00','2026-04-06','13:09:00'),(64,33,28,NULL,NULL,41,'2026-03-27','14:32:00','C','P',_binary 'Se for impressora colorida qual a cor to toner ?: magenta\r\n\r\n\r\nCONCLUSÃO :\r\n\r\ninstalação concluída, testes ok','','V',55,'2026-03-27','15:32:00','2026-03-27','14:33:00'),(65,6,30,NULL,NULL,69,'2026-03-30','08:22:00','C','P',_binary 'Acesso ao email do Recursos Humanos (Paulo)\r\n\r\nCONCLUSÃO :\r\n\r\nCódigos de acesso enviados para celular corporativo','','V',56,'2026-03-30','08:23:00','2026-03-30','08:24:00'),(66,25,16,NULL,NULL,70,'2026-03-30','10:17:00','C','P',_binary 'Verificar pontos de rede e verificar se máquinas estão no domínio\r\n\r\nCONCLUSÃO :\r\n\r\nConclusão : Computadores colocados no domínio. Regional precisa comprar um Hub/Switch de 8 portas, para adicionar mais computadores.','','V',61,'2026-04-06','17:00:00','2026-04-09','13:08:00'),(67,7,29,NULL,NULL,60,'2026-03-30','11:04:00','X','P',_binary 'Local : Instalar na Sala de Reunião\r\nResponsável: Carlos Eduardo\r\n\r\nObs.: instalar Projetor e Notebook na Sala de Reunião às 13:30 do dia 31/03/2026.\r\n(Notebook verificar com o Carlos Eduardo, provavelmente o que está emprestado com a Mariana)','','V',57,'2026-03-31','13:50:00',NULL,NULL),(68,32,28,NULL,NULL,24,'2026-03-30','16:27:00','C','P',_binary 'Usuário Rafaela relata que ao tentar acessar o pc com seu usuário sempre aparece: \"usuário ou senha inválida\". E quando loga em pc Windows, o mesmo está ok.\r\n\r\nCONCLUSÃO :\r\n\r\nFoi retirado do domínio Linux e reincluído. Realizado os testes, ok.','','V',58,'2026-03-31','15:30:00','2026-03-30','16:28:00'),(69,7,16,NULL,NULL,24,'2026-03-31','09:47:00','C','P',_binary 'Patrimônio :\r\nAdicionar pc da saúde na rede pms\r\n\r\nUsuário renata.araújo\r\n\r\nCONCLUSÃO :\r\n\r\nPC adicionado ao domínio; impressora configurada; configurado os acessos às pastas de rede e scanner; documentos/arquivos copiados; testes feitos.','','V',59,'2026-03-31','09:30:00','2026-03-31','10:05:00'),(70,29,28,NULL,NULL,70,'2026-03-31','16:57:00','C','P',_binary 'Computador trava na tela de inicialização\r\n\r\nCONCLUSÃO :\r\n\r\nConclusão : Foi trocada placa mãe e processador pela empresa Dell. Após foi feita reinstalação do windows, reinstalação dos programas, reinstalação office, instalação da rede, impressoras, testes com usuário, ok','','V',60,'2026-03-31','16:57:00','2026-03-31','16:59:00'),(71,9,16,NULL,NULL,43,'2026-04-06','09:31:00','C','P',_binary 'local :Secretaria Municipal de Obras\r\nSolicitante : Sabrina\r\n\r\nCONCLUSÃO :\r\n\r\nProblema resolvido, endereço IP estava em conflito.','','V',62,'2026-04-06','12:38:00','2026-04-08','13:10:00'),(72,30,30,NULL,NULL,43,'2026-04-06','09:41:00','C','P',_binary 'local : Gerência de Trânsito. Interrupção dos serviços de internet. <JUNIOR>\r\n\r\nCONCLUSÃO :\r\n\r\nCabos arrebentados; abertura de chamado para a empresa prestadora do serviço.','','V',64,'2026-04-06','16:23:00','2026-04-06','13:24:00'),(73,30,30,8,NULL,8,'2026-04-06','13:17:00','C','P',_binary 'Usuário : Alessandra\r\nPatrimonio: 119245\r\n\r\nDescrição do problema: Pc sem Sistema Operacional; instalação do Sistema LinuxMint\r\n\r\nCONCLUSÃO :\r\n\r\nObservações: Computador funcional enviado para a secretaria','','R',63,'2026-04-06','13:18:00','2026-04-08','09:53:00'),(74,5,16,NULL,NULL,15,'2026-04-06','15:28:00','C','P',_binary 'Nome do usuário :thiago.santos\r\nModulos que irá acessar (compras, estoque, contabilidade, pregão, credores, frotas, prestação de contas, patrimônio :\r\n\r\nSistema de contabilidade e compras\r\n\r\n\r\n\r\nCONCLUSÃO :\r\n\r\nUsuário de Acesso :thiago.santos\r\nSenha de Acesso : já tinha senha \r\n\r\nUsuário do(s) módulo(s) : thiago.santos\r\nSenha do(s) módulo(s) : sabara@2026','','V',65,'2026-04-06','17:28:00','2026-04-06','15:28:00'),(75,7,28,NULL,NULL,70,'2026-04-06','16:42:00','C','P',_binary 'Aparecendo vários pop-ups no navegador google Chrome com informação de \"vírus\"\r\n\r\nCONCLUSÃO :\r\n\r\nConclusão : Foi realizada varredura de vírus no computador, desinstalado o Google Chrome e reinstalado. Foi testado pelo usuário e normalizado.','','V',66,'2026-04-06','14:42:00','2026-04-06','16:43:00'),(76,28,30,NULL,NULL,43,'2026-04-07','09:54:00','C','P',_binary 'local : Escola Municipal Ordália\r\n\r\n\r\nCONCLUSÃO :\r\n\r\nRompimento de fibra soliciionado','','V',67,'2026-04-07','12:54:00','2026-04-07','11:52:00'),(77,9,30,NULL,NULL,43,'2026-04-07','10:09:00','X','P',_binary 'local :...','','V',69,'2026-04-07','14:01:00',NULL,NULL),(78,5,16,NULL,NULL,15,'2026-04-07','10:29:00','C','P',_binary 'Nome do usuário :Fabio Jesuita Magalhaes\r\nCPF:871.705.826-00\r\nModulos que irá acessar (compras, estoque, contabilidade, pregão, credores, frotas, prestação de contas, patrimônio :\r\n\r\n\r\n\r\nCONCLUSÃO :\r\n\r\nUsuário de Acesso :fabio.magalhaes\r\nSenha de Acesso :sabara@2026\r\n\r\nUsuário do(s) módulo(s) : fabio.magalhaes\r\nSenha do(s) módulo(s) :sabara@2026','','V',68,'2026-04-07','12:32:00','2026-04-07','10:55:00'),(79,8,30,NULL,NULL,23,'2026-04-07','16:15:00','C','P',_binary 'Patrimonio:\r\nLocal: sala de GeoProcessamento; mudar o computador de lugar na mesma sala.\r\n\r\n\r\nCONCLUSÃO :\r\n\r\nmudança efetivada; reorganização de cabos; ','','V',70,'2026-04-07','13:15:00','2026-04-07','16:16:00'),(80,6,28,NULL,NULL,36,'2026-04-08','08:33:00','C','P',_binary 'Instalação impressora do RH para funcionária Bruna do setor de Serviços Gerais\r\n\r\nCONCLUSÃO :\r\n\r\nInstalação concluída com sucesso. Testes ok','','V',71,'2026-04-07','10:33:00','2026-04-08','08:45:00'),(81,5,16,NULL,NULL,15,'2026-04-08','09:29:00','C','P',_binary 'Nome do usuário :Thiago Fernando Martins Ramos de Carvalho\r\nnúmero do CPF : não informado\r\nModulos que irá acessar (compras, estoque, contabilidade, pregão, credores, frotas, prestação de contas, patrimônio : Estoque\r\n\r\n\r\n\r\nCONCLUSÃO :\r\n\r\nUsuário de Acesso :Já possui acesso\r\nSenha de Acesso :já possui acess\r\n\r\nUsuário do(s) módulo(s) :thiago.ramos\r\nSenha do(s) módulo(s) :sabara@2026','','V',74,'2026-04-08','11:33:00','2026-04-08','11:13:00'),(82,11,16,NULL,NULL,54,'2026-04-08','09:31:00','C','P',_binary 'Nome do usuário :Pedro Henrique Faleiro de Souza Pieri\r\nPastas de acesso na rede :Meio ambiente\r\n\r\nCONCLUSÃO :\r\n\r\nLogin do Usuário:pedro.pieri\r\nSenha Inicial :sabara@2026','','V',73,'2026-04-08','10:32:00','2026-04-08','09:38:00'),(83,11,16,NULL,NULL,62,'2026-04-08','09:32:00','C','P',_binary 'Nome do Usuário:Pedro Henrique Faleiro de Souza Pieri\r\nCPF:021.663.596-98\r\nLocais de Tramitação :Meio Ambiente\r\n\r\nCONCLUSÃO :\r\n\r\nLogin do Usuário :pedro.pieri\r\nSenha de Acesso :123456','','V',72,'2026-04-08','10:02:00','2026-04-08','09:42:00'),(84,8,16,NULL,NULL,54,'2026-04-08','11:20:00','C','P',_binary 'Nome do usuário :Adrian Karster Souza Silva\r\nPastas de acesso na rede :fazenda e fiscalização\r\n\r\nCONCLUSÃO :\r\n\r\nLogin do Usuário:adrian.kaster\r\nSenha Inicial :sabara@2026','','V',75,'2026-04-08','12:20:00','2026-04-08','11:20:00'),(85,12,16,11,NULL,70,'2026-04-08','15:38:00','C','P',_binary 'Computador com tarvamento e lentidão',_binary 'Conclusão :\r\nAtualização de Bios e drivers\r\nOtimização de desempenho\r\nOtimização de unidades(c:)\r\nExclusão de arquivos temporários ','R',76,'2026-04-13','15:38:00','2026-04-15','14:07:00'),(86,12,16,12,NULL,70,'2026-04-08','15:41:00','C','P',_binary 'Computador com travamento e Lentidão',_binary 'Conclusão :\r\nAtualização de Bios e drivers\r\nOtimização de desempenho\r\nOtimização de unidades(c:)\r\nExclusão de arquivos temporários ','R',77,'2026-04-13','15:41:00','2026-04-15','13:53:00'),(87,8,30,13,NULL,23,'2026-04-09','08:39:00','C','P',_binary 'Patrimonio: 119311\r\nConfiguração do Sistema Operacional; instalação de \"programas padrão\"; adicionar ao domínio; configurar impressora; \r\n',_binary 'Procedimentos feitos.','R',80,'2026-04-09','10:39:00','2026-04-10','15:03:00'),(88,8,16,NULL,NULL,54,'2026-04-09','09:06:00','C','P',_binary 'Nome do usuário : Kátia Vilela Rocha\r\nPastas de acesso na rede : Contabilidade\r\n\r\nCONCLUSÃO :\r\n\r\nLogin do Usuário:katia.rocha\r\nSenha Inicial :sabara@2026','','V',81,'2026-04-09','10:06:00','2026-04-09','09:38:00'),(89,8,16,NULL,NULL,15,'2026-04-09','09:08:00','C','P',_binary 'Nome do usuário :Kátia Vilela Rocha\r\nnúmero do CPF : 01505073642\r\nModulos que irá acessar (compras, estoque, contabilidade, pregão, credores, frotas, prestação de contas, patrimônio :Contabilidade\r\n\r\n\r\n\r\nCONCLUSÃO :\r\n\r\nUsuário de Acesso :katia.rocha\r\nSenha de Acesso :sabara@2026\r\n\r\nUsuário do(s) módulo(s) :katia.rocha\r\nSenha do(s) módulo(s) :sabara@2026','','V',82,'2026-04-09','10:00:00','2026-04-09','09:36:00'),(90,5,16,NULL,NULL,15,'2026-04-09','12:04:00','C','P',_binary 'Nome do usuário :Vinicius Silva Bento\r\nnúmero do CPF : 12307802622\r\nModulos que irá acessar (compras, estoque, contabilidade, pregão, credores, frotas, prestação de contas, patrimônio :Estoque\r\n\r\n\r\n\r\nCONCLUSÃO :\r\n\r\nUsuário vinicius.bento já tinha acesso ao módulo de estoque pedido. foi redefinido senha para sabara@2026','','V',83,'2026-04-09','16:00:00','2026-04-09','14:00:00'),(91,5,16,NULL,NULL,15,'2026-04-09','15:19:00','C','P',_binary 'Nome: Remisson Soares Pereira\r\nCPF: 425.457.496-72\r\nCONTABILIDADE e ESTOQUE\r\n\r\n\r\n\r\nCONCLUSÃO :\r\n\r\nUsuário remisson.pereira  senha inicial sabara@2026\r\n\r\nsomente contabilidade e estoque','','V',84,'2026-04-09','17:19:00','2026-04-09','16:14:00'),(92,32,30,14,NULL,28,'2026-04-10','08:17:00','C','P',_binary 'Possui Licença(sim/não) ? sim (NMCRM-6TJ77-CW7FQ-6JVDG-FVYFX)\r\nDescrição do software a ser instalado: Microsoft Office 2021\r\n\r\nCONCLUSÃO :\r\n\r\nSoftware instalado e ativado','','R',85,'2026-04-13','12:00:00','2026-04-10','08:31:00'),(93,7,30,15,NULL,36,'2026-04-10','09:19:00','C','P',_binary 'SELB da Impressora : TFC9\r\n\r\nCONCLUSÃO :\r\n\r\nDriver de Impressora instalado e configurado.','','R',86,'2026-04-10','11:20:00','2026-04-10','09:21:00'),(94,7,30,15,NULL,74,'2026-04-10','09:41:00','C','P',_binary 'Instalação do GoGlobal e atalho do SUPERNOVA-MODERNA no pc.\r\n\r\nCONCLUSÃO :\r\n\r\nInstalação feita','','R',87,'2026-04-10','10:42:00','2026-04-10','09:43:00'),(95,6,30,16,NULL,74,'2026-04-10','11:18:00','C','P',_binary 'Login setor de Licitação',_binary 'Instalação feita','R',88,'2026-04-10','11:30:00','2026-04-10','11:20:00'),(96,28,16,NULL,NULL,54,'2026-04-10','11:37:00','C','P',_binary 'Solicito, por gentileza, crianção de login e senha de acesso (pasta P) para Servidora Adriana Lúcia da Silva, assistente administrativo na Educação (Setor de Alimentação Escolar).',_binary 'Login do Usuário:adriana.lucia\r\nSenha Inicial :sabara@2026','V',89,'2026-04-10','12:37:00','2026-04-10','11:40:00'),(97,11,16,NULL,NULL,62,'2026-04-10','15:25:00','C','P',_binary 'Nome do Usuário:Ana Beatriz Cardoso Vasconcelos dos Santos\r\nCPF:159.938.916-96\r\nLocais de Tramitação :Meio Ambiente',_binary 'Login do Usuário :ana.vasconcelos\r\nSenha de Acesso :123456','V',90,'2026-04-10','16:48:00','2026-04-10','16:21:00'),(98,6,16,NULL,NULL,15,'2026-04-13','09:03:00','C','P',_binary 'Nome do usuário :Glênia Paula Pinto \r\nnúmero do CPF :08025421658\r\nModulos que irá acessar (compras, estoque, contabilidade, pregão, credores, frotas, prestação de contas, patrimônio :\r\n\r\nCompras\r\nEstoque\r\nContabilidade\r\nPatrimônio\r\nProtocolo\r\n\r\n',_binary 'Usuário de Acesso :glenia.pinto\r\nSenha de Acesso :sabara@2026\r\n\r\nUsuário do(s) módulo(s) :glenia.pinto\r\nSenha do(s) módulo(s) :sabara@2026','V',91,'2026-04-13','11:12:00','2026-04-13','10:13:00'),(99,9,30,NULL,NULL,43,'2026-04-14','09:07:00','C','P',_binary 'local : SEMOB - Projetos, pc usado pela Gabrielle Galdino',_binary 'Problema solucionado','V',93,'2026-04-14','12:07:00','2026-05-07','12:12:00'),(100,11,16,NULL,NULL,68,'2026-04-14','09:19:00','C','P',_binary 'Local:Meio Ambiente\r\nNúmero de pontos :1 ponto cabo com problema',_binary 'Habilitado novo ponto na sala do Secretário de Meio Ambiente','V',105,'2026-04-22','10:07:00','2026-05-07','17:24:00'),(101,7,30,NULL,NULL,59,'2026-04-14','09:25:00','C','P',_binary 'Descrição do Serviço:Acompanhar Laila (Secretaria de Governo) em visita a alguns prédios públicos, junto com a equipe de totens.',_binary 'Efetuado o acompanhamento. Problemas observados foram repassados para Flávio Maielo.','V',97,'2026-04-17','16:41:00','2026-04-22','16:33:00'),(102,14,30,NULL,NULL,23,'2026-04-14','09:29:00','C','P',_binary 'Solicita a instalação e configuração de 2 pcs, na sala de reunião da Administração e configuração de impressoras, para apoio ao JEMG.\r\n',_binary 'Os pcs continuarão, por tempo indefinido, no local.','V',94,'2026-04-17','17:00:00','2026-04-22','10:55:00'),(103,8,30,NULL,NULL,43,'2026-04-14','11:03:00','C','P',_binary 'local : SECRETARIA DE FAZENDA ESTADUAL: -Colocar o cabeamento de internet; -conectar impressora.',_binary 'Montagem de 01 pc; reconfiguração de IP da impressora RVH1; configuração da porta de impressão nos 03 pc da Secretaria de Fazenda Estadual.','V',96,'2026-04-14','16:10:00','2026-04-14','16:37:00'),(104,34,30,NULL,NULL,46,'2026-04-14','11:14:00','X','P',_binary 'Local : PROCON\r\nNúmero de pontos: 02\r\n\r\nSolicita vista técnica a sede do PROCON (Rua: Dom Pedro II, N° 72, Centro), para que seja instalado cabo de internet em dois computadores recentemente adquiridos pelo órgão; será preciso estender o cabo de internet dos telefones.  \r\n\r\nLarissa Vieira - Tecnica de atendimento',NULL,'V',104,'2026-04-18','09:33:00',NULL,NULL),(105,14,30,NULL,NULL,69,'2026-04-14','11:24:00','C','P',_binary 'Acompanhar pessoal da SpeedNet no Campo da Liga',_binary 'Link ativo no local','V',95,'2026-04-14','11:24:00','2026-04-16','09:29:00'),(106,31,16,NULL,NULL,10,'2026-04-15','15:13:00','C','P',_binary 'Descrição do e-mail (ex. <descricao>@sabara.mg.gov.br:relatorios@sabara.mg.gov.br\r\nResponsável :Itelvina',_binary 'Descrição do e-mail:relatorios@sabara.mg.gov.br\r\nSenha iniciao :sabara@2026','V',98,'2026-04-15','16:00:00','2026-04-15','15:14:00'),(107,7,16,NULL,NULL,54,'2026-04-15','15:16:00','C','P',_binary 'Nome do usuário : Mirelly Guimarães Pereira\r\nPastas de acesso na rede :planejamento',_binary 'Login do Usuário: mirelly.pereira\r\nSenha Inicial :sabara@2026','V',99,'2026-04-15','16:18:00','2026-04-15','15:18:00'),(108,7,30,NULL,NULL,60,'2026-04-15','17:35:00','C','P',_binary 'Local : sala de reuniões do Gabinete\r\nResponsável: Cassirlene Vieira\r\n\r\nE solicitar suporte técnico para conexão via notebook, para acesso e participação em reunião virtual do Conselho Municipal de Habitação de Interesse Social - CMHIS e do Grupo Institucional do Poder Público - GIPP.',_binary 'Montagem realizada; testes realizados; reunião iniciou-se às 14h.','V',100,'2026-04-15','17:00:00','2026-04-15','17:37:00'),(109,31,28,NULL,NULL,41,'2026-04-16','08:37:00','C','P',_binary 'Se for impressora colorida qual a cor to toner ?: Azul e Amarelo\r\n',_binary 'Realizada troca dos tonners, testes ok','V',101,'2026-04-16','09:37:00','2026-04-16','08:38:00'),(110,8,28,NULL,NULL,23,'2026-04-16','08:39:00','C','P',_binary 'Instalação de módulo da Caixa\r\n',_binary 'Módulo da Caixa não funcionou no navegador google Chrome, instalado no navegador Firefox. Testes ok','V',102,'2026-04-16','10:39:00','2026-04-16','08:40:00'),(111,28,16,NULL,NULL,15,'2026-04-16','09:10:00','C','P',_binary 'Nome do usuário :Adriana Lúcia da Silva\r\nnúmero do CPF :068.132.296-99\r\nModulos que irá acessar (compras, estoque, contabilidade, pregão, credores, frotas, prestação de contas, patrimônio :\r\n\r\n',_binary 'Usuário de Acesso :adriana.lucia\r\nSenha de Acesso : sabara@2026\r\n\r\nUsuário do(s) módulo(s) : adriana.lucia\r\nSenha do(s) módulo(s) : sabara@2026','V',103,'2026-04-16','11:10:00','2026-04-16','09:10:00'),(112,30,16,NULL,NULL,51,'2026-04-16','10:56:00','C','P',_binary 'Local :Prédio da Secretaria de Segurança pública\r\n\r\nSinal da Operadora  ok mas não replica para o pontos de acesso. Verificar problemas internos nos equipamentos',_binary 'Problema elétrico resolvido pelo setor de obras.','V',106,'2026-04-16','17:00:00','2026-05-07','12:08:00'),(113,30,16,NULL,NULL,10,'2026-04-16','11:48:00','C','P',_binary 'Descrição do e-mail (ex. <descricao>@sabara.mg.gov.br:\r\n\r\ncomunicacaogcmsabara@sabara.mg.gov.br\r\nplanejamentooperacionalgcmsabara@sabara.mg.gov.br\r\nfiscalizacaodeobras@sabara.mg.gov.br\r\nsecaotilogisticaepessoalgcm@sabara.mg.gov.br\r\ncorregedoriagcm@sabara.mg.gov.br\r\n\r\nResponsável :Glisia',_binary 'Descrição do e-mail:\r\n\r\ncomunicacaogcmsabara@sabara.mg.gov.br\r\nplanejamentooperacionalgcmsabara@sabara.mg.gov.br\r\nfiscalizacaodeobras@sabara.mg.gov.br\r\nsecaotilogisticaepessoalgcm@sabara.mg.gov.br\r\ncorregedoriagcm@sabara.mg.gov.br\r\nSenha inicial : sabara@2026','V',107,'2026-04-16','13:49:00','2026-04-16','11:49:00'),(114,30,16,NULL,NULL,63,'2026-04-16','11:51:00','E','P',_binary 'Local:Patrulha Guardiã da Mulher\r\nReferência:próximo a guarda Municipal\r\nContato:Glisia',NULL,'V',167,'2026-05-14','09:32:00',NULL,NULL),(115,11,16,NULL,NULL,54,'2026-04-17','15:26:00','C','P',_binary 'Nome do usuário : Lucas Matos dos Santos Lima\r\nPastas de acesso na rede :Meio Ambiente',_binary 'Login do Usuário:lucas.lima\r\nSenha Inicial :sabara@2026','V',108,'2026-04-17','16:26:00','2026-04-17','15:26:00'),(116,11,16,NULL,NULL,62,'2026-04-17','15:28:00','C','P',_binary 'Nome do Usuário: Lucas Matos dos Santos Lima\r\nCPF: não informado\r\nLocais de Tramitação :Meio Ambiente',_binary 'Login do Usuário :lucas.lima\r\nSenha de Acesso :123456','V',109,'2026-04-17','15:58:00','2026-04-17','15:28:00'),(117,7,16,NULL,NULL,43,'2026-04-22','11:12:00','C','P',_binary 'local :Computador da Maria Clara do planejamento sem internet',_binary 'Foi alterada a porta no rack central. Testes realizados ok','V',110,'2026-04-22','14:13:00','2026-04-22','11:44:00'),(118,6,16,NULL,NULL,54,'2026-04-22','11:38:00','C','P',_binary 'Nome do usuário :Jean Carlos Macario Roque\r\nPastas de acesso na rede :Administração e transporte',_binary 'Login do Usuário: jean.roque\r\nSenha Inicial : sabara@2026','V',111,'2026-04-22','12:38:00','2026-04-22','11:38:00'),(119,6,16,NULL,NULL,15,'2026-04-22','11:40:00','C','P',_binary 'Nome do usuário :Jean Carlos Macario Roque\r\nnúmero do CPF : 128.409.566-59\r\nModulos que irá acessar (compras, estoque, contabilidade, pregão, credores, frotas, prestação de contas, patrimônio :Compras\r\n\r\n',_binary 'Usuário de Acesso : jean.roque\r\nSenha de Acesso :sabara@2026\r\n\r\nUsuário do(s) módulo(s) :jean.roque\r\nSenha do(s) módulo(s) :sabara@2026','V',112,'2026-04-22','13:41:00','2026-04-22','11:41:00'),(120,6,16,NULL,NULL,62,'2026-04-22','11:44:00','C','P',_binary 'Nome do Usuário: Jean Carlos Macario Roque\r\nCPF:128.409.566-59\r\nLocais de Tramitação :Transporte',_binary 'Login do Usuário :jean.roque\r\nSenha de Acesso :123456','V',113,'2026-04-22','12:14:00','2026-04-22','11:44:00'),(121,11,30,17,NULL,24,'2026-04-23','11:08:00','C','P',_binary 'Patrimônio : 97354\r\n\r\nFalha de confiança (domínio)',_binary 'add ao domínio','R',114,'2026-04-24','11:08:00','2026-04-23','11:18:00'),(122,14,30,NULL,NULL,59,'2026-04-23','11:20:00','C','P',_binary 'Descrição do Serviço: Acompanhamento na mudança de local físico dos desktop',_binary 'Acompanhamento efetuado com sucesso','V',115,'2026-04-23','17:00:00','2026-04-24','09:07:00'),(123,7,30,NULL,NULL,59,'2026-04-23','11:37:00','C','P',_binary 'Descrição do Serviço: Acompanhamento na mudança de local físico dos desktop, setor de Arquitetura',_binary 'Acompanhamento realizado com sucesso','V',116,'2026-04-23','19:37:00','2026-04-24','09:09:00'),(124,8,30,NULL,NULL,59,'2026-04-23','11:39:00','C','P',_binary 'Descrição do Serviço: Acompanhamento na mudança de local físico dos desktop (setor de Fiscalização)',_binary 'Acompamento realizado com sucesso','V',117,'2026-04-23','17:00:00','2026-04-24','09:09:00'),(125,9,30,NULL,NULL,35,'2026-04-23','11:42:00','C','P',_binary 'SELB da impressora: Configuração de scanner, na Regional Centro',_binary 'Serviço realizado com sucesso','V',118,'2026-04-26','11:42:00','2026-04-28','14:46:00'),(126,8,28,NULL,NULL,75,'2026-04-23','14:28:00','C','P',_binary 'Novo monitor para Contabilidade',_binary 'Instalação realizada com sucesso, testes ok','V',119,'2026-04-23','15:29:00','2026-04-23','14:29:00'),(127,9,16,NULL,NULL,76,'2026-04-24','09:15:00','C','P',_binary 'Local a ser utilizado : Secretaria de Obras (Alexandra)\r\nTamanho em Metro : 4 metros ',_binary 'Cabo de Rede Liberado','V',120,'2026-04-24','12:15:00','2026-04-24','15:00:00'),(128,7,16,NULL,NULL,68,'2026-04-24','09:20:00','C','P',_binary 'Local:Ponto da máquina de Maria Clara no planejamento\r\nNúmero de pontos :1',_binary 'Manutenção do ponto de rede realizada com sucesso','V',121,'2026-04-24','11:50:00','2026-04-24','15:02:00'),(129,32,28,NULL,NULL,48,'2026-04-24','15:59:00','C','P',_binary 'Local: Sala do Controlador\r\nNúmero de pontos: 2',_binary 'Foram instalados dois cabos (sendo 1 de reserva) Cat 5e de aproximadamente 5 metros na nova sala do Controlador Geral. Testes ok.','V',122,'2026-04-25','15:59:00','2026-04-24','16:04:00'),(130,11,16,18,NULL,19,'2026-04-27','10:27:00','C','P',_binary 'Patrimõnio do Computador : informado no cadastro\r\nUsuário:Diogo Nunes\r\n\r\nComputador com lentidão necessário formatação',_binary 'Atualizado bios, defrag de Hd e limpesa de arquivos\r\n\r\nMaquina liberada com boa funcionalidade','R',123,'2026-04-30','10:27:00','2026-04-30','16:53:00'),(131,8,16,NULL,NULL,77,'2026-04-27','12:07:00','C','P',_binary 'Local:Contabilidade\r\nUsuário:Maria Goulart',_binary 'Aplicativo instalado com sucesso','V',124,'2026-04-27','14:37:00','2026-04-27','14:07:00'),(132,30,16,19,NULL,70,'2026-04-27','15:58:00','C','P',_binary 'Instalação e Configuração de sistema operacional Linux',_binary 'Conclusão : Sistema Operacional instalado, atualizado e configurado; \"programas padrão\" instalados; adicionado ao domínio PMS; adicionado usuário administrador.','R',125,'2026-04-30','15:58:00','2026-04-28','16:44:00'),(133,7,28,NULL,NULL,36,'2026-04-27','16:17:00','C','P',_binary 'instalação de impressora do RH para setor de fiscalização',_binary 'Impressora instalada para servidora Elem. testes ok!','V',126,'2026-04-27','18:17:00','2026-04-27','16:17:00'),(134,8,16,NULL,NULL,54,'2026-04-27','16:20:00','C','P',_binary 'Nome do usuário : Maria Luiza Ferreira Rodrigues Xavier\r\nPastas de acesso na rede :faCadastro',_binary 'Login do Usuário:maria.xavier\r\nSenha Inicial :sabara@2026','V',127,'2026-04-27','17:20:00','2026-04-27','16:20:00'),(135,28,16,NULL,NULL,15,'2026-04-28','09:53:00','C','P',_binary 'Nome do usuário :Mariana Virginia Tomaz de Macedo\r\nnúmero do CPF : 074.930.506-19\r\nModulos que irá acessar (compras, estoque, contabilidade, pregão, credores, frotas, prestação de contas, patrimônio :Estoque\r\n\r\n',_binary 'Usuário de Acesso :Já possui\r\nSenha de Acesso :Já possui\r\n\r\nUsuário do(s) módulo(s) : mariana.tomaz\r\nSenha do(s) módulo(s) :sabara@2026','V',128,'2026-04-28','11:54:00','2026-04-28','09:54:00'),(137,7,16,NULL,NULL,52,'2026-04-28','11:37:00','C','P',_binary 'Descrição do software :office\r\nPossui licença? (sim/Não) : Sim',_binary 'Reparação feita com sucesso. Atualização  do office 365','V',129,'2026-04-28','13:38:00','2026-04-28','14:45:00'),(138,10,16,NULL,NULL,64,'2026-04-29','09:05:00','E','P',_binary 'Local:Advocacia Municipal\r\nReferência:Setor de Advocacia Municipal\r\nContato:Isabel Bomtempo',NULL,'V',168,'2026-05-14','09:33:00',NULL,NULL),(139,8,16,NULL,NULL,28,'2026-04-29','10:02:00','X','P',_binary 'Possui Licença(sim/não) ? sim\r\nDescrição do software a ser instalado: gerenciador de segurança do Banco do Brasil',NULL,'V',130,'2026-04-29','12:02:00',NULL,NULL),(140,7,16,NULL,NULL,48,'2026-04-29','11:22:00','C','P',_binary 'Local:procon\r\nNúmero de pontos : 3 pontos de rede',_binary '2 novos pontos ativos\r\nImpressora ativa na rede\r\n3 pcs linux configurados\r\npontos reativados no patchpanel','V',131,'2026-04-29','11:23:00','2026-04-30','16:51:00'),(141,31,28,NULL,NULL,43,'2026-04-30','13:50:00','C','P',_binary 'local : Gabinete do Prefeito, Leandro, computador apresenta lentidão para acessar sites',_binary 'Testes de ping estavam ok e realmente paralisou o serviço de internet em vários navegadores, após reinício do computador realizado testes e confirmado pelo usuário que estava ok','V',133,'2026-04-30','16:51:00','2026-04-30','13:51:00'),(142,10,16,NULL,NULL,41,'2026-04-30','14:34:00','C','P',_binary 'CRAS Castanheiras',_binary 'Responsável pelo transporte:Secretária do Cars Castanheira (Patricia)','V',134,'2026-04-30','15:04:00','2026-04-30','14:35:00'),(143,8,30,20,NULL,19,'2026-05-04','15:12:00','C','P',_binary 'Patrimõnio do Computador : 83332\r\nUsuário: luciane.firmo\r\n\r\nPC apresenta lentidão; realizar limpeza; realizar atualização de drivers.',_binary 'Limpezas e atualizações realizadas. \r\n(Considero o computador \"final de meia-vida\").','R',135,'2026-05-06','15:13:00','2026-05-04','16:49:00'),(144,6,16,NULL,NULL,54,'2026-05-05','09:35:00','C','P',_binary 'Nome do usuário :Franklin.hilario\r\nPastas de acesso na rede : administração',_binary 'Login do Usuário:Franklin.hilario\r\nSenha Inicial : Sabara@2026','V',136,'2026-05-05','10:36:00','2026-05-05','09:36:00'),(145,8,16,20,NULL,22,'2026-05-05','10:37:00','C','P',_binary 'Patrimônio :83332\r\n',_binary 'Atualização de drivers; ','R',137,'2026-05-07','10:37:00','2026-05-08','09:34:00'),(146,5,16,NULL,NULL,9,'2026-05-05','11:37:00','C','P',_binary 'Usuário : Ortep\r\nAtividade a ser executada :Computador para sistema da Ortep de relógio de ponto da secretaria de Saúde ',_binary 'Foi disponibilizado Servidor Virtual para instalação do software','V',138,'2026-05-08','11:39:00','2026-05-08','11:35:00'),(147,29,16,NULL,NULL,78,'2026-05-05','14:37:00','X','P',_binary 'Responsável:Ludmila dos Santos Martins\r\nData e hora: 21/05/2026, às 10h00\r\nMotivo:reunião com representantes da Vale e Defesa Civil de Santa Luzia\r\nLocal:Solar Padre correia',NULL,'V',139,'2026-05-22','14:38:00',NULL,NULL),(148,28,16,NULL,NULL,41,'2026-05-05','14:47:00','C','P',_binary 'Se for impressora colorida, qual a cor to toner ?:\r\nSELB da Impressora :Creche',_binary 'Responsável pelo transporte:Motorista da Creche','V',140,'2026-05-05','15:17:00','2026-05-05','14:48:00'),(149,10,16,NULL,NULL,41,'2026-05-05','16:48:00','C','P',_binary 'Se for impressora colorida, qual a cor to toner ?:\r\nSELB da Impressora :Conselho Tutelar',_binary 'Responsável pelo transporte:Conselho Tutelar','V',141,'2026-05-05','17:18:00','2026-05-05','16:49:00'),(150,28,16,NULL,NULL,41,'2026-05-07','08:59:00','C','P',_binary 'Se for impressora colorida, qual a cor to toner ?:\r\nSELB da Impressora :Cei Nancy Borges',_binary 'Responsável pelo transporte:Adriana','V',142,'2026-05-07','09:29:00','2026-05-07','09:00:00'),(151,7,16,NULL,NULL,26,'2026-05-07','11:16:00','C','P',_binary 'Patrimônio :não informa\r\nChecou cabos de energia e dados (sim/não) : Sim',_binary 'Atualização de drivers; troca de cabo VGA.','V',143,'2026-05-09','11:17:00','2026-05-08','09:35:00'),(152,6,16,NULL,NULL,15,'2026-05-07','11:20:00','C','P',_binary 'Nome do usuário :Juliana Santos de Morais \r\nnúmero do CPF :10525768696\r\nModulos que irá acessar (compras, estoque, contabilidade, pregão, credores, frotas, prestação de contas, patrimônio :\r\nacesso no Patrimônio - Contabilidade e Estoque\r\n\r\n',_binary 'Usuário de Acesso :juliana.santos\r\nSenha de Acesso :sabara@2026\r\n\r\nUsuário do(s) módulo(s) :juliana.santos\r\nSenha do(s) módulo(s) :sabara@2026','V',144,'2026-05-07','13:20:00','2026-05-07','11:44:00'),(153,28,16,NULL,NULL,41,'2026-05-07','13:56:00','C','P',_binary 'Se for impressora colorida, qual a cor to toner ?:\r\nSELB da Impressora :creche Perdigão de Roça Grande',_binary 'Responsável pelo transporte:Responsável da Creche','V',145,'2026-05-07','14:26:00','2026-05-07','13:57:00'),(154,7,28,NULL,NULL,23,'2026-05-07','15:16:00','C','P',_binary 'Patrimonio:\r\nInstalação do software QGIS em duas máquinas do setor de Geo.',_binary 'Foi instalada em duas máquinas do setor de Geo o software gratuito QGIS. Para leitura e criação de mapas em formato SHAPE e JSON bem como ler as camadas criadas pela empresa Topocart','V',146,'2026-05-07','17:16:00','2026-05-07','15:17:00'),(155,7,30,NULL,NULL,25,'2026-05-07','17:16:00','C','P',_binary 'Patrimônio :\r\nchecou cabos de energia (sim/não)? sim\r\nMonitor 2 não apresenta video',_binary 'Foram trocados os cabos de video (VGA/HDMI); foi feita atualização dos drives da maquina; reinicialização.','V',147,'2026-05-07','13:00:00','2026-05-07','17:18:00'),(156,7,30,15,NULL,52,'2026-05-07','17:21:00','C','P',_binary 'Descrição do software :\r\nPossui licença? (sim/Não) : Sim\r\nOffice Professional Plus 2016 não estava funcionando.',_binary 'Pacote Office 2016 desinstalado; reinstall do pacote Office 2016; inserção do serial; ','R',148,'2026-05-07','12:40:00','2026-05-07','17:27:00'),(157,18,16,NULL,NULL,38,'2026-05-11','10:22:00','C','P',_binary 'SELB da Impressora :Regional Ana Lucia\r\nImpressora apresentando mensagem off line',_binary 'Foi reconfigurado a impressora e instalado drivers novos nos computadores com novo ip e 3 computadores do setor','V',149,'2026-05-11','17:00:00','2026-05-11','14:12:00'),(158,10,16,NULL,NULL,41,'2026-05-11','11:54:00','C','P',_binary 'Se for impressora colorida, qual a cor to toner ?:Preto\r\nSELB da Impressora :IM430',_binary 'Responsável pelo transporte:Jonathen Felix','V',150,'2026-05-11','12:24:00','2026-05-11','11:55:00'),(159,29,16,NULL,NULL,54,'2026-05-11','14:17:00','C','P',_binary 'Para inserção dos servidores na rede da Defesa Civil, seguem os logins dos usuários:\r\nludmila.martins\r\nviviane.aparecida\r\nfernanda.vitoria\r\ndouglas.martins\r\nguilherme.mendes\r\nyasmin.ribeiro\r\npaulo.rogério\r\npedro.paulo\r\nrafael.almeida\r\nleandro.eduardo\r\njonatas.viana',_binary 'Foi criado novo mapeamento na rede para a defesa civil (DefesaCivil) e usuários forma remanejados para o novo compartilamento de rede','V',151,'2026-05-12','15:17:00','2026-05-13','09:33:00'),(160,28,16,NULL,NULL,41,'2026-05-11','14:59:00','C','P',_binary 'Se for impressora colorida, qual a cor to toner ?:Preto e Margenta\r\nSELB da Impressora :Educação',_binary 'Responsável pelo transporte:Ti da Educação','V',152,'2026-05-11','15:30:00','2026-05-11','15:02:00'),(161,7,28,NULL,NULL,36,'2026-05-11','15:00:00','C','P',_binary 'instalação impressora RH no setor de Projetos',_binary 'testes ok','V',153,'2026-05-11','17:00:00','2026-05-11','15:02:00'),(162,7,16,NULL,NULL,41,'2026-05-11','15:03:00','C','P',_binary 'Se for impressora colorida, qual a cor to toner ?:Margenta\r\nSELB da Impressora :Gabinete',_binary 'Responsável pelo transporte:Jedean para o Pedro ','V',155,'2026-05-11','15:34:00','2026-05-11','15:05:00'),(163,6,28,NULL,NULL,36,'2026-05-11','15:03:00','C','P',_binary 'instalação impressora RH no setor de Serviços Gerais',_binary 'instalação e testes ok','V',154,'2026-05-11','17:03:00','2026-05-11','15:06:00'),(164,33,28,NULL,NULL,77,'2026-05-11','15:12:00','C','P',_binary 'Local: Proju\r\nUsuário: Isasmin, Adriana e Bruno',_binary 'Foram instalados o primeiro acesso da Supernova para os usuários citados faltando apenas o sistema de dívida ativa a ser instalado pelo servidor Leonardo','V',156,'2026-05-11','15:42:00','2026-05-11','15:13:00'),(165,28,16,NULL,NULL,15,'2026-05-11','16:57:00','C','P',_binary 'Nome: Adriana Lúcia da Silva\r\nCPF: 068.132.296-99\r\nModulos que irá acessar (compras, estoque, contabilidade, pregão, credores, frotas, prestação de contas, patrimônio :Estoque\r\n\r\n',_binary '\r\n\r\nUsuário do(s) módulo(s) :adriana.lucia\r\nSenha do(s) módulo(s) :sabara@2026','V',157,'2026-05-11','18:57:00','2026-05-11','16:58:00'),(166,18,16,NULL,NULL,54,'2026-05-11','17:03:00','C','P',_binary 'Nome do usuário : Jairo Chaves de Oliveira\r\nPastas de acesso na rede :Regionais',_binary 'Login do Usuário:jairo.chaves\r\nSenha Inicial :sabara@2026','V',158,'2026-05-11','18:03:00','2026-05-11','17:04:00'),(167,6,16,NULL,NULL,62,'2026-05-12','09:26:00','C','P',_binary 'Nome do Usuário:Juliana Santos de Morais\r\nCPF:não informado\r\nLocais de Tramitação :Administração e patrimonio',_binary 'Login do Usuário :juliana.santos\r\nSenha de Acesso :123456','V',159,'2026-05-12','09:57:00','2026-05-12','09:31:00'),(168,10,16,NULL,NULL,55,'2026-05-12','10:09:00','C','P',_binary 'hais Marcela Lages Fialho\r\nCPF: 10635477688\r\n\r\nPermitir acesso a DS >> Suas\r\nSugestão: thais.fialho',_binary 'usuário :dandara.sales\r\nSenha sabara@2026','V',160,'2026-05-12','11:10:00','2026-05-12','10:14:00'),(169,10,16,NULL,NULL,55,'2026-05-12','10:11:00','C','P',_binary 'Dandara Raiane Sales Ferreira \r\n065.215.316-03\r\nSugestão: dandara.sales\r\n\r\nAcesso pasta DS >> CRAS',_binary 'Login do Usuário:dandara.sales\r\nSenha Inicial :sabara@2026','V',161,'2026-05-12','11:11:00','2026-05-12','10:13:00'),(170,33,16,NULL,NULL,26,'2026-05-12','15:39:00','C','P',_binary 'Patrimônio :juridico (sueli)\r\nChecou cabos de energia e dados (sim/não) :sim',_binary 'Reinstalado drive da placa de video do site da dell. Monitor funcionando normalmente','V',162,'2026-05-14','15:39:00','2026-05-12','15:40:00'),(171,9,30,NULL,NULL,24,'2026-05-12','16:29:00','C','P',_binary 'Patrimônio :\r\nSolicita senha para acessar pastas/arquivos de rede.\r\nUSUÁRIO: tatiane.matias',_binary 'O S.O. é Linux; adicionei o pc ao domínio PMS; executei comandos update/upgrade; solicitei redefinição de senha de domínio para a usuária; configurei acesso para as pastas de rede; examinei ponto de acesso a rede; troquei o patch cord de porta no switch.','V',163,'2026-05-12','12:20:00','2026-05-12','17:00:00'),(172,9,30,21,NULL,23,'2026-05-12','17:08:00','C','P',_binary 'Patrimonio: 103910\r\n\r\nPc foi redefinido para configurações de fábrica.\r\n',_binary 'Maquina atualizada, intalado office','R',164,'2026-05-13','19:11:00','2026-05-15','15:31:00'),(173,6,16,22,NULL,20,'2026-05-13','11:51:00','C','P',_binary 'Patrimônio :081940',_binary 'Mau contato nos conectores da placa mãe.','R',166,'2026-05-18','11:51:00','2026-05-14','09:48:00'),(174,6,27,NULL,NULL,70,'2026-05-14','09:42:00','C','P',_binary 'Instalar mais memória no computador da Bruna ',_binary 'Conclusão : Foi instalado um pente de 4GB de memória no computador da Bruna. Totalizando 8GB','V',169,'2026-05-14','10:43:00','2026-05-14','09:54:00'),(175,6,27,NULL,NULL,70,'2026-05-14','09:46:00','C','P',_binary 'Realizar clonagem de um  HD para SSD, e instalar mais memória.',_binary 'Conclusão : Realizei a clonagem de um HD para SSD, instalei o SSD e instalei mais 4GB de memória RAM.','V',170,'2026-05-14','10:46:00','2026-05-14','09:51:00'),(176,7,16,NULL,NULL,23,'2026-05-14','10:36:00','C','P',_binary 'Patrimonio:não informado\r\nComputador utilizado pela livia do planejamento. Mudança de Local\r\n',_binary 'mudança realizada','V',171,'2026-05-14','12:36:00','2026-05-15','15:29:00'),(177,33,16,NULL,NULL,41,'2026-05-15','11:35:00','C','P',_binary 'Se for impressora colorida, qual a cor to toner ?: Preto\r\nSELB da Impressora :Juridico',_binary 'Responsável pelo transporte:jedean','V',173,'2026-05-15','12:12:00','2026-05-15','11:43:00'),(178,33,32,NULL,NULL,35,'2026-05-15','11:36:00','X','P',_binary 'Solicito por gentileza que verifiquem se há possibilidade de disponibilizar 1 impressora tamanho comum/pequena.',NULL,'V',172,'2026-05-22','11:41:00',NULL,NULL),(179,32,33,NULL,NULL,49,'2026-05-15','11:58:00','C','U',_binary 'Local : Venho solicitar login de acesso a rede HOTSPOT, para:\r\n\r\nLindaiane Almeida \r\nCPF: 14232046623\r\nMatricula: 32550\r\n',_binary 'usuário do wi-fi lindaiane.almeida senha 1234 ','V',174,'2026-05-16','12:04:00','2026-05-15','12:07:00'),(180,7,16,23,NULL,20,'2026-05-15','14:47:00','C','P',_binary 'Patrimônio :119306\r\n\r\nComputador não liga',_binary 'Problema resolvido, foi feito uma limpeza nos componentes.','R',175,'2026-05-19','14:47:00','2026-05-19','08:55:00'),(181,7,16,NULL,NULL,54,'2026-05-15','15:05:00','C','P',_binary 'Nome do usuário :Poliana Torres Frias Siqueira\r\nPastas de acesso na rede :pl, plAprovacao',_binary 'Login do Usuário:poliana.torres\r\nSenha Inicial :sabara@2026','V',176,'2026-05-15','16:05:00','2026-05-15','15:05:00'),(182,10,30,24,NULL,19,'2026-05-15','16:51:00','C','P',_binary 'Patrimõnio do Computador : 92784\r\nUsuário: Déborah\r\n\r\nComputador lento.',_binary 'Equipamento OK','R',177,'2026-05-17','16:52:00','2026-05-20','09:53:00'),(183,27,22,NULL,NULL,17,'2026-05-18','09:43:00','X','P',_binary 'Qual o Usuário ?\r\nMotivo da ação:',NULL,'V',178,'2026-05-19','10:24:00',NULL,NULL),(184,27,22,NULL,NULL,81,'2026-05-18','10:18:00','X','P',_binary 'Caminho  e Nome da pasta onde estava localizado o arquivo:\r\nNome do arquivo :',NULL,'V',181,'2026-05-18','16:19:00',NULL,NULL),(185,27,22,NULL,NULL,81,'2026-05-18','10:42:00','X','P',_binary 'Caminho  e Nome da pasta onde estava localizado o arquivo:\r\nNome do arquivo :',NULL,'V',180,'2026-05-18','16:18:00',NULL,NULL),(186,7,16,NULL,NULL,41,'2026-05-18','10:56:00','C','P',_binary 'Se for impressora colorida, qual a cor to toner ?: Preto\r\nSELB da Impressora :Planejamento',_binary 'Responsável pelo transporte:Pedro Neves','V',179,'2026-05-18','11:26:00','2026-05-18','10:57:00'),(187,5,16,NULL,NULL,41,'2026-05-18','11:26:00','C','P',_binary 'Se for impressora colorida, qual a cor to toner ?:Apena preto\r\nSELB da Impressora :Saúde',_binary 'Responsável pelo transporte:Clayson','V',182,'2026-05-18','11:57:00','2026-05-18','11:28:00'),(188,7,27,NULL,NULL,20,'2026-05-18','12:18:00','C','P',_binary 'Patrimônio :119306\r\n\r\nComputador não esta ligando.',_binary 'Computador não ligava, foi feito a limpeza e foi feito a formatação do computador.','V',183,'2026-05-20','12:19:00','2026-05-18','12:20:00'),(189,8,16,NULL,NULL,70,'2026-05-18','16:49:00','C','P',_binary 'Estou com problema para logar no meu usuário através da minha máquina Linux. Quando insiro o usuário e digito a senha, aparece senha incorreta. Não obstante, quando insiro o mesmo usuário e senha numa máquina sistema windoms, o usuário entra normalmente. \r\n\r\nPodem me ajudar?\r\n\r\nAtenciosamente,\r\n\r\nMaria Luiza',_binary 'Conclusão : feitos update && upgrade; configuração de impressora; adicionados locais de rede (fa/publico); configuração de token virtual (inicialmente com erro de acesso).','V',184,'2026-05-18','16:49:00','2026-05-20','13:55:00'),(190,33,32,NULL,NULL,52,'2026-05-19','10:21:00','C','P',_binary 'Descrição do software :\r\nPossui licença? (sim/Não) : \r\nEstou tentando acessar o pje, quando aperto em certificado digital, após carregar por muito tempo, aparece erro \"Operação cancelada\".',_binary 'Pje configurado corretamente. Foi detectado uso de certificado virtual da \"vidaas\" certicação em nuvem\r\nNecessário autenticação via celular do Procurador Municipal','V',185,'2026-05-19','12:38:00','2026-05-19','12:05:00'),(191,5,16,NULL,NULL,15,'2026-05-19','11:42:00','C','P',_binary 'Nome do usuário :Rafael Moreira\r\nnúmero do CPF : 08825117698\r\nModulos que irá acessar (compras, estoque, contabilidade, pregão, credores, frotas, prestação de contas, patrimônio) :\r\nContabilidade, credores, Prestação de Contas\r\n\r\n',_binary 'Usuário do(s) módulo(s) :rafael.moreira\r\nSenha do(s) módulo(s) :sabara@2026','V',186,'2026-05-19','13:43:00','2026-05-19','11:43:00'),(192,7,16,NULL,NULL,54,'2026-05-19','15:13:00','C','P',_binary 'Nome do usuário :Ana Luiza Dutra da Silva e Bianca Izabele Leão Figueiredo\r\nPastas de acesso na rede :pl, plReurb e plAprovacao',_binary 'Login do Usuário:ana.dutra e bianca.figueiredo\r\nSenha Inicial : sabara@2026','V',187,'2026-05-19','16:13:00','2026-05-19','15:13:00'),(193,34,16,NULL,NULL,43,'2026-05-20','15:02:00','C','P',_binary 'local :Prédio do procom. Sem internet em compudador e consequentemente telefone',_binary 'Configuração de impressora, alteração de local do telefone, verificação de dois pontos de rede','V',188,'2026-05-20','18:02:00','2026-05-20','16:29:00'),(194,33,32,NULL,NULL,17,'2026-05-20','15:49:00','C','U',_binary 'Qual o Usuário ? jessica.barbosa\r\nMotivo da ação: erro de senha',_binary 'Nova senha de entrada : sabara@2026','V',189,'2026-05-20','16:21:00','2026-05-20','15:53:00'),(195,13,16,NULL,NULL,24,'2026-05-20','16:42:00','C','P',_binary 'Patrimônio :099484',_binary 'Computador teve a bios atualizada e foi colocado no dominio de rede','V',190,'2026-05-22','16:42:00','2026-05-22','15:39:00'),(196,28,16,NULL,NULL,41,'2026-05-21','08:52:00','C','P',_binary 'Se for impressora colorida, qual a cor to toner ?:Preto\r\nSELB da Impressora :im430 Educação',_binary 'Responsável pelo transporte:Lucio Machado','V',191,'2026-05-21','09:23:00','2026-05-21','08:57:00'),(197,33,32,NULL,NULL,56,'2026-05-21','09:40:00','C','U',_binary 'Login do usuário : natalya.duarte\r\nNovas pastas de acesso na rede : acesso ao computador e rede juridico',_binary 'Nova senha para computador / rede : sabara@2026','V',192,'2026-05-21','10:54:00','2026-05-21','10:10:00'),(198,33,32,NULL,NULL,69,'2026-05-21','10:28:00','C','P',_binary 'Solicito suporte técnico devido a erro do word, arquivo não está abrindo. ',_binary 'Problema de compatibilidade com o documento e o Microsoft Office 2019. O documento abriu no Writer - LibreOffice.','V',193,'2026-05-21','16:55:00','2026-05-21','15:49:00'),(199,30,16,NULL,NULL,41,'2026-05-21','15:04:00','C','P',_binary 'Se for impressora colorida, qual a cor to toner ?:\r\nSELB da Impressora :Segurança Pública',_binary 'Responsável pelo transporte:Luizinho','V',194,'2026-05-21','15:35:00','2026-05-21','15:12:00'),(200,8,30,NULL,NULL,23,'2026-05-21','16:00:00','C','P',_binary 'Patrimonio:\r\n\r\nVerificação da montagem do pc; verificação da instalação de programas padrão; configuração de impressoras (13.240 e 13.241)',_binary 'Solicitação concluida. \r\nVerificação do usuário de rede;\r\nInstalação do módulo SUPERNOVA - MODERNA.','V',195,'2026-05-21','11:50:00','2026-05-21','16:02:00'),(201,6,27,NULL,NULL,52,'2026-05-22','09:33:00','C','P',_binary 'Descrição do software : Formatar computador RH\r\nPossui licença? (sim/Não) :\r\n\r\nPatrimônio 119037: ',_binary 'Foi feito a formatação do computador e limpeza interna.','V',196,'2026-05-22','11:33:00','2026-05-22','09:34:00'),(202,33,32,NULL,NULL,65,'2026-05-25','09:16:00','C','P',_binary 'Número Telefone:\r\nNúmero Ramal: \r\nCom a mudança de local, um dos telefones da Procuradoria estão recebendo chamadas que seriam destinadas à Secretaria de Planejamento. Solicito por gentileza que verifique.',_binary 'O aparelho pertence à Secretaria de Planejamento no qual a funcionária Jéssica (Jurídico) tomou a iniciativa ao devolver o aparelho. Chamado encerrado','V',197,'2026-05-25','09:42:00','2026-05-25','09:43:00'),(203,29,34,NULL,NULL,22,'2026-05-25','09:20:00','C','P',_binary 'Patrimônio :119304\r\n',_binary 'Desktop POSITIVO MASTER D480 esquentando o gabinete. Foi relatada melhora na performance do equipamento após reinício. \r\nO detalhe da máquina é aquecimento.','V',199,'2026-05-26','15:19:00','2026-05-25','11:01:00'),(204,35,37,NULL,NULL,77,'2026-05-25','10:32:00','C','U',_binary 'Local:RH\r\nUsuário:paulo.castro\r\n\r\nO SISTEMA SUPERNOVA NÃO ESTÁ ENTRANDO, DANDO MENSAGEM DE ERRO.\r\n\r\nASS. PAULO H',_binary 'Foi feio a reinstalação do supernova no computador.','V',198,'2026-05-25','12:15:00','2026-05-25','11:47:00'),(205,33,32,NULL,NULL,37,'2026-05-25','15:15:00','C','P',_binary 'SELB da impressora :\r\nesta dando erro na fila de impressão de alguns computadores',_binary 'Foi feito alteração do ip da impressora. Funcionando normalmente','V',200,'2026-05-28','15:23:00','2026-05-25','16:38:00'),(206,31,30,NULL,NULL,36,'2026-05-26','09:27:00','C','P',_binary 'SELB da Impressora :\r\n\r\nConfigurar os computadores com a impressora do setor Jurídico.\r\nUSUÁRIO: Etelvina Lana',_binary 'Chamado resolvido, instalado a Impressora no computador.','V',201,'2026-05-26','12:06:00','2026-05-26','10:07:00'),(207,31,27,NULL,NULL,36,'2026-05-26','10:28:00','C','P',_binary 'SELB da Impressora : Instalar impressora no computador da Joelma, Gabinete.',_binary 'Foi feito a instalação no computador.','V',203,'2026-05-26','12:30:00','2026-05-26','10:30:00'),(208,31,27,NULL,NULL,36,'2026-05-26','10:29:00','C','P',_binary 'SELB da Impressora : Instalar impressora no computador Jéssica, gabinete.',_binary 'Foi feita a instalação configuração da impressora no computador.','V',202,'2026-05-26','12:29:00','2026-05-26','10:31:00'),(209,8,16,NULL,NULL,41,'2026-05-26','11:47:00','C','P',_binary 'Se for impressora colorida, qual a cor to toner ?:\r\nSELB da Impressora :Fazenda',_binary 'Responsável pelo transporte:Edilson','V',204,'2026-05-26','12:18:00','2026-05-26','11:49:00'),(210,7,16,NULL,NULL,15,'2026-05-26','15:21:00','C','P',_binary 'Nome do usuário :Ismael dos Santos e Erick.elias\r\nnúmero do CPF : 182.728.986.40 (Erick)\r\nModulos que irá acessar (compras, estoque, contabilidade, pregão, credores, frotas, prestação de contas, patrimônio :Acesso inicial\r\n\r\n',_binary 'Erick Elias Usuário de rede e acesso ao supernova erick.elias  senha sabara@2026\r\nProtocoloweb erick.elias senha 123456\r\n\r\nIsmael Elias\r\n\r\nUsuário protocolo web ismael.elias senha 123456\r\nUsuário supernova acesso ismael.santos senha sabara@2026','V',208,'2026-05-26','17:26:00','2026-05-26','15:29:00'),(211,7,16,NULL,NULL,62,'2026-05-26','15:23:00','C','P',_binary 'Nome do Usuário::Ismael dos Santos e Erick.elias\r\nCPF:182.728.986.40\r\nLocais de Tramitação :Planejamento',_binary 'Erick Elias Usuário de rede e acesso ao supernova erick.elias  senha sabara@2026\r\nProtocoloweb erick.elias senha 123456\r\n\r\nIsmael Elias\r\n\r\nUsuário protocolo web ismael.elias senha 123456\r\nUsuário supernova acesso ismael.santos senha sabara@2026','V',207,'2026-05-26','15:56:00','2026-05-26','15:30:00'),(212,7,16,NULL,NULL,54,'2026-05-26','15:24:00','C','P',_binary 'Nome do usuário :Erick Elias e Ismael Santos\r\nPastas de acesso na rede :Planejamento e Alvaras',_binary 'Erick Elias Usuário de rede e acesso ao supernova erick.elias  senha sabara@2026\r\nProtocoloweb erick.elias senha 123456\r\n\r\nIsmael Elias\r\n\r\nUsuário protocolo web ismael.elias senha 123456\r\nUsuário supernova acesso ismael.santos senha sabara@2026','V',206,'2026-05-26','16:25:00','2026-05-26','15:31:00'),(213,11,16,NULL,NULL,41,'2026-05-26','15:25:00','C','P',_binary 'Se for impressora colorida, qual a cor to toner ?:\r\nSELB da Impressora :IM 430',_binary 'Responsável pelo transporte:Meio Ambiente','V',205,'2026-05-26','15:55:00','2026-05-26','15:27:00'),(214,9,16,NULL,NULL,41,'2026-05-27','11:40:00','C','P',_binary 'Se for impressora colorida, qual a cor to toner ?:Margenta\r\nSELB da Impressora :Obras',_binary 'Responsável pelo transporte:Secretaria de Obras','V',209,'2026-05-27','12:11:00','2026-05-27','11:42:00'),(215,32,33,NULL,NULL,68,'2026-05-27','12:58:00','C','U',_binary 'Local: Sala do Controlador Dr. Samuel\r\nprecisa de ajuda quanto a um ponto de rede que parece que nao esta passando rede',_binary 'Problema relatado não está relacionado a rede. Problema no notebook  do controlador que não está aceitando conexão via cabo.\r\n\r\nComputador será avalidado devido a não ser máquina da Prefeitura','V',210,'2026-05-27','17:59:00','2026-05-28','09:31:00'),(216,19,16,NULL,NULL,41,'2026-05-27','16:30:00','C','P',_binary 'Se for impressora colorida, qual a cor to toner ?:\r\nSELB da Impressora :Reginal ravena',_binary 'Responsável pelo transporte:Regional Ravena','V',211,'2026-05-27','17:01:00','2026-05-27','16:32:00'),(217,10,16,NULL,NULL,41,'2026-05-28','13:53:00','C','P',_binary 'Se for impressora colorida, qual a cor to toner ?:preto\r\nSELB da Impressora :Desenvolvimento Social\r\n',_binary 'Responsável pelo transporte:Jonathan','V',212,'2026-05-28','14:25:00','2026-05-28','13:58:00'),(218,28,16,NULL,NULL,41,'2026-05-28','16:52:00','C','P',_binary 'Se for impressora colorida, qual a cor to toner ?:\r\nSELB da Impressora :Cei ',_binary 'Responsável pelo transporte:Cei','V',213,'2026-05-28','17:22:00','2026-05-28','16:53:00'),(219,6,30,NULL,NULL,42,'2026-05-28','17:10:00','C','P',_binary 'SELB da impressora DER06\r\n\r\nTroca da unidade fusora da impressora SELB DER06 pela unidade fusora da impressora SELB 120Q.\r\nTroca da impressora SELB DER06 pela impressora SELB 120Q.\r\nColocação da impressora 120Q na Secretaria de Administração;\r\nFazer bkp.',_binary 'Feita a troca; restaurado o bkp; feitas as configurações necessárias; configurada a tela de scanner.\r\nTérmino: 28/05/2026, às 21h30min.','V',223,'2026-05-28','21:32:00','2026-06-01','17:04:00'),(220,7,30,NULL,NULL,55,'2026-06-01','08:41:00','C','U',_binary 'Redefinição de senha para lucio.machado',_binary 'Nova senha do usuário :sabara@2026','V',214,'2026-06-01','09:42:00','2026-06-01','09:20:00'),(221,32,30,NULL,NULL,46,'2026-06-01','08:46:00','C','P',_binary 'Local : \r\nNúmero de pontos: 07',_binary 'Serviço realizado com sucesso.','V',215,'2026-06-29','17:00:00','2026-06-02','09:17:00'),(222,31,30,NULL,NULL,46,'2026-06-01','08:52:00','C','P',_binary 'Local : mesa da secretária (Jéssica)\r\nNúmero de pontos: 01',_binary 'Ponto de rede instalado.','V',216,'2026-06-29','17:00:00','2026-06-02','09:17:00'),(223,6,38,NULL,NULL,10,'2026-06-01','13:55:00','C','U',_binary 'Descrição do e-mail (ex. <descricao>@sabara.mg.gov.br:  clayton.peixoto@sabara.mg.gov.br\r\nResponsável : Clayton Luiz Lima Peixoto - Cpf: 07463714624 ( Secretário Administração )',_binary 'Descrição do e-mail:clayton.peixoto@sabara.mg.gov.br\r\nSenha inicial :sabara@2026\r\n\r\nobs.:necessário instalação do microsoft autenticator no celular','V',217,'2026-06-01','16:01:00','2026-06-01','14:03:00'),(224,30,16,NULL,NULL,35,'2026-06-01','15:59:00','X','P',_binary 'SELB da impressora: Impressora da Guarda\r\n\r\nConfiguração de scanner da Maquina da Aexandra.',NULL,'V',218,'2026-06-04','16:00:00',NULL,NULL),(225,6,30,NULL,NULL,46,'2026-06-01','16:08:00','C','P',_binary 'Local : setor de Patrimônio\r\nNúmero de pontos: 08 pontos',_binary 'Os pontos foram modificados, e as mesas foram reposicionadas.','V',219,'2026-05-29','17:00:00','2026-06-02','09:19:00'),(226,6,38,NULL,NULL,54,'2026-06-01','16:09:00','C','U',_binary 'Nome do usuário : Clayton Peixoto\r\nPastas de acesso na rede : Administração, Transporte, RH, Patrimônio, Serviços Gerais',_binary 'Login do Usuário:clayton.peixoto\r\nSenha Inicial :sabara@2026\r\n\r\nOBS :Usuário já possuia cadastro na rede vinculado a secretaria de Obras. Foi Alterado o perfil para as pastas da secretaria de Administração','V',220,'2026-06-02','09:00:00','2026-06-01','16:33:00'),(227,33,30,NULL,NULL,46,'2026-06-01','16:41:00','C','P',_binary 'Local : Jurídico\r\nNúmero de pontos: 18 pontos',_binary 'Pontos foram modificados, estão em pleno funcionamento.','V',221,'2026-05-29','17:00:00','2026-06-02','09:18:00'),(228,10,30,NULL,NULL,46,'2026-06-01','16:55:00','C','P',_binary 'Local : Advocacia Municipal\r\nNúmero de pontos: 11 pontos\r\n\r\nTroca para nova sala; modificação da posição das mesas',_binary 'Pontos modificados, mesas reposicionadas.','V',222,'2026-05-29','17:00:00','2026-06-02','09:18:00'),(229,33,32,NULL,NULL,15,'2026-06-02','09:24:00','C','P',_binary 'Nome do usuário : Natalya Duarte\r\nnúmero do CPF : 018.968.716-90\r\nModulos que irá acessar (compras, estoque, contabilidade, pregão, credores, frotas, prestação de contas, patrimônio : Dívida ativa\r\n\r\n',_binary 'Por questão de controle e segurança os usuários e senhas do módulo de divida ativa e iptu são criados pelo Sr. Leonardo ou Sr. Arísio da secretaria de fazenda. Solicitamos que seja feito contato com os mesmos para essa demanda','V',224,'2026-06-02','11:32:00','2026-06-02','09:34:00'),(230,30,42,NULL,NULL,35,'2026-06-02','09:45:00','C','U',_binary 'SELB da impressora\r\n\r\nPrezados,\r\n\r\nSolicito a gentileza de realizar a configuração do scanner em meu computador, uma vez que o equipamento não se encontra disponível para utilização ou necessita de ajustes para seu correto funcionamento.\r\n\r\nA configuração é necessária para o desempenho das atividades administrativas desta Secretaria, especialmente para digitalização e tramitação de documentos.',_binary 'o Scanner foi configurado no computador.','V',225,'2026-06-02','17:48:00','2026-06-02','14:47:00'),(231,36,43,NULL,NULL,8,'2026-06-02','11:42:00','C','P',_binary 'Usuário : Laysa\r\nPatrimonio: 096564\r\n\r\nDescrição do problema: O computador já foi encaminhado para manutenção na data de hoje.',_binary 'Observações: Sistema operacional Windows instalado (sem ativação); programas padrão instalados e configurados; driver de impressora instalado e configurado;','V',226,'2026-06-08','16:04:00','2026-06-08','16:02:00'),(232,30,42,NULL,NULL,13,'2026-06-03','12:55:00','C','P',_binary 'Descrição do e-mail: elianefatima@sabara.mg.gov.br\r\nResponsável : Eliane de Fatima\r\n\r\nSolicito a gentileza de providenciar a configuração de computador na rede da Prefeitura, incluindo acesso aos sistemas e recursos institucionais necessários ao desempenho das atividades funcionais.\r\nRedefinição da senha do e-mail corporativo da servidora Eliane, tendo em vista que a mesma encontra-se sem acesso à sua conta de e-mail institucional, impossibilitando o recebimento e envio de mensagens relacionadas às suas atividades laborais.\r\n\r\nAtenciosamente,',_binary 'Senha redefinida para :sabara@2026\r\n\r\nQuanto ao computador o mesmo deve ser enviado para nossa oficina na sede administrativa para avaliação, configuração e \r\ninstalação e sistemas','V',227,'2026-06-03','16:08:00','2026-06-03','14:09:00'),(233,29,16,NULL,NULL,41,'2026-06-03','14:44:00','C','P',_binary 'Se for impressora colorida, qual a cor to toner ?:Guarda\r\nSELB da Impressora :im 430',_binary 'Responsável pelo transporte:Funcionário da Guarda Civil','V',228,'2026-06-03','15:14:00','2026-06-03','14:45:00'),(234,29,34,NULL,NULL,54,'2026-06-08','11:55:00','C','P',_binary 'Nome do usuário : Aline Magalhães \r\nPastas de acesso na rede : Defesa Civil\r\n',_binary 'Login do Usuário:aline.magalhaes\r\nSenha Inicial :sabara@2026','V',229,'2026-06-08','12:57:00','2026-06-08','11:58:00'),(235,29,34,NULL,NULL,82,'2026-06-08','13:22:00','E','U',_binary 'Solicito por gentileza a manutenção de um cabo de rede de internet.',NULL,'V',232,'2026-06-09','08:00:00',NULL,NULL),(236,36,43,NULL,NULL,13,'2026-06-08','13:23:00','C','P',_binary 'Descrição do e-mail: elem.colchete@sabara\r\nResponsável : Elem (31) 998932246\r\n\r\nO usuário não consegue acessar o e-mail. Consta erro de senha. ',_binary 'Senha redefinida para :sabara@2026','V',230,'2026-06-08','15:51:00','2026-06-08','13:52:00'),(237,33,32,NULL,NULL,15,'2026-06-08','14:06:00','C','P',_binary 'Nome do usuário : Natalya Duarte\r\nnúmero do CPF : 018.968.716-90\r\nModulos que irá acessar (compras, estoque, contabilidade, pregão, credores, frotas, prestação de contas, patrimônio : Dívida ativa.\r\nPrecisa de login para que o Leo libere acesso\r\n\r\n',_binary 'Usuário de Acesso :natalya.duarte\r\nSenha de Acesso :sabara@2026\r\n\r\n','V',231,'2026-06-08','16:17:00','2026-06-08','14:18:00'),(238,36,43,NULL,NULL,13,'2026-06-08','14:07:00','E','P',_binary 'Descrição do e-mail: elem.colchete@sabara \r\nResponsável : Elem (31) 998932246 \r\n\r\nPrezados, mesmo após a redefinição da senha, não consigo acesso. Em anexo a mensagem que aparece \"solicitação negada\". ',NULL,'V',233,'2026-06-09','18:03:00',NULL,NULL),(239,28,16,NULL,NULL,41,'2026-06-08','21:46:00','C','P',_binary 'Se for impressora colorida, qual a cor to toner ?:-\r\nSELB da Impressora :Educação',_binary 'Responsável pelo transporte:Educação','V',234,'2026-06-08','22:17:00','2026-06-08','21:48:00'),(240,36,43,NULL,NULL,8,'2026-06-09','09:39:00','C','P',_binary 'Usuário : maria.xavier\r\nPatrimonio: 118220\r\n\r\nDescrição do problema: o computador veio da formatação mas eu não consigo fazer o login no meu usuário. Coloquei em anexo a informação que aparece na tela.',_binary 'Observações: Problema de acesso ao dominio resolvido após visita técnica','V',235,'2026-06-08','17:00:00','2026-06-09','16:03:00'),(241,8,16,NULL,NULL,41,'2026-06-09','10:02:00','C','P',_binary 'Se for impressora colorida, qual a cor to toner ?:501\r\nSELB da Impressora :Fazenda 501',_binary 'Responsável pelo transporte:Fazenda','V',236,'2026-06-09','10:33:00','2026-06-09','10:04:00'),(242,31,30,NULL,NULL,76,'2026-06-09','17:00:00','C','P',_binary 'Local a ser utilizado : recepção\r\nMetragem : 2,5m',_binary 'acompanhamento de mudança das mesas da recepção; confecção de novo cabeamento; solicitação de ligação elétrica para o novo local da mesa da recepção.','V',237,'2026-06-09','11:47:00','2026-06-09','17:02:00'),(243,31,30,NULL,NULL,35,'2026-06-09','17:09:00','C','P',_binary 'SELB da impressora: TFD2\r\nReconfiguração de acesso para a pasta SCANNER - GO ',_binary 'Acessos regularizados','V',238,'2026-06-09','09:40:00','2026-06-09','17:11:00'),(244,8,27,NULL,NULL,24,'2026-06-10','08:20:00','C','P',_binary 'Patrimônio :Instalar scanner Duda, da Sec. Fazenda.',_binary 'Foi colocado o Scanner na rede.','V',239,'2026-06-11','08:21:00','2026-06-10','08:21:00'),(245,8,30,NULL,NULL,82,'2026-06-10','12:56:00','E','P',_binary 'Acionar a Regional Centro pra vistoriar rede elétrica no setor de GeoProcessamento',NULL,'V',240,'2026-06-17','17:00:00',NULL,NULL),(246,18,16,NULL,NULL,41,'2026-06-10','14:02:00','C','P',_binary 'Se for impressora colorida, qual a cor to toner ?:\r\nSELB da Impressora :58YL',_binary 'Responsável pelo transporte:Reginal Ana Lucia','V',241,'2026-06-10','14:32:00','2026-06-10','14:05:00'),(247,36,43,NULL,NULL,67,'2026-06-10','14:09:00','C','P',_binary 'Login do Usuário :laysasantos\r\nNovos locais de tramitação: gerencia de tributos \r\nExcluir locais anteriores (sim/Não) : NÃO',_binary 'Foi incluido novo local como solicitado','V',243,'2026-06-10','15:05:00','2026-06-10','14:39:00'),(248,36,43,NULL,NULL,62,'2026-06-10','14:11:00','C','P',_binary 'Nome do Usuário: maria.xavier - Maria Luiza Ferreira Rodrigues Xavier\r\nCPF: 130.088.836-99\r\nLocais de Tramitação : Gerência de Fiscalização de Tributos\r\n\r\n',_binary 'Login do Usuário :maria.xavier\r\nSenha de Acesso :123456','V',242,'2026-06-10','15:05:00','2026-06-10','14:40:00'),(249,7,16,NULL,NULL,41,'2026-06-10','14:58:00','C','P',_binary 'Se for impressora colorida, qual a cor to toner ?:Preto \r\nSELB da Impressora :C2000 do Planejamento',_binary 'Responsável pelo transporte:Pedro Neves','V',244,'2026-06-10','15:28:00','2026-06-10','14:59:00'),(250,29,34,NULL,NULL,54,'2026-06-10','15:52:00','C','P',_binary 'Nome do usuário :Lidia Ribeiro\r\n\r\nPastas de acesso na rede :Defesa Civil ',_binary 'Login do Usuário:lidia.ribeiro\r\nSenha Inicial :sabara@2026','V',245,'2026-06-10','17:01:00','2026-06-10','16:04:00'),(251,8,16,NULL,NULL,52,'2026-06-10','16:19:00','C','P',_binary 'Descrição do software :Office\r\nPossui licença? (sim/Não) : sim',_binary 'Office registrado e funcional','V',246,'2026-06-10','18:19:00','2026-06-10','21:22:00'),(252,14,30,NULL,NULL,44,'2026-06-10','17:02:00','C','P',_binary 'local : Campo da Liga Municipal de Desportos\r\nInstalar programas',_binary 'Serviço na  realizado com sucesso','V',247,'2026-06-11','17:00:00','2026-06-12','16:04:00'),(253,31,27,NULL,NULL,23,'2026-06-11','09:17:00','C','P',_binary 'Patrimonio: Instalação de TOTENS no Prédio Administrativo.\r\n',_binary 'Foi instalado os Totens no Centro Administrativo.','V',249,'2026-06-11','11:22:00','2026-06-11','09:22:00'),(254,28,27,NULL,NULL,24,'2026-06-11','09:19:00','C','P',_binary 'Patrimônio : Configurar computadores pra ingressar na rede. Sec. de Educação (SEMED)',_binary 'Foi configurados os computadores na rede.','V',248,'2026-06-12','09:20:00','2026-06-11','09:21:00'),(255,6,38,NULL,NULL,82,'2026-06-11','10:12:00','C','U',_binary 'SOLICITO POR GENTILEZA A LIBERAÇÃO DE CESSO AO SITEMA SUPERNOVA PARA O SECRETÁRIO DE ADMINISTRAÇÃO CLAYTON LUIZ LIMA PEIXOTO MATRICULA 34693. \r\nSOLICITO OS SEGUINTES ACESSOS:\r\n\r\nCompras\r\nEstoque\r\nContabilidade\r\nPatrimônio\r\nProtocolo\r\nFrotas\r\nRh\r\n\r\nObrigada\r\n',_binary 'Usuário de acesso ao supernova e ao módulos de compras, contabilidade, estoque, patrimonio e frotas: clayton.peixoto senha sabara@2026\r\n- Usuário Protocolo web clayton.peixoto senha inicial sabara@2026\r\n- O sistema de Rh deve ser cadastrado pelo Sr. Nilo no RH','V',250,'2026-06-11','14:00:00','2026-06-11','11:05:00'),(256,35,37,NULL,NULL,74,'2026-06-11','14:40:00','C','P',_binary 'Solicito a inclusão do Módulo Compras (execução de procedimentos) para a Servidora: Raissa Aparecida da Silva Coelho, matrícula: 34234, cpf: 127.728.096.76.\r\n1º login no sistema supernova: raissa.coelho',_binary 'Acesso ao Ssistema de Compras\r\nUsuário :raissa.coelho\r\nSenha : sabara@2026\r\n','V',251,'2026-06-11','15:58:00','2026-06-11','15:05:00'),(257,32,33,NULL,NULL,41,'2026-06-11','15:01:00','C','U',_binary 'Se for impressora colorida, qual a cor to toner ?: Magenta\r\nSELB da Impressora : não sei ',_binary 'Responsável pelo transporte:Jedean Moises','V',252,'2026-06-11','15:39:00','2026-06-11','15:10:00'),(258,30,16,NULL,NULL,41,'2026-06-11','16:20:00','C','P',_binary 'Se for impressora colorida, qual a cor to toner ?:Não\r\nSELB da Impressora : Guarda',_binary 'Responsável pelo transporte:Guada Municipal','V',253,'2026-06-11','16:50:00','2026-06-11','16:22:00'),(259,7,30,NULL,NULL,48,'2026-06-12','08:28:00','C','P',_binary 'Local: Centro Adminitrativo - Comunicação\r\nNúmero de pontos: 06 ',_binary 'Pontos necessários, foram instalados.','V',254,'2026-06-16','17:00:00','2026-06-15','12:26:00'),(260,36,43,NULL,NULL,65,'2026-06-12','10:05:00','C','P',_binary 'Número Telefone:3672-7876\r\nNúmero Ramal: 1221\r\nOutro Telefone fixo ou celular para contato : 31992653413,  pessoal pois não temos outro telefone. Laysa',_binary 'Manutenção Feita na linha pela SpeedNet. Linha testada e funcionando normalmente','V',255,'2026-06-12','17:00:00','2026-06-12','10:43:00'),(261,13,39,NULL,NULL,43,'2026-06-12','13:11:00','C','P',_binary 'local : na sala que funciona a gerencia de fomento, o cabo que liga o computador da servidora Karoline, se partiu, por esse motivo ela se encontra sem acesso a internet pela rede.',_binary 'Cabo danificado trocado no local','V',256,'2026-06-12','17:09:00','2026-06-12','16:10:00'),(262,9,30,NULL,NULL,43,'2026-06-12','16:58:00','C','P',_binary 'local : Regional Centro\r\n',_binary 'Informada a demanda aos coordenadores; acionada a empresa responsável;\r\n(houve troca de postes da rede elétrica, próximos ao local);\r\n-Restabelecidas as conexões.','V',257,'2026-06-12','12:00:00','2026-06-12','16:59:00'),(263,6,38,NULL,NULL,54,'2026-06-15','08:49:00','C','U',_binary ' Nome do usuário : TAYLA DE SIQUEIRA\r\nPastas de acesso na rede : Solicito que seja feito o cadastro da estagiária em usuários de rede/computador. ela fará estágio no setor de trasnporte.',_binary 'Login do Usuário:tayla.siqueira\r\nSenha Inicial :sabara@2026','V',258,'2026-06-15','10:05:00','2026-06-15','09:07:00'),(264,33,32,NULL,NULL,16,'2026-06-15','11:15:00','C','U',_binary 'Qual o login do usuário? : jessica.barbosa',_binary 'Nova senha redefinida : sabara@2026','V',259,'2026-06-15','11:49:00','2026-06-15','11:20:00'),(265,35,16,NULL,NULL,41,'2026-06-15','16:09:00','C','P',_binary 'Se for impressora colorida, qual a cor to toner ?:\r\nSELB da Impressora :Recursos Humanos',_binary 'Responsável pelo transporte:Jedean Moises','V',260,'2026-06-15','16:39:00','2026-06-15','16:10:00'),(266,7,27,NULL,NULL,22,'2026-06-16','08:14:00','C','P',_binary 'Patrimônio :\r\nUsuário : Sec.Thiago\r\n',_binary 'Foi corrigido o erro de tela preta, foi feito o Clear Cmos. A computador foi atualizado, e o defeito foi corrigido.','V',261,'2026-06-18','08:16:00','2026-06-16','11:20:00'),(267,34,30,NULL,NULL,20,'2026-06-16','08:39:00','C','P',_binary 'Patrimônio :\r\n',_binary 'Patrimônio 119204\r\nUpdate && upgrade; verificação das configurações de impressora e usuário.\r\nNenhum problema elétrico detectado.','V',273,'2026-06-22','09:46:00','2026-06-19','11:35:00'),(268,34,30,NULL,NULL,38,'2026-06-16','08:42:00','C','P',_binary 'SELB da Impressora :\r\n',_binary 'Remoção de dispositivos impressora não utilizados; configuração de impressora padrão PROCON.','V',272,'2026-06-22','09:45:00','2026-06-19','11:35:00'),(269,27,22,NULL,NULL,15,'2026-06-16','10:18:00','X','P',_binary 'Nome do usuário :jose da silva\r\nnúmero do CPF :08098-09809\r\nModulos que irá acessar (compras, estoque, contabilidade, pregão, credores, frotas, prestação de contas, patrimônio :compras\r\n\r\n\r\n\r\n',NULL,'V',263,'2026-06-16','13:56:00',NULL,NULL),(270,36,43,NULL,NULL,36,'2026-06-16','11:02:00','C','P',_binary 'SELB da Impressora : DEU7 \r\n\r\nA impressora da Receita, na Secretaria de Fazenda, não está configurada para impressão na minha minha máquina e não sei adicioná-la através das configurações.',_binary 'Impressora instalada; teste de impressão \"OK\".','V',264,'2026-06-16','17:57:00','2026-06-17','09:38:00'),(271,7,16,NULL,NULL,41,'2026-06-16','11:54:00','C','P',_binary 'Se for impressora colorida, qual a cor to toner ?:\r\nSELB da Impressora :planejmento',_binary 'Responsável pelo transporte:Lucio Machado','V',262,'2026-06-16','12:24:00','2026-06-16','11:56:00'),(272,11,16,NULL,NULL,54,'2026-06-16','12:02:00','C','P',_binary 'Nome do usuário :Luiza Cristina Santiago Arcanjo\r\nPastas de acesso na rede :Meio Ambiente',_binary 'Login do Usuário:luiza.arcanjo\r\nSenha Inicial :sabara@2026','V',265,'2026-06-16','14:30:00','2026-06-16','14:09:00'),(273,11,16,NULL,NULL,62,'2026-06-16','12:10:00','C','P',_binary 'Nome do Usuário:Luiza Cristina Santiago Arcanjo\r\nLocais de Tramitação :Meio Ambiente',_binary 'Login do Usuário :luiza.arcanjo\r\nSenha de Acesso :123456','V',266,'2026-06-16','14:29:00','2026-06-16','14:00:00'),(274,27,22,NULL,NULL,10,'2026-06-16','15:12:00','X','P',_binary 'Descrição do e-mail (ex. <descricao>@sabara.mg.gov.br:teste@sabara.mg.gov.br\r\nResponsável :jose da silva\r\n\r\n',NULL,'V',267,'2026-06-16','17:24:00',NULL,NULL),(275,30,30,26,NULL,19,'2026-06-17','11:44:00','C','P',_binary 'Patrimõnio do Computador : 97353\r\nUsuário: Mauricio Mendes',_binary 'Atualização de drivers; remoção de arquivos temporários; backup de arquivos/documentos; reinstalação de Sistema Operacional (Win10); instalação e configuração de \"programas padrão\"; instalação de driver de impressora IM430f.','R',268,'2026-06-19','17:00:00','2026-06-18','11:00:00'),(276,27,22,NULL,NULL,48,'2026-06-17','14:20:00','X','P',_binary 'Local:\r\nNúmero de pontos',NULL,'V',269,'2026-06-18','14:32:00',NULL,NULL),(277,7,48,NULL,NULL,70,'2026-06-17','14:38:00','E','P',_binary 'Usuário: iara.fonseca\r\nPatrimônio: 096563\r\n\r\nA máquina necessita de um ssd.\r\n',NULL,'V',270,'2026-06-22','16:18:00',NULL,NULL),(278,32,33,NULL,NULL,16,'2026-06-17','16:31:00','C','U',_binary 'Qual o login do usuário? : lindaiane.silva',_binary 'Nova senha redefinida :sabara@2026','V',271,'2026-06-17','17:03:00','2026-06-17','16:34:00'),(279,13,39,NULL,NULL,54,'2026-06-18','13:40:00','C','P',_binary 'Nome do usuário : Kamily Vitoria Zunzarrem Quites\r\nPastas de acesso na rede : P da cultura',_binary 'Login do Usuário:kamily.quites\r\nSenha Inicial :sabara@2026','V',274,'2026-06-18','15:04:00','2026-06-18','14:06:00'),(280,13,39,NULL,NULL,23,'2026-06-18','13:46:00','E','P',_binary 'Patrimonio: 103889\r\n\r\nInstalação do computador do novo servidor lotado na secretaria de cultura, o computador precisa de um cabo rede (longo), estabilizador, cabo de força do computador, extensão. ',NULL,'V',277,'2026-06-22','18:06:00',NULL,NULL),(281,7,48,NULL,NULL,82,'2026-06-18','14:38:00','C','P',_binary 'A servidora Paula Scoralick relatou que há um problema no aúdio do computador dela, o fone não aparece nas configurações de aúdio. ',_binary 'Foi resetado o driver de áudio. o áudio está funcionando.','V',275,'2026-06-18','17:00:00','2026-06-18','15:28:00'),(282,9,27,NULL,NULL,8,'2026-06-18','14:58:00','C','P',_binary 'Usuário :\r\nPatrimonio: 119260\r\n\r\nDescrição do problema: Computador está sem sistema operacional ',_binary 'Observações: Foi instalado o Sistema Operacional, computador segue funcionando normal.','V',276,'2026-06-21','14:59:00','2026-06-18','14:59:00'),(283,35,37,NULL,NULL,77,'2026-06-19','11:00:00','C','U',_binary 'Local: RH\r\nUsuário: aron.silva\r\n\r\nINSTALAÇÃO DO SISTEMA SUPERNOVA COMPUTADOR',_binary 'Sistema instalado com sucesso','V',278,'2026-06-19','11:34:00','2026-06-19','11:42:00'),(284,7,48,NULL,NULL,55,'2026-06-19','11:02:00','C','P',_binary 'Prezados, \r\nA servidora Poliana Martins Ribeiro Leite, voltou de licença hoje e está necessitando do seu usuário e senha de acesso. \r\n\r\nAtenciosamente, \r\nPedro Neves',_binary 'Nova senha do usuário :sabara@2026','V',279,'2026-06-19','12:06:00','2026-06-19','11:41:00'),(285,7,48,NULL,NULL,16,'2026-06-19','11:04:00','C','P',_binary 'Qual o login do usuário? : \r\nA servidora Poliana Martins Ribeiro Leite, necessita da mudança da senha de acesso nos sistemas geral da Supernova, no compras e no orçamento e também necessita de saber o seu usuário.',_binary 'usuario de entrada: poliana.martins\r\nusuario modulos: polianamartins\r\nNova senha redefinida : sabara@2026','V',280,'2026-06-19','11:57:00','2026-06-19','11:37:00'),(286,7,30,NULL,NULL,77,'2026-06-22','09:14:00','C','P',_binary 'Local: Planejamento\r\nUsuário: Poliana ',_binary 'Configuração feita; vistoria das configurações de impressora.','V',281,'2026-06-22','09:12:00','2026-06-22','09:15:00'),(287,32,16,NULL,NULL,36,'2026-06-22','11:14:00','C','P',_binary 'SELB da Impressora :Controladoria\r\n\r\nInstalação de impressora em computador de terceirizado',_binary 'Não foi possível a configuração por não conseguir acessar algum usuário com direitos administrativos. \r\nSolução paliativa: criação de usuário de rede para o colaborador da MAPZER.','V',282,'2026-06-22','13:14:00','2026-06-22','12:40:00'),(288,7,46,NULL,NULL,25,'2026-06-22','14:03:00','C','U',_binary 'Patrimônio : \r\nchecou cabos de energia (sim/não)?',_binary 'Monitou funcionando normalmente após instalação do Cabo de energia','V',283,'2026-06-22','15:07:00','2026-06-22','15:24:00'),(289,7,16,NULL,NULL,38,'2026-06-22','16:23:00','C','P',_binary 'SELB da Impressora :Impressora do Planejamento\r\n\r\nRecipiente de residuos de toner cheio',_binary 'Feito o esvaziamento do recepiente. Impressora funcional','V',285,'2026-06-22','16:45:00','2026-06-22','16:46:00'),(290,7,46,NULL,NULL,25,'2026-06-22','16:42:00','C','U',_binary 'o cabo que foi colocado esta com defeito, a tela esta desligando',_binary 'Mal contato na conexão do cabo. Problema resolvido no computador','V',284,'2026-06-23','16:44:00','2026-06-22','16:48:00'),(291,13,39,NULL,NULL,19,'2026-06-23','09:34:00','C','P',_binary 'Patrimõnio do Computador : 091865\r\nUsuário: kamily.quites\r\n\r\n\r\nComputador apresentação lentidão para qualquer funcionalidade que se tenta fazer nele.',_binary 'Computador foi formatado, mas necessita de um SSD.','V',294,'2026-06-27','09:04:00','2026-06-26','09:54:00'),(292,12,30,NULL,NULL,70,'2026-06-23','12:24:00','E','P',_binary 'Computador Lenovo ThinkCentre M70q, tipo 11DU.\r\nOBS.: aguardando fonte de alimentação específica para ser feita a avaliação do PC',NULL,'V',290,'2026-06-23','16:22:00',NULL,NULL),(293,35,37,NULL,NULL,62,'2026-06-23','14:37:00','C','P',_binary 'Nome do Usuário: beatriz.perdigao\r\nCPF: 152.439.596-00\r\nLocais de Tramitação : RH',_binary 'Login do Usuário :beatriz.perdigao\r\nSenha de Acesso :123456','V',287,'2026-06-23','15:40:00','2026-06-23','15:13:00'),(294,10,49,NULL,NULL,15,'2026-06-23','14:44:00','X','P',_binary 'Nome do usuário :jose da silva\r\nnúmero do CPF :66363636363\r\nModulos que irá acessar (compras, estoque, contabilidade, pregão, credores, frotas, prestação de contas, patrimônio : Estoque\r\n\r\n',NULL,'V',286,'2026-06-23','17:09:00',NULL,NULL),(295,33,32,NULL,NULL,16,'2026-06-23','16:08:00','C','U',_binary 'Qual o login do usuário? :bruno.sette',_binary 'Nova senha redefinida :sabara@2026','V',289,'2026-06-23','16:43:00','2026-06-23','16:14:00'),(296,31,45,NULL,NULL,16,'2026-06-23','16:09:00','C','P',_binary 'Qual o login do usuário? : laila.negreiros',_binary 'Nova senha redefinida :sabara@2026','V',288,'2026-06-23','16:40:00','2026-06-23','16:12:00'),(297,27,22,NULL,NULL,15,'2026-06-24','09:17:00','X','P',_binary 'Nome do usuário :jose da silva\r\nnúmero do CPF :34534552345\r\nModulos que irá acessar (compras, estoque, contabilidade, pregão, credores, frotas, prestação de contas, patrimônio :compras\r\n\r\n\r\n\r\n',NULL,'V',291,'2026-06-24','11:28:00',NULL,NULL),(298,33,49,NULL,NULL,54,'2026-06-24','10:40:00','C','U',_binary 'Nome do usuário : ana luiza saraiva fernandes\r\nPastas de acesso na rede : ds advocacia\r\n\r\ncpf 13573701647',_binary 'Login do Usuário:ana.saraiva\r\nSenha Inicial :sabara@2026','V',292,'2026-06-24','11:41:00','2026-06-24','10:46:00'),(299,33,49,NULL,NULL,54,'2026-06-24','12:47:00','C','U',_binary 'Nome do usuário :Isadora Mirella dos Santos Torres\r\nPastas de acesso na rede :DS Advocacia\r\n\r\nCPF:13738709665',_binary 'Login do Usuário:isadora.torres\r\nSenha Inicial :sabara@2026','V',293,'2026-06-24','15:15:00','2026-06-24','14:16:00'),(300,31,44,NULL,NULL,71,'2026-06-25','10:27:00','C','P',_binary 'Secretaria/Gerencia: Gabinete do Prefeito \r\nUsuário: Camila Ferreira Abel ',_binary 'Entregue para Etelvina. Chip corporativo.','V',296,'2026-06-25','11:30:00','2026-06-26','17:21:00'),(301,27,22,NULL,NULL,20,'2026-06-25','10:37:00','X','P',_binary 'Patrimônio :9595995\r\n\r\n',NULL,'V',295,'2026-06-27','10:52:00',NULL,NULL),(302,15,27,NULL,NULL,19,'2026-06-25','13:02:00','C','P',_binary 'Patrimõnio do Computador : 091864\r\nUsuário:\r\nSão 2 computadores, da regional Roça grande. Um esta com tela preta e o outro está com lentidão.',_binary 'Computadores, estavam com os HDs ruins, os mesmos foram substituídos.','V',297,'2026-06-27','13:02:00','2026-06-26','11:55:00'),(303,7,51,NULL,NULL,35,'2026-06-26','11:33:00','C','P',_binary 'SELB da impressora: 56FN máquina MP601\r\nA impressora está no setor da Sala Mineira, ao escanear utilizando a parte superior (que puxa a folha), o resultado do escaneamento vem com uma lista no meio, assim não conseguimos digitalizar dessa forma que é mais rápida.\r\nPoderia também configurar a máquina para que todas as digitalizações fossem feitas coloridas, sem necessidade de parametrizar (porque no atual está para preto e branco).',_binary 'Manutenção realizad pelo Técnico Eliezer da Selbetti','V',298,'2026-06-29','11:42:00','2026-06-29','19:25:00'),(304,33,49,NULL,NULL,26,'2026-06-26','15:45:00','C','U',_binary 'Patrimônio :\r\nChecou cabos de energia e dados (sim/não)',_binary 'Monitor sem problemas. Problema no office que deverá ser restaurado. Provavelmente incompatibilidades no windows 7 já que não tem mais suporte ou vírus','V',299,'2026-06-26','17:00:00','2026-06-26','16:03:00'),(305,14,30,NULL,NULL,36,'2026-06-26','17:46:00','C','P',_binary 'SELB da Impressora :\r\nImpressora HP m130fw\r\nConfiguração de IP; teste de impressão',_binary 'Instalação de impressora na rede cabeada e na rede sem fio','V',303,'2026-06-30','12:15:00','2026-06-30','10:16:00'),(306,7,46,NULL,NULL,37,'2026-06-29','09:00:00','C','U',_binary 'Nao estou conseguindo imprimir la na impressora do gabinete.',_binary 'Impressora instalada no usuário','V',300,'2026-07-29','12:06:00','2026-06-30','09:20:00'),(307,6,35,NULL,NULL,20,'2026-06-30','09:17:00','C','P',_binary 'Patrimônio :computador nao esta ligando',_binary 'desktop não ligava porque a fonte estava conectada somente na energia e não no desktop','V',301,'2026-07-02','09:17:00','2026-06-30','09:18:00'),(308,6,35,NULL,NULL,63,'2026-06-30','09:22:00','C','P',_binary 'Local: centro adminstrativo\r\nReferência:\r\nContato:\r\n\r\nmudança de local do telefone',_binary 'telefone foi trocado de local','V',302,'2026-06-30','09:22:00','2026-06-30','09:23:00'),(309,6,38,NULL,NULL,63,'2026-06-30','10:43:00','E','P',_binary 'Local: Setor de Patrimônio\r\nReferência: Solicitação de novo aparelho de telefone fixo para atender as demandas do Setor\r\nContato: 1079 ramal\r\n\r\nBruna Góes',NULL,'V',307,'2026-07-06','15:44:00',NULL,NULL),(310,14,30,NULL,NULL,35,'2026-06-30','11:33:00','C','P',_binary 'Impressora HP M130 offline; scanner não funciona.',_binary 'Scaner e impressora ok','V',304,'2026-07-03','11:35:00','2026-07-03','09:05:00'),(311,33,49,NULL,NULL,28,'2026-06-30','14:30:00','C','U',_binary 'Instalação dos Softwares Libre Office e Libre Office Calc, para edição de textos e planilhas.\r\n',_binary 'Deu tudo certo.','V',305,'2026-06-30','16:40:00','2026-06-30','16:16:00'),(312,30,42,NULL,NULL,15,'2026-06-30','14:31:00','C','P',_binary 'Nome do usuário :Alessandra.lima\r\nnúmero do CPF : 033.807.876-20\r\nModulos que irá acessar (compras,contabilidade, credores, prestação de contas, transparência, patrimônio :\r\n\r\n',_binary 'Usuário já possuia acesso. foi configurado para ter acesso a opção de Execução/emenda parlamentar','V',306,'2026-06-30','16:41:00','2026-06-30','15:06:00'),(313,6,37,NULL,NULL,23,'2026-07-01','09:46:00','C','P',_binary 'Transferir um computador da secretaria de governo pra a secretaria de administração.',_binary 'Foi transferido o computador e instalado.','V',308,'2026-07-01','12:16:00','2026-07-01','11:11:00'),(314,9,27,NULL,NULL,23,'2026-07-01','10:40:00','C','P',_binary 'Patrimonio:\r\nLocal: Regional Ana Lucia\r\nNome solicitante: Marisa\r\n\r\n\r\ninstalar computador, aplicativos, impressora.',_binary 'Foi feita a instalação do computador da Alexandra, aplicativos e a instalação da impressora.','V',309,'2026-07-01','12:40:00','2026-07-01','12:00:00'),(315,33,49,NULL,NULL,28,'2026-07-01','10:45:00','C','U',_binary 'Possui Licença(sim/não) ? \r\nDescrição do software a ser instalado:\r\nUrgência para instalar libre office completo para a estagiaria ANA LUIZA. Está sem acesso a qualquer tipo de documento em Word, wordpad ou libre Office. \r\n\r\nAdvocacia Municipal ',_binary 'Foi instalado o aplicativo no computador.','V',310,'2026-07-01','12:51:00','2026-07-01','11:09:00'),(316,29,34,NULL,NULL,36,'2026-07-01','15:18:00','C','P',_binary 'SELB da Impressora : instalar a opção de consguir imprimir  no not de uma colaboradora ',_binary 'Impressora instalada.','V',311,'2026-07-01','17:41:00','2026-07-01','16:00:00'),(317,9,28,NULL,NULL,41,'2026-07-01','16:01:00','C','P',_binary 'Se for impressora colorida, qual a cor to toner ?: Amarelo\r\n',_binary 'Responsável pelo transporte:','V',312,'2026-07-01','16:32:00','2026-07-01','16:03:00'),(318,7,28,NULL,NULL,41,'2026-07-01','16:06:00','C','P',_binary 'Se for impressora colorida, qual a cor to toner ?: Magenta\r\n',_binary 'Responsável pelo transporte:','V',313,'2026-07-01','16:38:00','2026-07-01','17:04:00'),(319,29,34,NULL,NULL,20,'2026-07-01','16:08:00','E','U',_binary 'Patrimônio : 119315',NULL,'V',314,'2026-07-01','17:10:00',NULL,NULL),(320,32,33,NULL,NULL,54,'2026-07-02','09:01:00','C','U',_binary 'Nome do usuário : Rosimeire Rocha\r\nPastas de acesso na rede : cpad (S:)',_binary 'Login do Usuário:rosimeire.rocha\r\nconfiguração do usuário alterado para controladoria e cpad no drive (S). Necessário reiniciar computador','V',315,'2026-07-02','10:03:00','2026-07-02','09:16:00'),(321,31,44,NULL,NULL,65,'2026-07-02','15:46:00','C','P',_binary 'Número Telefone: 36727672\r\nNúmero Ramal: 1055\r\nOutro Telefone fixo ou celular para contato : 36727699 ou 975718723 \r\n\r\nObservação:  O telefone da recepção tem recebido diversas ligações do 156 de Belo Horizonte, gentileza averiguar a situação.  ',_binary 'Ocorrência foi passada para empresa de telefonia (speedNet) que irá tomar as providências técnicas necessárias','V',316,'2026-07-07','09:03:00','2026-07-06','10:52:00'),(322,7,46,NULL,NULL,30,'2026-07-03','09:29:00','E','P',_binary 'o meu esta com defeito',NULL,'V',317,'2026-07-06','09:49:00',NULL,NULL),(323,6,38,NULL,NULL,68,'2026-07-03','10:31:00','C','U',_binary 'Local: Setor de Patrimônio, Computador da colaboradora Fiama\r\n\r\n\r\nA nossa colaboradora está sem acesso à REDE e precisa da mesma para dar continuidade ao trabalho, solicitamos visita técnica com urgência.\r\n\r\nObrigada, Bruna.',_binary 'cabo de rede estava conectado apenas no pc e fora do ponto de rede ','V',318,'2026-07-03','11:06:00','2026-07-03','10:41:00'),(324,33,32,NULL,NULL,70,'2026-07-03','10:50:00','C','P',_binary 'Prezado(a), bom dia!!\r\n\r\nSolicito por gentileza que resete a senha do usuário abaixo para sabara@2026:\r\n\r\nRenata.Ferreira\r\n\r\nAtenciosamente,\r\nBruno Sette Marra\r\n',_binary 'Topico correto usuário de rede / computador e reset de senha . Foi passado para usuário nova senha sabara@2026','V',319,'2026-07-03','11:15:00','2026-07-03','11:16:00'),(325,9,52,NULL,NULL,38,'2026-07-06','07:26:00','C','U',_binary 'SELB da Impressora :bom dia aqui marco Antônio não estou conseguindo imprimir a caixa de impressão encontra a impressora, obrigado peço também criar um email so para abrir chamada, que pode ser manutensão_semob.mg.gov.br',_binary 'Impressora instalado e dados do novo e-mail repassados. Intalação da impressora feita pelo Jonathan do desenvolvimento social','V',324,'2026-07-06','17:00:00','2026-07-06','14:21:00'),(326,35,37,NULL,NULL,54,'2026-07-06','08:35:00','C','P',_binary 'Nome do usuário : Fabio Jesuita Magalhães - cpf: 871.705.826-00\r\nPastas de acesso na rede : acesso a rede do RH',_binary 'Login do Usuário:fabio.jesuita\r\nSenha Inicial :sabara@2026','V',320,'2026-07-06','09:48:00','2026-07-06','08:52:00'),(327,35,37,NULL,NULL,74,'2026-07-06','08:35:00','C','U',_binary 'Acesso ao Sistema Supernova para folha de pagamento',_binary 'usuário não foi informado. Abrir como criação de usuário para esse tipo de ocorrência. Como o usuário já possui acesso ao supernova\r\npedir ao Sr. Nilo a criação de usuário no módulo de RH','V',321,'2026-07-06','10:22:00','2026-07-06','09:30:00'),(328,6,27,NULL,NULL,35,'2026-07-06','09:44:00','C','P',_binary 'SELB da impressora\r\n\r\nInstalar scanner na impressora.',_binary 'Foi instalado o scanner, no computador do Leandro.','V',322,'2026-07-09','09:45:00','2026-07-06','09:45:00'),(329,29,34,NULL,NULL,15,'2026-07-06','10:01:00','C','P',_binary 'Nome do usuário :Douglas Roberto Martins, matrícula 7311, \r\nnúmero do CPF : CPF 051.352.376-66.\r\nModulos que irá acessar (compras, orçamentário.)\r\npatrimônio : 118309\r\n\r\n\r\n',_binary 'Usuário de Acesso :douglas.martins\r\nSenha de Acesso :sabara@2026\r\n\r\nUsuário do(s) módulo(s) :douglas.martins\r\nSenha do(s) módulo(s) :sabara@2026','V',323,'2026-07-06','12:16:00','2026-07-06','10:40:00'),(330,35,35,NULL,NULL,77,'2026-07-06','11:22:00','C','P',_binary 'Local: setor de rh\r\nUsuário:fabio.jesuita',_binary 'aplicativo instalado ','V',325,'2026-07-06','11:52:00','2026-07-06','11:23:00'),(331,30,42,NULL,NULL,67,'2026-07-06','11:43:00','C','P',_binary 'Login do Usuário :Alessandralima\r\nNovos locais de tramitação: Secretaria Municipal de segurança Publica\r\nExcluir locais anteriores (sim/Não) : sim',_binary 'Novos locais COORDENAÇÃO DE APOIO A SEGURANÇA PUBLICA	CDFSA e GERENCIA DE SEGURANÇA GDFS foram incluidos ao perfil do usuário e anteriores excluido no sistema de protocoloWEB','V',326,'2026-07-06','12:34:00','2026-07-06','12:05:00'),(332,32,33,NULL,NULL,51,'2026-07-06','14:47:00','C','U',_binary 'Local :Sala do Controlador Samuel\r\nA rede parou',_binary 'Foi reiniciado o adaptador de internet.','V',327,'2026-07-06','15:51:00','2026-07-06','15:11:00'),(333,8,47,NULL,NULL,8,'2026-07-07','08:58:00','C','U',_binary 'Usuário : Luciene Firmo\r\nPatrimonio:0833332\r\n\r\nDescrição do problema: Erro ao salvar relatório de conciliação bancária.',_binary 'Na verdade estava com um erro no sistema de Supernova quando na emissão de arquivo PDF. Informamos o novo procedimento para execução bem como instalado programa Foxit Reader. Testes ok','V',328,'2026-07-07','09:08:00','2026-07-07','09:48:00'),(334,12,40,NULL,NULL,55,'2026-07-07','14:36:00','E','P',_binary 'Nome do usuário : Raylane Vitoria de Souza Fernandes\r\nLogin do usuário : raylane.vitoria\r\n\r\nObs: Servidora questiona que o login fornecido no dia 01 de Julho não lhe da acesso a maquina na qual esta trabalhando. Situação comprovada pela gerência imediata. Conseguem nos ajudar? Desde já muito grato.',NULL,'V',329,'2026-07-08','16:21:00',NULL,NULL),(335,29,34,NULL,NULL,54,'2026-07-08','09:02:00','C','P',_binary 'Nome do usuário : laura.lima\r\nPastas de acesso na rede : DFCIVIL',_binary 'Login do Usuário:laura.lima\r\nSenha Inicial :sabara@2026','V',330,'2026-07-08','10:15:00','2026-07-08','09:33:00'),(336,35,37,NULL,NULL,67,'2026-07-08','11:27:00','C','P',_binary 'Login do Usuário : fabio.magalhaes\r\n\r\nNovos locais de tramitação: RH\r\n\r\nExcluir locais anteriores (sim/Não) :\r\n\r\nAdicionar a este usuário a possibilidade de aceitar e tramitar processos do RH\r\n\r\n\r\n\r\n',_binary 'Local de tramitação alterado para secretaria de Recursos Humanos','V',331,'2026-07-08','11:58:00','2026-07-08','11:31:00'),(337,33,49,NULL,NULL,52,'2026-07-08','11:35:00','E','P',_binary 'Antivírus expirou e computador está notificando que foram encontrados 7 vírus. Computador travado, a servidora não consegue ne, fechar a tela.',NULL,'V',332,'2026-07-08','13:37:00',NULL,NULL),(338,28,16,NULL,NULL,41,'2026-07-08','11:57:00','C','P',_binary 'Se for impressora colorida, qual a cor to toner ?:Não\r\nSELB da Impressora :im430 CEI',_binary 'Responsável pelo transporte:Iana funcionária da CEI','V',333,'2026-07-08','12:27:00','2026-07-08','11:58:00');
/*!40000 ALTER TABLE `solicitacao` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `temp_custos`
--

DROP TABLE IF EXISTS `temp_custos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `temp_custos` (
  `id` int NOT NULL AUTO_INCREMENT,
  `valor_material` double DEFAULT NULL,
  `valor_servico` double DEFAULT NULL,
  `valor_total` double DEFAULT NULL,
  `descricao` varchar(120) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `temp_custos`
--

LOCK TABLES `temp_custos` WRITE;
/*!40000 ALTER TABLE `temp_custos` DISABLE KEYS */;
/*!40000 ALTER TABLE `temp_custos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `temp_horas`
--

DROP TABLE IF EXISTS `temp_horas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `temp_horas` (
  `id` int NOT NULL AUTO_INCREMENT,
  `horas` int DEFAULT NULL,
  `minutos` int DEFAULT NULL,
  `executor` varchar(150) DEFAULT NULL,
  `tempo_grafico` double DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=153 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `temp_horas`
--

LOCK TABLES `temp_horas` WRITE;
/*!40000 ALTER TABLE `temp_horas` DISABLE KEYS */;
INSERT INTO `temp_horas` VALUES (148,225,0,'Edilson Fernandes da Cruz',225),(149,18,60,'Glaison Queiroz',19),(150,31,30,'Jedean Moisés do Carmo',31.5),(151,145,30,'Jerônimo Mayer dos Santos',145.5),(152,106,60,'Lucio Machado',107);
/*!40000 ALTER TABLE `temp_horas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tempo_horas_mes`
--

DROP TABLE IF EXISTS `tempo_horas_mes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tempo_horas_mes` (
  `id` int NOT NULL AUTO_INCREMENT,
  `horas` int DEFAULT NULL,
  `minutos` int DEFAULT NULL,
  `mes` int DEFAULT NULL,
  `tempo_grafico` double DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tempo_horas_mes`
--

LOCK TABLES `tempo_horas_mes` WRITE;
/*!40000 ALTER TABLE `tempo_horas_mes` DISABLE KEYS */;
INSERT INTO `tempo_horas_mes` VALUES (20,18,60,3,19),(21,21,60,4,22),(22,13,25,5,13.416666666667),(23,13,60,6,14);
/*!40000 ALTER TABLE `tempo_horas_mes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tipo_ocorrencia`
--

DROP TABLE IF EXISTS `tipo_ocorrencia`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tipo_ocorrencia` (
  `id` int NOT NULL AUTO_INCREMENT,
  `descricao` varchar(150) DEFAULT NULL,
  `tipo` char(1) DEFAULT NULL,
  KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tipo_ocorrencia`
--

LOCK TABLES `tipo_ocorrencia` WRITE;
/*!40000 ALTER TABLE `tipo_ocorrencia` DISABLE KEYS */;
INSERT INTO `tipo_ocorrencia` VALUES (1,'Impressoras e scanners','0'),(2,'Computadores',NULL),(3,'Rede - Conectividade',NULL),(5,'e-mail corporativo',NULL),(6,'Câmeras',NULL),(7,'Internet',NULL),(8,'Rede wi-fi',NULL),(9,'software',NULL),(10,'Sistema Moderna (supernova)',NULL),(11,'Monitor',NULL),(12,'Mouse',NULL),(13,'Teclado',NULL),(14,'Acesso de usuários de Rede / Computador',NULL),(15,'Plantão de Suporte de TI',NULL),(16,'Projetores',NULL),(17,'Protocolo WEB',NULL),(18,'Telefonia',NULL),(19,'Outros',NULL),(20,'Telefonia Movel',NULL),(21,'Backup de Arquivos e pastas de rede',NULL);
/*!40000 ALTER TABLE `tipo_ocorrencia` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tipos`
--

DROP TABLE IF EXISTS `tipos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tipos` (
  `id` int NOT NULL AUTO_INCREMENT,
  `descricao` varchar(150) DEFAULT NULL,
  `classe` varchar(70) DEFAULT NULL,
  `horas_operacao` int DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tipos`
--

LOCK TABLES `tipos` WRITE;
/*!40000 ALTER TABLE `tipos` DISABLE KEYS */;
INSERT INTO `tipos` VALUES (1,'Apoios','Infra Estrutura',3000),(2,'Aquecimento','Clinico',400),(4,'Computadores Pessoais (pc)','Operacional',2000),(5,'Equipamento Médicos','Clinico',1396);
/*!40000 ALTER TABLE `tipos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `unidades`
--

DROP TABLE IF EXISTS `unidades`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `unidades` (
  `id` int NOT NULL AUTO_INCREMENT,
  `descricao` varchar(120) NOT NULL DEFAULT '0',
  `abreviatura` varchar(6) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `unidades`
--

LOCK TABLES `unidades` WRITE;
/*!40000 ALTER TABLE `unidades` DISABLE KEYS */;
INSERT INTO `unidades` VALUES (1,'Metro Quadrado','M2'),(2,'Centímetro','cm'),(3,'Kilo','KG'),(4,'Hora','H'),(5,'Litro','LT'),(8,'Unidade','UN'),(9,'Metro Cúbico','M3'),(10,'Metro','m'),(11,'kilowatts','Kw'),(12,'Quilowatt-hora (kWh)','KWh');
/*!40000 ALTER TABLE `unidades` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usuarios`
--

DROP TABLE IF EXISTS `usuarios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `usuarios` (
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
) ENGINE=InnoDB AUTO_INCREMENT=53 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuarios`
--

LOCK TABLES `usuarios` WRITE;
/*!40000 ALTER TABLE `usuarios` DISABLE KEYS */;
INSERT INTO `usuarios` VALUES (16,1,NULL,'Glaison Queiroz','Glaison','dGFpb2JhQDMxNjMxOA==','S','695.510.226-53','Administrador','glaison26.queiroz@gmail.com'),(22,1,27,'Solicitante','Solicitante','c2FiYXJhQDIwMjY=','S','69551022653','Solicitante','glaison26.queiroz@gmail.com'),(25,2,NULL,'Informatica','informatica','U2FiYXJhQDIwMjY=','S','69551022653','Operador','suporte@sabara.mg.gov.br'),(26,1,NULL,'Jerônimo Mayer dos Santos','jeronimo.mayer','SjI0MTcwMCM=','S','79017711604','Operador','manutencao@sabara.mg.gov.br'),(27,1,NULL,'Edilson Fernandes da Cruz','edilson.fernandes','RWQmbHNvbjE4MDE4Ng==','S','07364181644','Operador','manutencao@sabara.mg.gov.br'),(28,1,NULL,'Jedean Moisés do Carmo','Jedean','TnVtZXJvMDU4Lg==','S','04071055650','Operador','jedean@sabara.mg.gov.br'),(29,1,NULL,'Wellington Alves Jardim da Silva','wellington.jardim','UmFmYWVsYS41OA==','S','95752560691','Administrador','wellington@sabara.mg.gov.br'),(30,1,NULL,'Lucio Machado','lucio.machado','cm9nZXBvMWNA','S','03153248648','Operador','manutencao@sabara.mg.gov.br'),(31,1,NULL,'Flavio Maielo','flavio.maielo','ZmxhdmlvQDIwMjY=','S','69551022653','Operador','suporte@sabara.mg.gov.br'),(32,1,33,'Juridico','Juridico','anVyaWRpY29AMjAyNg==','S','69551022653','Solicitante','proju@sabara.mg.gov.br'),(33,1,32,'Controladoria','Controladoria','Y29udHJvbGFkb3JpYUAyMDI2','S','69551022653','Solicitante','controladoriageral@sabara.mg.gov.br'),(34,1,29,'Defesa Civil','defesacivil','ZGVmZXNhQDIwMjY=','S','69551022653','Solicitante','defesacivil@sabara.mg.gov.br'),(35,1,27,'Ruan Pablo Alves do Espirito Santo','ruan.pablo','c2FiYXJhQDIwMjU=','S','69551022653','Operador','manutencao@sabara.mg.gov.br'),(36,1,7,'Convidado','Convidado','Y29udmlkYWRvQDIwMjY=','S','69551022653','Operador','glaison26.queiroz@gmail.com'),(37,1,35,'Recursos Humanos','rh','cmhAc2FiYXJhMjAyNg==','S','69551022653','Solicitante','rh@sabara.mg.gov.br'),(38,1,6,'Administração','Administracao','YWRtaW5pc3RyYWNhb0AyMDI2','S','69551022653','Solicitante','secretaria.administracao@sabara.mg.gov.br'),(39,1,13,'Secretaria de Cultura','Cultura','Y3VsdHVyYUAyMDI2','S','69551022653','Solicitante','cultura@sabara.mg.gov.br'),(40,1,12,'Secretaria Municipal de Turismo','turismo','c2FiYXJhQDIwMjY=','S','69551022653','Solicitante','turismo@sabara.mg.gov.br'),(41,1,30,'Secretaria de Segurança Logistica','seguranca.logistica','c2FiYXJhQDIwMjY=','S','69551022653','Solicitante','secaotilogisticaepessoalgcm@sabara.mg.gov.br'),(42,1,30,'Segurança Pública fundos','seguranca.fundos','c2FiYXJhQDIwMjY=','S','69551022653','Solicitante','fundo.ssp@sabara.mg.gov.br'),(43,1,36,'Tributos ISS','iss.sabara','c3Vwb3J0ZWlzc0AyMDI2','S','69551022653','Solicitante','issonline@sabara.mg.gov.br'),(44,1,31,'Gabinete da Prefeitura','gabinete','c2FiYXJhQDIwMjY=','S','69551022653','Solicitante','gabinete@sabara.mg.gov.br'),(45,1,31,'Laila Soares','laila.soares','c2FiYXJhQDIwMjY=','S','69551022653','Solicitante','governo@sabara.mg.gov.br'),(46,1,7,'Projetos Semob','projetos','c2FiYXJhQDIwMjY=','S','69551022653','Solicitante','semob_projetos@sabara.mg.gov.br'),(47,1,8,'Tesouraria Secretaria de Fazenda','tesouraria','c2FiYXJhQDIwMjY=','S','69551022653','Solicitante','tesouraria@sabara.mg.gov.br'),(48,1,7,'Secretaria de Planejamento','planejamento','c2FiYXJhQDIwMjY=','S','69551022653','Solicitante','planejamento@sabara.mg.gov.br'),(49,1,33,'Advocacia Municipal','advocacia','YWR2b2NhY2lhQDIwMjY=','S','69551022653','Solicitante','advocaciamunicipal@sabara.mg.gov.br'),(50,1,27,'Pedro Reis','pedro.reis','c2FiYXJhQDIwMjY=','S','69551022653','Operador','manutencao@sabara.mg.gov.br'),(51,1,7,'Rede Sim','redesim','c2FiYXJhQDIwMjY=','S','69551022653','Solicitante','redesim.sabara@sabara.mg.gov.br'),(52,1,9,'Obras Públicas','obras','c2FiYXJhQDIwMjY=','S','69551022653','Solicitante','manutencao_semob@sabara.mg.gov.br');
/*!40000 ALTER TABLE `usuarios` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-07-08 12:36:53
