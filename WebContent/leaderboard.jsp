<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title> Leader Board </title>
</head>
<body>
	<h2 align="center"><font color="0000FF"><strong>Leader Board</strong></font></h2>
	<table align="center" cellpadding = "4" cellspacing = "4" border = "4">
	<tr>
	</tr>
	<tr bgcolor="#00FFFF">
	<td><b>Username</b></td>
	<td><b>Rating</b></td>
	<td><b># of Passengers This Month</b></td>
	<td><b>Rides Completed This Month</b></td>
	<td><b>Campus Parked On</b><br></td>
	</tr>
	<%
		try {

			String url = "jdbc:mysql://malcador.canetd0jmani.us-east-2.rds.amazonaws.com:3306/RideShare";
			//Load JDBC driver - the interface standardizing the connection procedure. Look at WEB-INF\lib for a mysql connector jar file, otherwise it fails.
			Class.forName("com.mysql.jdbc.Driver");
			Connection con = DriverManager.getConnection(url, "keyujin", "password");
			
			String sql = "SELECT * FROM DriverStatistics";
			Statement statement = con.createStatement();
			ResultSet resultSet = statement.executeQuery(sql);
			while (resultSet.next()) {
	%>
				<tr bgcolor="#56A5EC">
				<td><%=resultSet.getString("Username")%></td>
				<td><%=resultSet.getString("Rating")%></td>
				<td><%=resultSet.getString("PassengersThisMonth")%></td>
				<td><%=resultSet.getString("RidesThisMonth")%></td>
				<td><%=resultSet.getString("CampusParkedOn")%></td>
				</tr>
	 <% 
			}
			con.close();
		} catch (Exception e) {
			e.printStackTrace();
		}	     
	%>
</body>
</html>