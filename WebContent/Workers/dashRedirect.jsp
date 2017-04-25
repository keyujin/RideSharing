<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>redirecting...</title>
</head>
<body>
<%
try{
	String url = "jdbc:mysql://malcador.canetd0jmani.us-east-2.rds.amazonaws.com:3306/RideShare";
	Class.forName("com.mysql.jdbc.Driver");
	
	//Create a connection to your DB
	Connection con = DriverManager.getConnection(url, "keyujin", "password");
	String username = (String) session.getAttribute("UserName");
	
	String str = "SELECT u.userType FROM UserTable u WHERE u.username = ?";
	String check = "SELECT COUNT(u.userType) AS count FROM UserTable u WHERE u.username = ?";
	PreparedStatement ps = con.prepareStatement(str);
	PreparedStatement checker = con.prepareStatement(check);
	ps.setString(1,username);
	checker.setString(1,username);
	ResultSet num = checker.executeQuery();
	ResultSet id = ps.executeQuery();
	num.next(); 
	id.next();
	int countMatches = num.getInt("count");
	System.out.println(countMatches + "test" + id);
	if(countMatches != 1){
		System.out.println("Failure (error code: 01)");
		session.invalidate();
		response.sendRedirect(request.getContextPath()+"/login.jsp");
	}
	String userType = id.getString("userType");
	if(userType.equals("0")){
		response.sendRedirect(request.getContextPath()+"/dashDriver.jsp");
	}else if(userType.equals("1")){
		response.sendRedirect(request.getContextPath()+"/dashRider.jsp");
	}else if(userType.equals("2")){
		response.sendRedirect(request.getContextPath()+"/dashSystem.jsp");
	}else if(userType.equals("3")){
		response.sendRedirect(request.getContextPath()+"/dashSystem.jsp");
	}else{
		System.out.println("Failure (error code: 02)");
		session.invalidate();
		response.sendRedirect(request.getContextPath()+"/login.jsp");
	}
	con.close();
}catch(Exception e){
	System.out.println("Failure (error code: 03)");
	session.invalidate();
	response.sendRedirect(request.getContextPath()+"/login.jsp");
}
%>
</body>
</html>