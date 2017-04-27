<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*,java.text.*"%>
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
					
			String timeFrom = request.getParameter("timeFrom");
			String timeTo = request.getParameter("timeTo");
			String date = request.getParameter("date");
			String fromLot = request.getParameter("fromLot#");
			String toLot = request.getParameter("toLot#");
			String numPass = request.getParameter("numPass");

			String recurring = request.getParameter("recurring");
			String often = request.getParameter("numOften");

			String driverUsername = (String)session.getAttribute("UserName");

			int numOften = 0;
			int recurringVal = Integer.parseInt(recurring);
			if(!often.equals("")){
				numOften = Integer.parseInt(often);
			}
		
			String insert = "INSERT INTO RideOffers(timeFrom,timeTo,date,fromLot,toLot,driverUsername,numPassengers,recurring)"
					+ "VALUES (?,?,?,?,?,?,?,?)";
			//Create a Prepared SQL statement allowing you to introduce the parameters of the query
			PreparedStatement ps = con.prepareStatement(insert);
			
			
			
			ps.setString(1, timeFrom);
			ps.setString(2, timeTo);
			ps.setString(3, date);
			ps.setString(4, fromLot);
			ps.setString(5, toLot);
			ps.setString(6, driverUsername);
			ps.setString(7, numPass);
			ps.setInt(8, recurringVal);

			//Run the query against the DB
			
			
			ps.executeUpdate();
			
			int i=0;
			if(recurringVal!=0){
			if(recurringVal==1){
				while(i<numOften-1){
					java.text.DateFormat df = new java.text.SimpleDateFormat("yyyy-MM-dd"); 
					java.util.Date startDate = df.parse(date);
					out.println(startDate);
					Calendar cal = Calendar.getInstance();
					cal.setTime(startDate);
					cal.add(Calendar.DATE, +1);
					
					ps.setString(1, timeFrom);
					ps.setString(2, timeTo);
					ps.setString(3, df.format(cal.getTime()));
					ps.setString(4, fromLot);
					ps.setString(5, toLot);
					ps.setString(6, driverUsername);
					ps.setString(7, numPass);
					ps.setString(8, recurring);

					//Run the query against the DB
					
					date = df.format(cal.getTime());
					ps.executeUpdate();
					i++;
				}
			}else if(recurringVal==2){
				while(i<numOften-1){
					java.text.DateFormat df = new java.text.SimpleDateFormat("yyyy-MM-dd"); 
					java.util.Date startDate = df.parse(date);
					out.println(startDate);
					Calendar cal = Calendar.getInstance();
					cal.setTime(startDate);
					cal.add(Calendar.DATE, +7);
					
					ps.setString(1, timeFrom);
					ps.setString(2, timeTo);
					ps.setString(3, df.format(cal.getTime()));
					ps.setString(4, fromLot);
					ps.setString(5, toLot);
					ps.setString(6, driverUsername);
					ps.setString(7, numPass);
					ps.setString(8, recurring);

					//Run the query against the DB
					
					date = df.format(cal.getTime());
					ps.executeUpdate();
					i++;
				}
			}else if(recurringVal==3){
				while(i<numOften-1){
					java.text.DateFormat df = new java.text.SimpleDateFormat("yyyy-MM-dd"); 
					java.util.Date startDate = df.parse(date);
					out.println(startDate);
					Calendar cal = Calendar.getInstance();
					cal.setTime(startDate);
					cal.add(Calendar.MONTH, +1);
					
					ps.setString(1, timeFrom);
					ps.setString(2, timeTo);
					ps.setString(3, df.format(cal.getTime()));
					ps.setString(4, fromLot);
					ps.setString(5, toLot);
					ps.setString(6, driverUsername);
					ps.setString(7, numPass);
					ps.setString(8, recurring);

					//Run the query against the DB
					
					date = df.format(cal.getTime());
					ps.executeUpdate();
					i++;
				}
			}
			}
			//close the connection
			con.close();
			out.print("insert succeded");

			response.sendRedirect(request.getContextPath()+"/dashDriver.jsp");
		} catch (Exception e) {
			e.printStackTrace();
			out.print("insert failed");
		}
%>
</body>
</html>