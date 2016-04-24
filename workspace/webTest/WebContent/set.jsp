<%@page import="webTest.GG"%>
<%@page import="webTest.TT"%>
<%@page import="java.util.LinkedHashMap"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
set
<%
TT t = new TT();
t.setAge("55");
t.setName("bbb");
t.put("v", "v");

request.getSession().setAttribute("ROL", t);

GG g = new GG();
g.setAge("55");
g.setName("bbb");
request.getSession().setAttribute("GOL", g);
%>

</body>
</html>