<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.library.dao.LibraryDAO, com.library.model.IssuedBook, java.sql.SQLException" %>
<%
    // Security check: Only Member can view their own books
    if (session.getAttribute("isMember") == null || !(Boolean)session.getAttribute("isMember")) {
        response.sendRedirect("member_login.jsp?error=Login required.");
        return;
    }

    // Logged-in student ID fetch karna
    String studentId = (String) session.getAttribute("loggedInStudentId");
    String studentName = (String) session.getAttribute("studentName");
    String display_name = (studentName != null) ? studentName : studentId;


    java.util.List<com.library.model.IssuedBook> issuedList = new java.util.ArrayList<>();
    LibraryDAO dao = new LibraryDAO();
    String error = null;

    try {
        issuedList = dao.getIssuedBooksByStudent(studentId);
    } catch (SQLException e) {
        error = "Database Error: Could not fetch issued books. Check server logs.";
        e.printStackTrace();
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>My Issued Books</title>
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
            max-width: 1200px;
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
            font-size: 0.9em;
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
        /* Status Highlighting */
        .status-overdue {
            color: #dc3545; /* Red */
            font-weight: bold;
            background-color: #f8d7da; /* Light red background for row */
        }
        .status-active { color: #28a745; } /* Green for Active */

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
        <h2>⏳ Books Issued to <%= display_name %></h2>

        <% if (error != null) { %>
            <p style="color: red;" class="error-message"><%= error %></p>
        <% } else if (issuedList.isEmpty()) { %>
            <p>You currently have no books issued.</p>
        <% } else { %>

            <table>
                <thead>
                    <tr>
                        <th>Txn ID</th>
                        <th>ISBN</th>
                        <th>Title</th>
                        <th>Author</th>
                        <th>Issue Date</th>
                        <th>Due Date</th>
                        <th>Status</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        for (com.library.model.IssuedBook book : issuedList) {
                            // Check if due date has passed
                            boolean isOverdue = book.getDueDate().before(new java.util.Date());
                            String rowClass = isOverdue ? "status-overdue" : "";
                            String statusText = isOverdue ? "OVERDUE" : "Active";
                            String statusTextColor = isOverdue ? "status-overdue" : "status-active";
                    %>
                        <tr class="<%= rowClass %>">
                            <td><%= book.getTransactionId() %></td>
                            <td><%= book.getIsbn() %></td>
                            <td><%= book.getTitle() %></td>
                            <td><%= book.getAuthor() %></td>
                            <td><%= book.getIssueDate() %></td>
                            <td><%= book.getDueDate() %></td>
                            <td class="<%= statusTextColor %>"><%= statusText %></td>
                        </tr>
                    <%
                        }
                    %>
                </tbody>
            </table>

            <%
            // Check again for the warning message display
            if (issuedList.stream().anyMatch(b -> b.getDueDate().before(new java.util.Date()))) { %>
                 <p class="error-message" style="background-color: #f8d7da; color: #dc3545; border-color: #f5c6cb;">
                 **WARNING:** Please return overdue books immediately.
                 </p>
            <% } %>

        <% } %>

        <p><a href="member_dashboard.jsp" class="back-link">← Go Back to Dashboard</a></p>
    </div>
</body>
</html>