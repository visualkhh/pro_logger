<%@page import="khh.web.jsp.framework.validate.rolek.RoleK"%>
<%@page import="khh.web.jsp.framework.validate.rolek.Role"%>
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="khh.property.util.PropertyUtil"%>
<%@taglib prefix="fluid"  uri="http://visualkhh.com/fluid"%>
<script type="text/javascript" src="https://maps.google.com/maps/api/js?v=3.exp&region=KR"></script>
<script type="text/javascript">
var ele_graph 	= undefined;
var cad_graph 	= undefined;
var hr_graph 	= undefined;
var atemp_graph = undefined;

$( window ).resize(function() {
	ele_graph.canvas.width = $("#ele").width();
	ele_graph.canvas.height = $("#ele").height();
	ele_graph.rendering();
	
	cad_graph.canvas.width = $("#cad").width();
	cad_graph.canvas.height = $("#cad").height();
	cad_graph.rendering();
	
	hr_graph.canvas.width = $("#hr").width();
	hr_graph.canvas.height = $("#hr").height();
	hr_graph.rendering();
	
	atemp_graph.canvas.width = $("#atemp").width();
	atemp_graph.canvas.height = $("#atemp").height();
	atemp_graph.rendering();
		
		
// 	graph1.canvas.width = $("#jumbotron").width();
// 	graph1.canvas.height = 500;;
// 	graph1.rendering();
	
	
});

var gsStatoin = new google.maps.LatLng(37.6617390755564, 127.03791291452944);
var parliament = new google.maps.LatLng(37.4781527917781, 126.88218618556971);
var marker;
var map;
EventUtil.addOnloadEventListener(function(){
	
// 	draw();
	
	
	
	
	
	
	 var mapOptions = {
				zoom: 13,
				mapTypeId: google.maps.MapTypeId.ROADMAP,
				center: gsStatoin
			  };
	map = new google.maps.Map(document.getElementById("map_canvas"),mapOptions);
			  marker = new google.maps.Marker({
				map:map,
				animation: google.maps.Animation.DROP,
				position: parliament
			  });
	  google.maps.event.addListener(map, 'click', function(event) {
			alert(event.latLng);
		});
			  
	  
	  
		ele_graph = new GraphK("#ele");
		ele_graph.chartDataVisible 		= false;
//		ele_graph.setData(graphDataKSet);
//		ele_graph.rendering();
// 		ele_graph.onMouseTraking();
// 		ele_graph.onDrag();
		ele_graph.setMargin(0,0,0,0); 
		ele_graph.setPadding(1,1,1,1);
		ele_graph.chartAxisXDataMinMarginPercent = 0;
		ele_graph.chartAxisXDataMaxMarginPercent = 0;
		ele_graph.chartAxisYDataMinMarginPercent = 0;
		ele_graph.chartAxisYDataMaxMarginPercent = 0;
		ele_graph.chartAxisXCount = 7;
		ele_graph.chartAxisYCount = 5;
		
		cad_graph = new GraphK("#cad");
		cad_graph.chartDataVisible 		= false;
// 		cad_graph.onMouseTraking();
// 		cad_graph.onDrag();
		cad_graph.setMargin(0,0,0,0); 
		cad_graph.setPadding(1,1,1,1);
		cad_graph.chartAxisXDataMinMarginPercent = 0;
		cad_graph.chartAxisXDataMaxMarginPercent = 0;
		cad_graph.chartAxisYDataMinMarginPercent = 0;
		cad_graph.chartAxisYDataMaxMarginPercent = 0;
		cad_graph.chartAxisXCount = 7;
		cad_graph.chartAxisYCount = 5;
		
		hr_graph = new GraphK("#hr");
		hr_graph.chartDataVisible 		= false;
// 		hr_graph.onMouseTraking();
// 		hr_graph.onDrag();
		hr_graph.setMargin(0,0,0,0); 
		hr_graph.setPadding(1,1,1,1);
		hr_graph.chartAxisXDataMinMarginPercent = 0;
		hr_graph.chartAxisXDataMaxMarginPercent = 0;
		hr_graph.chartAxisYDataMinMarginPercent = 0;
		hr_graph.chartAxisYDataMaxMarginPercent = 0;
		hr_graph.chartAxisXCount = 7;
		hr_graph.chartAxisYCount = 5;
		
		
		atemp_graph = new GraphK("#atemp");
		atemp_graph.chartDataVisible 		= false;
// 		atemp_graph.onMouseTraking();
// 		atemp_graph.onDrag();
		atemp_graph.setMargin(0,0,0,0); 
		atemp_graph.setPadding(1,1,1,1);
		atemp_graph.chartAxisXDataMinMarginPercent = 0;
		atemp_graph.chartAxisXDataMaxMarginPercent = 0;
		atemp_graph.chartAxisYDataMinMarginPercent = 0;
		atemp_graph.chartAxisYDataMaxMarginPercent = 0;
		atemp_graph.chartAxisXCount = 7;
		atemp_graph.chartAxisYCount = 5;
		
		
		 $("#gen").click(function(){
				var param = {
// 						"url":"/activity_953761378.gpx.xml",
						"url":"/activity_784081461.gpx.xml",
						"type":"POST",
						onSuccess : ajaxDetailLogCallBack,
						dataType:"XML"
					};
				ajax(param,"GPX data loading..request..")
		 });
				
				  
	
	
});

