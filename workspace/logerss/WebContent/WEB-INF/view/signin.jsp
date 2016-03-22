<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="fluid"  uri="http://visualkhh.com/fluid"%>
<script type="text/javascript">
EventUtil.addOnloadEventListener(function(){
	$("#signin").click(submit);
	$("#form").submit(function(event){
		submit();
		event.preventDefault();
	});
	
	$("#email").val('a');
	$("#password").val('a');
	
// 	isSensor(function(sensor){
// 		$("#email").val('a');
// 		$("#password").val('a');
// 	});
});

function submit(){
	var param = {
			"url":"/ajax/sign",
			"type":"POST",
			"data" : 	{
						"email":$("#email").val(),
						"password":$("#password").val(),
						"MN":"in"
						},
			onSuccess : ajaxSignInCallBack,
			onError : ajaxSignInErrorCallback
		};
	request(param,"Sign In request..");
}

function ajaxSignInCallBack(data){
	
	for (var i = 0; i < data.length; i++) {
		
		$("#success-signin-container").show();
		$("#error-signin-container").hide();
		isSensor(function(sensor){
			sensor.login($("#email").val(),$("#password").val(),data[i].USER_SEQ);
			setTimeout(LocationUtil.goHref("/view/log?u="+data[i].USER_SEQ), "1500")
		},function(){
			setTimeout(LocationUtil.goHref("/view"), "1500")
		});
		
	}


}

function ajaxSignInErrorCallback(data){
	$("#success-signin-container").hide();
	$("#error-signin-container").show();
	$("#error-signin-msg-container").html(data.status_msg+"("+data.status_code+")");
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
						<strong> Sign in to continue</strong>
					</div>
					<div class="panel-body">
						<form id="form" role="form" action="#" method="POST">
							<fieldset>
								<div class="row">
									<div class="center-block" style="text-align:center;">
										<span class="fa fa-sign-in fa-3x" aria-hidden="true"></span>
									</div>
								</div>
								<div class="row">
									<div id="error-signin-container" style="display: none; margin:1em;" class="alert alert-danger" role="alert" >
									  <span class="glyphicon glyphicon-exclamation-sign"  aria-hidden="true"></span>
									  <span class="sr-only">Error:</span>
									  <span id="error-signin-msg-container">error</span>
									</div>
									<div id="success-signin-container" style="display: none; margin:1em;" class="alert alert-success" role="alert" >
									  <span class="glyphicon glyphicon-exclamation-sign"  aria-hidden="true"></span>
									  <span class="sr-only">success :</span>
									  <span id="success-signup-msg-container">success</span>
									  <span>
									  <div style="text-align: center;"> 
									  	<a type="button"  href="/view" class="btn btn-default btn-lg">
  										<span class="" aria-hidden="true"></span> Go Main
										</a>
										</div>
									  </span>
									</div>
								</div>
								<div class="row">
									<div class="col-sm-12 col-md-10  col-md-offset-1 ">
										<div class="form-group">
											<div class="input-group">
												<span class="input-group-addon">
													<i class="glyphicon glyphicon-user"></i>
												</span> 
												<input class="form-control" type="email" name="email" id="email" tabindex="1" type="text" placeholder="Email Address" autofocus>
											</div>
										</div>
										<div class="form-group">
											<div class="input-group">
												<span class="input-group-addon">
													<i class="glyphicon glyphicon-lock"></i>
												</span>
												<input class="form-control" placeholder="Password" id="password" name="password" tabindex="2" type="password" value="">
											</div>
										</div>
										<div class="form-group">
											<input type="submit" id="signin" tabindex="3" class="btn btn-lg btn-primary btn-block" value="Sign in">
										</div>
									</div>
								</div>
							</fieldset>
						</form>
					</div>
					<div class="panel-footer ">
						Don't have an account! <a href="/view/signup"> Sign Up Here </a>
					</div>
                </div>
			</div>
		</div>
	<%--footer--%>
	<fluid:insertView id="page-body-footer"/>
	<%--footer--%>
    </div> <!-- /container -->
</body>