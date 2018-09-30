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
	String clubNo = request.getParameter("clubNo");
String userNo = request.getParameter("userNo");
Connection conn = Dbconn.getMySqlConnection();
Statement stmt = conn.createStatement();

String sql = "select * from club where clubNo = "+clubNo;
ResultSet rs = null;
rs = stmt.executeQuery(sql);
rs.next();
out.print("<clubName>"+rs.getString("name")+"</clubName>");
out.print("<category>"+rs.getString("category")+"</category>");
sql = "select post.title, user.nickname, post.postNo from post, user where post.userNo = user.userNo and post.clubNo = "+clubNo+" and notice = false order by post.postNo desc";
System.out.print(sql);
rs = null;
rs = stmt.executeQuery(sql);

while(rs.next()){
out.print("<post>");
out.print("<postNo>"+rs.getString("postNo")+"</postNo>");
out.print("<nickname>"+rs.getString("nickname")+"</nickname>");	
out.print("<title>"+rs.getString("title")+"</title>");	
out.print("</post>");
}

sql = "select grade from club_user where userNo= "+userNo+ " and clubNo= "+clubNo;
rs = stmt.executeQuery(sql);
rs.next();
	out.print("<grade>"+rs.getString("grade")+"</grade>");
sql = "select post.title, user.nickname, post.postNo from post, user where post.userNo = user.userNo and post.clubNo = "+clubNo+" and notice = true order by post.postNo desc";
rs = stmt.executeQuery(sql);
while(rs.next()){
out.print("<notice>");
out.print("<postNo>"+rs.getString("postNo")+"</postNo>");
out.print("<nickname>"+rs.getString("nickname")+"</nickname>");	
out.print("<title>"+rs.getString("title")+"</title>");	
out.print("</notice>");



}
sql = "select * from culture where clubNo="+clubNo;
rs = stmt.executeQuery(sql);
while(rs.next()){
out.print("<culture>");
out.print("<c_title>"+rs.getString("c_title")+"</c_title>");
out.print("<c_content>"+rs.getString("c_content")+"</c_content>");
out.print("<title_c>"+rs.getString("title").replace("<"," ").replace(">"," ")+"</title_c>");
out.print("<place>"+rs.getString("place").replace("<"," ").replace(">"," ")+"</place>");	
out.print("<date>"+rs.getString("date")+"</date>");	
out.print("<imgurl>"+rs.getString("imgurl")+"</imgurl>");	
out.print("</culture>");
}
%>