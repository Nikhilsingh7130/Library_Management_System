<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Add New Book</title>
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
        /* Form Label Styling */
        form {
            text-align: left;
        }
        form input[type="text"],
        form input[type="number"] {
            width: calc(100% - 10px); /* Adjust width */
            padding: 10px;
            margin-bottom: 15px;
            border: 1px solid #ddd;
            border-radius: 4px;
            box-sizing: border-box;
            float: right; /* Input fields ko right align karein */
            width: 60%;
        }
        /* Clearfix for form alignment */
        form br {
            clear: both;
            margin-bottom: 10px;
        }
        label {
            display: block;
            margin-bottom: 5px;
            width: 35%;
            float: left;
            padding-top: 10px;
            font-weight: 500;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2> Add New Book to Library</h2>

        <%
            String error = request.getParameter("error");
            if (error != null) {
        %>
            <p class="error-message">Error: <%= error %></p>
        <%
            }
        %>

        <form action="AddBookServlet" method="post">

            <label for="isbn">ISBN:</label>
            <input type="text" id="isbn" name="isbn" required><br>

            <label for="title">Title:</label>
            <input type="text" id="title" name="title" required><br>

            <label for="author">Author:</label>
            <input type="text" id="author" name="author" required><br>

            <label for="quantity">Quantity:</label>
            <input type="number" id="quantity" name="quantity" required min="1"><br>

            <div style="clear: both; text-align: center; margin-top: 20px;">
                 <input type="submit" value="Add Book" class="btn btn-success">
            </div>
        </form>

        <p style="margin-top: 20px;">
            <a href="admin_dashboard.jsp" class="btn btn-primary" style="background-color: #6c757d;">Go to Dashboard</a>
        </p>
    </div>
</body>
</html>