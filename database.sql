CREATE DATABASE  IF NOT EXISTS `global_hotels_booking` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `global_hotels_booking`;
-- MySQL dump 10.13  Distrib 8.0.41, for Win64 (x86_64)
--
-- Host: localhost    Database: global_hotels_booking
-- ------------------------------------------------------
-- Server version	8.0.41

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
-- Table structure for table `existing_reservations`
--

DROP TABLE IF EXISTS `existing_reservations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `existing_reservations` (
  `ReservationID` int NOT NULL,
  `UserID` int NOT NULL,
  `ReviewID` int NOT NULL,
  `Status` enum('confirmed','pending','cancelled','completed') NOT NULL,
  `CreatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`ReservationID`),
  KEY `UserID` (`UserID`),
  KEY `ReviewID` (`ReviewID`),
  CONSTRAINT `existing_reservations_ibfk_1` FOREIGN KEY (`ReservationID`) REFERENCES `reservations` (`ReservationID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `existing_reservations_ibfk_2` FOREIGN KEY (`UserID`) REFERENCES `users` (`UserID`),
  CONSTRAINT `existing_reservations_ibfk_3` FOREIGN KEY (`ReviewID`) REFERENCES `hotel_reviews` (`ReviewID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `existing_reservations`
--

LOCK TABLES `existing_reservations` WRITE;
/*!40000 ALTER TABLE `existing_reservations` DISABLE KEYS */;
/*!40000 ALTER TABLE `existing_reservations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `feedback`
--

DROP TABLE IF EXISTS `feedback`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `feedback` (
  `RateID` int NOT NULL AUTO_INCREMENT,
  `UserID` int DEFAULT NULL,
  `Feedback` text,
  `FeedbackDate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `AppRate` int DEFAULT NULL,
  PRIMARY KEY (`RateID`),
  UNIQUE KEY `UserID_2` (`UserID`),
  KEY `UserID` (`UserID`),
  CONSTRAINT `feedback_ibfk_1` FOREIGN KEY (`UserID`) REFERENCES `users` (`UserID`),
  CONSTRAINT `feedback_chk_1` CHECK ((`AppRate` between 1 and 5))
) ENGINE=InnoDB AUTO_INCREMENT=801 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `feedback`
--

LOCK TABLES `feedback` WRITE;
/*!40000 ALTER TABLE `feedback` DISABLE KEYS */;
INSERT INTO `feedback` VALUES (1,3,'Great experience!','2025-02-03 16:07:47',5);
/*!40000 ALTER TABLE `feedback` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hotel_reviews`
--

DROP TABLE IF EXISTS `hotel_reviews`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `hotel_reviews` (
  `ReviewID` int NOT NULL AUTO_INCREMENT,
  `UserID` int DEFAULT NULL,
  `HotelID` int DEFAULT NULL,
  `Star_rate` int DEFAULT NULL,
  `Review` text,
  `ReviewDate` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`ReviewID`),
  KEY `UserID` (`UserID`),
  KEY `HotelID` (`HotelID`),
  CONSTRAINT `hotel_reviews_ibfk_1` FOREIGN KEY (`UserID`) REFERENCES `users` (`UserID`),
  CONSTRAINT `hotel_reviews_ibfk_2` FOREIGN KEY (`HotelID`) REFERENCES `hotels` (`HotelID`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hotel_reviews`
--

LOCK TABLES `hotel_reviews` WRITE;
/*!40000 ALTER TABLE `hotel_reviews` DISABLE KEYS */;
INSERT INTO `hotel_reviews` VALUES (1,3,2,5,'Exceptional service!','2025-02-03 16:09:26');
/*!40000 ALTER TABLE `hotel_reviews` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hotels`
--

DROP TABLE IF EXISTS `hotels`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `hotels` (
  `HotelID` int NOT NULL,
  `Hotel_name` varchar(50) NOT NULL,
  `Country` varchar(50) NOT NULL,
  `City` varchar(50) NOT NULL,
  `Address` text NOT NULL,
  `Star_rate` int NOT NULL,
  `Description` text NOT NULL,
  `Amenities` json NOT NULL,
  `ImageURLs` text NOT NULL,
  PRIMARY KEY (`HotelID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hotels`
--

LOCK TABLES `hotels` WRITE;
/*!40000 ALTER TABLE `hotels` DISABLE KEYS */;
INSERT INTO `hotels` VALUES (1,'Sunrise Hotel','Sudan','Khartoum','123 Nile Street',5,'A luxurious hotel with a stunning view of the Nile.','{\"Gym\": true, \"Pool\": true, \"WiFi\": true}','url1'),(2,'Desert Oasis','Egypt','Cairo','456 Pyramid Road',4,'A charming hotel near the Pyramids.','{\"Spa\": true, \"Pool\": true, \"WiFi\": true}','url2'),(3,'Mountain Retreat','Ethiopia','Addis Ababa','789 Mountain Road',3,'A cozy retreat in the mountains.','{\"Gym\": true, \"WiFi\": true}','url3');
/*!40000 ALTER TABLE `hotels` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `payment`
--

DROP TABLE IF EXISTS `payment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `payment` (
  `PaymentID` int NOT NULL,
  `ReservationID` int DEFAULT NULL,
  `Payment_method` enum('credit card','cash','','') NOT NULL,
  `Amount` decimal(10,0) NOT NULL,
  `TransactionID` varchar(255) NOT NULL,
  `Currency` varchar(10) NOT NULL,
  `Status` enum('success','failed','pending','') NOT NULL,
  `PaymentDate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`PaymentID`),
  UNIQUE KEY `ReservationsID` (`ReservationID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payment`
--

LOCK TABLES `payment` WRITE;
/*!40000 ALTER TABLE `payment` DISABLE KEYS */;
INSERT INTO `payment` VALUES (1,5,'credit card',70,'45','USD','success','2025-02-02 20:41:09'),(2,100,'credit card',150,'46','USD','success','2025-02-02 20:38:07');
/*!40000 ALTER TABLE `payment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reports`
--

DROP TABLE IF EXISTS `reports`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `reports` (
  `ReportID` int NOT NULL AUTO_INCREMENT,
  `UserID` int DEFAULT NULL,
  `ReportType` enum('Bookings','Revenues','Users','Hotels','Feedbacks') NOT NULL,
  `ReportData` blob NOT NULL,
  `ReportDate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`ReportID`),
  KEY `UserID` (`UserID`),
  CONSTRAINT `reports_ibfk_1` FOREIGN KEY (`UserID`) REFERENCES `users` (`UserID`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reports`
--

LOCK TABLES `reports` WRITE;
/*!40000 ALTER TABLE `reports` DISABLE KEYS */;
INSERT INTO `reports` VALUES (1,6,'Bookings',_binary 'Booking data excel file','2025-02-02 14:11:29'),(2,6,'Revenues',_binary 'Revenues data PDF file','2025-02-02 14:11:29');
/*!40000 ALTER TABLE `reports` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reservations`
--

DROP TABLE IF EXISTS `reservations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `reservations` (
  `ReservationID` int NOT NULL AUTO_INCREMENT,
  `UserID` int NOT NULL,
  `HotelID` int NOT NULL,
  `CheckIn_date` date NOT NULL,
  `CheckOut_Date` date NOT NULL,
  `Amount` decimal(10,0) NOT NULL,
  `Status` enum('confirmed','pending','cancelled','completed') NOT NULL,
  `Special_Request` text NOT NULL,
  `CreatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `PaymentID` int DEFAULT NULL,
  PRIMARY KEY (`ReservationID`),
  UNIQUE KEY `UserID` (`UserID`),
  UNIQUE KEY `HotelID` (`HotelID`),
  UNIQUE KEY `PaymentID` (`PaymentID`),
  CONSTRAINT `FK_reservations_hotels` FOREIGN KEY (`HotelID`) REFERENCES `hotels` (`HotelID`),
  CONSTRAINT `FK_reservations_payment` FOREIGN KEY (`PaymentID`) REFERENCES `payment` (`PaymentID`),
  CONSTRAINT `FK_reservations_user` FOREIGN KEY (`UserID`) REFERENCES `users` (`UserID`)
) ENGINE=InnoDB AUTO_INCREMENT=101 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reservations`
--

LOCK TABLES `reservations` WRITE;
/*!40000 ALTER TABLE `reservations` DISABLE KEYS */;
INSERT INTO `reservations` VALUES (5,3,2,'2025-02-12','2025-02-14',70,'completed','','2025-02-02 20:41:09',NULL),(100,1,1,'0000-00-00','0000-00-00',150,'confirmed','','2025-02-02 20:38:07',NULL);
/*!40000 ALTER TABLE `reservations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reserved_rooms`
--

DROP TABLE IF EXISTS `reserved_rooms`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `reserved_rooms` (
  `Reserved_rooms_ID` int NOT NULL,
  `ReservationID` int NOT NULL,
  `RoomID` int NOT NULL,
  `Quantity` int NOT NULL DEFAULT '1',
  PRIMARY KEY (`Reserved_rooms_ID`),
  UNIQUE KEY `ReservationID` (`ReservationID`),
  UNIQUE KEY `RoomID` (`RoomID`),
  CONSTRAINT `FK_reserved_rooms_reservation` FOREIGN KEY (`ReservationID`) REFERENCES `reservations` (`ReservationID`),
  CONSTRAINT `FK_reserved_rooms_room` FOREIGN KEY (`RoomID`) REFERENCES `rooms` (`RoomID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reserved_rooms`
--

LOCK TABLES `reserved_rooms` WRITE;
/*!40000 ALTER TABLE `reserved_rooms` DISABLE KEYS */;
INSERT INTO `reserved_rooms` VALUES (55,5,2,1),(77,100,1,1);
/*!40000 ALTER TABLE `reserved_rooms` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rooms`
--

DROP TABLE IF EXISTS `rooms`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `rooms` (
  `RoomID` int NOT NULL,
  `HotelID` int NOT NULL,
  `Room_type` enum('Single','Double','Suite') NOT NULL,
  `Occupancy_adults` int NOT NULL,
  `Occupancy_children` int NOT NULL,
  `Price_per_night` decimal(10,2) NOT NULL,
  `Availability` tinyint(1) NOT NULL,
  `Amenities` json NOT NULL,
  `Bed_type` enum('King','Queen','Twin') NOT NULL,
  PRIMARY KEY (`RoomID`),
  KEY `Foreign Key` (`HotelID`),
  CONSTRAINT `rooms_ibfk_1` FOREIGN KEY (`HotelID`) REFERENCES `hotels` (`HotelID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rooms`
--

LOCK TABLES `rooms` WRITE;
/*!40000 ALTER TABLE `rooms` DISABLE KEYS */;
INSERT INTO `rooms` VALUES (1,1,'Suite',2,2,300.00,1,'{\"Mini Bar\": true, \"Air Conditioning\": true}','King'),(2,1,'Double',2,0,150.00,1,'{\"Mini Bar\": false, \"Air Conditioning\": true}','Queen'),(3,2,'Single',1,0,80.00,1,'{\"Mini Bar\": false, \"Air Conditioning\": true}','Twin'),(4,2,'Double',2,0,120.00,1,'{\"Mini Bar\": true, \"Air Conditioning\": true}','Queen'),(5,3,'Suite',2,1,200.00,1,'{\"Mini Bar\": true, \"Air Conditioning\": true}','King');
/*!40000 ALTER TABLE `rooms` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `UserID` int NOT NULL AUTO_INCREMENT,
  `Email` varchar(50) NOT NULL,
  `Password` varchar(50) NOT NULL,
  `FName` varchar(50) NOT NULL,
  `LName` varchar(50) DEFAULT NULL,
  `BirthDate` date DEFAULT NULL,
  `Phone` varchar(20) DEFAULT NULL,
  `Role` enum('Traveler','Admin') NOT NULL,
  `SupportContact_message` text,
  `SupportContact_preference` enum('Phone','Email','Chatbot') DEFAULT NULL,
  PRIMARY KEY (`UserID`),
  UNIQUE KEY `Email` (`Email`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'alice.brown@gmail.com','SecurePass1!','Alice','Brown','1987-06-30','+1-555-8765','Traveler','Chatbot',''),(2,'bob.white@yahoo.com','SecurePass2$','Bob','White','1975-04-10','+44-555-3456','Traveler','Need help with payment','Email'),(3,'carol.johnson@mail.com','SecurePass3#','Carol','Johnson','1992-09-12','+61-555-6543','Traveler',NULL,NULL),(4,'dave.williams@gmail.com','SecurePass4%','Dave','Williams','1983-11-14','+33-555-7890','Traveler',NULL,NULL),(5,'eve.miller@hotmail.com','SecurePass5^','Eve','Miller','1995-07-19','+91-555-4321','Traveler',NULL,NULL),(6,'john.doe@hotelbooking.com','AdminPass1*','John','Doe','1980-05-15','+1-555-2345','Admin','Chatbot','Chatbot'),(7,'jane.smith@hotelbooking.com','AdminPass2&','Jane','Smith','1982-08-25','+44-555-6789','Admin','Reply: Need help with payment','Email');
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

-- Dump completed on 2025-02-04 17:35:16
