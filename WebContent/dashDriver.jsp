<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Driver DashBoard</title>
</head>
<body>
Welcome <%

out.print((String) session.getAttribute("UserName"));
%>
<form method="get" action="inbox.jsp" enctype=text/plain>
  <input type="submit" value="inbox">
</form>
<br>
	<form method="post" action="<%=request.getContextPath()%>/Workers/addOffer.jsp">
	<table>
	<tr>    
	<td>Time From: (00:00:00)</td><td><input type="text" name="timeFrom"></td>
	</tr>
	<tr>    
	<td>Time To: (00:00:00)</td><td><input type="text" name="timeTo"></td>
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
	<tr>
	<td>Number of Passengers</td><td><input type="text" name="numPass"></td>
	</tr>
	</table>
	<br>
	Recurring?
	<select name="recurring" size=1>
		<option value="0">Yes</option>
		<option value="1">No</option>
	</select>&nbsp;<br>
	<br>
	<input type="submit" value="Add Offer">
	</form>
<br>
<h2 align="left"><font color="0000FF"><strong>Matching Ride Requests</strong></font></h2>
				<table align="left" cellpadding = "4" cellspacing = "4" border = "4">
				<tr>
				</tr>
				<tr>
				<TH><b>Departure Time</b></th>
				<th><b>Date</b></th>
				<th><b>From Lot#</b></th>
				<th><b>To Lot# </b></th>
				<th><b>Rider Username </b></th>
				<th><b>Accept/Deny </b></th>
		
				</tr>

	<%
	
	String url = "jdbc:mysql://malcador.canetd0jmani.us-east-2.rds.amazonaws.com:3306/RideShare";
	//Load JDBC driver - the interface standardizing the connection procedure. Look at WEB-INF\lib for a mysql connector jar file, otherwise it fails.
	Class.forName("com.mysql.jdbc.Driver");
	Connection con = DriverManager.getConnection(url, "keyujin", "password");
			
	PreparedStatement statement = null;
	
	
	statement = con.prepareStatement("SELECT rq.riderUsername,rq.time,rq.date,rq.fromLot,rq.toLot FROM RideRequests rq, RideOffers ro WHERE rq.time<=ro.timeTo AND rq.time>=ro.timeFrom AND rq.date=ro.Date");

	ResultSet resultSet = statement.executeQuery();
	while (resultSet.next()) {
	%>
		<tr bgcolor="#56A5EC">
		<td><%=resultSet.getString("time")%></td>
		<td><%=resultSet.getString("Date")%></td>
		<td><%=resultSet.getInt("FromLot")%></td>
		<td><%=resultSet.getInt("ToLot")%></td>
		<td><%=resultSet.getString("riderUsername")%></td>

		<td><form method="get" action="inbox.jsp" enctype=text/plain>
  			<input type="submit" value="Send Message">
			</form>
		</td>
		
		</tr>			
		
	<%
	}
%>
</table>
</body>
</html>