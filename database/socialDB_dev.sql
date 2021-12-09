-- MySQL dump 10.13  Distrib 8.0.27, for Win64 (x86_64)
--
-- Host: localhost    Database: socialdb_dev
-- ------------------------------------------------------
-- Server version	8.0.27

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `comments`
--

DROP TABLE IF EXISTS `comments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `comments` (
  `id` int NOT NULL AUTO_INCREMENT,
  `message` text NOT NULL,
  `pseudo` varchar(255) NOT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  `UserId` int NOT NULL,
  `PostId` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `UserId` (`UserId`),
  KEY `PostId` (`PostId`),
  CONSTRAINT `comments_ibfk_1` FOREIGN KEY (`UserId`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `comments_ibfk_2` FOREIGN KEY (`PostId`) REFERENCES `posts` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `comments`
--

LOCK TABLES `comments` WRITE;
/*!40000 ALTER TABLE `comments` DISABLE KEYS */;
INSERT INTO `comments` VALUES (5,'Il faut bien ça pour un lundi !!','Lunamina','2021-11-30 15:33:17','2021-11-30 15:33:17',4,3),(6,'Oui c\'est un peu la tête que je fais les lundi ! :) ','fabsolo58','2021-12-01 12:10:28','2021-12-01 12:10:28',3,4),(7,'Il me fait penser à Golum !! ','Gandalf','2021-12-01 16:47:08','2021-12-01 16:47:08',6,4),(11,'Pourquoi pas se challenger ? ','Fabsolo','2021-12-02 18:19:30','2021-12-02 18:19:30',2,5),(12,'Vive le vendredi ! ','fabsolo58','2021-12-03 17:12:30','2021-12-03 17:12:30',3,6),(13,'Ils sont pressés ! ','Bakary','2021-12-03 17:18:41','2021-12-03 17:18:41',7,6),(14,'Oh la trogne !! ','Fabsolo','2021-12-03 17:41:41','2021-12-03 17:41:41',2,4);
/*!40000 ALTER TABLE `comments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `likes`
--

DROP TABLE IF EXISTS `likes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `likes` (
  `id` int NOT NULL AUTO_INCREMENT,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  `UserId` int NOT NULL,
  `PostId` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `UserId` (`UserId`),
  KEY `PostId` (`PostId`),
  CONSTRAINT `likes_ibfk_1` FOREIGN KEY (`UserId`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `likes_ibfk_2` FOREIGN KEY (`PostId`) REFERENCES `posts` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `likes`
--

LOCK TABLES `likes` WRITE;
/*!40000 ALTER TABLE `likes` DISABLE KEYS */;
INSERT INTO `likes` VALUES (4,'2021-11-24 17:06:22','2021-11-24 17:06:22',3,3),(8,'2021-12-01 12:49:40','2021-12-01 12:49:40',3,4),(9,'2021-12-01 16:46:17','2021-12-01 16:46:17',6,3),(12,'2021-12-02 00:24:14','2021-12-02 00:24:14',2,4),(14,'2021-12-02 18:18:20','2021-12-02 18:18:20',2,5),(17,'2021-12-03 17:12:10','2021-12-03 17:12:10',3,6),(18,'2021-12-03 17:18:19','2021-12-03 17:18:19',7,9),(19,'2021-12-03 17:18:21','2021-12-03 17:18:21',7,6),(20,'2021-12-03 17:18:24','2021-12-03 17:18:24',7,5),(21,'2021-12-07 19:01:10','2021-12-07 19:01:10',2,3),(23,'2021-12-08 12:36:49','2021-12-08 12:36:49',1,4),(24,'2021-12-08 12:41:53','2021-12-08 12:41:53',1,9),(25,'2021-12-08 12:58:54','2021-12-08 12:58:54',1,11);
/*!40000 ALTER TABLE `likes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `posts`
--

