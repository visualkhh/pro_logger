<%@taglib prefix="fluid"  uri="http://visualkhh.com/fluid"%>
<%@taglib prefix="rolek"  uri="http://visualkhh.com/rolek"%>

<rolek:insertString id="IS_LOGIN" equals="true">
	<script type="text/javascript">
	EventUtil.addOnloadEventListener(function(){
		$("#signout").click(function(){
			var param = {
					"url":"/ajax/sign",
					"type":"POST",
					"data" : 	{
								"MN":"out"
								},
					onSuccess : ajaxNavCallBack,
					dataType:"XML"
				};
			ajax(param,"Sign out request..")
		});
	 
	});
	
	function ajaxNavCallBack(data,readyState,status){
		var status_code = $(data).find("ROOT>STATUS_CODE").text();
		var status_msg = $(data).find("ROOT>STATUS_MSG").text();
		if(STATUS_CODE_SUCCESS==status_code){ //성공
			alert("Sign out success");
			setTimeout(LocationUtil.goHref("/view"), "1500")
		}else{	//실패
			alert(status_msg+"("+status_code+")");
		}
	}
	</script>
</rolek:insertString>


    <nav class="navbar navbar-default navbar-fixed-top">
      <div class="container">
      
        <div class="navbar-header row">
          <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
            <span class="sr-only">Toggle navigation</span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
          </button>
          <span class="navbar-brand" style="">
	          <a href="/view" style="color:rgb(255,162,6);"><img src="<fluid:insertString id="icon"/>" align="middle"/>logerss</a>
	          <rolek:insertString id="IS_LOGIN" equals="true">
	          <li class="nav dropdown" style="float: right;">
		          <a class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false" style="font-size: 14px; color:#777;  margin-left: 50px; " href="/view/mylog" >
		          <img class="img-circle" src="/user/profile.png" alt="Generic placeholder image" width="20" height="20"/> ${ROLEK.USER_NAME}<span class="caret"></span>
		          </a>
				<ul class="dropdown-menu">
<!-- 					<li><a href="/view/log/addlog"><span class="fa fa-plus" aria-hidden="true"></span> Add Log</a> </li> -->
					<li><a href="/view/log"><span class="fa fa-bar-chart" aria-hidden="true"></span> My Log</a> </li>
	                <li role="separator" class="divider"></li>
<!-- 	                <li class="dropdown-header">Profile</li> -->
	                <li><a href="/view/profile">Edit profile</a></li>
              	</ul>
	          </li>
	          </rolek:insertString>
          </span>
<%--           <a class="navbar-brand" href="/view" style="color:rgb(255,162,6);"><img src="<fluid:insertString id="icon"/>" style="float: left;"/>logerss</a> --%>
          

        </div>


        <div id="navbar" class="navbar-collapse collapse">
<!--           <ul class="nav navbar-nav"> -->
<!--             <li class="active"><a href="#">Home</a></li> -->
<!--             <li><a href="#about">About</a></li> -->
<!--             <li><a href="#contact">Contact</a></li> -->
<!--           </ul> -->
          <ul class="nav navbar-nav navbar-right">
<%--           ${ROLEK.info} --%>
          	<rolek:insertString id="IS_LOGIN" equals="false">
            <li><a href="/view/signup"><span class="fa fa-registered" aria-hidden="true"></span> Sign up</a> </li>
            <li><a href="/view/signin"><span class="fa fa-sign-in" aria-hidden="true"></span> Sign in</a> </li>
            </rolek:insertString>
          	<rolek:insertString id="IS_LOGIN" equals="true">
            <li><a href="#" id="signout"><span class="fa fa-sign-out" aria-hidden="true"></span>Sign out</a> </li>
            </rolek:insertString>
          <li>
          <form class="navbar-form">
            <input type="text" class="form-control" placeholder="Search log...">
          </form>
          </li>
<!--             <li class="active"><a href="./">Fixed top <span class="sr-only">(current)</span></a></li> -->
            
<!--             <li class="dropdown"> -->
<!--               <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">english<span class="caret"></span></a> -->
<!--               <ul class="dropdown-menu"> -->
<!--                 <li><a href="#">english</a></li> -->
<!--                 <li><a href="#">korea</a></li> -->
<!--                 <li><a href="#">Something else here</a></li> -->
<!--                 <li role="separator" class="divider"></li> -->
<!--                 <li class="dropdown-header">Nav header</li> -->
<!--                 <li><a href="#">Separated link</a></li> -->
<!--                 <li><a href="#">One more separated link</a></li> -->
<!--               </ul> -->
<!--             </li> -->
          </ul>
        </div><!--/.nav-collapse -->
      </div>
    </nav>
    
    


    </nav>