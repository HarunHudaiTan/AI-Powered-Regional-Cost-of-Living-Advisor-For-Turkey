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
-- Table structure for table `districts`
--

DROP TABLE IF EXISTS `districts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `districts` (
  `id` int NOT NULL AUTO_INCREMENT,
  `district_name` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `province_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_district_name` (`district_name`),
  KEY `idx_province_id` (`province_id`),
  KEY `idx_district_province_name` (`district_name`,`province_id`),
  CONSTRAINT `districts_ibfk_1` FOREIGN KEY (`province_id`) REFERENCES `provinces` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=974 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `districts`
--

LOCK TABLES `districts` WRITE;
/*!40000 ALTER TABLE `districts` DISABLE KEYS */;
INSERT INTO `districts` VALUES (808,'19 Mayıs',67),(548,'Abana',46),(740,'Acıgöl',61),(273,'Acıpayam',25),(183,'Adaklı',17),(448,'Adalar',40),(792,'Adapazarı',66),(191,'Adilcevaz',18),(517,'Afşin',42),(51,'Ağaçören',5),(326,'Ağın',29),(207,'Ağlasun',20),(549,'Ağlı',46),(624,'Ahırlı',53),(192,'Ahlat',18),(681,'Ahmetli',56),(901,'Akçaabat',75),(668,'Akçadağ',55),(825,'Akçakale',68),(605,'Akçakent',51),(309,'Akçakoca',27),(952,'Akdağmadeni',80),(708,'Akdeniz',58),(682,'Akhisar',56),(861,'Akıncılar',72),(568,'Akkışla',47),(754,'Akkuş',63),(625,'Akören',53),(606,'Akpınar',51),(626,'Akşehir',53),(91,'Akseki',8),(92,'Aksu',8),(435,'Aksu',39),(540,'Akyaka',45),(793,'Akyazı',66),(66,'Akyurt',7),(259,'Alaca',24),(327,'Alacakaya',29),(809,'Alaçam',67),(1,'Aladağ',1),(93,'Alanya',8),(966,'Alaplı',81),(683,'Alaşehir',56),(487,'Aliağa',41),(889,'Almus',74),(366,'Alpu',32),(142,'Altıeylül',12),(67,'Altındağ',7),(627,'Altınekin',53),(755,'Altınordu',63),(946,'Altınova',79),(416,'Altınözü',37),(655,'Altıntaş',54),(208,'Altınyayla',20),(862,'Altınyayla',72),(748,'Altunhisar',62),(389,'Alucra',34),(162,'Amasra',13),(709,'Anamur',58),(518,'Andırın',42),(417,'Antakya',37),(380,'Araban',33),(550,'Araç',46),(902,'Araklı',75),(431,'Aralık',38),(669,'Arapgir',55),(116,'Ardanuç',10),(780,'Ardeşen',65),(670,'Arguvan',55),(117,'Arhavi',10),(794,'Arifiye',66),(328,'Arıcak',29),(947,'Armutlu',79),(449,'Arnavutköy',40),(541,'Arpaçay',45),(903,'Arsin',75),(418,'Arsuz',37),(890,'Artova',74),(698,'Artuklu',57),(810,'Asarcık',67),(346,'Aşkale',31),(656,'Aslanapa',54),(436,'Atabey',39),(811,'Atakum',67),(450,'Ataşehir',40),(247,'Atkaracalar',23),(741,'Avanos',61),(451,'Avcılar',40),(845,'Ayancık',70),(68,'Ayaş',7),(756,'Aybastı',63),(710,'Aydıncık',58),(953,'Aydıncık',80),(172,'Aydıntepe',15),(534,'Ayrancı',44),(235,'Ayvacık',22),(812,'Ayvacık',67),(143,'Ayvalık',12),(551,'Azdavay',46),(347,'Aziziye',31),(274,'Babadağ',25),(597,'Babaeski',50),(813,'Bafra',67),(452,'Bağcılar',40),(292,'Bağlar',26),(773,'Bahçe',64),(453,'Bahçelievler',40),(933,'Bahçesaray',78),(588,'Bahşılı',49),(454,'Bakırköy',40),(275,'Baklan',25),(69,'Bala',7),(488,'Balçova',41),(589,'Balışeyh',49),(144,'Balya',12),(927,'Banaz',77),(145,'Bandırma',12),(455,'Başakşehir',40),(891,'Başçiftlik',74),(612,'Başiskele',52),(934,'Başkale',78),(329,'Baskil',29),(25,'Başmakçı',3),(535,'Başyayla',44),(671,'Battalgazi',55),(26,'Bayat',3),(260,'Bayat',24),(489,'Bayındır',41),(838,'Baykan',69),(490,'Bayraklı',41),(236,'Bayramiç',22),(248,'Bayramören',23),(456,'Bayrampaşa',40),(276,'Bekilli',25),(419,'Belen',37),(491,'Bergama',41),(904,'Beşikdüzü',75),(457,'Beşiktaş',40),(166,'Beşiri',14),(16,'Besni',2),(277,'Beyağaç',25),(492,'Beydağ',41),(458,'Beykoz',40),(459,'Beylikdüzü',40),(367,'Beylikova',32),(460,'Beyoğlu',40),(70,'Beypazarı',7),(628,'Beyşehir',53),(854,'Beytüşşebap',71),(237,'Biga',22),(146,'Bigadiç',12),(826,'Birecik',68),(293,'Bismil',26),(721,'Bodrum',59),(261,'Boğazkale',24),(954,'Boğazlıyan',80),(27,'Bolvadin',3),(749,'Bor',62),(118,'Borçka',10),(493,'Bornova',41),(846,'Boyabat',70),(238,'Bozcaada',22),(125,'Bozdoğan',11),(629,'Bozkır',53),(278,'Bozkurt',25),(552,'Bozkurt',46),(827,'Bozova',68),(607,'Boztepe',51),(175,'Bozüyük',16),(711,'Bozyazı',58),(494,'Buca',41),(209,'Bucak',20),(126,'Buharkent',11),(390,'Bulancak',34),(734,'Bulanık',60),(279,'Buldan',25),(569,'Bünyan',47),(147,'Burhaniye',12),(461,'Büyükçekmece',40),(218,'Büyükorhan',21),(519,'Çağlayancerit',42),(280,'Çal',25),(935,'Çaldıran',78),(750,'Çamardı',62),(757,'Çamaş',63),(281,'Çameli',25),(71,'Çamlıdere',7),(781,'Çamlıhemşin',65),(712,'Çamlıyayla',58),(391,'Çamoluk',34),(239,'Çan',22),(392,'Çanakçı',34),(955,'Çandır',80),(814,'Canik',67),(72,'Çankaya',7),(282,'Çardak',25),(815,'Çarşamba',67),(905,'Çarşıbaşı',75),(348,'Çat',31),(936,'Çatak',78),(462,'Çatalca',40),(758,'Çatalpınar',63),(553,'Çatalzeytin',46),(657,'Çavdarhisar',54),(210,'Çavdır',20),(28,'Çay',3),(759,'Çaybaşı',63),(967,'Çaycuma',81),(782,'Çayeli',65),(956,'Çayıralan',80),(337,'Çayırlı',30),(613,'Çayırova',52),(906,'Çaykara',75),(957,'Çekerek',80),(463,'Çekmeköy',40),(590,'Çelebi',49),(17,'Çelikhan',2),(630,'Çeltik',53),(211,'Çeltikçi',20),(919,'Çemişgezek',76),(249,'Çerkeş',23),(878,'Çerkezköy',73),(294,'Çermik',26),(495,'Çeşme',41),(2,'Ceyhan',1),(828,'Ceylanpınar',68),(608,'Çiçekdağı',51),(554,'Cide',46),(368,'Çifteler',32),(751,'Çiftlik',62),(948,'Çiftlikköy',79),(496,'Çiğli',41),(631,'Cihanbeyli',53),(310,'Çilimli',27),(127,'Çine',11),(283,'Çivril',25),(855,'Cizre',71),(110,'Çıldır',9),(295,'Çınar',26),(949,'Çınarcık',79),(29,'Çobanlar',3),(879,'Çorlu',73),(73,'Çubuk',7),(411,'Çukurca',36),(3,'Çukurova',1),(311,'Cumayeri',27),(632,'Çumra',53),(296,'Çüngüş',26),(555,'Daday',46),(722,'Dalaman',59),(111,'Damal',9),(672,'Darende',55),(699,'Dargeçit',57),(614,'Darıca',52),(723,'Datça',59),(30,'Dazkırı',3),(420,'Defne',37),(591,'Delice',49),(684,'Demirci',56),(598,'Demirköy',50),(173,'Demirözü',15),(94,'Demre',8),(633,'Derbent',53),(634,'Derebucak',53),(412,'Derecik',36),(393,'Dereli',34),(783,'Derepazarı',65),(700,'Derik',57),(615,'Derince',52),(742,'Derinkuyu',61),(907,'Dernekpazarı',75),(570,'Develi',47),(968,'Devrek',81),(556,'Devrekani',46),(297,'Dicle',26),(128,'Didim',11),(542,'Digor',45),(497,'Dikili',41),(847,'Dikmen',70),(616,'Dilovası',52),(31,'Dinar',3),(863,'Divriği',72),(43,'Diyadin',4),(262,'Dodurga',24),(635,'Doğanhisar',53),(394,'Doğankent',34),(864,'Doğanşar',72),(673,'Doğanşehir',55),(674,'Doğanyol',55),(557,'Doğanyurt',46),(44,'Doğubayazıt',4),(658,'Domaniç',54),(198,'Dörtdivan',19),(421,'Dörtyol',37),(95,'Döşemealtı',8),(520,'Dulkadiroğlu',42),(659,'Dumlupınar',54),(848,'Durağan',70),(148,'Dursunbey',12),(774,'Düziçi',64),(908,'Düzköy',75),(240,'Eceabat',22),(149,'Edremit',12),(937,'Edremit',78),(129,'Efeler',11),(528,'Eflani',43),(298,'Eğil',26),(437,'Eğirdir',39),(521,'Ekinözü',42),(584,'Elbeyli',48),(522,'Elbistan',42),(250,'Eldivan',23),(45,'Eleşkirt',4),(74,'Elmadağ',7),(96,'Elmalı',8),(660,'Emet',54),(32,'Emirdağ',3),(636,'Emirgazi',53),(317,'Enez',28),(892,'Erbaa',74),(938,'Erciş',78),(150,'Erdek',12),(713,'Erdemli',58),(637,'Ereğli',53),(969,'Ereğli',81),(795,'Erenler',66),(849,'Erfelek',70),(299,'Ergani',26),(880,'Ergene',73),(536,'Ermenek',44),(839,'Eruh',69),(422,'Erzin',37),(464,'Esenler',40),(465,'Esenyurt',40),(52,'Eskil',5),(529,'Eskipazar',43),(928,'Eşme',77),(395,'Espiye',34),(75,'Etimesgut',7),(33,'Evciler',3),(76,'Evren',7),(396,'Eynesil',34),(466,'Eyüpsultan',40),(829,'Eyyübiye',68),(241,'Ezine',22),(467,'Fatih',40),(760,'Fatsa',63),(4,'Feke',1),(571,'Felahiye',47),(796,'Ferizli',66),(724,'Fethiye',59),(97,'Finike',8),(784,'Fındıklı',65),(498,'Foça',41),(499,'Gaziemir',41),(468,'Gaziosmanpaşa',40),(98,'Gazipaşa',8),(617,'Gebze',52),(661,'Gediz',54),(438,'Gelendost',39),(242,'Gelibolu',22),(865,'Gemerek',72),(219,'Gemlik',21),(184,'Genç',17),(167,'Gercüş',14),(199,'Gerede',19),(18,'Gerger',2),(130,'Germencik',11),(850,'Gerze',70),(939,'Gevaş',78),(797,'Geyve',66),(243,'Gökçeada',22),(970,'Gökçebey',81),(523,'Göksun',42),(19,'Gölbaşı',2),(77,'Gölbaşı',7),(618,'Gölcük',52),(112,'Göle',9),(212,'Gölhisar',20),(761,'Gölköy',63),(685,'Gölmarmara',56),(866,'Gölova',72),(176,'Gölpazarı',16),(312,'Gölyaka',27),(151,'Gömeç',12),(152,'Gönen',12),(439,'Gönen',39),(686,'Gördes',56),(397,'Görele',34),(59,'Göynücek',6),(200,'Göynük',19),(398,'Güce',34),(856,'Güçlükonak',71),(78,'Güdül',7),(53,'Gülağaç',5),(714,'Gülnar',58),(743,'Gülşehir',61),(762,'Gülyalı',63),(60,'Gümüşhacıköy',6),(313,'Gümüşova',27),(99,'Gündoğmuş',8),(284,'Güney',25),(638,'Güneysınır',53),(785,'Güneysu',65),(469,'Güngören',40),(369,'Günyüzü',32),(763,'Gürgentepe',63),(193,'Güroymak',18),(940,'Gürpınar',78),(220,'Gürsu',21),(867,'Gürün',72),(500,'Güzelbahçe',41),(54,'Güzelyurt',5),(744,'Hacıbektaş',61),(572,'Hacılar',47),(639,'Hadim',53),(868,'Hafik',72),(830,'Halfeti',68),(831,'Haliliye',68),(640,'Halkapınar',53),(61,'Hamamözü',6),(46,'Hamur',4),(370,'Han',32),(113,'Hanak',9),(300,'Hani',26),(558,'Hanönü',46),(221,'Harmancık',21),(832,'Harran',68),(775,'Hasanbeyli',64),(168,'Hasankeyf',14),(735,'Hasköy',60),(423,'Hassa',37),(153,'Havran',12),(318,'Havsa',28),(816,'Havza',67),(79,'Haymana',7),(881,'Hayrabolu',73),(909,'Hayrat',75),(301,'Hazro',26),(675,'Hekimhan',55),(786,'Hemşin',65),(798,'Hendek',66),(833,'Hilvan',68),(662,'Hisarcık',54),(194,'Hizan',18),(349,'Hınıs',31),(34,'Hocalar',3),(285,'Honaz',25),(119,'Hopa',10),(350,'Horasan',31),(920,'Hozat',76),(641,'Hüyük',53),(100,'İbradı',8),(857,'İdil',71),(559,'İhsangazi',46),(35,'İhsaniye',3),(764,'İkizce',63),(787,'İkizdere',65),(251,'Ilgaz',23),(642,'Ilgın',53),(338,'İliç',30),(817,'İlkadım',67),(5,'İmamoğlu',1),(869,'İmranlı',72),(573,'İncesu',47),(131,'İncirliova',11),(560,'İnebolu',46),(222,'İnegöl',21),(177,'İnhisar',16),(371,'İnönü',32),(941,'İpekyolu',78),(319,'İpsala',28),(36,'İscehisar',3),(424,'İskenderun',37),(263,'İskilip',24),(381,'İslahiye',33),(351,'İspir',31),(154,'İvrindi',12),(788,'İyidere',65),(619,'İzmit',52),(223,'İznik',21),(765,'Kabadüz',63),(766,'Kabataş',63),(776,'Kadirli',64),(470,'Kadıköy',40),(643,'Kadınhanı',53),(958,'Kadışehri',80),(471,'Kağıthane',40),(543,'Kağızman',45),(80,'Kahramankazan',7),(20,'Kahta',2),(286,'Kale',25),(676,'Kale',55),(81,'Kalecik',7),(789,'Kalkandere',65),(609,'Kaman',51),(620,'Kandıra',52),(870,'Kangal',72),(882,'Kapaklı',73),(501,'Karabağlar',41),(502,'Karaburun',41),(224,'Karacabey',21),(132,'Karacasu',11),(352,'Karaçoban',31),(929,'Karahallı',77),(6,'Karaisalı',1),(592,'Karakeçili',49),(330,'Karakoçan',29),(834,'Karaköprü',68),(432,'Karakoyunlu',38),(213,'Karamanlı',20),(621,'Karamürsel',52),(644,'Karapınar',53),(799,'Karapürçek',66),(800,'Karasu',66),(7,'Karataş',1),(645,'Karatay',53),(353,'Karayazı',31),(155,'Karesi',12),(264,'Kargı',24),(382,'Karkamış',33),(185,'Karlıova',17),(133,'Karpuzlu',11),(503,'Karşıyaka',41),(472,'Kartal',40),(622,'Kartepe',52),(101,'Kaş',8),(818,'Kavak',67),(725,'Kavaklıdere',59),(302,'Kayapınar',26),(801,'Kaynarca',66),(314,'Kaynaşlı',27),(537,'Kazımkarabekir',44),(331,'Keban',29),(440,'Keçiborlu',39),(82,'Keçiören',7),(225,'Keles',21),(405,'Kelkit',35),(339,'Kemah',30),(340,'Kemaliye',30),(120,'Kemalpaşa',10),(504,'Kemalpaşa',41),(102,'Kemer',8),(214,'Kemer',20),(103,'Kepez',8),(156,'Kepsut',12),(320,'Keşan',28),(399,'Keşap',34),(593,'Keskin',49),(226,'Kestel',21),(186,'Kiğı',17),(971,'Kilimli',81),(506,'Kiraz',41),(201,'Kıbrıscık',19),(505,'Kınık',41),(425,'Kırıkhan',37),(687,'Kırkağaç',56),(83,'Kızılcahamam',7),(252,'Kızılırmak',23),(37,'Kızılören',3),(701,'Kızıltepe',57),(802,'Kocaali',66),(303,'Kocaköy',26),(134,'Koçarlı',11),(574,'Kocasinan',47),(599,'Kofçaz',50),(507,'Konak',41),(104,'Konyaaltı',8),(688,'Köprübaşı',56),(910,'Köprübaşı',75),(354,'Köprüköy',31),(623,'Körfez',52),(767,'Korgan',63),(253,'Korgun',23),(736,'Korkut',60),(105,'Korkuteli',8),(406,'Köse',35),(135,'Köşk',11),(332,'Kovancılar',29),(726,'Köyceğiz',59),(871,'Koyulhisar',72),(745,'Kozaklı',61),(8,'Kozan',1),(972,'Kozlu',81),(169,'Kozluk',14),(473,'Küçükçekmece',40),(689,'Kula',56),(304,'Kulp',26),(646,'Kulu',53),(677,'Kuluncak',55),(426,'Kumlu',37),(106,'Kumluca',8),(768,'Kumru',63),(561,'Küre',46),(254,'Kurşunlu',23),(840,'Kurtalan',69),(407,'Kürtün',35),(163,'Kurucaşile',13),(136,'Kuşadası',11),(137,'Kuyucak',11),(265,'Laçin',24),(819,'Ladik',67),(321,'Lalapaşa',28),(244,'Lapseki',22),(305,'Lice',26),(600,'Lüleburgaz',50),(911,'Maçka',75),(333,'Maden',29),(372,'Mahmudiye',32),(737,'Malazgirt',60),(883,'Malkara',73),(474,'Maltepe',40),(84,'Mamak',7),(107,'Manavgat',8),(157,'Manyas',12),(158,'Marmara',12),(884,'Marmaraereğlisi',73),(727,'Marmaris',59),(921,'Mazgirt',76),(702,'Mazıdağı',57),(266,'Mecitözü',24),(575,'Melikgazi',47),(508,'Menderes',41),(509,'Menemen',41),(202,'Mengen',19),(728,'Menteşe',59),(647,'Meram',53),(322,'Meriç',28),(21,'Merkez',2),(38,'Merkez',3),(47,'Merkez',4),(55,'Merkez',5),(62,'Merkez',6),(114,'Merkez',9),(121,'Merkez',10),(164,'Merkez',13),(170,'Merkez',14),(174,'Merkez',15),(178,'Merkez',16),(187,'Merkez',17),(195,'Merkez',18),(203,'Merkez',19),(215,'Merkez',20),(245,'Merkez',22),(255,'Merkez',23),(267,'Merkez',24),(315,'Merkez',27),(323,'Merkez',28),(334,'Merkez',29),(341,'Merkez',30),(400,'Merkez',34),(408,'Merkez',35),(413,'Merkez',36),(433,'Merkez',38),(441,'Merkez',39),(530,'Merkez',43),(538,'Merkez',44),(544,'Merkez',45),(562,'Merkez',46),(585,'Merkez',48),(594,'Merkez',49),(601,'Merkez',50),(610,'Merkez',51),(663,'Merkez',54),(738,'Merkez',60),(746,'Merkez',61),(752,'Merkez',62),(777,'Merkez',64),(790,'Merkez',65),(841,'Merkez',69),(851,'Merkez',70),(858,'Merkez',71),(872,'Merkez',72),(893,'Merkez',74),(922,'Merkez',76),(930,'Merkez',77),(950,'Merkez',79),(959,'Merkez',80),(973,'Merkez',81),(287,'Merkezefendi',25),(63,'Merzifon',6),(769,'Mesudiye',63),(715,'Mezitli',58),(703,'Midyat',57),(373,'Mihalgazi',32),(374,'Mihalıççık',32),(729,'Milas',59),(611,'Mucur',51),(227,'Mudanya',21),(204,'Mudurnu',19),(942,'Muradiye',78),(885,'Muratlı',73),(108,'Muratpaşa',8),(122,'Murgul',10),(586,'Musabeyli',48),(228,'Mustafakemalpaşa',21),(716,'Mut',58),(196,'Mutki',18),(85,'Nallıhan',7),(510,'Narlıdere',41),(355,'Narman',31),(138,'Nazilli',11),(923,'Nazımiye',76),(894,'Niksar',74),(229,'Nilüfer',21),(383,'Nizip',33),(384,'Nurdağı',33),(524,'Nurhak',42),(704,'Nusaybin',57),(511,'Ödemiş',41),(375,'Odunpazarı',32),(912,'Of',75),(385,'Oğuzeli',33),(268,'Oğuzlar',24),(356,'Oltu',31),(357,'Olur',31),(705,'Ömerli',57),(525,'Onikişubat',42),(230,'Orhaneli',21),(231,'Orhangazi',21),(256,'Orta',23),(730,'Ortaca',59),(913,'Ortahisar',75),(56,'Ortaköy',5),(269,'Ortaköy',24),(270,'Osmancık',24),(179,'Osmaneli',16),(232,'Osmangazi',21),(342,'Otlukbeli',30),(531,'Ovacık',43),(924,'Ovacık',76),(943,'Özalp',78),(576,'Özvatan',47),(358,'Palandöken',31),(335,'Palu',29),(288,'Pamukkale',25),(803,'Pamukova',66),(359,'Pasinler',31),(48,'Patnos',4),(427,'Payas',37),(791,'Pazar',65),(895,'Pazar',74),(526,'Pazarcık',42),(664,'Pazarlar',54),(180,'Pazaryeri',16),(360,'Pazaryolu',31),(602,'Pehlivanköy',50),(475,'Pendik',40),(770,'Perşembe',63),(925,'Pertek',76),(842,'Pervari',69),(401,'Piraziz',34),(563,'Pınarbaşı',46),(577,'Pınarbaşı',47),(603,'Pınarhisar',50),(587,'Polateli',48),(86,'Polatlı',7),(115,'Posof',9),(9,'Pozantı',1),(926,'Pülümür',76),(87,'Pursaklar',7),(678,'Pütürge',55),(343,'Refahiye',30),(896,'Reşadiye',74),(428,'Reyhanlı',37),(257,'Şabanözü',23),(532,'Safranbolu',43),(386,'Şahinbey',33),(10,'Saimbeyli',1),(690,'Salihli',56),(820,'Salıpazarı',67),(914,'Şalpazarı',75),(429,'Samandağ',37),(22,'Samsat',2),(476,'Sancaktepe',40),(39,'Sandıklı',3),(804,'Sapanca',66),(665,'Şaphane',54),(886,'Saray',73),(944,'Saray',78),(852,'Saraydüzü',70),(960,'Saraykent',80),(289,'Sarayköy',25),(648,'Sarayönü',53),(376,'Sarıcakaya',32),(11,'Sarıçam',1),(691,'Sarıgöl',56),(545,'Sarıkamış',45),(961,'Sarıkaya',80),(578,'Sarıoğlan',47),(539,'Sarıveliler',44),(57,'Sarıyahşi',5),(477,'Sarıyer',40),(579,'Sarız',47),(442,'Şarkikaraağaç',39),(873,'Şarkışla',72),(887,'Şarköy',73),(692,'Saruhanlı',56),(171,'Sason',14),(159,'Savaştepe',12),(123,'Şavşat',10),(706,'Savur',57),(205,'Seben',19),(402,'Şebinkarahisar',34),(962,'Şefaatli',80),(512,'Seferihisar',41),(387,'Şehitkamil',33),(693,'Şehzadeler',56),(513,'Selçuk',41),(649,'Selçuklu',53),(694,'Selendi',56),(546,'Selim',45),(414,'Şemdinli',36),(443,'Senirkent',39),(361,'Şenkaya',31),(564,'Şenpazar',46),(805,'Serdivan',66),(88,'Şereflikoçhisar',7),(109,'Serik',8),(290,'Serinhisar',25),(731,'Seydikemer',59),(565,'Seydiler',46),(650,'Seydişehir',53),(12,'Seyhan',1),(377,'Seyitgazi',32),(478,'Şile',40),(717,'Silifke',58),(479,'Silivri',40),(859,'Silopi',71),(306,'Silvan',26),(666,'Simav',54),(40,'Sinanpaşa',3),(89,'Sincan',7),(23,'Sincik',2),(409,'Şiran',35),(843,'Şirvan',69),(480,'Şişli',40),(931,'Sivaslı',77),(835,'Siverek',68),(336,'Sivrice',29),(378,'Sivrihisar',32),(160,'Sındırgı',12),(181,'Söğüt',16),(806,'Söğütlü',66),(139,'Söke',11),(188,'Solhan',17),(695,'Soma',56),(963,'Sorgun',80),(41,'Şuhut',3),(595,'Sulakyurt',49),(888,'Süleymanpaşa',73),(324,'Süloğlu',28),(481,'Sultanbeyli',40),(42,'Sultandağı',3),(482,'Sultangazi',40),(58,'Sultanhanı',5),(140,'Sultanhisar',11),(64,'Suluova',6),(897,'Sulusaray',74),(778,'Sumbas',64),(271,'Sungurlu',24),(307,'Sur',26),(915,'Sürmene',75),(836,'Suruç',68),(874,'Suşehri',72),(161,'Susurluk',12),(547,'Susuz',45),(444,'Sütçüler',39),(580,'Talas',47),(807,'Taraklı',66),(718,'Tarsus',58),(651,'Taşkent',53),(566,'Taşköprü',46),(49,'Taşlıçay',4),(65,'Taşova',6),(197,'Tatvan',18),(291,'Tavas',25),(667,'Tavşanlı',54),(216,'Tefenni',20),(821,'Tekkeköy',67),(362,'Tekman',31),(379,'Tepebaşı',32),(344,'Tercan',30),(951,'Termal',79),(822,'Terme',67),(844,'Tillo',69),(514,'Tire',41),(403,'Tirebolu',34),(581,'Tomarza',47),(916,'Tonya',75),(779,'Toprakkale',64),(515,'Torbalı',41),(719,'Toroslar',58),(363,'Tortum',31),(410,'Torul',35),(567,'Tosya',46),(13,'Tufanbeyli',1),(696,'Turgutlu',56),(898,'Turhal',74),(853,'Türkeli',70),(527,'Türkoğlu',42),(945,'Tuşba',78),(24,'Tut',2),(50,'Tutak',4),(483,'Tuzla',40),(434,'Tuzluca',38),(652,'Tuzlukçu',53),(272,'Uğurludağ',24),(732,'Ula',59),(875,'Ulaş',72),(771,'Ulubey',63),(932,'Ulubey',77),(445,'Uluborlu',39),(860,'Uludere',71),(753,'Ulukışla',62),(165,'Ulus',13),(484,'Ümraniye',40),(772,'Ünye',63),(747,'Ürgüp',61),(516,'Urla',41),(485,'Üsküdar',40),(345,'Üzümlü',30),(364,'Uzundere',31),(325,'Uzunköprü',28),(917,'Vakfıkebir',75),(739,'Varto',60),(823,'Vezirköprü',67),(837,'Viranşehir',68),(604,'Vize',50),(404,'Yağlıdere',34),(596,'Yahşihan',49),(582,'Yahyalı',47),(824,'Yakakent',67),(365,'Yakutiye',31),(653,'Yalıhüyük',53),(446,'Yalvaç',39),(258,'Yapraklı',23),(733,'Yatağan',59),(388,'Yavuzeli',33),(430,'Yayladağı',37),(189,'Yayladere',17),(679,'Yazıhan',55),(190,'Yedisu',17),(206,'Yeniçağa',19),(246,'Yenice',22),(533,'Yenice',43),(964,'Yenifakılı',80),(90,'Yenimahalle',7),(141,'Yenipazar',11),(182,'Yenipazar',16),(447,'Yenişarbademli',39),(233,'Yenişehir',21),(308,'Yenişehir',26),(720,'Yenişehir',58),(965,'Yerköy',80),(583,'Yeşilhisar',47),(707,'Yeşilli',57),(217,'Yeşilova',20),(680,'Yeşilyurt',55),(899,'Yeşilyurt',74),(316,'Yığılca',27),(234,'Yıldırım',21),(876,'Yıldızeli',72),(918,'Yomra',75),(415,'Yüksekova',36),(14,'Yumurtalık',1),(654,'Yunak',53),(697,'Yunusemre',56),(15,'Yüreğir',1),(124,'Yusufeli',10),(877,'Zara',72),(486,'Zeytinburnu',40),(900,'Zile',74);
/*!40000 ALTER TABLE `districts` ENABLE KEYS */;
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
-- Temporary view structure for view `province_districts`
--

DROP TABLE IF EXISTS `province_districts`;
/*!50001 DROP VIEW IF EXISTS `province_districts`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `province_districts` AS SELECT 
 1 AS `province_name`,
 1 AS `province_code`,
 1 AS `district_name`,
 1 AS `total_districts`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `provinces`
--

DROP TABLE IF EXISTS `provinces`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `provinces` (
  `id` int NOT NULL AUTO_INCREMENT,
  `province_name` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `province_code` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `province_name` (`province_name`),
  KEY `idx_province_name` (`province_name`),
  KEY `idx_province_code` (`province_code`)
) ENGINE=InnoDB AUTO_INCREMENT=82 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `provinces`
--

LOCK TABLES `provinces` WRITE;
/*!40000 ALTER TABLE `provinces` DISABLE KEYS */;
INSERT INTO `provinces` VALUES (1,'Adana',1),(2,'Adıyaman',2),(3,'Afyonkarahisar',3),(4,'Ağrı',4),(5,'Aksaray',68),(6,'Amasya',5),(7,'Ankara',6),(8,'Antalya',7),(9,'Ardahan',75),(10,'Artvin',8),(11,'Aydın',9),(12,'Balıkesir',10),(13,'Bartın',74),(14,'Batman',72),(15,'Bayburt',69),(16,'Bilecik',11),(17,'Bingöl',12),(18,'Bitlis',13),(19,'Bolu',14),(20,'Burdur',15),(21,'Bursa',16),(22,'Çanakkale',17),(23,'Çankırı',18),(24,'Çorum',19),(25,'Denizli',20),(26,'Diyarbakır',21),(27,'Düzce',81),(28,'Edirne',22),(29,'Elazığ',23),(30,'Erzincan',24),(31,'Erzurum',25),(32,'Eskişehir',26),(33,'Gaziantep',27),(34,'Giresun',28),(35,'Gümüşhane',29),(36,'Hakkari',30),(37,'Hatay',31),(38,'Iğdır',76),(39,'Isparta',32),(40,'İstanbul',34),(41,'İzmir',35),(42,'Kahramanmaraş',46),(43,'Karabük',78),(44,'Karaman',70),(45,'Kars',36),(46,'Kastamonu',37),(47,'Kayseri',38),(48,'Kilis',79),(49,'Kırıkkale',71),(50,'Kırklareli',39),(51,'Kırşehir',40),(52,'Kocaeli',41),(53,'Konya',42),(54,'Kütahya',43),(55,'Malatya',44),(56,'Manisa',45),(57,'Mardin',47),(58,'Mersin',33),(59,'Muğla',48),(60,'Muş',49),(61,'Nevşehir',50),(62,'Niğde',51),(63,'Ordu',52),(64,'Osmaniye',80),(65,'Rize',53),(66,'Sakarya',54),(67,'Samsun',55),(68,'Şanlıurfa',63),(69,'Siirt',56),(70,'Sinop',57),(71,'Şırnak',73),(72,'Sivas',58),(73,'Tekirdağ',59),(74,'Tokat',60),(75,'Trabzon',61),(76,'Tunceli',62),(77,'Uşak',64),(78,'Van',65),(79,'Yalova',77),(80,'Yozgat',66),(81,'Zonguldak',67);
/*!40000 ALTER TABLE `provinces` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `universities`
--

DROP TABLE IF EXISTS `universities`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `universities` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=62 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `universities`
--

LOCK TABLES `universities` WRITE;
/*!40000 ALTER TABLE `universities` DISABLE KEYS */;
INSERT INTO `universities` VALUES (1,'Alanya HEP Üniversitesi','2025-06-08 13:46:47'),(2,'Ankara Bilim Üniversitesi','2025-06-08 13:46:47'),(3,'Ankara Medipol Üniversitesi','2025-06-08 13:46:47'),(4,'Antalya Belek Üniversitesi','2025-06-08 13:46:47'),(5,'Atılım Üniversitesi','2025-06-08 13:46:47'),(6,'Avrasya Üniversitesi','2025-06-08 13:46:47'),(7,'Başkent Üniversitesi','2025-06-08 13:46:47'),(8,'Beykent Üniversitesi','2025-06-08 13:46:47'),(9,'Beykoz Üniversitesi','2025-06-08 13:46:47'),(10,'Bezm-i Âlem Vakıf Üniversitesi','2025-06-08 13:46:47'),(11,'Bilkent Üniversitesi','2025-06-08 13:46:47'),(12,'Biruni Üniversitesi','2025-06-08 13:46:47'),(13,'Çağ Üniversitesi','2025-06-08 13:46:47'),(14,'Çankaya Üniversitesi','2025-06-08 13:46:47'),(15,'Demircioğlu Bilim Üniversitesi','2025-06-08 13:46:47'),(16,'Doğuş Üniversitesi','2025-06-08 13:46:47'),(17,'Fatih Sultan Mehmet Vakıf Üniversitesi','2025-06-08 13:46:47'),(18,'Fenerbahçe Üniversitesi','2025-06-08 13:46:47'),(19,'Haliç Üniversitesi','2025-06-08 13:46:47'),(20,'Hasan Kalyoncu Üniversitesi','2025-06-08 13:46:47'),(21,'İbn Haldun Üniversitesi','2025-06-08 13:46:47'),(22,'İstanbul 29 Mayıs Üniversitesi','2025-06-08 13:46:47'),(23,'İstanbul Atlas Üniversitesi','2025-06-08 13:46:47'),(24,'İstanbul Aydın Üniversitesi','2025-06-08 13:46:47'),(25,'İstanbul Esenyurt Üniversitesi','2025-06-08 13:46:47'),(26,'İstanbul Galata Üniversitesi','2025-06-08 13:46:47'),(27,'İstanbul Gedik Üniversitesi','2025-06-08 13:46:47'),(28,'İstanbul Kent Üniversitesi','2025-06-08 13:46:47'),(29,'İstanbul Kültür Üniversitesi','2025-06-08 13:46:47'),(30,'İstanbul Nişantaşı Üniversitesi','2025-06-08 13:46:47'),(31,'İstanbul Rumeli Üniversitesi','2025-06-08 13:46:47'),(32,'İstanbul Sabahattin Zaim Üniversitesi','2025-06-08 13:46:47'),(33,'İstanbul Sağlık ve Sosyal Bilimler Meslek Yüksekokulu','2025-06-08 13:46:47'),(34,'İstanbul Sağlık ve Teknoloji Üniversitesi','2025-06-08 13:46:47'),(35,'İstanbul Şişli Meslek Yüksekokulu','2025-06-08 13:46:47'),(36,'İstanbul Ticaret Üniversitesi','2025-06-08 13:46:47'),(37,'İstanbul Yeni Yüzyıl Üniversitesi','2025-06-08 13:46:47'),(38,'İstinye Üniversitesi','2025-06-08 13:46:47'),(39,'İzmir Ekonomi Üniversitesi','2025-06-08 13:46:47'),(40,'Kadir Has Üniversitesi','2025-06-08 13:46:47'),(41,'Kapadokya Üniversitesi','2025-06-08 13:46:47'),(42,'Koç Üniversitesi','2025-06-08 13:46:47'),(43,'Kocaeli Sağlık ve Teknoloji Üniversitesi','2025-06-08 13:46:47'),(44,'Konya Gıda ve Tarım Üniversitesi','2025-06-08 13:46:47'),(45,'KTO Karatay Üniversitesi','2025-06-08 13:46:47'),(46,'Lokman Hekim Üniversitesi','2025-06-08 13:46:47'),(47,'Maltepe Üniversitesi','2025-06-08 13:46:47'),(48,'Mudanya Üniversitesi','2025-06-08 13:46:47'),(49,'Nuh Naci Yazgan Üniversitesi','2025-06-08 13:46:47'),(50,'Ostim Teknik Üniversitesi','2025-06-08 13:46:47'),(51,'Piri Reis Üniversitesi','2025-06-08 13:46:47'),(52,'Sabancı Üniversitesi','2025-06-08 13:46:47'),(53,'Sanko Üniversitesi','2025-06-08 13:46:47'),(54,'TED Üniversitesi','2025-06-08 13:46:47'),(55,'TOBB Ekonomi ve Teknoloji Üniversitesi','2025-06-08 13:46:47'),(56,'Toros Üniversitesi','2025-06-08 13:46:47'),(57,'Türk Hava Kurumu Üniversitesi','2025-06-08 13:46:47'),(58,'Ufuk Üniversitesi','2025-06-08 13:46:47'),(59,'Üsküdar Üniversitesi','2025-06-08 13:46:47'),(60,'Yaşar Üniversitesi','2025-06-08 13:46:47'),(61,'Yüksek İhtisas Üniversitesi','2025-06-08 13:46:47');
/*!40000 ALTER TABLE `universities` ENABLE KEYS */;
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

--
-- Final view structure for view `province_districts`
--

/*!50001 DROP VIEW IF EXISTS `province_districts`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `province_districts` AS select `p`.`province_name` AS `province_name`,`p`.`province_code` AS `province_code`,`d`.`district_name` AS `district_name`,count(`d`.`id`) OVER (PARTITION BY `p`.`id` )  AS `total_districts` from (`provinces` `p` left join `districts` `d` on((`p`.`id` = `d`.`province_id`))) order by `p`.`province_name`,`d`.`district_name` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-06-09  9:48:47
