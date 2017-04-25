<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Account Login</title>
</head>
<body>
Please Input Your Credentials:
<br>
	<form method="post" action="Workers/loginCheck.jsp">
	<table>
	<tr>    
	<td>Username</td><td><input type="text" name="username"></td>
	</tr>
	<tr>
	<td>Password</td><td><input type="password" name="password"></td>
	</tr>
	</table>
	<br>
	<input type="submit" value="Submit">
	</form>
	
<br>

<br>
<form method="get" action="createAccount.jsp" enctype=text/plain>
  <input type="submit" value="Create New Account">
</form>
<form method="get" action="forgotAccount.jsp" enctype=text/plain>
  <input type="submit" value="Forgot Password?">
</form>
<form method="get" action="adminDash.jsp" enctype=text/plain>
  <input type="submit" value="Admin Functions">
</form>
<form method="get" action="leaderboard.jsp" enctype=text/plain>
  <input type="submit" value="Leaderboard">
</form>
<form method="get" action="Workers/sendMessage.jsp" enctype=text/plain>
  <input type="submit" value="tester">
</form>
<form method="get" action="inbox.jsp" enctype=text/plain>
  <input type="submit" value="inbox">
</form>
<br>

</body>
</html>