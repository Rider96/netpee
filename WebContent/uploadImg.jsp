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
String postXml = "";
String notice = "";
Connection conn = Dbconn.getMySqlConnection();
Statement stmt = conn.createStatement();
String sql = "insert into post(postXml) values('test');";
ResultSet rs = null;
stmt.executeUpdate(sql);
sql = "SELECT LAST_INSERT_ID() AS lii;";
rs = stmt.executeQuery(sql);
rs.next();
String postNo = String.valueOf(rs.getInt("lii"));
System.out.println("Content Type =" + request.getContentType());
ServletContext context = getServletContext();
String revFilePath = "postimg";
DiskFileUpload dfu = new DiskFileUpload();
String realFilePath = context.getRealPath(revFilePath);

int j = 1;
// FileUploadException이 발생한다.
dfu.setSizeMax(200000000); 

List fileItems = dfu.parseRequest(request);
Iterator itr = fileItems.iterator();
while(itr.hasNext()) {
     FileItem fileItem = (FileItem)itr.next();

     //Check if not form field so as to only handle the file inputs
     //else condition handles the submit button input
     if(!fileItem.isFormField()) { //파일인 경우 
            String fileNm  = fileItem.getName(); //한글 파일명 처리!
            /*test*/System.out.println("fileName: "+ fileNm );
            /*test*/System.out.println("fileSize: "+ fileItem.getSize());

            File file= new File(realFilePath, postNo+"_"+j+".jpg");
            /*test*/System.out.println(file.getAbsolutePath());
            fileItem.write(file);
            j++;
    }else { //문자열인 경우
            /*test*/System.out.println("Field: "+ fileItem.getFieldName() + ", content: " + fileItem.getString());
    
    	if(fileItem.getFieldName().equals("userNo")){
    		userNo = fileItem.getString();
    	}
    	if(fileItem.getFieldName().equals("clubNo")){
    		clubNo = fileItem.getString();
    	}
    	if(fileItem.getFieldName().equals("title")){
    		title = fileItem.getString();
    	}
    	if(fileItem.getFieldName().equals("postXml")){
    		postXml = fileItem.getString();
    	}
    	if(fileItem.getFieldName().equals("notice")){
    		notice = fileItem.getString();
    	}
    }
}
sql = "update post set postXml = '"+postXml+"', title = '" + title + "', notice = "+notice + ", userNo = "+userNo+", clubNo=" + clubNo 

		+" where postNo = "+postNo;
System.out.println(sql);
stmt.executeUpdate(sql);
%>