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
<% 
String cur_user = (String) session.getAttribute("UserName");
if(cur_user == null){response.sendRedirect(request.getContextPath()); return;}
%>

<table>
<tr>
<td>Logged in as: <%out.print(cur_user);%></td>
<td></td><td></td><td>
<td>	
	<form method="get" action="Workers/dashRedirect.jsp" enctype=text/plain>
 	<input type="submit" value="back to dashboard" style="height:22px; width:150px" >
	</form>
</td>
<td>	
	<form method="get" action="Workers/logout.jsp" enctype=text/plain>
 	<input type="submit" value="logout" style="height:22px; width:70px" >
	</form>
</td>
<td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td>
<td>
<form method="get" action="createMessage.jsp" enctype=text/plain>
<input type="submit" value="Create New Message" style="height:35px; width:190px" >
</form>
</td>
</tr>
</table>
<form method="post" action="Workers/inboxOptions.jsp">
<br>
<table border="5" cellpadding = "10" id="mytab1" style="width:650px">
<tr id = "A1">
	<td> Date/Time Sent </td>
	<td> Sender </td>
	<td> Subject </td>
	<td> Message </td>
	<td> Select </td>
</tr>
<%
try
{
	Class.forName("com.mysql.jdbc.Driver");
	String url="jdbc:mysql://malcador.canetd0jmani.us-east-2.rds.amazonaws.com:3306/RideShare";
	Connection con = DriverManager.getConnection(url, "keyujin", "password");
	String sql = "(SELECT e.timeSent, e.sender, e.subject, CONVERT(e.message, CHAR(20)) AS message FROM Emails e WHERE e.receiver LIKE '" + cur_user + "'ORDER BY e.timeSent DESC)";
	Statement stmt=con.createStatement();
	ResultSet resultSet=stmt.executeQuery(sql);
	Integer i = 0;
	String adInc = "UPDATE Ads SET AdViews = AdViews + 1 WHERE AdName = 'notepad.png'";
	PreparedStatement ad = con.prepareStatement(adInc);
	ad.executeUpdate();
	while(resultSet.next())
	{
%>
		<tr>
			<td><%=resultSet.getTimestamp("timeSent")%></td>
			<td><%=resultSet.getString("sender")%></td>
			<td><%=resultSet.getString("subject") %></td>
			<td><%=resultSet.getString("message")%></td>
			<td><input type="radio" name="id" value= <%=i%> ><br></td>
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
<td>Choose Action: </td>
<td><input type="submit" name="order" value="Expand Message" style="height:25px; width:150px" ></td>
<td><input type="submit" name="order" value="Delete Message" style="height:25px; width:150px" ></td>
</tr>
</table>
<br>
Forward to:
<input type="text" name="newReceiver">
<input type="submit" name="order" value="Forward Message">
</form>
<br/>
<img src="<%=request.getContextPath()%>/images/notepad.png" width="500" height="200"/>
</body>
</html>