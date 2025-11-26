package com.library.dao; // Apne actual package name se replace karein

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
//import com.java.model.com.library.model.Book;
import java.sql.Statement;
import java.sql.Date;
import com.library.model.Book;
import com.library.model.Member;
import com.library.model.IssuedBook;
import java.time.LocalDate;
public class LibraryDAO {

    // Database Connection Details (Aapke credentials ke according change karein)
    private static final String JDBC_URL = "jdbc:mysql://localhost:3306/lib?allowPublicKeyRetrieval=true&useSSL=false"; // Database name 'lib'
    private static final String DB_USER = "root"; // Aapka MySQL username
    private static final String DB_PASSWORD = "Nikhil@7130"; // Aapka MySQL password

    /**
     * Database se Connection establish karta hai.
     */
    public static Connection getConnection() throws SQLException {
        try {
            // Step 1: JDBC Driver Load karna
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            System.err.println("MySQL JDBC Driver not found.");
            throw new SQLException("MySQL Driver not found.", e);
        }

        // Step 2: Connection establish karna
        return DriverManager.getConnection(JDBC_URL, DB_USER, DB_PASSWORD);
    }

    // ----------------------------------------------------------------------
    //                           LOGIN VALIDATION
    // ----------------------------------------------------------------------

    /**
     * Admin credentials ko validate karta hai.
     * Table: admin
     */
    public boolean validateAdmin(String username, String password) throws SQLException {

        // Query jo username aur password_hash dono check karegi
        String sql = "SELECT * FROM admin WHERE username = ? AND password_hash = ?";

        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, username);
            ps.setString(2, password);

            try (ResultSet rs = ps.executeQuery()) {
                // Agar ResultSet mein koi row hai, toh login successful hai
                return rs.next();
            }
        }
    }
    public List<Book> getAllBooks() throws SQLException {
        List<Book> bookList = new ArrayList<>();
        String sql = "SELECT book_id, isbn, title, author, quantity, issued_copies FROM books";

        try (Connection conn = getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {

            while (rs.next()) {
                Book book = new Book(
                        rs.getInt("book_id"),
                        rs.getString("isbn"),
                        rs.getString("title"),
                        rs.getString("author"),
                        rs.getInt("quantity"),
                        rs.getInt("issued_copies")
                );
                bookList.add(book);
            }
        }
        return bookList;
    }
// com.library.dao.LibraryDAO.java mein add karein


    /**
     * com.library.model.Member/Student credentials ko validate karta hai.
     * Table: members
     * Returns: 1 agar successful, -1 agar fail.
     */
    public int validateMember(String studentId, String password) throws SQLException {

        // Query jo student_id aur password_hash dono check karegi
        String sql = "SELECT student_id FROM members WHERE student_id = ? AND password_hash = ?";

        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, studentId);
            ps.setString(2, password);

            try (ResultSet rs = ps.executeQuery()) {
                // Agar ResultSet mein row milti hai, toh member exist karta hai aur credentials sahi hain
                if (rs.next()) {
                    return 1; // Success
                }
            }
        }
        return -1; // Failure
    }
    public boolean addBook(String isbn, String title, String author, int quantity) throws SQLException {
        // Issued_copies default 0 honge
        String sql = "INSERT INTO books (isbn, title, author, quantity, issued_copies) VALUES (?, ?, ?, ?, 0)";
        int rowsAffected = 0;

        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, isbn);
            ps.setString(2, title);
            ps.setString(3, author);
            ps.setInt(4, quantity);

            rowsAffected = ps.executeUpdate();
        }
        return rowsAffected > 0;
    }
    public String getStudentName(String studentId) throws java.sql.SQLException {
        String name = null;
        String sql = "SELECT name FROM members WHERE student_id = ?";

        try (java.sql.Connection conn = getConnection();
             java.sql.PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, studentId);

            try (java.sql.ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    name = rs.getString("name");
                }
            }
        }
        return name;
    }
    public String changeMemberPassword(String studentId, String oldPassword, String newPassword) throws java.sql.SQLException {

        // 1. Verify Old Password
        String sqlVerify = "SELECT student_id FROM members WHERE student_id = ? AND password_hash = ?";

        // 2. Update New Password
        String sqlUpdate = "UPDATE members SET password_hash = ? WHERE student_id = ?";

        try (java.sql.Connection conn = getConnection()) {

            // A. Verification Check
            try (java.sql.PreparedStatement psVerify = conn.prepareStatement(sqlVerify)) {
                psVerify.setString(1, studentId);
                psVerify.setString(2, oldPassword);

                if (!psVerify.executeQuery().next()) {
                    return "Verification Failed: Old password is incorrect.";
                }
            }

            // B. Update Password
            try (java.sql.PreparedStatement psUpdate = conn.prepareStatement(sqlUpdate)) {
                psUpdate.setString(1, newPassword);
                psUpdate.setString(2, studentId);

                psUpdate.executeUpdate();
                return "SUCCESS";
            }

        } catch (java.sql.SQLException e) {
            throw e;
        }
    }
    // com.library.dao.LibraryDAO.java mein add karein
