<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="jakarta.servlet.http.HttpSession" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Login</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>
<div class="form-container">
    <h2>Login</h2>
    <form method="post">
        <input type="hidden" name="action" value="login">
        <div class="input-group">
            <label for="username">Username:</label>
            <input type="text" id="username" name="username" required>
        </div>
        <div class="input-group">
            <label for="password">Password:</label>
            <input type="password" id="password" name="password" required>
        </div>
        <button type="submit">Login</button>
    </form>
    <p>Don't have an account? <a href="register.jsp">Register here</a></p>
    <%
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String action = request.getParameter("action");
        if ("login".equals(action) && username != null && password != null) {
            Connection conn = null;
            PreparedStatement pstmt = null;
            ResultSet rs = null;
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/website", "root", "0000");

                String sql = "SELECT user_id, role FROM users WHERE username = ? AND password = ?";
                pstmt = conn.prepareStatement(sql);
                pstmt.setString(1, username);
                pstmt.setString(2, password);
                rs = pstmt.executeQuery();

                if (rs.next()) {
                    int userId = rs.getInt("user_id");
                    String role = rs.getString("role");

                    // Setting session attributes
                    //HttpSession session = request.getSession();
                    session.setAttribute("user_id", userId);
                    session.setAttribute("role", role);

                    if ("user".equals(role)) {
                        response.sendRedirect("userDashboard.jsp"); // Redirect to user dashboard
                    } else if ("recruiter".equals(role)) {
                        response.sendRedirect("adminDashboard.jsp"); // Redirect to admin (recruiter) dashboard
                    }
                } else {
                    out.println("<p class='error'>Invalid username or password.</p>");
                }
            } catch (Exception e) {
                e.printStackTrace();
                out.println("<p class='error'>An error occurred during login.</p>");
            } finally {
                if (rs != null) try { rs.close(); } catch (SQLException ex) { /* Ignored */ }
                if (pstmt != null) try { pstmt.close(); } catch (SQLException ex) { /* Ignored */ }
                if (conn != null) try { conn.close(); } catch (SQLException ex) { /* Ignored */ }
            }
        }
        if (request.getParameter("error") != null) {
    %>
    <p class="error"><%= request.getParameter("error") %></p>
    <% } %>
</div>
</body>
</html>
