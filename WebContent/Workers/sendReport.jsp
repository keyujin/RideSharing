<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>sending report...</title>
</head>
<body>
<%
try {
	String url = "jdbc:mysql://malcador.canetd0jmani.us-east-2.rds.amazonaws.com:3306/RideShare";
	//Load JDBC driver - the interface standardizing the connection procedure. Look at WEB-INF\lib for a mysql connector jar file, otherwise it fails.
	Class.forName("com.mysql.jdbc.Driver");
	Connection con = DriverManager.getConnection(url, "keyujin", "password");
	int access_level = (Integer) session.getAttribute("Access");
	String target = request.getParameter("offender");
	
	
	String str = "SELECT COUNT(Aggressor) AS cnt FROM Reports r WHERE r.Aggressor=?";
	PreparedStatement stmt = con.prepareStatement(str);
	stmt.setString(1,target);
	ResultSet result = stmt.executeQuery();
	result.next();
	int countMatches = result.getInt("cnt");
	
	out.print(countMatches);
	if(countMatches==0){
		String addS = "INSERT INTO Reports(Aggressor,timesReported)"
				+ "VALUES (?,1)";
		//Create a Prepared SQL statement allowing you to introduce the parameters of the query
		PreparedStatement add = con.prepareStatement(addS);
		
		add.setString(1, target);
		
		add.executeUpdate();
		add.close();
		if(access_level == 1){
			response.sendRedirect(request.getContextPath() + "/dashRider.jsp");
			return;
		}else{
			response.sendRedirect(request.getContextPath() + "/dashDriver.jsp");
			return;
		}
		
	}else{
		//Make an insert statement for the Sells table:
		String insert = "UPDATE Reports SET timesReported = timesReported + 1 WHERE Aggressor=?";
		//PreparedStatement deleter = con.prepareStatement("DELETE FROM Emails WHERE sender='admin' ");
		//Create a Prepared SQL statement allowing you to introduce the parameters of the query
		PreparedStatement ps = con.prepareStatement(insert);
		ps.setString(1, target);
		ps.executeUpdate();
		ps.close();
		
		//close the connection
		con.close();
		if(access_level == 1){
			response.sendRedirect(request.getContextPath() + "/dashRider.jsp");
			return;
		}else{
			response.sendRedirect(request.getContextPath() + "/dashDriver.jsp");
			return;
		}
	}
} catch (Exception e) {
	
	int access_level = (Integer) session.getAttribute("Access");

	if(access_level == 1){
		response.sendRedirect(request.getContextPath() + "/dashRider.jsp");
	}else{
		response.sendRedirect(request.getContextPath() + "/dashDriver.jsp");
	}}
%>
</body>
</html>