function ajaxDetailLogCallBack(data,readyState,status){
	var status_code = $(data).find("ROOT>STATUS_CODE").text();
	status_code = status=="200"?STATUS_CODE_SUCCESS:"999";
	var status_msg = $(data).find("ROOT>STATUS_MSG").text();
	
	if(STATUS_CODE_SUCCESS==status_code){ //성공

		 var flightPlanCoordinates = new Array();
		// var xmlDoc = $.parseXML( $("#data").val() );
		 var xml = $( data );
		 var trkpt = xml.find("trk>trkseg>trkpt"); //gps
		 var time = xml.find("trk>trkseg>trkpt>time");
		 var ele = xml.find("trk>trkseg>trkpt>ele"); 
		 var cad = xml.find("trk>trkseg>trkpt>extensions>gpxtpx\\:TrackPointExtension>gpxtpx\\:cad");//[nodeName=rs:data]
		 var hr = xml.find("trk>trkseg>trkpt>extensions>gpxtpx\\:TrackPointExtension>gpxtpx\\:hr");//[nodeName=rs:data]
		 var tp = xml.find("trk>trkseg>trkpt>extensions>gpxtpx\\:TrackPointExtension>gpxtpx\\:atemp");//[nodeName=rs:data]
		 if(cad.length<=0){
			 cad = xml.find("cad");//[nodeName=rs:data]
		 }
		 if(hr.length<=0){
			 hr = xml.find("hr");//[nodeName=rs:data]
		 }
		 if(tp.length<=0){
			 tp = xml.find("atemp");//[nodeName=rs:data]
		 }
		 
		 trkpt.each(function(index){
			 flightPlanCoordinates.push(new google.maps.LatLng($(this).attr("lat"), $(this).attr("lon")));
		 });
		 
		var graphDataKSet = new GraphDataKSet();		  
		var data = new Array();
		var x=1;
		 cad.each(function(index){
			 data.push({"x":index,"y":Number($(this).text())});
		 });
		 
		var cgraphKData = new GraphDataK("data0", data);
		cgraphKData.setType("linefill");
		cgraphKData.setWidth(10);
		cgraphKData.setFillStyle(GraphKUtil.getRandomColor());
		cgraphKData.setStrokeStyle(GraphKUtil.getRandomColor());
		cgraphKData.setFillStyle(GraphKUtil.getRandomColor());

		
		var hdata = new Array();
		hr.each(function(index){
			hdata.push({"x":index,"y":Number($(this).text())});
		 });
		var hgraphKData = new GraphDataK("data0", hdata);
		hgraphKData.setType("linefill");
		hgraphKData.setWidth(10);
		hgraphKData.setFillStyle(GraphKUtil.getRandomColor());
		hgraphKData.setStrokeStyle(GraphKUtil.getRandomColor());
		hgraphKData.setFillStyle(GraphKUtil.getRandomColor());

		
		var tdata = new Array();
		tp.each(function(index){
			tdata.push({"x":index,"y":Number($(this).text())});
		 });
		var tgraphKData = new GraphDataK("data0", tdata);
		tgraphKData.setType("linefill");
		tgraphKData.setWidth(10);
		tgraphKData.setFillStyle(GraphKUtil.getRandomColor());
		tgraphKData.setStrokeStyle(GraphKUtil.getRandomColor());
		tgraphKData.setFillStyle(GraphKUtil.getRandomColor());
		

		
		var edata = new Array();
		ele.each(function(index){
			edata.push({"x":index,"y":Number($(this).text())});
		 });
		var egraphKData = new GraphDataK("data0", edata);
		egraphKData.setType("linefill");
		egraphKData.setWidth(10);
		egraphKData.setFillStyle(GraphKUtil.getRandomColor());
		egraphKData.setStrokeStyle(GraphKUtil.getRandomColor());
		egraphKData.setFillStyle(GraphKUtil.getRandomColor());
		
		
		
		
		
		var graphDataKSet = new GraphDataKSet();
		graphDataKSet.push(cgraphKData);
		cad_graph.setData(graphDataKSet);
		cad_graph.canvas.width = $("#cad").width();
		cad_graph.canvas.height = $("#cad").height();
		cad_graph.rendering();
		cad_graph.onMouseTraking();   
		cad_graph.onDrag();           
		
		graphDataKSet = new GraphDataKSet();
		graphDataKSet.push(hgraphKData);
		hr_graph.setData(graphDataKSet);
		hr_graph.canvas.width = $("#hr").width();
		hr_graph.canvas.height = $("#hr").height();
		hr_graph.rendering();
		hr_graph.onMouseTraking();   
		hr_graph.onDrag();        
		
		graphDataKSet = new GraphDataKSet();
		graphDataKSet.push(tgraphKData);
		atemp_graph.setData(graphDataKSet);
		atemp_graph.canvas.width = $("#atemp").width();
		atemp_graph.canvas.height = $("#atemp").height();
		atemp_graph.rendering();
		atemp_graph.onMouseTraking();   
		atemp_graph.onDrag();        
		
		
		graphDataKSet = new GraphDataKSet();
		graphDataKSet.push(egraphKData);
		ele_graph.setData(graphDataKSet);
		ele_graph.canvas.width = $("#ele").width();
		ele_graph.canvas.height = $("#ele").height();
		ele_graph.rendering();
		ele_graph.onMouseTraking();   
		ele_graph.onDrag();        
		
		
		
		  var flightPath = new google.maps.Polyline({
			    path: flightPlanCoordinates,
			    strokeColor: "#FF0000",
			    strokeOpacity: 1.0,
			    strokeWeight: 2
			  });
		 flightPath.setMap(map);
		
		
	}else{	//실패
		$("#success-signin-container").hide();
		$("#error-signin-container").show();
		$("#error-signin-msg-container").html(status_msg+"("+status_code+")");
	}
}

