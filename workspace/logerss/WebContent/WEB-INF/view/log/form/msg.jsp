<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<div id="msg-form-container" class="panel panel-default" style="margin-bottom:10px;">
	<div class="panel-heading" style="padding:3px;">
	<h3 class="panel-title">
				<div class="input-group input-group-sm" >
		  			<span class="input-group-addon"  id="sizing-addon3"><span class="fa fa-map" aria-hidden="true"></span></span>
		  			<input id="msg-form-title"  value="msg" type="text" class="form-control" placeholder="title" aria-describedby="sizing-addon3"/>
				</div>
	</h3>
	</div>
	<div id="msg-form-body" class="panel-body" style="padding:0px; ">
	</div>
	<div class="panel-footer" style="text-align: right; padding:3px;" >
	<button id="msg-form-add" type="button" class="btn btn-primary">add message</button>
	</div>
</div>
<script type="text/javascript">

function addMsg(msg,date,latlgn){
	var id=JavaScriptUtil.getUniqueKey();
	var contentId = 'msg-form-content-'+id;
	var removeId = 'msg-form-content-remove-'+id;
	var latlngId = 'msg-form-content-latlng-'+id;
	var h="";
 h+='  <div id="'+contentId+'" name="msg-form-content" class="thumbnail">';
 h+='  <textarea class="form-control" name="msg-form-content-msg" placeholder="message..">'+msg+'</textarea>';
 h+='  <div class="caption" style="padding: 0px;">';
h+='		<div class="input-group input-group-sm" >';
h+='			<span class="input-group-addon" background-color: #fff id="sizing-addon3"><span class="fa fa-calendar-check-o" aria-hidden="true"/></span>';
h+='			<input name="msg-form-content-date" value="'+(date||"")+'"  type="text" class="form-control" placeholder="yyyy.MM.dd HH:mm:ss" aria-describedby="sizing-addon3"/>';
h+='			<span class="input-group-addon"  id="sizing-addon3"><span class="fa fa-map" aria-hidden="true"/></span>';
h+='			<input id="'+latlngId+'"name="msg-form-content-latlng"  value="'+(latlgn||"")+'"  type="text" class="form-control" placeholder="latitude, longitude" aria-describedby="sizing-addon3"/>';
h+='			<span class="input-group-btn">';
h+='	        <button id="'+removeId+'" class="btn btn-default"  type="button"><span class="fa fa-times" aria-hidden="true"></span></button>';
h+='	        </span>';
h+='		</div>';
 h+='  </div>';
 h+='</div>';
 var newMsg = $(h);
 newMsg.find("#"+removeId).click(function(){
	 $("#"+contentId).remove();
 });
 
 $("#msg-form-body").append(newMsg);
 return id;
}

$('#msg-form-add').click(function(){
	var id = addMsg('',DateUtil.getDate("yyyyMMddHHmmss"),'...');
	
	(function(id){
		GPSUtil.getGPS(function(geo){
			$("#msg-form-content-latlng-"+id).val(geo.latitude+","+geo.longitude);
		});
	})(id);
	

});
</script>