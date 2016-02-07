<%@page import="org.json.simple.parser.JSONParser"%>
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="fluid"  uri="http://visualkhh.com/fluid"%>
<script type="text/javascript">
EventUtil.addOnloadEventListener(function(){
	var img = new Image();
	var w=50;
	//img.setAttribute('crossOrigin', 'anonymous');
	img.onload=function(e){
		var canvas = document.createElement('canvas');
		var canvasContext = canvas.getContext("2d");
		canvas.width = w;
		canvas.height = canvas.width * (img.height / img.width);

		
		  /// step 1
	    var oc = document.createElement('canvas'),
	        octx = oc.getContext('2d');

	    oc.width = img.width * 0.5;
	    oc.height = img.height * 0.5;
	    octx.drawImage(img, 0, 0, oc.width, oc.height);

	    /// step 2
	    ///octx.drawImage(oc, 0, 0, oc.width * 0.5, oc.height * 0.5);
	    canvasContext.drawImage(oc, 0, 0, oc.width, oc.height, 0, 0, canvas.width, canvas.height);
	    document.body.appendChild(canvas);
// 		var dataURI = canvas.toDataURL();
// 		callback(dataURI);
	};
	img.src="http://www.w3schools.com/images/w3schools.png";

});
</script>
<body>
	<%--nav--%>
	<%--<fluid:insertView id="page-body-nav"/> --%>
	<%--nav--%>
	<div class="container">
	<%--footer--%>
	<%--<fluid:insertView id="page-body-footer"/> --%>
	<%--footer--%>
    </div> <!-- /container -->
    <input id="photo-form-file" style="width: 100%" type="file" multiple="multiple"/>
    
    <canvas id="canvas" width="200"/>
    <img id="img" />
<!--     <img id="img" src="http://wowslider.com/sliders/demo-51/thumb.jpg"/> -->
</body>