<%@page import="khh.web.jsp.framework.validate.rolek.RoleK"%>
<%@page import="khh.web.jsp.framework.validate.rolek.Role"%>
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="khh.property.util.PropertyUtil"%>
<%@taglib prefix="fluid"  uri="http://visualkhh.com/fluid"%>
</script>
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
	//ajax(param,"notice loading..");
	//var ajax = new AjaxK(param);
	//$('#task-container').modal('show');
});
function ajaxCallBack(data,readyState,status){
	var status_code = $(data).find("ROOT>STATUS_CODE").text();
	var status_msg = $(data).find("ROOT>STATUS_MSG").text();
	if(STATUS_CODE_SUCCESS==status_code){ //성공
		$(data).find("ROOT>RESULT>TABLE>RECODE").each(function(index){
			var title = $(this).find("TITLE").text();
			$("#notice_container").append("<div>"+title+"</div>");
		});
	}else{	//실패
		alert("notice loading FAIL!</br>"+status_msg);
	}

}
</script>
<body>
<!-- <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#alert">Windows 8 modal - Click to View</button> -->
	<%--nav--%>
	<fluid:insertView id="page-body-nav"/>
	
	

  <!-- page Start -->
    <div class="jumbotron"  style="color:rgb(255,175,15); height:400px; background: no-repeat -0px 0 / cover url(/front-end/img/cover.jpg);">
      <div class="container" >
        <h1>Hello, Log your life!</h1>
        <p>It analyzes to compare the Log.</p>
        <p><h1><span class="fa fa-bar-chart" aria-hidden="true"></span></h1></p>
<!--         <p><a class="btn btn-primary btn-lg" href="#" role="button">Learn more &raquo;</a></p> -->
      </div>
    </div>

    <div class="container">

	<h3 style="color:rgb(255,162,6);"><fluid:insertTag  name="img" id="icon" target="src"/>logers It supports many types logs.</h3>
		<div class="row">
		
		
		
		  <div class="col-sm-6 col-md-3" style="margin-bottom:55px;">
		    <div class="thumbnail" style="padding: 12px;" >
		      <div class="caption">
		        <h3>GPS Log <span class="fa fa-map"></span> </h3>
		        <p>Location-based data log support(Google Map, Tracking)</p>
<!-- 		        <p><a href="#" class="btn btn-primary" role="button">Button</a> <a href="#" class="btn btn-default" role="button">Button</a></p> -->
		      </div>
		      	<img src="/front-end/img/maplog.jpg" alt="maplog" style="border:1px solid #ddd;border-radius:10px;"/>
		    </div>
		  </div>
		
		
		  <div class="col-sm-6 col-md-3" style="margin-bottom:55px;">
		    <div class="thumbnail" style="padding: 12px;">
		      <div class="caption">
		        <h3>Data Log <span class="fa fa-area-chart"></span></h3>
		        <p>Nromal data log support(Tracking)</p>
		      </div>
		      <img src="/front-end/img/datalog.jpg" alt="maplog" style="border:1px solid #ddd;border-radius:10px;"/>
		    </div>
		  </div>
		
		
		  <div class="col-sm-6 col-md-3" style="margin-bottom:55px;">
		    <div class="thumbnail" style="padding: 12px;">
		      <div class="caption">
		        <h3>Photo Log <span class="fa fa-picture-o"></span></h3>
		        <p>Picture log support(Google Map, Tracking)</p>
		      </div>
		      <img src="/front-end/img/photolog.jpg" alt="maplog" style="border:1px solid #ddd;border-radius:10px;"/>
		    </div>
		  </div>
		  
		  <div class="col-sm-6 col-md-3" style="margin-bottom:55px;">
		    <div class="thumbnail" style="padding: 12px;" >
		      <div class="caption">
		        <h3>Message Log <span class="fa fa-envelope"></span></h3>
		        <p>Message log support(Google Map, Tracking)</p>
		      </div>
		      <img src="/front-end/img/msglog.jpg" alt="maplog" style="border:1px solid #ddd;border-radius:10px;"/>
		    </div>
		  </div>
		
		
		
		
		<div class="row">
		  <div class="col-sm-6 col-md-3" style="margin-bottom:55px;">
		    <div class="thumbnail" style="padding: 12px;" >
		      <div class="caption">
		        <h3>Open Gis <span class="fa fa-map-pin"></span></h3>
		        <p>Anonymous real-time location sharing(Google Map)</p>
		      </div>
		      <img src="/front-end/img/opengis.jpg" alt="maplog" style="border:1px solid #ddd;border-radius:10px;"/>
		    </div>
		  </div>
		</div>
		
		
		
		
		  
		  
		  
		  </div>

<!-- 	<img src="https://loger.ga/ajax/sign?email=a&password=aaaaa&MN=in"/> -->

	<!-- page END -->
	<fluid:insertView id="page-body-footer"/>
    </div> <!-- /container -->
</body>