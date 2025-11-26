<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.library.dao.LibraryDAO" %>
<%@ page import="com.library.model.Book" %>
<%@ page import="java.sql.SQLException" %>
<%
    // Security check: Agar koi login nahi hai, toh wapas bhej dein
    if (session.getAttribute("isAdmin") == null && session.getAttribute("isMember") == null) {
        response.sendRedirect("index.jsp?error=Login required to view books.");
        return;
    }

    // Fully Qualified Names use kar rahe hain taaki 'import java.util.List/ArrayList' ka issue na aaye
    java.util.List<com.library.model.Book> bookList = new java.util.ArrayList<>();
    LibraryDAO dao = new LibraryDAO();
    String error = null;

    try {
        bookList = dao.getAllBooks();
    } catch (SQLException e) {
        error = "Could not fetch books from database: " + e.getMessage();
        e.printStackTrace();
    }

    // User type check (navigation ke liye)
    String dashboard = (session.getAttribute("isAdmin") != null) ? "admin_dashboard.jsp" : "member_dashboard.jsp";
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Available Books</title>
    <style>
       @import url('https://fonts.googleapis.com/css2?family=Cabin:ital,wght@0,500;1,500&display=swap');
        body {
            font-family: "Cabin", sans-serif;
              font-optical-sizing: auto;
              font-weight: 500;
              font-style: normal;
              font-variation-settings:
                "wdth" 100;
            background-color: #f7d7b5;
            color: #351c75;
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

            color: #351c75; /* Deep Corporate Blue */
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
            background-color: #351c75; /* Deep Blue Header */
            color: white;
            padding: 12px 15px;
            text-align: left;
            border: 1px solid #004c99;
            font-weight: bold;
        }
        table tbody tr:nth-child(even) {
            /*background-color: #f8f8f8; /* Zebra striping for readability */*/
        }
        table td {
            padding: 10px 15px;
            border: 2px solid #351c75;
            text-align: left;
        }
        /* Status Colors */
        .status-available { color: #28a745; font-weight: bold; } /* Green */
        .status-unavailable { color: #dc3545; font-weight: bold; } /* Red */

        /* Back Link Style */
        .back-link {
            display: block;
            margin-top: 20px;
            color: #00bff;
            text-decoration: none;
            font-weight: 800;
        }
        .back-link:hover {
            text-decoration: underline;
        }

    </style>
</head>
<body>
    <h2> Current Book Stock</h2>

    <% if (error != null) { %>
        <p style="color: red;">Database Error: <%= error %></p>
    <% } else if (bookList.isEmpty()) { %>
        <p>No books found in the library.</p>
    <% } else { %>

        <table border="1" style="width: 80%; margin: 20px auto; border-collapse: collapse;">
            <thead>
                <tr>
                    <th>Book ID</th>
                    <th>ISBN</th>
                    <th>Title</th>
                    <th>Author</th>
                    <th>Total Stock</th>
                    <th>Issued</th>
                    <th>Available</th>
                </tr>
            </thead>
            <tbody>
                <%
                    for (com.library.model.Book book : bookList) {
                        int available = book.getQuantity() - book.getIssuedCopies();
                %>
                    <tr>
                        <td><%= book.getBookId() %></td>
                        <td><%= book.getIsbn() %></td>
                        <td><%= book.getTitle() %></td>
                        <td><%= book.getAuthor() %></td>
                        <td><%= book.getQuantity() %></td>
                        <td><%= book.getIssuedCopies() %></td>
                        <td style="color: <%= available > 0 ? "green" : "red" %>;">
                            <%= available %>
                        </td>
                    </tr>
                <%
                    }
                %>
            </tbody>
        </table>
    <% } %>

    <p><a href="<%= dashboard %>">← Go Back to Dashboard</a></p>

</body>
</html>
