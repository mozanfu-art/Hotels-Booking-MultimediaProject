<?php
session_start();
include('db-connect.php');

if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $email = $_POST['Email'];
    $password = $_POST['Pass'];

    $sql = "SELECT * FROM users WHERE Email = '$email' AND Password = '$password'";
    $result = $conn->query($sql);

    if ($result->num_rows > 0) {
        
        $row = $result->fetch_assoc();
        $_SESSION['UserID'] = $row['UserID'];
        $_SESSION['Role'] = $row['Role'];

        if ($row['Role'] == 'Admin') {
            header("Location: ../profile-dashboard-account/admin-dashboard.html");
        } else {
            header("Location: Home-(HB).html");
        }
    } else {

        echo "Invalid email or password";
    }
}
