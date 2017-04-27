<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Create Account</title>
</head>
<body>
Please enter your details below (Required Fields Marked *):
<% String svalid = (String) request.getParameter("order");
if(svalid == null){ svalid = "NOT";}
if(!svalid.equals("Create Support Account*")){
%>
<br>
	<form method="post" action="Workers/makeAccount.jsp">
	<table>
	<tr>    
	<td>New Username:</td><td><input type="text" name="username"></td><td>*</td>
	</tr>
	<tr>
	<td>New Password: </td><td><input type="text" name="password"></td><td>*</td>
	</tr>
	<tr>    
	<td>Full Name: </td><td><input type="text" name="fullName"></td><td>*</td>
	</tr>
	<tr>    
	<td>Email Address: </td><td><input type="text" name="email"></td><td>*</td>
	</tr>
	<tr>    
	<td>Address: </td><td><input type="text" name="address"></td>
	</tr>
	<tr>    
	<td>City: </td><td><input type="text" name="city"></td>
	</tr>
	<tr>    
	<td>Zip Code: </td><td><input type="text" name="zipCode"></td>
	</tr>
	<tr>    
	<td>Phone Number: </td><td><input type="text" name="phoneNumber"></td><td>*</td>
	</tr>
	<tr>
	<td>Account Type: </td><td>
	<select name="userType" id = "userType" size=1>
		<option selected value = "0">Driver</option>
		<option value= "1">Rider</option>
	</select>&nbsp;<br></td><td>*</td>
	</tr>
	</table>
	<br>
	<input type="submit" value="Create Account">
	</form>
<br>
<% }else{	%>
<br>
	<form method="post" action="Workers/makeAccount.jsp">
	<table>
	<tr>    
	<td>Support Username:</td><td><input type="text" name="username"></td><td>*</td>
	</tr>
	<tr>
	<td>Password: </td><td><input type="text" name="password"></td><td>*</td>
	</tr>
	<tr>    
	<td>Full Name: </td><td><input type="text" name="fullName"></td><td>*</td>
	</tr>
	<tr>    
	<td>Email Address: </td><td><input type="text" name="email"></td><td>*</td>
	</tr>
	<tr>    
	<td>Address: </td><td><input type="text" name="address"></td>
	</tr>
	<tr>    
	<td>City: </td><td><input type="text" name="city"></td>
	</tr>
	<tr>    
	<td>Zip Code: </td><td><input type="text" name="zipCode"></td>
	</tr>
	<tr>    
	<td>Phone Number: </td><td><input type="text" name="phoneNumber"></td><td>*</td>
	</tr>
	<tr>
	<td>Account Type: </td><td>
	<select name="userType" id = "userType" size=1 disabled>
		<option selected value = "2">Support</option>
	</select>&nbsp;<br></td><td>*</td>
	</tr>
	</table>
	<br>
	<input type="submit" value="Create Account">
	</form>
<br>

<%
}
%>
</body>
</html>