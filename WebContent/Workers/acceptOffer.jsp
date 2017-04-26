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
			//close the connectionString sender = (String) session.getAttribute("UserName");
			
			String getReciever = "SELECT r.riderUsername as reciever FROM RideRequests r WHERE r.requestID=?";
			PreparedStatement stmt2 = con.prepareStatement(getReciever);
			stmt2.setString(1,requestID);
			ResultSet result2 = stmt2.executeQuery();
			result2.next();
			String receiver = result2.getString("reciever");
			
			
			
			String subject = "Ride Request : "+requestID+" Accepted by driver "+ driverUsername;
			String message = "Thank you for choosing our service! Your ride request "+requestID+" will be completed by "+driverUsername+". See you then and be sure to leave a comment and rating about your driver";
	
			if(driverUsername.isEmpty() | receiver.isEmpty()){
				con.close();
			}
			
			//Make an insert statement for the Sells table:
			String insert = "INSERT INTO Emails(timeSent, sender, subject, message, receiver)"
					+ "VALUES (?,?,?,?,?)";
			//PreparedStatement deleter = con.prepareStatement("DELETE FROM Emails WHERE sender='admin' ");
			//Create a Prepared SQL statement allowing you to introduce the parameters of the query
			PreparedStatement ps2 = con.prepareStatement(insert);
		
			//Add parameters of the query. Start with 1, the 0-parameter is the INSERT statement itself
			ps2.setTimestamp(1, new Timestamp(System.currentTimeMillis()));
			ps2.setString(2, driverUsername);
			ps2.setString(3, subject);
			ps2.setString(4, message);
			ps2.setString(5, receiver);
			
			ps2.executeUpdate();

			
			
			//close the connection
			con.close();
			response.sendRedirect(request.getContextPath() + "/inbox.jsp");
%>
</body>
</html>