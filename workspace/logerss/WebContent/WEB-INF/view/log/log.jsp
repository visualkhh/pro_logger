<%@page import="khh.web.jsp.framework.validate.rolek.RoleK"%>
<%@page import="khh.web.jsp.framework.validate.rolek.Role"%>
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="khh.property.util.PropertyUtil"%>
<%@taglib prefix="fluid"  uri="http://visualkhh.com/fluid"%>
<script src="/front-end/jquery/plugin/jQuery-fileExif-master/jquery.exif.js"></script>
<script src="/front-end/javascript/visualkhh/device_util.js"></script>
<script src="/front-end/javascript/visualkhh/googlemap_util.js"></script>
<script src="/front-end/graphK/graphk_util.js"></script>
<script src="/front-end/graphK/graphk_object.js"></script>
<script src="/front-end/graphK/graphk.js"></script>
<script type="text/javascript" src="https://maps.google.com/maps/api/js?v=3.exp"></script>
<script type="text/javascript">
var from_date;
var to_date;
var log = {
		'map':new Array(),
		'data':new Array(),
		'weather':new Array(),
		'food':new Array(),
		'money':new Array(),
		'item':new Array()
};
var map;
EventUtil.addOnloadEventListener(function(){
	settingTimeLine();
	$('#map').click(function(){
		var param={
				"url":"/view/log/form/map.form",
				"data":{"id":"haha"}
		}
		loadPage(param,function(data){
			alert(data);
		});
// 		createData("map",applyMap,
// 		function(data,id){
// 			alert("save "+data);
// 		});
	});
	$('#data').click(function(){
		createData("data", drawGraph,
		function(data,id){
			alert("save "+data);
		});
	});
	$('#photo').click(function(){
		createData("data", drawGraph,
		function(data,id){
			alert("save "+data);
		});
	});

});

function transDate(data){
	var yyyyMMdd = data.split(" ")[0];
	var HHmmss = data.split(" ")[1];
	
	var yyyy = yyyyMMdd.split(".")[0]; 
	var MM = yyyyMMdd.split(".")[1]; 
	var dd = yyyyMMdd.split(".")[2];
	
	var HH = HHmmss.split(":")[0]; 
	var mm = HHmmss.split(":")[1]; 
	var ss = HHmmss.split(":")[2];
	var d = new Date(yyyy, MM, dd, HH, mm, ss, 0);
	return d;
}
function applyMap(data, id){
	var speed_data = new Array();
	var flightPlanCoordinates = new Array();
	var before_date = undefined;
	var before_lat = undefined;
	var before_lng = undefined;
	
	for (var i = 0; i < data.length; i++) {
		var d = transDate(data[i][0]);
		var lat = data[i][1];
		var lng = data[i][2];
		
		if(before_date){
			var hms = 60*60*1000; 
			var bms = before_date.getTime();
			var dms = d.getTime();
			var dist_ms = dms - bms;
			
			var per =  MathUtil.getPercentByTot(dist_ms, hms);
			var dist_k = MathUtil.gpsdist(lat,lng, before_lat, before_lng,'K');
			var tt = undefined;
			if(hms>dist_ms){
				tt = MathUtil.getValuePercentUp(dist_k,per);
			}else{
				tt = MathUtil.getValuePercentDown(dist_k,100-per);
			}
			//speed_data.push({"x":d.getTime(),"y": tt});
			speed_data.push([data[i][0], tt]);
		}
		
		//var p = new google.maps.LatLng(lat, lng);
		var p = {
				"lat":Number(lat),
				"lng":Number(lng)
		};
		flightPlanCoordinates.push(p);
		
		//before setting
		before_date = d;
		before_lat = lat;
		before_lng = lng;
	}
	
	drawGraph(id,speed_data, "SPEED");
	
	
	var map = getMap();
	var flightPath = new google.maps.Polyline({
	    path: flightPlanCoordinates,
	    strokeColor: "#FF0000",
	    strokeOpacity: 1.0,
	    strokeWeight: 2
	  });
	flightPath.setMap(null);
 	flightPath.setMap(map);
 	
 	GmapUtil.fitBounds(map,flightPath);
 	
	
}


