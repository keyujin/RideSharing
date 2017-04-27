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
<script type = "text/javascript">
function validInput(){
	if(document.getElementById("loginForm").elements.item(0).value == ""){
		alert ("Please enter your username.");
		return false;
	}
	if(document.getElementById("loginForm").elements.item(1).value == ""){
		alert( "Please enter your password.");
		return false;
	}
	return true;
}
</script>
<table><tr><td>
<a href="https://www.reddit.com/r/Overwatch/"><img src="<%=request.getContextPath()%>/images/ow1.jpg" width="290" height="121"/></a>
<%
String url = "jdbc:mysql://malcador.canetd0jmani.us-east-2.rds.amazonaws.com:3306/RideShare";
//Load JDBC driver - the interface standardizing the connection procedure. Look at WEB-INF\lib for a mysql connector jar file, otherwise it fails.
Class.forName("com.mysql.jdbc.Driver");
Connection con = DriverManager.getConnection(url, "keyujin", "password");
String adInc = "UPDATE Ads SET AdViews = AdViews + 1 WHERE AdName = 'ow1.jpg'";
PreparedStatement ad = con.prepareStatement(adInc);
ad.executeUpdate();
con.close();
%>

</td></tr></table>
<font size = "+2">


Please Input Your Credentials:
</font>
<br>
<br>
<font size="+1">
<form id="loginForm" method="post" onsubmit="return validInput();" action="Workers/loginCheck.jsp">
<table>
<tr>    
<td>Username</td><td><input type="text" name="username" style="height:24px; width:200px"></td>
</tr>
<tr>
<td>Password</td><td><input type="password" name="password" style="height:24px; width:200px"></td>
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