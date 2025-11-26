<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Register New Member</title>
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
            max-width: 550px;
            margin: 50px auto; /* Center the form */
            background: white;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }
        h2 {
            color: #28a745; /* Green for new registration/success */
            margin-bottom: 25px;
            font-weight: 600;
        }
        /* Form Alignment (Label aur Input ko horizontal rakhne ke liye) */
        form {
            text-align: left;
        }
        form input[type="text"],
        form input[type="password"],
        form input[type="email"] {
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
        .error-message {
            color: #dc3545;
            background-color: #f8d7da;
            border: 1px solid #f5c6cb;
            padding: 10px;
            border-radius: 4px;
            margin-bottom: 15px;
            text-align: left;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>Register New Student/Member</h2>

        <%
            String error = request.getParameter("error");
            if (error != null) {
        %>
            <p class="error-message">Error: <%= error %></p>
        <%
            }
        %>

        <form action="AddMemberServlet" method="post">

            <label for="studentId">Student ID (PK):</label>
            <input type="text" id="studentId" name="studentId" placeholder="e.g., S1006" required><br>

            <label for="name">Full Name:</label>
            <input type="text" id="name" name="name" required><br>

            <label for="password">Password:</label>
            <input type="password" id="password" name="password" required><br>

            <label for="email">Email :</label>
            <input type="email" id="email" name="email"><br>

            <label for="phone">Phone Number:</label>
            <input type="text" id="phone" name="phone"><br>

            <div style="clear: both; text-align: center; margin-top: 25px;">
                <input type="submit" value="Add Member" class="btn btn-success">
            </div>
        </form>

        <p style="margin-top: 20px;">
            <a href="admin_dashboard.jsp" class="btn btn-primary" style="background-color: #6c757d;"> Go to Dashboard</a>
        </p>
    </div>
</body>
</html>