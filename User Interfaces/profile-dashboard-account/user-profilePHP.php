<?php
session_start();


if (!isset($_SESSION['UserID'])) {
    header("Location: ../sign-home/login.php");
    exit();
}


include '../db-connect.php'; 

$userID = $_SESSION['UserID'];


$sql = "SELECT Email, FName, LName, BirthDate, Phone FROM users WHERE UserID = ?";
$stmt = $conn->prepare($sql);

if ($stmt) {
    $stmt->bind_param("i", $userID);
    $stmt->execute();
    $result = $stmt->get_result();

    if ($result->num_rows > 0) {
        $user = $result->fetch_assoc();
    } else {
        echo "Error: User not found.";
        exit();
    }

    $stmt->close();
} else {
    die("Error preparing statement: " . $conn->error);
}

$conn->close();
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User Profile</title>
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

/* Profile Form Styles */
.container {
    display: flex;
    justify-content: center;
    align-items: center;
    width: 100%;
    margin: 10px;
    
}

.profile-form {
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

.profile-form input {
    width: 90%;
    padding: 10px;
    margin: 10px;
    border: 1px solid #ccc;
    border-radius: 3px;
    color: #004d40;
    font-size: 1rem;
    background-color: #ffffff;
    transition: border-color 0.3s;
}

.profile-form input:focus {
    border-color: #004d40;
    outline: none;
}

.profile-form button {
    background-color: #004d40;
    color: #ffffff;
    width: 90%;
    padding: 10px;
    margin: 10px;
    border: none;
    border-radius: 3px;
    cursor: pointer;
    font-size: 1rem;
}

.profile-form button:hover {
    background-color: #00392e;
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
    <header class="header">
        <a href="manage-accountPHP.php"><img src="Back Arrow.png" width="35px"></a>
        <h1>Your details</h1>
        <h3>
            <a href="../sign-home/Home-(HB).html" class="home-link">Home</a>
        </h3>
    </header>
    
    <div class="container">
        <form class="profile-form" action="update-profile.php" method="post">
            <label for="email">Email:</label>
            <input type="email" id="email" name="email" maxlength="50" required value="<?php echo htmlspecialchars($user['Email']); ?>">

            <label for="current-password">Current Password:</label>
            <input type="password" id="current-password" name="current-password" maxlength="50" required>

            <label for="new-password">New Password:</label>
            <input type="password" id="new-password" name="new-password" maxlength="50">

            <label for="confirm-password">Confirm New Password:</label>
            <input type="password" id="confirm-password" name="confirm-password" maxlength="50">

            <label for="fname">First Name:</label>
            <input type="text" id="fname" name="fname" maxlength="50" value="<?php echo htmlspecialchars($user['FName']); ?>">

            <label for="lname">Last Name:</label>
            <input type="text" id="lname" name="lname" maxlength="50" value="<?php echo htmlspecialchars($user['LName']); ?>">

            <label for="birthdate">Birth Date:</label>
            <input type="date" id="birthdate" name="birthdate" value="<?php echo htmlspecialchars($user['BirthDate']); ?>">

            <label for="phone">Phone:</label>
            <input type="tel" id="phone" name="phone" maxlength="20" value="<?php echo htmlspecialchars($user['Phone']); ?>">

            <button type="submit">Save Details</button>
        </form>
    </div>
    
    <footer class="footer">
        <p>&copy; 2025 Hotels Booking. All rights reserved.</p>
    </footer>
</body>
</html>
