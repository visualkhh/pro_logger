<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="khh.property.util.PropertyUtil"%>
<%@taglib prefix="fluid"  uri="http://visualkhh.com/fluid"%>
<script type="text/javascript">
EventUtil.addOnloadEventListener(function(){
	var param = {
			url:"/ajax/info",
			type:"POST",
			data:{
				"MN":"main"
			},
			//onBeforeProcess:ajaxBefore,
			onSuccess:ajaxCallBack,
			//onComplete:ajaxComplete,
			dataType:"XML"
		};
	ajax(param,"notice loading..");
	//var ajax = new AjaxK(param);
	//$('#task-container').modal('show');
});
function ajaxCallBack(data,readyState,status){
// 	var selector = new SelectorK("status_msg", data);
	if(STATUS_CODE_SUCCESS==$(data).find("ROOT>STATUS_CODE").text()){ //성공
		$(data).find("ROOT>RESULT>TABLE>RECODE").each(function(index){
			var title = $(this).find("TITLE").text();
			$("#notice_container").append("<div>"+title+"</div>");
			//console.log( new SelectorK("TITLE",this).get(0).textContent )
		});
	}else{	//실패
		alert("notice loading FAIL!");
	}

}
</script>
<body>
<!-- <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#alert">Windows 8 modal - Click to View</button> -->
	<%--nav--%>
	<fluid:insertView id="page-body-nav"/>
	
	

  <!-- page Start -->
    <div class="jumbotron"  style="color:rgb(255,175,15); height:500px; background: no-repeat -0px 0 / cover url(/front-end/img/IMG_9619-PANO.jpg);">
      <div class="container" style="margin-top:4em;">
        <h1>Hello, Log your life!</h1>
        <p>It analyzes to compare the Log.</p>
        <p><a class="btn btn-primary btn-lg" href="#" role="button">Learn more &raquo;</a></p>
      </div>
    </div>

    <div class="container">
      <!-- Example row of columns -->
      <div class="row">
        <div class="col-md-4">
          <h2>Heading</h2>
          <p><div id="notice_container"></div></p>
          <p>Donec id elit non mi porta gravida at eget metus. Fusce dapibus, tellus ac cursus commodo, tortor mauris condimentum nibh, ut fermentum massa justo sit amet risus. Etiam porta sem malesuada magna mollis euismod. Donec sed odio dui. </p>
          <p><a class="btn btn-default" href="#" role="button">View details &raquo;</a></p>
        </div>
        <div class="col-md-4">
          <h2>Heading</h2>
          <p>Donec id elit non mi porta gravida at eget metus. Fusce dapibus, tellus ac cursus commodo, tortor mauris condimentum nibh, ut fermentum massa justo sit amet risus. Etiam porta sem malesuada magna mollis euismod. Donec sed odio dui. </p>
          <p><a class="btn btn-default" href="#" role="button">View details &raquo;</a></p>
       </div>
        <div class="col-md-4">
          <h2>Heading</h2>
          <p>Donec sed odio dui. Cras justo odio, dapibus ac facilisis in, egestas eget quam. Vestibulum id ligula porta felis euismod semper. Fusce dapibus, tellus ac cursus commodo, tortor mauris condimentum nibh, ut fermentum massa justo sit amet risus.</p>
          <p><a class="btn btn-default" href="#" role="button">View details &raquo;</a></p>
        </div>
        
                <div class="col-md-3">
            <ul class="nav nav-stacked admin-menu">
                <li><h4>Select Resource</h4></li>
                <li class="active"><a href="#" data-target-id="home"><i class="fa fa-home fa-fw"></i>Global Permissions</a></li>
                <li><a href="http://www.jquery2dotnet.com" data-target-id="widgets"><i class="fa fa-list-alt fa-fw"></i>Security Settings</a></li>
                <li><a href="http://www.jquery2dotnet.com" data-target-id="pages"><i class="fa fa-file-o fa-fw"></i>Batch Processing</a></li>
                <li><a href="http://www.jquery2dotnet.com" data-target-id="charts"><i class="fa fa-bar-chart-o fa-fw"></i>Users</a></li>
            </ul>
        </div>
      </div>
      
      
	<!-- page END -->
	<fluid:insertView id="page-body-footer"/>
    </div> <!-- /container -->
</body>