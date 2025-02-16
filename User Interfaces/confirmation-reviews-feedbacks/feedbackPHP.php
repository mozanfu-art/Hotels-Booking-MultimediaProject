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

if ($_SERVER['REQUEST_METHOD'] == 'POST' && $UserID) {
    $feedback_type = $_POST['AppRate'];
    $feedback_text = $_POST['feedback'];

    $stmt = $conn->prepare("INSERT INTO feedback (UserID, AppRate, feedback, FeedbackDate) VALUES (?, ?, ?, ?)");
    $stmt->bind_param("iss", $user_id, $feedback_type, $feedback_text);
    $stmt->execute();
    $stmt->close();

    header("Location: ./feedbackPHP.php");
    exit();
}
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>App Feedback</title>
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
    
.section-reviews h3,
.section-reviews p {
    color: black;
    font-family: Cambria;
    font-size: 1.2em;
}

.details {
    background-color: #004d40;
    color: #ffffff;
    font-size: 1.5em;
    text-align: left;
    position: relative;
    margin: 1em;
    padding: 5px;
    font-family: Cambria;
    border: 1px solid #fff;
}
.section-reviews {
    text-align: left;
    padding: 1em;
    font-size: 1.2em;
    width: 600px; 
    margin-left: 20px; 
}

.section-reviews label,
.section-reviews select,
.section-reviews textarea {
    display: block;
    width: 100%;
    margin: 10px 0;
    font-size: 1em;
    font-family: Cambria;
    text-align: left;
}

.section-reviews label {
    margin-top: 20px;
}

.section-reviews select {
    padding: 1px;
}

.section-reviews textarea {
    padding: 1px;
    height: 100px;
    margin-bottom: 10px;
}

.reviews-policy-button {
    padding: 0.6em;
    text-decoration: none;
    color: #004d40;
    border: 1px solid  #004d40 ;
    font-family: Cambria;
    font-size: 1em;
}
.reviews-policy-button:hover {
    background: #004d40;
    color: #fff;
}

.feedback-message {
    color: #004d40;
    font-family: Cambria;
    font-size: 1.1em;
    margin-top: 20px;
    font-style: italic; 
    font-weight: bold;
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
        <h1>Give App Feedback</h1>
        <h3>
            <a href="../sign-home/Home-(HB).html" class="home-link">Home</a>
        </h3>
    </div>
    <div class="section-reviews">
        <h3>How do you rate our app?</h3>
        <h3>Can you tell us a little more?</h3>
        <form method="POST" action="../sign-home/Home-(HB).html">
            <label for="AppRate">Select feedback type</label>
            <select name="AppRate" required>
                <option value="very-bad">Very Bad</option>
                <option value="bad">Bad</option>
                <option value="good">Good</option>
                <option value="very-good">Very Good</option>
                <option value="excellent">Excellent</option>
            </select>
            <textarea name="feedback_text" id="feedback_text" placeholder="Enter your feedback here"></textarea><br>
    <input type="submit" value="Send feedback" required class="reviews-policy-button">
</form>
<div id="thank-you-message" class="feedback-message" style="display: none;">
    "Thank you, we will use your feedback to improve our app."
</div>
</div>
<footer>
<p>&copy; 2025 Hotels Booking. All rights reserved.</p>
</footer>

<script>
function displayThankYouMessage() {
    document.getElementById('thank-you-message').style.display = 'block';
}
</script>
</body>
</html>
