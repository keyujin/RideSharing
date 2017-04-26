<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>doing work...</title>
</head>
<body>
<%-- Get Current User and Request --%>
<% 	
String cur_user = (String) session.getAttribute("UserName");
String order = request.getParameter("order");
//out.print(order);
String id = request.getParameter("id");
if(id == null){
	response.sendRedirect(request.getContextPath());
}
int num = Integer.parseInt(id);
%>
<%-- Get Values --%>
<%
Timestamp timeSent = null;
String sender = null;
String subject = null;
String message = null;
String newReceiver = request.getParameter("newReceiver");

try
{
	Class.forName("com.mysql.jdbc.Driver");
	String url="jdbc:mysql://malcador.canetd0jmani.us-east-2.rds.amazonaws.com:3306/RideShare";
	Connection con = DriverManager.getConnection(url, "keyujin", "password");
	String sql = "SELECT e.timeSent, e.sender, e.subject, e.message FROM Emails e WHERE e.receiver LIKE '" + cur_user + "'ORDER BY e.timeSent DESC";
	Statement stmt=con.createStatement();
	ResultSet resultSet=stmt.executeQuery(sql);
	Integer i = 0;
	while(resultSet.next())
	{
		if(i == num){
			timeSent = resultSet.getTimestamp("timeSent");
			sender = resultSet.getString("sender");
			subject = resultSet.getString("subject");
			message =resultSet.getString("message");
			break;
		}
		i++; 
	}
	resultSet.close();
	stmt.close();
	con.close();
}
catch(Exception e)
{
	response.sendRedirect(request.getContextPath()+"/inbox.jsp");
}
%>
<%-- Perform Request --%>
<%
if(new String("Expand Message").equals(order)){
	%>
		FROM: <%=sender%>
		<br>
		SUBJECT: <%=subject%>
		<br>
		<br>
		<textarea name="paragraph_text" cols="50" rows="10" readonly hard><%=message%></textarea>
		<br>
		<br>
		<form method="get" action="<%=request.getContextPath()%>/inbox.jsp" enctype=text/plain>
  		<input type="submit" value="Return to Inbox" style="height:22px; width:70px" >
		</form>
	<%
}else if(new String("Delete Message").equals(order)){
		try{
			Class.forName("com.mysql.jdbc.Driver");
			String url="jdbc:mysql://malcador.canetd0jmani.us-east-2.rds.amazonaws.com:3306/RideShare";
			Connection con = DriverManager.getConnection(url, "keyujin", "password");
			PreparedStatement ps = con.prepareStatement(
					"DELETE FROM Emails WHERE sender LIKE '" + sender
					+ "' AND timeSent='" + timeSent + "'"
					);
			ps.executeUpdate();
			con.close();
			response.sendRedirect(request.getContextPath()+"/inbox.jsp");
		}catch(Exception e){
			response.sendRedirect(request.getContextPath()+"/inbox.jsp");
		}
}else if(new String("Forward Message").equals(order)){
	try{
		Class.forName("com.mysql.jdbc.Driver");
		String url="jdbc:mysql://malcador.canetd0jmani.us-east-2.rds.amazonaws.com:3306/RideShare";
		Connection con = DriverManager.getConnection(url, "keyujin", "password");
		if(sender.isEmpty() | newReceiver.isEmpty()){ out.println("hi"); con.close(); }
		String insert = "INSERT INTO Emails(timeSent, sender, subject, message, receiver)"
				+ "VALUES (?,?,?,?,?)";
		PreparedStatement ps = con.prepareStatement(insert);
		ps.setTimestamp(1,new Timestamp(System.currentTimeMillis()));
		ps.setString(2,cur_user);
		ps.setString(3, "SENT_EMAIL " + subject);
		ps.setString(4, "FROM: " + sender + " ["+ message + "]");
		ps.setString(5, newReceiver);		
		ps.executeUpdate();
		con.close();
		response.sendRedirect(request.getContextPath()+"/inbox.jsp");
	}catch(Exception e){
		out.println("hi");
		response.sendRedirect(request.getContextPath()+"/inbox.jsp");
	}
}else{
	out.print("CRITICAL ERROR");
}

%>
</body>
</html>