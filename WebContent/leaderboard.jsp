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
	<b style = "margin-left:100px">Select a category to sort by:</b>
	<form name = "form" method="get" action = "#">
	<br>
	<%
	String stat = request.getParameter("stat");
	String order = request.getParameter("sort");
	%>
	<select name="stat" size=5 style = "margin-left:100px">
		<option value = "username" <%if (stat == null || stat.equals("username")){%> selected <%} %>>Username</option>
		<option value = "rating" <%if (stat != null && stat.equals("rating")){%> selected <%} %>>Rating</option>
		<option value = "numRatings" <%if (stat != null && stat.equals("numRatings")){%> selected <%} %>>Number of Ratings</option>
		<option value = "ridesGiven" <%if (stat != null && stat.equals("ridesGiven")){%> selected <%} %>>Total Rides Given</option>

	</select>&nbsp;
	<br>
	<br>
	<div id = "btn" style = "margin-left:100px">
		<input type="radio" name="sort" value="ascending" <%if (order == null || order.equals("ascending")){%>checked = "checked" <%}%>>Sort Ascending
		<input type="radio" name="sort" value="descending"<%if (order != null && order.equals("descending")){%>checked = "checked" <%}%>>Sort Descending
		<input type="submit" value ="Sort">
	</div>
	<br>	
	</form>

	<table align="center" cellpadding = "4" cellspacing = "4" border = "4">
		<tr>
		</tr>
		<tr bgcolor="#00FFFF">
		<td><b>Username</b></td>
		<td><b>Rating</b></td>
		<td><b>Number of Ratings</b></td>
		<td><b>Total Rides Given</b></td>
		</tr>		
	<%
    Connection con = null;
	try {
		String url = "jdbc:mysql://malcador.canetd0jmani.us-east-2.rds.amazonaws.com:3306/RideShare";
		//Load JDBC driver - the interface standardizing the connection procedure. Look at WEB-INF\lib for a mysql connector jar file, otherwise it fails.
		Class.forName("com.mysql.jdbc.Driver");
		con = DriverManager.getConnection(url, "keyujin", "password");
		
		if (stat == null) stat = "username";
		if (order == null) order = "ascending";
		PreparedStatement statement = null;
		if (order.equals("ascending")) {
			statement = con.prepareStatement("SELECT * FROM UserTable ORDER BY " + stat);
		} else {
			statement = con.prepareStatement("SELECT * FROM UserTable ORDER BY " + stat + " DESC");
		}
		ResultSet resultSet = statement.executeQuery();
		while (resultSet.next()) {
		%>
			<tr bgcolor="#56A5EC">
			<td><%=resultSet.getString("Username")%></td>
			<td><%=resultSet.getString("Rating")%></td>
			<td><%=resultSet.getString("numRatings")%></td>
			<td><%=resultSet.getString("ridesGiven")%></td>
			</tr>			
		<% 
		}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (con != null) con.close();
			} catch (Exception e) {
				e.printStackTrace();
			}					 
		}
	%>
	</table>

	<br>
	<input type="button" style = "margin-left:100px" value="Back" onclick="javascript:history.go(-1)">
	<br>
</body>
</html>