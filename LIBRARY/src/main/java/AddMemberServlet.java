import com.library.dao.LibraryDAO;

import java.io.IOException;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

// ... (Sare imports) ...

@WebServlet("/AddMemberServlet")
public class AddMemberServlet extends HttpServlet {
    // ... serialVersionUID ...

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Input receive karein
        String studentId = request.getParameter("studentId");
        String name = request.getParameter("name");
        String password = request.getParameter("password");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        LibraryDAO dao = new LibraryDAO();

        try {
            String result = dao.addMember(studentId, name, password, email,phone);

            if ("SUCCESS".equals(result)) {
                // Success
                response.sendRedirect("admin_dashboard.jsp?msg=Member " + studentId + " successfully registered!");
            } else {
                // Custom error message (jo DAO se aaya)
                response.sendRedirect("add_member.jsp?error=" + java.net.URLEncoder.encode(result, "UTF-8"));
            }

        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp?msg=DB Error adding member: " + e.getMessage());
        }
    }
}