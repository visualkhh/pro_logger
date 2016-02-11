<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

            <div class="panel panel-default">
                <!-- Default panel contents -->
<!--                 <div class="panel-heading">Material Design Switch Demos</div> -->
                <!-- List group -->
                <ul class="list-group">
                    <li class="list-group-item">
                        The only sensor function
                        <div class="input-group">
						  <span class="input-group-addon"><span class="fa fa-map-pin" aria-hidden="true"></span></span>
						  <input id="livegps-form-title" value="liveGPSLog" type="text" class="form-control" placeholder="log name..." >
<!--   						<span class="input-group-btn"> -->
<!--   								<input id="livegps-form-sw" type="checkbox" checked data-toggle="toggle"> -->
<!-- 					      </span> -->
						</div>
						
						<div id="error-signin-container" style="display: none; margin:1em;" class="alert alert-danger" role="alert" >
						  <span class="glyphicon glyphicon-exclamation-sign"  aria-hidden="true"></span>
						  <span>Impossible sensor.</span>
						</div>
						<div id="success-signin-container" style="display: none; margin:1em;" class="alert alert-success" role="alert" >
						  <span class="glyphicon glyphicon-exclamation-sign"  aria-hidden="true"></span>
						  <span>The available sensors.</span>
						</div>
						
						
                    </li>
                </ul>
            </div>            
<script type="text/javascript">
// var toggle = $('#livegps-form-sw').bootstrapToggle();
// toggle.bootstrapToggle('off');

isSensor(function(){
	$("#success-signin-container").show();
// 	toggle.bootstrapToggle('enable')
},function(){
	$("#error-signin-container").show();
// 	toggle.bootstrapToggle('disable')
});

</script>