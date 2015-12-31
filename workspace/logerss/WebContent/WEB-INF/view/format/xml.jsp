<%@page import="khh.date.util.DateUtil"%>
<%@ page language="java" contentType="text/xml; charset=UTF-8" pageEncoding="UTF-8"%>
<ROOT>
<%-- <name><![CDATA[<%=request.getAttribute("name")%>]]></name> --%>
	<DATE><![CDATA[<%=DateUtil.getDate("yyyy/MM/dd HH:mm:ss/SSS")%>]]></DATE>
	<REQUEST_KEY><![CDATA[<%=request.getParameter("REQUEST_KEY")%>]]></REQUEST_KEY>
	<STATUS_CODE><![CDATA[<%=request.getAttribute("STATUS_CODE")%>]]></STATUS_CODE>
	<STATUS_MSG><![CDATA[<%=request.getAttribute("STATUS_MSG")%>]]></STATUS_MSG>
	<%Boolean cdata = (Boolean)request.getAttribute("RESULT_ISCDATA"); cdata = (cdata==null?true:cdata);
	if(true == cdata){%>
		<RESULT><![CDATA[<%=request.getAttribute("RESULT")%>]]></RESULT>
	<%}else{%>
		<RESULT><%=request.getAttribute("RESULT")%></RESULT>
	<%}%>
</ROOT>
<%
//Thread.sleep(3000);
%>