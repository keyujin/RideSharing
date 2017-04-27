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
		try {

			String url = "jdbc:mysql://malcador.canetd0jmani.us-east-2.rds.amazonaws.com:3306/RideShare";
			//Load JDBC driver - the interface standardizing the connection procedure. Look at WEB-INF\lib for a mysql connector jar file, otherwise it fails.
			Class.forName("com.mysql.jdbc.Driver");
			Connection con = DriverManager.getConnection(url, "keyujin", "password");
					
			String user = request.getParameter("username");
			String pass = request.getParameter("password");
			String fullName = request.getParameter("fullName");
			String userType = request.getParameter("userType");
			String email = request.getParameter("email");
			String phoneNumber = request.getParameter("phoneNumber");
			
			//Make an insert statement for the Sells table:
			String insert = "INSERT INTO UserTable(username, password,fullName,userType,email,phoneNumber)"
					+ "VALUES (?,?,?,?,?,?)";
			//Create a Prepared SQL statement allowing you to introduce the parameters of the query
			PreparedStatement ps = con.prepareStatement(insert);

			//Add parameters of the query. Start with 1, the 0-parameter is the INSERT statement itself
			ps.setString(1, user);
			ps.setString(2, pass);
			ps.setString(3, fullName);
			ps.setString(4, userType);
			ps.setString(5, email);
			ps.setString(6, phoneNumber);
			
			ps.executeUpdate();
		//	String userType = request.getParameter("accounttype");
			/*
			//check if user created driver account to be included into the DriverStatistics table
			if (userType.equals("0")) {
				out.print(userType);
				String insertDriver = "INSERT INTO DriverStatistics(Username) VALUES (?)";
				PreparedStatement psDriver = con.prepareStatement(insertDriver);
				psDriver.setString(1, user);
				psDriver.executeUpdate();
			}
			*/
			
			//close the connection
			con.close();
			out.print("insert succeeded");
		} catch (Exception e) {
			out.print("Insert failed");
			%>
			<br>
			<form><INPUT Type="button" VALUE="Try Again" onClick="history.go(-1);return true;"></form>
			<br>
	<% 
		}
	%>
</body>
</html>