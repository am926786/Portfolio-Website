<%@ page import="java.sql.*" %>
<%
    String dbURL = "jdbc:mysql://localhost:3306/website";
    String dbUsername = "root"; // Update with your DB username
    String dbPassword = "0000"; // Update with your DB password
    Connection conn = null;
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(dbURL, dbUsername, dbPassword);
    } catch (ClassNotFoundException | SQLException e) {
        e.printStackTrace();
    }
    request.setAttribute("conn", conn);
%>
