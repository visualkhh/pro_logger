<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="fluid"  uri="http://visualkhh.com/fluid"%>
<script type="text/javascript">
EventUtil.addOnloadEventListener(function(){
	$("#signin").click(function(){

		var param = {
				"url":"/ajax/sign",
				"type":"POST",
				"data" : 	{
							"email":$("#email").val(),
							"password":$("#password").val(),
							"MN":"in"
							},
				onSuccess : ajaxSignInCallBack,
				dataType:"XML"
			};
		ajax(param,"Sign In request..")
	});
 
});


function ajaxSignInCallBack(data,readyState,status){
	var status_code = $(data).find("ROOT>STATUS_CODE").text();
	var status_msg = $(data).find("ROOT>STATUS_MSG").text();
	
	if(STATUS_CODE_SUCCESS==status_code){ //성공
		$("#success-signin-container").show();
		$("#error-signin-container").hide();
		setTimeout(LocationUtil.goHref("/view"), "1500")
	}else{	//실패
		$("#success-signin-container").hide();
		$("#error-signin-container").show();
		$("#error-signin-msg-container").html(status_msg+"("+status_code+")");
	}
}


</script>
<body>
	<%--nav--%>
	<fluid:insertView id="page-body-nav"/>
	<%--nav--%>
    <div class="container" style="margin-top:40px">
		<div class="row">
			<div class="col-sm-6 col-md-4 col-md-offset-4">
				<div class="panel panel-default">
					<div class="panel-heading">
						<strong> Sign in to continue</strong>
					</div>
					<div class="panel-body">
						<form role="form" action="#" method="POST">
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
												<input class="form-control" type="email" name="email" id="email" type="text" placeholder="Email Address" autofocus>
											</div>
										</div>
										<div class="form-group">
											<div class="input-group">
												<span class="input-group-addon">
													<i class="glyphicon glyphicon-lock"></i>
												</span>
												<input class="form-control" placeholder="Password" id="password" name="password" type="password" value="">
											</div>
										</div>
										<div class="form-group">
											<input type="button" id="signin" class="btn btn-lg btn-primary btn-block" value="Sign in">
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