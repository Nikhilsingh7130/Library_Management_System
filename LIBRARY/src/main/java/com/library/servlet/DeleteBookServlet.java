package com.library.servlet;

import com.library.dao.LibraryDAO;
import java.io.IOException;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/DeleteBookServlet")
public class DeleteBookServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String isbn = request.getParameter("isbn");
        LibraryDAO dao = new LibraryDAO();

        try {
            String result = dao.deleteBook(isbn);

            if ("SUCCESS".equals(result)) {
                // Success
                response.sendRedirect("admin_dashboard.jsp?msg=Book with ISBN " + isbn + " permanently deleted.");
            } else {
                // Custom error message (DAO se aaya)
                response.sendRedirect("delete_book_form.jsp?error=" + java.net.URLEncoder.encode(result, "UTF-8"));
            }

        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp?msg=DB Error during deletion: " + e.getMessage());
        }
    }
}