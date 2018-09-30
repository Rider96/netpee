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
	String id = request.getParameter("id");
String pw = request.getParameter("pw");
String name = request.getParameter("name");
String nickname = request.getParameter("nickname");
String gender = request.getParameter("gender");
String birth_year = request.getParameter("birth_year");
String birth_month = request.getParameter("birth_month");
String birth_day = request.getParameter("birth_day");
String state = request.getParameter("state");
Connection conn = Dbconn.getMySqlConnection();
Statement stmt = conn.createStatement();
String sql = "select * from user where id='"+id+"';";
ResultSet rs = null;
rs = stmt.executeQuery(sql);
if(rs.next()){
	out.print("dup");
}else{
	sql = "insert into user(id,pw,userName,nickname,gender,birthday,state) values('"+id+"','"+pw+"','"+name+"','"+nickname+"',"+gender+",'"+birth_year+"-"+birth_month+"-"+birth_day+"','"+state+"');";
	System.out.println(sql);
	if(stmt.executeUpdate(sql)>0){
		out.print("success");
	}else{
		out.print("fail");
	}
}
%>
</registerResult>