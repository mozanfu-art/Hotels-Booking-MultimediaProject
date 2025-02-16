<?php
session_start();
include 'db-connect.php';

if (!isset($_SESSION['UserID'])) {
    header("Location: ../sign-home/Start-(HB).html");
    exit();
}

$userID = $_SESSION['UserID'];


if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    
    
    $payment_type = $_POST['paymentType'];
    $totalBill = $_POST['totalBill']; 
    $card_number = isset($_POST['cardNumber']) ? $_POST['cardNumber'] : null;
    $rooms = $_GET['Rooms'] ?? 1;
    $Adults = $_GET['Adults'] ?? 1;
    $Children = $_GET['Children'] ?? 1;
    $roomid = $_GET['room_id'] ?? 1; 
    $roomType = $_GET['roomType'] ?? '-'; 

    
    if (empty($payment_type) || empty($rooms) || empty($roomid) || empty($totalBill)) {
        die('All fields are required');
    }

    
    $sql = "INSERT INTO reservations (UserID, payment_type, card_number, Rooms, Adults, Children, RoomID, RoomTypes, Amount) 
            VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
    $stmt = $conn->prepare($sql);

    if ($stmt === false) {
        die('MySQL prepare error: ' . $conn->error);
    }

    
    $stmt->bind_param("issiiiisi", $userID, $payment_type, $card_number, $rooms, $Adults, $Children, $roomid, $roomType, $totalBill);

    
    if ($stmt->execute()) {
        
        header("Location: ../confirmation-reviews-feedbacks/confirmationPHP.php");
        exit();
    } else {
        
        die('Error saving reservation: ' . $stmt->error);
    }

}


$sql = "SELECT FName, LName, Email, Phone FROM users WHERE UserID = ?";
$stmt = $conn->prepare($sql);
$stmt->bind_param("i", $userID);
$stmt->execute();
$stmt->bind_result($firstName, $lastName, $email, $phone);
$stmt->fetch();
$stmt->close();


$roomID = $_GET['room_id'] ?? null;
$Adults = $_GET['Adults'] ?? 1;
$rooms = $_GET['Rooms'] ?? 1;
$Children = $_GET['Children'] ?? 1;

$roomPrice = 0;
if ($roomID) {
    $roomSql = "SELECT Price_per_night FROM rooms WHERE RoomID = ?";
    $roomStmt = $conn->prepare($roomSql);
    $roomStmt->bind_param("i", $roomID);
    $roomStmt->execute();
    $roomStmt->bind_result($roomPrice);
    $roomStmt->fetch();
    $roomStmt->close();
}

$totalBill = $roomPrice * $rooms;

?>




<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=0.75">
    <title>Payment Page</title>
    <style>
         
        /* General Styles */
        body {
          background-color: #fffbf0; 
          color: #004d40; 
          font-family: Arial, sans-serif;
          display: flex;
          justify-content: center;
          align-items: center;
          height: 100vh;
          margin: 0;
          padding: 0;
          flex-direction: column;
          min-height: 100vh;
      }
      
      /* Header Styles */
      .header {
        background-color: #004d40;
        color: #ffffff;
        padding: 10px 20px; 
        position: relative;
        display: flex;
        align-items: center;
        width: 100%;
    }

    .header .back-arrow {
        position: absolute;
        left: 20px;
    }

    .header .home-link {
        position: absolute;
        right: 20px; 
        top: 50%;
        transform: translateY(-50%);
        color: #ffffff;
        font-weight: bold;
    }

    .header h1 {
        flex-grow: 1;
        text-align: center;
        margin: 0;
        font-size: 1.5em; 
    }

    .container {
      display: flex;
      justify-content: center;
      align-items: center;
      width: 100%;
      margin: 10px;
      
  }

      select, input, button {
          margin: 8px 0;
          padding: 10px;
          border-radius: 5px;
          border: 1px solid #ccc;
      }

      button {
          background-color: #004d40;
          color: white;
          border: none;
          cursor: pointer;
      }

      .links {
          margin-top: 15px;
      }

      .links a {
          display: inline-block;
          margin: 5px;
          color: #004d40;
          text-decoration: none;
          font-weight: bold;
      }

      #cardDetails {
          display: none;
          margin-top: 10px;
      }

      .payment-methods {
        background-color: #ffffff;
        width: 50%;
        margin: 10px;
        padding: 10px;
        border-radius: 5px;
        box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        text-align: left; 
        display: flex;
        flex-direction: column; 
        justify-content: center; 
      }

      .payment-methods label {
          margin-right: 15px;
          font-weight: bold;
      } 

      .booker-info {
        background-color: #ffffff;
        width: 50%;
        margin: 10px;
        padding: 10px;
        border-radius: 5px;
        box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        text-align: left; 
        display: flex;
        flex-direction: column; 
        justify-content: center; 
        text-align: left; 
      }

      .booker-info label {
          display: block;
          margin-bottom: 5px;
          font-weight: bold;
      }

      .booker-info input {
          padding: 10px;
          margin-bottom: 15px;
      }

      /* Footer Styles */
      footer {
          background-color: #004d40;
          color: white;
          text-align: center;
          position: relative; 
          margin-top: auto; 
          width: 100%;
      }
    </style>
    <script>
        function toggleCardDetails() {
            var paymentType = document.querySelector('input[name="paymentType"]:checked').value;
            document.getElementById("cardDetails").style.display = paymentType === "card" ? "block" : "none";
        }
    </script>
</head>
<body>
  <div class="header">
    <a href="./BookingPHP.php"><img src="Back Arrow.png" width="35px"></a>
    <h1>Fill Your Information</h1>
    <h3>
        <a href="../sign-home/Home-(HB).html" class="home-link">Home</a>
    </h3>
</div>
    <div class="container">
        <div class="booker-info">
            <h2>Fill Your Information</h2>
            <form action="" method="POST">
                <label for="firstName">First Name:</label>
                <input type="text" id="firstName" name="firstName" value="<?php echo htmlspecialchars($firstName); ?>" required>

                <label for="lastName">Last Name:</label>
                <input type="text" id="lastName" name="lastName" value="<?php echo htmlspecialchars($lastName); ?>" required>

                <label for="email">Email:</label>
                <input type="email" id="email" name="email" value="<?php echo htmlspecialchars($email); ?>" required>

                <label for="phone">Phone Number:</label>
                <input type="tel" id="phone" name="phone" value="<?php echo htmlspecialchars($phone); ?>" required>

                <p><strong>Total Bill:</strong> $<?php echo number_format($totalBill, 2); ?></p>

                <div class="payment-methods">
                    <label>
                        <input type="radio" name="paymentType" value="cash" onchange="toggleCardDetails()"> Cash
                    </label>
                    <label>
                        <input type="radio" name="paymentType" value="card" onchange="toggleCardDetails()"> Card
                    </label>
                </div>

                <div id="cardDetails" style="display: none;">
                    <label for="cardNumber">Card Number:</label>
                    <input type="text" id="cardNumber" name="cardNumber" placeholder="Enter Card Number">
                </div>

                <input type="hidden" name="roomID" value="<?php echo $roomID; ?>">
                <input type="hidden" name="Adults" value="<?php echo $Adults; ?>">
                <input type="hidden" name="rooms" value="<?php echo $rooms; ?>">
                <input type="hidden" name="totalBill" value="<?php echo $totalBill; ?>">

                <button type="submit">Book Now</button>
            </form>
        </div>
    </div>

    <footer>
        <p>&copy; 2025 Hotels Booking. All rights reserved.</p>
    </footer>
</body>
</html>
