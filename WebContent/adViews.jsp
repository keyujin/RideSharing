<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title> Ad View Count </title>
</head>
<body>
	<h2 align="center"><strong>Ad View Count</strong></h2>
	<table align="center" cellpadding = "4" cellspacing = "4" border = "4">
	<tr>
	</tr>
	<td><b>Ad Name</b></td>
	<td><b>Ad Views</b></td>
	<%
		try {

			String url = "jdbc:mysql://malcador.canetd0jmani.us-east-2.rds.amazonaws.com:3306/RideShare";
			//Load JDBC driver - the interface standardizing the connection procedure. Look at WEB-INF\lib for a mysql connector jar file, otherwise it fails.
			Class.forName("com.mysql.jdbc.Driver");
			Connection con = DriverManager.getConnection(url, "keyujin", "password");
			
			String sql = "SELECT * FROM Ads";
			Statement statement = con.createStatement();
			ResultSet resultSet = statement.executeQuery(sql);
			while (resultSet.next()) {
	%>
				<tr>
				<td><%=resultSet.getString("AdName")%></td>
				<td><%=resultSet.getString("AdViews")%></td>
				</tr>
	 <% 
			}
			con.close();
		} catch (Exception e) {
			e.printStackTrace();
		}	     
	%>
	</table>
	<br>
	<input type="button" style = "margin-left:370px" value="Back" onclick="javascript:history.go(-1)">
	<br>
</body>
</html>