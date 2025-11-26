<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    // Security Check: Verify ki session mein 'isAdmin' flag set hai
    if (session.getAttribute("isAdmin") == null || !(Boolean)session.getAttribute("isAdmin")) {
        // Agar login nahi hua hai, toh wapas login page par bhej dein
        response.sendRedirect("admin_login.jsp?error=Access Denied. Please Login First.");
        return; // Further rendering se rokna
    }
    // Session se Admin ka username nikalna
    String adminName = (String) session.getAttribute("adminUser");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Admin Dashboard - Library LMS</title>
    <style>
    @import url('https://fonts.googleapis.com/css2?family=Cabin:ital,wght@0,500;1,500&display=swap');
        body {
             font-family: "Cabin", sans-serif;
              font-optical-sizing: auto;
              font-weight: 500;
              font-style: normal;
              font-variation-settings:
                "wdth" 100;
                background-color: #fce5cd;

            color: #333;
            margin: 0;
            padding: 0;
            text-align: center;
        }
        .header {
            background-color: #f7d7b5;
            color: #351c75;
            padding: 20px 0;
            margin-bottom: 30px;
        }
        .header h1 {
            margin: 0;
            font-size: 2.5em;
        }
        .dashboard-container {
            width: 90%;
            max-width: 1000px;
            margin: auto;
        }
        .action-grid {

            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
            gap: 20px;
        }
        .action-item {
            background: #FFFFFF;
            padding: 25px;
            border-radius: 10px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
            transition: transform 0.2s;
        }
        .action-item:hover {
            transform: translateY(-5px);
            box-shadow: 0 6px 15px rgba(0, 0, 0, 0.2);
        }
        .action-item h3 {
            color: #351c75;
            margin-top: 0;
        }
        .action-item a {
            display: inline-block;
            margin-top: 15px;
            padding: 10px 20px;
            text-decoration: none;
            color: white;
            background-color: #28a745;
            border-radius: 5px;
            font-weight: bold;
        }
        .action-item .secondary-link {
            background-color: #ffc107;
            color: #333;
            margin-left: 10px;
        }
        .action-item a:hover {
            background-color: #218838;
        }
        .action-item .secondary-link:hover {
             background-color: #e0a800;
        }
        .logout-link {
            display: block;
            margin-top: 30px;
            font-size: 1.1em;
            color: #dc3545;
        }
        .logout-link:hover {
            text-decoration: underline;
        }

    </style>
</head>
<body>

    <div class="header">
        <h1>Admin Control Panel</h1>
        <p>Welcome, **<%= adminName != null ? adminName : "Admin" %>**!</p>
    </div>

    <div class="dashboard-container">
        <h2>Library Management Tasks</h2>

        <div class="action-grid">

            <div class="action-item">
                <h3>Manage Books</h3>
                <p>Add new titles, update quantities, and view stock.</p>
                <a href="add_book.jsp">Add New Book</a>
                <a href="view_books.jsp" class="secondary-link">View/Update Books</a>
                <a href="delete_book_form.jsp" style="background-color: #dc3545;">Delete Book</a>
            </div>

            <div class="action-item">
                <h3>Issue & Return</h3>
                <p>Record transactions when books are issued or returned.</p>
                <a href="issue_book_form.jsp">Issue Book</a>
                <a href="return_book_form.jsp" class="secondary-link" style="background-color: #00bcd4; color: white;">Return Book</a>
            </div>

            <div class="action-item">
                <h3>Manage Members</h3>
                <p>Register new students and view member details.</p>
                <a href="add_member.jsp">Add New Member</a>
                <a href="view_members.jsp" class="secondary-link" style="background-color: #17a2b8; color: white;">View All Members</a>
            </div>

            <div class="action-item">
                <h3>Reports & History</h3>
                <p>View overdue books and full transaction history.</p>
                <a href="view_history.jsp" style="background-color: #6c757d;">View Transactions</a>
            </div>
        </div>

        <a href="LogoutServlet" class="logout-link">Log Out of Admin Panel</a>

    </div>

</body>
</html>