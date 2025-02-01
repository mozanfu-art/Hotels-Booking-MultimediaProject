-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: Feb 01, 2025 at 01:33 PM
-- Server version: 9.1.0
-- PHP Version: 8.3.14

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `database.sql`
--

-- --------------------------------------------------------

--
-- Table structure for table `feedbacks`
--

DROP TABLE IF EXISTS `feedbacks`;
CREATE TABLE IF NOT EXISTS `feedbacks` (
  `rateid` int NOT NULL AUTO_INCREMENT COMMENT 'primary key for feedback records',
  `userid` int NOT NULL,
  `apprate` int NOT NULL,
  `feedbackdate` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`rateid`),
  KEY `userid` (`userid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `hotels table`
--

DROP TABLE IF EXISTS `hotels table`;
CREATE TABLE IF NOT EXISTS `hotels table` (
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

-- --------------------------------------------------------

--
-- Table structure for table `hotel_reviews`
--

DROP TABLE IF EXISTS `hotel_reviews`;
CREATE TABLE IF NOT EXISTS `hotel_reviews` (
  `reviewid` int NOT NULL AUTO_INCREMENT COMMENT 'primary key for hotel reviews',
  `userid` int NOT NULL,
  `hotelid` int NOT NULL,
  `rating` int NOT NULL,
  `review_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `review_text` text,
  PRIMARY KEY (`reviewid`),
  KEY `userid` (`userid`),
  KEY `hotelid` (`hotelid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `reports`
--

DROP TABLE IF EXISTS `reports`;
CREATE TABLE IF NOT EXISTS `reports` (
  `ReportID` int NOT NULL AUTO_INCREMENT,
  `UserID` int DEFAULT NULL,
  `ReportType` enum('Bookings','Revenues','Users','Hotels','Feedbacks') DEFAULT NULL,
  `ReportData` blob,
  `ReportDate` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`ReportID`),
  KEY `UserID` (`UserID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `rooms table`
--

DROP TABLE IF EXISTS `rooms table`;
CREATE TABLE IF NOT EXISTS `rooms table` (
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
  UNIQUE KEY `Foreign Key` (`HotelID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
CREATE TABLE IF NOT EXISTS `users` (
  `UserID` int NOT NULL AUTO_INCREMENT,
  `Email` varchar(50) NOT NULL,
  `Password` varchar(50) NOT NULL,
  `FName` varchar(50) DEFAULT NULL,
  `LName` varchar(50) DEFAULT NULL,
  `BirthDate` date DEFAULT NULL,
  `Phone` varchar(20) DEFAULT NULL,
  `Role` enum('Traveler','Admin') DEFAULT NULL,
  `SupportContact_message` text,
  `SupportContact_preference` enum('Phone','Email','Chatbot') DEFAULT NULL,
  PRIMARY KEY (`UserID`),
  UNIQUE KEY `Email` (`Email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `reports`
--
ALTER TABLE `reports`
  ADD CONSTRAINT `reports_ibfk_1` FOREIGN KEY (`UserID`) REFERENCES `users` (`UserID`);

--
-- Constraints for table `rooms table`
--
ALTER TABLE `rooms table`
  ADD CONSTRAINT `rooms table_ibfk_1` FOREIGN KEY (`HotelID`) REFERENCES `hotels table` (`HotelID`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
