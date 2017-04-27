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
<form method="get" action="inbox.jsp" enctype=text/plain>
  <input type="submit" value="inbox">
</form>
<br>
	<form method="post" action="<%=request.getContextPath()%>/Workers/addRequest.jsp">
	<table>
	<tr>    
	<td>Departure Time: (00:00:00 )</td><td><input type="text" name="time"></td>
	</tr>
	<tr>
	<td>Date:(YYYY-MM-DD) </td><td><input type="text" name="date"></td>
	</tr>
	<tr>
	<%
	try{
		Class.forName("com.mysql.jdbc.Driver");
		String url0="jdbc:mysql://malcador.canetd0jmani.us-east-2.rds.amazonaws.com:3306/RideShare";
		Connection con0 = DriverManager.getConnection(url0, "keyujin", "password");
		Statement findLots = con0.createStatement();
		ResultSet allLots = findLots.executeQuery("SELECT lotName FROM Lots");
	%>
	<td>From Lot: </td>
	<td>
	<select name="fromLot#" size=1>
		<% while(allLots.next()) {%>
		<option><%=allLots.getString("lotName")%></option>
		<% }  %>
	</select>&nbsp;<br></td>
	</tr>
	<tr>
	<%
		allLots = findLots.executeQuery("SELECT lotName FROM Lots");
	%>
	<td>To Lot: </td><td>
	<select name="toLot#" size=1>
		<% while(allLots.next()) {%>
		<option><%=allLots.getString("lotName")%></option>
		<% }  %>
	</select>&nbsp;<br></td>
	</tr>
	<%}catch(Exception e){ out.println("error"); } %>
	</table>
	<br>
	Recurring?
	<select name="recurring" size=1>
		<option value=0>No</option>
		<option value=1>Every Day</option>
		<option value=2>Every Week </option>
		<option value=3>Every Month</option>
	</select>&nbsp;<br>
	<br>
<table>
<tr>
	<td>How Often? Every:</td><td><input type="text" name="numOften"> days/weeks/months</td>
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
	
	
	statement = con.prepareStatement("SELECT * FROM RideRequests r Where r.RideAccepted=0 AND r.riderUsername='"+(String) session.getAttribute("UserName")+"'");

	ResultSet resultSet = statement.executeQuery();
	while (resultSet.next()) {
	%>
		<tr bgcolor="#56A5EC">
		<td><%=resultSet.getString("time")%></td>
		<td><%=resultSet.getString("Date")%></td>
		<td><%=resultSet.getString("fromLot")%></td>
		<td><%=resultSet.getString("toLot")%></td>
		</tr>			
		
	<%
	}
%>
</table>
<br>
<br>
<br>
<br>
<br>
<h2 align="left"><font color="0000FF"><strong>Scheduled Rides</strong></font></h2>
				<table align="left" cellpadding = "4" cellspacing = "4" border = "4">
				<tr>
				</tr>
				<tr>
				<TH><b>Offer ID</b></th>
				<TH><b>Request ID</b></th>
				<TH><b>Departure Time</b></th>
				<th><b>Date</b></th>
				<th><b>From Lot#</b></th>
				<th><b>To Lot# </b></th>
				<th><b>Driver Username </b></th>
		
				</tr>

	<%
	PreparedStatement statement2 = null;
	
	
	statement2 = con.prepareStatement("SELECT ro.offerID,rq.requestID,rq.driverUsername,rq.time,rq.date,rq.fromLot,rq.toLot FROM RideRequests rq, RideOffers ro WHERE rq.time<=ro.timeTo AND rq.time>=ro.timeFrom AND rq.date=ro.Date AND rq.RideAccepted=1 AND rq.riderUsername=?");

	statement2.setString(1,(String) session.getAttribute("UserName"));
	ResultSet resultSet2 = statement2.executeQuery();
	while (resultSet2.next()) {
		%>
			<tr bgcolor="#56A5EC">
			<td><%=resultSet2.getInt("offerID")%></td>
			<td><%=resultSet2.getInt("requestID")%></td>
			<td><%=resultSet2.getString("time")%></td>
			<td><%=resultSet2.getString("Date")%></td>
			<td><%=resultSet2.getString("FromLot")%></td>
			<td><%=resultSet2.getString("ToLot")%></td>
			<td><%=resultSet2.getString("driverUsername")%></td>
			</tr>			
			
		<%
		}
	%>