function getTempData(name, type, width, length){
	name = name||"name";
	type = type||"line";
	width = width || 10;
	length = length || 20;
	var data = new Array();
	for(var x = 1 ; x < length; x++){
		data.push(getRandomObj(x,(Math.random() * 500).toFixed(2)));
	}
	var graphKData = new GraphDataK(name,data);
	graphKData.setType(type);
	graphKData.setWidth(width);
	graphKData.setFillStyle(GraphKUtil.getRandomColor());
	graphKData.setStrokeStyle(GraphKUtil.getRandomColor());
	graphKData.setFillStyle(GraphKUtil.getRandomColor());
	return graphKData;
} 

function getRandomObj(x,y){
	if(x==undefined)
		x = Math.random() * 500;
	if(y==undefined)
		y = Math.random() * 500;
	
	return {"x":x, "y":y};
}


function draw(){
	graph1 = new GraphK("#can1");
	
	//option
	graph1.setMargin(20,10,10,10); //t, r, b, l 
	graph1.setPadding(20,20,40,40);
	graph1.chartDataVisible 		= true;
	graph1.chartAxisScaleVisible	= true;
//		graph1.chartAxisXDataMinMarginPercent = 0;
//		graph1.chartAxisXDataMaxMarginPercent = 0;
//		graph1.chartAxisYDataMinMarginPercent = 0;
//		graph1.chartAxisYDataMaxMarginPercent = 0;
//		graph1.rChartPadding				  = 0;
//		graph1.lChartPadding				  = 0;
//		graph1.addData(getTempData("data0","line"));
//		graph1.addData(getTempData("data0","dot"));
//		graphDataKSet.push(getTempData("data2","stick")); 
	graphDataKSet.push(getTempData("data0","line"));
	graphDataKSet.push(getTempData("data0","line"));
		graphDataKSet.push(getTempData("data1","dot",5));
		graphDataKSet.push(getTempData("data3","arc",5)); 
//		graphDataKSet.push(getTempData("data3","arc",5)); 
//		graphDataKSet.push(getTempData("data3","arc",5)); 
//		graphDataKSet.push(getTempData("data3","arc",5)); 
//		graphDataKSet.push(getTempData("data3","arc",5)); 
	graph1.setData(graphDataKSet);
	graph1.rendering();
	graph1.onMouseTraking();
	graph1.onDrag();
	
// 		setInterval(function(){
// 			graph1.chartAxisXDataMin      = undefined;
// 			graph1.chartAxisXDataMax      = undefined;
// 			graph1.chartAxisXDataMin      = graphDataKSet.getDataXMax()-100;
// 			graph1.chartAxisXDataMax      = graphDataKSet.getDataXMax();
// 			graph1.chartAxisYDataMin      = undefined;
// 			graph1.chartAxisYDataMax      = undefined;
// 			for(var i = 0 ; i < graphDataKSet.length; i++){
// 				graphDataKSet[i].width = (Math.random() * 50);
// 				graphDataKSet[i].data.push(getRandomObj(graphDataKSet.getDataXMax()+1,(Math.random() * 500).toFixed(2)));
// 			}
// 			graph1.rendering();
// 		},100);
}
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
          <div class="jumbotron" id="jumbotron" >
