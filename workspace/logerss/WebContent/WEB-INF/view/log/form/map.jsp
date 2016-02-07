<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<div id="map-form-container" class="panel panel-default" style="margin-bottom:10px;">
	<div class="panel-heading" style="padding:3px;">
	<h3 class="panel-title">
				<div class="input-group input-group-sm" >
		  			<span class="input-group-addon"  id="sizing-addon3"><span class="fa fa-map" aria-hidden="true"></span></span>
		  			<input id="map-form-title" value="map" type="text" class="form-control" placeholder="title" aria-describedby="sizing-addon3"/>
				</div>
	</h3>
	</div>
	<div class="panel-body" style="padding:0px;">
           <textarea class="form-control" rows="10" id="map-form-data" placeholder='[{date:"yyyyMMddHHmmss", latlng:"latitude, longitude"}, {date:"yyyyMMddHHmmss", latlng:"latitude, longitude"}..]'>${param.data}</textarea>
	</div>
</div>