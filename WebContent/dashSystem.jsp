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
if(cur_user == null){ response.sendRedirect(request.getContextPath()); return;}
int access_level = (Integer) session.getAttribute("Access");
if(access_level != 2 && access_level != 3){
	response.sendRedirect(request.getContextPath()); return;
}
%>
<script type = "text/javascript">
function checkAccess(){
	if(<%=access_level%> != 3){
		alert ("Did you ever hear the tragedy of Darth" + " <%=cur_user%> " + "the Wise?");
		return false;
	}
	return true;
}
</script>
<font size="+3">
Administrator / Support Console
</font>
<font size="+0">
(* - administrator only) 
<% out.println(" | currently logged in as: " + cur_user + " | access level: " + access_level); %>
</font>
<br>
<form method="post" action="Workers/modUser.jsp">
<div style="width:1015px; height:400px; overflow:auto;">
<table cellspacing="0" cellpadding="1" border="1" style="width:990px">
   <tr>
   		<td>Type</td>
        <td>Username</td>
        <td>Fullname</td>
        <td>Email</td>
        <td>Phone Number</td>
        <td># Rides</td>
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
           		<td style="width:60px"><%=resultSet.getString("userType")%></td>
				<td><%=resultSet.getString("username")%></td>
				<td><%=resultSet.getString("fullName")%></td>
				<td><%=resultSet.getString("email")%></td>
				<td><%=resultSet.getString("phoneNumber")%></td>
				<td style="width:60px"><%=resultSet.getInt("ridesGiven") + resultSet.getInt("ridesTaken")%></td>
				<td><input type="radio" name="id" value= <%=i%> ></td>
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
<td><input type="submit" name="order" value="Manual Ban" style="height:50px; width:512px"></td>
<td><input type="submit" name="order" value="Reset Password" style="height:50px; width:512px"></td>
<tr>
</table>
</form>
<table>
<tr>
<td>
<form method="get" action="bannedUsers.jsp" enctype=text/plain>
<input type="submit" value="View Banned Users" style="height:50px; width:254px" >
</form>
</td>
<td><input type="submit" name="order" value="View Statistics" style="height:50px; width:254px"></td>
<td><input type="submit" name="order" value="View Advertisements" style="height:50px; width:254px" ></td>
<td>
<form method="get" action="inbox.jsp" enctype=text/plain>
<input type="submit" value="Inbox" style="height:50px; width:254px" >
</form>
</td>
</tr>
<tr>
<td>
<form method="get" onsubmit="return checkAccess();" action="inbox.jsp" enctype=text/plain>
<input type="submit" value="Create Support Account*" style="height:50px; width:254px" >
</form>
</td>
<td>
<form method="get" onsubmit="return checkAccess();" action="inbox.jsp" enctype=text/plain>
<input type="submit" value="Run Queries*" style="height:50px; width:254px" >
</form>
</td>
<td>
<form method="get" onsubmit="return checkAccess();" action="inbox.jsp" enctype=text/plain>
<input type="submit" value="Emergency Maintenance*" style="height:50px; width:254px" >
</form>
</td>
<td>
<form method="get" action="Workers/logout.jsp" enctype=text/plain>
<input type="submit" value="Logout" style="height:50px; width:254px" >
</form>
</td>
</table>
</body>
</html>