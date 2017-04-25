<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Rider DashBoard</title>
</head>
<body>
Welcome <%
out.print((String) session.getAttribute("UserName"));
%>
<br>
	<form method="post" action="addRequest.jsp">
	<table>
	<tr>    
	<td>Time</td><td><input type="text" name="time"></td>
	</tr>
	<tr>
	<td>Date</td><td><input type="text" name="date"></td>
	</tr>
	<tr>
	<td>From Lot</td><td><input type="text" name="fromLot#"></td>
	</tr>
	<tr>
	<td>To Lot</td><td><input type="text" name="toLot#"></td>
	</tr>
	</table>
	<input type="submit" value="Add Request">
	</form>
<br>

<h2 align="left"><font color="0000FF"><strong>Current Ride Requests</strong></font></h2>
				<table align="left" cellpadding = "4" cellspacing = "4" border = "4">
				<tr>
				</tr>
				<tr>
				<TH><b>Time</b></th>
				<th><b>Date</b></th>
				<th><b>From Lot#</b></th>
				<th><b>To Lot# </b></th>
				</tr>

	<%
	
	String url = "jdbc:mysql://malcador.canetd0jmani.us-east-2.rds.amazonaws.com:3306/RideShare";
	//Load JDBC driver - the interface standardizing the connection procedure. Look at WEB-INF\lib for a mysql connector jar file, otherwise it fails.
	Class.forName("com.mysql.jdbc.Driver");
	Connection con = DriverManager.getConnection(url, "keyujin", "password");
			
	PreparedStatement statement = null;
	
	
	statement = con.prepareStatement("SELECT * FROM RideRequests r Where r.riderUsername='"+(String) session.getAttribute("UserName")+"'");

	ResultSet resultSet = statement.executeQuery();
	while (resultSet.next()) {
	%>
		<tr bgcolor="#56A5EC">
		<td><%=resultSet.getString("Time")%></td>
		<td><%=resultSet.getString("Date")%></td>
		<td><%=resultSet.getInt("FromLot")%></td>
		<td><%=resultSet.getInt("ToLot")%></td>
		</tr>			
		
	<%
	}
%>
</table>
</body>
</html>