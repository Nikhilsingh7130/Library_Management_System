
import com.library.dao.LibraryDAO;

import java.io.IOException;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
// ... (Sare imports) ...

@WebServlet("/ReturnBookServlet")
public class ReturnBookServlet extends HttpServlet {
    // ... serialVersionUID ...

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            String isbn = request.getParameter("isbn");
            String studentId = request.getParameter("studentId");

            LibraryDAO dao = new LibraryDAO();
            String result = dao.returnBook(isbn, studentId);

            if ("SUCCESS".equals(result)) {
                // Success
                response.sendRedirect("admin_dashboard.jsp?msg=com.library.model.Book successfully returned by " + studentId);
            } else {
                // Custom error message (jo DAO se aaya)
                response.sendRedirect("return_book_form.jsp?error=" + java.net.URLEncoder.encode(result, "UTF-8"));
            }

        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp?msg=Critical DB Transaction Error: " + e.getMessage());
        }
    }
}