<%@ page import="java.sql.*"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Edit Personal Information</title>
    <link rel="stylesheet" href="styles.css">
</head>
<body>

<%
    int personId = Integer.parseInt(request.getParameter("person_id"));
    String skill = "", education = "", projectInfo = "", contactInfo = "";
    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/website", "root", "0000");
        String sql = "SELECT * FROM person_info WHERE person_id = ?";
        pstmt = conn.prepareStatement(sql);
        pstmt.setInt(1, personId);
        rs = pstmt.executeQuery();

        if(rs.next()) {
            skill = rs.getString("skill");
            education = rs.getString("education");
            projectInfo = rs.getString("project_info");
            contactInfo = rs.getString("contact_info");
        }
    } catch(Exception e) {
        e.printStackTrace();
    } finally {
        if(rs != null) try { rs.close(); } catch(SQLException e) { e.printStackTrace(); }
        if(pstmt != null) try { pstmt.close(); } catch(SQLException e) { e.printStackTrace(); }
        if(conn != null) try { conn.close(); } catch(SQLException e) { e.printStackTrace(); }
    }
%>

<h2>Edit Personal Information</h2>

<form action="userDashboard.jsp" method="post">
    <input type="hidden" name="action" value="update">
    <input type="hidden" name="person_id" value="<%= personId %>">
    <div>
        <label for="skill">Skill:</label>
        <input type="text" id="skill" name="skill" value="<%= skill %>" required>
    </div>
    <div>
        <label for="education">Education:</label>
        <input type="text" id="education" name="education" value="<%= education %>" required>
    </div>
    <div>
        <label for="project_info">Project Info:</label>
        <textarea id="project_info" name="project_info" required><%= projectInfo %></textarea>
    </div>
    <div>
        <label for="contact_info">Contact Info:</label>
        <input type="text" id="contact_info" name="contact_info" value="<%= contactInfo %>" required>
    </div>
    <button type="submit">Update</button>
</form>

</body>
</html>