function drawGraph(id, data, title, type){
	//var data = eval("[" + $("#"+data_id).val() +"]");
	var chart_data = new Array();
	var flightPlanCoordinates = new Array();
	for (var i = 0; i < data.length; i++) {
		var d = transDate(data[i][0]);
		var val = data[i][1];
		chart_data.push({"x":d.getTime(),"y": Number(val)});
	}
 	
 	//graphk
	var graph = new GraphK("#graph_"+id);
	graph.contentTitle = title?title:"DATA";
	graph.chartDataVisible 		= false;
	graph.chartAxisScaleVisible = false;
	//graph.onMouseTraking();
	//graph.onDrag();
	graph.setMargin(0,25,0,20); //t, r, b, l 
	graph.setPadding(1,1,1,1);
	graph.chartAxisXDataMinMarginPercent = 0;
	graph.chartAxisXDataMaxMarginPercent = 0;
	graph.chartAxisYDataMinMarginPercent = 0;
	graph.chartAxisYDataMaxMarginPercent = 0;
	graph.chartAxisXCount = 3;
	graph.chartAxisYCount = 3;
	graph.chartAxisXFnc = function(data,index){
		var date = new Date(Number(data));
		return DateUtil.getDate("HH:mm",date); 
	}
	
	var graphData = new GraphDataK("data", chart_data);
	graphData.setType("linefill");
	graphData.setWidth(10);
	graphData.setFillStyle(GraphKUtil.getRandomColor());
	graphData.setStrokeStyle(GraphKUtil.getRandomColor());
	graphData.setFillStyle(GraphKUtil.getRandomColor());
	 
	var graphDataKSet = new GraphDataKSet();
	graphDataKSet.push(graphData);
	
	graph.setData(graphDataKSet);
	graph.canvas.width = $("#graph_"+id).width();
	graph.canvas.height = $("#graph_"+id).height();
	graph.rendering();
	graph.onMouseTraking();   
	graph.onDrag();
	
	$(window).resize(function() {
		graph.canvas.width = $("#graph_"+id).width();
		graph.canvas.height = $("#graph_"+id).height();
		graph.rendering();
	});
}


function settingTimeLine(){
	var from=$('#from-date').datetimepicker({
		format: "yyyy.mm.dd hh:ii",
        weekStart: 1,
        todayBtn:  1,
		autoclose: 1,
		todayHighlight: 1,
		startView: 2,
		forceParse: 0,
        showMeridian: 0,
        minuteStep: 1
//         pickerPosition: "bottom-"
    });
	var to=$('#to-date').datetimepicker({
		format: "yyyy.mm.dd hh:ii",
        weekStart: 1,
        todayBtn:  1,
		autoclose: 1,
		todayHighlight: 1,
		startView: 2,
		forceParse: 0,
        showMeridian: 0,
        minuteStep: 1,
        pickerPosition: "bottom-left"
    });
	
	from.on('changeDate', function(ev){
		from_date = ev.date;
		from_date.setSeconds(0);
		from_date.setMilliseconds(0);
		from_date.setHours(from_date.getHours() + from_date.getTimezoneOffset()/60)
		console.log(from_date + "   "+DateUtil.getDate("yyyy.MM.dd HH:mm",from_date));
		changeDate(from_date, to_date);
	});
	to.on('changeDate', function(ev){
		to_date = ev.date;
		to_date.setSeconds(0);
		to_date.setMilliseconds(0);
		to_date.setHours(to_date.getHours() + to_date.getTimezoneOffset()/60)
		console.log(to_date + "   "+DateUtil.getDate("yyyy.MM.dd(HH:mm)",to_date));
		changeDate(from_date, to_date);
	});
}


