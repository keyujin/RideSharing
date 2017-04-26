<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>making account...</title>
</head>
<body>
	<%
	
	
			String url = "jdbc:mysql://malcador.canetd0jmani.us-east-2.rds.amazonaws.com:3306/RideShare";
			//Load JDBC driver - the interface standardizing the connection procedure. Look at WEB-INF\lib for a mysql connector jar file, otherwise it fails.
			Class.forName("com.mysql.jdbc.Driver");
			Connection con = DriverManager.getConnection(url, "keyujin", "password");
					
			String requestID = request.getParameter("requestID");
			String driverUsername = (String)session.getAttribute("UserName");

	
			
		
			String update = "UPDATE RideRequests Set rideAccepted='1' , driverUsername=? Where requestID=?";
			//Create a Prepared SQL statement allowing you to introduce the parameters of the query
			PreparedStatement ps = con.prepareStatement(update);
	
			//Add parameters of the query. Start with 1, the 0-parameter is the INSERT statement itself
			ps.setString(1, driverUsername);
			ps.setString(2, requestID);
			
	
			//Run the query against the DB
			ps.executeUpdate();
			//close the connection
			con.close();
			response.sendRedirect(request.getContextPath()+"/dashDriver.jsp");

%>
</body>
</html>