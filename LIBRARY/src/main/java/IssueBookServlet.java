
import com.library.dao.LibraryDAO;

import java.io.IOException;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

// ... (Sare imports) ...
@WebServlet("/IssueBookServlet")
public class IssueBookServlet extends HttpServlet {
    // ... serialVersionUID ...

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            // bookId ki jagah ISBN receive karein
            String isbn = request.getParameter("isbn");
            String studentId = request.getParameter("studentId");
            int issueDays = Integer.parseInt(request.getParameter("issueDays"));

            LibraryDAO dao = new LibraryDAO();
            // IssueBook method ko updated signature ke saath call karein
            String result = dao.issueBook(isbn, studentId, issueDays);

            if ("SUCCESS".equals(result)) {
                response.sendRedirect("admin_dashboard.jsp?msg=Book (" + isbn + ") successfully issued to " + studentId);
            } else {
                response.sendRedirect("issue_book_form.jsp?error=" + java.net.URLEncoder.encode(result, "UTF-8"));
            }

        } catch (NumberFormatException e) {
            response.sendRedirect("issue_book_form.jsp?error=Days value must be a valid number.");
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp?msg=Critical DB Transaction Error: " + e.getMessage());
        }
    }
}