DROP TABLE IF EXISTS `posts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `posts` (
  `id` int NOT NULL AUTO_INCREMENT,
  `message` text NOT NULL,
  `link` varchar(255) DEFAULT NULL,
  `imageUrl` varchar(255) DEFAULT NULL,
  `UserId` int NOT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `UserId` (`UserId`),
  CONSTRAINT `posts_ibfk_1` FOREIGN KEY (`UserId`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `posts`
--

LOCK TABLES `posts` WRITE;
/*!40000 ALTER TABLE `posts` DISABLE KEYS */;
INSERT INTO `posts` VALUES (3,'Bon week-end !!',NULL,'http://localhost:3000/api/upload/monday1637515779335.gif',3,'2021-11-21 17:29:39','2021-11-21 17:29:39'),(4,'Bonjour à tous et bon courage pour cette semaine','https://media2.giphy.com/media/9s8Jq3Sc1ZnZS/200w.webp',NULL,4,'2021-11-30 10:52:42','2021-11-30 10:52:42'),(5,'N\'hésitez pas à me contacter sur notre nouveau réseau social d\'entreprise ! ','https://media2.giphy.com/media/iVfLR7Er36ToQ/200w.webp?cid=790b7611irxsgxmyb5od6vk1wrjziusuwoml7f9nij23sipa&rid=200w.webp&ct=g',NULL,6,'2021-12-01 17:18:55','2021-12-01 17:18:55'),(6,'Le week-end approche les amis !!  Profitez bien surtout ! ','https://media0.giphy.com/media/b2GZmLzEvgcFO/200.webp?cid=ecf05e470klhzw42aevby2nqc6dmw52r4r0kqs336sif37zu&rid=200.webp&ct=g',NULL,2,'2021-12-02 02:52:24','2021-12-07 18:49:53'),(9,'Bon weel end à tous',NULL,'http://localhost:3000/api/upload/Baby_Reaction1638551657989.undefined',3,'2021-12-03 17:14:18','2021-12-03 17:14:18'),(11,'Bonne semaine à tous',NULL,'http://localhost:3000/api/upload/41638838346662.jpeg',8,'2021-12-07 00:52:26','2021-12-07 00:52:26');
/*!40000 ALTER TABLE `posts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sequelizemeta`
--

DROP TABLE IF EXISTS `sequelizemeta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sequelizemeta` (
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`name`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sequelizemeta`
--

LOCK TABLES `sequelizemeta` WRITE;
/*!40000 ALTER TABLE `sequelizemeta` DISABLE KEYS */;
INSERT INTO `sequelizemeta` VALUES ('20211103165610-create-user.js'),('20211103165804-create-post.js');
/*!40000 ALTER TABLE `sequelizemeta` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` int NOT NULL AUTO_INCREMENT,
  `pseudo` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `photo` varchar(255) DEFAULT NULL,
  `bio` varchar(255) DEFAULT NULL,
  `admin` tinyint(1) NOT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'administrateur','administrateur@mail.com','$2b$10$Z20mpTDVj6.TewqsGrZsveVn.h.ePCQbBSypuEONr.1lKOEW74qLu',NULL,NULL,1,'2021-11-03 23:25:53','2021-11-03 23:25:53'),(2,'Fabsolo','fabsolo@email.fr','$2b$10$MUD.IOWUKMnfrEEhgMpkIes4rVKhoNU5v0sHDSVCI3H9lMXu1owo6','http://localhost:3000/api/upload/1b620c1cbce7ef13845cb4ae7069e221.01638458769561.jpeg','Ma bio est graphique et logique : biographique et biologique !! :) Ok je sors ! ',0,'2021-11-03 23:44:58','2021-12-07 18:39:44'),(3,'fabsolo58','fabso@mail.com','$2b$10$cAWIFo/djLWhG6hTKkzl8.XRI4DlARtI2XgMd/j9dpddZ2VSBkaAS','http://localhost:3000/api/upload/Fabsolo1637856967044.jpg','Je modifie ici ma bio sur mon profil',0,'2021-11-04 16:22:40','2021-12-07 23:00:59'),(4,'Lunamina','sab@mail.fr','$2b$10$1UxJNqhPdWBcYxE.j9hDVuA3cwCZO2jjUSeFXSZEhGVUu843aZDXq','http://localhost:3000/api/upload/20210330_0850281638637565108.jpeg','Mère d\'une fille de 16 ans qui fait mon bonheur, je suis passionnée de pâtisserie et réalise des cakes design, que je partage volontiers avec tous mes collègues de Groupomania ! ',0,'2021-11-08 23:12:08','2021-12-04 17:06:06'),(5,'Fab58','fab58@gmail.com','$2b$10$MnHsW.eImWEaAVUVFdWRKuJfj4VC.Z/y1EFCcTrlUPvdmwYkR1.EW',NULL,NULL,0,'2021-11-15 18:55:53','2021-11-15 18:55:53'),(6,'Gandalf','gandalf@mail.fr','$2b$10$L3fohdh315XQuu.kWbMXHOr.Jjv946.vEjSC83miAW8HfGakpbr5u','http://localhost:3000/api/upload/gandalf1638373379287.jpeg','Rassembleur et participants de la communauté de l\'anneau...',0,'2021-12-01 15:11:58','2021-12-01 15:42:59'),(7,'Bakary','bakary@mail.fr','$2b$10$m6kj8Ojb6jKj5WeEQ6mFw.uM.VY3zYyV0fg4T/oCbwBdROLgGFf3C',NULL,NULL,0,'2021-12-03 17:18:02','2021-12-03 17:18:02'),(8,'JohnDo','johndo@mail.fr','$2b$10$EiZ40KaIXwBsZNFbjfKvH.7sMg.ALXRTpGaAhEjfmZIjk34aGl1sq',NULL,NULL,0,'2021-12-06 13:35:56','2021-12-06 13:35:56');
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

-- Dump completed on 2021-12-08 17:38:57
