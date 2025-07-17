-- MySQL dump 10.13  Distrib 8.0.42, for Linux (aarch64)
--
-- Host: localhost    Database: user_details_and_preferences
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
-- Table structure for table `user_preferences`
--

DROP TABLE IF EXISTS `user_preferences`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_preferences` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `current_city` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `current_district` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `target_city` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `target_district` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `age` int NOT NULL,
  `family_size` int NOT NULL,
  `monthly_net_income` float NOT NULL,
  `monthly_rent` float NOT NULL,
  `electricity_bill` float NOT NULL,
  `natural_gas_bill` float NOT NULL,
  `water_bill` float NOT NULL,
  `internet_bill` float NOT NULL,
  `uses_public_transportation` tinyint(1) DEFAULT NULL,
  `is_the_user_student` tinyint(1) DEFAULT NULL,
  `public_transport_monthly_pass` float DEFAULT NULL,
  `wants_education_analysis` tinyint(1) DEFAULT NULL,
  `target_university` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `department_name` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `current_tuition_semester` float DEFAULT NULL,
  `gym_membership` float DEFAULT NULL,
  `entertainment_monthly` float DEFAULT NULL,
  `clothing_monthly` float DEFAULT NULL,
  `healthcare_monthly` float DEFAULT NULL,
  `subscriptions_monthly` float DEFAULT NULL,
  `travel_vacation_monthly` float DEFAULT NULL,
  `preferred_housing_type` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `number_of_rooms` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `owns_vehicle` tinyint(1) DEFAULT NULL,
  `vehicle_type` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `fuel_tank_capacity` int DEFAULT NULL,
  `fuel_tank_monthly_fill_count` int DEFAULT NULL,
  `distributor_preference` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `vehicle_fuel_type` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `grocery_preferences` json DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `user_preferences_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_preferences`
--

LOCK TABLES `user_preferences` WRITE;
/*!40000 ALTER TABLE `user_preferences` DISABLE KEYS */;
INSERT INTO `user_preferences` VALUES (1,1,'İstanbul','Kadıköy','Ankara','Çankaya',22,1,8500,2500,180,120,45,85,1,1,85,1,'TED Üniversitesi','Mühendislik',15000,150,400,300,100,65,200,'Daire','1+1',1,'sedan',40,2,'Opet','gasoline','[\"Elma\", \"Muz\", \"Domates\", \"Soğan\", \"Patates\", \"Havuç\", \"Süt\", \"Peynir\", \"Yoğurt\", \"Yumurta\", \"Tereyağı\", \"Tavuk Göğsü\", \"Kıyma\", \"Balık\", \"Ekmek\", \"Pirinç\", \"Makarna\", \"Yulaf\", \"Zeytinyağı\", \"Tuz\", \"Şeker\", \"Çay\", \"Kahve\"]'),(2,3,'Adana','Seyhan','Ankara','Çankaya',25,2,100000,15000,500,1000,500,600,1,0,100,1,'Ted Üniversitesi','Mühendislik Fakültesi',150000,800,0,1000,0,500,0,'Apartment','2+1',1,'Car',40,2,'Shell','Gasoline','[\"Bir litre Süt\", \"Ekmek\", \"Çikolata\"]'),(3,4,'Adana','Seyhan','Ankara','Çankaya',25,2,100000,15000,1000,1000,500,800,1,0,100,1,'Ted Üniversitesi','Mühendislik',150000,800,0,1000,0,500,0,'Apartment','2+1',1,'Car',40,2,'Shell','Gasoline','[\"ekmek\", \"bir litre su\"]'),(4,5,'Adana','Seyhan','Ankara','Yenimahalle',28,3,100000,15000,1000,1000,500,800,1,1,200,1,'Ted Üniversitesi','Mühendislik',150000,800,100,1000,0,300,0,'Apartment','2+1',1,'Car',40,2,'Shell','Gasoline','[\"Bir litre Su\", \"Ekmek\", \"çikolata\"]'),(5,6,'Ankara','Yenimahalle','Adana','Seyhan',28,3,100000,100,100,100,100,100,0,0,0,0,'Ted Üniversitesi','Mühendislik',0,0,0,0,0,0,0,'Apartment','2+1',1,'Car',40,2,'Shell','Gasoline','[]'),(6,7,'Adana','İmamoğlu','Afyonkarahisar','Çay',24,4,100000,10000,300,400,500,800,0,0,0,1,'Ankara Bilim Üniversitesi','',0,800,400,400,0,0,0,'House','2+1',1,'Car',40,2,'Petrol Ofisi','Diesel','[\"bir litre süt\", \"bir litre ayran\", \"bir kilogram tavuk eti\", \"bir kilogram sosis\", \"bir kilogram sucuk\", \"bir kilogram havuç\", \"bir kilogram domates\", \"bir kilogram salatalık\", \"bir kilogram elma\", \"bir kilogram ekmek\", \"bir kilogram mercimek\", \"bir kilogram pirinç\", \"bir kilogram nohut\", \"bir kilogram tuz\", \"bir litre sirke\", \"bir kilogram şeker\", \"bir kilogram zeytin\", \"bir kilogram un\", \"bir kilogram çay\", \"bir kilogram kahve\"]');
/*!40000 ALTER TABLE `user_preferences` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(80) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(120) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password_hash` varchar(256) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'harunbaba2123','harunbaba2@gmail.com','scrypt:32768:8:1$sGnSOJCTxvAukuZf$121c3b6cb8bd72f95a7c2ab1c430bac05a9634d6034c94d025281cd97c8e27cde882491487b43423738ed3ee252c9c460b6b87ad4131cdf9b41605bd08752fb1'),(2,'harunbaba22123','harunbaba22@gmail.com','scrypt:32768:8:1$XPnhMtEnk44iJBea$42e4df6fb727f2c80c311e97871ec78356ade067117360491ff7bf2621d3650690703662bea4233c0d2789f68dd2b8aa72ff2ad0889dabd5f9adf09150f3737d'),(3,'colawerdi','colawerdi@gmail.com','scrypt:32768:8:1$M6c39YQ2N2NWeiRg$fb87aed002026b77369f2572c938ba31035593efdf78e08e7751e36cc274ad5b93c2991b0a8793f2f138d8337c7ecbd543ef8e162d8f5023cdeb39856da2fc06'),(4,'gubis2','gubis@gmail.com','scrypt:32768:8:1$nqOvYE4IytpYqiUn$faab1af14455055d2845d6d7c6c5eeee4f3238751b6bd888ed36c0c92a49bd85b4590f4d880401759e6dc9371d83c5bccaa0b99600b0532056821de39f42bc16'),(5,'hahaha','hahaha@gmail.com','scrypt:32768:8:1$tNnCki2wlSS13L4J$d4f32092934d82388a4c79c3d9d9832fbc2faa98ae54670ff51b79c9aa1c21f984392a663678a46f8f00a9fa9eeeb3f9039bcf22d6f1a1848c29b29337668576'),(6,'agab','agab@gmail.com','scrypt:32768:8:1$DgkRWO9wa8w8vlIL$cc00a826ecfacbad02f6bd8fb52c31c9e46c8a639951843747b078b3dc823ce6188b2401fc0b7a0367488994d62f850528a392fcc41fde0af720becf5f7d34d0'),(7,'harunabc','harunabc@gmail.com','scrypt:32768:8:1$YAMbH9GP1IoTRn9n$72ff356879f20bc667704d99d8209f7b33bf28a3d7694b1cfe1328b2c3654d4d4fdbf34aa3689904a96e7d894628f25235a877071c26fb73c44c7b957fa81bd6'),(8,'harunabi','harunabi@gmail.com','scrypt:32768:8:1$hfDdPKzSIBX6yOTs$315cd2f108163877ca3944859d383ca3ef79e8272102f6f893066d4a083c99da83fe8126e4278720c6bfde8c9f75f0f57e5947c79ee56df658822c37fc11555d'),(9,'harun','harun22002tan@gmail.com','scrypt:32768:8:1$SUYauDfaLCsfLOmA$9084a5bb13eeacc9fd07319e8831fd87f27e404b253ad9a446b83c968a2c7a1dc653cac9d63824988afeccdc5045a2622d8100974e61213ae468e721b03450cc');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-07-17  7:39:21
