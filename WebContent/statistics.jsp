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
	out.println(" | viewing as: " + cur_user + " | access level: " + access_level);
	java.util.Date date = new java.util.Date();
	out.print( "<h2 align=\"left\">Current Time: " +date.toString()+"</h2>");
	
	java.text.SimpleDateFormat dateF = new java.text.SimpleDateFormat("yyyy-MM-dd");
	java.text.SimpleDateFormat timeF = new java.text.SimpleDateFormat("HH:mm:ss");
	Calendar cal = Calendar.getInstance();
	Calendar cur_cal = Calendar.getInstance();
	
	
	/*
   	cal.add(Calendar.DATE, -5);
   	out.println("30 days ago: " + cal.getTime());
   	cal.add(Calendar.HOUR, -6);
   	out.println("6 Hours ago: " + cal.getTime());
   	cal.add(Calendar.HOUR, +3);
   	out.println("+3 Hours: " + cal.getTime());
   	java.text.SimpleDateFormat ft = new java.text.SimpleDateFormat ("yyyy-MM-dd");
   	System.out.println("test: " + ft.format(cal.getTime()));
   	*/
   	System.out.println("test2:" + timeF.format(cal.getTime()));
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
		String SQL = "SELECT COUNT(*) AS count FROM RideOffers WHERE date >= ? AND date <= ?";
		PreparedStatement ps = null;
		ps = con.prepareStatement(SQL);
		
		//last year
		cal.add(Calendar.YEAR, -1);
		ps.setString(1, dateF.format(cal.getTime()));
		ps.setString(2, dateF.format(cur_cal.getTime()));
		System.out.println("Query: " + ps);
		ResultSet rs1 = ps.executeQuery();
		rs1.next();
		int yCount = rs1.getInt("count");
		
		//last semester
		cal.add(Calendar.YEAR,1);
		cal.add(Calendar.MONTH,-5);
		ps.setString(1, dateF.format(cal.getTime()));
		ps.setString(2, dateF.format(cur_cal.getTime()));
		System.out.println("Query: " + ps);
		ResultSet rs2 = ps.executeQuery();
		rs2.next();
		int sCount = rs2.getInt("count");
		
		//last month
		cal.add(Calendar.MONTH,5);
		cal.add(Calendar.MONTH,-1);
		ps.setString(1, dateF.format(cal.getTime()));
		ps.setString(2, dateF.format(cur_cal.getTime()));
		System.out.println("Query: " + ps);
		ResultSet rs3 = ps.executeQuery();
		rs3.next();
		int mCount = rs3.getInt("count");
		
		//last week
		cal.add(Calendar.MONTH,1);
		cal.add(Calendar.DATE, -7);
		ps.setString(1, dateF.format(cal.getTime()));
		ps.setString(2, dateF.format(cur_cal.getTime()));
		System.out.println("Query: " + ps);
		ResultSet rs4 = ps.executeQuery();
		rs4.next();
		int wCount = rs4.getInt("count");
		
		
		
		SQL = "SELECT COUNT(*) AS COUNT FROM RideOffers WHERE date >= ? AND timeTo >= ? AND date <= ? AND timeTo <= ?";
		ps = null;
		ps = con.prepareStatement(SQL);
		
		//last 24 hours
		cal.add(Calendar.DATE, +7);
		cal.add(Calendar.HOUR_OF_DAY, -24);
		ps.setString(1, dateF.format(cal.getTime()));
		ps.setString(2, timeF.format(cal.getTime()));
		ps.setString(3, dateF.format(cur_cal.getTime()));
		ps.setString(4, timeF.format(cur_cal.getTime()));
		System.out.println("Query: " + ps);
		ResultSet rs5 = ps.executeQuery();
		rs5.next();
		int dCount = rs5.getInt("count");
		
		//last 6 hours (time of day)
		cal.add(Calendar.HOUR_OF_DAY, +24);
		cal.add(Calendar.HOUR_OF_DAY, -6);
		ps.setString(1, dateF.format(cal.getTime()));
		ps.setString(2, timeF.format(cal.getTime()));
		ps.setString(3, dateF.format(cur_cal.getTime()));
		ps.setString(4, timeF.format(cur_cal.getTime()));
		System.out.println("Query: " + ps);
		ResultSet rs6 = ps.executeQuery();
		rs6.next();
		int tCount = rs6.getInt("count");
		%>
		<tr>
			<td><%=yCount%> </td>
			<td><%=sCount%></td>
			<td><%=mCount%></td>
			<td><%=wCount%></td>
			<td><%=dCount%></td>
			<td><%=tCount%></td>
		</tr>
		<%
		
	}catch(Exception e){
		
	}
	
	

	%>
</table>
</font>
</body>
</html>