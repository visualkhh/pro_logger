<%@page import="khh.web.jsp.framework.validate.rolek.RoleK"%>
<%@page import="khh.web.jsp.framework.validate.rolek.Role"%>
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="khh.property.util.PropertyUtil"%>
<%@taglib prefix="fluid"  uri="http://visualkhh.com/fluid"%>
<script src="/front-end/javascript/visualkhh/device_util.js"></script>
<script src="/front-end/javascript/visualkhh/googlemap_util.js"></script>
<script type="text/javascript" src="https://maps.google.com/maps/api/js?v=3.exp&language=en_us"></script>
<script type="text/javascript">
var map;
var myMarker = null;
var outherMarkers = new Array();;
var lat;
var lng;
EventUtil.addOnloadEventListener(function(){
	if(!map){
		var gsStatoin = new google.maps.LatLng(38.898102, -77.036519);
		var mapOptions = {
			zoom: 13,
			mapTypeId: google.maps.MapTypeId.ROADMAP,
			center: gsStatoin
		};
		map = GmapUtil.createMap(document.getElementById("googlemap"),mapOptions);
		var marker = new google.maps.Marker({
			map:map,
			animation: google.maps.Animation.DROP
	 	});
	}
	//geo();
	geo();
	setInterval(function(){ geo(); }, 2000);
	
	
	$("#refresh").click(function(){
		geo();
	});
	$("#mygis").click(function(){
		geo();
		GmapUtil.move(map,lat,lng);
	});
	$("#see").click(function(){
		GmapUtil.fitBoundsMarkerArry(map,outherMarkers);
	});
	
});
 

function geo(){
	GPSUtil.getGPS(function(geo){
		var markerop = {label:'M',icon:"http://mt.google.com/vt/icon?color=ff004C13&name=icons/spotlight/spotlight-waypoint-a.png",animation: google.maps.Animation.DROP};
		if(myMarker){
			GmapUtil.removeMarker(map,myMarker);
			//myMarker.setMap(map);
			myMarker = null;
			myMarker = undefined;
			myMarker = GmapUtil.createMarker(map,geo.latitude,geo.longitude,markerop);
		}else{
			myMarker = GmapUtil.createMarker(map,geo.latitude,geo.longitude,markerop);
			GmapUtil.move(map,geo.latitude,geo.longitude);
			getGIS();
		};
		
		lat = geo.latitude;
		lng = geo.longitude;
		//getGis();
	});
	
	getGIS();
}



function getGIS(){
	var param = {
			url:"/ajax/gis",
			type:"POST",
			data:{
				"lat":lat,
				"lng":lng,
				"MN":"get"
			},
			onSuccess:ajaxNewLogCallBack,
			dataType:"XML"
		};
	ajax(param,"gis loading..",false);
}

function ajaxNewLogCallBack(data,readyState,status){
	
	for (var i = 0; i < outherMarkers.length; i++) {
		GmapUtil.removeMarker(map,outherMarkers[i]);
	}
	outherMarkers = [];  //clear
	 
	
	
	var status_code = $(data).find("ROOT>STATUS_CODE").text();
	var status_msg = $(data).find("ROOT>STATUS_MSG").text();
	if(STATUS_CODE_SUCCESS==status_code){ //성공
		$(data).find("ROOT>RESULT>TABLE>RECODE").each(function(index){
			outherMarkers.push(GmapUtil.createMarker(map,Number($(this).find("LAT").text()), Number($(this).find("LNG").text())));
			var title = $(this).find("TITLE").text();
			$("#notice_container").append("<div>"+title+"</div>");
		});
	}else{	//실패
		alert("gis data load FAIL!</br>"+status_msg);
	}
}
</script>
<body>
	<!-- nav start -->
	<fluid:insertView id="page-body-nav"/>
	<!-- nav end -->
	
  <!-- page Start -->
	
	<div id="map-container" class="container-fluid" style="width:100%;height: 82%;position: absolute;">
		<div class="panel panel-default" style="width:100%;height: 100%;">
		  <div class="panel-body" id="googlemap" style="width:100%; ;height: 100%;" >
		  </div>
		  <div class="panel-footer">
		  	<button id="refresh" class="btn btn-default" style="border-radius:4px;" type="button"><span class="fa fa-refresh" aria-hidden="true"></span></span></button>
		  	<button id="mygis" class="btn btn-default" style="border-radius:4px;" type="button"><span class="fa fa-map-marker" aria-hidden="true"></span></span></button>
		  	<button id="see" class="btn btn-default" style="border-radius:4px;" type="button"><span class="fa fa-eye" aria-hidden="true"></span></span></button>
		  open gis
		  </div>
		</div>
    </div> <!-- /container -->
</body>