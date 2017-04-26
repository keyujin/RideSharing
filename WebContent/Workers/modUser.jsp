<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>doing mod stuff...</title>
</head>
<body>
<%-- Get Current User and Request --%>
<% 
String cur_user = (String) session.getAttribute("UserName");
String order = (String) request.getParameter("order");
if(new String("Return to Dashboard").equals(order)){
	response.sendRedirect(request.getContextPath() + "/dashSystem.jsp"); return;
}
String id = request.getParameter("id");
if(id == null){ response.sendRedirect(request.getContextPath() + "/dashSystem.jsp");  return; }
int num = Integer.parseInt(id);
%>

<%-- Get Values --%>
<%
Timestamp timeSent = new Timestamp(System.currentTimeMillis());
String target = null;

try
{
	Class.forName("com.mysql.jdbc.Driver");
	String url="jdbc:mysql://malcador.canetd0jmani.us-east-2.rds.amazonaws.com:3306/RideShare";
	Connection con = DriverManager.getConnection(url, "keyujin", "password");
	String sql = "SELECT u.username FROM UserTable u ORDER BY u.username ASC";
	Statement stmt=con.createStatement();
	ResultSet resultSet=stmt.executeQuery(sql);
	Integer i = 0;
	while(resultSet.next())
	{
		if(i == num){
			target = resultSet.getString("username");
			break;
		}
		i++; 
	}
	resultSet.close();
	stmt.close();
	con.close();
	if(target == null){ response.sendRedirect(request.getContextPath()+"/dashSystem.jsp"); return; }
}
catch(Exception e)
{
	response.sendRedirect(request.getContextPath()+"/dashSystem.jsp");
}
%>
<%-- Perform Request --%>
<%
if(new String("Manual Ban").equals(order)){
	try
	{
		Class.forName("com.mysql.jdbc.Driver");
		String url="jdbc:mysql://malcador.canetd0jmani.us-east-2.rds.amazonaws.com:3306/RideShare";
		Connection con = DriverManager.getConnection(url, "keyujin", "password");
		String sql = "SELECT COUNT(username) AS count FROM BanList b WHERE b.username = ?";
		PreparedStatement stmt = con.prepareStatement(sql);
		stmt.setString(1,target);
		ResultSet result = stmt.executeQuery();
		result.next();
		int countMatches = result.getInt("count");
		if(countMatches == 1){
			System.out.println("error: target already banned");
			response.sendRedirect(request.getContextPath()+"/dashSystem.jsp");
			return;
		}
		stmt.close();
		con.close();
	}
	catch(Exception e)
	{
		response.sendRedirect(request.getContextPath()+"/inbox.jsp");
	}
	try {
		String url = "jdbc:mysql://malcador.canetd0jmani.us-east-2.rds.amazonaws.com:3306/RideShare";
		//Load JDBC driver - the interface standardizing the connection procedure. Look at WEB-INF\lib for a mysql connector jar file, otherwise it fails.
		Class.forName("com.mysql.jdbc.Driver");
		Connection con = DriverManager.getConnection(url, "keyujin", "password");
		
		//Make an insert statement for the Sells table:
		String insert = "INSERT INTO BanList(username, dateBanned, bannedBy)"
				+ "VALUES (?,?,?)";
		//Create a Prepared SQL statement allowing you to introduce the parameters of the query
		PreparedStatement ps = con.prepareStatement(insert);

		//Add parameters of the query. Start with 1, the 0-parameter is the INSERT statement itself
		ps.setString(1, target);
		ps.setTimestamp(2, timeSent);
		ps.setString(3, cur_user);
		System.out.println(ps);
		ps.executeUpdate();
		//close the connection
		ps.close();
		con.close();
		response.sendRedirect(request.getContextPath()+"/bannedUsers.jsp");
	} catch (Exception e) {
		response.sendRedirect(request.getContextPath()+"/dashSystem.jsp");
	}
}else if(new String("Reset Password").equals(order)){
	try {
		String url = "jdbc:mysql://malcador.canetd0jmani.us-east-2.rds.amazonaws.com:3306/RideShare";
		//Load JDBC driver - the interface standardizing the connection procedure. Look at WEB-INF\lib for a mysql connector jar file, otherwise it fails.
		Class.forName("com.mysql.jdbc.Driver");
		Connection con = DriverManager.getConnection(url, "keyujin", "password");
		
		//Make an insert statement for the Sells table:
		String insert = "INSERT INTO Reset(username, resetBy)"
				+ "VALUES (?,?)";
		//Create a Prepared SQL statement allowing you to introduce the parameters of the query
		PreparedStatement ps = con.prepareStatement(insert);
		//Add parameters of the query. Start with 1, the 0-parameter is the INSERT statement itself
		ps.setString(1, target);
		ps.setString(2, cur_user);
		ps.executeUpdate();
		//close the connection
		ps.close();
		con.close();
		response.sendRedirect(request.getContextPath()+"/dashSystem.jsp");
	} catch (Exception e) {
		response.sendRedirect(request.getContextPath()+"/dashSystem.jsp");
	}
}else if(new String("Undo Ban").equals(order)){
	try
	{
		Class.forName("com.mysql.jdbc.Driver");
		String url="jdbc:mysql://malcador.canetd0jmani.us-east-2.rds.amazonaws.com:3306/RideShare";
		Connection con = DriverManager.getConnection(url, "keyujin", "password");
		String sql = "SELECT username FROM BanList ORDER BY dateBanned ASC";
		Statement stmt=con.createStatement();
		ResultSet resultSet=stmt.executeQuery(sql);
		Integer i = 0;
		while(resultSet.next())
		{
			if(i == num){
				target = resultSet.getString("username");
				break;
			}
			i++; 
		}
		resultSet.close();
		stmt.close();
		con.close();
		if(target == null){ response.sendRedirect(request.getContextPath()+"/dashSystem.jsp"); return; }
	}
	catch(Exception e)
	{
		response.sendRedirect(request.getContextPath()+"/dashSystem.jsp");
	}
	try{
		Class.forName("com.mysql.jdbc.Driver");
		String url="jdbc:mysql://malcador.canetd0jmani.us-east-2.rds.amazonaws.com:3306/RideShare";
		Connection con = DriverManager.getConnection(url, "keyujin", "password");
		PreparedStatement ps = con.prepareStatement("DELETE FROM BanList  WHERE username LIKE ?");
		ps.setString(1,target);
		ps.executeUpdate();
		con.close();
		response.sendRedirect(request.getContextPath()+"/bannedUsers.jsp");
	}catch(Exception e){
		response.sendRedirect(request.getContextPath()+"/bannedUsers.jsp");
	}
}else{
	out.print("CRITICAL ERROR");
}
%>
</body>
</html>