<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>logging you in...</title>
</head>
<body>
<%
try {
	String url = "jdbc:mysql://malcador.canetd0jmani.us-east-2.rds.amazonaws.com:3306/RideShare";
	Class.forName("com.mysql.jdbc.Driver");
	//Create a connection to your DB
	Connection con = DriverManager.getConnection(url, "keyujin", "password");
	String username = request.getParameter("username");
	String password = request.getParameter("password");
	
	String checkBan = "SELECT COUNT(username) AS count FROM BanList b WHERE b.username = ?";
	PreparedStatement cb = con.prepareStatement(checkBan);
	cb.setString(1,username);
	ResultSet bans = cb.executeQuery();
	bans.next();
	int banCount = bans.getInt("count");
	if(banCount == 1){
		System.out.println("error: You are Banned.");
		response.sendRedirect(request.getContextPath());
		return;
	}
	String checkPass = "SELECT COUNT(username) AS count FROM Reset r WHERE r.username = ?";
	PreparedStatement cp = con.prepareStatement(checkPass);
	cp.setString(1,username);
	ResultSet invalids = cp.executeQuery();
	invalids.next();
	int countInvalids = invalids.getInt("count");
	if(countInvalids == 1){
		System.out.println("You need to a new password.");
		session.setAttribute("UserName", username);
		response.sendRedirect(request.getContextPath()+"/newPassword.jsp");
		return;
	}
	//Populate SQL statement with an actual query.
	String str = "SELECT COUNT(Username) AS cnt FROM UserTable u WHERE u.Username = ? AND u.Password = ?";
	PreparedStatement stmt = con.prepareStatement(str);
	stmt.setString(1,username);
	stmt.setString(2,password);
	//Run the query against the DB
	ResultSet result = stmt.executeQuery();
	//Start parsing out the result of the query. Don't forget this statement. It opens up the result set.
	result.next();
	//Parse out the result of the query
	int countMatches = result.getInt("cnt");
	
	String getType = "SELECT u.userType as uType FROM UserTable u WHERE u.Username = ?";
	PreparedStatement stmt2 = con.prepareStatement(getType);
	stmt2.setString(1,username);
	//Run the query against the DB
	ResultSet result2 = stmt2.executeQuery();
	//Start parsing out the result of the query. Don't forget this statement. It opens up the result set.
	result2.next();
	String userType = result2.getString("uType");
	if(countMatches >0){
		session.setAttribute("UserName", username);
		if(userType.equals("0")){
			response.sendRedirect(request.getContextPath()+"/dashDriver.jsp");
			session.setAttribute("Access", 0);
			return;
		}else if(userType.equals("1")){
			response.sendRedirect(request.getContextPath()+"/dashRider.jsp");
			session.setAttribute("Access", 1);
			return;
		}else if(userType.equals("2")){
			response.sendRedirect(request.getContextPath()+"/dashSystem.jsp");
			session.setAttribute("Access", 2);
			return;
		}else if(userType.equals("3")){
			response.sendRedirect(request.getContextPath()+"/dashSystem.jsp");
			session.setAttribute("Access", 3);
			return;
		}else{
			out.print("Login Failed");
			session.invalidate();
			response.sendRedirect(request.getContextPath()+"/login.jsp");
			return;
		}
	}
	//close the connection
	con.close();
	out.print("hi");
	response.sendRedirect(request.getContextPath()+"/login.jsp");
	return;
} catch (Exception e) {
	out.print("Login Failed");
}
response.sendRedirect(request.getContextPath()+"/login.jsp");
%>
</body>
</html>