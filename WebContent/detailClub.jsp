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
	String userNo = request.getParameter("userNo");
String clubNo = request.getParameter("clubNo");

Connection conn = Dbconn.getMySqlConnection();
Statement stmt = conn.createStatement();
Statement stmt2 = conn.createStatement();
String sql;
String isReg = "no";
//sql = "select clubNo,name,category,info,area from club where area like '"+area+"' and category like '"+category+"' order by clubNo desc;" ;
sql = "select * from club_user where clubNo="+clubNo+" and userNo= "+userNo+"";
System.out.println(sql);
ResultSet rs = null;
ResultSet rs2 = null;
ResultSet rs3 = null;
rs3 = stmt.executeQuery(sql);
if(rs3.next()){
	isReg="yes";
}
System.out.println(isReg);
sql = "select * from club where clubNo="+clubNo+"";
rs = stmt.executeQuery(sql);
out.print("<isReg>"+isReg+"</isReg>");
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