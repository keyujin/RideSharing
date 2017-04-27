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
String fromLot = request.getParameter("fromLot#");
String toLot = request.getParameter("toLot#");
if(fromLot.equals(toLot)){
	System.out.println("error: identical lots");
	response.sendRedirect(request.getContextPath() + "/dashRider.jsp");
	return;
}
try{
	String url = "jdbc:mysql://malcador.canetd0jmani.us-east-2.rds.amazonaws.com:3306/RideShare";
	//Load JDBC driver - the interface standardizing the connection procedure. Look at WEB-INF\lib for a mysql connector jar file, otherwise it fails.
	Class.forName("com.mysql.jdbc.Driver");
	Connection con = DriverManager.getConnection(url, "keyujin", "password");
	String search = "SELECT COUNT(*) AS count FROM Lots WHERE lotName LIKE ?";
	PreparedStatement sps = con.prepareStatement(search);
	sps.setString(1, fromLot);
	ResultSet rsFrom = sps.executeQuery();
	rsFrom.next();
	int fromCount = rsFrom.getInt("count");
	sps.setString(1, toLot);
	ResultSet rsTo = sps.executeQuery();
	rsTo.next();
	int toCount = rsTo.getInt("count");
	if(toCount != 1 || fromCount != 1){ 
		System.out.println("Error: Invalid Lots"); 
		response.sendRedirect(request.getContextPath() + "/dashRider.jsp");
		return;
	}
	con.close();
	sps.close();
}catch (Exception e) {
	out.print("insert failed");
}
try {
	String url = "jdbc:mysql://malcador.canetd0jmani.us-east-2.rds.amazonaws.com:3306/RideShare";
	//Load JDBC driver - the interface standardizing the connection procedure. Look at WEB-INF\lib for a mysql connector jar file, otherwise it fails.
	Class.forName("com.mysql.jdbc.Driver");
	Connection con = DriverManager.getConnection(url, "keyujin", "password");
	
	String time = request.getParameter("time");
	String date = request.getParameter("date");
	String riderUsername = (String)session.getAttribute("UserName");
	String recurring = request.getParameter("recurring");
	String often = request.getParameter("numOften");
	int numOften = 0;
	int recurringVal = Integer.parseInt(recurring);
	if(!often.equals("")){
		numOften = Integer.parseInt(often);
	}
	String insert = "INSERT INTO RideRequests(time,date,fromLot,toLot,riderUsername)" + "VALUES (?,?,?,?,?)";
	//Create a Prepared SQL statement allowing you to introduce the parameters of the query
	PreparedStatement ps = con.prepareStatement(insert);

	
	int i=0;
	if(numOften==0){
		//Make an insert statement for the Sells table:
		
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
	}else{
		if(recurringVal==1){
			while(i<numOften-1){
				java.text.DateFormat df = new java.text.SimpleDateFormat("yyyy-MM-dd"); 
				java.util.Date startDate = df.parse(date);
				out.println(startDate);
				Calendar cal = Calendar.getInstance();
				cal.setTime(startDate);
				cal.add(Calendar.DATE, +1);
				
				
				ps.setString(1, time);
				ps.setString(2, df.format(cal.getTime()));
				ps.setString(3, fromLot);
				ps.setString(4, toLot);
				ps.setString(5, riderUsername);
			
				
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
				
				ps.setString(1, time);
				ps.setString(2, df.format(cal.getTime()));
				ps.setString(3, fromLot);
				ps.setString(4, toLot);
				ps.setString(5, riderUsername);
			
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
				
				ps.setString(1, time);
				ps.setString(2, df.format(cal.getTime()));
				ps.setString(3, fromLot);
				ps.setString(4, toLot);
				ps.setString(5, riderUsername);
			
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

		response.sendRedirect(request.getContextPath()+"/dashRider.jsp");
		
	}catch (Exception e) {
	out.print("insert failed");
}
%>
</body>
</html>