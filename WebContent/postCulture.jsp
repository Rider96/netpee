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
String clubNo = "";
String title = "";
String date = "";
String imgurl = "";
String place = "";
String c_title = "";
String c_content = "";



System.out.println("Content Type =" + request.getContentType());
ServletContext context = getServletContext();
DiskFileUpload dfu = new DiskFileUpload();

dfu.setSizeMax(200000000); 

List fileItems = dfu.parseRequest(request);
Iterator itr = fileItems.iterator();
while(itr.hasNext()) {
     FileItem fileItem = (FileItem)itr.next();

     //Check if not form field so as to only handle the file inputs
     //else condition handles the submit button input
		System.out.println("Field: "+ fileItem.getFieldName() + ", content: " + fileItem.getString());
    
    	if(fileItem.getFieldName().equals("userNo")){
    		userNo = fileItem.getString();
    	}
    	if(fileItem.getFieldName().equals("clubNo")){
    		clubNo = fileItem.getString();
    	}
    	if(fileItem.getFieldName().equals("title")){
    		title = fileItem.getString();
    	}
    	if(fileItem.getFieldName().equals("place")){
    		place = fileItem.getString();
    	}
    	if(fileItem.getFieldName().equals("date")){
    		date = fileItem.getString();
    	}
    	if(fileItem.getFieldName().equals("imgUrl")){
    		imgurl = fileItem.getString();
    	}
    	if(fileItem.getFieldName().equals("c_title")){
    		c_title = fileItem.getString();
    	}
    	if(fileItem.getFieldName().equals("c_content")){
    		c_content = fileItem.getString();
    	}
    }
Connection conn = Dbconn.getMySqlConnection();
Statement stmt = conn.createStatement();
String sql = "insert into culture(userNo, clubNo, c_title, c_content, title, place, date, imgurl) values("+userNo+","+clubNo+",'"+c_title+"','"+c_content+"','"+title+"','"+place+"','"+date+"','"+imgurl+"');";
stmt.executeUpdate(sql);
%>