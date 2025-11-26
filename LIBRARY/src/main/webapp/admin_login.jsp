<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Admin Login - Library LMS</title>
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Cabin:ital,wght@0,500;1,500&display=swap');
                body {
                     font-family: "Cabin", sans-serif;
                      font-optical-sizing: auto;
                      font-weight: 500;
                      font-style: normal;
                      font-variation-settings:
                        "wdth" 100;
            text-align: center;
            background-color: #f0f2f5;
            padding-top: 60px;
        }
        .login-box {
            width: 350px;
            margin: auto;
            background: white;
            padding: 25px 40px;
            border-radius: 10px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
        }
        h2 {
            color: #333;
            margin-bottom: 25px;
        }
        input[type="text"], input[type="password"] {
            width: 100%;
            padding: 12px;
            margin-bottom: 15px;
            border: 1px solid #ccc;
            border-radius: 5px;
            box-sizing: border-box; /* Padding include ho width mein */
        }
        input[type="submit"] {
            width: 100%;
            padding: 10px;
            background-color: #007bff;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 16px;
            transition: background-color 0.3s;
        }
        input[type="submit"]:hover {
            background-color: #0056b3;
        }
        .error-message {
            color: red;
            margin-bottom: 15px;
        }
    </style>
</head>
<body>

    <div class="login-box">
        <h2>Admin Login</h2>

        <%
            String error = request.getParameter("error");
            if (error != null) {
        %>
            <p class="error-message">Error: <%= error %></p>
        <%
            }
        %>

        <form action="AdminLoginServlet" method="post">

            <input type="text" name="username" placeholder="Username" required>

            <input type="password" name="password" placeholder="Password" required>

            <input type="submit" value="Log In">
        </form>

        <p style="margin-top: 20px;">
            <a href="index.jsp">← Go Back to Home</a>
        </p>
    </div>

</body>
</html>