<!--             <h1>Hello, world!</h1> -->
            <p>Detail Log.</p>
          </div>
          <div id="map_canvas" class="jumbotron" style="height:500px;"></div>
			<div class="form-group">
				<label for="comment">GPX xml data input</label>
				<textarea class="form-control" rows="5" id="data">
				</textarea>
			</div>
		<button type="button" class="btn btn-default btn-lg" id="gen">
		  <span class="glyphicon glyphicon-star" aria-hidden="true"></span> Go!
		</button>
          <div class="row">
            <div class="col-xs-12 col-lg-12">
              <h2>ele</h2>
              <canvas id="ele" class="col-xs-12 col-lg-12" style="height: 150px;"></canvas>
            </div>
            <div class="col-xs-12 col-lg-12">
              <h2>cad</h2>
              <canvas id="cad" class="col-xs-12 col-lg-12" style="height: 150px;"></canvas>
            </div>
            <div class="col-xs-12 col-lg-12">
              <h2>hr</h2>
              <canvas id="hr" class="col-xs-12 col-lg-12" style="height: 150px;"></canvas>
            </div>
            <div class="col-xs-12 col-lg-12">
              <h2>atemp</h2>
              <canvas id="atemp" class="col-xs-12 col-lg-12" style="height: 150px;"></canvas>
            </div>
