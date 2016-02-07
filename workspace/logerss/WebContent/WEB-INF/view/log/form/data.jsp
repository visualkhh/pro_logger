<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<div id="data-form-container" class="panel panel-default" style="margin-bottom:10px;">
	<div class="panel-heading" style="padding:3px;">
	<h3 class="panel-title">
				<div class="input-group input-group-sm" >
		  			<span class="input-group-addon"  id="sizing-addon3"><span class="fa fa-map" aria-hidden="true"></span></span>
		  			<input id="data-form-title"  value="data" type="text" class="form-control" placeholder="title" aria-describedby="sizing-addon3"/>
				</div>
	</h3>
	</div>
	<div class="panel-body" style="padding:0px;">
           <textarea class="form-control" id="data-form-data" rows="10" placeholder='[{date:"yyyyMMddHHmmss", valueName1:"value", valueName2:"value"..}, {date:"yyyyMMddHHmmss", valueName1:"value", valueName2:"value"..}..]'>${param.data}</textarea>
	</div>
</div>