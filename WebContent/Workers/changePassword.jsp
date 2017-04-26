<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>updating information...</title>
</head>
<body>
<%
String user = (String) session.getAttribute("UserName");
String password = (String) request.getParameter("password");

		try {

			String url = "jdbc:mysql://malcador.canetd0jmani.us-east-2.rds.amazonaws.com:3306/RideShare";
			//Load JDBC driver - the interface standardizing the connection procedure. Look at WEB-INF\lib for a mysql connector jar file, otherwise it fails.
			Class.forName("com.mysql.jdbc.Driver");
			Connection con = DriverManager.getConnection(url, "keyujin", "password");
			
			//Make an insert statement for the Sells table:
			String insert = "UPDATE UserTable SET password = ? WHERE username = ?";
			//Create a Prepared SQL statement allowing you to introduce the parameters of the query
			PreparedStatement ps = con.prepareStatement(insert);
			//Add parameters of the query. Start with 1, the 0-parameter is the INSERT statement itself
			ps.setString(1, password);
			ps.setString(2, user);
			ps.executeUpdate();
			String delete = "DELETE FROM Reset WHERE username LIKE ?";
			ps = con.prepareStatement(delete);
			ps.setString(1,user);
			ps.executeUpdate();
			ps.close();
			//close the connection
			con.close();
			response.sendRedirect(request.getContextPath());
		} catch (Exception e) {
			out.print("something went wrong..");
		}
	%>
</body>
</html>