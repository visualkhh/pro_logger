
<%@page import="java.awt.print.Printable"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="javax.sql.DataSource"%>
<%@page import="javax.naming.Context"%>
<%@page import="javax.naming.InitialContext"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
안녕하세요<%=String.valueOf(4+4+4+22) %>

<%

Context ic = new InitialContext(); 
DataSource ds = (DataSource) ic.lookup("java:comp/env/jdbc/TestDB"); 
Connection con = ds.getConnection();
Statement p  = con.createStatement();
ResultSet rs = p.executeQuery("SELECT A FROM TEST");

while(rs.next())
{
out.println( rs.getString(1)+"</br>");
}
con.close();

%>

f
</body>
</html>