<%@ page import="java.sql.*"%>
<%@ page import="jakarta.servlet.http.HttpSession"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>User Dashboard</title>
    <link rel="stylesheet" href="styles.css">
</head>
<body>

<%
    //HttpSession session = request.getSession(false);
    if(session == null || session.getAttribute("user_id") == null){
        response.sendRedirect("login.jsp"); // Redirect to login if no session found
        return;
    }

    int userId = (Integer) session.getAttribute("user_id");
    String action = request.getParameter("action");
    Connection conn = null;
    PreparedStatement pstmt = null;
    boolean isDataChanged = false;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/website", "root", "0000");
        
        if("add".equals(action)) {
            String sql = "INSERT INTO person_info (user_id, skill, education, project_info, contact_info) VALUES (?, ?, ?, ?, ?)";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, userId);
            pstmt.setString(2, request.getParameter("skill"));
            pstmt.setString(3, request.getParameter("education"));
            pstmt.setString(4, request.getParameter("project_info"));
            pstmt.setString(5, request.getParameter("contact_info"));
            pstmt.executeUpdate();
            isDataChanged = true;
        } 
        if("update".equals(action)) {
            String sql = "UPDATE person_info SET skill=?, education=?, project_info=?, contact_info=? WHERE person_id=? AND user_id=?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, request.getParameter("skill"));
            pstmt.setString(2, request.getParameter("education"));
            pstmt.setString(3, request.getParameter("project_info"));
            pstmt.setString(4, request.getParameter("contact_info"));
            pstmt.setInt(5, Integer.parseInt(request.getParameter("person_id")));
            pstmt.setInt(6, userId);
            pstmt.executeUpdate();
            isDataChanged = true;
        }
        else if("delete".equals(action)) {
            String sql = "DELETE FROM person_info WHERE person_id=? AND user_id=?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, Integer.parseInt(request.getParameter("person_id")));
            pstmt.setInt(2, userId);
            pstmt.executeUpdate();
            isDataChanged = true;
        }
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        if(pstmt != null) try { pstmt.close(); } catch (SQLException ex) { /* Ignored */ }
        if(conn != null) try { conn.close(); } catch (SQLException ex) { /* Ignored */ }
    }

    // Redirect to the same page to refresh the data after add/delete
    if(isDataChanged) {
        response.sendRedirect("userDashboard.jsp");
        return;
    }
%>

<h2>User Dashboard</h2>

<div class="form-container">
<h2>Add New Information</h2>
<!-- Form for adding new personal information -->
<form action="userDashboard.jsp" method="post">
    <input type="hidden" name="action" value="add">
    <div>
        <label for="skill">Skill:</label>
        <input type="text" name="skill" required>
    </div>
    <div>
        <label for="education">Education:</label>
        <input type="text" name="education" required>
    </div>
    <div>
        <label for="project_info">Project Info:</label>
        <textarea name="project_info" required></textarea>
    </div>
    <div>
        <label for="contact_info">Contact Info:</label>
        <input type="text" name="contact_info" required>
    </div>
    <button type="submit">Submit</button>
</form>
</div>
<!-- List existing records with options to edit and delete -->
<%
    Statement stmt = null;
    ResultSet rs = null;
    try {
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/website", "root", "0000");
        stmt = conn.createStatement();
        rs = stmt.executeQuery("SELECT * FROM person_info WHERE user_id = " + userId);
%>
<div class="table-container">
<h2>Your Information</h2>
<table border="1">
    <tr>
        <th>Skill</th>
        <th>Education</th>
        <th>Project Info</th>
        <th>Contact Info</th>
        <th>Actions</th>
    </tr>
<%
        while(rs.next()) {
%>
    <tr>
        <td><%= rs.getString("skill") %></td>
        <td><%= rs.getString("education") %></td>
        <td><%= rs.getString("project_info") %></td>
        <td><%= rs.getString("contact_info") %></td>
        <td>
            <a href="editPersonalInfo.jsp?person_id=<%= rs.getInt("person_id") %>">Edit</a> |
            <a href="userDashboard.jsp?action=delete&person_id=<%= rs.getInt("person_id") %>" onClick="return confirm('Are you sure?');">Delete</a>
        </td>
    </tr>
<%
        }
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        if(rs != null) try { rs.close(); } catch (SQLException ex) { /* Ignored */ }
        if(stmt != null) try { stmt.close(); } catch (SQLException ex) { /* Ignored */ }
        if(conn != null) try { conn.close(); } catch (SQLException ex) { /* Ignored */ }
    }
%>
</table>
</div>
</body>
</html>