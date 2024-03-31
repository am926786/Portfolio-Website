<%@ page import="java.sql.*" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.SQLException" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Registration</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>
<div class="form-container">
    <h2>Register</h2>
    <form method="post">
        <div class="input-group">
            <label for="username">Username:</label>
            <input type="text" id="username" name="username" required>
        </div>
        <div class="input-group">
            <label for="password">Password:</label>
            <input type="password" id="password" name="password" required>
        </div>
        <div class="input-group">
            <label for="role">Role:</label>
            <select id="role" name="role" required>
                <option value="user">Candidate</option>
                <option value="recruiter">Recruiter</option>
            </select>
        </div>
        <button type="submit">Register</button>
    </form>
    <% 
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String role = request.getParameter("role");
        if (username != null && password != null && role != null) {
            Connection conn = null;
            PreparedStatement pstmt = null;
            ResultSet rs = null;
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/website", "root", "0000");

                // Check if the username already exists
                String checkUserSql = "SELECT username FROM users WHERE username = ?";
                pstmt = conn.prepareStatement(checkUserSql);
                pstmt.setString(1, username);
                rs = pstmt.executeQuery();
                if (rs.next()) {
                    out.println("<p class='error'>Username already exists. Please choose a different username.</p>");
                } else {
                    // Insert new user
                    String insertUserSql = "INSERT INTO users (username, password, role) VALUES (?, ?, ?)";
                    pstmt = conn.prepareStatement(insertUserSql);
                    pstmt.setString(1, username);
                    pstmt.setString(2, password); // NOTE: Password should be hashed in a real application
                    pstmt.setString(3, role);
                    int result = pstmt.executeUpdate();
                    if (result > 0) {
                        response.sendRedirect("login.jsp"); // Redirect to login page
                    } else {
                        out.println("<p class='error'>Registration failed. Please try again.</p>");
                    }
                }
            } catch (Exception e) {
                e.printStackTrace();
                out.println("<p class='error'>An error occurred. Please try again later.</p>");
            } finally {
                if (rs != null) try { rs.close(); } catch (SQLException ex) { /* Ignored */ }
                if (pstmt != null) try { pstmt.close(); } catch (SQLException ex) { /* Ignored */ }
                if (conn != null) try { conn.close(); } catch (SQLException ex) { /* Ignored */ }
            }
        }
    %>
    <p>Already have an account? <a href="login.jsp">Login here</a></p>
</div>
</body>
</html>
