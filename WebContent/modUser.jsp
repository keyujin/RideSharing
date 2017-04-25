<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<form method="post" action="Workers/modUserOptions.jsp">
<div style="width:800px; height:400px; overflow:auto;">
<table cellspacing="0" cellpadding="1" border="1" style="width:780px">
   <tr>
   		<td>User Type</td>
        <td>Username</td>
        <td>Fullname</td>
        <td>Email</td>
        <td>Phone Number</td>
        <td>Rides Given/Taken</td>
        <td> Select </td>
   </tr>
   <%
   try
   {
       Class.forName("com.mysql.jdbc.Driver");
       String url="jdbc:mysql://malcador.canetd0jmani.us-east-2.rds.amazonaws.com:3306/RideShare";
       Connection con = DriverManager.getConnection(url, "keyujin", "password");
       String sql = "SELECT u.userType, u.username, u.fullName, u.email, u.phoneNumber, u.ridesGiven, u.ridesTaken FROM UserTable u ORDER BY u.username ASC";
       Statement stmt=con.createStatement();
       ResultSet resultSet=stmt.executeQuery(sql);
       Integer i = 0;
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
				<td><input type="radio" name="id" value= <%=i%> ><br></td>
				</tr>
   			<%
   			i++;
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
</div>
<table>
<tr>
<td>Choose Action: </td>
<td><input type="submit" name="order" value="Ban" style="height:25px; width:150px" ></td>
<td><input type="submit" name="order" value="Reset Password" style="height:25px; width:150px" ></td>
</tr>
</table>
</form>
</body>
</html>