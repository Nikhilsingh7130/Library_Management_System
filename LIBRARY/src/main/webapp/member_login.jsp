<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Member Login - Library LMS</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            text-align: center;
            background-color: #e6f7ff; /* Light blue background */
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
            color: #28a745; /* Green header */
            margin-bottom: 25px;
        }
        input[type="text"], input[type="password"] {
            width: 100%;
            padding: 12px;
            margin-bottom: 15px;
            border: 1px solid #ccc;
            border-radius: 5px;
            box-sizing: border-box;
        }
        input[type="submit"] {
            width: 100%;
            padding: 10px;
            background-color: #28a745; /* Green button */
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 16px;
            transition: background-color 0.3s;
        }
        input[type="submit"]:hover {
            background-color: #1e7e34;
        }
        .error-message {
            color: red;
            margin-bottom: 15px;
        }
    </style>
</head>
<body>

    <div class="login-box">
        <h2>Member Login</h2>
        <p>Please enter your credentials:</p>

        <%
            // Agar Servlet se koi error message aaya ho, toh display karein
            String error = request.getParameter("error");
            if (error != null) {
        %>
            <p class="error-message">Error: <%= error %></p>
        <%
            }
        %>

        <form action="MemberLoginServlet" method="post">

            <input type="text" name="studentId" placeholder="Student/Roll Number" required>

            <input type="password" name="password" placeholder="Password" required>

            <input type="submit" value="Log In">
        </form>

        <p style="margin-top: 20px;">
            <a href="index.jsp"> Go Back to Home</a>
        </p>
    </div>

</body>
</html>