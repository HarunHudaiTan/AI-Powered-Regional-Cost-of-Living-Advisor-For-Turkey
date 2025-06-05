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
-- Table structure for table `city_transportation`
--

DROP TABLE IF EXISTS `city_transportation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `city_transportation` (
  `id` int NOT NULL AUTO_INCREMENT,
  `city_name` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `transport_type` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `category` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `price` decimal(6,2) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=249 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `city_transportation`
--

LOCK TABLES `city_transportation` WRITE;
/*!40000 ALTER TABLE `city_transportation` DISABLE KEYS */;
INSERT INTO `city_transportation` VALUES (1,'adana','Belediye Otobüsü, Hafif Raylı Sistem','Tam',27.00),(2,'adana','Belediye Otobüsü, Hafif Raylı Sistem','Öğrenci',13.00),(3,'adana','Belediye Otobüsü, Hafif Raylı Sistem','Öğretmen',23.00),(4,'adana','Halk Otobüsü','Tam',29.00),(5,'adana','Halk Otobüsü','Öğrenci',16.50),(6,'adana','Halk Otobüsü','Öğretmen',26.00),(7,'adana','Dolmuş Minibüsü','Tam',30.00),(8,'adana','Dolmuş Minibüsü','Öğrenci',17.00),(9,'adiyaman','Belediye Otobüsü','Tam',14.00),(10,'adiyaman','Belediye Otobüsü','Öğrenci',10.00),(11,'afyonkarahisar','Halk Otobüsü','Tam',14.00),(12,'afyonkarahisar','Halk Otobüsü','Öğrenci',12.00),(13,'afyonkarahisar','Minibüs','Tam',20.00),(14,'afyonkarahisar','Minibüs','Öğrenci',15.00),(15,'agri','Belediye Otobüsü','Tam',13.00),(16,'agri','Belediye Otobüsü','İndirimli',8.00),(17,'amasya','Halk Otobüsü','Tam',18.00),(18,'amasya','Halk Otobüsü','Öğrenci',13.00),(19,'ankara','Belediye ve Özel Otobüsler, Ankaray, Metro, Başkentray','Tam',26.00),(20,'ankara','Belediye ve Özel Otobüsler, Ankaray, Metro, Başkentray','Öğrenci',13.00),(21,'antalya','Otobüsler, Raylı Ulaşım','Tam',27.00),(22,'antalya','Otobüsler, Raylı Ulaşım','Öğrenci',12.00),(23,'antalya','Otobüsler, Raylı Ulaşım','İndirimli',26.00),(24,'artvin','Dolmuş','Tam',25.00),(25,'artvin','Dolmuş','Öğrenci',20.00),(26,'aydin','Halk Otobüsü','Tam',25.00),(27,'aydin','Halk Otobüsü','İndirimli',16.50),(28,'balikesir','Belediye Otobüsü','Tam',24.00),(29,'balikesir','Belediye Otobüsü','Öğrenci',16.00),(30,'balikesir','Belediye Otobüsü','65 Yaş Üstü',19.25),(31,'bilecik','Halk Otobüsü','Tam',25.00),(32,'bilecik','Halk Otobüsü','Öğrenci',17.00),(33,'bingol','Halk Otobüsü','Tam',14.00),(34,'bingol','Halk Otobüsü','Öğrenci',10.00),(35,'bitlis','Halk Otobüsü','Tam',17.50),(36,'bitlis','Halk Otobüsü','Öğrenci',11.00),(37,'bolu','Halk Otobüsü','Tam',25.00),(38,'bolu','Halk Otobüsü','Öğrenci',18.00),(39,'burdur','Halk Otobüsü','Tam',22.00),(40,'burdur','Halk Otobüsü','Üniversite Öğrencisi',17.00),(41,'burdur','Halk Otobüsü','İlköğretim ve Lise Öğrencileri',12.00),(42,'bursa','Belediye Otobüsü','Tam',20.15),(43,'bursa','Belediye Otobüsü','Öğrenci',5.05),(44,'bursa','Belediye Otobüsü','İndirimli',18.15),(45,'bursa','Raylı Ulaşım (Bursaray)','Tam',26.00),(46,'bursa','Raylı Ulaşım (Bursaray)','Öğrenci',6.50),(47,'bursa','Raylı Ulaşım (Bursaray)','İndirimli',23.25),(48,'canakkale','Belediye Otobüsü','Tam',25.00),(49,'canakkale','Belediye Otobüsü','Öğrenci',15.00),(50,'canakkale','Feribot (Çanakkale - Eceabat Hattı)','Tam',27.00),(51,'canakkale','Feribot (Çanakkale - Eceabat Hattı)','Öğrenci',7.50),(52,'canakkale','Feribot (Çanakkale - Eceabat Hattı)','65 Yaş Üstü',15.00),(53,'cankiri','Halk Otobüsü','Tam',15.00),(54,'cankiri','Halk Otobüsü','Öğrenci',12.00),(55,'corum','Halk Otobüsü','Tam',17.50),(56,'corum','Halk Otobüsü','Öğrenci',12.00),(57,'denizli','Belediye Otobüsü','Tam',17.00),(58,'denizli','Belediye Otobüsü','Öğrenci',10.00),(59,'denizli','Minibüs','Tam',22.00),(60,'denizli','Minibüs','Öğrenci',17.00),(61,'diyarbakir','Belediye Otobüsü','Tam',20.00),(62,'diyarbakir','Belediye Otobüsü','İndirimli',15.00),(63,'diyarbakir','Belediye Otobüsü','Öğrenci',10.00),(64,'diyarbakir','Minibüs','Tam',25.00),(65,'diyarbakir','Minibüs','Öğrenci',15.00),(66,'diyarbakir','Halk Otobüsü','Tam',16.00),(67,'diyarbakir','Halk Otobüsü','İndirimli',14.00),(68,'diyarbakir','Halk Otobüsü','Öğrenci',9.00),(69,'edirne','Belediye Otobüsü','Tam',26.45),(70,'edirne','Belediye Otobüsü','Öğrenci',16.30),(71,'edirne','Minibüs','Tam',25.00),(72,'elazig','Belediye Otobüsü','Tam',18.00),(73,'elazig','Belediye Otobüsü','İndirimli',13.00),(74,'elazig','Minibüs','Tam',20.00),(75,'elazig','Minibüs','Öğrenci',15.00),(76,'erzincan','Halk Otobüsü','Tam',20.40),(77,'erzincan','Halk Otobüsü','Öğrenci',16.80),(78,'erzurum','Belediye Otobüsü','Tam',18.00),(79,'erzurum','Belediye Otobüsü','Öğrenci',13.00),(80,'erzurum','Belediye Otobüsü','Öğretmen',17.50),(81,'erzurum','Minibüs','Tam',18.00),(82,'erzurum','Minibüs','Öğrenci',13.00),(83,'eskisehir','Belediye Otobüsü, Tramvay','Tam',25.00),(84,'eskisehir','Belediye Otobüsü, Tramvay','İndirimli',12.50),(85,'gaziantep','Belediye Otobüsü','Tam',26.00),(86,'gaziantep','Belediye Otobüsü','Öğrenci',13.00),(87,'gaziantep','Belediye Otobüsü','İndirimli',22.50),(88,'giresun','Dolmuş','Tam',25.00),(89,'giresun','Dolmuş','Öğrenci',17.00),(90,'gumushane','Belediye Otobüsü','Tam',20.00),(91,'gumushane','Belediye Otobüsü','Öğrenci',17.00),(92,'gumushane','Dolmuş','Tam',25.00),(93,'gumushane','Dolmuş','Öğrenci',20.00),(94,'hakkari','Belediye Otobüsü','Tam',12.00),(95,'hakkari','Belediye Otobüsü','Öğrenci',8.00),(96,'hatay','Belediye Otobüsü','Tam',20.00),(97,'hatay','Belediye Otobüsü','Öğrenci',14.00),(98,'isparta','Belediye Otobüsü','Tam',18.00),(99,'isparta','Belediye Otobüsü','Öğrenci',14.00),(100,'mersin','Belediye Otobüsü','Tam',25.00),(101,'mersin','Belediye Otobüsü','Öğrenci',13.00),(102,'mersin','Belediye Otobüsü','İndirimli',22.00),(103,'mersin','Belediye Otobüsü','Öğretmen',23.00),(104,'mersin','Dolmuş','Tam',30.00),(105,'mersin','Dolmuş','Öğrenci',20.00),(106,'istanbul','Otobüsler, Metro, Tramvay, Teleferik','Tam',27.00),(107,'istanbul','Otobüsler, Metro, Tramvay, Teleferik','Öğrenci',13.18),(108,'istanbul','Otobüsler, Metro, Tramvay, Teleferik','İndirimli',19.33),(109,'istanbul','Marmaray (Ortalama Fiyatlar)','Tam',43.63),(110,'istanbul','Marmaray (Ortalama Fiyatlar)','Öğrenci',20.59),(111,'istanbul','Marmaray (Ortalama Fiyatlar)','İndirimli',30.74),(112,'istanbul','Metrobüs (Ortalama Fiyatlar)','Tam',31.53),(113,'istanbul','Metrobüs (Ortalama Fiyatlar)','Öğrenci',11.98),(114,'istanbul','Metrobüs (Ortalama Fiyatlar)','İndirimli',18.60),(115,'istanbul','Vapur ve Deniz Motorları (Ortalama Fiyatlar)','Tam',44.42),(116,'istanbul','Vapur ve Deniz Motorları (Ortalama Fiyatlar)','Öğrenci',22.08),(117,'istanbul','Vapur ve Deniz Motorları (Ortalama Fiyatlar)','İndirimli',31.35),(118,'izmir','Otobüsler, Metro, Vapur','Tam',25.00),(119,'izmir','Otobüsler, Metro, Vapur','Öğrenci',10.00),(120,'izmir','Otobüsler, Metro, Vapur','İndirimli',20.00),(121,'izmir','Otobüsler, Metro, Vapur','Öğretmen',17.72),(122,'kars','Dolmuş','Tam',25.00),(123,'kars','Dolmuş','Öğrenci',20.00),(124,'kastamonu','Halk Otobüsü','Tam',20.00),(125,'kastamonu','Halk Otobüsü','Öğrenci',13.00),(126,'kayseri','Otobüsler, Raylı Ulaşım','Tam',25.00),(127,'kayseri','Otobüsler, Raylı Ulaşım','İndirimli',13.75),(128,'kayseri','Otobüsler, Raylı Ulaşım','Öğretmen',20.00),(129,'kirklareli','Halk Otobüsü','Tam',25.00),(130,'kirklareli','Halk Otobüsü','İndirimli',20.00),(131,'kirsehir','Otobüs','Tam',19.00),(132,'kirsehir','Otobüs','Öğrenci',13.00),(133,'kirsehir','Dolmuş','Tam',15.00),(134,'kirsehir','Dolmuş','Öğrenci',12.00),(135,'kocaeli (izmit)','Otobüs, Minibüs','Tam',27.00),(136,'kocaeli (izmit)','Otobüs, Minibüs','İndirimli',17.50),(137,'kocaeli (izmit)','Tramvay','Tam',23.00),(138,'kocaeli (izmit)','Tramvay','İndirimli',13.50),(139,'kocaeli (izmit)','Deniz Ulaşımı','Tam',32.00),(140,'kocaeli (izmit)','Deniz Ulaşımı','İndirimli',24.00),(141,'konya','Otobüs, Tramvay','Tam',17.50),(142,'konya','Otobüs, Tramvay','Öğrenci',6.75),(143,'konya','Dolmuş','Herkes',20.00),(144,'kutahya','Halk Otobüsü','Tam',24.00),(145,'kutahya','Halk Otobüsü','Üniversite Öğrencisi',19.00),(146,'kutahya','Halk Otobüsü','İlköğretim ve Lise Öğrencileri',13.00),(147,'malatya','Otobüs, Trambüs','Tam',14.00),(148,'malatya','Otobüs, Trambüs','Öğrenci',9.00),(149,'manisa','Otobüs','Tam',20.00),(150,'manisa','Otobüs','Öğrenci',12.20),(151,'kahramanmaras','Otobüs','Tam',16.50),(152,'kahramanmaras','Otobüs','Öğrenci',9.00),(153,'kahramanmaras','Otobüs','Öğretmen',16.00),(154,'mardin','Otobüs','Tam',18.50),(155,'mardin','Otobüs','Öğrenci',12.00),(156,'mugla','Otobüs','Tam',29.00),(157,'mugla','Otobüs','İndirimli',23.00),(158,'mugla','Otobüs','Öğrenci',18.00),(159,'mus','Otobüs','Tam',17.00),(160,'mus','Otobüs','Öğrenci',12.00),(161,'nevsehir','Otobüs','Tam',20.00),(162,'nevsehir','Otobüs','İndirimli',14.00),(163,'nigde','Otobüs','Tam',20.00),(164,'nigde','Otobüs','Öğrenci',13.50),(165,'ordu','Otobüs','Tam',26.00),(166,'ordu','Otobüs','Öğrenci',15.85),(167,'rize','Halk Otobüsü','Tam',26.00),(168,'rize','Halk Otobüsü','Öğrenci',18.00),(169,'rize','Dolmuş','Tam',23.00),(170,'rize','Dolmuş','Öğrenci',17.00),(171,'sakarya (adapazari)','Otobüs','Tam',13.50),(172,'sakarya (adapazari)','Otobüs','Öğrenci',4.35),(173,'sakarya (adapazari)','Otobüs','60 - 65 Yaş',6.75),(174,'sakarya (adapazari)','Otobüs','Öğretmen',11.48),(175,'sakarya (adapazari)','Minibüs','Tam',19.50),(176,'sakarya (adapazari)','Minibüs','Öğrenci',17.50),(177,'sakarya (adapazari)','Adaray','Tam',15.00),(178,'sakarya (adapazari)','Adaray','Öğrenci',4.83),(179,'sakarya (adapazari)','Adaray','60 - 65 Yaş',7.50),(180,'sakarya (adapazari)','Adaray','Öğretmen',12.75),(181,'samsun','Otobüs, Tramvay','Tam',17.00),(182,'samsun','Otobüs, Tramvay','Öğrenci',11.00),(183,'samsun','Minibüs','Tam',24.00),(184,'samsun','Minibüs','Öğrenci',18.00),(185,'siirt','Belediye Otobüsü','Tam',12.00),(186,'siirt','Belediye Otobüsü','Öğrenci',9.00),(187,'siirt','Minibüs','Tam',10.00),(188,'siirt','Minibüs','Öğrenci',7.50),(189,'sinop','Otobüs','Tam',25.00),(190,'sinop','Otobüs','Öğrenci',20.00),(191,'sivas','Otobüs','Tam',21.00),(192,'sivas','Otobüs','Öğrenci',14.00),(193,'tekirdag','Otobüs','Tam',25.00),(194,'tekirdag','Otobüs','İndirimli',13.00),(195,'tokat','Belediye Otobüsü','Tam',17.50),(196,'tokat','Belediye Otobüsü','Öğrenci',13.50),(197,'trabzon','Otobüs','Tam',22.00),(198,'trabzon','Otobüs','İndirimli',17.50),(199,'trabzon','Otobüs','Öğrenci',10.00),(200,'trabzon','Dolmuş','Tam',25.00),(201,'trabzon','Dolmuş','Öğrenci',18.00),(202,'tunceli','Otobüs','Tam',20.00),(203,'tunceli','Otobüs','Öğrenci',9.76),(204,'sanliurfa','Belediye Otobüsü','Tam',17.50),(205,'sanliurfa','Belediye Otobüsü','İndirimli',10.00),(206,'usak','Otobüs','Tam',22.00),(207,'usak','Otobüs','Öğrenci',16.00),(208,'van','Otobüs','Tam',19.00),(209,'van','Otobüs','Öğrenci',11.70),(210,'yozgat','Halk Otobüsü','Tam',20.00),(211,'yozgat','Halk Otobüsü','Öğrenci',15.00),(212,'zonguldak','Otobüs','Tam',27.00),(213,'zonguldak','Otobüs','Öğrenci',17.00),(214,'aksaray','Halk Otobüsü','Tam',20.00),(215,'aksaray','Halk Otobüsü','İndirimli',13.00),(216,'bayburt','Dolmuş','Tam',18.00),(217,'bayburt','Dolmuş','İndirimli',15.00),(218,'karaman','Otobüs','Tam',4.00),(219,'karaman','Otobüs','Öğrenci',2.00),(220,'karaman','Dolmuş','Herkes',20.00),(221,'kirikkale','Belediye Otobüsü','Tam',14.00),(222,'kirikkale','Belediye Otobüsü','Öğrenci',11.00),(223,'kirikkale','Minibüs','Tam',17.00),(224,'kirikkale','Minibüs','Öğrenci',15.00),(225,'batman','Belediye Otobüsü','Tam',15.00),(226,'batman','Belediye Otobüsü','Öğrenci',12.00),(227,'batman','Minibüs','Tam',20.00),(228,'batman','Minibüs','Öğrenci',15.00),(229,'sirnak','Belediye Otobüsü','Tam',15.00),(230,'sirnak','Belediye Otobüsü','Öğrenci',12.00),(231,'bartin','Halk Otobüsü','Tam',23.00),(232,'bartin','Halk Otobüsü','İndirimli',15.00),(233,'ardahan','Dolmuş','Tam',20.00),(234,'ardahan','Dolmuş','Öğrenci',15.00),(235,'igdir','Otobüs','Tam',15.00),(236,'igdir','Otobüs','Öğrenci',8.00),(237,'yalova','Minibüs','Tam',25.00),(238,'yalova','Minibüs','Öğrenci',20.00),(239,'karabuk','Otobüs','Tam',20.50),(240,'karabuk','Otobüs','İndirimli',16.00),(241,'kilis','Halk Otobüsü','Tam',20.00),(242,'kilis','Halk Otobüsü','Öğrenci',15.00),(243,'osmaniye','Otobüs','Tam',25.00),(244,'osmaniye','Otobüs','Öğrenci',15.00),(245,'osmaniye','Dolmuş','Tam',25.00),(246,'osmaniye','Dolmuş','Öğrenci',20.00),(247,'duzce','Otobüs','Tam',24.00),(248,'duzce','Otobüs','İndirimli',15.00);
/*!40000 ALTER TABLE `city_transportation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `electricity_tariffs`
--

