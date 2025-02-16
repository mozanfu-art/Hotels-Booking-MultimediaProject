<?php
include 'db-connect.php';
session_start();


if (!isset($_SESSION['UserID'])) {
    header("Location: ../sign-home/Start-(HB).html");
    exit();
}

$userID = $_SESSION['UserID']; 


if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}


$reservationSql = "SELECT * FROM reservations WHERE UserID = ? ORDER BY id DESC LIMIT 1";
$reservationStmt = $conn->prepare($reservationSql);

if ($reservationStmt === false) {
    die('MySQL prepare error: ' . $conn->error);
}

$reservationStmt->bind_param("i", $userID);
$reservationStmt->execute();
$reservationResult = $reservationStmt->get_result();

if ($reservationResult->num_rows > 0) {
    $reservation = $reservationResult->fetch_assoc();
} else {
    die("No reservations found.");
}


$userSql = "SELECT * FROM users WHERE UserID = ?";
$userStmt = $conn->prepare($userSql);

if ($userStmt === false) {
    die('MySQL prepare error: ' . $conn->error);
}

$userStmt->bind_param("i", $userID);
$userStmt->execute();
$userResult = $userStmt->get_result();

if ($userResult->num_rows > 0) {
    $user = $userResult->fetch_assoc();
} else {
    die("User not found.");
}


$reservationStmt->close();
$userStmt->close();
$conn->close();
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Booking Confirmation</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #fffbf0; 
            margin: 0;
            padding: 0;
            color: #004d40; 
            display: flex;
            flex-direction: column;
            min-height: 100vh;
        }

        .header {
            background-color: #004d40;
            color: #ffffff;
            padding: 10px 20px; 
            position: relative;
            display: flex;
            align-items: center;
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

        .section {
            text-align: center;
        }

        .details {
            background-color: #004d40;
            color: #ffffff;
            font-size: 1.3em;
            text-align: left;
            position: relative;
            margin: 1em;
            padding: 5px;
            font-family: Cambria;
            border: 1px solid #fff;
        }

        .yellow-bg {
            background: #fef5e7;
        }

        .reviews-policy-button {
        margin-top: 2em;
        margin-bottom: 2em;
        margin-left: 1em;
        padding: 0.6em;
        width: 15%;
        text-decoration: none;
        color: #004d40;
        border: 1px solid  #004d40 ;
        font-family: Cambria;
        font-size: 1.3em;
    }
    .reviews-policy-button:hover{
        background: #004d40;
        color:  #fff;
    }

        footer {
            background-color: #004d40;
            color: white;
            text-align: center;
            position: relative; 
            margin-top: auto; 
            width: 100%;
        }
    </style>
</head>
<body>
    <div class="header">
        <h1>Booking Confirmation</h1>
        <a href="../sign-home/Home-(HB).html" class="home-link">Home</a>
    </div>
    <div class="section">
        <h3>Your reservation is confirmed!</h3>
    </div>
    <div class="msg">
        <p><b>Hi <?php echo htmlspecialchars($user['FName']) . ' ' . htmlspecialchars($user['LName']); ?>        ,</b></p>
        <p class="text-msg">Thank you for choosing our app,<br> 
            after your staying you will be invited to
            provide a review about your experience at the hotel. </p>
    </div>

    <div class="details">
        <label>Reservation Details</label>
    </div>
    <table>
        <tr>
            <td class="yellow-bg">Lead Guest Name:</td>
            <td><?php echo htmlspecialchars($user['FName']) . ' ' . htmlspecialchars($user['LName']); ?> </td>
        </tr>
        <tr>
            <td class="yellow-bg">Room Type:</td>
            <td><?php echo htmlspecialchars($reservation['RoomTypes']); ?></td>
        </tr>
        <tr>
            <td class="yellow-bg">Number of Adults:</td>
            <td><?php echo $reservation['Adults']; ?> Adults</td>
        </tr>        <tr>
            <td class="yellow-bg">Number of Children:</td>
            <td><?php echo $reservation['Children']; ?> Children</td>
        </tr>
        <tr>
            <td class="yellow-bg">Number of Rooms:</td>
            <td><?php echo $reservation['Rooms']; ?> Rooms</td>
        </tr><tr>
            <td class="yellow-bg">Created at:</td>
            <td><?php echo $reservation['CreatedAt']; ?> </td>
        </tr>
      
    </table>

    <div class="details">
        <label>Payment Details</label>
    </div>
    <table>
        <tr>
            <td class="yellow-bg">Total Charge</td>
            <td><?php echo $reservation['Amount']; ?></td>
        </tr>
        <tr>
    <td class="yellow-bg">Paid with</td>
    <td>
        <?php
        if ($reservation['payment_type'] == 'card') {
            
            echo "Credit Card: xxxxxxxx" . substr($reservation['card_number'], -4);
        } else {
            
            echo "Cash";
        }
        ?>
    </td>
</tr>

    </table>
    <div class="details">
        <label>Cancellation Policy</label>
    </div>
    <table>
        <tr>
            <td class="yellow-bg">This booking is non-refundable.</td>
        </tr>
    </table>
    <a href="../confirmation-reviews-feedbacks/feedbackPHP.php" class="reviews-policy-button">
        Give our app a feedback?
    </a>
    <footer>
        <p>&copy; 2025 Hotels Booking. All rights reserved.</p>
    </footer>
</body>
</html>

