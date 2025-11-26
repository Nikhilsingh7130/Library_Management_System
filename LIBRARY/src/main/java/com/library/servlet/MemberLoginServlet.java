package com.library.servlet;

import com.library.dao.LibraryDAO;

import java.io.IOException;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

// WebServlet annotation mapping URL se match hona chahiye jo member_login.jsp mein diya hai
@WebServlet("/MemberLoginServlet")
public class MemberLoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // 1. Request Handling: Form se studentId aur password receive karein
        String studentId = request.getParameter("studentId");
        String password = request.getParameter("password");

        // Object banana com.library.dao.LibraryDAO ka
        LibraryDAO dao = new LibraryDAO();
        int memberId = -1;

        try {
            // 2. JDBC Validation: DAO method call karein
            memberId = dao.validateMember(studentId, password);

            if (memberId != -1) {

                // 3. Success: Session Management
//                studentName = dao.getStudentName(studentId);
                HttpSession session = request.getSession();
                session.setAttribute("isMember", true); // Flag set karein ki user authenticated hai
                session.setAttribute("loggedInStudentId", studentId);
                session.setAttribute("loggedInMemberId", memberId); // Internal ID use ke liye
//                session.setAttribute("studentName", studentName);
                // com.library.model.Member Dashboard par redirect karein
                response.sendRedirect("member_dashboard.jsp");

            } else {
                // Failure: Wapas login page par bhej dein, error message ke saath
                String errorMsg = "Invalid Student ID or Password.";
                response.sendRedirect("member_login.jsp?error=" + errorMsg);
            }
        } catch (SQLException e) {
            // Database Error handling
            e.printStackTrace();
            response.sendRedirect("error.jsp?msg=Database error during login: " + e.getMessage());
        }
    }
}