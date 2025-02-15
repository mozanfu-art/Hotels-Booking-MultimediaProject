<?php
session_start();
include '../db-connect.php';

if (!isset($_SESSION['UserID'])) {
    header("Location: ../sign-home/login.php");
    exit();
}

$userID = $_SESSION['UserID'];


$sql = "SELECT r.id, r.RoomID, r.RoomTypes, r.Rooms, r.Adults, r.Children, r.Amount, r.payment_type, r.card_number, r.status, ro.Room_type, r.CreatedAt
        FROM reservations r
        INNER JOIN rooms ro ON r.RoomID = ro.RoomID
        WHERE r.UserID = ?";


$stmt = $conn->prepare($sql);

if ($stmt === false) {
    
    die('MySQL prepare error: ' . $conn->error);
}

$stmt->bind_param("i", $userID);
$stmt->execute();
$result = $stmt->get_result();
?>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Your Bookings</title>
    
    <style>
        /* General Styles */
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

        .container {
            flex: 1;
            padding: 20px;
            max-width: 1200px;
            margin: 0 auto;
            width: 90%;
        }

        .booking-list {
            display: flex;
            flex-direction: column;
            gap: 20px;
        }

        .booking-card {
            background-color: white;
            border-radius: 12px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            padding: 20px;
            display: flex;
            flex-direction: column;
            gap: 10px;
            position: relative;
        }

        .reservation-id {
            position: absolute;
            top: 30px;
            right: 10px;
            font-size: 14px;
            font-weight: bold;
            color: #004d40;
            background-color: #ffeb3b;
            padding: 5px 10px;
            border-radius: 5px;
        }

        .booking-title {
            font-size: 18px;
            font-weight: bold;
            color: #004d40;
        }

        .booking-details {
            font-size: 14px;
            color: #555;
        }

        .booking-footer {
            display: flex;
            justify-content: space-between;
            font-size: 16px;
        }

        .booking-status {
            font-weight: bold;
        }

        .yellow-bg {
            background-color: #ffeb3b;
            font-weight: bold;
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
        <a href="../profile-dashboard-account/manage-account.html"><img src="Back Arrow.png" width="35px" class="back-arrow"></a>
        <h1>Your Bookings</h1>
        <h3><a href="../sign-home/Home-(HB).html" class="home-link">Home</a></h3>
    </div>

    <div class="container">
        <div class="booking-list">
            <?php while ($reservation = $result->fetch_assoc()) { ?>
                <div class="booking-card">
                    <div class="reservation-id">#<?php echo htmlspecialchars($reservation['id']); ?></div>
                    <p class="booking-title"><?php echo htmlspecialchars($reservation['Room_type']); ?> Room</p>
                    <p class="booking-details">Rooms: <?php echo htmlspecialchars($reservation['Rooms']); ?></p>
                    <p class="booking-details">Adults: <?php echo htmlspecialchars($reservation['Adults']); ?></p>
                    <p class="booking-details">Children: <?php echo htmlspecialchars($reservation['Children']); ?></p>
                    <p class="booking-details">Amount: USD <?php echo htmlspecialchars($reservation['Amount']); ?></p>
                    <p class="booking-details">Created at <?php echo htmlspecialchars($reservation['CreatedAt']); ?></p>
                    
                    <div class="booking-footer">
                        <p class="booking-status"><?php echo ucfirst($reservation['status']); ?></p>
                        <p>
                            <?php
                            if ($reservation['payment_type'] == 'card') {
                                echo 'Paid with credit card: xxxxxxxx' . substr($reservation['card_number'], -4);
                            } else {
                                echo 'Paid with Cash';
                            }
                            ?>
                        </p>
                    </div>
                </div>
            <?php } ?>
        </div>
    </div>

    <footer>
        <p>&copy; 2025 Hotels Booking. All rights reserved.</p>
    </footer>

</body>

</html>

<?php
$stmt->close();
$conn->close();
?>
