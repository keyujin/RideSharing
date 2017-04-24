<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
Welcome <%
out.print((String) session.getAttribute("UserName"));
%>
<br>
	<form method="post" action="addRequest.jsp">
	<table>
	<tr>    
	<td>Time</td><td><input type="text" name="time"></td>
	</tr>
	<tr>
	<td>Date</td><td><input type="text" name="date"></td>
	</tr>
	<tr>
	<td>From Lot</td><td><input type="text" name="fromLot#"></td>
	</tr>
	<tr>
	<td>To Lot</td><td><input type="text" name="toLot#"></td>
	</tr>
	</table>
	<input type="submit" value="Add Request">
	</form>
<br>

</body>
</html>