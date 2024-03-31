<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Recruiter Dashboard</title>
    <link rel="stylesheet" href="styles.css">
</head>
<body>

<h2>Recruiter Dashboard</h2>

<div class="table-container">
    <h2>Candidate Information</h2>
    <table border="1">
        <tr>
            <th>User ID</th>
            <th>Skill</th>
            <th>Education</th>
            <th>Project Info</th>
            <th>Contact Info</th>
        </tr>
        <%
            Connection conn = null;
            Statement stmt = null;
            ResultSet rs = null;

            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/website", "root", "0000");
                stmt = conn.createStatement();
                rs = stmt.executeQuery("SELECT * FROM person_info");

                while (rs.next()) {
        %>
        <tr>
            <td><%= rs.getInt("user_id") %></td>
            <td><%= rs.getString("skill") %></td>
            <td><%= rs.getString("education") %></td>
            <td><%= rs.getString("project_info") %></td>
            <td><%= rs.getString("contact_info") %></td>
        </tr>
        <%
                }
            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                if (rs != null) try { rs.close(); } catch (SQLException ex) { /* Ignored */ }
                if (stmt != null) try { stmt.close(); } catch (SQLException ex) { /* Ignored */ }
                if (conn != null) try { conn.close(); } catch (SQLException ex) { /* Ignored */ }
            }
        %>
    </table>
</div>

</body>
</html>
