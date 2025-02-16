<?php
include 'db-connect.php';

if (!isset($_SESSION['UserID'])) {
    header("Location: ../sign-home/Start-(HB).html");
    exit();
}


$hotels = [];

$sql = "SELECT * FROM hotels";
$result = $conn->query($sql);

if ($result->num_rows > 0) {
    while ($row = $result->fetch_assoc()) {
        $hotels[] = $row;
    }
}
?>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Search Results</title>
<style>
body {
    font-family: Arial, sans-serif;
    background-color: #fffbf0;
    margin: 0;
    padding: 0;
    color: #004d40;
}
.container {
    max-width: 1200px;
    margin: 0 auto;
    padding: 20px;
}
.header {
    background-color: #004d40;
    color: #ffffff;
    padding: 10px 20px;
    position: relative;
    display: flex;
    align-items: center;
    width: 100%;
}
.header .home-link {
    position: absolute;
    right: 20px;
    top: 50%;
    transform: translateY(-50%);
    color: #ffffff;
    font-weight: bold;
}
.hotel-list {
    display: flex;
    flex-wrap: wrap;
    justify-content: center;
    gap: 20px;
    margin-top: 20px;
}
.hotel-item {
    background-color: #ffffff;
    border-radius: 5px;
    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
    padding: 20px;
    width: calc(33.33% - 40px);
    box-sizing: border-box;
    display: flex;
    flex-direction: column;
}
.hotel-item img {
    width: 100%;
    height: 580px;
    object-fit: cover;
    border-radius: 5px 5px 0 0;
    margin-bottom: 10px;
}
.footer {
    background-color: #004d40;
    color: #ffffff;
    padding: 20px;
    text-align: center;
    margin-top: 20px;
    border-radius: 5px;
    box-shadow: 0 -2px 4px rgba(0, 0, 0, 0.1);
    display: flex;
    justify-content: center;
    align-items: center;
}
.hotel-item img:hover {
transform: scale(1.05); 
box-shadow: 0 4px 8px rgba(0, 0, 0, 0.15); 
transition: transform 0.3s ease, box-shadow 0.3s ease;
}

.hotel-item a{
 text-decoration: none; 
 color: inherit;
}
.hotel-item a:hover{
    color: #00392e; 
text-decoration: underline;
}
h1{
   margin-left: 40%;
}
</style>
</head>
<body>
    <div class="header">
        <a href="../sign-home/Home-(HB).html"><img src="Back Arrow.png" width="35px"></a>
        <h1>Search Results</h1>
    </div>
    <div class="container">
        <div class="hotel-list">
            <?php if (!empty($hotels)) : ?>
                <?php foreach ($hotels as $hotel) : ?>
                    <div class="hotel-item">
                        <img src="<?php echo htmlspecialchars($hotel['ImageURLs']); ?>" alt="<?php echo htmlspecialchars($hotel['Hotel_name']); ?>">
                        <h2><a href="../booking-payment-settings/BookingPHP.php" id=<?php echo $hotel['HotelID']; ?>> <?php echo htmlspecialchars($hotel['Hotel_name']); ?> </a></h2>
                        <p>Location: <?php echo htmlspecialchars($hotel['City']); ?></p>
                        <p>Star Rating: <?php echo htmlspecialchars($hotel['Star_rate']); ?> stars</p>
                        <p>Description: <?php echo htmlspecialchars($hotel['Description']); ?></p>
                        <p>Amenities: <?php echo htmlspecialchars($hotel['Amenities']); ?></p>
                    </div>
                <?php endforeach; ?>
            <?php else : ?>
                <p>No hotels found.</p>
            <?php endif; ?>
        </div>
    </div>
    <footer class="footer">
        <p>&copy; 2025 Hotels Booking. All rights reserved.</p>
    </footer>
</body>
</html>
