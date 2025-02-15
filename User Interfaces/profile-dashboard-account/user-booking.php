<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>your bookings</title>
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
    display: flex;
    justify-content: center;
    align-items: center;
}

.account-page {
    display: flex;
    justify-content: center;
    align-items: center;
    height: 100%;
}

.account-options {
    text-align: center;
    display: flex;
    flex-direction: column;
    gap: 20px;
}

.account-options .account-button {
    display: inline-block;
    background-color: #004d40;
    color: #ffffff;
    padding: 20px 40px;
    border: none;
    border-radius: 5px;
    cursor: pointer;
    margin: 10px;
    text-decoration: none;
    font-size: 1.5em;
}

.account-options .account-button:hover {
    background-color: #00392e;
}

.account-options .account-button i {
    margin-right: 10px;
}

.section-bookings {
    text-align: left;
    padding: 1em;
}

.section-bookings h3,
.section-bookings p {
    color: black;
    font-family: Cambria;
    font-size: 1.5em; 
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
</head>
<body>
    <div class="header">
        <a href="../profile-dashboard-account/manage-account.html"><img src="Back Arrow.png" width="35px"></a>
        <h1>Your Bookings</h1>
        <h3>
            <a href="../sign-home/Home-(HB).html" class="home-link">Home</a>
        </h3>
    </div>
    <div class="container account-page">
        <div class="account-options">
            <a href="../confirmation-reviews-feedbacks/confirmationPHP.php" class="account-button">
                <i class="fas fa-user-edit"></i> view your booking details
            </a>
        <div class="section-bookings">
            <h2>You don't have any reservations yet</h2>
            <p>please Explore in the home page </br>
                so you can find the perfect hotel in your destination</br>
            </p>
            <div class="account-options">
            <a href="../sign-home/Home-(HB).html" class="account-button">
                <i class="fas fa-user-edit"></i> Book Now
            </a>
        </div>
       </div>
      </div>
    </div>
    <footer>
        <p>&copy; 2025 Hotels Booking. All rights reserved.</p>
    </footer>
</body>
</html>

