
<head>
    <meta charset="UTF-8">
    <title>Library Management System Home</title>
    <link rel="stylesheet" href="style.css">
    <style>
    @import url('https://fonts.googleapis.com/css2?family=Cabin:ital,wght@0,500;1,500&display=swap');
            body {
                            font-family: "Cabin", sans-serif;
                             font-optical-sizing: auto;
                             font-weight: 500;
                             font-style: normal;
                             font-variation-settings:
                               "wdth" 100;
                               }
        /* Existing internal styles ko yahan se remove kar dein */
        /* Ya fir sirf .container ke liye basic style rehne dein */
        .container {
            width: 80%;
            margin: auto;
            background: white;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
    </style>
</head>
<body>

    <div class="container card login-box"> <h1>Library Management System</h1>
        <p>Welcome! Please select your user type to proceed:</p>
        <hr>

        <a href="admin_login.jsp" class="btn btn-primary">
            Admin/Staff Login
        </a>
        <a href="member_login.jsp" class="btn btn-success">
            Student/Member Login
        </a>
        <hr>
        <p style="font-size: 12px; color: #666;">Note: Use Admin login for managing books and members.</p>
    </div>
</body>