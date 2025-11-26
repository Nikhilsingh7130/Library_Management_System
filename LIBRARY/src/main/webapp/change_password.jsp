<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Change Password</title>
    <link rel="stylesheet" href="style.css">
    <style>
        /* Agar aap global style.css use nahi kar rahe, toh is block ko use karein */
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f5f7fa;
            text-align: center;
        }
        .container {
            width: 90%;
            max-width: 450px;
            margin: 50px auto;
            background: white;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }
        h2 {
            color: #004c99; /* Deep Corporate Blue */
            margin-bottom: 25px;
            font-weight: 600;
        }
        /* Message Styling */
        .message-box {
            padding: 10px;
            border-radius: 4px;
            margin-bottom: 15px;
            text-align: left;
            font-weight: bold;
        }
        .error-message {
            color: #dc3545;
            background-color: #f8d7da;
            border: 1px solid #f5c6cb;
        }
        .success-message {
            color: #28a745;
            background-color: #d4edda;
            border: 1px solid #c3e6cb;
        }
        /* Form Alignment */
        form {
            text-align: left;
        }
        form input[type="password"] {
            /* Input fields ko right align karein */
            float: right;
            width: 60%;
            padding: 10px;
            margin-bottom: 15px;
            border: 1px solid #ddd;
            border-radius: 4px;
            box-sizing: border-box;
        }
        label {
            display: block;
            margin-bottom: 5px;
            width: 35%;
            float: left;
            padding-top: 10px;
            font-weight: 500;
        }
        form br {
            clear: both;
            margin-bottom: 10px;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2> Change Your Password</h2>

        <%
            String error = request.getParameter("error");
            String msg = request.getParameter("msg");
        %>

        <% if (error != null) { %>
            <p class="message-box error-message">Error: <%= error %></p>
        <% } else if (msg != null) { %>
            <p class="message-box success-message">Success: <%= msg %></p>
        <% } %>

        <form action="ChangePasswordServlet" method="post">

            <label for="oldPassword">Old Password:</label>
            <input type="password" id="oldPassword" name="oldPassword" required><br>

            <label for="newPassword">New Password:</label>
            <input type="password" id="newPassword" name="newPassword" required><br>

            <label for="confirmPassword">Confirm New Password:</label>
            <input type="password" id="confirmPassword" name="confirmPassword" required><br>

            <div style="clear: both; text-align: center; margin-top: 25px;">
                <input type="submit" value="Change Password" class="btn btn-primary">
            </div>
        </form>

        <p style="margin-top: 20px;">
            <a href="member_dashboard.jsp" class="btn btn-primary" style="background-color: #6c757d;"> Go Back to Dashboard</a>
        </p>
    </div>
</body>
</html>