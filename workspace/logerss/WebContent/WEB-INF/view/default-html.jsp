<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="fluid"  uri="http://visualkhh.com/fluid"%>
<!DOCTYPE html>
<html lang="<fluid:insertString id="lang"/>">
<!-- 김현하 -->
  <head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<fluid:insertTag id="meta-viewport" attribute="name='viewport'" name="meta" target="content"></fluid:insertTag>
	<!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
	<fluid:insertTag id="meta-description" attribute="name='description'" name="meta" target="content"></fluid:insertTag>
	<fluid:insertTag id="meta-author" attribute="name='author'"  name="meta" target="content"></fluid:insertTag>
    
	<fluid:insertTag id="icon" name="link" attribute="rel='icon'" target="href"></fluid:insertTag>

	<title><fluid:insertString id="title"/></title>
    
	<!-- default-head-css -->
	<fluid:insertView id="default-head-css"/>
	<!-- page-head-css -->
	<fluid:insertTag id="page-head-css" name="link" attribute="rel='stylesheet'" target="href"></fluid:insertTag>
	
	<!-- default-head-javascript -->
	<fluid:insertView id="default-head-javascript"/>
	<!-- page-head-javascript -->
	<fluid:insertTag id="page-head-javascript" name="script" attribute="type='text/javascript'" target="src"></fluid:insertTag>
	
	<%--START JAVASCRIPT GLOBAL--%>
	<script type="text/javascript">
	</script>
	<%--END JAVASCRIPT--%>
  </head>
		
  <!-- page-body -->
  <%--<body>--%>
	<fluid:insertView id="page-body" exception="true"/>
  <%--</body>--%>
  <!-- default-footer-javascript -->
  <fluid:insertView id="default-footer-javascript"/>
  <!-- page-footer-javascript -->
  <fluid:insertTag id="page-footer-javascript" name="script" attribute="type='text/javascript'" target="src"></fluid:insertTag>
  
</html>