<%@page import="khh.web.jsp.framework.validate.rolek.RoleK"%>
<%@page import="khh.web.jsp.framework.validate.rolek.Role"%>
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="khh.property.util.PropertyUtil"%>
<%@taglib prefix="fluid"  uri="http://visualkhh.com/fluid"%>
<script type="text/javascript" src="https://maps.google.com/maps/api/js?v=3.exp&region=KR"></script>
<script type="text/javascript">
var graph1 = undefined;

$( window ).resize(function() {
	console.log($("#jumbotron").width()+" "+$("#jumbotron").height());
	$("#can1").width($("#jumbotron").width());
// 	$("#can1").height($("#jumbotron").height());
	$("#can1").height("500");
	//draw();
	graph1.canvas.width = $("#jumbotron").width();
// 	graph1.canvas.height = $("#jumbotron").height();
	graph1.canvas.height = 500;;
	graph1.rendering();
	
	
});

var gsStatoin = new google.maps.LatLng(37.48144560453497, 126.88266361877436);
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


			  map = new google.maps.Map(document.getElementById("map_canvas"),
				  mapOptions);

			  marker = new google.maps.Marker({
				map:map,
				animation: google.maps.Animation.DROP,
				position: parliament
			  });
//			  google.maps.event.addListener(marker, 'click', toggleBounce);

			  google.maps.event.addListener(map, 'click', function(event) {
					alert(event.latLng);
				});
			  
			  
// 			  var flightPlanCoordinates = [
// 			                               new google.maps.LatLng(37.6617390755564, 127.03791291452944),
// 			                               new google.maps.LatLng(21.291982, -157.821856),
// 			                               new google.maps.LatLng(-18.142599, 178.431),
// 			                               new google.maps.LatLng(-27.46758, 153.027892)
// 			                             ];
			  


				  //flightPath.setMap(map);
				  
// 	graph1.setData(graphDataKSet);
// 	graph1.rendering();
// 	graph1.onMouseTraking();
// 	graph1.onDrag();
				 $("#gen").click(function(){
					 var flightPlanCoordinates = new Array();
					 var xmlDoc = $.parseXML( $("#data").val() );
					 var xml = $( xmlDoc );
					 var trkpt = xml.find( "trkpt" );
					 var el = xml.find( "ele" );
					 var cad = xml.find( "gpxtpx\\:cad" );//[nodeName=rs:data]
					 var hr = xml.find( "gpxtpx\\:hr" );//[nodeName=rs:data]
					 var tp = xml.find( "gpxtpx\\:atemp" );//[nodeName=rs:data]

					 trkpt.each(function(index){
						 flightPlanCoordinates.push(new google.maps.LatLng($(this).attr("lat"), $(this).attr("lon")));
					 });
					 
					var graphDataKSet = new GraphDataKSet();		  
					var data = new Array();
					var x=1;
					 cad.each(function(index){
						 data.push({"x":index,"y":Number($(this).text())});
						 //console.log(index+", "+$(this).text());
					 });
					 
					var graphKData = new GraphDataK("data0", data);
					graphKData.setType("line");
					graphKData.setWidth(10);
					graphKData.setFillStyle(GraphKUtil.getRandomColor());
					graphKData.setStrokeStyle(GraphKUtil.getRandomColor());
					graphKData.setFillStyle(GraphKUtil.getRandomColor());

					
					var hdata = new Array();
					hr.each(function(index){
						hdata.push({"x":index,"y":Number($(this).text())});
					 });
					var hgraphKData = new GraphDataK("data0", hdata);
					hgraphKData.setType("line");
					hgraphKData.setWidth(10);
					hgraphKData.setFillStyle(GraphKUtil.getRandomColor());
					hgraphKData.setStrokeStyle(GraphKUtil.getRandomColor());
					hgraphKData.setFillStyle(GraphKUtil.getRandomColor());

					
					var tdata = new Array();
					tp.each(function(index){
						tdata.push({"x":index,"y":Number($(this).text())});
					 });
					var tgraphKData = new GraphDataK("data0", tdata);
					tgraphKData.setType("line");
					tgraphKData.setWidth(10);
					tgraphKData.setFillStyle(GraphKUtil.getRandomColor());
					tgraphKData.setStrokeStyle(GraphKUtil.getRandomColor());
					tgraphKData.setFillStyle(GraphKUtil.getRandomColor());
					

					
					var edata = new Array();
					el.each(function(index){
						edata.push({"x":index,"y":Number($(this).text())});
					 });
					var egraphKData = new GraphDataK("data0", edata);
					egraphKData.setType("line");
					egraphKData.setWidth(10);
					egraphKData.setFillStyle(GraphKUtil.getRandomColor());
					egraphKData.setStrokeStyle(GraphKUtil.getRandomColor());
					egraphKData.setFillStyle(GraphKUtil.getRandomColor());
					
					
					
					
					
					var graphDataKSet = new GraphDataKSet();
					graphDataKSet.push(graphKData);
					graphDataKSet.push(hgraphKData);
					graphDataKSet.push(tgraphKData);
					graphDataKSet.push(egraphKData);
					graph1 = new GraphK("#can1");
					graph1.chartDataVisible 		= false;
					graph1.setData(graphDataKSet);
					graph1.rendering();
					graph1.onMouseTraking();
					graph1.onDrag();
					
					
					
					  var flightPath = new google.maps.Polyline({
						    path: flightPlanCoordinates,
						    strokeColor: "#FF0000",
						    strokeOpacity: 1.0,
						    strokeWeight: 2
						  });
					 flightPath.setMap(map);
				 });
				
				  
	
	
});

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
          <div id="map_canvas" class="jumbotron" style="height:500px;"></div>
          <div class="jumbotron" id="jumbotron" >
          <canvas id="can1" width="700" height="500"></canvas>
