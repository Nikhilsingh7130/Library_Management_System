<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>System Error</title>
</head>
<body>
    <h2>❌ Oops! An Error Occurred</h2>
    <%
        // Servlet se bheja gaya message (jise 'msg' parameter mein daala gaya hai)
        String errorMsg = request.getParameter("msg");
        if (errorMsg != null) {
    %>
        <p style="color: red;">Error Details: <strong><%= errorMsg %></strong></p>
    <%
        } else {
    %>
         <p>No specific error message was provided.</p>
    <%
        }
    %>
    <p><a href="index.jsp">Go back to Home</a></p>
</body>
</html>