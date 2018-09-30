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
	String id = request.getParameter("id");
String pw = request.getParameter("pw");
Connection conn = Dbconn.getMySqlConnection();
Statement stmt = conn.createStatement();
String sql = "select * from user where id='"+id+"' and pw='"+pw+"';";
System.out.print(sql);
ResultSet rs = null;
rs = stmt.executeQuery(sql);
if(rs.next()){
	out.print("<loginResult>success</loginResult>");
	out.print("<userNo>"+rs.getInt("userNo")+"</userNo>");
	out.print("<state>"+rs.getString("state")+"</state>");
	out.print("<userName>"+rs.getString("userName")+"</userName>");
	out.print("<nickname>"+rs.getString("nickname")+"</nickname>");
}else{
	out.print("<loginResult>fail!</loginResult>");
}
%>