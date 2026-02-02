<?php
include 'db-connect.php';

if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $email = $_POST["Email"];
    $pass = $_POST["pass"];
    $First_NM = $_POST["FN"];
    $Last_NM = $_POST["LN"];
    $date = $_POST["DOB"];
    $num = $_POST["Num"];

    $checkEmailStmt = $conn->prepare("SELECT Email FROM users WHERE Email = ?");
    $checkEmailStmt->bind_param("s", $email);
    $checkEmailStmt->execute();
    $checkEmailStmt->store_result();

    if ($checkEmailStmt->num_rows > 0) {
        echo createResponsePage("Your Account already exists", "Go to Login", "LOGIN", "Start-(HB).html");
    } else {

        $stmt = $conn->prepare("INSERT INTO users (Email, Password, FName, LName, BirthDate, Phone) VALUES (?, ?, ?, ?, ?, ?)");
        $stmt->bind_param("ssssss", $email, $pass, $First_NM, $Last_NM, $date, $num);

        if ($stmt->execute()) {
            echo createResponsePage("Account created successfully", "Login Now", "LOGIN", "Start-(HB).html");
        } else {
            echo createResponsePage("Something went wrong", "Try again", "SignUp", "SignUp-(HB).html");
        }

        $stmt->close();
    }

    $checkEmailStmt->close();
    $conn->close();
}

function createResponsePage($mess, $subMess, $btn, $PLink)
{
    return "
    <html>
    <style>
        body {
            background-color: #004d40;
            background-repeat: no-repeat;
            background-attachment: fixed;
            background-size: 100% 100%;
        }
        .container {
            background-color: white;
            width: 35%;
            height: auto;
            margin: auto;
            text-align: center;
            padding: 5px 0px;
            box-shadow: 0px 0px 0px rgb(0, 0, 0, 0.5);
            border-radius: 40px;
        }
        .btn {
            width: 40%;
            height: 40px;
            background: #004d40;
            color: #fffbf0;
            border: none;
        }
        .btn:hover {
            background: #fffbf0;
            color: #004d40;
            border: 1px groove #004d40;
        }

        #success-animation {
            width: 250px;
            height: 250px;
            margin: 0 auto;
        }

    </style>
    <body>
        <div class='container'>
        <div id='success-animation'></div>
            <font color='#004d40' size='7'>$mess</font><br>
            <font color='#004d40' size='7'>$subMess</font>
            <form action='$PLink'>
                <p><input type='submit' class='btn' value='$btn' /></p>
            </form>
        </div>
         </div>
        <script src='https://cdnjs.cloudflare.com/ajax/libs/bodymovin/5.12.2/lottie.min.js'></script>
        <script>
            lottie.loadAnimation({
                container: document.getElementById('success-animation'),
                path: './json/login1.json',
                renderer: 'svg',
                loop: false,
                autoplay: true
            });
        </script>
    </body>
    </html>
    ";
}
?>
