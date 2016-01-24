<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="fluid"  uri="http://visualkhh.com/fluid"%>
<script type="text/javascript">
EventUtil.addOnloadEventListener(function(){
});
</script>
<body>
	<%--nav--%>
	<%--<fluid:insertView id="page-body-nav"/> --%>
	<%--nav--%>
	<div class="container">
	
	
	<div class="row">
        <div class="col-xs-12 col-sm-12 col-md-6">
                First Column, First Cell
        </div>
        <div class="col-xs-12 col-sm-12 col-md-6">
            <div class="row">
               <div class="col-xs-12">
                Second Column, First Cell
               </div>
               <div class="col-xs-12">
                Second Column, Second Cell
               </div>
               <div class="col-xs-12">
                Second Column, Third Cell
               </div>
           </div>
        </div>
    </div>
	<%--footer--%>
	<%--<fluid:insertView id="page-body-footer"/> --%>
	<%--footer--%>
    </div> <!-- /container -->
</body>