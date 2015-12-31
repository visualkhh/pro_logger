<%@page import="khh.web.jsp.framework.validate.rolek.RoleK"%>
<%@page import="khh.web.jsp.framework.validate.rolek.Role"%>
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="khh.property.util.PropertyUtil"%>
<%@taglib prefix="fluid"  uri="http://visualkhh.com/fluid"%>
<script type="text/javascript">
var graph1 = undefined;
var graphDataKSet = new GraphDataKSet();
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
EventUtil.addOnloadEventListener(function(){
	
	draw();
	
	
	
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
//		graphDataKSet.push(getTempData("data3","arc",5)); 
//		graphDataKSet.push(getTempData("data3","arc",5)); 
//		graphDataKSet.push(getTempData("data3","arc",5)); 
//		graphDataKSet.push(getTempData("data3","arc",5)); 
//		graphDataKSet.push(getTempData("data3","arc",5)); 
//		graphDataKSet.push(getTempData("data3","arc",5)); 
//		graphDataKSet.push(getTempData("data3","arc",5)); 
//		graphDataKSet.push(getTempData("data3","arc",5)); 
//		graphDataKSet.push(getTempData("data3","arc",5)); 
//		graphDataKSet.push(getTempData("data3","arc",5)); 
//		graphDataKSet.push(getTempData("data3","arc",5)); 
//		graphDataKSet.push(getTempData("data3","arc",5)); 
//		graphDataKSet.push(getTempData("data3","arc",5)); 
//		graphDataKSet.push(getTempData("data3","arc",5)); 
//		graphDataKSet.push(getTempData("data3","arc",5)); 
//		graphDataKSet.push(getTempData("data3","arc",5)); 
//		graphDataKSet.push(getTempData("data3","arc",5)); 
//		graphDataKSet.push(getTempData("data3","arc",5)); 
//		graphDataKSet.push(getTempData("data3","arc",5)); 
//		graphDataKSet.push(getTempData("data3","arc",5)); 
//		graphDataKSet.push(getTempData("data3","arc",5)); 
//		graphDataKSet.push(getTempData("data3","arc",5)); 
//		graphDataKSet.push(getTempData("data3","arc",5)); 
//		graphDataKSet.push(getTempData("data3","arc",5)); 
//		graphDataKSet.push(getTempData("data3","arc",5)); 
//		graphDataKSet.push(getTempData("data3","arc",5)); 
//		graphDataKSet.push(getTempData("data3","arc",5)); 
//		graphDataKSet.push(getTempData("data3","arc",5)); 
//		graphDataKSet.push(getTempData("data3","arc",5)); 
//		graphDataKSet.push(getTempData("data3","arc",5)); 
//		graphDataKSet.push(getTempData("data3","arc",5)); 
//		graphDataKSet.push(getTempData("data3","arc",5)); 
//		graphDataKSet.push(getTempData("data3","arc",5)); 
//		graphDataKSet.push(getTempData("data3","arc",5)); 
//		graphDataKSet.push(getTempData("data3","arc",5)); 
//		graphDataKSet.push(getTempData("data3","arc",5)); 
//		graphDataKSet.push(getTempData("data3","arc",5)); 
//		graphDataKSet.push(getTempData("data3","arc",5)); 
//		graphDataKSet.push(getTempData("data3","arc",5)); 
//		graphDataKSet.push(getTempData("data3","arc",5)); 
//		graphDataKSet.push(getTempData("data3","arc",5)); 
//		graphDataKSet.push(getTempData("data3","arc",5)); 
//		graphDataKSet.push(getTempData("data3","arc",5)); 
//		graphDataKSet.push(getTempData("data3","arc",5)); 
//		graphDataKSet.push(getTempData("data3","arc",5)); 
//		graphDataKSet.push(getTempData("data3","arc",5)); 
//		graphDataKSet.push(getTempData("data3","arc",5)); 
//		graphDataKSet.push(getTempData("data3","arc",5)); 
//		graphDataKSet.push(getTempData("data3","arc",5)); 
//		graphDataKSet.push(getTempData("data3","arc",5)); 
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
          <div class="jumbotron" id="jumbotron">
          <canvas id="can1" width="700" height="500"></canvas>
<!--             <h1>Hello, world!</h1> -->
<!--             <p>This is an example to show the potential of an offcanvas layout pattern in Bootstrap. Try some responsive-range viewport sizes to see it in action.</p> -->
          </div>
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