<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Systems Dashboard</title>
</head>
<body>
<% 
String cur_user = (String) session.getAttribute("UserName");
if(cur_user == null){response.sendRedirect(request.getContextPath());}
%>
<form method="post">
<table border="5" style="width:1015px">
   <tr>
   		<td>User Type</td>
        <td>Username</td>
        <td>Fullname</td>
        <td>Email</td>
        <td>Phone Number</td>
        <td>Rides Given/Taken</td>
   </tr>
   <%
   try
   {
       Class.forName("com.mysql.jdbc.Driver");
       String url="jdbc:mysql://malcador.canetd0jmani.us-east-2.rds.amazonaws.com:3306/RideShare";
       Connection con = DriverManager.getConnection(url, "keyujin", "password");
       String sql = "SELECT u.userType, u.username, u.fullName, u.email, u.phoneNumber, u.ridesGiven, u.ridesTaken FROM UserTable u ORDER BY u.username ASC LIMIT 10";
       Statement stmt=con.createStatement();
       ResultSet resultSet=stmt.executeQuery(sql);
       while(resultSet.next())
       {
       		%>
           		<tr>
           		<td><%=resultSet.getString("userType")%></td>
				<td><%=resultSet.getString("username")%></td>
				<td><%=resultSet.getString("fullName")%></td>
				<td><%=resultSet.getString("email")%></td>
				<td><%=resultSet.getString("phoneNumber")%></td>
				<td><%=resultSet.getInt("ridesGiven") + resultSet.getInt("ridesTaken")%></td>
				</tr>
   			<%
       }
   		resultSet.close();
        stmt.close();
        con.close();
   }
   catch(Exception e){
        e.printStackTrace();
   }
   %>
</table>
</form>
<table>
<tr>
<td>
<form method="get" action="modUser.jsp" enctype=text/plain>
<input type="submit" value="View All Users" style="height:50px; width:250px" >
</form>
</td>
<td><input type="submit" name="order" value="View Statistics" style="height:50px; width:250px"></td>
<td><input type="submit" name="order" value="View Advertisements" style="height:50px; width:250px" ></td>
<td>
<form method="get" action="inbox.jsp" enctype=text/plain>
<input type="submit" value="Inbox" style="height:50px; width:250px" >
</form>
</td>
</tr>
<tr>
<td><input type="submit" name="order" value="Create Support Account*" style="height:50px; width:250px"></td>
<td><input type="submit" name="order" value="Run Queries*" style="height:50px; width:250px" ></td>
<td><input type="submit" name="order" value="Emergency Maintenance*" style="height:50px; width:250px" ></td>
<td>
<form method="get" action="Workers/logout.jsp" enctype=text/plain>
<input type="submit" value="Logout" style="height:50px; width:250px" >
</form>
</td>
</table>
</body>
</html>