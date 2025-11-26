package com.library.servlet; // Apna package use karein

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/LogoutServlet")
public class LogoutServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // 1. Session lena
        HttpSession session = request.getSession(false); // Agar session exist karta hai toh lo

        if (session != null) {
            // 2. Session ko Invalidate karna (khatam karna)
            session.invalidate();
        }

        // 3. User ko Home/Index page par bhej dena
        response.sendRedirect("index.jsp");
    }

    // Logout hamesha doGet se karte hain, but doPost bhi add kar dete hain as safety
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}