DROP TABLE IF EXISTS `electricity_tariffs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `electricity_tariffs` (
  `id` int NOT NULL AUTO_INCREMENT,
  `tariff_type` enum('single_time','three_time') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `time_period` enum('day','peak','night','single') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `consumption_threshold` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'e.g., above_8kwh_per_day, below_8kwh_per_day',
  `price_per_kwh` decimal(10,6) NOT NULL,
  `currency` varchar(3) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT 'TRY',
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
  `tariff_type` enum('single_time','three_time') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `calculated_amount` decimal(10,2) NOT NULL,
  `currency` varchar(3) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT 'TRY',
  `calculation_notes` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
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
  `package_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `speed_mbps` int NOT NULL,
  `monthly_price` decimal(10,2) NOT NULL,
  `currency` varchar(3) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT 'TRY',
  `contract_required` tinyint(1) DEFAULT '0',
  `contract_months` int DEFAULT '0',
  `promotional_price` decimal(10,2) DEFAULT NULL,
  `promotional_months` int DEFAULT '0',
  `features` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT 'Special features or notes',
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
  `provider_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `provider_type` enum('fiber','adsl','vdsl','cable') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT 'fiber',
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
  `test_period` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'e.g., August 2024',
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
  `city_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `price_per_m3` decimal(10,2) DEFAULT NULL COMMENT 'NULL means service not available',
  `currency` varchar(3) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT 'TRY',
  `notes` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT 'Additional notes about pricing or availability',
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
  `type_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `type_name_en` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'English translation',
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
-- Table structure for table `water_tariffs`
--

DROP TABLE IF EXISTS `water_tariffs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `water_tariffs` (
  `id` int NOT NULL AUTO_INCREMENT,
  `city_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `price_per_m3` decimal(10,2) DEFAULT NULL COMMENT 'NULL means data not available',
  `currency` varchar(3) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT 'TRY',
  `notes` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT 'Additional notes about pricing or availability',
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

-- Dump completed on 2025-06-05 14:04:11
