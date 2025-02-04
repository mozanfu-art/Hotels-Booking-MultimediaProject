-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: Feb 04, 2025 at 01:27 AM
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
-- Database: `database`
--

DELIMITER $$
--
-- Procedures
--
DROP PROCEDURE IF EXISTS `AuthenticateUser`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `AuthenticateUser` (IN `userEmail` VARCHAR(50), IN `userPassword` VARCHAR(50))   BEGIN
    DECLARE userRole ENUM('Traveler', 'Admin');
    DECLARE authResult VARCHAR(100);

    -- Check if user exists and fetch their role
    SELECT Role INTO userRole
    FROM users
    WHERE Email = userEmail AND Password = userPassword;

    -- Determine the authentication result based on the role
    IF userRole = 'Admin' THEN
        SET authResult = 'Authenticated as Admin';
    ELSEIF userRole = 'Traveler' THEN
        SET authResult = 'Authenticated as Traveler';
    ELSE
        SET authResult = 'Authentication Failed';
    END IF;

    -- Display the authentication result
    SELECT authResult AS AuthenticationResult;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `existing_reservations`
--

DROP TABLE IF EXISTS `existing_reservations`;
CREATE TABLE IF NOT EXISTS `existing_reservations` (
  `ReservationsID` int DEFAULT NULL,
  `UserID` int DEFAULT NULL,
  `ReviewID` int DEFAULT NULL,
  `Status` enum('Completed') DEFAULT NULL,
  `CreatedAt` timestamp NULL DEFAULT NULL,
  UNIQUE KEY `UserID_2` (`UserID`,`ReviewID`),
  UNIQUE KEY `ReviewID_2` (`ReviewID`),
  UNIQUE KEY `ReservationsID` (`ReservationsID`),
  UNIQUE KEY `ReviewID_3` (`ReviewID`),
  KEY `ReservationID` (`ReservationsID`),
  KEY `UserID` (`UserID`),
  KEY `ReviewID` (`ReviewID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `existing_reservations`
--

INSERT INTO `existing_reservations` (`ReservationsID`, `UserID`, `ReviewID`, `Status`, `CreatedAt`) VALUES
(1, 1, 1, 'Completed', '2025-02-03 23:04:50'),
(5, 1, 3, 'Completed', '2025-02-04 01:16:59'),
(100, 1, 2, 'Completed', '2025-02-04 01:16:59');

-- --------------------------------------------------------

--
-- Table structure for table `feedback`
--

DROP TABLE IF EXISTS `feedback`;
CREATE TABLE IF NOT EXISTS `feedback` (
  `FeedbackID` int NOT NULL AUTO_INCREMENT,
  `UserID` int DEFAULT NULL,
  `HotelID` int DEFAULT NULL,
  `Feedback` text,
  `FeedbackDate` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`FeedbackID`),
  UNIQUE KEY `UserID_2` (`UserID`,`HotelID`),
  KEY `UserID` (`UserID`),
  KEY `HotelID` (`HotelID`)
) ENGINE=InnoDB AUTO_INCREMENT=801 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `feedback`
--

INSERT INTO `feedback` (`FeedbackID`, `UserID`, `HotelID`, `Feedback`, `FeedbackDate`) VALUES
(1, 1, 1, 'Excellent service!', '2025-02-03 16:07:47'),
(700, 5, 3, NULL, '2025-02-04 01:18:10'),
(750, 7, 2, NULL, '2025-02-04 01:19:37'),
(800, 2, 3, NULL, '2025-02-04 01:19:51');

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

--
-- Dumping data for table `hotels table`
--

INSERT INTO `hotels table` (`HotelID`, `Hotel_name`, `Country`, `City`, `Address`, `Star_rate`, `Description`, `Amenities`, `ImageURLs`) VALUES
(1, 'Sunrise Hotel', 'Sudan', 'Khartoum', '123 Nile Street', 5, 'A luxurious hotel with a stunning view of the Nile.', '{\"Gym\": true, \"Pool\": true, \"WiFi\": true}', 'url1'),
(2, 'Desert Oasis', 'Egypt', 'Cairo', '456 Pyramid Road', 4, 'A charming hotel near the Pyramids.', '{\"Spa\": true, \"Pool\": true, \"WiFi\": true}', 'url2'),
(3, 'Mountain Retreat', 'Ethiopia', 'Addis Ababa', '789 Mountain Road', 3, 'A cozy retreat in the mountains.', '{\"Gym\": true, \"WiFi\": true}', 'url3');

-- --------------------------------------------------------

--
-- Table structure for table `hotel_reviews`
--

DROP TABLE IF EXISTS `hotel_reviews`;
CREATE TABLE IF NOT EXISTS `hotel_reviews` (
  `ReviewID` int NOT NULL,
  `Star_rate` int NOT NULL,
  `Review` text NOT NULL,
  `ReviewDate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `UserID` int NOT NULL,
  `HotelID` int NOT NULL,
  PRIMARY KEY (`ReviewID`),
  UNIQUE KEY `UserID` (`UserID`),
  UNIQUE KEY `HotelID` (`HotelID`),
  UNIQUE KEY `UserID_2` (`UserID`,`HotelID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `hotel_reviews`
--

INSERT INTO `hotel_reviews` (`ReviewID`, `Star_rate`, `Review`, `ReviewDate`, `UserID`, `HotelID`) VALUES
(700, 4, '', '2025-02-04 01:20:15', 1, 3),
(750, 5, '', '2025-02-04 01:20:34', 6, 2),
(800, 2, '', '2025-02-04 01:20:51', 5, 1);

-- --------------------------------------------------------

--
-- Table structure for table `payment`
--

DROP TABLE IF EXISTS `payment`;
CREATE TABLE IF NOT EXISTS `payment` (
  `PaymentID` int NOT NULL,
  `ReservationsID` int NOT NULL,
  `Payment_method` enum('credit card','cash','','') NOT NULL,
  `Amount` decimal(10,0) NOT NULL,
  `TransactionID` varchar(255) NOT NULL,
  `Currency` varchar(10) NOT NULL,
  `Status` enum('success','failed','pending','') NOT NULL,
  `PaymentDate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`PaymentID`),
  UNIQUE KEY `ReservationsID` (`ReservationsID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `payment`
--

INSERT INTO `payment` (`PaymentID`, `ReservationsID`, `Payment_method`, `Amount`, `TransactionID`, `Currency`, `Status`, `PaymentDate`) VALUES
(700, 100, 'cash', 250, '', 'usd', 'pending', '2025-02-04 01:21:27');

-- --------------------------------------------------------

--
-- Table structure for table `reports`
--

DROP TABLE IF EXISTS `reports`;
CREATE TABLE IF NOT EXISTS `reports` (
  `ReportID` int NOT NULL AUTO_INCREMENT,
  `UserID` int DEFAULT NULL,
  `ReportType` enum('Bookings','Revenues','Users','Hotels','Feedbacks') NOT NULL,
  `ReportData` blob NOT NULL,
  `ReportDate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`ReportID`),
  KEY `UserID` (`UserID`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `reports`
--

INSERT INTO `reports` (`ReportID`, `UserID`, `ReportType`, `ReportData`, `ReportDate`) VALUES
(1, 6, 'Bookings', 0x426f6f6b696e67206461746120657863656c2066696c65, '2025-02-02 14:11:29'),
(2, 6, 'Revenues', 0x526576656e7565732064617461205044462066696c65, '2025-02-02 14:11:29'),
(3, 7, 'Users', 0x5573657273206461746120657863656c2066696c65, '2025-02-02 14:11:29'),
(4, 7, 'Hotels', 0x486f74656c732064617461205044462066696c65, '2025-02-02 14:11:29'),
(5, 7, 'Feedbacks', 0x466565646261636b732064617461205044462066696c65, '2025-02-02 14:11:29');

-- --------------------------------------------------------

--
-- Table structure for table `reservations table`
--

DROP TABLE IF EXISTS `reservations table`;
CREATE TABLE IF NOT EXISTS `reservations table` (
  `ReservationsID` int NOT NULL,
  `UserID` int NOT NULL,
  `HotelID` int NOT NULL,
  `CheckIn_date` date NOT NULL,
  `CheckOut_Date` date NOT NULL,
  `Amount` decimal(10,0) NOT NULL,
  `Status` enum('confirmed','pending','cancelled','completed') NOT NULL,
  `Special_Request` text NOT NULL,
  `CreatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`ReservationsID`),
  UNIQUE KEY `UserID` (`UserID`),
  UNIQUE KEY `HotelID` (`HotelID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `reservations table`
--

INSERT INTO `reservations table` (`ReservationsID`, `UserID`, `HotelID`, `CheckIn_date`, `CheckOut_Date`, `Amount`, `Status`, `Special_Request`, `CreatedAt`) VALUES
(5, 3, 2, '2025-02-12', '2025-02-14', 70, 'pending', '', '2025-02-02 20:41:09'),
(100, 1, 1, '0000-00-00', '0000-00-00', 150, 'confirmed', '', '2025-02-02 20:38:07');

-- --------------------------------------------------------

--
-- Table structure for table `reserved_rooms`
--

DROP TABLE IF EXISTS `reserved_rooms`;
CREATE TABLE IF NOT EXISTS `reserved_rooms` (
  `Reserved_rooms_ID` int NOT NULL,
  `ReservationsID` int NOT NULL,
  `RoomID` int NOT NULL,
  `Quantity` int NOT NULL DEFAULT '1',
  PRIMARY KEY (`Reserved_rooms_ID`),
  UNIQUE KEY `ReservationID` (`ReservationsID`),
  UNIQUE KEY `RoomID` (`RoomID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `reserved_rooms`
--

INSERT INTO `reserved_rooms` (`Reserved_rooms_ID`, `ReservationsID`, `RoomID`, `Quantity`) VALUES
(55, 5, 2, 1),
(77, 100, 1, 1);

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
  KEY `Foreign Key` (`HotelID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `rooms table`
--

INSERT INTO `rooms table` (`RoomID`, `HotelID`, `Room_type`, `Occupancy_adults`, `Occupancy_children`, `Price_per_night`, `Availability`, `Amenities`, `Bed_type`) VALUES
(1, 1, 'Suite', 2, 2, 300.00, 1, '{\"Mini Bar\": true, \"Air Conditioning\": true}', 'King'),
(2, 1, 'Double', 2, 0, 150.00, 1, '{\"Mini Bar\": false, \"Air Conditioning\": true}', 'Queen'),
(3, 2, 'Single', 1, 0, 80.00, 1, '{\"Mini Bar\": false, \"Air Conditioning\": true}', 'Twin'),
(4, 2, 'Double', 2, 0, 120.00, 1, '{\"Mini Bar\": true, \"Air Conditioning\": true}', 'Queen'),
(5, 3, 'Suite', 2, 1, 200.00, 1, '{\"Mini Bar\": true, \"Air Conditioning\": true}', 'King');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
CREATE TABLE IF NOT EXISTS `users` (
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

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`UserID`, `Email`, `Password`, `FName`, `LName`, `BirthDate`, `Phone`, `Role`, `SupportContact_message`, `SupportContact_preference`) VALUES
(1, 'alice.brown@gmail.com', 'SecurePass1!', 'Alice', 'Brown', '1987-06-30', '+1-555-8765', 'Traveler', 'Chatbot', ''),
(2, 'bob.white@yahoo.com', 'SecurePass2$', 'Bob', 'White', '1975-04-10', '+44-555-3456', 'Traveler', 'Need help with payment', 'Email'),
(3, 'carol.johnson@mail.com', 'SecurePass3#', 'Carol', 'Johnson', '1992-09-12', '+61-555-6543', 'Traveler', NULL, NULL),
(4, 'dave.williams@gmail.com', 'SecurePass4%', 'Dave', 'Williams', '1983-11-14', '+33-555-7890', 'Traveler', NULL, NULL),
(5, 'eve.miller@hotmail.com', 'SecurePass5^', 'Eve', 'Miller', '1995-07-19', '+91-555-4321', 'Traveler', NULL, NULL),
(6, 'john.doe@hotelbooking.com', 'AdminPass1*', 'John', 'Doe', '1980-05-15', '+1-555-2345', 'Admin', 'Chatbot', 'Chatbot'),
(7, 'jane.smith@hotelbooking.com', 'AdminPass2&', 'Jane', 'Smith', '1982-08-25', '+44-555-6789', 'Admin', 'Reply: Need help with payment', 'Email');

--
-- Constraints for dumped tables
--

--
-- Constraints for table `existing_reservations`
--
ALTER TABLE `existing_reservations`
  ADD CONSTRAINT `existing_reservations_ibfk_1` FOREIGN KEY (`UserID`) REFERENCES `users` (`UserID`);

--
-- Constraints for table `feedback`
--
ALTER TABLE `feedback`
  ADD CONSTRAINT `feedback_ibfk_1` FOREIGN KEY (`UserID`) REFERENCES `users` (`UserID`),
  ADD CONSTRAINT `feedback_ibfk_2` FOREIGN KEY (`HotelID`) REFERENCES `hotels table` (`HotelID`);

--
-- Constraints for table `hotel_reviews`
--
ALTER TABLE `hotel_reviews`
  ADD CONSTRAINT `hotel_reviews_ibfk_1` FOREIGN KEY (`HotelID`) REFERENCES `hotels table` (`HotelID`),
  ADD CONSTRAINT `hotel_reviews_ibfk_2` FOREIGN KEY (`UserID`) REFERENCES `users` (`UserID`);

--
-- Constraints for table `payment`
--
ALTER TABLE `payment`
  ADD CONSTRAINT `payment_ibfk_1` FOREIGN KEY (`ReservationsID`) REFERENCES `reservations table` (`ReservationsID`);

--
-- Constraints for table `reports`
--
ALTER TABLE `reports`
  ADD CONSTRAINT `reports_ibfk_1` FOREIGN KEY (`UserID`) REFERENCES `users` (`UserID`);

--
-- Constraints for table `reservations table`
--
ALTER TABLE `reservations table`
  ADD CONSTRAINT `reservations table_ibfk_1` FOREIGN KEY (`UserID`) REFERENCES `users` (`UserID`),
  ADD CONSTRAINT `reservations table_ibfk_2` FOREIGN KEY (`HotelID`) REFERENCES `hotels table` (`HotelID`);

--
-- Constraints for table `reserved_rooms`
--
ALTER TABLE `reserved_rooms`
  ADD CONSTRAINT `reserved_rooms_ibfk_1` FOREIGN KEY (`ReservationsID`) REFERENCES `reservations table` (`ReservationsID`),
  ADD CONSTRAINT `reserved_rooms_ibfk_2` FOREIGN KEY (`RoomID`) REFERENCES `rooms table` (`RoomID`);

--
-- Constraints for table `rooms table`
--
ALTER TABLE `rooms table`
  ADD CONSTRAINT `rooms table_ibfk_1` FOREIGN KEY (`HotelID`) REFERENCES `hotels table` (`HotelID`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
