<%@page import="org.json.simple.parser.JSONParser"%>
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="fluid"  uri="http://visualkhh.com/fluid"%>
<script type="text/javascript">
EventUtil.addOnloadEventListener(function(){
	var broswerInfo = navigator.userAgent;
	
// 	alert(window.Android);
	
// 	alert(AndroidFunction);
	Android.showToast("hi");

});
</script>
<body>
	<%--nav--%>
	<%--<fluid:insertView id="page-body-nav"/> --%>
	<%--nav--%>
	<div class="container">
	
${param.a }	<br>
${param.b }	<br>
${param.c }	<br>
<%

java.util.Enumeration names = request.getHeaderNames();

while (names.hasMoreElements()) {
    String name = (String)names.nextElement();
    out.println(name+" := "+request.getHeader(name) + "<br/>");
}

%>
<br/>
<%= request.getSession().getId()%>
	
	<button onclick="window.Android.showToast('hi');" value="aaaaaa">vvvvvvvvv</button>
	<%--footer--%>
	<%--<fluid:insertView id="page-body-footer"/> --%>
	<%--footer--%>
    </div> <!-- /container -->
</body>