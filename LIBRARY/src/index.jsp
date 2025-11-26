<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Library Management System Home</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            text-align: center;
            padding-top: 50px;
            background-color: #f4f4f4;
        }
        .container {
            width: 80%;
            margin: auto;
            background: white;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        h1 {
            color: #333;
        }
        .link-button {
            display: inline-block;
            margin: 15px;
            padding: 10px 20px;
            text-decoration: none;
            color: white;
            background-color: #007bff;
            border-radius: 5px;
            font-size: 18px;
            transition: background-color 0.3s;
        }
        .link-button:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>

    <div class="container">
        <h1>📚 Library Management System</h1>
        <p>Welcome! Please select your user type to proceed:</p>

        <hr>

        <a href="admin_login.jsp" class="link-button">
            Admin/Staff Login
        </a>

        <a href="member_login.jsp" class="link-button" style="background-color: #28a745;">
            Student/Member Login
        </a>

        <hr>

        <p style="font-size: 12px; color: #666;">Note: Use Admin login for managing books and members.</p>
    </div>

</body>
</html>