function createData(type, callbackApply, callbackSave){
	var id = JavaScriptUtil.getUniqueKey();
	var container_id = "container_"+id;
	var title_id = "title_"+id;
	var move_id = "move_"+id;
	var remove_id = "remove_"+id;
	var graph_id = "graph_"+id;
	var data_id = "data_"+id;
	var applay_id = "applay_"+id;
	var question_id = "question_"+id;
	var save_id = "save_"+id;
	var h="";
	
	var placeholder = "[yyyy.MM.dd HH:mm:ss, value]";
	var icon ="fa-area-chart";
	if("map"==type){
		icon="fa-map";
		placeholder="[yyyy.MM.dd HH:mm:ss, latitude, longitude]";
	}else if("photo"==type){
		icon="fa-picture-o";
		//placeholder="[yyyy.MM.dd HH:mm:ss, latitude, longitude]";
	}else if("weather"==type){
		icon="fa-sun-o";
		placeholder="[yyyy.MM.dd HH:mm:ss, latitude, longitude]";
	}else if("food"==type){
		icon="fa-cutlery";
		placeholder="[yyyy.MM.dd HH:mm:ss, latitude, longitude]";
	}else if("money"==type){
		icon="fa-mone";
		placeholder="[yyyy.MM.dd HH:mm:ss, latitude, longitude]";
	}else if("item"==type){
		icon="fa-laptop";
		placeholder="[yyyy.MM.dd HH:mm:ss, latitude, longitude]";
	}
	
	
	
	h+='<div id="'+container_id+'" class="panel panel-default" style="margin-bottom:10px;">';
	h+='	<div class="panel-heading" style="padding:3px;">';
	h+='	<h3 class="panel-title">';
	h+='				<div class="input-group input-group-sm" >';
	h+='		  			<span class="input-group-addon"  id="sizing-addon3"><span class="fa '+icon+' aria-hidden="true"></span></span>';
	h+='		  			<input id="'+title_id+'" type="text" class="form-control" placeholder="title" aria-describedby="sizing-addon3"/>';
	h+='						<span class="input-group-btn" style="padding-left:10px;">';
	h+='							<button id="'+move_id+'" class="btn btn-default" style="border-radius:4px;" type="button"><span class="fa fa-bars" aria-hidden="true"></span></span></button>';
	h+='							<button id="'+remove_id+'" class="btn btn-default" style="border-radius:4px;" type="button"><span class="fa fa-times" aria-hidden="true"></span></button>';
	h+='						</span>';
	h+='				</div>';
	h+='	</h3>';
	h+='	</div>';
	h+='	<div class="panel-body" style="padding:0px;">';
	h+='		<canvas id="'+graph_id+'"  style="width:100%; height:100px;"></canvas>';
	h+='	</div>';
	h+='	<div class="panel-footer" style="text-align: right; padding:3px;" >';
	h+='		<div class="btn-group" role="group" >';
	h+='			<div class="input-group input-group-sm">';
	h+='			  <span class="input-group-addon" id="sizing-addon3"><span class="fa fa-file-text" aria-hidden="true"></span></span>';
// 	h+='			 <input type="file" name="upload" multiple="multiple" />';
	h+='			  <input id="'+data_id+'" type="text" class="form-control" value="" placeholder="'+placeholder+','+placeholder+'.." aria-describedby="sizing-addon3"/>';
	h+='			<span class="input-group-btn">';
	h+='				<button id="'+question_id+'" class="btn btn-default" type="button"><span class="fa fa-question" aria-hidden="true"></span></button>';
	h+='				<button id="'+applay_id+'" class="btn btn-default" type="button">apply</button>';
	h+='				<button id="'+save_id+'" class="btn btn-default" type="button">save</button>';
	h+='			</span>';
	h+='			</div>';
	h+='		</div>';
	h+='	</div>';
	h+='</div>';
	$("#data-container").append(h);
	
	
	$("#"+remove_id).click(function(){
		$("#"+container_id).remove();
	});
	
	$("#"+question_id).click(function(){
		alert("data format : <br>"+placeholder+",<br>"+placeholder+",<br>..");
	});
	$("#"+move_id).click(function(){
		$("#"+graph_id).toggle();
	});
	
	$("#"+save_id).click(function(){
		var data = eval("[" + $("#"+data_id).val() +"]");
		callbackSave(id,data);
	});
	$("#"+applay_id).click(function(){
		var data = eval("[" + $("#"+data_id).val() +"]");
		callbackApply(id,data);
	});
}
function getMap(){
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
	$("#map-container").show();
	return map;
}
function drawMapPolyline(latlng){

	var map = getMap();
	var speed_data = new Array();
	var flightPlanCoordinates = new Array();
	
	var before_date = undefined;
	var before_lat = undefined;
	var before_lng = undefined;
	for (var i = 0; i < latlng.length; i++) {
		var lat = data[i][0]; //lat
		var lng = data[i][1]; //lng
		
		var p = {//var p = new google.maps.LatLng(lat, lng);
				"lat":Number(lat),
				"lng":Number(lng)
		};
		flightPlanCoordinates.push(p);
	}
	
	var flightPath = new google.maps.Polyline({
	    path: flightPlanCoordinates,
	    strokeColor: "#FF0000",
	    strokeOpacity: 1.0,
	    strokeWeight: 2
	  });
	flightPath.setMap(null);
 	flightPath.setMap(map);
 	
 	GmapUtil.fitBounds(map,flightPath);
	
}



