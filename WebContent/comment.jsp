<%@page contentType="text/xml ;charset=UTF-8"
pageEncoding="UTF-8" %>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@ page import = "com.oreilly.servlet.MultipartRequest" %>
<%@ page import = "com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page import = "java.util.*" %>
<%@ page import = "java.io.*" %>
<%@page import="com.jsp.db.Dbconn"%>
<%@ page import="org.apache.commons.fileupload.DiskFileUpload"%>
<%@ page import="org.apache.commons.fileupload.FileItem"%>

<%
	out.print("<?xml version='1.0' encoding='UTF-8'?>");
%>
<%
	String userNo = "";
String postNo = "";
String content = "";
DiskFileUpload dfu = new DiskFileUpload();
dfu.setSizeMax(200000000); 
List fileItems = dfu.parseRequest(request);
Iterator itr = fileItems.iterator();
while(itr.hasNext()) {
    FileItem fileItem = (FileItem)itr.next();
	if(fileItem.getFieldName().equals("userNo")){
		userNo = fileItem.getString();
	}
	if(fileItem.getFieldName().equals("postNo")){
		postNo = fileItem.getString();
	}
	if(fileItem.getFieldName().equals("contents")){
		content = fileItem.getString();
	}
}
Connection conn = Dbconn.getMySqlConnection();
Statement stmt = conn.createStatement();
String sql = "insert into comment(postNo,userNo,contents) values("+postNo+","+userNo+",'"+content+"');";
System.out.println(sql);
stmt.executeUpdate(sql);
%>