// ... (Aur saare imports) ...

    public String issueBook(String isbn, String studentId, int days) throws SQLException {

        // 1. Calculate Dates
        LocalDate issueDate = LocalDate.now();
        LocalDate dueDate = issueDate.plusDays(days);

        // SQL Queries
        String sqlCheckMember = "SELECT student_id FROM members WHERE student_id = ?";
        String sqlGetBookId = "SELECT book_id, issued_copies, quantity FROM books WHERE isbn = ?"; // com.library.model.Book ID aur Stock check karne ke liye
        String sqlUpdateBook = "UPDATE books SET issued_copies = issued_copies + 1 WHERE book_id = ?";
        String sqlInsertTxn = "INSERT INTO transactions (book_id, student_id, issue_date, due_date) VALUES (?, ?, ?, ?)";

        Connection conn = null;
        int bookId = -1;

        try {
            conn = getConnection();
            conn.setAutoCommit(false); // *** TRANSACTION START ***

            // A. com.library.model.Member ID Check (Same as before)
            try (PreparedStatement psCheck = conn.prepareStatement(sqlCheckMember)) {
                psCheck.setString(1, studentId);
                if (!psCheck.executeQuery().next()) {
                    return "com.library.model.Member ID not found.";
                }
            }

            // B. Get com.library.model.Book ID and Check Stock (NEW STEP)
            try (PreparedStatement psGetId = conn.prepareStatement(sqlGetBookId)) {
                psGetId.setString(1, isbn);
                ResultSet rs = psGetId.executeQuery();

                if (!rs.next()) {
                    return "com.library.model.Book with given ISBN not found.";
                }

                bookId = rs.getInt("book_id");
                int quantity = rs.getInt("quantity");
                int issued = rs.getInt("issued_copies");

                if (issued >= quantity) {
                    return "All copies of this book are currently issued (Stock out).";
                }
            }

            // C. com.library.model.Book Stock Update
            try (PreparedStatement psUpdate = conn.prepareStatement(sqlUpdateBook)) {
                psUpdate.setInt(1, bookId);
                psUpdate.executeUpdate();
            }

            // D. Insert Transaction Record
            try (PreparedStatement psInsert = conn.prepareStatement(sqlInsertTxn)) {
                psInsert.setInt(1, bookId);
                psInsert.setString(2, studentId);
                psInsert.setDate(3, Date.valueOf(issueDate));
                psInsert.setDate(4, Date.valueOf(dueDate));
                psInsert.executeUpdate();
            }

            conn.commit(); // *** TRANSACTION SUCCESS ***
            return "SUCCESS";

        } catch (SQLException e) {
            if (conn != null) {
                conn.rollback();
            }
            throw e;
        } finally {
            if (conn != null) {
                conn.setAutoCommit(true);
                conn.close();
            }
        }
    }
    // com.library.dao.LibraryDAO.java mein add karein


    public String returnBook(String isbn, String studentId) throws SQLException {

        // 1. SQL Queries
        String sqlGetBookId = "SELECT book_id FROM books WHERE isbn = ?";
        // 2. Transaction ko update karein (return_date set karein, jiska return_date NULL ho)
        String sqlUpdateTxn = "UPDATE transactions SET return_date = CURDATE() WHERE book_id = ? AND student_id = ? AND return_date IS NULL";
        // 3. Issued copies kam karein
        String sqlUpdateBook = "UPDATE books SET issued_copies = issued_copies - 1 WHERE book_id = ?";

        Connection conn = null;
        int bookId = -1;
        int transactionsUpdated = 0;

        try {
            conn = getConnection();
            conn.setAutoCommit(false); // *** TRANSACTION START ***

            // A. Get com.library.model.Book ID
            try (PreparedStatement psGetId = conn.prepareStatement(sqlGetBookId)) {
                psGetId.setString(1, isbn);
                ResultSet rs = psGetId.executeQuery();

                if (!rs.next()) {
                    return "com.library.model.Book with given ISBN not found.";
                }
                bookId = rs.getInt("book_id");
            }

            // B. Update Transaction Record (Mark book as returned)
            try (PreparedStatement psUpdateTxn = conn.prepareStatement(sqlUpdateTxn)) {
                psUpdateTxn.setInt(1, bookId);
                psUpdateTxn.setString(2, studentId);
                transactionsUpdated = psUpdateTxn.executeUpdate();

                if (transactionsUpdated == 0) {
                    conn.rollback();
                    return "This book is not currently issued to this student or transaction is already closed.";
                }
            }

            // C. Update com.library.model.Book Stock (Issued copies - 1)
            try (PreparedStatement psUpdateBook = conn.prepareStatement(sqlUpdateBook)) {
                psUpdateBook.setInt(1, bookId);
                psUpdateBook.executeUpdate();
            }

            conn.commit(); // *** TRANSACTION SUCCESS ***
            return "SUCCESS";

        } catch (SQLException e) {
            if (conn != null) {
                conn.rollback();
            }
            throw e;
        } finally {
            if (conn != null) {
                conn.setAutoCommit(true);
                conn.close();
            }
        }
    }
    // com.library.dao.LibraryDAO.java mein add karein

    public String addMember(String studentId, String name, String password, String email,String phone) throws SQLException {

        // Check karein ki member pehle se exist toh nahi karta
        String sqlCheck = "SELECT student_id FROM members WHERE student_id = ?";

        // INSERT query
        String sqlInsert = "INSERT INTO members (student_id, name, password_hash, email, phone) VALUES (?, ?, ?, ?, ?)";

        try (Connection conn = getConnection()) {

            // 1. Check for existing ID
            try (PreparedStatement psCheck = conn.prepareStatement(sqlCheck)) {
                psCheck.setString(1, studentId);
                if (psCheck.executeQuery().next()) {
                    return "com.library.model.Member with this Student ID already exists.";
                }
            }

            // 2. Insert new member
            try (PreparedStatement psInsert = conn.prepareStatement(sqlInsert)) {
                psInsert.setString(1, studentId);
                psInsert.setString(2, name);
                psInsert.setString(3, password); // Storing plain password (password_hash field mein)
                psInsert.setString(4, email);
                psInsert.setString(5, phone);

                int rowsAffected = psInsert.executeUpdate();

                if (rowsAffected > 0) {
                    return "SUCCESS";
                } else {
                    return "Failed to insert member due to unknown reason.";
                }
            }

        } catch (SQLException e) {
            // SQLIntegrityConstraintViolationException (Agar UNIQUE constraint fail ho)
            if (e.getSQLState().startsWith("23")) {
                return "com.library.model.Member ID already exists.";
            }
            throw e;
        }
    }
    public java.util.List<Member> getAllMembers() throws SQLException {
        java.util.List<Member> memberList = new java.util.ArrayList<>();

        // Password field ko chhod kar baaki sab select karein
        String sql = "SELECT student_id, name, email, phone FROM members";

        try (java.sql.Connection conn = getConnection();
             java.sql.Statement stmt = conn.createStatement();
             java.sql.ResultSet rs = stmt.executeQuery(sql)) {

            while (rs.next()) {
                com.library.model.Member member = new com.library.model.Member(
                        rs.getString("student_id"),
                        rs.getString("name"),
                        rs.getString("email"),
                        rs.getString("phone")
                );
                memberList.add(member);
            }
        }
        return memberList;
    }
    public java.util.List<com.library.model.IssuedBook> getIssuedBooksByStudent(String studentId) throws java.sql.SQLException {
        java.util.List<com.library.model.IssuedBook> issuedList = new java.util.ArrayList<>();

        // JOIN Query: transactions, books ko join karke sirf woh records nikalna jo abhi return nahi hue hain
        String sql = "SELECT t.transaction_id, b.title, b.author, b.isbn, t.issue_date, t.due_date " +
                "FROM transactions t " +
                "JOIN books b ON t.book_id = b.book_id " +
                "WHERE t.student_id = ? AND t.return_date IS NULL";

        try (java.sql.Connection conn = getConnection();
             java.sql.PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, studentId);

            try (java.sql.ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    com.library.model.IssuedBook issuedBook = new com.library.model.IssuedBook(
                            rs.getString("title"),
                            rs.getString("author"),
                            rs.getString("isbn"),
                            rs.getDate("issue_date"),
                            rs.getDate("due_date"),
                            rs.getInt("transaction_id")
                    );
                    issuedList.add(issuedBook);
                }
            }
        }
        return issuedList;
    }
    public String deleteBook(String isbn) throws java.sql.SQLException {

        // 1. SQL Queries
        String sqlGetBookId = "SELECT book_id FROM books WHERE isbn = ?";
        String sqlCheckIssued = "SELECT transaction_id FROM transactions WHERE book_id = ? AND return_date IS NULL"; // Safety Check
        String sqlDeleteBook = "DELETE FROM books WHERE book_id = ?";

        Connection conn = null;
        int bookId = -1;

        try {
            conn = getConnection();

            // A. Get Book ID
            try (java.sql.PreparedStatement psGetId = conn.prepareStatement(sqlGetBookId)) {
                psGetId.setString(1, isbn);
                java.sql.ResultSet rs = psGetId.executeQuery();

                if (!rs.next()) {
                    return "Book with given ISBN not found.";
                }
                bookId = rs.getInt("book_id");
            }

            // B. Safety Check: Check karein ki book issued toh nahi hai
            try (java.sql.PreparedStatement psCheck = conn.prepareStatement(sqlCheckIssued)) {
                psCheck.setInt(1, bookId);
                if (psCheck.executeQuery().next()) {
                    return "Error: This book is currently ISSUED. Cannot delete.";
                }
            }

            // C. Delete Book
            try (java.sql.PreparedStatement psDelete = conn.prepareStatement(sqlDeleteBook)) {
                psDelete.setInt(1, bookId);
                int rowsAffected = psDelete.executeUpdate();

                if (rowsAffected > 0) {
                    return "SUCCESS";
                } else {
                    return "Book deletion failed unexpectedly.";
                }
            }

        } catch (java.sql.SQLException e) {
            throw e;
        } finally {
            if (conn != null) {
                conn.close();
            }
        }
    }
    // ----------------------------------------------------------------------
    //                      FUTURE METHODS (Placeholders)
    // ----------------------------------------------------------------------

    /* public boolean addBook(com.library.model.Book book) { ... JDBC INSERT logic ... }
    public List<com.library.model.Book> getAllBooks() { ... JDBC SELECT logic ... }
    public boolean issueBook(int bookId, String studentId) { ... JDBC Transaction logic ... }
    public boolean returnBook(int transactionId) { ... JDBC UPDATE logic ... }
    */
}