-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: Feb 01, 2025 at 03:47 AM
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

-- --------------------------------------------------------

--
-- Table structure for table `hotels table`, created by Awab-Ahmed-Os
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
-- Table structure for table `reports`, created by Mozan-Abdelsamie
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
-- Table structure for table `rooms table`, created by Awab-Ahmed-Os
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
-- Table structure for table `users` created by Mozan-Abdelsamie
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


USE global_hotels_booking;

-- Insert 5 travelers information samples to the users table, created by Mozan-Abdelsamie
INSERT INTO users (Email, Password, FName, LName, BirthDate, Phone, Role, SupportContact_message, SupportContact_preference) VALUES
('alice.brown@gmail.com', 'SecurePass1!', 'Alice', 'Brown', '1987-06-30', '+1-555-8765', 'Traveler', 'Question about reservation', 'Chatbox'),
('bob.white@yahoo.com', 'SecurePass2$', 'Bob', 'White', '1975-04-10', '+44-555-3456', 'Traveler', 'Need help with payment', 'Email'),
('carol.johnson@mail.com', 'SecurePass3#', 'Carol', 'Johnson', '1992-09-12', '+61-555-6543', 'Traveler', NULL, NULL),
('dave.williams@gmail.com', 'SecurePass4%', 'Dave', 'Williams', '1983-11-14', '+33-555-7890', 'Traveler', NULL, NULL),
('eve.miller@hotmail.com', 'SecurePass5^', 'Eve', 'Miller', '1995-07-19', '+91-555-4321', 'Traveler', NULL, NULL);

-- Insert 2 admins samples to the users table, created by Mozan-Abdelsamie
INSERT INTO users (Email, Password, FName, LName, BirthDate, Phone, Role, SupportContact_message, SupportContact_preference) VALUES
('john.doe@hotelbooking.com', 'AdminPass1*', 'John', 'Doe', '1980-05-15', '+1-555-2345', 'Admin', 'Reply: Question about reservation', 'chatbot'),
('jane.smith@hotelbooking.com', 'AdminPass2&', 'Jane', 'Smith', '1982-08-25', '+44-555-6789', 'Admin', 'Reply: Need help with payment', 'Email');

-- Create a procedure to authenticate user, created by Mozan-Abdelsamie
DELIMITER $$

CREATE PROCEDURE AuthenticateUser(IN userEmail VARCHAR(50), IN userPassword VARCHAR(50))
BEGIN
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
END $$

DELIMITER ;

-- Select all rows from the users table to verify insertion
SELECT * FROM users;
-- Show the status of all procedures in the database
SHOW PROCEDURE STATUS WHERE Db = 'global_hotels_booking';
SHOW CREATE PROCEDURE AuthenticateUser;

-- Update the SupportContact_message field for the specific row using primary key
UPDATE users
SET SupportContact_message = 'Chatbot'
WHERE UserID = 1;

UPDATE users
SET SupportContact_message = 'Chatbot'
WHERE UserID = 6;

-- Select the specific row to verify the update
SELECT * FROM users;

-- Insert reports data samples, created by Mozan-Abdelsamie
-- by admin John Doe (UserID = 6) 
INSERT INTO reports (UserID, ReportType, ReportData, ReportDate) VALUES
(6, 'Bookings', 'Booking data excel file', CURRENT_TIMESTAMP),
(6, 'Revenues', 'Revenues data PDF file', CURRENT_TIMESTAMP);

-- by admin Jane Smith (UserID = 7)
INSERT INTO reports (UserID, ReportType, ReportData, ReportDate) VALUES
(7, 'Users', 'Users data excel file', CURRENT_TIMESTAMP),
(7, 'Hotels', 'Hotels data PDF file', CURRENT_TIMESTAMP),
(7, 'Feedbacks', 'Feedbacks data PDF file', CURRENT_TIMESTAMP);

SELECT * FROM reports;
SHOW TABLES;
DESCRIBE users;

ALTER TABLE users
MODIFY COLUMN FName VARCHAR(50) NOT NULL,
MODIFY COLUMN Role ENUM('Traveler', 'Admin') NOT NULL;
DESCRIBE users;

DESCRIBE reports;
ALTER TABLE reports
MODIFY COLUMN ReportType ENUM('Bookings','Revenues','Users','Hotels','Feedbacks') NOT NULL,
MODIFY COLUMN ReportData BLOB NOT NULL,
MODIFY COLUMN ReportDate TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP;
DESCRIBE reports;



