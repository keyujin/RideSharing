<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<%
		try {

			String url = "jdbc:mysql://malcador.canetd0jmani.us-east-2.rds.amazonaws.com:3306/RideShare";
			//Load JDBC driver - the interface standardizing the connection procedure. Look at WEB-INF\lib for a mysql connector jar file, otherwise it fails.
			Class.forName("com.mysql.jdbc.Driver");
			Connection con = DriverManager.getConnection(url, "keyujin", "password");
					
			String time = request.getParameter("time");
			String date = request.getParameter("date");
			String fromLot = request.getParameter("fromLot#");
			String toLot = request.getParameter("toLot#");
			String riderUsername = (String)session.getAttribute("UserName");


			//Make an insert statement for the Sells table:
			String insert = "INSERT INTO RideRequests(time,date,fromLot,toLot,riderUsername)"
					+ "VALUES (?,?,?,?,?)";
			//Create a Prepared SQL statement allowing you to introduce the parameters of the query
			PreparedStatement ps = con.prepareStatement(insert);

			//Add parameters of the query. Start with 1, the 0-parameter is the INSERT statement itself
			ps.setString(1, time);
			ps.setString(2, date);
			ps.setString(3, fromLot);
			ps.setString(4, toLot);
			ps.setString(5, riderUsername);

			//Run the query against the DB
			ps.executeUpdate();
			//close the connection
			con.close();
			 response.sendRedirect(request.getContextPath()+"/dashRider.jsp");
} catch (Exception e) {
			out.print("insert failed");
		}
%>
</body>
</html>