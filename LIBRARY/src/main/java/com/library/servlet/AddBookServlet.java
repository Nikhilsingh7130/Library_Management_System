package com.library.servlet;
//import com.library.dao.com.library.dao.LibraryDAO;
//... necessary imports ...
import com.library.dao.LibraryDAO;

import java.io.IOException;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/AddBookServlet")
public class AddBookServlet extends HttpServlet {
    // ... serialVersionUID ...

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Input receive karein
        String isbn = request.getParameter("isbn");
        String title = request.getParameter("title");
        String author = request.getParameter("author");
        // String ko int mein convert karein
        int quantity = Integer.parseInt(request.getParameter("quantity"));

        LibraryDAO dao = new LibraryDAO();

        try {
            if (dao.addBook(isbn, title, author, quantity)) {
                // Success: Dashboard par success message ke saath redirect karein
                response.sendRedirect("admin_dashboard.jsp?msg=Book added successfully!");
            } else {
                // Failure: (E.g., ISBN already exists)
                response.sendRedirect("add_book.jsp?error=Book insertion failed, perhaps ISBN already exists.");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp?msg=DB Error adding book: " + e.getMessage());
        } catch (NumberFormatException e) {
            response.sendRedirect("add_book.jsp?error=Quantity must be a valid number.");
        }
    }
}