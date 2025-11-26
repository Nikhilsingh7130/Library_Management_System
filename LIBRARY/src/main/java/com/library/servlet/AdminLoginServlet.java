package com.library.servlet; // Aapka package name use karein
// Ensure ki aapne com.library.dao.LibraryDAO class ko bhi sahi package mein rakha hai

// com.library.dao.LibraryDAO ka package import karein
import com.library.dao.LibraryDAO;

import java.io.IOException;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

// Annotation jo URL /com.library.servlet.AdminLoginServlet ko is class se map karta hai
@WebServlet("/AdminLoginServlet")
public class AdminLoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // 1. Input Data Receive Karna
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        // DAO object banayein
        LibraryDAO dao = new LibraryDAO();

        try {
            // 2. Validation Check
            if (dao.validateAdmin(username, password)) {

                // 3. SUCCESS: Session Set Karna
                HttpSession session = request.getSession();
                session.setAttribute("isAdmin", true); // Flag for authorization
                session.setAttribute("adminUser", username); // Display name for dashboard

                // Admin Dashboard par bhej dein
                response.sendRedirect("admin_dashboard.jsp");

            } else {
                // 4. FAILURE: Error Message ke saath wapas bhej dein
                String errorMsg = "Invalid Username or Password. Please try again.";
                // URL Rewriting karke error message wapas bhejte hain
                response.sendRedirect("admin_login.jsp?error=" + java.net.URLEncoder.encode(errorMsg, "UTF-8"));
            }
        } catch (SQLException e) {
            // 5. Database Error Handling
            e.printStackTrace();
            String errorMsg = "Database error during login. Check Server Logs.";
            response.sendRedirect("error.jsp?msg=" + java.net.URLEncoder.encode(errorMsg, "UTF-8"));
        }
    }
}