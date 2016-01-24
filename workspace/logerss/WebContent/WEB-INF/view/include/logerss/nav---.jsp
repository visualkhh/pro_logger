<%@taglib prefix="fluid"  uri="http://visualkhh.com/fluid"%>
<%@taglib prefix="rolek"  uri="http://visualkhh.com/rolek"%>
<style>
<!--
/* Template-specific stuff
 *
 * Customizations just for the template; these are not necessary for anything
 * with disabling the responsiveness.
 */

/* Account for fixed navbar */
body {
/*   padding-top: 70px; */
  padding-bottom: 30px;
}

body,
.navbar-fixed-top,
.navbar-fixed-bottom {
  min-width: 970px;
}

/* Don't let the lead text change font-size. */
.lead {
  font-size: 16px;
}

/* Finesse the page header spacing */
.page-header {
  margin-bottom: 30px;
}
.page-header .lead {
  margin-bottom: 10px;
}


/* Non-responsive overrides
 *
 * Utilize the following CSS to disable the responsive-ness of the container,
 * grid system, and navbar.
 */

/* Reset the container */
.container {
  width: 970px;
  max-width: none !important;
}

/* Demonstrate the grids */
.col-xs-4 {
  padding-top: 15px;
  padding-bottom: 15px;
  background-color: #eee;
  background-color: rgba(86,61,124,.15);
  border: 1px solid #ddd;
  border: 1px solid rgba(86,61,124,.2);
}

.container .navbar-header,
.container .navbar-collapse {
  margin-right: 0;
  margin-left: 0;
}

/* Always float the navbar header */
.navbar-header {
  float: left;
}

/* Undo the collapsing navbar */
.navbar-collapse {
  display: block !important;
  height: auto !important;
  padding-bottom: 0;
  overflow: visible !important;
  visibility: visible !important;
}

.navbar-toggle {
  display: none;
}
.navbar-collapse {
  border-top: 0;
}

.navbar-brand {
  margin-left: -15px;
}

/* Always apply the floated nav */
.navbar-nav {
  float: left;
  margin: 0;
}
.navbar-nav > li {
  float: left;
}
.navbar-nav > li > a {
  padding: 15px;
}

/* Redeclare since we override the float above */
.navbar-nav.navbar-right {
  float: right;
}

/* Undo custom dropdowns */
.navbar .navbar-nav .open .dropdown-menu {
  position: absolute;
  float: left;
  background-color: #fff;
  border: 1px solid #ccc;
  border: 1px solid rgba(0, 0, 0, .15);
  border-width: 0 1px 1px;
  border-radius: 0 0 4px 4px;
  -webkit-box-shadow: 0 6px 12px rgba(0, 0, 0, .175);
          box-shadow: 0 6px 12px rgba(0, 0, 0, .175);
}
.navbar-default .navbar-nav .open .dropdown-menu > li > a {
  color: #333;
}
.navbar .navbar-nav .open .dropdown-menu > li > a:hover,
.navbar .navbar-nav .open .dropdown-menu > li > a:focus,
.navbar .navbar-nav .open .dropdown-menu > .active > a,
.navbar .navbar-nav .open .dropdown-menu > .active > a:hover,
.navbar .navbar-nav .open .dropdown-menu > .active > a:focus {
  color: #fff !important;
  background-color: #428bca !important;
}
.navbar .navbar-nav .open .dropdown-menu > .disabled > a,
.navbar .navbar-nav .open .dropdown-menu > .disabled > a:hover,
.navbar .navbar-nav .open .dropdown-menu > .disabled > a:focus {
  color: #999 !important;
  background-color: transparent !important;
}

/* Undo form expansion */
.navbar-form {
  float: left;
  width: auto;
  padding-top: 0;
  padding-bottom: 0;
  margin-right: 0;
  margin-left: 0;
  border: 0;
  -webkit-box-shadow: none;
          box-shadow: none;
}

/* Copy-pasted from forms.less since we mixin the .form-inline styles. */
.navbar-form .form-group {
  display: inline-block;
  margin-bottom: 0;
  vertical-align: middle;
}

.navbar-form .form-control {
  display: inline-block;
  width: auto;
  vertical-align: middle;
}

.navbar-form .form-control-static {
  display: inline-block;
}

.navbar-form .input-group {
  display: inline-table;
  vertical-align: middle;
}

