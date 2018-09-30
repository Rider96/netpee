<%@ page language="java" contentType="text/xml; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="com.jsp.db.Dbconn"%>
<%
	out.print("<?xml version='1.0' encoding='UTF-8'?>");
%>
<%
	String area = request.getParameter("area");
String category = request.getParameter("category");

Connection conn = Dbconn.getMySqlConnection();
Statement stmt = conn.createStatement();
Statement stmt2 = conn.createStatement();
String sql;
sql = "select clubNo,name,category,info,area from club where area like '"+area+"' and category like '"+category+"' order by clubNo desc;" ;

System.out.print(sql);
ResultSet rs = null;
ResultSet rs2 = null;
rs = stmt.executeQuery(sql);

while(rs.next()){
out.print("<club>");
out.print("<clubNo>"+rs.getString("clubNo")+"</clubNo>");
out.print("<name>"+rs.getString("name")+"</name>");	
out.print("<category>"+rs.getString("category")+"</category>");	
out.print("<info>"+rs.getString("info")+"</info>");	
out.print("<area>"+rs.getString("area")+"</area>");

String sql2 = "select count(*) as count from club_user where clubNo = "+ rs.getString("clubNo");
rs2 = stmt2.executeQuery(sql2);
rs2.next();
out.print("<count>"+rs2.getString("count")+"</count>");
out.print("</club>");
}
%>