<!--             <h1>Hello, world!</h1> -->
<!--             <p>This is an example to show the potential of an offcanvas layout pattern in Bootstrap. Try some responsive-range viewport sizes to see it in action.</p> -->
          </div>
			<div class="form-group">
				<label for="comment">Comment:</label>
				<textarea class="form-control" rows="5" id="data"></textarea>
			</div>
		<button type="button" class="btn btn-default btn-lg" id="gen">
		  <span class="glyphicon glyphicon-star" aria-hidden="true"></span> Star
		</button>
          <div class="row">
            <div class="col-xs-6 col-lg-4">
              <h2>Heading</h2>
              <p>Donec id elit non mi porta gravida at eget metus. Fusce dapibus, tellus ac cursus commodo, tortor mauris condimentum nibh, ut fermentum massa justo sit amet risus. Etiam porta sem malesuada magna mollis euismod. Donec sed odio dui. </p>
              <p><a class="btn btn-default" href="#" role="button">View details &raquo;</a></p>
            </div><!--/.col-xs-6.col-lg-4-->
            <div class="col-xs-6 col-lg-4">
              <h2>Heading</h2>
              <p>Donec id elit non mi porta gravida at eget metus. Fusce dapibus, tellus ac cursus commodo, tortor mauris condimentum nibh, ut fermentum massa justo sit amet risus. Etiam porta sem malesuada magna mollis euismod. Donec sed odio dui. </p>
              <p><a class="btn btn-default" href="#" role="button">View details &raquo;</a></p>
            </div><!--/.col-xs-6.col-lg-4-->
            <div class="col-xs-6 col-lg-4">
              <h2>Heading</h2>
              <p>Donec id elit non mi porta gravida at eget metus. Fusce dapibus, tellus ac cursus commodo, tortor mauris condimentum nibh, ut fermentum massa justo sit amet risus. Etiam porta sem malesuada magna mollis euismod. Donec sed odio dui. </p>
              <p><a class="btn btn-default" href="#" role="button">View details &raquo;</a></p>
            </div><!--/.col-xs-6.col-lg-4-->
            <div class="col-xs-6 col-lg-4">
              <h2>Heading</h2>
              <p>Donec id elit non mi porta gravida at eget metus. Fusce dapibus, tellus ac cursus commodo, tortor mauris condimentum nibh, ut fermentum massa justo sit amet risus. Etiam porta sem malesuada magna mollis euismod. Donec sed odio dui. </p>
              <p><a class="btn btn-default" href="#" role="button">View details &raquo;</a></p>
            </div><!--/.col-xs-6.col-lg-4-->
            <div class="col-xs-6 col-lg-4">
              <h2>Heading</h2>
              <p>Donec id elit non mi porta gravida at eget metus. Fusce dapibus, tellus ac cursus commodo, tortor mauris condimentum nibh, ut fermentum massa justo sit amet risus. Etiam porta sem malesuada magna mollis euismod. Donec sed odio dui. </p>
              <p><a class="btn btn-default" href="#" role="button">View details &raquo;</a></p>
            </div><!--/.col-xs-6.col-lg-4-->
            <div class="col-xs-6 col-lg-4">
              <h2>Heading</h2>
              <p>Donec id elit non mi porta gravida at eget metus. Fusce dapibus, tellus ac cursus commodo, tortor mauris condimentum nibh, ut fermentum massa justo sit amet risus. Etiam porta sem malesuada magna mollis euismod. Donec sed odio dui. </p>
              <p><a class="btn btn-default" href="#" role="button">View details &raquo;</a></p>
            </div><!--/.col-xs-6.col-lg-4-->
          </div><!--/row-->
        </div><!--/.col-xs-12.col-sm-9-->

        <div class="col-xs-6 col-sm-3 sidebar-offcanvas" id="sidebar">
        
          <div class="list-group">
            <a href="#" class="list-group-item active">MyLogList 
			  <span class="fa fa-plus" aria-hidden="true"></span>
			</a>
            <a href="#" class="list-group-item">Link</a>
            <a href="#" class="list-group-item">Link</a>
            <a href="#" class="list-group-item">Link</a>
            <a href="#" class="list-group-item">Link</a>
            <a href="#" class="list-group-item">Link</a>
            <a href="#" class="list-group-item">Link</a>
            <a href="#" class="list-group-item">Link</a>
            <a href="#" class="list-group-item">Link</a>
            <a href="#" class="list-group-item">Link</a>
          </div>
        </div><!--/.sidebar-offcanvas-->
      </div><!--/row-->

	<!-- page END -->
	<fluid:insertView id="page-body-footer"/>
    </div> <!-- /container -->
</body>