</table>
<br>
<br>
<br>
<br>
<br>
<br>
<h2 align="left"><font color="0000FF"><strong>Completed Rides</strong></font></h2>
				<table align="left" cellpadding = "4" cellspacing = "4" border = "4">
				<tr>
				</tr>
				<tr>
				<TH><b>Offer ID</b></th>
				<TH><b>Request ID</b></th>
				<TH><b>Departure Time</b></th>
				<th><b>Date</b></th>
				<th><b>From Lot#</b></th>
				<th><b>To Lot# </b></th>
				<th><b>Driver Username </b></th>
	
				</tr>

	<%
	
	PreparedStatement statement3 = null;
	
	   java.util.Date dNow = new java.util.Date();
	   java.text.SimpleDateFormat ft = new java.text.SimpleDateFormat ("yyyy-MM-dd");
	   ft.format(dNow);	
		
	statement3 = con.prepareStatement("SELECT ro.offerID, rq.requestID,rq.driverUsername,rq.time,rq.date,rq.fromLot,rq.toLot FROM RideRequests rq, RideOffers ro WHERE rq.time<=ro.timeTo AND rq.time>=ro.timeFrom AND rq.date=ro.Date AND rq.RideAccepted=1 AND rq.riderUsername=? AND rq.date<=?");

	statement3.setString(1,(String) session.getAttribute("UserName"));
	statement3.setString(2,ft.toString());

	ResultSet resultSet3 = statement3.executeQuery();
	while (resultSet3.next()) {
		%>
			<tr bgcolor="#56A5EC">
			<td><%=resultSet3.getInt("offerID")%></td>
			<td><%=resultSet3.getInt("requestID")%></td>
			<td><%=resultSet3.getString("time")%></td>
			<td><%=resultSet3.getString("Date")%></td>
			<td><%=resultSet3.getString("FromLot")%></td>
			<td><%=resultSet3.getString("ToLot")%></td>
			<td><%=resultSet3.getString("driverUsername")%></td>
			</tr>			
			
		<%
		}
	con.close();
	%>
	
</table>
<br>
<br>
<br>
<br>
<br>
<br>
<h2 ><font color="0000FF"><strong>Leave Rating</strong></font></h2>
	<form  method="post" action="<%=request.getContextPath()%>/Workers/updateRating.jsp">
	<table>
	<tr>    
	<td>Driver Username:</td><td><input type="text" name="driverUsername"></td><td>*</td>
	</tr>
	<tr>
	<td>Rating (1-5): </td><td>
	<select name="rating" id = "rating" size=1>
		<option selected value = 1>1</option>
		<option value= 2>2</option>
		<option value= 3>3</option>
		<option value= 4>4</option>
		<option value= 5>5</option>
	</select>&nbsp;<br></td><td>*</td>
	</tr>
	</table>
	<input type="submit" value="Rate!">
	</form>
<br>
<br>
<br>
<br>
<br>
<h2 ><font color="0000FF"><strong>LeaderBoard</strong></font></h2>
<form action = "leaderboard.jsp">
<br>
<input type="submit" value="View LeaderBoard" />
<br>
</form>
<br>
<br>
<br>

Report User
<form  method="post" action="<%=request.getContextPath()%>/Workers/sendReport.jsp">
	<table>
	<tr>    
	<td>Username:</td><td><input type="text" name="username"></td><td>*</td>
	</tr>
	</table>
	<input type="submit" value="Report User">
	</form>
	
</body>
</html>