<%@page import="khh.web.jsp.framework.validate.rolek.RoleK"%>
<%@page import="khh.web.jsp.framework.validate.rolek.Role"%>
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="khh.property.util.PropertyUtil"%>
<%@taglib prefix="fluid"  uri="http://visualkhh.com/fluid"%>
<script type="text/javascript">
EventUtil.addOnloadEventListener(function(){
// 	var param = {
// 			url:"/ajax/info",
// 			type:"POST",
// 			data:{
// 				"MN":"main"
// 			},
// 			//onBeforeProcess:ajaxBefore,
// 			onSuccess:ajaxCallBack,
// 			//onComplete:ajaxComplete,
// 			dataType:"XML"
// 		};
// 	ajax(param,"notice loading..");
	//var ajax = new AjaxK(param);
	//$('#task-container').modal('show');
});
// function ajaxCallBack(data,readyState,status){
// 	var status_code = $(data).find("ROOT>STATUS_CODE").text();
// 	var status_msg = $(data).find("ROOT>STATUS_MSG").text();
// 	if(STATUS_CODE_SUCCESS==status_code){ //성공
// 		$(data).find("ROOT>RESULT>TABLE>RECODE").each(function(index){
// 			var title = $(this).find("TITLE").text();
// 			$("#notice_container").append("<div>"+title+"</div>");
// 		});
// 	}else{	//실패
// 		alert("notice loading FAIL!</br>"+status_msg);
// 	}

// }
</script>
<body>
<!-- <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#alert">Windows 8 modal - Click to View</button> -->
	<!-- nav start -->
	<fluid:insertView id="page-body-nav"/>
	<!-- nav end -->
	
	

  <!-- page Start -->
    <div class="container">

      <div class="row row-offcanvas row-offcanvas-right">

        <div class="col-xs-12 col-sm-9">
          <p class="pull-right visible-xs">
            <button type="button" class="btn btn-primary btn-xs" data-toggle="offcanvas">Toggle nav</button>
          </p>
          
          		<h2 class="sub-header">My Logs</h2>
          <div class="table-responsive">
            <table class="table table-striped">
              <thead>
                <tr>
                  <th>#</th>
                  <th>Name</th>
                  <th>Type</th>
                  <th>Time</th>
                </tr>
              </thead>
              <tbody>
                <tr>
                  <td>1,001</td>
                  <td>Lorem</td>
                  <td>ipsum</td>
                  <td>dolor</td>
                </tr>
                <tr>
                  <td>1,002</td>
                  <td>amet</td>
                  <td>consectetur</td>
                  <td>adipiscing</td>
                </tr>
                <tr>
                  <td>1,003</td>
                  <td>Integer</td>
                  <td>nec</td>
                  <td>odio</td>
                </tr>
                <tr>
                  <td>1,003</td>
                  <td>libero</td>
                  <td>Sed</td>
                  <td>cursus</td>
                </tr>
                <tr>
                  <td>1,004</td>
                  <td>dapibus</td>
                  <td>diam</td>
                  <td>Sed</td>
                </tr>
                <tr>
                  <td>1,005</td>
                  <td>Nulla</td>
                  <td>quis</td>
                  <td>sem</td>
                </tr>
                <tr>
                  <td>1,006</td>
                  <td>nibh</td>
                  <td>elementum</td>
                  <td>imperdiet</td>
                </tr>
                <tr>
                  <td>1,007</td>
                  <td>sagittis</td>
                  <td>ipsum</td>
                  <td>Praesent</td>
                </tr>
                <tr>
                  <td>1,008</td>
                  <td>Fusce</td>
                  <td>nec</td>
                  <td>tellus</td>
                </tr>
                <tr>
                  <td>1,009</td>
                  <td>augue</td>
                  <td>semper</td>
                  <td>porta</td>
                </tr>
                <tr>
                  <td>1,010</td>
                  <td>massa</td>
                  <td>Vestibulum</td>
                  <td>lacinia</td>
                </tr>
                <tr>
                  <td>1,011</td>
                  <td>eget</td>
                  <td>nulla</td>
                  <td>Class</td>
                </tr>
                <tr>
                  <td>1,012</td>
                  <td>taciti</td>
                  <td>sociosqu</td>
                  <td>ad</td>
                </tr>
                <tr>
                  <td>1,013</td>
                  <td>torquent</td>
                  <td>per</td>
                  <td>conubia</td>
                </tr>
                <tr>
                  <td>1,014</td>
                  <td>per</td>
                  <td>inceptos</td>
                  <td>himenaeos</td>
                </tr>
                <tr>
                  <td>1,015</td>
                  <td>sodales</td>
                  <td>ligula</td>
                  <td>in</td>
                </tr>
              </tbody>
            </table>
          </div>
          
        </div><!--/.col-xs-12.col-sm-9-->

        <div class="col-xs-6 col-sm-3 sidebar-offcanvas" id="sidebar">
        
          <div class="list-group">
            <a href="#" class="list-group-item active">MyLogList 
			  <span class="fa fa-plus" aria-hidden="true"></span>
			</a>
            <a href="/view/mylog/detail" class="list-group-item">Item1</a>
            <a href="/view/mylog/detail" class="list-group-item">Link</a>
            <a href="/view/mylog/detail" class="list-group-item">Link</a>
            <a href="/view/mylog/detail" class="list-group-item">Link</a>
            <a href="/view/mylog/detail" class="list-group-item">Link</a>
            <a href="/view/mylog/detail" class="list-group-item">Link</a>
            <a href="/view/mylog/detail" class="list-group-item">Link</a>
            <a href="/view/mylog/detail" class="list-group-item">Link</a>
            <a href="/view/mylog/detail" class="list-group-item">Link</a>
          </div>
        </div><!--/.sidebar-offcanvas-->
      </div><!--/row-->

	<!-- page END -->
	<fluid:insertView id="page-body-footer"/>
    </div> <!-- /container -->
</body>