package com.library.servlet;

import com.library.dao.LibraryDAO;
import java.io.IOException;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/ChangePasswordServlet")
public class ChangePasswordServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Ensure user is logged in
        String studentId = (String) request.getSession().getAttribute("loggedInStudentId");
        if (studentId == null) {
            response.sendRedirect("member_login.jsp?error=Session expired. Please log in.");
            return;
        }

        String oldPassword = request.getParameter("oldPassword");
        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");

        // 1. Basic Validation
        if (!newPassword.equals(confirmPassword)) {
            response.sendRedirect("change_password.jsp?error=New passwords do not match.");
            return;
        }

        LibraryDAO dao = new LibraryDAO();

        try {
            String result = dao.changeMemberPassword(studentId, oldPassword, newPassword);

            if ("SUCCESS".equals(result)) {
                // Success
                response.sendRedirect("change_password.jsp?msg=Password changed successfully!");
            } else {
                // Custom error message (DAO se aaya)
                response.sendRedirect("change_password.jsp?error=" + java.net.URLEncoder.encode(result, "UTF-8"));
            }

        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp?msg=DB Error during password change: " + e.getMessage());
        }
    }
}