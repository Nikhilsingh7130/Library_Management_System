<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Delete Book</title>
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
            color: #dc3545; /* Red for warning/deletion */
            margin-bottom: 25px;
            font-weight: 600;
        }
        /* Form Styling (style.css se aayegi, agar linked ho) */
        form {
            text-align: left;
        }
        form input[type="text"] {
            width: 100%;
            padding: 10px;
            margin-bottom: 15px;
            border: 1px solid #ddd;
            border-radius: 4px;
            box-sizing: border-box;
        }
        .warning-text {
            color: #dc3545;
            font-weight: bold;
            margin-bottom: 20px;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2> Permanently Delete Book</h2>

        <%
            String error = request.getParameter("error");
            if (error != null) {
        %>
            <p class="error-message">Error: <%= error %></p> <%
            }
        %>

        <p class="warning-text">WARNING: This action is permanent and cannot be undone.</p>

        <form action="DeleteBookServlet" method="post">

            <label for="isbn">Book ISBN to Delete:</label>
            <input type="text" id="isbn" name="isbn" placeholder="Enter ISBN (e.g., 978-XXXX)" required>

            <div style="text-align: center; margin-top: 20px;">
                <input type="submit" value="Delete Book" class="btn btn-danger">
            </div>
        </form>

        <p style="margin-top: 20px;">
            <a href="admin_dashboard.jsp" class="btn btn-primary" style="background-color: #6c757d; color: white;"> Go to Dashboard</a>
        </p>
    </div>
</body>
</html>