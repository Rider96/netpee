<%@page contentType="text/xml" %>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="com.jsp.db.Dbconn"%>
<%
	out.print("<?xml version='1.0' encoding='UTF-8'?>");
%>
<registerResult>
<%
	String userNo = request.getParameter("userNo");
String clubNo = request.getParameter("clubNo");
Connection conn = Dbconn.getMySqlConnection();
Statement stmt = conn.createStatement();
String sql = "insert into club_user(userNo,clubNo,grade) values("+userNo+","+clubNo+",'nomal');";
ResultSet rs = null;
stmt.executeUpdate(sql);
%>
</registerResult>