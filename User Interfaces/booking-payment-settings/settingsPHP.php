<?php
session_start();

if (!isset($_SESSION['UserID'])) {
    header("Location: ../sign-home/login.php");
    exit();
}

include '../db-connect.php'; 
$UserID = $_SESSION['UserID'];

$query = "SELECT theme, currency, lang, email_notifications, sms_notifications FROM users WHERE UserID = ?";
$stmt = $conn->prepare($query);
$stmt->bind_param("i", $UserID);
$stmt->execute();
$result = $stmt->get_result();
$user = $result->fetch_assoc();

$theme = $user['theme'] ?? 'light';
$currency = $user['currency'] ?? 'usd';
$lang = $user['lang'] ?? 'en';
$email_notifications = $user['email_notifications'] ?? 0;
$sms_notifications = $user['sms_notifications'] ?? 0;

if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $theme = $_POST['theme'] ?? 'light';
    $currency = $_POST['currency'] ?? 'usd';
    $lang = $_POST['lang'] ?? 'en';
    $email_notifications = isset($_POST['email_notifications']) ? 1 : 0;
    $sms_notifications = isset($_POST['sms_notifications']) ? 1 : 0;

    $update_query = "UPDATE users SET theme=?, currency=?, lang=?, email_notifications=?, sms_notifications=? WHERE UserID=?";
    $update_stmt = $conn->prepare($update_query);
    $update_stmt->bind_param("sssiii", $theme, $currency, $lang, $email_notifications, $sms_notifications, $UserID);
    $update_stmt->execute();
    header("Location: ./settingsPHP.php?success=1");
    exit();
}
?> 
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Settings</title>
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
                margin: 10px;
                justify-content: center;
                align-items: center;
                flex-direction: column; 
            }
            
            .settings-section {
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
            
            .radio-container {
                display: flex;
                justify-content: space-around;
                align-items: center;
                margin: 20px;
            }
            
            .s-container {
                display: flex;
                justify-content: space-around;
                align-items: center;
                margin: 20px;
            }
            
            .checkbox-label {
                display: flex;
                justify-content: space-around;
                align-items: center;
                margin: 20px;
            }
            
            .settings-button {
                display: inline-block;
                background-color: #004d40;
                color: #ffffff;
                padding: 10px 20px;
                margin: 20px; 
                border: none;
                border-radius: 5px;
                cursor: pointer;
                text-decoration: none;
                text-align: center;
                font-size: 1.2em;
                transition: background-color #ffffff;
            }
            
            .settings-button:hover {
                background-color: #00392e;
            }
            
            .settings-button i {
                margin-right: 10px;
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
</head>
<body>
    <div class="header">
        <a href="../sign-home/Home-(HB).html"><img src="Back Arrow.png" width="35px"></a>
        <h1>Settings</h1>
        <h3>
            <a href="../sign-home/Home-(HB).html" class="home-link">Home</a>
        </h3>
    </div>
    <div class="container">
        <div class="settings-section">
            <?php if (isset($_GET['success'])): ?>
                <p style="color:green;">Settings updated successfully!</p>
            <?php endif; ?>

            <form method="post">
                <div class="radio-container">
                    <label>Theme:</label>
                    <label>
                        <input type="radio" name="theme" value="light" <?= ($theme == 'light') ? 'checked' : ''; ?>> Light
                    </label>
                    <label>
                        <input type="radio" name="theme" value="dark" <?= ($theme == 'dark') ? 'checked' : ''; ?>> Dark
                    </label>
                </div>
                <div class="s-container">
                <label for="currency">Currency:</label>
                <select name="currency">
                    <option value="usd" <?= ($currency == 'usd') ? 'selected' : ''; ?>>USD</option>
                    <option value="eur" <?= ($currency == 'eur') ? 'selected' : ''; ?>>EUR</option>
                    <option value="sar" <?= ($currency == 'sar') ? 'selected' : ''; ?>>SAR</option>
                </select>
                </div>
                <div class="s-container">

                <label for="lang">Language:</label>
                <select name="lang">
                    <option value="ar" <?= ($lang == 'ar') ? 'selected' : ''; ?>>AR</option>
                    <option value="en" <?= ($lang == 'en') ? 'selected' : ''; ?>>EN</option>
                    <option value="fr" <?= ($lang == 'fr') ? 'selected' : ''; ?>>FR</option>
                </select>
                </div>
                
                
                
                
                <div class="checkbox-label">
                    <label for="email_notifications">Enable Email Notifications</label>
                    <input type="checkbox" name="email_notifications" <?= ($email_notifications) ? 'checked' : ''; ?>>
                </div>

                <div class="checkbox-label">
                    <label for="sms_notifications">Enable SMS Notifications</label>
                    <input type="checkbox" name="sms_notifications" <?= ($sms_notifications) ? 'checked' : ''; ?>>
                </div>
            <button type="submit" class="settings-button">
                    Save Settings
                </button>
                </form>
            <a href="../profile-dashboard-account/manage-accountPHP.php" class="settings-button">
                <i class="fas fa-user-edit"></i> Manage Account
            </a>
            <a href="#" class="settings-button">
                <i class="fas fa-calendar-check"></i> Manage privacy settings
            </a>
            <a href="#" class="settings-button">
                <i class="fas fa-star"></i> About Us
            </a>
        </div>
    </div>
    <footer>
        <p>&copy; 2025 Hotels Booking. All rights reserved.</p>
    </footer>
</body>
</html>
