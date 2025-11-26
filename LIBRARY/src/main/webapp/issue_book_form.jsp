<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Issue Book</title>
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
            color: #004c99; /* Deep Corporate Blue */
            margin-bottom: 25px;
            font-weight: 600;
        }
        /* Form Alignment (Label aur Input ko horizontal rakhne ke liye) */
        form {
            text-align: left;
        }
        form input[type="text"],
        form input[type="number"] {
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
            /* Clearfix for proper layout */
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
        <h2> Issue Book to Member (Using ISBN)</h2>

        <%
            String error = request.getParameter("error");
            if (error != null) {
        %>
            <p class="error-message">Error: <%= error %></p>
        <%
            }
        %>

        <form action="IssueBookServlet" method="post">

            <label for="isbn">Book ISBN:</label>
            <input type="text" id="isbn" name="isbn" placeholder="e.g., 978-0134685991" required><br>

            <label for="studentId">Student ID:</label>
            <input type="text" id="studentId" name="studentId" placeholder="e.g., S1001" required><br>

            <label for="issueDays">Days to Issue:</label>
            <input type="number" id="issueDays" name="issueDays" value="7" required min="1"><br>

            <div style="clear: both; text-align: center; margin-top: 25px;">
                <input type="submit" value="Issue Book" class="btn btn-primary">
            </div>
        </form>

        <p style="margin-top: 20px;">
            <a href="admin_dashboard.jsp" class="btn btn-primary" style="background-color: #6c757d;"> Go to Dashboard</a>
        </p>
    </div>
</body>
</html>