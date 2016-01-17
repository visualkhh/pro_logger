<%@page import="khh.web.jsp.framework.validate.rolek.Role"%>
<%@page import="khh.web.jsp.framework.validate.rolek.RoleK"%>
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
	out.println("<br>");
	out.println(role.getPageRole(request));
	//out.println(role.getInfo());
}
 
%>
<div>
${param.name}..3
<%-- ${ROLEK_SESSION_dgsjhsey4idwefhu.getRoleList().view} --%>
</div>
</body>
</html>