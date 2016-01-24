    <%@page import="loggerss.INFO"%>
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
    <!-- Just for debugging purposes. Don't actually copy these 2 lines! -->
    <!--[if lt IE 9]><script src="../../assets/js/ie8-responsive-file-warning.js"></script><![endif]-->
    <script src="/front-end/bootstrap/3.3.6/docs/assets/js/ie-emulation-modes-warning.js"></script>
    <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
    <!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
      <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->
	<script src="/front-end/bootstrap/3.3.6/docs/assets/js/vendor/jquery.min.js"></script>
	<script src="/front-end/javascript/visualkhh/sizzle.js"></script>
	<script src="/front-end/javascript/visualkhh/util.js"></script>

	
	<script src="/front-end/bootstrap/plugin/bootstrap-slider/dependencies/js/modernizr.js"></script>
	<script src="/front-end/bootstrap/plugin/bootstrap-slider/dist/bootstrap-slider.js"></script>
	<script src="/front-end/bootstrap/plugin/bootstrap-datetimepicker-master/js/bootstrap-datetimepicker.min2.js"></script>
    
	<script type="text/javascript">
	var STATUS_CODE_SUCCESS				= "<%=INFO.STATUS_CODE_SUCCESS			%>"; //성공 일반적인 리턴값이 없는 성공   
<%-- 	var STATUS_CODE_SUCCESS_XMLRETURN	= "<%=INFO.STATUS_CODE_SUCCESS_XMLRETURN%>"; //성공 xml 리턴값 있는 성공      --%>
	var STATUS_CODE_FAIL				= "<%=INFO.STATUS_CODE_FAIL				%>"; //실패 일반적인 리턴값이 없는 실패                  
<%-- 	var STATUS_CODE_FAIL_XMLRETURN		= "<%=INFO.STATUS_CODE_FAIL_XMLRETURN	%>"; //xml로 리턴값을 돌려줍니다.     --%>
	var REMOTEADDR						= "<%=request.getRemoteAddr()%>";
	</script>
