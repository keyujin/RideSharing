<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Statistics</title>
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
<font size="+3">
Ride Statistics
</font>
<font size="+0">
<% 
	Calendar cal = Calendar.getInstance();
	out.println(" | viewing as: " + cur_user + " | access level: " + access_level);
   java.util.Date date = new java.util.Date();
   out.print( "<h2 align=\"left\">Current Time: " +date.toString()+"</h2>");
   cal.add(Calendar.DATE, -5);
   out.println("30 days ago: " + cal.getTime());
   cal.add(Calendar.HOUR, -6);
   out.println("6 Hours ago: " + cal.getTime());
   cal.add(Calendar.HOUR, +3);
   out.println("+3 Hours: " + cal.getTime());
   
%>
<br>
<table>
	<tr>
		<td> Year </td>
		<td> Semester </td>
		<td> Month </td>
		<td> Week </td>
		<td> Today </td>
		<td> Last 6 Hours </td>
	</tr>
	<%
	try{
		Class.forName("com.mysql.jdbc.Driver");
		String url="jdbc:mysql://malcador.canetd0jmani.us-east-2.rds.amazonaws.com:3306/RideShare";
		Connection con = DriverManager.getConnection(url, "keyujin", "password");
		String yearSQL = "SELECT COUNT(*) FROM RideOffers";
		String semSQL = "";
		String moSQL = "";
		String weekSQL = "";
		String daySQL = "";
		String sixSQL = "";
		
		
	}catch(Exception e){
		
	}
	
	

	%>
</table>
</font>
</body>
</html>