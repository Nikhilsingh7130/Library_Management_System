<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.library.dao.LibraryDAO, com.library.model.Member, java.sql.SQLException" %>
<%
    // Security check: Only Admin can view members
    if (session.getAttribute("isAdmin") == null || !(Boolean)session.getAttribute("isAdmin")) {
        response.sendRedirect("admin_login.jsp?error=Admin access required.");
        return;
    }

    // Fully Qualified Names use kar rahe hain (Safest approach)
    java.util.List<com.library.model.Member> memberList = new java.util.ArrayList<>();
    LibraryDAO dao = new LibraryDAO();
    String error = null;

    try {
        memberList = dao.getAllMembers();
    } catch (SQLException e) {
        error = "Could not fetch members from database: " + e.getMessage();
        e.printStackTrace();
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>View All Members</title>
    <link rel="stylesheet" href="style.css">
    <style>
        /* Agar aap global style.css use nahi kar rahe, toh is block ko use karein */
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f5f7fa;
            color: #333;
            margin: 0;
            padding: 20px;
            text-align: center;
        }
        .container {
            width: 90%;
            max-width: 1000px;
            margin: auto;
            background: white;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
        }
        h2 {
            color: #004c99; /* Deep Corporate Blue */
            margin-bottom: 20px;
            font-weight: 600;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin: 20px 0;
            font-size: 0.95em;
        }
        table thead th {
            background-color: #004c99; /* Deep Blue Header */
            color: white;
            padding: 12px 15px;
            text-align: left;
            border: 1px solid #004c99;
            font-weight: bold;
        }
        table tbody tr:nth-child(even) {
            background-color: #f8f8f8; /* Zebra striping for readability */
        }
        table td {
            padding: 10px 15px;
            border: 1px solid #ddd;
            text-align: left;
        }
        /* Back Link Style */
        .back-link {
            display: block;
            margin-top: 20px;
            color: #007bff;
            text-decoration: none;
            font-weight: 500;
        }
        .back-link:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>👥 Registered Library Members</h2>

        <% if (error != null) { %>
            <p style="color: red;" class="error-message">Database Error: <%= error %></p>
        <% } else if (memberList.isEmpty()) { %>
            <p>No members registered yet.</p>
        <% } else { %>

            <table>
                <thead>
                    <tr>
                        <th>Student ID</th>
                        <th>Full Name</th>
                        <th>Email</th>
                        <th>Phone</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        for (com.library.model.Member member : memberList) {
                    %>
                        <tr>
                            <td><%= member.getStudentId() %></td>
                            <td><%= member.getName() %></td>
                            <td><%= member.getEmail() %></td>
                            <td><%= member.getPhone() != null ? member.getPhone() : "-" %></td>
                        </tr>
                    <%
                        }
                    %>
                </tbody>
            </table>
        <% } %>

        <p><a href="admin_dashboard.jsp" class="back-link">← Go Back to Dashboard</a></p>
    </div>

</body>
</html>