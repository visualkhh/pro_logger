<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<div id="photo-form-container" class="panel panel-default" style="margin-bottom:10px;">
	<div class="panel-heading" style="padding:3px;">
	<h3 class="panel-title">
				<div class="input-group input-group-sm" >
		  			<span class="input-group-addon"  id="sizing-addon3"><span class="fa fa-map" aria-hidden="true"></span></span>
		  			<input id="photo-form-title"  value="${param.title}" type="text" class="form-control" placeholder="title" aria-describedby="sizing-addon3"/>
				</div>
	</h3>
	</div>
	<div id="photo-form-body" class="panel-body" style="padding:0px; ">
	</div>
	<div class="panel-footer" style="text-align: right; padding:3px;" >
	<input id="photo-form-file" style="width: 100%" type="file" multiple="multiple"/>
	</div>
</div>
<script type="text/javascript">

function addImg(imgBase64,date,latlgn){
	
	var id=JavaScriptUtil.getUniqueKey();
	var contentId	= 'photo-form-content-'+id;
	var removeId	= 'photo-form-content-remove-'+id;
	var h="";
	 	 h+='  <div id="'+contentId+'" name="photo-form-content" class="thumbnail">';
		 h+='  <img  name="photo-form-content-photo" src="'+imgBase64+'">';
		 h+='  <div class="caption" style="padding: 0px;">';
		 h+='		<div class="input-group input-group-sm" >';
		 h+='			<span class="input-group-addon" background-color: #fff id="sizing-addon3"><span class="fa fa-calendar-check-o" aria-hidden="true"/></span>';
		 h+='			<input name="photo-form-content-date" value="'+(date||"")+'"  type="text" class="form-control" placeholder="yyyy.MM.dd HH:mm:ss" aria-describedby="sizing-addon3"/>';
		 h+='			<span class="input-group-addon"  id="sizing-addon3"><span class="fa fa-map" aria-hidden="true"/></span>';
		 h+='			<input name="photo-form-content-latlng"  value="'+(latlgn||"")+'"  type="text" class="form-control" placeholder="latitude, longitude" aria-describedby="sizing-addon3"/>';
		 h+='			<span class="input-group-btn">';
		 h+='	        <button id="'+removeId+'" class="btn btn-default"  type="button"><span class="fa fa-times" aria-hidden="true"></span></button>';
		 h+='	        </span>';
		 h+='		</div>';
		 h+='  </div>';
		 h+='</div>';
	 var newPhoto = $(h);
	 newPhoto.find("#"+removeId).click(function(){
		 $("#"+contentId).remove();
	 });
	 $("#photo-form-body").append(newPhoto);
// 	ImageUtil.thumbnailToBase64(imgBase64,300,function(thbase64){
// 	})
	
	
 return id;
}

$('#photo-form-file').change(function(){
// 	debugger;
	var files = event.target.files;
	var l ="";
	for (var i = 0; i < files.length; i++) {
		//l+=files[i]+"<br>";
		var file = files[i];
		if (!file.type.match('image.*')) {
        	continue;
		}
		
		
	    EXIF.getData(file, function() {
	    	var date = this.exifdata.DateTime||"";
	    	var latlgn="";
	    	if(this.exifdata.GPSLatitude && this.exifdata.GPSLongitude){
	    		var lat = Number(this.exifdata.GPSLatitude[0]) + ( Number(this.exifdata.GPSLatitude[1])/60 ) + ( Number(this.exifdata.GPSLatitude[2])/3600 );
	    		var lgn = Number(this.exifdata.GPSLongitude[0]) + ( Number(this.exifdata.GPSLongitude[1])/60 ) + ( Number(this.exifdata.GPSLongitude[2])/3600 );
	    		latlgn= lat.toFixed(7);
	    		latlgn+=","+lgn.toFixed(7);
	    	}
	    	
	        var id = addImg(this.getImgBase64(),date,latlgn);
	    	
	    	
	    });
		
		
	} 

})
</script>