<%@ page import="java.sql.*" %>
<%
String url = "jdbc:mysql://localhost:3306/library_db"; // Database name
String user = "root";                           // MySQL username
String password = "Nikhil@7130";                      // MySQL password
//  Load the MySQL Driver
Class.forName("com.mysql.cj.jdbc.Driver");

// Establish Connection
Connection conn = DriverManager.getConnection(url, user, password);

%>





