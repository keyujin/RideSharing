<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Inbox</title>
</head>
<body>
Welcome <%out.print((String) session.getAttribute("UserName"));%> !
<br>
<br/>
<br>
<form method="post">
<table border="5" cellpadding = "10">
<tr>
	<td> Time Sent </td>
	<td> Sender </td>
	<td> Message </td>
</tr>
<%
try
{
	Class.forName("com.mysql.jdbc.Driver");
	String url="jdbc:mysql://malcador.canetd0jmani.us-east-2.rds.amazonaws.com:3306/RideShare";
	Connection con = DriverManager.getConnection(url, "keyujin", "password");
	String sql = "SELECT * FROM Emails e";
	Statement stmt=con.createStatement();
	ResultSet resultSet=stmt.executeQuery(sql);
	while(resultSet.next())
	{
%>
		<tr>
			<td><%=resultSet.getString("timeSent")%></td>
			<td><%=resultSet.getString("sender")%></td>
			<td><%=resultSet.getString("message")%></td>
		</tr>
<%
	}
%>
</table>
<%
	resultSet.close();
	stmt.close();
	con.close();
}
catch(Exception e)
{
	e.printStackTrace();
}
%>
</form>
<br/>
<form method="get" action="createMessage.jsp" enctype=text/plain>
  <input type="submit" value="Create Message" style="height:25px; width:150px" >
</form>
</body>
</html>