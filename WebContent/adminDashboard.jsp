<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Administrator Dashboard</title>
</head>
<body>
<form method="post">

<table border="5">
   <tr>
        <td>Username</td>
        <td>Fullname</td>
        <td>User Type</td>
        <td>Email</td>
        <td>Rides Given</td>
        <td>Rides Taken</td>
   </tr>
   <%
   try
   {
       Class.forName("com.mysql.jdbc.Driver");
       String url="jdbc:mysql://malcador.canetd0jmani.us-east-2.rds.amazonaws.com:3306/RideShare";
		Connection con = DriverManager.getConnection(url, "keyujin", "password");
		String sql = "SELECT u.username, u.fullName, u.userType, u.email, u.ridesGiven, u.ridesTaken FROM UserTable u";
       Statement stmt=con.createStatement();
       ResultSet resultSet=stmt.executeQuery(sql);
       while(resultSet.next())
       {
   %>
           <tr>
				<td><%=resultSet.getString("username")%></td>
				<td><%=resultSet.getString("fullName")%></td>
				<td><%=resultSet.getString("userType")%></td>
				<td><%=resultSet.getString("email")%></td>
				<td><%=resultSet.getInt("ridesGiven") %></td>
				<td><%=resultSet.getInt("ridesTaken") %></td>
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
</body>
</html>