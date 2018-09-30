<%@page contentType="text/xml ;charset=UTF-8"
pageEncoding="UTF-8" %>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="com.jsp.db.Dbconn"%>
<%@page import="java.util.Enumeration"%>

<%
	out.print("<?xml version='1.0' encoding='UTF-8'?>");
%>
<%
	request.setCharacterEncoding("UTF-8");
String postXml = request.getParameter("postXml");
String userNo = request.getParameter("userNo");
String clubNo = request.getParameter("clubNo");
String title = request.getParameter("title");
System.out.println(postXml);

Connection conn = Dbconn.getMySqlConnection();
Statement stmt = conn.createStatement();
String sql = "insert into post(title, userNo, clubNo, postXml) values('"+title+"','"+userNo+"','"+clubNo+"','"+postXml+"');";
System.out.println(sql);
if(stmt.executeUpdate(sql)>0){
	ResultSet rs = null;
	sql = "SELECT LAST_INSERT_ID() AS lii;";
	rs = stmt.executeQuery(sql);
	rs.next();
	out.print("<postNo>"+rs.getInt("lii")+"</postNo>");
}
%>