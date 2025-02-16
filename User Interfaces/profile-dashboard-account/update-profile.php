<?php
session_start();


if (!isset($_SESSION['UserID'])) {
    header("Location: ../sign-home/Start-(HB).html");
    exit();
}


include 'db-connect.php'; 

$userID = $_SESSION['UserID'];

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $email = $_POST['email'];
    $fname = $_POST['fname'];
    $lname = $_POST['lname'];
    $birthdate = $_POST['birthdate'];
    $phone = $_POST['phone'];
    $currentPassword = $_POST['current-password'];
    $newPassword = $_POST['new-password'];
    $confirmPassword = $_POST['confirm-password'];

    
    $stmt = $conn->prepare("SELECT Password FROM users WHERE UserID = ?");
    $stmt->bind_param("i", $userID);
    $stmt->execute();
    $stmt->bind_result($storedPassword);
    $stmt->fetch();
    $stmt->close();

    if ($currentPassword != $storedPassword)  {
        die("Incorrect current password.");
    }

    
    if (!empty($newPassword)) {
        if ($newPassword === $confirmPassword) {
            
            $sql = "UPDATE users SET Email = ?, FName = ?, LName = ?, BirthDate = ?, Phone = ?, Password = ? WHERE UserID = ?";
            $stmt = $conn->prepare($sql);
            $stmt->bind_param("ssssssi", $email, $fname, $lname, $birthdate, $phone, $confirmPassword, $userID);
        } else {
            die("New password and confirm password do not match.");
        }
    } else {
        $sql = "UPDATE users SET Email = ?, FName = ?, LName = ?, BirthDate = ?, Phone = ? WHERE UserID = ?";
        $stmt = $conn->prepare($sql);
        $stmt->bind_param("sssssi", $email, $fname, $lname, $birthdate, $phone, $userID);
    }
    
    if ($stmt->execute()) {
        header("Location: user-profilePHP.php?success=Profile updated successfully");
        exit();
    } else {
        echo "Error updating profile: " . $stmt->error;
    }
    
    $stmt->close();
}

$conn->close();
?>
