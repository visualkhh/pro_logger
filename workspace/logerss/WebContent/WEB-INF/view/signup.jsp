<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="fluid"  uri="http://visualkhh.com/fluid"%>
<script type="text/javascript">
EventUtil.addOnloadEventListener(function(){
	EventUtil.addOnClickEventListener(new SelectorK("#register").get(0),registerAjax);

});

function registerAjax(){
	if($("#password").val() != $("#password_confirmation").val()){
		$("#error-signup-msg-container").html("The password is not the same.");
		$("#error-signup-container").show();
		$("#password").val('');
		$("#password_confirmation").val('');
		return;
	}else if(!Validate.isEmail($("#email").val())){
		$("#error-signup-msg-container").html("Email format Check.");
		$("#error-signup-container").show();
		return;
	}
	
	var param = {
			"url":"/ajax/sign",
			"type":"POST",
			"data" : 	{
						"name":$("#name").val(),
						"email":$("#email").val(),
						"password":$("#password").val(),
						"password_confirmation":$("#password_confirmation").val(),
						"MN":"up"
						},
			onSuccess : ajaxSignUpCallBack,
			dataType:"XML"
		};
	ajax(param,"request regist..")
	
}

function ajaxSignUpCallBack(data,readyState,status){
	var status_code = $(data).find("ROOT>STATUS_CODE").text();
	var status_msg = $(data).find("ROOT>STATUS_MSG").text();
	
	if(STATUS_CODE_SUCCESS==status_code){ //성공
		$("#success-signup-container").show();
		$("#error-signup-container").hide();
		$("#form").hide();
	}else{	//실패
		$("#success-signup-container").hide();
		$("#error-signup-container").show();
		$("#error-signup-msg-container").html(status_msg+"("+status_code+")");
	}
}
</script>

<body>
	<%--nav--%>
	<fluid:insertView id="page-body-nav"/>
	<%--nav--%>
    <div class="container" style="margin-top: 50px;" >
		<div class="row">
			<div class="col-sm-6 col-md-4 col-md-offset-4 col-sm-offset-4">
				<div class="panel panel-default">
					<div class="panel-heading">
						<strong> Sign up to continue</strong>
					</div>
					<div class="panel-body">
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
				    		<form role="form" id="form">
								<div class="row">
									<div class="center-block" style="text-align:center;">
										<span class="fa fa-registered fa-3x" aria-hidden="true"></span>
									</div>
								</div>
					    			<div class="form-group">
					    				<input type="email" name="email" id="email" class="form-control input-sm" placeholder="Email Address">
					    			</div>
					    			<div class="row">
					    				<div class="col-xs-12 col-sm-12 col-md-12">
					    					<div class="form-group">
					    						<input type="text" name="name" id="name" class="form-control input-sm" placeholder="Name">
					    					</div>
					    				</div>
					    			</div>
		
					    			<div class="row">
					    				<div class="col-xs-6 col-sm-6 col-md-6">
					    					<div class="form-group">
					    						<input type="password" name="password" id="password" class="form-control input-sm" placeholder="Password">
					    					</div>
					    				</div>
					    				<div class="col-xs-6 col-sm-6 col-md-6">
					    					<div class="form-group">
					    						<input type="password" name="password_confirmation" id="password_confirmation" class="form-control input-sm" placeholder="Confirm Password">
					    					</div>
					    				</div>
					    			</div>
					    			
					    			<input type="button" id="register" value="Register" class="btn btn-info btn-block">
				    		</form>
					</div>
					<div class="panel-footer ">
						now <a href="/view/signin"> Sign In Here </a>
					</div>
                </div>
			</div>
		</div>
	<%--footer--%>
	<fluid:insertView id="page-body-footer"/>
	<%--footer--%>
    </div> <!-- /container -->
</body>