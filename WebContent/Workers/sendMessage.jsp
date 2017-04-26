<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>sending message...</title>
</head>
<body>
<%
try {
	String url = "jdbc:mysql://malcador.canetd0jmani.us-east-2.rds.amazonaws.com:3306/RideShare";
	//Load JDBC driver - the interface standardizing the connection procedure. Look at WEB-INF\lib for a mysql connector jar file, otherwise it fails.
	Class.forName("com.mysql.jdbc.Driver");
	Connection con = DriverManager.getConnection(url, "keyujin", "password");
	
	String sender = (String) session.getAttribute("UserName");
	String receiver = request.getParameter("username");
	String subject = request.getParameter("subject");
	String message = request.getParameter("paragraph_text");
	
	if(sender.isEmpty() | receiver.isEmpty()){
		con.close();
	}
	
	//Make an insert statement for the Sells table:
	String insert = "INSERT INTO Emails(timeSent, sender, subject, message, receiver)"
			+ "VALUES (?,?,?,?,?)";
	//PreparedStatement deleter = con.prepareStatement("DELETE FROM Emails WHERE sender='admin' ");
	//Create a Prepared SQL statement allowing you to introduce the parameters of the query
	PreparedStatement ps = con.prepareStatement(insert);

	//Add parameters of the query. Start with 1, the 0-parameter is the INSERT statement itself
	ps.setTimestamp(1, new Timestamp(System.currentTimeMillis()));
	ps.setString(2, sender);
	ps.setString(3, subject);
	ps.setString(4, message);
	ps.setString(5, receiver);
	
	ps.close();
	ps.executeUpdate();
	//deleter.executeUpdate();
	
	//close the connection
	con.close();
	response.sendRedirect(request.getContextPath() + "/inbox.jsp");
} catch (Exception e) {
	response.sendRedirect(request.getContextPath() + "/createMessage.jsp");
}
%>
</body>
</html>