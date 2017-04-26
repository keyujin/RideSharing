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
					
			String ratingString = request.getParameter("rating");
			String driverUsername = request.getParameter("driverUsername");

			int rating = Integer.parseInt(ratingString);
			
			String getCurrentRating = "SELECT u.rating as curRating FROM UserTable u WHERE u.username=?";
			PreparedStatement stmt2 = con.prepareStatement(getCurrentRating);
			stmt2.setString(1,driverUsername);
			ResultSet result2 = stmt2.executeQuery();
			result2.next();
			double curRating = result2.getDouble("curRating");
			
			
			String getNumRatings = "SELECT u.numRatings as numRatings FROM UserTable u WHERE u.username=?";
			PreparedStatement stmt3 = con.prepareStatement(getNumRatings);
			stmt3.setString(1,driverUsername);
			ResultSet result3 = stmt3.executeQuery();
			result3.next();
			int numRatings = result3.getInt("numRatings");
			
			double newRating = (curRating*numRatings+rating)/(numRatings+1);
			numRatings++;
			String update = "UPDATE UserTable Set rating=? , numRatings=? Where username=?";
			//Create a Prepared SQL statement allowing you to introduce the parameters of the query
			PreparedStatement ps = con.prepareStatement(update);
	
			ps.setDouble(1, newRating);
			ps.setInt(2, numRatings);
			ps.setString(3, driverUsername);
			
			//Run the query against the DB
			ps.executeUpdate();
			con.close();
			response.sendRedirect(request.getContextPath() + "/inbox.jsp");
%>
</body>
</html>