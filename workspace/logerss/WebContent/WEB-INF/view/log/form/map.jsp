<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<div id="container_<%=request.getParameter("id")%>" class="panel panel-default" style="margin-bottom:10px;">
	<div class="panel-heading" style="padding:3px;">
	<h3 class="panel-title">
				<div class="input-group input-group-sm" >
		  			<span class="input-group-addon"  id="sizing-addon3"><span class="fa '+icon+' aria-hidden="true"></span></span>
		  			<input id="'+title_id+'" type="text" class="form-control" placeholder="title" aria-describedby="sizing-addon3"/>
						<span class="input-group-btn" style="padding-left:10px;">
							<button id="'+move_id+'" class="btn btn-default" style="border-radius:4px;" type="button"><span class="fa fa-bars" aria-hidden="true"></span></span></button>
							<button id="'+remove_id+'" class="btn btn-default" style="border-radius:4px;" type="button"><span class="fa fa-times" aria-hidden="true"></span></button>
						</span>
				</div>
	</h3>
	</div>
	<div class="panel-body" style="padding:0px;">
	</div>
	<div class="panel-footer" style="text-align: right; padding:3px;" >
		<div class="btn-group" role="group" >
			<div class="input-group input-group-sm">
			  <span class="input-group-addon" id="sizing-addon3"><span class="fa fa-file-text" aria-hidden="true"></span></span>
			 <input type="file" name="upload" multiple="multiple" />
			  <input id="'+data_id+'" type="text" class="form-control" value="" placeholder="'+placeholder+','+placeholder+'.." aria-describedby="sizing-addon3"/>
			<span class="input-group-btn">
				<button id="'+question_id+'" class="btn btn-default" type="button"><span class="fa fa-question" aria-hidden="true"></span></button>
				<button id="'+applay_id+'" class="btn btn-default" type="button">apply</button>
				<button id="'+save_id+'" class="btn btn-default" type="button">save</button>
			</span>
			</div>
		</div>
	</div>
</div>