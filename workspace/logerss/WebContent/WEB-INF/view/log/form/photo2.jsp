<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<div id="photo-form-container" class="panel panel-default" style="margin-bottom:10px;">
	<div class="panel-heading" style="padding:3px;">
	<h3 class="panel-title">
				<div class="input-group input-group-sm" >
		  			<span class="input-group-addon"  id="sizing-addon3"><span class="fa fa-map" aria-hidden="true"></span></span>
		  			<input id="data-form-title"  value="${param.title}" type="text" class="form-control" placeholder="title" aria-describedby="sizing-addon3"/>
				</div>
	</h3>
	</div>
	<div id="photo-form-body" class="panel-body" style="padding:0px;">
	</div>
	<div class="panel-footer" style="text-align: right; padding:3px;" >
	<input id="photo-form-file" type="file" multiple="multiple"/>
	</div>
</div>

<script type="text/javascript">

function addImg(imgSource){
	var h="";
 h+='  <div class="thumbnail">';
 h+='  <img src="'+imgSource+'">';
 h+='  <div class="caption" style="padding: 0px;">';
h+='		<div class="input-group input-group-sm" >';
h+='			<span class="input-group-addon"  id="sizing-addon3"><span class="fa fa-calendar-check-o" aria-hidden="true"/></span>';
h+='			<input id="data-form-title"  type="text" class="form-control" placeholder="yyyy.MM.dd HH:mm:ss" aria-describedby="sizing-addon3"/>';
h+='			<span class="input-group-addon"  id="sizing-addon3"><span class="fa fa-map" aria-hidden="true"/></span>';
h+='			<input id="data-form-title"   type="text" class="form-control" placeholder="latitude, longitude" aria-describedby="sizing-addon3"/>';
h+='			<span class="input-group-btn">';
h+='	        <button id="remove" class="btn btn-default"  type="button"><span class="fa fa-times" aria-hidden="true"></span></button>';
h+='	        </span>';
h+='		</div>';
 h+='  </div>';
 h+='</div>';
 var newPhoto = $(h);
 $("#photo-form-body").append(newPhoto);
}

$('#photo-form-file').change(function(){
	debugger;
	var files = event.target.files;
	var l ="";
	for (var i = 0; i < files.length; i++) {
		//l+=files[i]+"<br>";
		var f = files[i];
		if (!f.type.match('image.*')) {
        	continue;
		}
		var reader = new FileReader();
	      // Closure to capture the file information.
	    reader.onload = (function(theFile) {
	      return function(e) {
	    	  addImg(e.target.result);
	      };
	    })(f);
		 // Read in the image file as a data URL.
		reader.readAsDataURL(f);
	} 

})
</script>