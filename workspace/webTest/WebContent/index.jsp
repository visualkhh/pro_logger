<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<c:if test="${param.u=='u'}">
aaaaaa
</c:if>
<%

java.util.Enumeration names = request.getHeaderNames();

while (names.hasMoreElements()) {
    String name = (String)names.nextElement();
    out.println(name+" := "+request.getHeader(name) + "<br/>");
}

%>
<br/>
<%= request.getSession().getId()%>

<%

//String s = request.getSession().getServletContext().getRealPath("/WEB-INF/visualkhh@gmail.com.png");
String s = request.getSession().getServletContext().getRealPath("/WEB-INF/visualkhh@gmail.com");
%><br>
<%=s %>
</body>
</html>