.navbar-form .input-group .input-group-addon,
.navbar-form .input-group .input-group-btn,
.navbar-form .input-group .form-control {
  width: auto;
}

.navbar-form .input-group > .form-control {
  width: 100%;
}

.navbar-form .control-label {
  margin-bottom: 0;
  vertical-align: middle;
}

.navbar-form .radio,
.navbar-form .checkbox {
  display: inline-block;
  margin-top: 0;
  margin-bottom: 0;
  vertical-align: middle;
}

.navbar-form .radio label,
.navbar-form .checkbox label {
  padding-left: 0;
}

.navbar-form .radio input[type="radio"],
.navbar-form .checkbox input[type="checkbox"] {
  position: relative;
  margin-left: 0;
}

.navbar-form .has-feedback .form-control-feedback {
  top: 0;
}

/* Undo inline form compaction on small screens */
.form-inline .form-group {
  display: inline-block;
  margin-bottom: 0;
  vertical-align: middle;
}

.form-inline .form-control {
  display: inline-block;
  width: auto;
  vertical-align: middle;
}

.form-inline .form-control-static {
  display: inline-block;
}

.form-inline .input-group {
  display: inline-table;
  vertical-align: middle;
}
.form-inline .input-group .input-group-addon,
.form-inline .input-group .input-group-btn,
.form-inline .input-group .form-control {
  width: auto;
}

.form-inline .input-group > .form-control {
  width: 100%;
}

.form-inline .control-label {
  margin-bottom: 0;
  vertical-align: middle;
}

.form-inline .radio,
.form-inline .checkbox {
  display: inline-block;
  margin-top: 0;
  margin-bottom: 0;
  vertical-align: middle;
}
.form-inline .radio label,
.form-inline .checkbox label {
  padding-left: 0;
}

.form-inline .radio input[type="radio"],
.form-inline .checkbox input[type="checkbox"] {
  position: relative;
  margin-left: 0;
}

.form-inline .has-feedback .form-control-feedback {
  top: 0;
}

-->
</style>
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
        <div class="navbar-header">
          <!-- The mobile navbar-toggle button can be safely removed since you do not need it in a non-responsive implementation -->
           <a class="navbar-brand" href="/view"><img src="<fluid:insertString id="icon"/>" style="float: left;"/>logerss</a>
        </div>
        <!-- Note that the .navbar-collapse and .collapse classes have been removed from the #navbar -->
        <div id="navbar">
         <form class="navbar-form navbar-left" role="search">
           <div class="form-group">
             <input type="text" class="form-control" placeholder="Search Log">
           </div>
<!--             <button type="submit" class="btn btn-default">Submit</button> -->
         </form>
        <rolek:insertString id="IS_LOGIN" equals="true">
	          <ul class="nav navbar-nav">
<!-- 	            <li class="active"><a href="#">Home</a></li> -->
	            <li><a href="#about">MyLog <span class="fa fa-bar-chart"></span></a></li>
<!-- 	            <li><a href="#contact">Contact</a></li> -->
<!-- 	            <li class="dropdown"> -->
<!-- 	              <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">Dropdown <span class="caret"></span></a> -->
<!-- 	              <ul class="dropdown-menu"> -->
<!-- 	                <li><a href="#">Action</a></li> -->
<!-- 	                <li><a href="#">Another action</a></li> -->
<!-- 	                <li><a href="#">Something else here</a></li> -->
<!-- 	                <li role="separator" class="divider"></li> -->
<!-- 	                <li class="dropdown-header">Nav header</li> -->
<!-- 	                <li><a href="#">Separated link</a></li> -->
<!-- 	                <li><a href="#">One more separated link</a></li> -->
<!-- 	              </ul> -->
<!-- 	            </li> -->
	          </ul>
          </rolek:insertString>

          <ul class="nav navbar-nav navbar-right">
			<rolek:insertString id="IS_LOGIN" equals="false">
            <li><a href="/view/signup">Sign up<span class="fa fa-registered" aria-hidden="true"></span></a></li>
            <li><a href="/view/signin">Sign in<span class="fa fa-sign-in" aria-hidden="true"></span></a></li>
            </rolek:insertString>
			<rolek:insertString id="IS_LOGIN" equals="true">
            <li><a href="#" id="signout">Sign out <span class="fa fa-sign-out" aria-hidden="true"></span></a></li>
            </rolek:insertString>
          </ul>
        </div><!--/.nav-collapse -->
      </div>
    </nav>