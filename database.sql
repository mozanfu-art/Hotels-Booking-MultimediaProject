-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: Feb 15, 2025 at 08:53 PM
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
-- Database: `global_hotels_booking`
--

-- --------------------------------------------------------

--
-- Table structure for table `feedback`
--

DROP TABLE IF EXISTS `feedback`;
CREATE TABLE IF NOT EXISTS `feedback` (
  `RateID` int NOT NULL AUTO_INCREMENT,
  `UserID` int DEFAULT NULL,
  `Feedback` text COLLATE utf8mb4_general_ci,
  `FeedbackDate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `AppRate` int DEFAULT NULL,
  PRIMARY KEY (`RateID`),
  UNIQUE KEY `UserID_2` (`UserID`),
  KEY `UserID` (`UserID`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `feedback`
--

INSERT INTO `feedback` (`RateID`, `UserID`, `Feedback`, `FeedbackDate`, `AppRate`) VALUES
(1, 3, 'Great experience!', '2025-02-03 16:07:47', 5);

-- --------------------------------------------------------

--
-- Table structure for table `hotels`
--

DROP TABLE IF EXISTS `hotels`;
CREATE TABLE IF NOT EXISTS `hotels` (
  `HotelID` int NOT NULL,
  `Hotel_name` varchar(50) NOT NULL,
  `Country` varchar(50) NOT NULL,
  `City` varchar(50) NOT NULL,
  `Address` text NOT NULL,
  `Star_rate` int NOT NULL,
  `Description` text NOT NULL,
  `Amenities` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `ImageURLs` text NOT NULL,
  PRIMARY KEY (`HotelID`)
) ;

--
-- Dumping data for table `hotels`
--

INSERT INTO `hotels` (`HotelID`, `Hotel_name`, `Country`, `City`, `Address`, `Star_rate`, `Description`, `Amenities`, `ImageURLs`) VALUES
(1, 'Sunrise Hotel', 'Sudan', 'Khartoum', '123 Nile Street', 5, 'A luxurious hotel with a stunning view of the Nile.', '{\"Gym\": true, \"Pool\": true, \"WiFi\": true}', 'sunrise_hotel.jpg'),
(2, 'Desert Oasis', 'Egypt', 'Cairo', '456 Pyramid Road', 4, 'A charming hotel near the Pyramids.', '{\"Spa\": true, \"Pool\": true, \"WiFi\": true}', 'desert_oasis.jpg'),
(3, 'Mountain Retreat', 'Ethiopia', 'Addis Ababa', '789 Mountain Road', 3, 'A cozy retreat in the mountains.', '{\"Gym\": true, \"WiFi\": true}', 'mountain_retreat.jpg');

-- --------------------------------------------------------

--
-- Table structure for table `hotel_reviews`
--

DROP TABLE IF EXISTS `hotel_reviews`;
CREATE TABLE IF NOT EXISTS `hotel_reviews` (
  `created_at` date DEFAULT NULL,
  `full_name` varchar(50) COLLATE utf8mb4_general_ci NOT NULL,
  `user_email` varchar(50) COLLATE utf8mb4_general_ci NOT NULL,
  `review_text` varchar(50) COLLATE utf8mb4_general_ci NOT NULL,
  `ReviewID` int NOT NULL AUTO_INCREMENT,
  `UserID` int DEFAULT NULL,
  `HotelID` int DEFAULT NULL,
  `Star_rate` int DEFAULT NULL,
  `Review` text COLLATE utf8mb4_general_ci,
  `ReviewDate` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`ReviewID`),
  KEY `UserID` (`UserID`),
  KEY `HotelID` (`HotelID`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `hotel_reviews`
--

INSERT INTO `hotel_reviews` (`created_at`, `full_name`, `user_email`, `review_text`, `ReviewID`, `UserID`, `HotelID`, `Star_rate`, `Review`, `ReviewDate`) VALUES
(NULL, 'ali', 'aliew123@gmail.com', 'sdlkfnsdv sdjfsl;dff sdlkfsdmf', 2, NULL, NULL, 3, NULL, '2025-02-14 15:26:00'),
('2025-02-14', 'asdas', 'asfva@fsedsdf.com', 'fosdjkflsdf', 3, NULL, NULL, 4, NULL, '2025-02-14 15:28:40'),
('2025-02-14', 'ahmed', 'asfva@fseddsfsdfsdf.com', 'fewgbnrsfdsgsdg', 4, NULL, NULL, 5, NULL, '2025-02-14 15:35:54'),
('2025-02-15', 'mozan ahmed', 'mozan@gmail.com', 'nice staying.', 5, 15, NULL, 1, NULL, '2025-02-15 19:51:51');

-- --------------------------------------------------------

--
-- Table structure for table `payment`
--

DROP TABLE IF EXISTS `payment`;
CREATE TABLE IF NOT EXISTS `payment` (
  `PaymentID` int NOT NULL,
  `ReservationID` int DEFAULT NULL,
  `Payment_method` enum('credit card','cash','','') COLLATE utf8mb4_general_ci NOT NULL,
  `Amount` decimal(10,0) NOT NULL,
  `TransactionID` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `Currency` varchar(10) COLLATE utf8mb4_general_ci NOT NULL,
  `Status` enum('success','failed','pending','') COLLATE utf8mb4_general_ci NOT NULL,
  `PaymentDate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`PaymentID`),
  UNIQUE KEY `ReservationsID` (`ReservationID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `payment`
--

INSERT INTO `payment` (`PaymentID`, `ReservationID`, `Payment_method`, `Amount`, `TransactionID`, `Currency`, `Status`, `PaymentDate`) VALUES
(1, 5, 'credit card', 70, '45', 'USD', 'success', '2025-02-02 20:41:09'),
(2, 100, 'credit card', 150, '46', 'USD', 'success', '2025-02-02 20:38:07');

-- --------------------------------------------------------

--
-- Table structure for table `reports`
--

DROP TABLE IF EXISTS `reports`;
CREATE TABLE IF NOT EXISTS `reports` (
  `ReportID` int NOT NULL AUTO_INCREMENT,
  `UserID` int DEFAULT NULL,
  `ReportType` enum('Bookings','Revenues','Users','Hotels','Feedbacks') COLLATE utf8mb4_general_ci NOT NULL,
  `ReportData` blob NOT NULL,
  `ReportDate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`ReportID`),
  KEY `UserID` (`UserID`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `reports`
--

INSERT INTO `reports` (`ReportID`, `UserID`, `ReportType`, `ReportData`, `ReportDate`) VALUES
(1, 6, 'Bookings', 0x426f6f6b696e67206461746120657863656c2066696c65, '2025-02-02 14:11:29'),
(2, 6, 'Revenues', 0x526576656e7565732064617461205044462066696c65, '2025-02-02 14:11:29');

-- --------------------------------------------------------

--
-- Table structure for table `reservations`
--

DROP TABLE IF EXISTS `reservations`;
CREATE TABLE IF NOT EXISTS `reservations` (
  `id` int NOT NULL AUTO_INCREMENT,
  `UserID` int NOT NULL,
  `RoomID` int NOT NULL,
  `CheckIn_date` date NOT NULL,
  `CheckOut_Date` date NOT NULL,
  `Amount` decimal(10,0) NOT NULL,
  `Status` enum('confirmed','pending','cancelled','completed') COLLATE utf8mb4_general_ci NOT NULL,
  `Special_Request` text COLLATE utf8mb4_general_ci NOT NULL,
  `CreatedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `PaymentID` int DEFAULT NULL,
  `Rooms` int NOT NULL DEFAULT '1',
  `Adults` int NOT NULL DEFAULT '1',
  `Children` int DEFAULT '0',
  `RoomTypes` set('Single','Double','Suite') COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'Single',
  `payment_type` varchar(50) COLLATE utf8mb4_general_ci NOT NULL,
  `card_number` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `PaymentID` (`PaymentID`),
  KEY `FK_reservations_hotels` (`RoomID`),
  KEY `FK_reservations_user` (`UserID`)
) ENGINE=InnoDB AUTO_INCREMENT=128 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `reservations`
--

INSERT INTO `reservations` (`id`, `UserID`, `RoomID`, `CheckIn_date`, `CheckOut_Date`, `Amount`, `Status`, `Special_Request`, `CreatedAt`, `PaymentID`, `Rooms`, `Adults`, `Children`, `RoomTypes`, `payment_type`, `card_number`) VALUES
(5, 5, 2, '2025-02-12', '2025-02-14', 70, 'completed', '', '2025-02-02 20:41:09', NULL, 1, 1, 0, 'Single', '', 0),
(100, 1, 1, '0000-00-00', '0000-00-00', 150, 'confirmed', '', '2025-02-02 20:38:07', NULL, 1, 1, 0, 'Single', '', 0),
(123, 13, 1, '0000-00-00', '0000-00-00', 900, 'confirmed', '', '2025-02-15 08:12:34', NULL, 3, 2, 2, 'Suite', 'cash', 0),
(124, 13, 1, '0000-00-00', '0000-00-00', 300, 'confirmed', '', '2025-02-15 08:17:40', NULL, 1, 1, 0, 'Suite', 'cash', 0),
(125, 13, 1, '0000-00-00', '0000-00-00', 600, 'confirmed', '', '2025-02-15 08:30:49', NULL, 2, 1, 0, 'Suite', 'cash', 0),
(126, 13, 2, '0000-00-00', '0000-00-00', 150, 'confirmed', '', '2025-02-15 08:35:12', NULL, 1, 1, 0, 'Double', 'cash', 0),
(127, 15, 2, '0000-00-00', '0000-00-00', 150, 'confirmed', '', '2025-02-15 19:23:55', NULL, 1, 1, 0, 'Double', 'cash', 0);

-- --------------------------------------------------------

--
-- Table structure for table `reserved_rooms`
--

DROP TABLE IF EXISTS `reserved_rooms`;
CREATE TABLE IF NOT EXISTS `reserved_rooms` (
  `Reserved_rooms_ID` int NOT NULL,
  `ReservationID` int NOT NULL,
  `RoomID` int NOT NULL,
  `Quantity` int NOT NULL DEFAULT '1',
  PRIMARY KEY (`Reserved_rooms_ID`),
  UNIQUE KEY `ReservationID` (`ReservationID`),
  UNIQUE KEY `RoomID` (`RoomID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `reserved_rooms`
--

INSERT INTO `reserved_rooms` (`Reserved_rooms_ID`, `ReservationID`, `RoomID`, `Quantity`) VALUES
(55, 5, 2, 1),
(77, 100, 1, 1);

-- --------------------------------------------------------

--
-- Table structure for table `rooms`
--

DROP TABLE IF EXISTS `rooms`;
CREATE TABLE IF NOT EXISTS `rooms` (
  `RoomID` int NOT NULL,
  `HotelID` int NOT NULL,
  `max_guests` int NOT NULL,
  `max_rooms` int NOT NULL,
  `Room_type` enum('Single','Double','Suite') NOT NULL,
  `Occupancy_adults` int NOT NULL,
  `Occupancy_children` int NOT NULL,
  `Price_per_night` decimal(10,2) NOT NULL,
  `Availability` tinyint(1) NOT NULL,
  `Amenities` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `Bed_type` enum('King','Queen','Twin') NOT NULL,
  `image` varchar(100) NOT NULL,
  `Description` varchar(150) NOT NULL,
  PRIMARY KEY (`RoomID`),
  KEY `Foreign Key` (`HotelID`)
) ;

--
-- Dumping data for table `rooms`
--

INSERT INTO `rooms` (`RoomID`, `HotelID`, `max_guests`, `max_rooms`, `Room_type`, `Occupancy_adults`, `Occupancy_children`, `Price_per_night`, `Availability`, `Amenities`, `Bed_type`, `image`, `Description`) VALUES
(1, 1, 2, 3, 'Suite', 2, 2, 300.00, 1, '{\"Mini Bar\": true, \"Air Conditioning\": true}', 'King', 'Suite Room.jpg', 'A luxurious suite with a king Sized bed and sofa.'),
(2, 1, 3, 2, 'Double', 2, 0, 150.00, 1, '{\"Mini Bar\": true, \"Air Conditioning\": true}', 'Queen', 'Double Room.jpg', 'A spacious room with a Queen Sized bed for two people.'),
(3, 2, 4, 4, 'Single', 1, 0, 80.00, 1, '{\"Mini Bar\": false, \"Air Conditioning\": true}', 'Twin', 'Single Room.jpg', 'A cozy room for one person with a Twin Sized bed.');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
CREATE TABLE IF NOT EXISTS `users` (
  `UserID` int NOT NULL AUTO_INCREMENT,
  `Email` varchar(50) COLLATE utf8mb4_general_ci NOT NULL,
  `Password` varchar(50) COLLATE utf8mb4_general_ci NOT NULL,
  `FName` varchar(50) COLLATE utf8mb4_general_ci NOT NULL,
  `LName` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `BirthDate` date DEFAULT NULL,
  `Phone` varchar(20) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `card_number` varchar(16) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Role` enum('Traveler','Admin') COLLATE utf8mb4_general_ci NOT NULL,
  `SupportContact_message` text COLLATE utf8mb4_general_ci,
  `SupportContact_preference` enum('Phone','Email','Chatbot') COLLATE utf8mb4_general_ci DEFAULT NULL,
  `theme` varchar(10) COLLATE utf8mb4_general_ci DEFAULT 'light',
  `currency` varchar(5) COLLATE utf8mb4_general_ci DEFAULT 'usd',
  `lang` varchar(11) COLLATE utf8mb4_general_ci NOT NULL,
  `email_notifications` tinyint(1) DEFAULT '1',
  `sms_notifications` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`UserID`),
  UNIQUE KEY `Email` (`Email`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`UserID`, `Email`, `Password`, `FName`, `LName`, `BirthDate`, `Phone`, `card_number`, `Role`, `SupportContact_message`, `SupportContact_preference`, `theme`, `currency`, `lang`, `email_notifications`, `sms_notifications`) VALUES
(1, 'alice.brown@gmail.com', 'SecurePass1!', 'Alice', 'Brown', '1987-06-30', '+1-555-8765', '', 'Traveler', '', 'Chatbot', 'light', 'usd', '', 1, 1),
(2, 'bob.white@yahoo.com', 'SecurePass2$', 'Bob', 'White', '1975-04-10', '+44-555-3456', '', 'Traveler', 'Need help with payment', 'Email', 'light', 'usd', '', 1, 1),
(3, 'carol.johnson@mail.com', 'SecurePass3#', 'Carol', 'Johnson', '1992-09-12', '+61-555-6543', '', 'Traveler', NULL, NULL, 'light', 'usd', '', 1, 1),
(4, 'dave.williams@gmail.com', 'SecurePass4%', 'Dave', 'Williams', '1983-11-14', '+33-555-7890', '', 'Traveler', NULL, NULL, 'light', 'usd', '', 1, 1),
(5, 'eve.miller@hotmail.com', 'SecurePass5^', 'Eve', 'Miller', '1995-07-19', '+91-555-4321', '', 'Traveler', NULL, NULL, 'light', 'usd', '', 1, 1),
(6, 'john.doe@hotelbooking.com', 'AdminPass1*', 'John', 'Doe', '1980-05-15', '+1-555-2345', '', 'Admin', 'Chatbot', 'Chatbot', 'light', 'usd', '', 1, 1),
(7, 'jane.smith@hotelbooking.com', 'AdminPass2&', 'Jane', 'Smith', '1982-08-25', '+44-555-6789', '', 'Admin', 'Reply: Need help with payment', 'Email', 'light', 'usd', '', 1, 1),
(13, 'dsfwefew@gdmskgsd.com', '12e45316', 'fdssdf', 'sdfsdfsd', '2007-05-09', 'ge54f423', NULL, 'Traveler', NULL, NULL, 'dark', 'usd', 'ar', 0, 1),
(14, 'ljaklkaklfsd@gmail.com', '1234567', 'ahmed', 'zahir', '1111-11-11', '123456789', NULL, 'Traveler', NULL, NULL, 'light', 'usd', '', 1, 1),
(15, 'mozan@gmail.com', '12345mozan', 'mozan', 'ahmed', '2025-02-15', '0123456789', NULL, 'Traveler', NULL, NULL, 'light', 'usd', 'ar', 1, 1);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `feedback`
--
ALTER TABLE `feedback`
  ADD CONSTRAINT `feedback_ibfk_1` FOREIGN KEY (`UserID`) REFERENCES `users` (`UserID`);

--
-- Constraints for table `hotel_reviews`
--
ALTER TABLE `hotel_reviews`
  ADD CONSTRAINT `hotel_reviews_ibfk_1` FOREIGN KEY (`UserID`) REFERENCES `users` (`UserID`),
  ADD CONSTRAINT `hotel_reviews_ibfk_2` FOREIGN KEY (`HotelID`) REFERENCES `hotels` (`HotelID`);

--
-- Constraints for table `reports`
--
ALTER TABLE `reports`
  ADD CONSTRAINT `reports_ibfk_1` FOREIGN KEY (`UserID`) REFERENCES `users` (`UserID`);

--
-- Constraints for table `reservations`
--
ALTER TABLE `reservations`
  ADD CONSTRAINT `FK_reservations_hotels` FOREIGN KEY (`RoomID`) REFERENCES `hotels` (`HotelID`),
  ADD CONSTRAINT `FK_reservations_payment` FOREIGN KEY (`PaymentID`) REFERENCES `payment` (`PaymentID`),
  ADD CONSTRAINT `FK_reservations_user` FOREIGN KEY (`UserID`) REFERENCES `users` (`UserID`);

--
-- Constraints for table `reserved_rooms`
--
ALTER TABLE `reserved_rooms`
  ADD CONSTRAINT `FK_reserved_rooms_reservation` FOREIGN KEY (`ReservationID`) REFERENCES `reservations` (`id`),
  ADD CONSTRAINT `FK_reserved_rooms_room` FOREIGN KEY (`RoomID`) REFERENCES `rooms` (`RoomID`);

--
-- Constraints for table `rooms`
--
ALTER TABLE `rooms`
  ADD CONSTRAINT `rooms_ibfk_1` FOREIGN KEY (`HotelID`) REFERENCES `hotels` (`HotelID`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
