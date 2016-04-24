-- MySQL dump 10.13  Distrib 5.7.10, for Win32 (AMD64)
--
-- Host: localhost    Database: logersstest
-- ------------------------------------------------------
-- Server version	5.7.10-log

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `lo_notice`
--

DROP TABLE IF EXISTS `lo_notice`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lo_notice` (
  `TITLE` varchar(100) COLLATE utf8_bin DEFAULT NULL,
  `CONTENT` varchar(500) COLLATE utf8_bin DEFAULT NULL,
  `READ_CNT` int(11) DEFAULT NULL,
  `WRITER` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `WRITE_DATE` date DEFAULT NULL,
  `MODIFY_DATE` date DEFAULT NULL,
  `DELETE_YN` varchar(1) COLLATE utf8_bin DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lo_notice`
--

LOCK TABLES `lo_notice` WRITE;
/*!40000 ALTER TABLE `lo_notice` DISABLE KEYS */;
INSERT INTO `lo_notice` VALUES ('A','AC',1,'f',NULL,NULL,'N'),('B','BC',3,'김현하',NULL,NULL,'N');
/*!40000 ALTER TABLE `lo_notice` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lo_role_info`
--

DROP TABLE IF EXISTS `lo_role_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lo_role_info` (
  `ROLE_SEQ` int(11) NOT NULL AUTO_INCREMENT,
  `ROLE_NAME` varchar(100) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`ROLE_SEQ`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lo_role_info`
--

LOCK TABLES `lo_role_info` WRITE;
/*!40000 ALTER TABLE `lo_role_info` DISABLE KEYS */;
INSERT INTO `lo_role_info` VALUES (1,'normal');
/*!40000 ALTER TABLE `lo_role_info` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lo_user_info`
--

DROP TABLE IF EXISTS `lo_user_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lo_user_info` (
  `NAME` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `EMAIL` varchar(100) COLLATE utf8_bin NOT NULL,
  `PASSWORD` varchar(500) COLLATE utf8_bin DEFAULT NULL,
  `ROLE_BASE_SEQ` int(11) DEFAULT NULL,
  PRIMARY KEY (`EMAIL`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lo_user_info`
--

LOCK TABLES `lo_user_info` WRITE;
/*!40000 ALTER TABLE `lo_user_info` DISABLE KEYS */;
INSERT INTO `lo_user_info` VALUES ('a','a','a',1);
/*!40000 ALTER TABLE `lo_user_info` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `test`
--

DROP TABLE IF EXISTS `test`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `test` (
  `A` varchar(44) COLLATE utf8_bin DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `test`
--

LOCK TABLES `test` WRITE;
/*!40000 ALTER TABLE `test` DISABLE KEYS */;
INSERT INTO `test` VALUES ('gg'),('zz');
/*!40000 ALTER TABLE `test` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2015-12-29  9:03:09
