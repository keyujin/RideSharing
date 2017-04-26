<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>New Password</title>
</head>
<body>
<font size = "+2">
Please Enter a New Password:
</font>
<br>
<br>
	<font size="+1">
	<form method="post" action="Workers/loginCheck.jsp">
	<table>
	<tr>    
	<td>Password</td><td><input type="text" name="username" style="height:24px; width:200px"></td>
	</tr>
	<tr>
	<td>Re-enter</td><td><input type="password" name="password" style="height:24px; width:200px"></td>
	</tr>
	</table>
	<br>
	<input type="submit" value="Submit" style="height:35px; width:300px">
	</form>
	</font>
<br>
<form method="get" action="createAccount.jsp" enctype=text/plain>
  <input type="submit" value="Create New Account" style="height:35px; width:300px">
</form>
<br>
<form method="get" action="forgotAccount.jsp" enctype=text/plain>
  <input type="submit" value="Forgot Password?" style="height:35px; width:300px">
</form>
</body>
</html>