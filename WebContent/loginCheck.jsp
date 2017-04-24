<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
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
	
			//Create a connection to your DB
			Connection con = DriverManager.getConnection(url, "keyujin", "password");
			String username = request.getParameter("username");
			String password = request.getParameter("password");

		    session.setAttribute("UserName", username);

			//Populate SQL statement with an actual query. It returns a single number. The number of beers in the DB.
			String str = "SELECT COUNT(Username) AS cnt FROM UserTable u WHERE u.Username = ? AND u.Password = ?";
			PreparedStatement stmt = con.prepareStatement(str);
			stmt.setString(1,username);
			stmt.setString(2,password);
			//Run the query against the DB
			ResultSet result = stmt.executeQuery();
			//Start parsing out the result of the query. Don't forget this statement. It opens up the result set.
			result.next();
			//Parse out the result of the query
			int countMatches = result.getInt("cnt");
			
			String getType = "SELECT u.userType as uType FROM UserTable u WHERE u.Username = ?";
			PreparedStatement stmt2 = con.prepareStatement(getType);
			stmt2.setString(1,username);
			//Run the query against the DB
			ResultSet result2 = stmt2.executeQuery();
			//Start parsing out the result of the query. Don't forget this statement. It opens up the result set.
			result2.next();

			String userType = result2.getString("uType");
			
			out.print(userType);

			if(countMatches >0){
				
				if(userType.equals("0")){
					 response.sendRedirect("createOffer.jsp");

				}else {
					 response.sendRedirect("createRequest.jsp");
				}
			}else{
				out.print("Login Failed");
			}
			//close the connection
			con.close();

		} catch (Exception e) {
			
			out.print("Login Failed");
			 response.sendRedirect("Login.jsp");

		}
	%>

</body>
</html>