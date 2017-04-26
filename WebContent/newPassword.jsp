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
<% String userId = (String) session.getAttribute("UserName"); %>
<script type = "text/javascript">
function validInput(){
	if(document.getElementById("newPassForm").elements.item(1).value == ""){
		alert ("Please enter your new password.");
		return false;
	}
	if(document.getElementById("newPassForm").elements.item(2).value == ""){
		alert( "Please re-enter your new password.");
		return false;
	}
	if(document.getElementById("newPassForm").elements.item(1).value != document.getElementById("newPassForm").elements.item(2).value){
		alert( "Passwords Don't Match.");
		return false;
	}
	return true;
}
</script>
<font size = "+2">
Please Enter a New Password:
</font>
<font size="+1">
	<form id="newPassForm" onsubmit="return validInput()" method="post" action="Workers/changePassword.jsp">
	<table>
	<tr>
	<td>Username: </td><td><input type="text" name="username" value=<%=userId%> style="height:24px; width:210px" disabled></td>
	</tr>
	<tr> 
	<td>Password: </td><td><input type="text" name="password" style="height:24px; width:210px"></td>
	</tr>
	<tr>
	<td>Re-enter: </td><td><input type="text" name="password2" style="height:24px; width:210px"></td>
	</tr>
	</table>
	<br>
	<input type="submit" value="Submit" style="height:35px; width:300px">
	</form>
</font>
</body>
</html>