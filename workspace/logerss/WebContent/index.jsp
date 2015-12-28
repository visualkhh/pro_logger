<%@page import="khh.web.jsp.framework.filter.validate.Role"%>
<%@page import="khh.web.jsp.framework.filter.validate.RoleK"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
ㅠㅠㅠ
<% 
Role role = (Role)session.getAttribute(RoleK.PARAM_NAME_SESSION);
if(null!=role){
	out.println(role.getRoleList());
	out.println(role.getInfo());
}

%>
</body>
</html>