function changeDate(from_date, to_date){
	if(from_date==undefined || to_date==undefined){return;}
	
	console.log("changeDate f: "+  from_date + "   "+DateUtil.getDate("yyyy.MM.dd(HH:mm)",from_date));
	console.log("changeDate t: "+  to_date + "   "+DateUtil.getDate("yyyy.MM.dd(HH:mm)",to_date));
    var option = {
    		"min":from_date.getTime(),
    		"max":to_date.getTime(),
    		"value":0,
    		"tooltip":"always",
    		formatter: function(value) {
    			var d = new Date();
    			d.setTime(value);
//     			console.log(d);
    			return DateUtil.getDate("yyyy.MM.dd(HH:mm)",d);
    		}
    };
    $('#slider').slider('destroy')
    $('#slider').slider(option);
}



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
<body style="margin-top: 85px;">
<!-- <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#alert">Windows 8 modal - Click to View</button> -->
	<!-- nav start -->
	<fluid:insertView id="page-body-nav"/>
	<!-- nav end -->
	
	

  <!-- page Start -->
  
  <nav class="navbar-fixed-top" style="margin-top: 36px; padding: 15px; z-index: 10;">
  	<div class="row">
           <div id="from-date" class="input-group date form_datetime col-xs-5 col-md-6" style="float: left;">
<!--            		<span class="input-group-addon" style="background-color:#fff;">from</span> -->
				<span class="input-group-addon" style="padding:5px;background-color:#fff; "><span class="glyphicon glyphicon-calendar"></span></span>
				<input class="form-control" style="padding-left: 5px; padding-right: 5px; border-radius:0;" size="16" type="text" value="" readonly>
           </div>
           <div id="to-date" class="input-group date form_datetime col-xs-7 col-md-6" style="float: left;">
				<span class="input-group-addon" style="padding:5px; background-color:#fff; border-radius:0;">~ <span class="glyphicon glyphicon-calendar"></span></span>
				<input class="form-control" style="padding-left: 5px; padding-right: 5px;" size="16" type="text" value="" readonly>
				<div class="input-group-btn">
				        <button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"><span class="fa fa-plus" aria-hidden="true"></span></button>
				        <ul class="dropdown-menu dropdown-menu-right">
				          <li><a id="map" href="#"><span class="fa fa-map"></span> Map</a></li>
				          <li><a id="data" href="#"><span class="fa fa-area-chart"></span> Data</a></li>
				          <li><a id="photo" href="#"><span class="fa fa-picture-o"></span> Photo</a></li>
				          <li><a id="weather" href="#"><span class="fa fa-sun-o"></span> Weather</a></li>
				          <li><a id="food" href="#"><span class="fa fa-cutlery"></span> Food</a></li>
				          <li><a id="money" href="#"><span class="fa fa-money"></span> Money</a></li>
				          <li><a id="item" href="#"><span class="fa fa-laptop"></span> Item</a></li>
				          <!-- li role="separator" class="divider"></li-->
				        </ul>
				 </div>
           </div>
	</div>
  </nav> 
  
	<div id="map-container" class="container-fluid" style="display: none;">
		<div class="panel panel-default">
		  <div class="panel-body" id="googlemap" style="height:300px;" >
		    Panel content
		  </div>
		  <div class="panel-footer">Panel footer</div>
		</div>
	</div>
	
	
	<div id="data-container" class="container-fluid" >
	</div>
	
	<div id="slider-container" class="container-fluid" >
	  <nav class="navbar-fixed-bottom" style="padding-bottom: 10px; padding-left: 60px; padding-right: 60px;">
	  	<div class="row">
	  		<div class="col-xs-12 col-md-12">
	  			<div class="slider slider-horizontal"  style="width: 100%" id="slider"></div>
	  		</div>
	  	</div>
	  </nav> 
		<!-- page END -->
		<fluid:insertView id="page-body-footer"/>
    </div> <!-- /container -->
</body>