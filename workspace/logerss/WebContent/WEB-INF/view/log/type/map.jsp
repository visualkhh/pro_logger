<%@page import="khh.web.jsp.framework.validate.rolek.RoleK"%>
<%@page import="khh.web.jsp.framework.validate.rolek.Role"%>
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="khh.property.util.PropertyUtil"%>
<%@taglib prefix="fluid"  uri="http://visualkhh.com/fluid"%>
<!-- <script type="text/javascript" src="https://maps.google.com/maps/api/js?v=3.exp&region=KR"></script> -->
<script type="text/javascript" src="https://maps.google.com/maps/api/js?v=3.exp"></script>
<script type="text/javascript">
var gsStatoin = new google.maps.LatLng(38.898102, -77.036519);
// var parliament = new google.maps.LatLng(38.898102, -77.036519);
var marker;
var map;
EventUtil.addOnloadEventListener(function(){
	 var mapOptions = {
				zoom: 13,
				mapTypeId: google.maps.MapTypeId.ROADMAP,
				center: gsStatoin
			  };
	map = new google.maps.Map(document.getElementById("map_canvas"),mapOptions);
			  marker = new google.maps.Marker({
				map:map,
				animation: google.maps.Animation.DROP
				//,position: parliament
			  });
			  
	$("#apply").click(function(){
		var flightPlanCoordinates = new Array();
		var userData = eval($("#data"));
		 trkpt.each(function(index){
			 flightPlanCoordinates.push(new google.maps.LatLng($(this).attr("lat"), $(this).attr("lon")));
		 });
		 
		  var flightPath = new google.maps.Polyline({
			    path: flightPlanCoordinates,
			    strokeColor: "#FF0000",
			    strokeOpacity: 1.0,
			    strokeWeight: 2
			  });
		 flightPath.setMap(map);
	});
});

var lat;
var lng;
function geo(){
	if (navigator.geolocation) {
	    navigator.geolocation.getCurrentPosition(function(position) {
	        $("#jumbotron").html("Latitude: " + position.coords.latitude +
	        "<br>Longitude: " + position.coords.longitude+
	        "<br>speed: "+position.coords.speed+
	        "<br>altitude: "+position.coords.altitude);
	        lat = position.coords.latitude;
	        lng = position.coords.longitude;
	        saveGIS();
	        
	    });
	}
	
}



function saveGIS(){
	var param = {
			url:"/ajax/gis",
			type:"POST",
			data:{
				"lat":lat,
				"lng":lng,
				"MN":"save"
			},
			//onBeforeProcess:ajaxBefore,
			onSuccess:ajaxNewLogCallBack,
			//onComplete:ajaxComplete,
			dataType:"XML"
		};
	ajax(param,"notice loading..");
}
function ajaxNewLogCallBack(data,readyState,status){
	var status_code = $(data).find("ROOT>STATUS_CODE").text();
	var status_msg = $(data).find("ROOT>STATUS_MSG").text();
	if(STATUS_CODE_SUCCESS==status_code){ //성공
		setTimeout(geo, "3000");
// 		$(data).find("ROOT>RESULT>TABLE>RECODE").each(function(index){
// 			alert("Success");
// 		});
	}else{	//실패
		alert("notice loading FAIL!</br>"+status_msg);
	}

}
</script>
<body>
<!-- <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#alert">Windows 8 modal - Click to View</button> -->
	<!-- nav start -->
	<fluid:insertView id="page-body-nav"/>
	<!-- nav end -->
	
	

  <!-- page Start -->
	<div class="container">
	<div><span class="fa fa-map" aria-hidden="true"></span> Map</div>
	<div id="map_canvas" class="jumbotron" style="height:500px;"></div>
	<div class="panel panel-default">
		<div class="panel-heading"> <h3 class="panel-title">
		Data input <span class="fa fa-file-text" aria-hidden="true"></span></h3> 
		</div> 
		<div class="panel-body">
			<textarea class="form-control" rows="5" id="data" placeholder='[ ["longitude" , "latitude"],["longitude" , "latitude"], ...]'></textarea>
		</div>
		<div class="panel-footer" style="text-align: right;" >
			<div class="btn-group" role="group" >
				<button id="apply" type="button" class="btn btn-default" aria-label="Left Align">
		  		<span class="fa fa-map-o" aria-hidden="true"></span> apply
		  		</button>
				<button id="save" type="button" class="btn btn-default" aria-label="Left Align">
				<span class="fa fa-file" aria-hidden="true"></span> save
				</button>
			</div>
		</div>
	</div>



	<div class="row">
			<div class="col-xs-6 col-md-4" style="text-align: center; height:17em;">
				<span class="fa fa-map fa-fw4x" aria-hidden="true"></span>
				<h2>Map</h2>
				<p>location log
					<span class="fa fa-clock-o" aria-hidden="true"/>
					<span class="fa fa-bar-chart" aria-hidden="true"/>
				</p>
				<p><a class="btn btn-default" href="#" role="button">add log<span class="fa fa-plus" aria-hidden="true"></span></a></p>
			</div>
            
			<div class="col-xs-6 col-md-4" style="text-align: center; height:17em;">
				<span class="fa fa-area-chart fa-fw4x" aria-hidden="true"></span>
				<h2>Data</h2>
				<p>Data log
					<span class="fa fa-clock-o" aria-hidden="true"/>
				</p>
				<p><a class="btn btn-default" href="#" role="button">add log<span class="fa fa-plus" aria-hidden="true"></span></a></p>
			</div>
            
			<div class="col-xs-6 col-md-4" style="text-align: center; height:17em;">
				<span class="fa fa-sun-o fa-fw4x" aria-hidden="true"></span>
				<h2>Weather</h2>
				<p>Weather log</p>
				<p><a class="btn btn-default" href="#" role="button">add log<span class="fa fa-plus" aria-hidden="true"></span></a></p>
			</div>
			<div class="col-xs-6 col-md-4" style="text-align: center; height:17em;">
				<span class="fa fa-cutlery fa-fw4x" aria-hidden="true"></span>
				<h2>Food</h2>
				<p>Food log</p>
				<p><a class="btn btn-default" href="#" role="button">add log<span class="fa fa-plus" aria-hidden="true"></span></a></p>
			</div>
	            
			<div class="col-xs-6 col-md-4" style="text-align: center; height:17em;">
				<span class="fa fa-users fa-fw4x" aria-hidden="true"></span>
				<h2>Human</h2>
				<p>human relations log</p>
				<p><a class="btn btn-default" href="#" role="button">add log<span class="fa fa-plus" aria-hidden="true"></span></a></p>
			</div>
			<div class="col-xs-6 col-md-4" style="text-align: center; height:17em;">
				<span class="fa fa-money fa-fw4x" aria-hidden="true"></span>
				<h2>Money</h2>
				<p>money log</p>
				<p><a class="btn btn-default" href="#" role="button">add log<span class="fa fa-plus" aria-hidden="true"></span></a></p>
			</div>
	            
			<div class="col-xs-6 col-md-4" style="text-align: center; height:17em;">
				<span class="fa fa-laptop fa-fw4x" aria-hidden="true"></span>
				<h2>Item</h2>
				<p>Item log</p>
				<p><a class="btn btn-default" href="#" role="button">add log<span class="fa fa-plus" aria-hidden="true"></span></a></p>
			</div>
	</div>
	

	<!-- page END -->
	<fluid:insertView id="page-body-footer"/>
    </div> <!-- /container -->
</body>