<!--             <div class="col-xs-6 col-lg-4"> -->
<!--               <h2>Heading</h2> -->
<!--               <p>Donec id elit non mi porta gravida at eget metus. Fusce dapibus, tellus ac cursus commodo, tortor mauris condimentum nibh, ut fermentum massa justo sit amet risus. Etiam porta sem malesuada magna mollis euismod. Donec sed odio dui. </p> -->
<!--               <p><a class="btn btn-default" href="#" role="button">View details &raquo;</a></p> -->
<!--             </div>/.col-xs-6.col-lg-4 -->
<!--             <div class="col-xs-6 col-lg-4"> -->
<!--               <h2>Heading</h2> -->
<!--               <p>Donec id elit non mi porta gravida at eget metus. Fusce dapibus, tellus ac cursus commodo, tortor mauris condimentum nibh, ut fermentum massa justo sit amet risus. Etiam porta sem malesuada magna mollis euismod. Donec sed odio dui. </p> -->
<!--               <p><a class="btn btn-default" href="#" role="button">View details &raquo;</a></p> -->
<!--             </div>/.col-xs-6.col-lg-4 -->
<!--             <div class="col-xs-6 col-lg-4"> -->
<!--               <h2>Heading</h2> -->
<!--               <p>Donec id elit non mi porta gravida at eget metus. Fusce dapibus, tellus ac cursus commodo, tortor mauris condimentum nibh, ut fermentum massa justo sit amet risus. Etiam porta sem malesuada magna mollis euismod. Donec sed odio dui. </p> -->
<!--               <p><a class="btn btn-default" href="#" role="button">View details &raquo;</a></p> -->
<!--             </div>/.col-xs-6.col-lg-4 -->
<!--             <div class="col-xs-6 col-lg-4"> -->
<!--               <h2>Heading</h2> -->
<!--               <p>Donec id elit non mi porta gravida at eget metus. Fusce dapibus, tellus ac cursus commodo, tortor mauris condimentum nibh, ut fermentum massa justo sit amet risus. Etiam porta sem malesuada magna mollis euismod. Donec sed odio dui. </p> -->
<!--               <p><a class="btn btn-default" href="#" role="button">View details &raquo;</a></p> -->
<!--             </div>/.col-xs-6.col-lg-4 -->
<!--             <div class="col-xs-6 col-lg-4"> -->
<!--               <h2>Heading</h2> -->
<!--               <p>Donec id elit non mi porta gravida at eget metus. Fusce dapibus, tellus ac cursus commodo, tortor mauris condimentum nibh, ut fermentum massa justo sit amet risus. Etiam porta sem malesuada magna mollis euismod. Donec sed odio dui. </p> -->
<!--               <p><a class="btn btn-default" href="#" role="button">View details &raquo;</a></p> -->
<!--             </div>/.col-xs-6.col-lg-4 -->
<!--             <div class="col-xs-6 col-lg-4"> -->
<!--               <h2>Heading</h2> -->
<!--               <p>Donec id elit non mi porta gravida at eget metus. Fusce dapibus, tellus ac cursus commodo, tortor mauris condimentum nibh, ut fermentum massa justo sit amet risus. Etiam porta sem malesuada magna mollis euismod. Donec sed odio dui. </p> -->
<!--               <p><a class="btn btn-default" href="#" role="button">View details &raquo;</a></p> -->
<!--             </div>/.col-xs-6.col-lg-4 -->
          </div><!--/row-->
        </div><!--/.col-xs-12.col-sm-9-->

        <div class="col-xs-6 col-sm-3 sidebar-offcanvas" id="sidebar">
        
          <div class="list-group">
            <a href="#" class="list-group-item active">MyLogList 
			  <span class="fa fa-plus" aria-hidden="true"></span>
			</a>
            <a href="/view/mylog/detail" class="list-group-item">Link</a>
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