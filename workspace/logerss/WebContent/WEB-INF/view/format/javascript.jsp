<%@page import="khh.date.util.DateUtil"%>
<%@ page language="java" contentType="application/javascript; charset=UTF-8" pageEncoding="UTF-8"%>

<%=request.getParameter("callback")%>(

{
	"DATE" 				: "<%=DateUtil.getDate("yyyy/MM/dd HH:mm:ss/SSS")%>",
	"REQUEST_KEY" 		: "<%=request.getParameter("REQUEST_KEY")%>",
	"STATUS_CODE" 		: "<%=request.getParameter("STATUS_CODE")%>",
	"STATUS_MSG" 		: "<%=request.getParameter("STATUS_MSG")%>",
	"RESULT" 			: "<%=request.getParameter("RESULT")%>"

}


);
