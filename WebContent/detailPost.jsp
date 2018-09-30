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
	String postNo = request.getParameter("postNo");

Connection conn = Dbconn.getMySqlConnection();
Statement stmt = conn.createStatement();
String sql;
//sql = "select clubNo,name,category,info,area from club where area like '"+area+"' and category like '"+category+"' order by clubNo desc;" ;
sql = "select * from post where postNo= "+postNo;
System.out.println(sql);
ResultSet rs = null;
rs = stmt.executeQuery(sql);
while(rs.next()){
out.print("<title>"+rs.getString("title")+"</title>");
out.print(rs.getString("postXml"));
}
sql = "select user.nickname, comment.contents from user,comment where user.userNo = comment.userNo and comment.postNo ="+postNo;
rs = stmt.executeQuery(sql);
while(rs.next()){
	out.print("<comment>");
out.print("<nickname>"+rs.getString("nickname")+"</nickname>");
out.print("<contents>"+rs.getString("contents")+"</contents>");
out.print("</comment>");
}
%>