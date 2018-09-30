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
	System.out.println("Content Type =" + request.getContentType());



String name = request.getParameter("name");
String category = request.getParameter("category");
String info = request.getParameter("info");
String area = request.getParameter("area");
String userNo = request.getParameter("userNo");

Connection conn = Dbconn.getMySqlConnection();
Statement stmt = conn.createStatement();
String sql = "insert into club(name,category,info,area) values('"+name+"','"+category+"','"+info+"','"+area+"');";
System.out.println(sql);
stmt.executeUpdate(sql);

ResultSet rs = null;
sql = "SELECT LAST_INSERT_ID() AS lii;";
rs = stmt.executeQuery(sql);
rs.next();
String clubNo = String.valueOf(rs.getInt("lii"));

sql = "insert into club_user(userNo,clubNo,grade) values("+userNo+","+clubNo+",'manager');";
System.out.println(sql);
stmt.executeUpdate(sql);

ServletContext context = getServletContext();
String revFilePath = "clubimg";
String realFilePath = context.getRealPath(revFilePath);
DiskFileUpload dfu = new DiskFileUpload();


//동시에 올릴 수 있는 최대 사이드를 설정한다. 설정된 사이즈 이상의 파일이 수신되면

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

            File file= new File(realFilePath, "club"+clubNo+".jpg");
            /*test*/System.out.println(file.getAbsolutePath());
            fileItem.write(file);
    }else { //문자열인 경우
            /*test*/System.out.println("Field: "+ fileItem.getFieldName() + ", content: " + fileItem.getString());
    }
}
%>