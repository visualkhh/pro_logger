<%@page import="khh.web.jsp.framework.validate.rolek.RoleK"%>
<%@page import="khh.web.jsp.framework.validate.rolek.Role"%>
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="khh.property.util.PropertyUtil"%>
<%@taglib prefix="fluid"  uri="http://visualkhh.com/fluid"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script type="text/javascript">

EventUtil.addOnloadEventListener(function(){
	
	<c:if test="${param.s ne null }">
	search("${param.s}");
	</c:if>
});


function search(title){
	$("#search").val(title);
	var param_user = {
			"url":"/ajax/log",
			"data" : 	{"MN":"searchLog","title":title},
			"async": false,
			onSuccess : function(data){
				var log = new HashMap();
				for (var i = 0; i < data.length; i++) {
					var atData = data[i];
					if(log.get(atData.USER_SEQ)){
						log.get(atData.USER_SEQ).push(atData);
					}else{
						var a = new Array();
						a.name = atData.NAME;
						a.seq = atData.USER_SEQ;
						a.push(atData);
						log.put(atData.USER_SEQ,a);
					}
				}
				
				var keys = log.getKeys();
				for (var i = 0; i < keys.length; i++) {
					var at = log.get(keys[i]);
					
					
						var h ="";	
					    h+='<div class="blockquote-box blockquote-warning clearfix">';
						h+=' <div class="media">';
						h+='  <div class="media-left media-middle">';
						h+='    <a href="/view/log?u='+at.seq+'" style="text-decoration:none;"  class="content">';
						h+='      <img class="img-circle" src="/user/profile.png?u='+at.seq+'" alt="Generic placeholder image" width="30" height="30"/>';
						h+='      <h4 class="media-heading">'+at.name+'</h4>';
						h+='    </a>';
						h+='  </div>';
						
						h+='  <div class="media-body">';
						
						for (var y = 0; y < at.length; y++) {
							
						   h+=' <blockquote><a style="text-decoration:none;" href="/view/log?u='+at.seq+'&id='+at[y].LOG_ID+'">';
					       h+='            <span class="'+at[y].ICON+'"></span> '+at[y].TITLE;
					       h+='            <p style="font-size: 14px;">'+at[y].MIN_DATE+' ~ '+at[y].MAX_DATE+'</p>';
					       h+='</a></blockquote>';
						}
					       
						h+='     </div>';
						h+='   </div>';
						h+=' </div>';
						$("#log-container").append(h);
				}
				
			}
			
	}
	request(param_user,"search request..");
}
</script>
<body>
	<!-- nav start -->
	<fluid:insertView id="page-body-nav"/>
	<!-- nav end -->
	
  <!-- page Start --> 
	<div id="container" class="container" style="padding:0px">
		<div class="row">
			<div class="page-header">
	              <div class="input-group" style="margin: 10px">
	              <form method="get">
			      <input type="text" name="s" id="search" class="form-control" placeholder="Search for...">
			      </form>
			      <span class="input-group-btn">
			        <button class="btn btn-default" type="button"><span class="fa fa-search"></span></button>
			      </span>
				</div>
            </div>
          </div>
            
	<div id="log-container" class="container" style="padding:0px" >
	</div>
<!--             <div class="blockquote-box blockquote-warning clearfix"> -->
<!-- 				<div class="media"> -->
<!-- 				  <div class="media-left media-middle"> -->
<!-- 				    <a href="#" class="content"> -->
<!-- 				      <img class="img-circle" src="/user/profile.png?u=1" alt="Generic placeholder image" width="30" height="30"/> -->
<!-- 				      <h4 class="media-heading">visualkhh</h4> -->
<!-- 				    </a> -->
<!-- 				  </div> -->
<!-- 				  <div class="media-body"> -->
<!-- 					<blockquote> -->
<!-- 	                    Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer posuere erat a -->
<!-- 	                    ante. -->
<!-- 	                    <p style="font-size: 14px;">2015:05:05 01:01:01 ~ 2015:05:05 01:01:01</p> -->
<!-- 	                </blockquote> -->
<!-- 					<blockquote> -->
<!-- 	                    Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer posuere erat a -->
<!-- 	                    ante. -->
<!-- 	                </blockquote> -->
<!-- 					<blockquote> -->
<!-- 	                    Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer posuere erat a -->
<!-- 	                    ante. -->
<!-- 	                </blockquote> -->
<!-- 				 </div> -->
<!-- 				</div> -->
<!--             </div> -->
            
	<!-- page END -->
	<fluid:insertView id="page-body-footer"/>
	</div>
</body>