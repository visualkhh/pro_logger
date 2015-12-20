<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="fluid"  uri="http://visualkhh.com/fluid"%>
<!DOCTYPE html>
<html lang="<fluid:insertString id="lang"/>">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
<!--     <meta name="viewport" content="width=device-width, initial-scale=1"> -->
    <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
    <meta name="description" content="<fluid:insertString id="description"/>">
    <meta name="author" content="<fluid:insertString id="author"/>">
    <link rel="icon" href="<fluid:insertString id="icon"/>">

    <title><fluid:insertString id="title"/></title>
    
    <style type="text/css">
	.container {
	  width: 1024px;
	  max-width: none !important;
	}
    </style>
    
	<fluid:insertView id="default-head-css"/>
	<fluid:insertView id="page-head-css"/>
	<fluid:insertView id="default-head-javascript"/>
	<fluid:insertView id="page-head-javascript"/>
	
	<%--START JAVASCRIPT--%>
	<script type="text/javascript">
	</script>
	<%--END JAVASCRIPT--%>
  </head>

  <%--<body>--%>
	<fluid:insertView id="page-body"/>
  <%--</body>--%>
  
  <fluid:insertView id="default-footer-javascript"/>
  <fluid:insertView id="page-footer-javascript"/>
</html>