<%@page import="khh.web.jsp.framework.validate.rolek.RoleK"%>
<%@page import="khh.web.jsp.framework.validate.rolek.Role"%>
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="khh.property.util.PropertyUtil"%>
<%@taglib prefix="fluid"  uri="http://visualkhh.com/fluid"%>
<script type="text/javascript">
EventUtil.addOnloadEventListener(function(){
	$("#modify").click(modifyAjax);
	
	$('#photo-form-file').change(function(){
		var files = event.target.files;
		for (var i = 0; i < files.length; i++) {
			//l+=files[i]+"<br>";
			var file = files[i];
			if (!file.type.match('image.*')) {
	        	continue;
			}
			ImageUtil.thumbnailFileToBase64(file,100,function(data){
				window.open(data);
				profileAjax(data)
			});
		}
	});
	
});


function profileAjax(base64){
	var param = {
			"url":"/ajax/sign",
			"type":"POST",
			"data" : 	{
						"base64":ConvertingUtil.Base64EncodeUrl(base64),
						"MN":"profile"
						},
			onSuccess : function(arr){
				$("#profile").attr("src",base64);
				toastr.success("save Success!");
			}
		};
	request(param,"save profile...")
}


function modifyAjax(){
	if($("#new_password").val() != $("#new_password_confirmation").val()){
		$("#error-signup-container").show();
		$("#error-signup-msg-container").html("The new password is not the same.");
		$("#new_password").val('');
		$("#new_password_confirmation").val('');
		return;
	}
	var param = {
			"url":"/ajax/sign",
			"type":"POST",
			"data" : 	{
						"name":$("#name").val(),
						"email":$("#email").val(),
						"password":$("#password").val(),
						"new_password":$("#new_password").val(),
						"new_password_confirmation":$("#new_password_confirmation").val(),
						"MN":"modify"
						},
			onSuccess : ajaxModifyCallBack,
			dataType:"XML"
		};
	ajax(param,"request regist..")
	
}

function ajaxModifyCallBack(data,readyState,status){
	var status_code = $(data).find("ROOT>STATUS_CODE").text();
	var status_msg = $(data).find("ROOT>STATUS_MSG").text();
	
	if(STATUS_CODE_SUCCESS==status_code){ //성공
		$("#success-signup-container").show();
		$("#error-signup-container").hide();
		ajaxNavSignOut();
	}else{	//실패
		$("#success-signup-container").hide();
		$("#error-signup-container").show();
		$("#error-signup-msg-container").html(status_msg+"("+status_code+")");
	}
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
          
	      <div class="row row-centered" style="margin: 10px;">
	        <div class="col-md-4 col-centered">
	        </div>
	        
	        <div class="col-md-4 col-centered" >
	        	<div class="item" style="width: 100%">
	        		<div class="content">
				          <img  id="profile" class="img-circle" src="/user/profile.png?u=${ROLEK.USER_SEQ}" width="140" height="140"/>
				          <h2 id="user_name"></h2>
				          <p><input id="photo-form-file" type="file" /></p>
					</div>
				</div>
	        </div><!-- /.col-lg-4 -->
	        
	        <div class="col-md-4 col-centered">
	        </div>
	      </div><!-- /.row -->
				
				
				

      
      
				
				
				
				<div class="row">
							<div class="">
								<div class="panel panel-default">
									<div class="panel-heading">
										<strong> Change account information </strong>
									</div>
									<div class="panel-body">
								    		<form role="form">
												<div class="row">
													<div id="error-signup-container" style="display: none; margin:1em;" class="alert alert-danger" role="alert" >
													  <span class="glyphicon glyphicon-exclamation-sign"  aria-hidden="true"></span>
													  <span class="sr-only">Error:</span>
													  <span id="error-signup-msg-container">error</span>
													</div>
													<div id="success-signup-container" style="display: none; margin:1em;" class="alert alert-success" role="alert" >
													  <span class="glyphicon glyphicon-exclamation-sign"  aria-hidden="true"></span>
													  <span class="sr-only">success :</span>
													  <span id="success-signup-msg-container">success</span>
													  <span>
													  <div style="text-align: center;"> 
													  	<a type="button"  href="/view/signin" class="btn btn-default btn-lg">
				  										<span class="" aria-hidden="true"></span> Go Sign In
														</a>
														</div>
													  </span>
													</div>
												</div>
					
								    			<div class="form-group">
								    				<input type="email" name="email" id="email" class="form-control input-sm" placeholder="Email Address"  readonly="readonly" value="${ROLEK.USER_EMAIL}"/>
								    			</div>
								    			<div class="row">
								    				<div class="col-xs-12 col-sm-12 col-md-12">
								    					<div class="form-group">
								    						<input type="text" name="name" id="name" class="form-control input-sm" placeholder="Name" value="${ROLEK.USER_NAME}">
								    					</div>
								    				</div>
								    			</div>
					
								    			<div class="row">
								    				<div class="col-xs-12 col-sm-12 col-md-12">
								    					<div class="form-group">
								    						<input type="password" name="password" id="password" class="form-control input-sm" placeholder="Password">
								    					</div>
								    				</div>
								    			</div>
					
								    			<div class="row">
								    				<div class="col-xs-6 col-sm-6 col-md-6">
								    					<div class="form-group">
								    						<input type="password" name="newpassword" id="new_password" class="form-control input-sm" placeholder="NEW Password">
								    					</div>
								    				</div>
								    				<div class="col-xs-6 col-sm-6 col-md-6">
								    					<div class="form-group">
								    						<input type="password" name="newpassword_confirmation" id="new_password_confirmation" class="form-control input-sm" placeholder="NEW Confirm Password">
								    					</div>
								    				</div>
								    			</div>
								    			
								    			<input type="button" id="modify" value="Modify" class="btn btn-info btn-block">
								    		
								    		</form>
									</div>
									<div class="panel-footer ">
										modify automatically log out
									</div>
				                </div>
							</div>
						</div>
        </div><!--/.col-xs-12.col-sm-9-->

        <div class="col-xs-6 col-sm-3 sidebar-offcanvas" id="sidebar">
          <div class="list-group">
            <a href="#" class="list-group-item active">Profile</a>
            <a href="#" class="list-group-item">open API</a>
            <a href="#" class="list-group-item">event</a>
            <a href="#" class="list-group-item">etc</a>
          </div>
        </div><!--/.sidebar-offcanvas-->
      </div><!--/row-->

	<!-- page END -->
	<fluid:insertView id="page-body-footer"/>
    </div> <!-- /container -->
</body>