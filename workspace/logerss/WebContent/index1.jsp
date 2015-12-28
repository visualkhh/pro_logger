
<%@page import="java.util.Map"%>
<%@page import="khh.property.util.PropertyUtil"%>
<%@page import="khh.property.util.PropertiesUtil"%>
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
<%=PropertyUtil.getFileEncoding() %>
<%

Map<String,String[]> map = request.getParameterMap();


// Context ic = new InitialContext(); 
// DataSource ds = (DataSource) ic.lookup("java:comp/env/jdbc/TestDB"); 
// Connection con = ds.getConnection();
// con.close();

%>
<br>
<%=map.get("a")[0] %>

<%
map.get("a")[0]="babo";


map = request.getParameterMap();
%>
<%=map.get("a")[0] %>

</body>
</html>