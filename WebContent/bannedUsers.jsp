<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Banned Users</title>
</head>
<body>
<% 
String cur_user = (String) session.getAttribute("UserName");
if(cur_user == null){ response.sendRedirect(request.getContextPath()); return;}
int access_level = (Integer) session.getAttribute("Access");
if(access_level != 2 && access_level != 3){
	response.sendRedirect(request.getContextPath()); return;
}
%>
<form method="post" action="Workers/modUser.jsp">
<br>
<table cellspacing="1" cellpadding="10" border="5" style="width:600px">
<tr id = "A2">
	<td> Date/Time Banned </td>
	<td> Offender </td>
	<td> Banned By </td>
	<td> Select </td>
</tr>
<%
try
{
	Class.forName("com.mysql.jdbc.Driver");
	String url="jdbc:mysql://malcador.canetd0jmani.us-east-2.rds.amazonaws.com:3306/RideShare";
	Connection con = DriverManager.getConnection(url, "keyujin", "password");
	String sql = "(SELECT * FROM BanList ORDER BY dateBanned ASC)";
	Statement stmt=con.createStatement();
	ResultSet resultSet=stmt.executeQuery(sql);
	Integer i = 0;
	while(resultSet.next())
	{
%>
		<tr>
			<td style="width:200px"><%=resultSet.getTimestamp("dateBanned")%></td>
			<td style="width:170px"><%=resultSet.getString("username")%></td>
			<td style="width:170px"><%=resultSet.getString("bannedBy") %></td>
			<td style="width:60px"><input type="radio" name="id" value= <%=i%> ><br></td>
		</tr>
<%
	i++; }
%>
</table>
<%
	resultSet.close();
	stmt.close();
	con.close();
}
catch(Exception e)
{
	System.out.println("Failed");
	e.printStackTrace();
}
%>
<br>
<table>
<tr>
<td><input type="submit" name="order" value="Undo Ban" style="height:50px; width:295px" ></td>
<td>
<input type="submit" name="order" value="Return to Dashboard" style="height:50px; width:295px" >
</td>
</tr>
</table>
</form>
</body>
</html>