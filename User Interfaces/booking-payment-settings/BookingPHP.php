<?php
include 'db-connect.php';
session_start();


if (!isset($_SESSION['UserID'])) {
    header("Location: ../sign-home/login.php");
    exit();
}


$sql = "SELECT * FROM rooms";
$result = $conn->query($sql);
?>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Booking Page</title>
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

        .container {
            display: flex;
            justify-content: space-between;
            flex-wrap: wrap;
            padding: 20px;
            gap: 20px;
        }

        .room-card {
            background-color: white;
            border-radius: 12px;
            width: 30%;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
            border: 1px solid #ddd;
            overflow: hidden;
            text-align: center;
            transition: transform 0.3s ease-in-out;
        }

        .room-card:hover {
            transform: translateY(-5px);
        }

        .room-card img {
            width: 100%;
            height: auto;
            border-bottom: 2px solid #ddd;
        }

        .room-card .room-info {
            padding: 15px;
        }

        .room-card .room-title {
            font-size: 18px;
            font-weight: bold;
            color: #004d40;
        }

        .room-card .room-description {
            font-size: 14px;
            color: #555;
            margin-top: 10px;
        }

        .room-card .room-amenities {
            font-size: 12px;
            color: #777;
            margin-top: 10px;
        }

        .room-card .room-price {
            font-size: 20px;
            font-weight: bold;
            color: #d32f2f;
            margin-top: 15px;
        }

        .room-card .room-discounted-price {
            font-size: 24px;
            font-weight: bold;
            color: #000;
            margin-top: 5px;
        }

        .room-card .room-guests,
        .room-card .room-rooms {
            font-size: 14px;
            color: #555;
            margin-top: 10px;
        }

        .room-card .input-group {
            display: flex;
            justify-content: space-between;
            margin-top: 10px;
        }

        .room-card .input-group label {
            font-size: 14px;
            color: #555;
        }

        .room-card .input-group input {
            width: 60px;
            padding: 5px;
            font-size: 14px;
            border-radius: 5px;
            border: 1px solid #ccc;
        }

        .room-card .reserve-btn {
            display: block;
            width: 100%;
            padding: 10px;
            background: #004d40;
            color: white;
            text-align: center;
            border-radius: 5px;
            text-decoration: none;
            font-weight: bold;
            margin-top: 10px;
        }

        footer {
            background-color: #004d40;
            color: white;
            text-align: center;
            position: relative;
            margin-top: auto;
            width: 100%;
        }

        .strikethrough {
            text-decoration: line-through;
            color: red;
        }
    </style>
</head>

<body>
    <div class="header">
        <a href="../search-details/search-results.html"><img src="Back Arrow.png" width="35px"></a>
        <h1>Choose your stay</h1>
        <h3><a href="../sign-home/Home-(HB).html" class="home-link">Home</a></h3>
    </div>

    <div class="container">
        <?php while ($row = $result->fetch_assoc()) { ?>
            <div class="room-card">
                <img src="<?php echo htmlspecialchars($row['image']); ?>"
                    alt="<?php echo htmlspecialchars($row['Room_type']); ?>">
                <div class="room-info">
                    <p class="room-title"><?php echo htmlspecialchars($row['Room_type']); ?> Room</p>
                    <p class="room-description"><?php echo htmlspecialchars($row['Description']); ?></p>
                    <p class="room-amenities">
                        <strong>Amenities:</strong>
                        <?php
                        $amenities = json_decode($row['Amenities'], true);
                        if (!empty($amenities)) {
                            echo implode(", ", array_keys(array_filter($amenities)));
                        } else {
                            echo "";
                        }
                        ?>
                    </p>
                    <p class="room-price"><span class="strikethrough">USD <?php echo $row['Price_per_night']; ?></span></p>
                    <p class="room-discounted-price">USD <?php echo $row['Price_per_night']; ?></p>

                    <div class="input-group">
                        <label for="numAdults<?php echo $row['RoomID']; ?>">Adults:</label>
                        <input type="number" id="numAdults<?php echo $row['RoomID']; ?>" value="1" min="1"
                            max="<?php echo $row['Occupancy_adults']; ?>">
                    </div>
                    <div class="input-group">
                        <label for="numChildren<?php echo $row['RoomID']; ?>">Children:</label>
                        <input type="number" id="numChildren<?php echo $row['RoomID']; ?>" value="0" min="0"
                            max="<?php echo $row['Occupancy_children']; ?>">
                    </div>

                    <div class="input-group">
                        <label for="numRooms<?php echo $row['RoomID']; ?>">Rooms :</label>
                        <input type="number" id="numRooms<?php echo $row['RoomID']; ?>" value="1" min="1" max="<?php echo $row['max_rooms']; ?>">
                    </div>

                    <a href="#" class="reserve-btn"
                        onclick="redirectToPayment(<?php echo $row['RoomID']; ?>, '<?php echo addslashes($row['Room_type']); ?>')">
                        Reserve
                    </a>


                    <script>
                        function redirectToPayment(roomID, roomType) {
                            let Adults = document.getElementById("numAdults" + roomID).value;
                            let Children = document.getElementById("numChildren" + roomID).value;
                            let rooms = document.getElementById("numRooms" + roomID).value;

                            
                            let paymentUrl = `./PaymentPHP.php?room_id=${roomID}&Adults=${Adults}&Children=${Children}&Rooms=${rooms}&roomType=${encodeURIComponent(roomType)}`;

                            
                            window.location.href = paymentUrl;
                        }
                    </script>



                </div>
            </div>
        <?php } ?>
    </div>

    <footer>
        <p>&copy; 2025 Hotels Booking. All rights reserved.</p>
    </footer>
</body>

</html>

<?php $conn->close(); ?>
