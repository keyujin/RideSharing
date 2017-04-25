<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Create Message</title>
</head>
<body>
<%-- Message Box --%>
<form method="post" action="Workers/sendMessage.jsp">
<table>
<tr>
<td>From: </td>
<td><%out.print((String) session.getAttribute("UserName"));%></td>
</tr>
<tr>    
<td>To: </td><td><input type="text" name="username" style="height:16px; width:500px"></td>
</tr>
<tr>
<td>Subject: </td><td><input type="text" name="subject"style=" height:16px; width:500px"></td>
</tr>
<tr>
<td>Message: </td>
</tr>
</table>
<table>
<tr>
<td><textarea name="paragraph_text" cols="68" rows="10"></textarea></td>
</tr>
</table>
<br>
<input type="submit" value="Send" style="height:25px; width:150px">
</form>
<br/>
<%-- Return to Inbox --%>
<form method="get" action="inbox.jsp" enctype=text/plain>
  <input type="submit" value="Return to Inbox" style="height:25px; width:150px" >
</form>
</body>
</html>