-- MySQL dump 10.13  Distrib 8.0.42, for Linux (aarch64)
--
-- Host: localhost    Database: utilities_turkey
-- ------------------------------------------------------
-- Server version	8.0.42

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
-- Table structure for table `electricity_tariffs`
--

DROP TABLE IF EXISTS `electricity_tariffs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `electricity_tariffs` (
  `id` int NOT NULL AUTO_INCREMENT,
  `tariff_type` enum('single_time','three_time') COLLATE utf8mb4_unicode_ci NOT NULL,
  `time_period` enum('day','peak','night','single') COLLATE utf8mb4_unicode_ci NOT NULL,
  `consumption_threshold` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'e.g., above_8kwh_per_day, below_8kwh_per_day',
  `price_per_kwh` decimal(10,6) NOT NULL,
  `currency` varchar(3) COLLATE utf8mb4_unicode_ci DEFAULT 'TRY',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_tariff_type` (`tariff_type`),
  KEY `idx_consumption` (`consumption_threshold`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `electricity_tariffs`
--

LOCK TABLES `electricity_tariffs` WRITE;
/*!40000 ALTER TABLE `electricity_tariffs` DISABLE KEYS */;
INSERT INTO `electricity_tariffs` VALUES (1,'single_time','single','above_8kwh_per_day',3.451626,'TRY','2025-06-03 10:33:41','2025-06-03 10:33:41');
/*!40000 ALTER TABLE `electricity_tariffs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `electricity_usage_examples`
--

DROP TABLE IF EXISTS `electricity_usage_examples`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `electricity_usage_examples` (
  `id` int NOT NULL AUTO_INCREMENT,
  `consumption_kwh` int NOT NULL,
  `tariff_type` enum('single_time','three_time') COLLATE utf8mb4_unicode_ci NOT NULL,
  `calculated_amount` decimal(10,2) NOT NULL,
  `currency` varchar(3) COLLATE utf8mb4_unicode_ci DEFAULT 'TRY',
  `calculation_notes` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_consumption` (`consumption_kwh`),
  KEY `idx_tariff` (`tariff_type`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `electricity_usage_examples`
--

LOCK TABLES `electricity_usage_examples` WRITE;
/*!40000 ALTER TABLE `electricity_usage_examples` DISABLE KEYS */;
INSERT INTO `electricity_usage_examples` VALUES (1,416,'single_time',1435.87,'TRY','416 kWh * 3.451626 TL/kWh = 1435.87 TL (for above 8 kWh/day residential usage)','2025-06-03 10:33:41','2025-06-03 10:33:41');
/*!40000 ALTER TABLE `electricity_usage_examples` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `internet_packages`
--

DROP TABLE IF EXISTS `internet_packages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `internet_packages` (
  `id` int NOT NULL AUTO_INCREMENT,
  `provider_id` int NOT NULL,
  `package_name` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `speed_mbps` int NOT NULL,
  `monthly_price` decimal(10,2) NOT NULL,
  `currency` varchar(3) COLLATE utf8mb4_unicode_ci DEFAULT 'TRY',
  `contract_required` tinyint(1) DEFAULT '0',
  `contract_months` int DEFAULT '0',
  `promotional_price` decimal(10,2) DEFAULT NULL,
  `promotional_months` int DEFAULT '0',
  `features` text COLLATE utf8mb4_unicode_ci COMMENT 'Special features or notes',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_speed` (`speed_mbps`),
  KEY `idx_price` (`monthly_price`),
  KEY `idx_provider_speed` (`provider_id`,`speed_mbps`),
  CONSTRAINT `internet_packages_ibfk_1` FOREIGN KEY (`provider_id`) REFERENCES `internet_providers` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `internet_packages`
--

LOCK TABLES `internet_packages` WRITE;
/*!40000 ALTER TABLE `internet_packages` DISABLE KEYS */;
INSERT INTO `internet_packages` VALUES (1,1,'Özgür İletişim GigaFiber',1000,499.90,'TRY',0,0,NULL,0,'Sınırsız internet, taahhütsüz kullanım, yüksek hız','2025-06-03 10:33:41','2025-06-03 10:33:41'),(2,2,'100 Mbps Fiber',100,199.90,'TRY',1,0,99.95,3,'Yeni müşterilere özel ilk 3 ay %50 indirim','2025-06-03 10:33:41','2025-06-03 10:33:41'),(3,2,'200 Mbps Fiber',200,249.90,'TRY',1,0,124.95,3,'Yeni müşterilere özel ilk 3 ay %50 indirim','2025-06-03 10:33:41','2025-06-03 10:33:41'),(4,2,'500 Mbps Fiber',500,349.90,'TRY',1,0,174.95,3,'Yeni müşterilere özel ilk 3 ay %50 indirim','2025-06-03 10:33:41','2025-06-03 10:33:41'),(5,2,'1000 Mbps Fiber',1000,499.90,'TRY',1,0,249.95,3,'Yeni müşterilere özel ilk 3 ay %50 indirim','2025-06-03 10:33:41','2025-06-03 10:33:41'),(6,3,'16 Mbps Package',16,600.00,'TRY',1,0,NULL,0,'12 ay taahhütlü, sabit fiyat garantisi','2025-06-03 10:33:41','2025-06-03 10:33:41'),(7,3,'24 Mbps Package',24,600.00,'TRY',1,0,NULL,0,'12 ay taahhütlü, sabit fiyat garantisi','2025-06-03 10:33:41','2025-06-03 10:33:41'),(8,3,'50 Mbps Package',50,630.00,'TRY',1,0,NULL,0,'12 ay taahhütlü, sabit fiyat garantisi','2025-06-03 10:33:41','2025-06-03 10:33:41'),(9,3,'100 Mbps Package',100,650.00,'TRY',1,0,NULL,0,'12 ay taahhütlü, sabit fiyat garantisi','2025-06-03 10:33:41','2025-06-03 10:33:41'),(10,3,'200 Mbps Package',200,770.00,'TRY',1,0,NULL,0,'12 ay taahhütlü, sabit fiyat garantisi','2025-06-03 10:33:41','2025-06-03 10:33:41'),(11,3,'500 Mbps Package',500,880.00,'TRY',1,0,NULL,0,'12 ay taahhütlü, sabit fiyat garantisi','2025-06-03 10:33:41','2025-06-03 10:33:41'),(12,3,'1000 Mbps Package',1000,935.00,'TRY',1,0,NULL,0,'12 ay taahhütlü, sabit fiyat garantisi','2025-06-03 10:33:41','2025-06-03 10:33:41'),(13,4,'200 Mbps Fiber',200,659.00,'TRY',1,0,NULL,0,'12 ay sabit fiyat garantisi, modem ve kurulum dahil','2025-06-03 10:33:41','2025-06-03 10:33:41'),(14,4,'1000 Mbps Fiber',1000,959.00,'TRY',1,0,NULL,0,'12 ay sabit fiyat garantisi, modem ve kurulum dahil','2025-06-03 10:33:41','2025-06-03 10:33:41'),(15,5,'100 Mbps Fiber (Taahhütsüz)',100,449.00,'TRY',0,0,249.00,3,'İlk 3 ay indirimli','2025-06-03 10:33:41','2025-06-03 10:33:41'),(16,5,'1000 Mbps Fiber (Taahhütsüz)',1000,899.00,'TRY',0,0,699.00,3,'İlk 3 ay indirimli','2025-06-03 10:33:41','2025-06-03 10:33:41'),(17,5,'100 Mbps Fiber (Taahhütlü)',100,499.00,'TRY',1,0,349.00,3,'İlk 3 ay indirimli, sonraki 6 ay sabit fiyat','2025-06-03 10:33:41','2025-06-03 10:33:41');
/*!40000 ALTER TABLE `internet_packages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `internet_providers`
--

DROP TABLE IF EXISTS `internet_providers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `internet_providers` (
  `id` int NOT NULL AUTO_INCREMENT,
  `provider_name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `provider_type` enum('fiber','adsl','vdsl','cable') COLLATE utf8mb4_unicode_ci DEFAULT 'fiber',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_provider` (`provider_name`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `internet_providers`
--

LOCK TABLES `internet_providers` WRITE;
/*!40000 ALTER TABLE `internet_providers` DISABLE KEYS */;
INSERT INTO `internet_providers` VALUES (1,'TurkNet','fiber','2025-06-03 10:33:41','2025-06-03 10:33:41'),(2,'Turkcell Superonline','fiber','2025-06-03 10:33:41','2025-06-03 10:33:41'),(3,'Türk Telekom','fiber','2025-06-03 10:33:41','2025-06-03 10:33:41'),(4,'Vodafone','fiber','2025-06-03 10:33:41','2025-06-03 10:33:41'),(5,'Teknosanet','fiber','2025-06-03 10:33:41','2025-06-03 10:33:41'),(6,'Türksat Kablo','cable','2025-06-03 10:33:41','2025-06-03 10:33:41'),(7,'Netspeed','fiber','2025-06-03 10:33:41','2025-06-03 10:33:41'),(8,'Millenicom','fiber','2025-06-03 10:33:41','2025-06-03 10:33:41');
/*!40000 ALTER TABLE `internet_providers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `internet_speed_stats`
--

DROP TABLE IF EXISTS `internet_speed_stats`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `internet_speed_stats` (
  `id` int NOT NULL AUTO_INCREMENT,
  `provider_id` int NOT NULL,
  `average_speed_mbps` decimal(10,1) NOT NULL,
  `test_period` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'e.g., August 2024',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_provider_period` (`provider_id`,`test_period`),
  CONSTRAINT `internet_speed_stats_ibfk_1` FOREIGN KEY (`provider_id`) REFERENCES `internet_providers` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `internet_speed_stats`
--

LOCK TABLES `internet_speed_stats` WRITE;
/*!40000 ALTER TABLE `internet_speed_stats` DISABLE KEYS */;
INSERT INTO `internet_speed_stats` VALUES (1,1,69.5,'August 2024','2025-06-03 10:33:41','2025-06-03 10:33:41'),(2,2,44.4,'August 2024','2025-06-03 10:33:41','2025-06-03 10:33:41'),(3,6,43.3,'August 2024','2025-06-03 10:33:41','2025-06-03 10:33:41'),(4,7,39.2,'August 2024','2025-06-03 10:33:41','2025-06-03 10:33:41'),(5,8,35.9,'August 2024','2025-06-03 10:33:41','2025-06-03 10:33:41'),(6,3,30.9,'August 2024','2025-06-03 10:33:41','2025-06-03 10:33:41'),(7,4,29.4,'August 2024','2025-06-03 10:33:41','2025-06-03 10:33:41');
/*!40000 ALTER TABLE `internet_speed_stats` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `natural_gas_tariffs`
--

DROP TABLE IF EXISTS `natural_gas_tariffs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `natural_gas_tariffs` (
  `id` int NOT NULL AUTO_INCREMENT,
  `city_name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `price_per_m3` decimal(10,2) DEFAULT NULL COMMENT 'NULL means service not available',
  `currency` varchar(3) COLLATE utf8mb4_unicode_ci DEFAULT 'TRY',
  `notes` text COLLATE utf8mb4_unicode_ci COMMENT 'Additional notes about pricing or availability',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_city` (`city_name`),
  KEY `idx_price` (`price_per_m3`)
) ENGINE=InnoDB AUTO_INCREMENT=82 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `natural_gas_tariffs`
--

LOCK TABLES `natural_gas_tariffs` WRITE;
/*!40000 ALTER TABLE `natural_gas_tariffs` DISABLE KEYS */;
INSERT INTO `natural_gas_tariffs` VALUES (1,'Adana',10.73,'TRY',NULL,'2025-06-03 10:33:41','2025-06-03 10:33:41'),(2,'Adıyaman',4.18,'TRY',NULL,'2025-06-03 10:33:41','2025-06-03 10:33:41'),(3,'Afyonkarahisar',9.14,'TRY',NULL,'2025-06-03 10:33:41','2025-06-03 10:33:41'),(4,'Ağrı',10.38,'TRY',NULL,'2025-06-03 10:33:41','2025-06-03 10:33:41'),(5,'Aksaray',8.97,'TRY',NULL,'2025-06-03 10:33:41','2025-06-03 10:33:41'),(6,'Amasya',7.98,'TRY',NULL,'2025-06-03 10:33:41','2025-06-03 10:33:41'),(7,'Ankara',8.29,'TRY',NULL,'2025-06-03 10:33:41','2025-06-03 10:33:41'),(8,'Antalya',10.17,'TRY',NULL,'2025-06-03 10:33:41','2025-06-03 10:33:41'),(9,'Ardahan',NULL,'TRY',NULL,'2025-06-03 10:33:41','2025-06-03 10:33:41'),(10,'Artvin',7.69,'TRY',NULL,'2025-06-03 10:33:41','2025-06-03 10:33:41'),(11,'Aydın',9.12,'TRY',NULL,'2025-06-03 10:33:41','2025-06-03 10:33:41'),(12,'Balıkesir',8.67,'TRY',NULL,'2025-06-03 10:33:41','2025-06-03 10:33:41'),(13,'Bartın',7.00,'TRY',NULL,'2025-06-03 10:33:41','2025-06-03 10:33:41'),(14,'Batman',7.82,'TRY',NULL,'2025-06-03 10:33:41','2025-06-03 10:33:41'),(15,'Bayburt',NULL,'TRY',NULL,'2025-06-03 10:33:41','2025-06-03 10:33:41'),(16,'Bilecik',7.98,'TRY',NULL,'2025-06-03 10:33:41','2025-06-03 10:33:41'),(17,'Bingöl',7.98,'TRY',NULL,'2025-06-03 10:33:41','2025-06-03 10:33:41'),(18,'Bitlis',NULL,'TRY',NULL,'2025-06-03 10:33:41','2025-06-03 10:33:41'),(19,'Bolu',NULL,'TRY',NULL,'2025-06-03 10:33:41','2025-06-03 10:33:41'),(20,'Burdur',NULL,'TRY',NULL,'2025-06-03 10:33:41','2025-06-03 10:33:41'),(21,'Bursa',7.50,'TRY',NULL,'2025-06-03 10:33:41','2025-06-03 10:33:41'),(22,'Çanakkale',8.95,'TRY',NULL,'2025-06-03 10:33:41','2025-06-03 10:33:41'),(23,'Çankırı',8.50,'TRY',NULL,'2025-06-03 10:33:41','2025-06-03 10:33:41'),(24,'Çorum',8.41,'TRY',NULL,'2025-06-03 10:33:41','2025-06-03 10:33:41'),(25,'Denizli',8.19,'TRY',NULL,'2025-06-03 10:33:41','2025-06-03 10:33:41'),(26,'Diyarbakır',9.30,'TRY',NULL,'2025-06-03 10:33:41','2025-06-03 10:33:41'),(27,'Düzce',7.61,'TRY',NULL,'2025-06-03 10:33:41','2025-06-03 10:33:41'),(28,'Edirne',9.64,'TRY',NULL,'2025-06-03 10:33:41','2025-06-03 10:33:41'),(29,'Elazığ',7.39,'TRY',NULL,'2025-06-03 10:33:41','2025-06-03 10:33:41'),(30,'Erzincan',8.82,'TRY',NULL,'2025-06-03 10:33:41','2025-06-03 10:33:41'),(31,'Erzurum',11.85,'TRY',NULL,'2025-06-03 10:33:41','2025-06-03 10:33:41'),(32,'Eskişehir',7.97,'TRY',NULL,'2025-06-03 10:33:41','2025-06-03 10:33:41'),(33,'Gaziantep',8.51,'TRY',NULL,'2025-06-03 10:33:41','2025-06-03 10:33:41'),(34,'Giresun',8.69,'TRY',NULL,'2025-06-03 10:33:41','2025-06-03 10:33:41'),(35,'Gümüşhane',8.66,'TRY',NULL,'2025-06-03 10:33:41','2025-06-03 10:33:41'),(36,'Hakkâri',6.03,'TRY',NULL,'2025-06-03 10:33:41','2025-06-03 10:33:41'),(37,'Hatay',NULL,'TRY',NULL,'2025-06-03 10:33:41','2025-06-03 10:33:41'),(38,'Iğdır',NULL,'TRY',NULL,'2025-06-03 10:33:41','2025-06-03 10:33:41'),(39,'Isparta',NULL,'TRY',NULL,'2025-06-03 10:33:41','2025-06-03 10:33:41'),(40,'İstanbul',7.57,'TRY',NULL,'2025-06-03 10:33:41','2025-06-03 10:33:41'),(41,'İzmir',8.95,'TRY',NULL,'2025-06-03 10:33:41','2025-06-03 10:33:41'),(42,'Kahramanmaraş',NULL,'TRY',NULL,'2025-06-03 10:33:41','2025-06-03 10:33:41'),(43,'Karabük',8.50,'TRY',NULL,'2025-06-03 10:33:41','2025-06-03 10:33:41'),(44,'Karaman',8.45,'TRY',NULL,'2025-06-03 10:33:41','2025-06-03 10:33:41'),(45,'Kars',NULL,'TRY',NULL,'2025-06-03 10:33:41','2025-06-03 10:33:41'),(46,'Kastamonu',8.50,'TRY',NULL,'2025-06-03 10:33:41','2025-06-03 10:33:41'),(47,'Kayseri',8.40,'TRY',NULL,'2025-06-03 10:33:41','2025-06-03 10:33:41'),(48,'Kırıkkale',9.66,'TRY',NULL,'2025-06-03 10:33:41','2025-06-03 10:33:41'),(49,'Kırklareli',NULL,'TRY',NULL,'2025-06-03 10:33:41','2025-06-03 10:33:41'),(50,'Kırşehir',9.66,'TRY',NULL,'2025-06-03 10:33:41','2025-06-03 10:33:41'),(51,'Kilis',NULL,'TRY',NULL,'2025-06-03 10:33:41','2025-06-03 10:33:41'),(52,'Kocaeli',9.63,'TRY',NULL,'2025-06-03 10:33:41','2025-06-03 10:33:41'),(53,'Konya',7.89,'TRY',NULL,'2025-06-03 10:33:41','2025-06-03 10:33:41'),(54,'Kütahya',NULL,'TRY',NULL,'2025-06-03 10:33:41','2025-06-03 10:33:41'),(55,'Malatya',17.44,'TRY',NULL,'2025-06-03 10:33:41','2025-06-03 10:33:41'),(56,'Manisa',8.23,'TRY',NULL,'2025-06-03 10:33:41','2025-06-03 10:33:41'),(57,'Mardin',10.25,'TRY',NULL,'2025-06-03 10:33:41','2025-06-03 10:33:41'),(58,'Mersin',NULL,'TRY',NULL,'2025-06-03 10:33:41','2025-06-03 10:33:41'),(59,'Muğla',9.78,'TRY',NULL,'2025-06-03 10:33:41','2025-06-03 10:33:41'),(60,'Muş',NULL,'TRY',NULL,'2025-06-03 10:33:41','2025-06-03 10:33:41'),(61,'Nevşehir',7.80,'TRY',NULL,'2025-06-03 10:33:41','2025-06-03 10:33:41'),(62,'Niğde',NULL,'TRY',NULL,'2025-06-03 10:33:41','2025-06-03 10:33:41'),(63,'Ordu',8.69,'TRY',NULL,'2025-06-03 10:33:41','2025-06-03 10:33:41'),(64,'Osmaniye',NULL,'TRY',NULL,'2025-06-03 10:33:41','2025-06-03 10:33:41'),(65,'Rize',8.31,'TRY',NULL,'2025-06-03 10:33:41','2025-06-03 10:33:41'),(66,'Sakarya',14.73,'TRY',NULL,'2025-06-03 10:33:41','2025-06-03 10:33:41'),(67,'Samsun',NULL,'TRY',NULL,'2025-06-03 10:33:41','2025-06-03 10:33:41'),(68,'Şanlıurfa',8.34,'TRY',NULL,'2025-06-03 10:33:41','2025-06-03 10:33:41'),(69,'Siirt',7.82,'TRY',NULL,'2025-06-03 10:33:41','2025-06-03 10:33:41'),(70,'Sinop',10.30,'TRY',NULL,'2025-06-03 10:33:41','2025-06-03 10:33:41'),(71,'Şırnak',6.03,'TRY',NULL,'2025-06-03 10:33:41','2025-06-03 10:33:41'),(72,'Sivas',8.15,'TRY',NULL,'2025-06-03 10:33:41','2025-06-03 10:33:41'),(73,'Tekirdağ',NULL,'TRY',NULL,'2025-06-03 10:33:41','2025-06-03 10:33:41'),(74,'Tokat',7.98,'TRY',NULL,'2025-06-03 10:33:41','2025-06-03 10:33:41'),(75,'Trabzon',8.31,'TRY',NULL,'2025-06-03 10:33:41','2025-06-03 10:33:41'),(76,'Tunceli',5.90,'TRY',NULL,'2025-06-03 10:33:41','2025-06-03 10:33:41'),(77,'Uşak',7.79,'TRY',NULL,'2025-06-03 10:33:41','2025-06-03 10:33:41'),(78,'Van',7.22,'TRY',NULL,'2025-06-03 10:33:41','2025-06-03 10:33:41'),(79,'Yalova',NULL,'TRY',NULL,'2025-06-03 10:33:41','2025-06-03 10:33:41'),(80,'Yozgat',8.31,'TRY',NULL,'2025-06-03 10:33:41','2025-06-03 10:33:41'),(81,'Zonguldak',7.00,'TRY',NULL,'2025-06-03 10:33:41','2025-06-03 10:33:41');
/*!40000 ALTER TABLE `natural_gas_tariffs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `passenger_types`
--

DROP TABLE IF EXISTS `passenger_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `passenger_types` (
  `id` int NOT NULL AUTO_INCREMENT,
  `type_name` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `type_name_en` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'English translation',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_passenger_type` (`type_name`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `passenger_types`
--

LOCK TABLES `passenger_types` WRITE;
/*!40000 ALTER TABLE `passenger_types` DISABLE KEYS */;
INSERT INTO `passenger_types` VALUES (1,'Tam','Full Price','2025-06-03 10:47:33'),(2,'Öğrenci','Student','2025-06-03 10:47:33'),(3,'Öğretmen','Teacher','2025-06-03 10:47:33'),(4,'İndirimli','Discounted','2025-06-03 10:47:33'),(5,'65 Yaş Üstü','Over 65','2025-06-03 10:47:33'),(6,'Üniversite Öğrencisi','University Student','2025-06-03 10:47:33'),(7,'İlköğretim ve Lise Öğrencileri','Elementary and High School Students','2025-06-03 10:47:33'),(8,'60 - 65 Yaş','60-65 Years Old','2025-06-03 10:47:33'),(9,'Herkes','Everyone','2025-06-03 10:47:33');
/*!40000 ALTER TABLE `passenger_types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `transportation_prices`
--

DROP TABLE IF EXISTS `transportation_prices`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `transportation_prices` (
  `id` int NOT NULL AUTO_INCREMENT,
  `city_id` int NOT NULL,
  `city_name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `plate_number` varchar(3) COLLATE utf8mb4_unicode_ci NOT NULL,
  `transportation_type_id` int NOT NULL,
  `passenger_type_id` int NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `currency` varchar(3) COLLATE utf8mb4_unicode_ci DEFAULT 'TRY',
  `notes` text COLLATE utf8mb4_unicode_ci COMMENT 'Additional information about the price',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_city` (`city_name`),
  KEY `idx_plate` (`plate_number`),
  KEY `idx_transport_type` (`transportation_type_id`),
  KEY `idx_passenger_type` (`passenger_type_id`),
  KEY `idx_price` (`price`),
  CONSTRAINT `transportation_prices_ibfk_1` FOREIGN KEY (`transportation_type_id`) REFERENCES `transportation_types` (`id`),
  CONSTRAINT `transportation_prices_ibfk_2` FOREIGN KEY (`passenger_type_id`) REFERENCES `passenger_types` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=311 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `transportation_prices`
--

LOCK TABLES `transportation_prices` WRITE;
/*!40000 ALTER TABLE `transportation_prices` DISABLE KEYS */;
INSERT INTO `transportation_prices` VALUES (1,1,'Adana','01',1,1,27.00,'TRY','Belediye Otobüsleri, Hafif Raylı Sistem','2025-06-03 10:51:55','2025-06-03 10:51:55'),(2,1,'Adana','01',1,2,13.00,'TRY','Belediye Otobüsleri, Hafif Raylı Sistem','2025-06-03 10:51:55','2025-06-03 10:51:55'),(3,1,'Adana','01',1,3,23.00,'TRY','Belediye Otobüsleri, Hafif Raylı Sistem','2025-06-03 10:51:55','2025-06-03 10:51:55'),(4,1,'Adana','01',3,1,29.00,'TRY',NULL,'2025-06-03 10:51:55','2025-06-03 10:51:55'),(5,1,'Adana','01',3,2,16.50,'TRY',NULL,'2025-06-03 10:51:55','2025-06-03 10:51:55'),(6,1,'Adana','01',3,3,26.00,'TRY',NULL,'2025-06-03 10:51:55','2025-06-03 10:51:55'),(7,1,'Adana','01',4,1,30.00,'TRY',NULL,'2025-06-03 10:51:55','2025-06-03 10:51:55'),(8,1,'Adana','01',4,2,17.00,'TRY',NULL,'2025-06-03 10:51:55','2025-06-03 10:51:55'),(9,2,'Adıyaman','02',1,1,14.00,'TRY',NULL,'2025-06-03 10:51:55','2025-06-03 10:51:55'),(10,2,'Adıyaman','02',1,2,10.00,'TRY',NULL,'2025-06-03 10:51:55','2025-06-03 10:51:55'),(11,3,'Afyonkarahisar','03',5,1,14.00,'TRY',NULL,'2025-06-03 10:51:55','2025-06-03 10:51:55'),(12,3,'Afyonkarahisar','03',5,2,12.00,'TRY',NULL,'2025-06-03 10:51:55','2025-06-03 10:51:55'),(13,3,'Afyonkarahisar','03',6,1,20.00,'TRY',NULL,'2025-06-03 10:51:55','2025-06-03 10:51:55'),(14,3,'Afyonkarahisar','03',6,2,15.00,'TRY',NULL,'2025-06-03 10:51:55','2025-06-03 10:51:55'),(15,4,'Ağrı','04',1,1,13.00,'TRY',NULL,'2025-06-03 10:51:55','2025-06-03 10:51:55'),(16,4,'Ağrı','04',1,4,8.00,'TRY',NULL,'2025-06-03 10:51:55','2025-06-03 10:51:55'),(17,5,'Amasya','05',3,1,18.00,'TRY',NULL,'2025-06-03 10:51:55','2025-06-03 10:51:55'),(18,5,'Amasya','05',3,2,13.00,'TRY',NULL,'2025-06-03 10:51:55','2025-06-03 10:51:55'),(19,6,'Ankara','06',1,1,26.00,'TRY','Belediye ve Özel Otobüsler, Ankaray, Metro, Başkentray','2025-06-03 10:51:55','2025-06-03 10:51:55'),(20,6,'Ankara','06',1,2,13.00,'TRY','Belediye ve Özel Otobüsler, Ankaray, Metro, Başkentray','2025-06-03 10:51:55','2025-06-03 10:51:55'),(21,7,'Antalya','07',18,1,27.00,'TRY','Otobüsler, Raylı Ulaşım','2025-06-03 10:51:55','2025-06-03 10:51:55'),(22,7,'Antalya','07',18,2,12.00,'TRY','Otobüsler, Raylı Ulaşım','2025-06-03 10:51:55','2025-06-03 10:51:55'),(23,7,'Antalya','07',18,4,26.00,'TRY','Otobüsler, Raylı Ulaşım','2025-06-03 10:51:55','2025-06-03 10:51:55'),(24,8,'Artvin','08',11,1,25.00,'TRY',NULL,'2025-06-03 10:51:55','2025-06-03 10:51:55'),(25,8,'Artvin','08',11,2,20.00,'TRY',NULL,'2025-06-03 10:51:55','2025-06-03 10:51:55'),(26,9,'Aydın','09',5,1,25.00,'TRY',NULL,'2025-06-03 10:51:55','2025-06-03 10:51:55'),(27,9,'Aydın','09',5,4,16.50,'TRY',NULL,'2025-06-03 10:51:55','2025-06-03 10:51:55'),(28,10,'Balıkesir','10',1,1,24.00,'TRY',NULL,'2025-06-03 10:51:55','2025-06-03 10:51:55'),(29,10,'Balıkesir','10',1,2,16.00,'TRY',NULL,'2025-06-03 10:51:55','2025-06-03 10:51:55'),(30,10,'Balıkesir','10',1,5,19.25,'TRY',NULL,'2025-06-03 10:51:55','2025-06-03 10:51:55'),(31,11,'Bilecik','11',5,1,25.00,'TRY',NULL,'2025-06-03 10:51:55','2025-06-03 10:51:55'),(32,11,'Bilecik','11',5,2,17.00,'TRY',NULL,'2025-06-03 10:51:55','2025-06-03 10:51:55'),(33,12,'Bingöl','12',5,1,14.00,'TRY',NULL,'2025-06-03 10:51:55','2025-06-03 10:51:55'),(34,12,'Bingöl','12',5,2,10.00,'TRY',NULL,'2025-06-03 10:51:55','2025-06-03 10:51:55'),(35,13,'Bitlis','13',5,1,17.50,'TRY',NULL,'2025-06-03 10:51:55','2025-06-03 10:51:55'),(36,13,'Bitlis','13',5,2,11.00,'TRY',NULL,'2025-06-03 10:51:55','2025-06-03 10:51:55'),(37,14,'Bolu','14',5,1,25.00,'TRY',NULL,'2025-06-03 10:51:55','2025-06-03 10:51:55'),(38,14,'Bolu','14',5,2,18.00,'TRY',NULL,'2025-06-03 10:51:55','2025-06-03 10:51:55'),(39,15,'Burdur','15',5,1,22.00,'TRY',NULL,'2025-06-03 10:51:55','2025-06-03 10:51:55'),(40,15,'Burdur','15',5,6,17.00,'TRY',NULL,'2025-06-03 10:51:55','2025-06-03 10:51:55'),(41,15,'Burdur','15',5,7,12.00,'TRY',NULL,'2025-06-03 10:51:55','2025-06-03 10:51:55'),(42,16,'Bursa','16',1,1,20.15,'TRY',NULL,'2025-06-03 10:51:55','2025-06-03 10:51:55'),(43,16,'Bursa','16',1,2,5.05,'TRY',NULL,'2025-06-03 10:51:55','2025-06-03 10:51:55'),(44,16,'Bursa','16',1,4,18.15,'TRY',NULL,'2025-06-03 10:51:55','2025-06-03 10:51:55'),(45,16,'Bursa','16',12,1,26.00,'TRY','Raylı Ulaşım','2025-06-03 10:51:55','2025-06-03 10:51:55'),(46,16,'Bursa','16',12,2,6.50,'TRY','Raylı Ulaşım','2025-06-03 10:51:55','2025-06-03 10:51:55'),(47,16,'Bursa','16',12,4,23.25,'TRY','Raylı Ulaşım','2025-06-03 10:51:55','2025-06-03 10:51:55'),(48,17,'Çanakkale','17',1,1,25.00,'TRY',NULL,'2025-06-03 10:51:55','2025-06-03 10:51:55'),(49,17,'Çanakkale','17',1,2,15.00,'TRY',NULL,'2025-06-03 10:51:55','2025-06-03 10:51:55'),(50,17,'Çanakkale','17',13,1,27.00,'TRY','Çanakkale – Eceabat Hattı','2025-06-03 10:51:55','2025-06-03 10:51:55'),(51,17,'Çanakkale','17',13,2,7.50,'TRY','Çanakkale – Eceabat Hattı','2025-06-03 10:51:55','2025-06-03 10:51:55'),(52,17,'Çanakkale','17',13,5,15.00,'TRY','Çanakkale – Eceabat Hattı','2025-06-03 10:51:55','2025-06-03 10:51:55'),(53,18,'Çankırı','18',5,1,15.00,'TRY',NULL,'2025-06-03 10:51:55','2025-06-03 10:51:55'),(54,18,'Çankırı','18',5,2,12.00,'TRY',NULL,'2025-06-03 10:51:55','2025-06-03 10:51:55'),(55,19,'Çorum','19',5,1,17.50,'TRY',NULL,'2025-06-03 10:51:55','2025-06-03 10:51:55'),(56,19,'Çorum','19',5,2,12.00,'TRY',NULL,'2025-06-03 10:51:55','2025-06-03 10:51:55'),(57,20,'Denizli','20',1,1,17.00,'TRY',NULL,'2025-06-03 10:51:55','2025-06-03 10:51:55'),(58,20,'Denizli','20',1,2,10.00,'TRY',NULL,'2025-06-03 10:51:55','2025-06-03 10:51:55'),(59,20,'Denizli','20',6,1,22.00,'TRY',NULL,'2025-06-03 10:51:55','2025-06-03 10:51:55'),(60,20,'Denizli','20',6,2,17.00,'TRY',NULL,'2025-06-03 10:51:55','2025-06-03 10:51:55'),(61,21,'Diyarbakır','21',1,1,20.00,'TRY',NULL,'2025-06-03 10:54:13','2025-06-03 10:54:13'),(62,21,'Diyarbakır','21',1,4,15.00,'TRY',NULL,'2025-06-03 10:54:13','2025-06-03 10:54:13'),(63,21,'Diyarbakır','21',1,2,10.00,'TRY',NULL,'2025-06-03 10:54:13','2025-06-03 10:54:13'),(64,21,'Diyarbakır','21',6,1,25.00,'TRY',NULL,'2025-06-03 10:54:13','2025-06-03 10:54:13'),(65,21,'Diyarbakır','21',6,2,15.00,'TRY',NULL,'2025-06-03 10:54:13','2025-06-03 10:54:13'),(66,21,'Diyarbakır','21',5,1,16.00,'TRY',NULL,'2025-06-03 10:54:13','2025-06-03 10:54:13'),(67,21,'Diyarbakır','21',5,4,14.00,'TRY',NULL,'2025-06-03 10:54:13','2025-06-03 10:54:13'),(68,21,'Diyarbakır','21',5,2,9.00,'TRY',NULL,'2025-06-03 10:54:13','2025-06-03 10:54:13'),(69,22,'Edirne','22',1,1,26.45,'TRY',NULL,'2025-06-03 10:54:13','2025-06-03 10:54:13'),(70,22,'Edirne','22',1,2,16.30,'TRY',NULL,'2025-06-03 10:54:13','2025-06-03 10:54:13'),(71,22,'Edirne','22',6,1,25.00,'TRY',NULL,'2025-06-03 10:54:13','2025-06-03 10:54:13'),(72,23,'Elazığ','23',1,1,18.00,'TRY',NULL,'2025-06-03 10:54:13','2025-06-03 10:54:13'),(73,23,'Elazığ','23',1,4,13.00,'TRY',NULL,'2025-06-03 10:54:13','2025-06-03 10:54:13'),(74,23,'Elazığ','23',6,1,20.00,'TRY',NULL,'2025-06-03 10:54:13','2025-06-03 10:54:13'),(75,23,'Elazığ','23',6,2,15.00,'TRY',NULL,'2025-06-03 10:54:13','2025-06-03 10:54:13'),(76,24,'Erzincan','24',5,1,20.40,'TRY',NULL,'2025-06-03 10:54:13','2025-06-03 10:54:13'),(77,24,'Erzincan','24',5,2,16.80,'TRY',NULL,'2025-06-03 10:54:13','2025-06-03 10:54:13'),(78,25,'Erzurum','25',1,1,18.00,'TRY',NULL,'2025-06-03 10:54:13','2025-06-03 10:54:13'),(79,25,'Erzurum','25',1,2,13.00,'TRY',NULL,'2025-06-03 10:54:13','2025-06-03 10:54:13'),(80,25,'Erzurum','25',1,3,17.50,'TRY',NULL,'2025-06-03 10:54:13','2025-06-03 10:54:13'),(81,25,'Erzurum','25',6,1,18.00,'TRY',NULL,'2025-06-03 10:54:13','2025-06-03 10:54:13'),(82,25,'Erzurum','25',6,2,13.00,'TRY',NULL,'2025-06-03 10:54:13','2025-06-03 10:54:13'),(83,26,'Eskişehir','26',1,1,25.00,'TRY','Belediye Otobüsleri, Tramvay','2025-06-03 10:54:13','2025-06-03 10:54:13'),(84,26,'Eskişehir','26',1,4,12.50,'TRY','Belediye Otobüsleri, Tramvay','2025-06-03 10:54:13','2025-06-03 10:54:13'),(85,27,'Gaziantep','27',1,1,26.00,'TRY',NULL,'2025-06-03 10:54:13','2025-06-03 10:54:13'),(86,27,'Gaziantep','27',1,2,13.00,'TRY',NULL,'2025-06-03 10:54:13','2025-06-03 10:54:13'),(87,27,'Gaziantep','27',1,4,22.50,'TRY',NULL,'2025-06-03 10:54:13','2025-06-03 10:54:13'),(88,28,'Giresun','28',11,1,25.00,'TRY',NULL,'2025-06-03 10:54:13','2025-06-03 10:54:13'),(89,28,'Giresun','28',11,2,17.00,'TRY',NULL,'2025-06-03 10:54:13','2025-06-03 10:54:13'),(90,29,'Gümüşhane','29',1,1,20.00,'TRY',NULL,'2025-06-03 10:57:34','2025-06-03 10:57:34'),(91,29,'Gümüşhane','29',1,2,17.00,'TRY',NULL,'2025-06-03 10:57:34','2025-06-03 10:57:34'),(92,29,'Gümüşhane','29',11,2,20.00,'TRY',NULL,'2025-06-03 10:57:34','2025-06-03 10:57:34'),(93,30,'Hakkâri','30',1,1,12.00,'TRY',NULL,'2025-06-03 10:57:34','2025-06-03 10:57:34'),(94,30,'Hakkâri','30',1,2,8.00,'TRY',NULL,'2025-06-03 10:57:34','2025-06-03 10:57:34'),(95,31,'Hatay','31',1,1,20.00,'TRY',NULL,'2025-06-03 10:57:34','2025-06-03 10:57:34'),(96,31,'Hatay','31',1,2,14.00,'TRY',NULL,'2025-06-03 10:57:34','2025-06-03 10:57:34'),(97,32,'Isparta','32',1,1,18.00,'TRY',NULL,'2025-06-03 10:57:34','2025-06-03 10:57:34'),(98,32,'Isparta','32',1,2,14.00,'TRY',NULL,'2025-06-03 10:57:34','2025-06-03 10:57:34'),(99,33,'Mersin','33',1,1,25.00,'TRY',NULL,'2025-06-03 10:57:34','2025-06-03 10:57:34'),(100,33,'Mersin','33',1,2,13.00,'TRY',NULL,'2025-06-03 10:57:34','2025-06-03 10:57:34'),(101,33,'Mersin','33',1,4,22.00,'TRY',NULL,'2025-06-03 10:57:34','2025-06-03 10:57:34'),(102,33,'Mersin','33',1,3,23.00,'TRY',NULL,'2025-06-03 10:57:34','2025-06-03 10:57:34'),(103,33,'Mersin','33',11,1,30.00,'TRY',NULL,'2025-06-03 10:57:34','2025-06-03 10:57:34'),(104,33,'Mersin','33',11,2,20.00,'TRY',NULL,'2025-06-03 10:57:34','2025-06-03 10:57:34'),(105,34,'İstanbul','34',18,1,27.00,'TRY','Otobüsler, Metro, Tramvay, Teleferik','2025-06-03 10:57:34','2025-06-03 10:57:34'),(106,34,'İstanbul','34',18,2,13.18,'TRY','Otobüsler, Metro, Tramvay, Teleferik','2025-06-03 10:57:34','2025-06-03 10:57:34'),(107,34,'İstanbul','34',18,4,19.33,'TRY','Otobüsler, Metro, Tramvay, Teleferik','2025-06-03 10:57:34','2025-06-03 10:57:34'),(108,34,'İstanbul','34',15,1,43.63,'TRY','ORTALAMA FİYATLAR','2025-06-03 10:57:34','2025-06-03 10:57:34'),(109,34,'İstanbul','34',15,2,20.59,'TRY','ORTALAMA FİYATLAR','2025-06-03 10:57:34','2025-06-03 10:57:34'),(110,34,'İstanbul','34',15,4,30.74,'TRY','ORTALAMA FİYATLAR','2025-06-03 10:57:34','2025-06-03 10:57:34'),(111,34,'İstanbul','34',16,1,31.53,'TRY','ORTALAMA FİYATLAR','2025-06-03 10:57:34','2025-06-03 10:57:34'),(112,34,'İstanbul','34',16,2,11.98,'TRY','ORTALAMA FİYATLAR','2025-06-03 10:57:34','2025-06-03 10:57:34'),(113,34,'İstanbul','34',16,4,18.60,'TRY','ORTALAMA FİYATLAR','2025-06-03 10:57:34','2025-06-03 10:57:34'),(114,34,'İstanbul','34',17,1,44.42,'TRY','ORTALAMA FİYATLAR','2025-06-03 10:57:34','2025-06-03 10:57:34'),(115,34,'İstanbul','34',17,2,22.08,'TRY','ORTALAMA FİYATLAR','2025-06-03 10:57:34','2025-06-03 10:57:34'),(116,34,'İstanbul','34',17,4,31.35,'TRY','ORTALAMA FİYATLAR','2025-06-03 10:57:34','2025-06-03 10:57:34'),(117,35,'İzmir','35',18,1,25.00,'TRY','Otobüsler, Metro, Vapur','2025-06-03 10:57:34','2025-06-03 10:57:34'),(118,35,'İzmir','35',18,2,10.00,'TRY','Otobüsler, Metro, Vapur','2025-06-03 10:57:34','2025-06-03 10:57:34'),(119,35,'İzmir','35',18,4,20.00,'TRY','Otobüsler, Metro, Vapur','2025-06-03 10:57:34','2025-06-03 10:57:34'),(120,35,'İzmir','35',18,3,17.72,'TRY','Otobüsler, Metro, Vapur','2025-06-03 10:57:34','2025-06-03 10:57:34'),(121,36,'Kars','36',11,1,25.00,'TRY',NULL,'2025-06-03 10:57:34','2025-06-03 10:57:34'),(122,36,'Kars','36',11,2,20.00,'TRY',NULL,'2025-06-03 10:57:34','2025-06-03 10:57:34'),(123,37,'Kastamonu','37',5,1,20.00,'TRY',NULL,'2025-06-03 10:57:34','2025-06-03 10:57:34'),(124,37,'Kastamonu','37',5,2,13.00,'TRY',NULL,'2025-06-03 10:57:34','2025-06-03 10:57:34'),(125,38,'Kayseri','38',18,1,25.00,'TRY','Otobüsler, Raylı Ulaşım','2025-06-03 10:57:34','2025-06-03 10:57:34'),(126,38,'Kayseri','38',18,4,13.75,'TRY','Otobüsler, Raylı Ulaşım','2025-06-03 10:57:34','2025-06-03 10:57:34'),(127,38,'Kayseri','38',18,3,20.00,'TRY','Otobüsler, Raylı Ulaşım','2025-06-03 10:57:34','2025-06-03 10:57:34'),(128,39,'Kırklareli','39',5,1,25.00,'TRY',NULL,'2025-06-03 10:57:34','2025-06-03 10:57:34'),(129,39,'Kırklareli','39',5,4,20.00,'TRY',NULL,'2025-06-03 10:57:34','2025-06-03 10:57:34'),(130,40,'Kırşehir','40',18,1,19.00,'TRY',NULL,'2025-06-03 10:57:34','2025-06-03 10:57:34'),(131,40,'Kırşehir','40',18,2,13.00,'TRY',NULL,'2025-06-03 10:57:34','2025-06-03 10:57:34'),(132,40,'Kırşehir','40',11,1,15.00,'TRY',NULL,'2025-06-03 10:57:34','2025-06-03 10:57:34'),(133,40,'Kırşehir','40',11,2,12.00,'TRY',NULL,'2025-06-03 10:57:34','2025-06-03 10:57:34'),(197,41,'Kocaeli','41',18,1,27.00,'TRY','Otobüsler, Minibüsler','2025-06-03 11:05:53','2025-06-03 11:05:53'),(198,41,'Kocaeli','41',18,4,17.50,'TRY','Otobüsler, Minibüsler','2025-06-03 11:05:53','2025-06-03 11:05:53'),(199,41,'Kocaeli','41',14,1,23.00,'TRY',NULL,'2025-06-03 11:05:53','2025-06-03 11:05:53'),(200,41,'Kocaeli','41',14,4,13.50,'TRY',NULL,'2025-06-03 11:05:53','2025-06-03 11:05:53'),(201,41,'Kocaeli','41',21,1,32.00,'TRY',NULL,'2025-06-03 11:05:53','2025-06-03 11:05:53'),(202,41,'Kocaeli','41',21,4,24.00,'TRY',NULL,'2025-06-03 11:05:53','2025-06-03 11:05:53'),(203,42,'Konya','42',18,1,17.50,'TRY','Otobüsler, Tramvay','2025-06-03 11:05:53','2025-06-03 11:05:53'),(204,42,'Konya','42',18,2,6.75,'TRY','Otobüsler, Tramvay','2025-06-03 11:05:53','2025-06-03 11:05:53'),(205,42,'Konya','42',11,9,20.00,'TRY',NULL,'2025-06-03 11:05:53','2025-06-03 11:05:53'),(206,43,'Kütahya','43',5,1,24.00,'TRY',NULL,'2025-06-03 11:05:53','2025-06-03 11:05:53'),(207,43,'Kütahya','43',5,6,19.00,'TRY',NULL,'2025-06-03 11:05:53','2025-06-03 11:05:53'),(208,43,'Kütahya','43',5,7,13.00,'TRY',NULL,'2025-06-03 11:05:53','2025-06-03 11:05:53'),(209,44,'Malatya','44',19,1,14.00,'TRY','Otobüs, Trambüs','2025-06-03 11:05:53','2025-06-03 11:05:53'),(210,44,'Malatya','44',19,2,9.00,'TRY','Otobüs, Trambüs','2025-06-03 11:05:53','2025-06-03 11:05:53'),(211,45,'Manisa','45',18,1,20.00,'TRY',NULL,'2025-06-03 11:05:53','2025-06-03 11:05:53'),(212,45,'Manisa','45',18,2,12.20,'TRY',NULL,'2025-06-03 11:05:53','2025-06-03 11:05:53'),(213,46,'Kahramanmaraş','46',18,1,16.50,'TRY',NULL,'2025-06-03 11:05:53','2025-06-03 11:05:53'),(214,46,'Kahramanmaraş','46',18,2,9.00,'TRY',NULL,'2025-06-03 11:05:53','2025-06-03 11:05:53'),(215,46,'Kahramanmaraş','46',18,3,16.00,'TRY',NULL,'2025-06-03 11:05:53','2025-06-03 11:05:53'),(216,47,'Mardin','47',18,1,18.50,'TRY',NULL,'2025-06-03 11:05:53','2025-06-03 11:05:53'),(217,47,'Mardin','47',18,2,12.00,'TRY',NULL,'2025-06-03 11:05:53','2025-06-03 11:05:53'),(218,48,'Muğla','48',18,1,29.00,'TRY',NULL,'2025-06-03 11:05:53','2025-06-03 11:05:53'),(219,48,'Muğla','48',18,4,23.00,'TRY',NULL,'2025-06-03 11:05:53','2025-06-03 11:05:53'),(220,48,'Muğla','48',18,2,18.00,'TRY',NULL,'2025-06-03 11:05:53','2025-06-03 11:05:53'),(221,49,'Muş','49',18,1,17.00,'TRY',NULL,'2025-06-03 11:05:53','2025-06-03 11:05:53'),(222,49,'Muş','49',18,2,12.00,'TRY',NULL,'2025-06-03 11:05:53','2025-06-03 11:05:53'),(223,50,'Nevşehir','50',18,1,20.00,'TRY',NULL,'2025-06-03 11:05:53','2025-06-03 11:05:53'),(224,50,'Nevşehir','50',18,4,14.00,'TRY',NULL,'2025-06-03 11:05:53','2025-06-03 11:05:53'),(225,51,'Niğde','51',18,1,20.00,'TRY',NULL,'2025-06-03 11:05:53','2025-06-03 11:05:53'),(226,51,'Niğde','51',18,2,13.50,'TRY',NULL,'2025-06-03 11:05:53','2025-06-03 11:05:53'),(227,52,'Ordu','52',18,1,26.00,'TRY',NULL,'2025-06-03 11:05:53','2025-06-03 11:05:53'),(228,52,'Ordu','52',18,2,15.85,'TRY',NULL,'2025-06-03 11:05:53','2025-06-03 11:05:53'),(229,53,'Rize','53',5,1,26.00,'TRY',NULL,'2025-06-03 11:05:53','2025-06-03 11:05:53'),(230,53,'Rize','53',5,2,18.00,'TRY',NULL,'2025-06-03 11:05:53','2025-06-03 11:05:53'),(231,53,'Rize','53',11,1,23.00,'TRY',NULL,'2025-06-03 11:05:53','2025-06-03 11:05:53'),(232,53,'Rize','53',11,2,17.00,'TRY',NULL,'2025-06-03 11:05:53','2025-06-03 11:05:53'),(233,54,'Sakarya','54',18,1,13.50,'TRY',NULL,'2025-06-03 11:05:53','2025-06-03 11:05:53'),(234,54,'Sakarya','54',18,2,4.35,'TRY',NULL,'2025-06-03 11:05:53','2025-06-03 11:05:53'),(235,54,'Sakarya','54',18,8,6.75,'TRY',NULL,'2025-06-03 11:05:53','2025-06-03 11:05:53'),(236,54,'Sakarya','54',18,3,11.48,'TRY',NULL,'2025-06-03 11:05:53','2025-06-03 11:05:53'),(237,54,'Sakarya','54',6,1,19.50,'TRY',NULL,'2025-06-03 11:05:53','2025-06-03 11:05:53'),(238,54,'Sakarya','54',6,2,17.50,'TRY',NULL,'2025-06-03 11:05:53','2025-06-03 11:05:53'),(239,54,'Sakarya','54',22,1,15.00,'TRY',NULL,'2025-06-03 11:05:53','2025-06-03 11:05:53'),(240,54,'Sakarya','54',22,2,4.83,'TRY',NULL,'2025-06-03 11:05:53','2025-06-03 11:05:53'),(241,54,'Sakarya','54',22,8,7.50,'TRY',NULL,'2025-06-03 11:05:53','2025-06-03 11:05:53'),(242,54,'Sakarya','54',22,3,12.75,'TRY',NULL,'2025-06-03 11:05:53','2025-06-03 11:05:53'),(243,55,'Samsun','55',18,1,17.00,'TRY','Otobüsler, Tramvay','2025-06-03 11:05:53','2025-06-03 11:05:53'),(244,55,'Samsun','55',18,2,11.00,'TRY','Otobüsler, Tramvay','2025-06-03 11:05:53','2025-06-03 11:05:53'),(245,55,'Samsun','55',6,1,24.00,'TRY',NULL,'2025-06-03 11:05:53','2025-06-03 11:05:53'),(246,55,'Samsun','55',6,2,18.00,'TRY',NULL,'2025-06-03 11:05:53','2025-06-03 11:05:53'),(247,56,'Siirt','56',1,1,12.00,'TRY',NULL,'2025-06-03 11:05:53','2025-06-03 11:05:53'),(248,56,'Siirt','56',1,2,9.00,'TRY',NULL,'2025-06-03 11:05:53','2025-06-03 11:05:53'),(249,56,'Siirt','56',6,1,10.00,'TRY',NULL,'2025-06-03 11:05:53','2025-06-03 11:05:53'),(250,56,'Siirt','56',6,2,7.50,'TRY',NULL,'2025-06-03 11:05:53','2025-06-03 11:05:53'),(251,57,'Sinop','57',18,1,25.00,'TRY',NULL,'2025-06-03 11:05:53','2025-06-03 11:05:53'),(252,57,'Sinop','57',18,2,20.00,'TRY',NULL,'2025-06-03 11:05:53','2025-06-03 11:05:53'),(253,58,'Sivas','58',18,1,21.00,'TRY',NULL,'2025-06-03 11:05:53','2025-06-03 11:05:53'),(254,58,'Sivas','58',18,2,14.00,'TRY',NULL,'2025-06-03 11:05:53','2025-06-03 11:05:53'),(255,59,'Tekirdağ','59',18,1,25.00,'TRY',NULL,'2025-06-03 11:05:53','2025-06-03 11:05:53'),(256,59,'Tekirdağ','59',18,4,13.00,'TRY',NULL,'2025-06-03 11:05:53','2025-06-03 11:05:53'),(257,60,'Tokat','60',1,1,17.50,'TRY',NULL,'2025-06-03 11:05:53','2025-06-03 11:05:53'),(258,60,'Tokat','60',1,2,13.50,'TRY',NULL,'2025-06-03 11:05:53','2025-06-03 11:05:53'),(259,61,'Trabzon','61',18,1,22.00,'TRY',NULL,'2025-06-03 11:05:53','2025-06-03 11:05:53'),(260,61,'Trabzon','61',18,4,17.50,'TRY',NULL,'2025-06-03 11:05:53','2025-06-03 11:05:53'),(261,61,'Trabzon','61',18,2,10.00,'TRY',NULL,'2025-06-03 11:05:53','2025-06-03 11:05:53'),(262,61,'Trabzon','61',11,1,25.00,'TRY',NULL,'2025-06-03 11:05:53','2025-06-03 11:05:53'),(263,61,'Trabzon','61',11,2,18.00,'TRY',NULL,'2025-06-03 11:05:53','2025-06-03 11:05:53'),(264,62,'Tunceli','62',18,1,20.00,'TRY',NULL,'2025-06-03 11:05:53','2025-06-03 11:05:53'),(265,62,'Tunceli','62',18,2,9.76,'TRY',NULL,'2025-06-03 11:05:53','2025-06-03 11:05:53'),(266,63,'Şanlıurfa','63',1,1,17.50,'TRY',NULL,'2025-06-03 11:05:53','2025-06-03 11:05:53'),(267,63,'Şanlıurfa','63',1,4,10.00,'TRY',NULL,'2025-06-03 11:05:53','2025-06-03 11:05:53'),(268,64,'Uşak','64',18,1,22.00,'TRY',NULL,'2025-06-03 11:05:53','2025-06-03 11:05:53'),(269,64,'Uşak','64',18,2,16.00,'TRY',NULL,'2025-06-03 11:05:53','2025-06-03 11:05:53'),(270,65,'Van','65',18,1,19.00,'TRY',NULL,'2025-06-03 11:05:53','2025-06-03 11:05:53'),(271,65,'Van','65',18,2,11.70,'TRY',NULL,'2025-06-03 11:05:53','2025-06-03 11:05:53'),(272,66,'Yozgat','66',5,1,20.00,'TRY',NULL,'2025-06-03 11:05:53','2025-06-03 11:05:53'),(273,66,'Yozgat','66',5,2,15.00,'TRY',NULL,'2025-06-03 11:05:53','2025-06-03 11:05:53'),(274,67,'Zonguldak','67',18,1,27.00,'TRY',NULL,'2025-06-03 11:05:53','2025-06-03 11:05:53'),(275,67,'Zonguldak','67',18,2,17.00,'TRY',NULL,'2025-06-03 11:05:53','2025-06-03 11:05:53'),(276,68,'Aksaray','68',5,1,20.00,'TRY',NULL,'2025-06-03 11:05:53','2025-06-03 11:05:53'),(277,68,'Aksaray','68',5,4,13.00,'TRY',NULL,'2025-06-03 11:05:53','2025-06-03 11:05:53'),(278,69,'Bayburt','69',11,1,18.00,'TRY',NULL,'2025-06-03 11:05:53','2025-06-03 11:05:53'),(279,69,'Bayburt','69',11,4,15.00,'TRY',NULL,'2025-06-03 11:05:53','2025-06-03 11:05:53'),(280,70,'Karaman','70',18,1,4.00,'TRY',NULL,'2025-06-03 11:05:53','2025-06-03 11:05:53'),(281,70,'Karaman','70',18,2,2.00,'TRY',NULL,'2025-06-03 11:05:53','2025-06-03 11:05:53'),(282,70,'Karaman','70',11,9,20.00,'TRY',NULL,'2025-06-03 11:05:53','2025-06-03 11:05:53'),(283,71,'Kırıkkale','71',1,1,14.00,'TRY',NULL,'2025-06-03 11:05:53','2025-06-03 11:05:53'),(284,71,'Kırıkkale','71',1,2,11.00,'TRY',NULL,'2025-06-03 11:05:53','2025-06-03 11:05:53'),(285,71,'Kırıkkale','71',6,1,17.00,'TRY',NULL,'2025-06-03 11:05:53','2025-06-03 11:05:53'),(286,71,'Kırıkkale','71',6,2,15.00,'TRY',NULL,'2025-06-03 11:05:53','2025-06-03 11:05:53'),(287,72,'Batman','72',1,1,12.00,'TRY',NULL,'2025-06-03 11:05:53','2025-06-03 11:05:53'),(288,72,'Batman','72',1,2,8.00,'TRY',NULL,'2025-06-03 11:05:53','2025-06-03 11:05:53'),(289,72,'Batman','72',6,1,20.00,'TRY',NULL,'2025-06-03 11:05:53','2025-06-03 11:05:53'),(290,72,'Batman','72',6,2,15.00,'TRY',NULL,'2025-06-03 11:05:53','2025-06-03 11:05:53'),(291,73,'Şırnak','73',1,1,15.00,'TRY',NULL,'2025-06-03 11:05:53','2025-06-03 11:05:53'),(292,73,'Şırnak','73',1,2,12.00,'TRY',NULL,'2025-06-03 11:05:53','2025-06-03 11:05:53'),(293,74,'Bartın','74',5,1,23.00,'TRY',NULL,'2025-06-03 11:05:53','2025-06-03 11:05:53'),(294,74,'Bartın','74',5,4,15.00,'TRY',NULL,'2025-06-03 11:05:53','2025-06-03 11:05:53'),(295,75,'Ardahan','75',11,1,20.00,'TRY',NULL,'2025-06-03 11:05:53','2025-06-03 11:05:53'),(296,75,'Ardahan','75',11,2,15.00,'TRY',NULL,'2025-06-03 11:05:53','2025-06-03 11:05:53'),(297,76,'Iğdır','76',18,1,15.00,'TRY',NULL,'2025-06-03 11:12:03','2025-06-03 11:12:03'),(298,76,'Iğdır','76',18,2,8.00,'TRY',NULL,'2025-06-03 11:12:03','2025-06-03 11:12:03'),(299,77,'Yalova','77',6,1,25.00,'TRY',NULL,'2025-06-03 11:12:03','2025-06-03 11:12:03'),(300,77,'Yalova','77',6,2,20.00,'TRY',NULL,'2025-06-03 11:12:03','2025-06-03 11:12:03'),(301,78,'Karabük','78',18,1,20.50,'TRY',NULL,'2025-06-03 11:12:03','2025-06-03 11:12:03'),(302,78,'Karabük','78',18,4,16.00,'TRY',NULL,'2025-06-03 11:12:03','2025-06-03 11:12:03'),(303,79,'Kilis','79',5,1,20.00,'TRY',NULL,'2025-06-03 11:12:03','2025-06-03 11:12:03'),(304,79,'Kilis','79',5,2,15.00,'TRY',NULL,'2025-06-03 11:12:03','2025-06-03 11:12:03'),(305,80,'Osmaniye','80',18,1,25.00,'TRY',NULL,'2025-06-03 11:12:03','2025-06-03 11:12:03'),(306,80,'Osmaniye','80',18,2,15.00,'TRY',NULL,'2025-06-03 11:12:03','2025-06-03 11:12:03'),(307,80,'Osmaniye','80',11,1,25.00,'TRY',NULL,'2025-06-03 11:12:03','2025-06-03 11:12:03'),(308,80,'Osmaniye','80',11,2,20.00,'TRY',NULL,'2025-06-03 11:12:03','2025-06-03 11:12:03'),(309,81,'Düzce','81',18,1,24.00,'TRY',NULL,'2025-06-03 11:12:03','2025-06-03 11:12:03'),(310,81,'Düzce','81',18,4,15.00,'TRY',NULL,'2025-06-03 11:12:03','2025-06-03 11:12:03');
/*!40000 ALTER TABLE `transportation_prices` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `transportation_types`
--

DROP TABLE IF EXISTS `transportation_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `transportation_types` (
  `id` int NOT NULL AUTO_INCREMENT,
  `type_name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `type_name_en` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'English translation for reference',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_type` (`type_name`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `transportation_types`
--

LOCK TABLES `transportation_types` WRITE;
/*!40000 ALTER TABLE `transportation_types` DISABLE KEYS */;
INSERT INTO `transportation_types` VALUES (1,'Belediye Otobüsleri','Municipal Buses','2025-06-03 10:47:33'),(2,'Hafif Raylı Sistem','Light Rail System','2025-06-03 10:47:33'),(3,'Özel Halk Otobüsleri','Private Public Buses','2025-06-03 10:47:33'),(4,'Özel Dolmuş Minibüsleri','Private Shared Minibuses','2025-06-03 10:47:33'),(5,'Halk Otobüsleri','Public Buses','2025-06-03 10:47:33'),(6,'Minibüs','Minibus','2025-06-03 10:47:33'),(7,'Ankaray','Ankaray (Ankara Metro)','2025-06-03 10:47:33'),(8,'Metro','Metro','2025-06-03 10:47:33'),(9,'Başkentray','Başkentray (Ankara Suburban Rail)','2025-06-03 10:47:33'),(10,'Raylı Ulaşım','Rail Transportation','2025-06-03 10:47:33'),(11,'Dolmuşlar','Shared Taxis','2025-06-03 10:47:33'),(12,'Bursaray','Bursaray (Bursa Metro)','2025-06-03 10:47:33'),(13,'Feribot','Ferry','2025-06-03 10:47:33'),(14,'Tramvay','Tram','2025-06-03 10:47:33'),(15,'Marmaray','Marmaray','2025-06-03 10:47:33'),(16,'Metrobüs','Metrobus','2025-06-03 10:47:33'),(17,'Vapur ve Deniz Motorları','Ferries and Sea Buses','2025-06-03 10:47:33'),(18,'Otobüsler','Buses','2025-06-03 10:47:33'),(19,'Trambüs','Trambus','2025-06-03 10:47:33'),(20,'Teleferik','Cable Car','2025-06-03 10:47:33'),(21,'Deniz Ulaşımı','Sea Transportation','2025-06-03 10:47:33'),(22,'Adaray','Adaray (Sakarya Light Rail)','2025-06-03 10:47:33');
/*!40000 ALTER TABLE `transportation_types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `water_tariffs`
--

DROP TABLE IF EXISTS `water_tariffs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `water_tariffs` (
  `id` int NOT NULL AUTO_INCREMENT,
  `city_name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `price_per_m3` decimal(10,2) DEFAULT NULL COMMENT 'NULL means data not available',
  `currency` varchar(3) COLLATE utf8mb4_unicode_ci DEFAULT 'TRY',
  `notes` text COLLATE utf8mb4_unicode_ci COMMENT 'Additional notes about pricing or availability',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_city` (`city_name`),
  KEY `idx_price` (`price_per_m3`)
) ENGINE=InnoDB AUTO_INCREMENT=82 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `water_tariffs`
--

LOCK TABLES `water_tariffs` WRITE;
/*!40000 ALTER TABLE `water_tariffs` DISABLE KEYS */;
INSERT INTO `water_tariffs` VALUES (1,'Adana',23.40,'TRY',NULL,'2025-06-03 10:33:41','2025-06-03 10:33:41'),(2,'Adıyaman',NULL,'TRY',NULL,'2025-06-03 10:33:41','2025-06-03 10:33:41'),(3,'Afyonkarahisar',16.00,'TRY',NULL,'2025-06-03 10:33:41','2025-06-03 10:33:41'),(4,'Ağrı',NULL,'TRY',NULL,'2025-06-03 10:33:41','2025-06-03 10:33:41'),(5,'Aksaray',15.00,'TRY',NULL,'2025-06-03 10:33:41','2025-06-03 10:33:41'),(6,'Amasya',18.63,'TRY',NULL,'2025-06-03 10:33:41','2025-06-03 10:33:41'),(7,'Ankara',37.85,'TRY',NULL,'2025-06-03 10:33:41','2025-06-03 10:33:41'),(8,'Antalya',50.34,'TRY',NULL,'2025-06-03 10:33:41','2025-06-03 10:33:41'),(9,'Ardahan',10.38,'TRY',NULL,'2025-06-03 10:33:41','2025-06-03 10:33:41'),(10,'Artvin',NULL,'TRY',NULL,'2025-06-03 10:33:41','2025-06-03 10:33:41'),(11,'Aydın',NULL,'TRY',NULL,'2025-06-03 10:33:41','2025-06-03 10:33:41'),(12,'Balıkesir',52.67,'TRY',NULL,'2025-06-03 10:33:41','2025-06-03 10:33:41'),(13,'Bartın',12.00,'TRY',NULL,'2025-06-03 10:33:41','2025-06-03 10:33:41'),(14,'Batman',NULL,'TRY',NULL,'2025-06-03 10:33:41','2025-06-03 10:33:41'),(15,'Bayburt',NULL,'TRY',NULL,'2025-06-03 10:33:41','2025-06-03 10:33:41'),(16,'Bilecik',10.00,'TRY',NULL,'2025-06-03 10:33:41','2025-06-03 10:33:41'),(17,'Bingöl',11.00,'TRY',NULL,'2025-06-03 10:33:41','2025-06-03 10:33:41'),(18,'Bitlis',NULL,'TRY',NULL,'2025-06-03 10:33:41','2025-06-03 10:33:41'),(19,'Bolu',NULL,'TRY',NULL,'2025-06-03 10:33:41','2025-06-03 10:33:41'),(20,'Burdur',NULL,'TRY',NULL,'2025-06-03 10:33:41','2025-06-03 10:33:41'),(21,'Bursa',41.29,'TRY',NULL,'2025-06-03 10:33:41','2025-06-03 10:33:41'),(22,'Çanakkale',30.00,'TRY',NULL,'2025-06-03 10:33:41','2025-06-03 10:33:41'),(23,'Çankırı',25.50,'TRY',NULL,'2025-06-03 10:33:41','2025-06-03 10:33:41'),(24,'Çorum',25.00,'TRY',NULL,'2025-06-03 10:33:41','2025-06-03 10:33:41'),(25,'Denizli',NULL,'TRY',NULL,'2025-06-03 10:33:41','2025-06-03 10:33:41'),(26,'Diyarbakır',32.38,'TRY',NULL,'2025-06-03 10:33:41','2025-06-03 10:33:41'),(27,'Düzce',36.12,'TRY',NULL,'2025-06-03 10:33:41','2025-06-03 10:33:41'),(28,'Edirne',22.65,'TRY',NULL,'2025-06-03 10:33:41','2025-06-03 10:33:41'),(29,'Elazığ',6.00,'TRY',NULL,'2025-06-03 10:33:41','2025-06-03 10:33:41'),(30,'Erzincan',NULL,'TRY',NULL,'2025-06-03 10:33:41','2025-06-03 10:33:41'),(31,'Erzurum',17.00,'TRY',NULL,'2025-06-03 10:33:41','2025-06-03 10:33:41'),(32,'Eskişehir',26.00,'TRY',NULL,'2025-06-03 10:33:41','2025-06-03 10:33:41'),(33,'Gaziantep',27.80,'TRY',NULL,'2025-06-03 10:33:41','2025-06-03 10:33:41'),(34,'Giresun',NULL,'TRY',NULL,'2025-06-03 10:33:41','2025-06-03 10:33:41'),(35,'Gümüşhane',NULL,'TRY',NULL,'2025-06-03 10:33:41','2025-06-03 10:33:41'),(36,'Hakkâri',NULL,'TRY',NULL,'2025-06-03 10:33:41','2025-06-03 10:33:41'),(37,'Hatay',28.82,'TRY',NULL,'2025-06-03 10:33:41','2025-06-03 10:33:41'),(38,'Iğdır',NULL,'TRY',NULL,'2025-06-03 10:33:41','2025-06-03 10:33:41'),(39,'Isparta',NULL,'TRY',NULL,'2025-06-03 10:33:41','2025-06-03 10:33:41'),(40,'İstanbul',43.00,'TRY',NULL,'2025-06-03 10:33:41','2025-06-03 10:33:41'),(41,'İzmir',47.89,'TRY',NULL,'2025-06-03 10:33:41','2025-06-03 10:33:41'),(42,'Kahramanmaraş',18.00,'TRY',NULL,'2025-06-03 10:33:41','2025-06-03 10:33:41'),(43,'Karabük',NULL,'TRY',NULL,'2025-06-03 10:33:41','2025-06-03 10:33:41'),(44,'Karaman',12.00,'TRY',NULL,'2025-06-03 10:33:41','2025-06-03 10:33:41'),(45,'Kars',NULL,'TRY',NULL,'2025-06-03 10:33:41','2025-06-03 10:33:41'),(46,'Kastamonu',10.00,'TRY',NULL,'2025-06-03 10:33:41','2025-06-03 10:33:41'),(47,'Kayseri',32.43,'TRY',NULL,'2025-06-03 10:33:41','2025-06-03 10:33:41'),(48,'Kırıkkale',NULL,'TRY',NULL,'2025-06-03 10:33:41','2025-06-03 10:33:41'),(49,'Kırklareli',40.00,'TRY',NULL,'2025-06-03 10:33:41','2025-06-03 10:33:41'),(50,'Kırşehir',NULL,'TRY',NULL,'2025-06-03 10:33:41','2025-06-03 10:33:41'),(51,'Kilis',NULL,'TRY',NULL,'2025-06-03 10:33:41','2025-06-03 10:33:41'),(52,'Kocaeli',36.01,'TRY',NULL,'2025-06-03 10:33:41','2025-06-03 10:33:41'),(53,'Konya',46.62,'TRY',NULL,'2025-06-03 10:33:41','2025-06-03 10:33:41'),(54,'Kütahya',NULL,'TRY',NULL,'2025-06-03 10:33:41','2025-06-03 10:33:41'),(55,'Malatya',17.37,'TRY',NULL,'2025-06-03 10:33:41','2025-06-03 10:33:41'),(56,'Manisa',40.43,'TRY',NULL,'2025-06-03 10:33:41','2025-06-03 10:33:41'),(57,'Mardin',8.80,'TRY',NULL,'2025-06-03 10:33:41','2025-06-03 10:33:41'),(58,'Mersin',37.62,'TRY',NULL,'2025-06-03 10:33:41','2025-06-03 10:33:41'),(59,'Muğla',66.73,'TRY',NULL,'2025-06-03 10:33:41','2025-06-03 10:33:41'),(60,'Muş',8.85,'TRY',NULL,'2025-06-03 10:33:41','2025-06-03 10:33:41'),(61,'Nevşehir',NULL,'TRY',NULL,'2025-06-03 10:33:41','2025-06-03 10:33:41'),(62,'Niğde',12.22,'TRY',NULL,'2025-06-03 10:33:41','2025-06-03 10:33:41'),(63,'Ordu',20.09,'TRY',NULL,'2025-06-03 10:33:41','2025-06-03 10:33:41'),(64,'Osmaniye',14.00,'TRY',NULL,'2025-06-03 10:33:41','2025-06-03 10:33:41'),(65,'Rize',NULL,'TRY',NULL,'2025-06-03 10:33:41','2025-06-03 10:33:41'),(66,'Sakarya',14.58,'TRY',NULL,'2025-06-03 10:33:41','2025-06-03 10:33:41'),(67,'Samsun',39.67,'TRY',NULL,'2025-06-03 10:33:41','2025-06-03 10:33:41'),(68,'Şanlıurfa',17.21,'TRY',NULL,'2025-06-03 10:33:41','2025-06-03 10:33:41'),(69,'Siirt',7.00,'TRY',NULL,'2025-06-03 10:33:41','2025-06-03 10:33:41'),(70,'Sinop',NULL,'TRY',NULL,'2025-06-03 10:33:41','2025-06-03 10:33:41'),(71,'Şırnak',12.00,'TRY',NULL,'2025-06-03 10:33:41','2025-06-03 10:33:41'),(72,'Sivas',13.00,'TRY',NULL,'2025-06-03 10:33:41','2025-06-03 10:33:41'),(73,'Tekirdağ',36.31,'TRY',NULL,'2025-06-03 10:33:41','2025-06-03 10:33:41'),(74,'Tokat',NULL,'TRY',NULL,'2025-06-03 10:33:41','2025-06-03 10:33:41'),(75,'Trabzon',24.90,'TRY',NULL,'2025-06-03 10:33:41','2025-06-03 10:33:41'),(76,'Tunceli',NULL,'TRY',NULL,'2025-06-03 10:33:41','2025-06-03 10:33:41'),(77,'Uşak',NULL,'TRY',NULL,'2025-06-03 10:33:41','2025-06-03 10:33:41'),(78,'Van',12.22,'TRY',NULL,'2025-06-03 10:33:41','2025-06-03 10:33:41'),(79,'Yalova',NULL,'TRY',NULL,'2025-06-03 10:33:41','2025-06-03 10:33:41'),(80,'Yozgat',NULL,'TRY',NULL,'2025-06-03 10:33:41','2025-06-03 10:33:41'),(81,'Zonguldak',NULL,'TRY',NULL,'2025-06-03 10:33:41','2025-06-03 10:33:41');
/*!40000 ALTER TABLE `water_tariffs` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-06-03 11:36:55
