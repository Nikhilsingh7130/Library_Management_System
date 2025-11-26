<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    // Security Check: Verify ki session mein 'isMember' flag set hai
    if (session.getAttribute("isMember") == null || !(Boolean)session.getAttribute("isMember")) {
        response.sendRedirect("member_login.jsp?error=Access Denied. Please Login First.");
        return;
    }

    // Session se member ki details nikalna
    String studentId = (String) session.getAttribute("loggedInStudentId");
    String studentName = (String) session.getAttribute("studentName");
    String display_name = (studentName != null) ? studentName : studentId;
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Member Dashboard - Library LMS</title>
    <link rel="stylesheet" href="style.css">
    <style>
        /* Styles updated for Corporate/Flat Theme */
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f5f7fa; /* Very light background */
            color: #333;
            margin: 0;
            padding: 0;
            text-align: center;
        }
        .header {
            background-color: #004c99; /* Deep Corporate Blue */
            color: white;
            padding: 20px 0;
            margin-bottom: 30px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }
        .header h1 {
            margin: 0;
            font-size: 2.5em;
        }
        .dashboard-container {
            width: 90%;
            max-width: 900px;
            margin: auto;
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr)); /* Grid layout */
            gap: 25px;
        }
        .action-item {
            background: white;
            padding: 25px;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            transition: transform 0.2s;
            text-align: center;
        }
        .action-item:hover {
            transform: translateY(-5px);
            box-shadow: 0 6px 15px rgba(0, 0, 0, 0.2);
        }
        .action-item h3 {
            color: #007bff; /* Standard Blue heading */
            margin-top: 0;
            margin-bottom: 15px;
        }
        .action-item a {
            display: block; /* Make links full width */
            width: 90%;
            margin: 15px auto 5px;
            padding: 12px 5px;
            text-decoration: none;
            color: white;
            background-color: #28a745; /* Green Button (Success/Go) */
            border-radius: 4px;
            font-weight: bold;
            transition: background-color 0.3s;
        }
        .action-item a.status-link {
            background-color: #ffc107; /* Yellow/Warning for Status check */
            color: #333;
        }
        .action-item a:hover {
            background-color: #1e7e34;
        }
        .action-item a.status-link:hover {
             background-color: #e0a800;
        }
        .logout-container {
            width: 90%;
            max-width: 900px;
            margin: 30px auto;
        }
        .logout-link {
            display: inline-block;
            font-size: 1.1em;
            color: white;
            background-color: #dc3545; /* Red for Logout */
            padding: 10px 20px;
            border-radius: 4px;
            text-decoration: none;
        }
        .logout-link:hover {
            background-color: #c82333;
        }
    </style>
</head>
<body>

    <div class="header">
        <h1>Member Portal</h1>
       <p>Welcome, **<%= display_name %>**!</p>
    </div>

    <div class="dashboard-container">

        <div class="action-item">
            <h3>📖 Books Catalog</h3>
            <a href="view_books.jsp">View All Books</a>
        </div>

        <div class="action-item">
            <h3>⏳ My Issued Books</h3>
            <a href="view_issued_books.jsp" class="status-link">View My Status</a>
        </div>

        <div class="action-item">
            <h3>⚙️ Account Settings</h3>
            <a href="change_password.jsp" style="background-color: #6c757d;">Change Password</a>
        </div>

    </div>

    <div class="logout-container">
        <a href="LogoutServlet" class="logout-link">Log Out</a>
    </div>

</body>
</html>