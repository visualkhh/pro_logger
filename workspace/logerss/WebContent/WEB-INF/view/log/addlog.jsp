<%@page import="khh.web.jsp.framework.validate.rolek.RoleK"%>
<%@page import="khh.web.jsp.framework.validate.rolek.Role"%>
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="khh.property.util.PropertyUtil"%>
<%@taglib prefix="fluid"  uri="http://visualkhh.com/fluid"%>
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

EventUtil.addOnloadEventListener(function(){
	
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
	
	$('#map').click(createMap);
	$('#data').click(createData);

});


function createData(){
	var id = JavaScriptUtil.getUniqueKey();
	var container_id = "container_"+id;
	var title_id = "title_"+id;
	var move_id = "move_"+id;
	var remove_id = "remove_"+id;
	var graph_id = "graph_"+id;
	var data_id = "data_"+id;
	var applay_id = "applay_"+id;
	var save_id = "save_"+id;
	var h="";
	h+='<div id="'+container_id+'" class="panel panel-default">';
	h+='	<div class="panel-heading" style="padding:3px;">';
	h+='	<h3 class="panel-title">';
	h+='				<div class="input-group input-group-sm" >';
	h+='		  			<span class="input-group-addon"  id="sizing-addon3"><span class="fa fa-map" aria-hidden="true"></span></span>';
	h+='		  			<input id="'+title_id+'" type="text" class="form-control" placeholder="title" aria-describedby="sizing-addon3"/>';
	h+='						<span class="input-group-btn" style="padding-left:10px;">';
	h+='							<button id="'+move_id+'" class="btn btn-default" style="border-radius:4px;" type="button"><span class="fa fa-arrows" aria-hidden="true"></span></span></button>';
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
	h+='			  <input id="'+data_id+'" type="text" class="form-control" value="" placeholder="[yyyy.MM.dd HH:mm,value], [yyyy.MM.dd HH:mm,value].." aria-describedby="sizing-addon3"/>';
	h+='			<span class="input-group-btn">';
	h+='				<button id="'+applay_id+'" class="btn btn-default" type="button">apply</button>';
	h+='				<button id="'+save_id+'" class="btn btn-default" type="button">save</button>';
	h+='			</span>';
	h+='			</div>';
	h+='		</div>';
	h+='	</div>';
	h+='</div>';
	$("#container").prepend(h);
	
	$("#"+save_id).click(function(){
		$("#"+data_id).val('["2015.05.24 22:34:47","39.599998474121094"],["2015.05.25 06:09:27","61.79999923706055"],["2015.05.25 06:47:02","51.79999923706055"]');
	});
	$("#"+applay_id).click(function(){
		var data = eval("[" + $("#"+data_id).val() +"]");
		var speed_data = new Array();
		var flightPlanCoordinates = new Array();
		for (var i = 0; i < data.length; i++) {
			var yyyyMMdd = data[i][0].split(" ")[0];
			var yyyy = yyyyMMdd.split(".")[0]; 
			var MM = yyyyMMdd.split(".")[1]; 
			var dd = yyyyMMdd.split(".")[2];
			
			var HHmmss = data[i][0].split(" ")[1];
			var HH = HHmmss.split(":")[0]; 
			var mm = HHmmss.split(":")[1]; 
			var ss = HHmmss.split(":")[2];
			var d = new Date(yyyy, MM, dd, HH, mm, ss, 0);
			
			var val = data[i][1];
			speed_data.push({"x":d.getTime(),"y": Number(val)});
		}
	 	
	 	//graphk
		var graph = new GraphK("#"+graph_id);
		graph.contentTitle = "DATA";
		graph.chartDataVisible 		= false;
		graph.chartAxisScaleVisible = false;
		//graph.onMouseTraking();
		//graph.onDrag();
		graph.setMargin(0,0,0,20); 
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
		
		var graphData = new GraphDataK("data", speed_data);
		graphData.setType("linefill");
		graphData.setWidth(10);
		graphData.setFillStyle(GraphKUtil.getRandomColor());
		graphData.setStrokeStyle(GraphKUtil.getRandomColor());
		graphData.setFillStyle(GraphKUtil.getRandomColor());
		 
		var graphDataKSet = new GraphDataKSet();
		graphDataKSet.push(graphData);
		
		graph.setData(graphDataKSet);
		graph.canvas.width = $("#"+graph_id).width();
		graph.canvas.height = $("#"+graph_id).height();
		graph.rendering();
		graph.onMouseTraking();   
		graph.onDrag();
		$(window).resize(function() {
			graph.canvas.width = $("#"+graph_id).width();
			graph.canvas.height = $("#"+graph_id).height();
			graph.rendering();
		});
	});
}
function createMap(){
	var id = JavaScriptUtil.getUniqueKey();
	var container_id = "container_"+id;
	var title_id = "title_"+id;
	var move_id = "move_"+id;
	var remove_id = "remove_"+id;
	var map_id = "map_"+id;
	var graph_speed_id = "graph_speed_"+id;
	var graph_ele_id = "graph_ele_"+id;
	var data_id = "data_"+id;
	var applay_id = "applay_"+id;
	var save_id = "save_"+id;
	
	var h="";
	h+='<div id="'+container_id+'" class="panel panel-default">';
	h+='	<div class="panel-heading" style="padding:3px;">';
	h+='	<h3 class="panel-title">';
	h+='				<div class="input-group input-group-sm" >';
	h+='		  			<span class="input-group-addon"  id="sizing-addon3"><span class="fa fa-map" aria-hidden="true"></span></span>';
	h+='		  			<input id="'+title_id+'" type="text" class="form-control" placeholder="title" aria-describedby="sizing-addon3"/>';
	h+='						<span class="input-group-btn" style="padding-left:10px;">';
	h+='							<button id="'+move_id+'" class="btn btn-default" style="border-radius:4px;" type="button"><span class="fa fa-arrows" aria-hidden="true"></span></span></button>';
	h+='							<button id="'+remove_id+'" class="btn btn-default" style="border-radius:4px;" type="button"><span class="fa fa-times" aria-hidden="true"></span></button>';
	h+='						</span>';
	h+='				</div>';
	h+='	</h3>';
	h+='	</div>';
	h+='	<div class="panel-body" style="padding:0px;">';
	h+='		<div id="'+map_id+'"  style="height:300px;"></div>';
	h+='		<canvas id="'+graph_speed_id+'"  style="width:100%; height:100px;"></canvas>';
// 	h+='		<canvas id="'+graph_ele_id+'"  style="width:100%; height:100px;"></canvas>';
	h+='	</div>';
	h+='	<div class="panel-footer" style="text-align: right; padding:3px;" >';
	h+='		<div class="btn-group" role="group" >';
	h+='			<div class="input-group input-group-sm">';
	h+='			  <span class="input-group-addon" id="sizing-addon3"><span class="fa fa-file-text" aria-hidden="true"></span></span>';
	h+='			  <input id="'+data_id+'" type="text" class="form-control" value="" placeholder="[yyyy.MM.dd HH:mm,lat,long], [yyyy.MM.dd HH:mm,lat,long].." aria-describedby="sizing-addon3"/>';
	h+='			<span class="input-group-btn">';
	h+='				<button id="'+applay_id+'" class="btn btn-default" type="button">apply</button>';
	h+='				<button id="'+save_id+'" class="btn btn-default" type="button">save</button>';
	h+='			</span>';
	h+='			</div>';
	h+='		</div>';
	h+='	</div>';
	h+='</div>';
	$("#container").prepend(h);

	log["map"].push(id);
	var gsStatoin = new google.maps.LatLng(38.898102, -77.036519);
	 var mapOptions = {
				zoom: 13,
				mapTypeId: google.maps.MapTypeId.ROADMAP,
				center: gsStatoin
			  };
	var map = GmapUtil.createMap(document.getElementById(map_id),mapOptions);
	var marker = new google.maps.Marker({
		map:map,
		animation: google.maps.Animation.DROP
  	});
	
	
	$("#"+remove_id).click(function(){
		$("#"+container_id).remove();
	});
	
	
	
	$("#"+save_id).click(function(){
		$("#"+data_id).val('["2015.05.24 22:34:47","37.661733627319336","127.03786144964397"],["2015.05.24 22:34:48","37.661735471338034","127.03789724037051"],["2015.05.24 22:34:51","37.66174511052668","127.03803705051541"],["2015.05.24 22:34:52","37.66173790208995","127.03810041770339"],["2015.05.24 22:34:53","37.66173513606191","127.03817652538419"],["2015.05.24 22:34:56","37.661726754158735","127.03840853646398"],["2015.05.24 22:35:02","37.661716025322676","127.03886493109167"],["2015.05.24 22:35:03","37.66171610914171","127.03894237987697"],["2015.05.24 22:35:06","37.661711163818836","127.03917455859482"],["2015.05.24 22:35:12","37.66171853989363","127.0396351441741"],["2015.05.24 22:35:16","37.661728179082274","127.03992406837642"],["2015.05.24 22:35:19","37.66172859817743","127.04011115245521"],["2015.05.24 22:35:26","37.66173345968127","127.04053862951696"],["2015.05.24 22:35:31","37.66172599978745","127.04088035970926"],["2015.05.24 22:35:34","37.66172784380615","127.04110558144748"],["2015.05.24 22:35:36","37.66172843053937","127.04125695861876"],["2015.05.24 22:35:40","37.66173337586224","127.0415623113513"],["2015.05.24 22:35:44","37.66174896620214","127.04187453724444"],["2015.05.24 22:35:47","37.66176857985556","127.04210897907615"],["2015.05.24 22:35:48","37.66176916658878","127.04218181781471"],["2015.05.24 22:35:49","37.66176899895072","127.04225532710552"],["2015.05.24 22:35:56","37.6618130877614","127.04279746860266"],["2015.05.24 22:36:00","37.66187737695873","127.04315780662"],["2015.05.24 22:36:05","37.661954406648874","127.04358813352883"],["2015.05.24 22:36:09","37.66200419515371","127.0439197216183"],["2015.05.24 22:36:16","37.66208943910897","127.04451961442828"],["2015.05.24 22:36:17","37.662088349461555","127.04459798522294"],["2015.05.24 22:36:20","37.66209740191698","127.044846592471"],["2015.05.24 22:36:21","37.66208843328059","127.04493611119688"],["2015.05.24 22:36:24","37.6620757766068","127.0451853889972"],["2015.05.24 22:36:30","37.66211072914302","127.04571914859116"],["2015.05.24 22:36:33","37.66210570000112","127.04598150216043"],["2015.05.24 22:36:34","37.662096563726664","127.04605325125158"],["2015.05.24 22:36:35","37.66206898726523","127.04614763148129"],["2015.05.24 22:36:38","37.662027748301625","127.0463937241584"],["2015.05.24 22:36:39","37.66200536862016","127.04647343605757"],["2015.05.24 22:36:43","37.66190470196307","127.04676202498376"],["2015.05.24 22:36:45","37.6618529856205","127.04690594226122"],["2015.05.24 22:36:50","37.661772686988115","127.04719075933099"],["2015.05.24 22:36:51","37.66177696175873","127.04722202382982"],["2015.05.24 22:36:52","37.66180177219212","127.0472457446158"],["2015.05.24 22:36:54","37.66184569336474","127.04729536548257"],["2015.05.24 22:36:57","37.66188148409128","127.04744640737772"],["2015.05.24 22:37:00","37.66184686683118","127.0476339943707"],["2015.05.24 22:37:01","37.6618286781013","127.04769786447287"],["2015.05.24 22:37:06","37.66172013245523","127.04800765961409"],["2015.05.24 22:37:14","37.66158828511834","127.04852708615363"],["2015.05.24 22:37:15","37.66155978664756","127.04858936369419"],["2015.05.24 22:37:19","37.661477560177445","127.04885406419635"],["2015.05.24 22:37:21","37.661433052271605","127.0489823911339"],["2015.05.24 22:37:22","37.66141813248396","127.0490447524935"],["2015.05.24 22:37:26","37.66133121214807","127.04933040775359"],["2015.05.24 22:37:28","37.66129441559315","127.0494729001075"],["2015.05.24 22:37:33","37.661220990121365","127.04980867914855"],["2015.05.24 22:37:37","37.66115779057145","127.0500548556447"],["2015.05.24 22:37:39","37.66113733872771","127.05013372935355"],["2015.05.24 22:37:41","37.66113222576678","127.05019164830446"],["2015.05.24 22:37:44","37.66112702898681","127.0502572786063"],["2015.05.24 22:37:45","37.66112216748297","127.05027990974486"],["2015.05.24 22:37:48","37.66109920106828","127.05034470185637"],["2015.05.24 22:37:50","37.661082772538066","127.05039214342833"],["2015.05.24 22:37:53","37.66105360351503","127.05048518255353"],["2015.05.24 22:37:56","37.66104530543089","127.05053832381964"],["2015.05.24 22:37:58","37.66104228794575","127.05059330910444"],["2015.05.25 07:18:47","37.07922304049134","127.05015585757792"],');
	});
	$("#"+applay_id).click(function(){
		var data = eval("[" + $("#"+data_id).val() +"]");
		var speed_data = new Array();
		var flightPlanCoordinates = new Array();
		
		var before_date = undefined;
		var before_lat = undefined;
		var before_lng = undefined;
		for (var i = 0; i < data.length; i++) {
			var yyyyMMdd = data[i][0].split(" ")[0];
			var yyyy = yyyyMMdd.split(".")[0]; 
			var MM = yyyyMMdd.split(".")[1]; 
			var dd = yyyyMMdd.split(".")[2];
			
			var HHmmss = data[i][0].split(" ")[1];
			var HH = HHmmss.split(":")[0]; 
			var mm = HHmmss.split(":")[1]; 
			var ss = HHmmss.split(":")[2];
			var d = new Date(yyyy, MM, dd, HH, mm, ss, 0);
			
			var lat = data[i][1];
			var lng = data[i][2];
			
			if(before_date){
				var hms = 60*60*1000; 
				var bms = before_date.getTime();
				var dms = d.getTime();
				var dist_ms = dms - bms;
				
				var per =  MathUtil.getPercentByTot(dist_ms,hms);
				var dist_k = MathUtil.gpsdist(lat,lng,before_lat,before_lng,'K');
				var tt = undefined;
				if(hms>dist_ms){
					tt = MathUtil.getValuePercentUp(dist_k,per);
				}else{
					tt = MathUtil.getValuePercentDown(dist_k,100-per);
				}
				
				
				speed_data.push({"x":d.getTime(),"y": tt});
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
		var flightPath = new google.maps.Polyline({
		    path: flightPlanCoordinates,
		    strokeColor: "#FF0000",
		    strokeOpacity: 1.0,
		    strokeWeight: 2
		  });
		flightPath.setMap(null);
	 	flightPath.setMap(map);
	 	
	 	GmapUtil.fitBounds(map,flightPath);
	 	
	 	
	 	
	 	
	 	//speed graphk
		var speedGraph = new GraphK("#"+graph_speed_id);
		speedGraph.contentTitle = "SPEED";
		speedGraph.chartDataVisible 		= false;
		speedGraph.chartAxisScaleVisible = false;
		speedGraph.setMargin(20,0,0,20); //t, r, b, l 
		speedGraph.setPadding(1,1,1,1); 
		speedGraph.chartAxisXDataMinMarginPercent = 0;
		speedGraph.chartAxisXDataMaxMarginPercent = 0;
		speedGraph.chartAxisYDataMinMarginPercent = 0;
		speedGraph.chartAxisYDataMaxMarginPercent = 0;
		speedGraph.chartAxisXCount = 3;
		speedGraph.chartAxisYCount = 3;
		speedGraph.chartAxisXFnc = function(data,index){
			var date = new Date(Number(data));
			return DateUtil.getDate("HH:mm",date); 
		}
		
		var speedData = new GraphDataK("speed", speed_data);
		speedData.setType("linefill");
		speedData.setWidth(10);
		speedData.setFillStyle(GraphKUtil.getRandomColor());
		speedData.setStrokeStyle(GraphKUtil.getRandomColor());
		speedData.setFillStyle(GraphKUtil.getRandomColor());
		
		var speedDataKSet = new GraphDataKSet();
		speedDataKSet.push(speedData);
		
		speedGraph.setData(speedDataKSet);
		speedGraph.canvas.width = $("#"+graph_speed_id).width();
		speedGraph.canvas.height = $("#"+graph_speed_id).height();
		speedGraph.rendering();
		speedGraph.onMouseTraking();   
		speedGraph.onDrag();
		

// 		 var path = [
// 		             {lat: 36.579, lng: -118.292},  // Mt. Whitney
// 		             {lat: 36.606, lng: -118.0638},  // Lone Pine
// 		             {lat: 36.433, lng: -117.951},  // Owens Lake
// 		             {lat: 36.588, lng: -116.943},  // Beatty Junction
// 		             {lat: 36.34, lng: -117.468},  // Panama Mint Springs
// 		             {lat: 36.24, lng: -116.832}];  // Badwater, Death Valley
// 		var path2 =new Array();
// 		for (var z = 0; z < 400; z++) {
// 			path2.push(flightPlanCoordinates[z]);
// 		}

// 		GmapUtil.getElevation(path2,function(elevations, status){
// 			for (var i = 0; i < elevations.length; i++) {
// 				console.log(elevations[i].elevation);
// 			}
// 		});
		
// 		var eleGraph = new GraphK("#"+graph_ele_id);
// 		eleGraph.contentTitle = "ELEVATION";
// 		eleGraph.chartDataVisible 		= false;
// 		eleGraph.chartAxisScaleVisible = false;
// 		eleGraph.setMargin(20,0,0,20); //t, r, b, l 
// 		eleGraph.setPadding(1,1,1,1); 
// 		eleGraph.chartAxisXDataMinMarginPercent = 0;
// 		eleGraph.chartAxisXDataMaxMarginPercent = 0;
// 		eleGraph.chartAxisYDataMinMarginPercent = 0;
// 		eleGraph.chartAxisYDataMaxMarginPercent = 0;
// 		eleGraph.chartAxisXCount = 3;
// 		eleGraph.chartAxisYCount = 3;
// 		eleGraph.chartAxisXFnc = function(data,index){
// 			var date = new Date(Number(data));
// 			return DateUtil.getDate("HH:mm",date); 
// 		}
		
		
		
// 		var eleData = new GraphDataK("ele", ele_data);
// 		eleData.setType("linefill");
// 		eleData.setWidth(10);
// 		eleData.setFillStyle(GraphKUtil.getRandomColor());
// 		eleData.setStrokeStyle(GraphKUtil.getRandomColor());
// 		eleData.setFillStyle(GraphKUtil.getRandomColor());
		
// 		var eleDataKSet = new GraphDataKSet();
// 		eleDataKSet.push(eleData);
		
// 		eleGraph.setData(eleDataKSet);
// 		eleGraph.canvas.width = $("#"+graph_ele_id).width();
// 		eleGraph.canvas.height = $("#"+graph_ele_id).height();
// 		eleGraph.rendering();
// 		eleGraph.onMouseTraking();   
// 		eleGraph.onDrag();
		
		
		$(window).resize(function() {
// 			eleGraph.canvas.width = $("#"+graph_ele_id).width();
// 			eleGraph.canvas.height = $("#"+graph_ele_id).height();
// 			eleGraph.rendering();
			speedGraph.canvas.width = $("#"+graph_speed_id).width();
			speedGraph.canvas.height = $("#"+graph_speed_id).height();
			speedGraph.rendering();
		});
	});
	
	
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
<body>
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
  
	<div id="container" class="container-fluid" style="margin-top:23px">

	


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