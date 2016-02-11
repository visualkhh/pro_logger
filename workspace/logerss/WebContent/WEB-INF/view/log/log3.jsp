<%@page import="khh.web.jsp.framework.validate.rolek.RoleK"%>
<%@page import="khh.web.jsp.framework.validate.rolek.Role"%>
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="khh.property.util.PropertyUtil"%>
<%@taglib prefix="fluid"  uri="http://visualkhh.com/fluid"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script src="/front-end/javascript/exif/exif-js-master/exif.js"></script>
<script src="/front-end/javascript/visualkhh/device_util.js"></script>
<script src="/front-end/javascript/visualkhh/googlemap_util.js"></script>
<script src="/front-end/graphK/graphk_util.js"></script>
<script src="/front-end/graphK/graphk_object.js"></script>
<script src="/front-end/graphK/graphk.js"></script>
<script type="text/javascript" src="https://maps.google.com/maps/api/js?v=3.exp&language=en_us"></script>
<script type="text/javascript">

// class..........
function MapLog(){};
MapLog.prototype = new Object();
MapLog.prototype.id;
MapLog.prototype.open="N"; //공개 비공개  기본 비공개
MapLog.prototype.type='map';
MapLog.prototype.chartType='linefill';
MapLog.prototype.isSearch; // 서치대상인가 아닌가. 서치버튼누를때마다 false 되고 완료되면 트루된다. 
MapLog.prototype.min_date;//14554165155 초기 
MapLog.prototype.max_date;//14554165155 초기 

MapLog.prototype.title; //$('#map-form-title').val(),
MapLog.prototype.data;//:eval("["+$('#map-form-data').val()+"]"),
MapLog.prototype.toggle=function(){
	this.polyline['visible']=!this.polyline['visible'];
	if(this.polyline['visible']){
		this.polyline.setMap(getMap());
	}else{
		this.polyline.setMap(null);
	}
};
MapLog.prototype.chartData	= function(){return chartMapSpeedData(this.id);};
MapLog.prototype.save		= function(){return save(this.id);};
MapLog.prototype.edit 		= function(){return loadMapForm(this.id);};
MapLog.prototype.remove	= function(){remove(this.id);};
MapLog.prototype.add		= function(){var a = addLog(this.id); this.polyline.setMap(getMap()); return a;};
MapLog.prototype.insertData	= function(){return JavaScriptUtil.arrayToString(this.data);};		//DB에 저장히기전에 디코딩 컨버팅 역활한다
MapLog.prototype.selectData	= function(getData){this.data=getData;};		// DB에서 가져온뒤 엔코딩 컨버팅 역활을한다.
MapLog.prototype.setTime	= function(time){
	if(this.min_date> time || time > this.max_date ){return};
	
	
	var btw = MathUtil.getBetweenSize($("#slider").data("slider").options.min, $("#slider").data("slider").options.max) //전체크기차
	var point = MathUtil.getBetweenSize($("#slider").data("slider").options.min, time); //특정시간대 포인트
	var per = MathUtil.getPercentByTot(btw,point);
	var index = Math.ceil( MathUtil.getValueByTotInPercent(this.data.length-1,per) );
	var atData = this.data[index];
	var lat = atData.latlng.split(",")[0];
	var lng = atData.latlng.split(",")[1];
	var map = getMap();
	var markerop = {icon:"http://mt.google.com/vt/icon?color=ff004C13&name=icons/spotlight/spotlight-waypoint-a.png"};
	
	if(this.point && this.point['dataIndex'] == index){
		return;
	}
	GmapUtil.removeMarker(map,this.point);
	this.point = null;
	this.point = undefined;
	this.point = GmapUtil.createMarker(map,Number(lat),Number(lng),markerop);
	this.point['latlng']=GmapUtil.createLatLng(Number(lat),Number(lng));
	this.point['dataIndex']= index;
	return GmapUtil.createLatLng(Number(lat),Number(lng));
}
MapLog.prototype.init	= function(){
}
MapLog.prototype.finalize	= function(){
	try{
		$("#container-"+this.id).remove();
		$("#log-list-item-"+this.id).remove();
		if(this.point)
			GmapUtil.removeMarker(getMap(),this.point);
		this.polyline.setMap(null);
	}catch(e){}
};


function DataLog(){};
DataLog.prototype = new Object();
DataLog.prototype.id;
DataLog.prototype.open="N"; //공개 비공개  기본 비공개
DataLog.prototype.type		= 'data';
DataLog.prototype.chartType	= 'linefill',
DataLog.prototype.isSearch; // 서치대상인가 아닌가. 서치버튼누를때마다 false 되고 완료되면 트루된다.
DataLog.prototype.min_date;//14554165155 초기 
DataLog.prototype.max_date;//14554165155 초기
DataLog.prototype.title;//:$('#data-form-title').val(),
DataLog.prototype.data;//:eval($('#data-form-data').val()),
DataLog.prototype.chartData	= function(){return this.data;};
DataLog.prototype.save		= function(){return save(this.id);};
DataLog.prototype.remove	= function(){return remove(this.id);};
DataLog.prototype.edit		= function(){return loadDataForm(this.id);};
DataLog.prototype.add		= function(){return addLog(this.id);};
DataLog.prototype.insertData	= function(){return JavaScriptUtil.arrayToString(this.data);};
DataLog.prototype.selectData	= function(getData){this.data=getData;};
DataLog.prototype.setTime	= function(time){
	
}
DataLog.prototype.finalize 	= function(){
	try{
		$("#container-"+this.id).remove();
		$("#log-list-item-"+this.id).remove();
	}catch(e){}
}




function PhotoLog(){};
PhotoLog.prototype = new Object();
PhotoLog.prototype.id;
PhotoLog.prototype.open="N"; //공개 비공개  기본 비공개
PhotoLog.prototype.type				= 'photo';
PhotoLog.prototype.chartType		= 'dot';
PhotoLog.prototype.isSearch; // 서치대상인가 아닌가. 서치버튼누를때마다 false 되고 완료되면 트루된다.
PhotoLog.prototype.min_date;//14554165155 초기 
PhotoLog.prototype.max_date;//14554165155 초기
PhotoLog.prototype.chartAxisYCount	= 0;
PhotoLog.prototype.title;//:$('#photo-form-title').val(),
PhotoLog.prototype.toggle = function(){
			this.markers['visible']=!this.markers['visible'];
			if(this.markers['visible']){
				for(var i=0;i<this.markers.length;i++)
					this.markers[i].setMap(getMap());
			}else{
				for(var i=0;i<this.markers.length;i++)
					this.markers[i].setMap(null);
			}
		};
PhotoLog.prototype.save = function(){return save(this.id);};
PhotoLog.prototype.remove = function(){
			remove(this.id);
		};
PhotoLog.prototype.data;
PhotoLog.prototype.chartData = function(){return chartPhotoData(this.id);};
PhotoLog.prototype.edit = function(){ return	loadPhotoForm(this.id);};
PhotoLog.prototype.add =  function(){
	var a = addLog(this.id); 
	for(var i=0;i<this.markers.length;i++)
		this.markers[i].setMap(getMap());
	return a;
};
PhotoLog.prototype.insertData	= function(){return JavaScriptUtil.arrayToString(this.data);};
PhotoLog.prototype.selectData	= function(getData){this.data=getData;};
PhotoLog.prototype.setTime	= function(time){
	if(this.min_date> time || time > this.max_date ){return};	
	var btw = MathUtil.getBetweenSize($("#slider").data("slider").options.min, $("#slider").data("slider").options.max) //전체크기차
	var point = MathUtil.getBetweenSize($("#slider").data("slider").options.min, time); //특정시간대 포인트
	var per = MathUtil.getPercentByTot(btw,point);
	var index = Math.ceil( MathUtil.getValueByTotInPercent(this.data.length-1,per) );
	var atData = this.data[index];
	var lat = atData.latlng.split(",")[0];
	var lng = atData.latlng.split(",")[1];
	var map = getMap();
	var markerop = {icon:"http://mt.google.com/vt/icon?color=ff004C13&name=icons/spotlight/spotlight-waypoint-a.png"};
	if(this.point && this.point['dataIndex'] == index){
		return;
	}
	GmapUtil.removeMarker(map,this.point);
	this.point = null;
	this.point = undefined;
	this.point = GmapUtil.createMarker(map,Number(lat),Number(lng),markerop);
	var infowindow = new google.maps.InfoWindow({
		content: "<div class='thumbnail'><img src='"+ConvertingUtil.Base64DecodeUrl(atData.src)+"'/></div>"
	    //maxWidth: 200
	  });
	this.point.addListener('click', function(){
		infowindow.open(map, this.point);
  	});
	infowindow.open(map, this.point);
	
	this.point['dataIndex']= index;
	return GmapUtil.createLatLng(Number(lat),Number(lng));
}
PhotoLog.prototype.finalize = function(){
	try{
		$("#container-"+this.id).remove();
		$("#log-list-item-"+this.id).remove();
		if(this.point)
			GmapUtil.removeMarker(getMap(),this.point);
		for(var i=0;i<this.markers.length;i++)
			this.markers[i].setMap(null);
	}catch(e){}
}


function MsgLog(){};
MsgLog.prototype = new Object();
MsgLog.prototype.id;
MsgLog.prototype.open="N"; //공개 비공개  기본 비공개
MsgLog.prototype.type			= 'msg';
MsgLog.prototype.isSearch; // 서치대상인가 아닌가. 서치버튼누를때마다 false 되고 완료되면 트루된다.
MsgLog.prototype.min_date;//14554165155 초기 
MsgLog.prototype.max_date;//14554165155 초기
MsgLog.prototype.chartType		= 'dot';
MsgLog.prototype.chartAxisYCount= 0;
MsgLog.prototype.title;//:$('#msg-form-title').val(),
MsgLog.prototype.toggle = function(){
			this.markers['visible']=!this.markers['visible'];
			if(this.markers['visible']){
				for(var i=0;i<this.markers.length;i++)
					this.markers[i].setMap(getMap());
			}else{
				for(var i=0;i<this.markers.length;i++)
					this.markers[i].setMap(null);
			}
		};
MsgLog.prototype.save = function(){return save(this.id);};
MsgLog.prototype.remove = function(){
			remove(this.id);
		},
MsgLog.prototype.data;
MsgLog.prototype.chartData = function(){return chartMsgData(this.id);};
MsgLog.prototype.edit=function(){ return	loadMsgForm(this.id);};
MsgLog.prototype.add=function(){
	var a = addLog(this.id);
	for(var i=0;i<this.markers.length;i++)
		this.markers[i].setMap(getMap());
	return a; 
};
MsgLog.prototype.insertData	= function(){return JavaScriptUtil.arrayToString(this.data);};
MsgLog.prototype.selectData	= function(getData){this.data=getData;};
MsgLog.prototype.setTime	= function(time){
	if(this.min_date> time || time > this.max_date ){return};	
	//time = time - this.min_date;
	var btw = MathUtil.getBetweenSize($("#slider").data("slider").options.min, $("#slider").data("slider").options.max) //전체크기차
	var point = MathUtil.getBetweenSize($("#slider").data("slider").options.min, time); //특정시간대 포인트
	var per = MathUtil.getPercentByTot(btw,point);
	var index = Math.ceil( MathUtil.getValueByTotInPercent(this.data.length-1,per) );
	var atData = this.data[index];
	var lat = atData.latlng.split(",")[0];
	var lng = atData.latlng.split(",")[1];
	var map = getMap();
	var markerop = {icon:"http://mt.google.com/vt/icon?color=ff004C13&name=icons/spotlight/spotlight-waypoint-a.png"};
	if(this.point && this.point['dataIndex'] == index){
		return;
	}
	GmapUtil.removeMarker(map,this.point);
	this.point = null;
	this.point = undefined;
	this.point = GmapUtil.createMarker(map,Number(lat),Number(lng),markerop);
	var infowindow = new google.maps.InfoWindow({
		content: atData.msg
	  });
	this.point.addListener('click', function(){
		infowindow.open(map, this.point);
  	});
	infowindow.open(map, this.point);
	
	this.point['dataIndex']= index; 
// 	return GmapUtil.createLatLng(Number(lat),Number(lng));
}
MsgLog.prototype.finalize=function(){
	try{
		$("#container-"+this.id).remove();
		$("#log-list-item-"+this.id).remove();
		if(this.point)
			GmapUtil.removeMarker(getMap(),this.point);
		for(var i=0;this.markers&&i<this.markers.length;i++)
			this.markers[i].setMap(null);
	}catch(e){}
};



/////live

function LiveGPSLog(){};
LiveGPSLog.prototype = new Object();
LiveGPSLog.prototype.id;
LiveGPSLog.prototype.open="N"; //공개 비공개  기본 비공개
LiveGPSLog.prototype.type='liveGPS';
LiveGPSLog.prototype.chartType='linefill';
LiveGPSLog.prototype.isSearch; // 서치대상인가 아닌가. 서치버튼누를때마다 false 되고 완료되면 트루된다. 
LiveGPSLog.prototype.min_date;//14554165155 초기 
LiveGPSLog.prototype.max_date;//14554165155 초기 
LiveGPSLog.prototype.title; //$('#map-form-title').val(),
LiveGPSLog.prototype.data;//:eval("["+$('#map-form-data').val()+"]"),
LiveGPSLog.prototype.toggle=function(){
	this.polyline['visible']=!this.polyline['visible'];
	if(this.polyline['visible']){
		this.polyline.setMap(getMap());
	}else{
		this.polyline.setMap(null);
	}
};
LiveGPSLog.prototype.chartData	= function(){return chartMapSpeedData(this.id);};
LiveGPSLog.prototype.save		= function(){return save(this.id);};
LiveGPSLog.prototype.edit 		= function(){return loadMapForm(this.id);};
LiveGPSLog.prototype.remove	= function(){remove(this.id);};
LiveGPSLog.prototype.add		= function(){var a = addLog(this.id); this.polyline.setMap(getMap()); return a;};
LiveGPSLog.prototype.insertData	= function(){return JavaScriptUtil.arrayToString(this.data);};		//DB에 저장히기전에 디코딩 컨버팅 역활한다
LiveGPSLog.prototype.selectData	= function(getData){this.data=getData;};		// DB에서 가져온뒤 엔코딩 컨버팅 역활을한다.
LiveGPSLog.prototype.setTime	= function(time){
	if(this.min_date> time || time > this.max_date ){return};
	
	
	var btw = MathUtil.getBetweenSize($("#slider").data("slider").options.min, $("#slider").data("slider").options.max) //전체크기차
	var point = MathUtil.getBetweenSize($("#slider").data("slider").options.min, time); //특정시간대 포인트
	var per = MathUtil.getPercentByTot(btw,point);
	var index = Math.ceil( MathUtil.getValueByTotInPercent(this.data.length-1,per) );
	var atData = this.data[index];
	var lat = atData.latlng.split(",")[0];
	var lng = atData.latlng.split(",")[1];
	var map = getMap();
	var markerop = {icon:"http://mt.google.com/vt/icon?color=ff004C13&name=icons/spotlight/spotlight-waypoint-a.png"};
	
	if(this.point && this.point['dataIndex'] == index){
		return;
	}
	GmapUtil.removeMarker(map,this.point);
	this.point = null;
	this.point = undefined;
	this.point = GmapUtil.createMarker(map,Number(lat),Number(lng),markerop);
	this.point['latlng']=GmapUtil.createLatLng(Number(lat),Number(lng));
	this.point['dataIndex']= index;
	return GmapUtil.createLatLng(Number(lat),Number(lng));
}
LiveGPSLog.prototype.init	= function(){
}
LiveGPSLog.prototype.finalize	= function(){
	try{
		$("#container-"+this.id).remove();
		$("#log-list-item-"+this.id).remove();
		if(this.point)
			GmapUtil.removeMarker(getMap(),this.point);
		this.polyline.setMap(null);
	}catch(e){}
};











var map;
var log = new HashMap(); 
log['getIsSearchMinDate'] = function(){
 	var keys = this.getKeys();
 	var array = new Array();
	for (var i = 0; i < keys.length; i++) {
		if(this.get(keys[i]).isSearch)
		array.push(this.get(keys[i]).min_date);
	}
	return MathUtil.min(array);
}
log['getIsSearchMaxDate'] = function(){
 	var keys = this.getKeys();
 	var array = new Array();
	for (var i = 0; i < keys.length; i++) {
		if(this.get(keys[i]).isSearch)
		array.push(this.get(keys[i]).max_date);
	}
	return MathUtil.max(array);
}
var logmeta = new HashMap(); 
EventUtil.addOnloadEventListener(function(){
	//map = getMap();
	init();
	
	$("#map-toggle").click(function(){
		$("#googlemap").toggle();
	});

	
	
	$("#search").click(function(){
		var selectedId = $('#log-list').selectpicker('val');
		if(selectedId && selectedId.length>0){
			$("#log-container").empty();
		 	var keys = log.getKeys();
		 	for (var i = 0; i < keys.length; i++) {
		 		log.get(keys[i]).finalize();
		 		log.get(keys[i]).isSearch=false;
		 	}
			for (var i = 0; i < selectedId.length; i++) {
				select(selectedId[i]);
			}
			
		}
	});
	
	
	
	<c:if test="${param.id ne null }">
		select("${param.id}");
	</c:if>
	
});


function init(){ 
	var param_user = {
			"url":"/ajax/user",
			"data" : 	{"MN":"getUser","u":"${param.u}"},
			"async": false,
			onSuccess : function(data){
				for (var i = 0; i < data.length; i++) {
					$("#user_name").text(data[i].NAME);
				}
			}
			
	}
	request(param_user,"loading user infomation request..");
	
	var param_logtype = {
			"url":"/ajax/log",
			"data" : 	{"MN":"getLogType"},
			"async": false,
			onSuccess : function(data){
				$("#addLog-container").empty()
				$("#log-list").empty();
				var beforeData;
				for (var i = 0; i < data.length; i++) {
					logmeta.put(data[i].TYPE,data[i]);
					var btn = $("<li><a href='#'><span class='"+data[i].ICON+"'></span> "+data[i].TYPE+"</a></li>");
					(function(fnc){
						btn.click(function(e){ eval(fnc)(); });	
					})(data[i].EXECUTEFNC);
					
					
					if(i==0){
// 						$("#addLog-container").append("<li class='dropdown-header'>"+data[i].LOG_GBUN+" <span class='caret'></span></li><li role='separator' class='divider'></li>");
					}else if(beforeData&& beforeData.LOG_GBUN != data[i].LOG_GBUN){
						$("#addLog-container").append("<li role='separator' class='divider'></li><li class='dropdown-header'>"+data[i].LOG_GBUN+" <span class='caret'></span></li><li role='separator' class='divider'></li>");
					}
					
					$("#addLog-container").append(btn);
					var logTypeE =  $("<optgroup id='log-list-"+data[i].TYPE+"'data-icon='"+data[i].ICON+"' label='"+data[i].TYPE+"'></optgroup>");
					$("#log-list").append(logTypeE);
					
					beforeData = data[i];
				}
				$('#log-list').selectpicker('refresh');


			}
		};
	request(param_logtype,"loading log infomation request..",false);
	
	var param_log = {
			"url":"/ajax/log",
			"data" : 	{"MN":"selectLog","u":"${param.u}"},
			"async": false,
			onSuccess : function(data){
				$("#log-list optgroup").empty()
				for (var i = 0; i < data.length; i++) {
					var obj = log.get(data[i].LOG_ID)||eval("new "+data[i].PROTOTYPE+"()");
					obj.id 		= data[i].LOG_ID;
					obj.title	= data[i].TITLE;
					obj.type 	= data[i].TYPE;
					obj.open 	= data[i].OPEN;
					obj.min_date= Number(data[i].MIN_DATE);
					obj.max_date= Number(data[i].MAX_DATE);
					log.put(data[i].LOG_ID,obj);
					
					var logE = $("#log-list-"+data[i].TYPE).append("<option id='log-list-item-"+data[i].LOG_ID+"' value='"+data[i].LOG_ID+"' data-subtext='("+obj.min_date+"~"+obj.max_date+")'>"+(data[i].TITLE)+"</option>");
// 					var logE = $("#log-list-"+data[i].TYPE).append("<option id='log-list-item-"+data[i].LOG_ID+"' value='"+data[i].LOG_ID+"'>"+(data[i].TITLE)+"</option>");
					$("#log-list").append(logE);
				}
				$('#log-list').selectpicker('refresh');
			}
		};
	request(param_log,"loading log infomation request..",false);
	
}

<c:if test="${ROLEK.USER_SEQ==param.u}">
	
	function saveTitle(id){
		var atData = log.get(id);
		var param = {
				"url":"/ajax/log",
				"data" :{
						"MN":"saveLog",
						"log_seq":logmeta.get(atData.type).LOG_SEQ,
						"log_id":id,
						"title":atData.title,
						"open":atData.open,
					},
				onSuccess : function(data){
					for (var i = 0; i < data.length; i++) {
						var openIcon = $("#open-icon-"+data[i].LOG_ID);
						openIcon.removeClass("fa-eye fa-eye-slash");
						if(data[i].OPEN=="Y"){
							openIcon.addClass("fa-eye");
						}else if(data[i].OPEN=="N"){
							openIcon.addClass("fa-eye-slash");
						}
					}
					toastr.success("save Success!");
				}
			};
		request(param,"save log ...")
	}
	function save(id){
		confirm(log.get(id).title+" ("+log.get(id).type+")<br/><h4>Log SAVE?</h4>",function(){
			var atData = log.get(id);
			var param = {
					"url":"/ajax/log",
					"data" :{
							"MN":"saveLogData",
							"log_seq":logmeta.get(atData.type).LOG_SEQ,
							"log_id":id,
							"title":atData.title,
							"open":atData.open,
							"data":atData.insertData()
						},
					onSuccess : function(data){
						toastr.success("save Success!");
					}
				};
			request(param,"save log ...")
		});
	}
	function remove(id){
		
		confirm(log.get(id).title+" ("+log.get(id).type+")<br/><h4 style='color:red'>Log DELETE?</h4>",function(){
			var atData = log.get(id);
			var param = {
					"url":"/ajax/log",
					"data" :{
							"MN":"deleteLog",
							"log_seq":logmeta.get(atData.type).LOG_SEQ,
							"log_id":id
						},
					onSuccess : function(data){
						toastr.success("remove Success!");
						log.get(id).finalize();
						log.remove(id);
					}
				};
			request(param,"remove log ...")
		});
	
	}
</c:if>


function select(id){
	var atData = log.get(id);
	var param = {
			"url":"/ajax/log",
			"data" :{
				"MN":"selectLogData",
				"log_seq":logmeta.get(atData.type).LOG_SEQ,
				"log_id":atData.id,
				"u":"${param.u}"
			},
			onSuccess :(function(pData){
				return function(data){
					var loadData = new Array();
					for (var i = 0; i < data.length; i++) {
						loadData.push(ConvertingUtil.JsonStringToObject(data[i].LOG_DATA));
					}
					pData.selectData(loadData);
					pData.add();
				}
			})(atData)
		};
	atData.isSearch=true;
 	request(param,"loading log ["+atData.title+"] request..")

}

function loadMapForm(id){
	var param = new Object(); 
	id = id||JavaScriptUtil.getUniqueKey()
	param['id'] = id;
	param['url'] = "/view/log/form/map.form";
	loadPage(param,function(data,readyState,status){
		
		var popupParam = {
				title:'MapLog',
				body: data,
				btn:[{title:"accept",callback:
					function(){
						try{
							var o = log.get(id)||new MapLog();
							o.id	= id;
							o.finalize();
							o.title	= $('#map-form-title').val();
							o.data	= eval($('#map-form-data').val())
							log.put(id,o);
							o.isSearch=true;
							o.add();
							popupClose()
						}catch(err){
							alert("Error Log!! : "+err+"");
							return;
						}
					}
				}]
		}
		popup(popupParam);
		///// form load  통신으로 처리하긴 이미지 크기 힘들어요그래서 이렇게.
		if(log.get(id) && log.get(id).data){
			var pdata = log.get(id);
			$("#map-form-title").val(pdata['title']);
			$("#map-form-data").val(JavaScriptUtil.arrayToString(pdata['data']));
		}
		/////
	});
}


function loadDataForm(id){
	var param = new Object(); 
	id = id||JavaScriptUtil.getUniqueKey()
	param['id'] = id;
	param['url'] = "/view/log/form/data.form";
	//param['data'] = log.get(id);
	
	loadPage(param,function(data,readyState,status){
		var popupParam = {
				title:'DataLog',
				body: data,
				btn:[{title:"accept",callback:
					function(){
					
						try{
							var o 	= log.get(id)||new DataLog();
							o.id	= id;
							o.title	= $('#data-form-title').val();
							o.data	= eval($('#data-form-data').val());
							log.put(id,o);
							o.isSearch=true;
							o.add();
							popupClose();
						}catch(err){
							alert("Error Log!! : "+err+"");
							return;
						}
					}
				}]
		}
		popup(popupParam);
		
		///// form load  통신으로 처리하긴 이미지 크기 힘들어요그래서 이렇게.
		if(log.get(id) && log.get(id).data){
			var pdata = log.get(id);
			$("#data-form-title").val(pdata['title']);
			$("#data-form-data").val(JavaScriptUtil.arrayToString(pdata['data']));
		}
		/////
	});
}


function loadPhotoForm(id){
	var param = new Object(); 
	id = id||JavaScriptUtil.getUniqueKey()
	param['id'] = id;
	param['url'] = "/view/log/form/photo.form";
	param['data'] = null;
	
	loadPage(param,function(data,readyState,status){
		var popupParam = {
				title:'PhotoLog',
				body: data,
				btn:[{title:"accept",callback:
					function(){
						try{
							var o = log.get(id)||new PhotoLog();
							o.id=id;
							o.title=$('#photo-form-title').val();
							o.data=(function(){
										var array = new Array();
										$("div[name='photo-form-content']").each(function(t){
											array.push({
												src : ConvertingUtil.Base64EncodeUrl($(this).find("img[name='photo-form-content-photo']").attr("src")), 
												date : $(this).find("input[name='photo-form-content-date']").val(), 
												latlng : $(this).find("input[name='photo-form-content-latlng']").val()
												
											});
										});
										return array;
									})();
							log.put(id,o);
							o.isSearch=true;
							o.add();
							popupClose()
						}catch(err){
							alert("Error Log!! : "+err+"");
							return;
						}
					}
				}]
		}
		popup(popupParam);
		
		///// form load  통신으로 처리하긴 이미지 크기 힘들어요그래서 이렇게.
		if(log.get(id) && log.get(id)['data']){
			var pdata = log.get(id);
			$("#photo-form-title").val(pdata['title']);
			for (var i = 0; i < pdata['data'].length; i++) {
				addImg(ConvertingUtil.Base64DecodeUrl(pdata['data'][i].src), pdata['data'][i].date, pdata['data'][i].latlng);
			}
		}
		/////
	});
}


function loadMsgForm(id){
	var param = new Object(); 
	id = id||JavaScriptUtil.getUniqueKey()
	param['id'] = id;
	param['url'] = "/view/log/form/msg.form";
	param['data'] = null;
	
	
	loadPage(param,function(data,readyState,status){
		

		
		var popupParam = {
				title:'MsgLog',
				body: data,
				btn:[{title:"accept",callback:
					function(){
						try{
							var o = log.get(id)||new MsgLog();
							o.id = id;
							o.title=$('#msg-form-title').val();
							o.data=(function(){
										var array = new Array();
										$("div[name='msg-form-content']").each(function(t){
											array.push({
												msg : $(this).find("textarea[name='msg-form-content-msg']").val(), 
												date : $(this).find("input[name='msg-form-content-date']").val(), 
												latlng : $(this).find("input[name='msg-form-content-latlng']").val()
												
											});
										});
										return array;
									})();
							log.put(id,o);
							o.add();
							popupClose()
						}catch(err){
							alert("Error Log!! : "+err+"");
							return;
						}
					}
				}]
		}
		popup(popupParam);
		
		///// form load  통신으로 처리하긴 이미지 크기 힘들어요그래서 이렇게.
		if(log.get(id) && log.get(id)['data']){
			var pdata = log.get(id);
			$("#msg-form-title").val(pdata['title']);
			for (var i = 0; i < pdata['data'].length; i++) {
				addMsg(pdata['data'][i].msg,pdata['data'][i].date,pdata['data'][i].latlng);
			}
		}
		/////
	});
}

function loadLiveGPSForm(id){
	var param = new Object(); 
	id = id||JavaScriptUtil.getUniqueKey()
	param['id'] = id;
	param['url'] = "/view/log/form/liveGPS.form";
	param['data'] = null;
	loadPage(param,function(data,readyState,status){
		var popupParam = {
				title:'liveGPSLog',
				body: data,
				btn:[{title:"save",callback:
					function(){
						try{
							var o = log.get(id)||new LiveGPSLog();
							o.finalize();
							o.id	= id;
							o.title=$('#livegps-form-title').val();
							o.data	= eval("[]");
							o.isSearch=true;
							log.put(id,o);
							o.add();
							popupClose()
							saveTitle(o.id);
						}catch(err){
							alert("Error Log!! : "+err+"");
							return;
						}
					}
				}]
		}
		popup(popupParam);
		///// form load  통신으로 처리하긴 이미지 크기 힘들어요그래서 이렇게.
		if(log.get(id) && log.get(id)['data']){
			var pdata = log.get(id);
			$("#msg-form-title").val(pdata['title']);
			for (var i = 0; i < pdata['data'].length; i++) {
				addMsg(pdata['data'][i].msg,pdata['data'][i].date,pdata['data'][i].latlng);
			}
		}
	});
}

function chartPhotoData(id){
	var data = log.get(id);
	var dataObj = data['data'];  //[ {date:"", latlng:""}... ]	
	
	var returnDataObj = new Array();
	var map = getMap();
	var markers = new Array();
	for (var i = 0; i < dataObj.length; i++) {
		var obj = dataObj[i];
		var latlng = obj['latlng'].split(",");
		var lat = latlng[0];
		var lng = latlng[1];
		var marker = GmapUtil.createMarker(map,Number(lat),Number(lng));
		markers.push(marker);
		
		
		(function(marker,src){
 			marker.addListener('click', function(){
 				var infowindow = new google.maps.InfoWindow({
 					content: "<div class='thumbnail'><img src='"+ConvertingUtil.Base64DecodeUrl(src)+"'/></div>",
 		    	    //maxWidth: 200
 		    	  });
 			    infowindow.open(map, marker);
 		  	});
 		})(marker,dataObj[i]['src']);

		
		//marker.content = "<div  class='thumbnail'><img src='"+dataObj[i]['src']+"'/></div>";
		returnDataObj.push({
			date : dataObj[i]['date'],
			photo: 1
		}) 
		//delete dataObj[i]['latlng'];
		//delete dataObj[i]['src'];
	}
	markers['visible']=true;
 	data['markers'] =[];
 	data['markers'] = markers;
 	GmapUtil.fitBoundsMarkerArry(map,markers);
	return returnDataObj;
}


function chartMsgData(id){
	var data = log.get(id);
	var dataObj = data['data'];  //[ {date:"", latlng:""}... ]	

	
	var returnDataObj = new Array();
	var map = getMap();
	var markers = new Array();
	for (var i = 0; i < dataObj.length; i++) {
		var obj = dataObj[i];
		var latlng = obj['latlng'].split(",");
		var lat = latlng[0];
		var lng = latlng[1];
		var marker = GmapUtil.createMarker(map,Number(lat),Number(lng));
		markers.push(marker);
		
		
		(function(marker,msg){
 			marker.addListener('click', function(){
 				var infowindow = new google.maps.InfoWindow({
 					content: msg,
 		    	    //maxWidth: 200
 		    	  });
 			    infowindow.open(map, marker);
 		  	});
 		})(marker,dataObj[i]['msg']);

		
		//marker.content = "<div  class='thumbnail'><img src='"+dataObj[i]['src']+"'/></div>";
		//dataObj[i]['photo']=1;
		returnDataObj.push({
			date : dataObj[i]['date'],
			msg: 1
		}) 
		//delete dataObj[i]['latlng'];
		//delete dataObj[i]['src'];
	}
	markers['visible']=true;
	data['markers'] = [];
 	data['markers'] = markers;
 	GmapUtil.fitBoundsMarkerArry(map,markers);
	return returnDataObj;
}


function chartMapSpeedData(id){
	var data = log.get(id);
	var dataObj = data['data'];//[ {date:"", latlng:""}... ]	
	
	
	var flightPlanCoordinates = new Array();
	var speed_data	= new Array();
	var before_date = undefined;
	var before_lat = undefined;
	var before_lng = undefined;
	
	var returnDataObj = new Array();
	for (var i = 0; i < dataObj.length; i++) {
		var obj = dataObj[i];
		var d = transDate(obj.date);
		var latlng = obj['latlng'].split(",");
		var lat = latlng[0];
		var lng = latlng[1];
		
		if(before_date){
			var hms = 60*60*1000; 
			var bms = before_date.getTime();
			var dms = d.getTime();
			var dist_ms = dms - bms;
			
			var per =  MathUtil.getPercentByTot(dist_ms, hms);
			var dist_k = MathUtil.gpsdist(lat,lng, before_lat, before_lng,'K');
			var tt = undefined;
			if(hms>dist_ms){
				tt = MathUtil.getValuePercentUp(dist_k,per);
			}else{
				tt = MathUtil.getValuePercentDown(dist_k,100-per);
			}
			//speed_data.push({"x":obj['date'], "y":tt});
			if(!dataObj[i]['speed'])	//speed 비어있는곳이 있으면. 넣어준다.
				dataObj[i]['speed'] = isNaN(tt)?0:tt.toFixed(2);
		}
		//delete dataObj[i]['latlng'];
		
		var p = {
				"lat":Number(lat),
				"lng":Number(lng)
		};
		flightPlanCoordinates.push(p);
		//before setting
		before_date = d;
		before_lat = lat;
		before_lng = lng;
	}
	
	var map = getMap();
	var flightPath = new google.maps.Polyline({
	    path: flightPlanCoordinates,
	    strokeColor: ColorUtil.prototype.getRandomColor(),
	    strokeOpacity: 1.0,
	    strokeWeight: 2
	  });
	flightPath.setMap(null);
 	flightPath.setMap(map);
 	flightPath["visible"]=true;
 	data['polyline'] = flightPath;
 	
 	GmapUtil.fitPolylineBounds(map,flightPath);
 	
 	//var returnMap = transTypeChartData(dataObj);
 	//returnMap.remove("latlng");
 	//returnMap.put("speed",speed_data);
 	
	return dataObj;
}


function transDate(dataStr){
// 	var yyyyMMddHHmmss =  data.split(" ");
// 	var yyyyMMdd = yyyyMMddHHmmss[0];
// 	var HHmmss = yyyyMMddHHmmss[1];
	
// 	yyyyMMdd = yyyyMMdd.split(":");
// 	var yyyy = yyyyMMdd[0]; 
// 	var MM = Number(yyyyMMdd[1])-1; 
// 	var dd = yyyyMMdd[2];
	
// 	HHmmss = HHmmss.split(":");
// 	var HH = HHmmss[0]; 
// 	var mm = HHmmss[1]; 
// 	var ss = HHmmss[2];
// 	var d = new Date(yyyy, MM, dd, HH, mm, ss, 0);


//"20150425121133".substring(0,4) + " " + "20150425121133".substring(4,6) + " " + "20150425121133".substring(6,8) + " " + "20150425121133".substring(8,10)  + " " + "20150425121133".substring(10,12)  + " " + "20150425121133".substring(12,14)
	var d = new Date(dataStr.substring(0,4), dataStr.substring(4,6), dataStr.substring(6,8), dataStr.substring(8,10), dataStr.substring(10,12), dataStr.substring(12,14), 0);
	return d;
}

function transTypeChartData(data){
	var dataMap = new HashMap();
	var dateArray = new Array();
	for (var i = 0; i < data.length; i++) {
		var obj = data[i];
		var datems = transDate(obj['date']).getTime();
		dateArray.push(datems);
		for (var property in obj) { //property
			if(property=='date'){continue;}
			if(dataMap.get(property)==undefined){dataMap.put(property,new Array())}
			
			var addObj = new Object();
			addObj['x']=datems;
			if(isNaN(obj[property]))
			addObj['y']= 0;//obj[property];
			else
			addObj['y']= Number(obj[property]);
				
			dataMap.get(property).push(addObj);
	    }	
	}
	dataMap['min_date'] = MathUtil.min(dateArray);
	dataMap['max_date'] = MathUtil.max(dateArray);
	return dataMap;
}



function addLog(id){
	var data = log.get(id);
	
	
	try { 
		
		//var dataObj = eval("[" + data['data'] +"]");
		var dataObj = undefined;   //[{date:"yyyy.MM.dd HH:mm:ss", data1:"value",data2:"value"}, {date:"yyyy.MM.dd HH:mm:ss", data1:"value",data2:"value"} ...]
		
		try{
			dataObj = data['chartData'](); 
			if(!dataObj){
				dataObj = data['data']; 
			}
		}catch(err){console.log(err)};
		
		
		var container_id = "container-"+id;
		var title_id = "title-"+id;
		var toggle_id = "toggle-"+id;
		var edit_id = "edit-"+id;
		var remove_id = "remove-"+id;
		var graph_id = "graph-"+id;
// 		var scope_id = "scope-"+id;
		var public_id = "public-"+id;
		var private_id = "private-"+id;
		var open_icon_id = "open-icon-"+id;
		var save_id = "save-"+id;
		var body_id = "body-"+id;
		var footer_id = "footer-"+id;
		var slider_id = "slider-"+id;
		var h="";
		h+='<div id="'+container_id+'" class="panel panel-default" style="margin-bottom:10px;">';
		h+='	<div class="panel-heading" style="padding:3px;">';
		h+='	<h3 class="panel-title">';
		h+='				<div class="input-group input-group-sm" >';
		h+='		  			<span class="input-group-addon"  id="sizing-addon3"><span class="fa '+logmeta.get(data['type']).ICON+' aria-hidden="true"></span></span>';
		h+='		  			<input id="'+title_id+'" readonly type="text" class="form-control" placeholder="title" aria-describedby="sizing-addon3" value="'+data['title']+'"/>';
		h+='						<span class="input-group-btn" style="padding-left:10px;">';
		
		
        <c:if test="${ROLEK.USER_SEQ==param.u}">
		h+='						<button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown" style="border-top-left-radius:4px;border-bottom-left-radius:4px;"  aria-haspopup="true" aria-expanded="false"><span id="'+open_icon_id+'"class="fa fa-eye'+(data.open=="N"?"-slash":"")+'"></span></button>';
        h+='						<ul class="dropdown-menu dropdown-menu-right">';
		h+='							<li id="'+public_id+'"><a id="map" href="#"><span class="fa fa-eye"></span> public</a></li>';
		h+='							<li id="'+private_id+'"><a id="map" href="#"><span class="fa fa-eye-slash "></span> private</a></li>';
        h+='						</ul>';
// 		h+='							<button id="'+scope_id+'" class="btn btn-default" style="border-top-left-radius:4px;border-bottom-left-radius:4px;" type="button"><span class="fa fa-arrows-h" aria-hidden="true"></span></span></button>';
		h+='							<button id="'+save_id+'" class="btn btn-default" type="button"><span class="fa fa-floppy-o" aria-hidden="true"></span></span></button>';
		h+='							<button id="'+edit_id+'" class="btn btn-default" style="border-top-right-radius:4px;border-bottom-right-radius:4px;" type="button"><span class="fa fa-pencil-square-o" aria-hidden="true"></span></span></button>';
		h+='							<button id="'+remove_id+'" class="btn btn-default" style="border-top-left-radius:4px;border-bottom-left-radius:4px;" type="button"><span class="fa fa-times" aria-hidden="true"></span></button>';
		</c:if>
		h+='							<button id="'+toggle_id+'" class="btn btn-default"  type="button"><span class="fa fa-bars" aria-hidden="true"></span></span></button>';
		h+='						</span>';
		h+='				</div>';
		h+='	</h3>';
		h+='	</div>';
		h+='	<div id="'+body_id+'" class="panel-body" style="padding:0px;">';
		h+='	</div>';
		h+='	<div id="'+footer_id+'" class="panel-footer">';
		h+='	 <div class="slider slider-horizontal"  style="width: 100%" id="'+slider_id+'"></div>';
		h+='	</div>';
		//h+='		<canvas id="'+graph_id+'"  style="width:100%; height:100px;"></canvas>';
		h+='</div>';
		
		var newLog=$(h);	
		
		
		newLog.find("#"+public_id).click(function(){
			data['open'] = "Y";
			saveTitle(id);
		});
		newLog.find("#"+private_id).click(function(){
			data['open'] = "N";
			saveTitle(id);
		});

		newLog.find("#"+save_id).click(function(){
			if(data['save'])
				data['save']();
		});
		
// 		newLog.find("#"+scope_id).click(function(){
// 			var at = log.get(id);
// 			///////slider
// 			 var option = {
// 			    		"min":at['min_date'],
// 			    		"max":at['max_date'],
// 			    		"value":0,
// 			    		"tooltip":"always",
// 			    		formatter: function(value) {
// 			    			var d = new Date(value);
// 			    			return DateUtil.getDate("yyyy:MM:dd HH:mm:ss",d);
// 			    		}
// 			    };
// 		    $('#slider').slider('destroy')
// 		    $('#slider').slider(option);
// 		    $('#slider').on('slide',function(ev){
// 		    	var keys = log.getKeys();
// // 		    	var oldZoom = GmapUtil.getZoom(getMap());
// 	    		var rg = at.setTime(ev.value);
// 	    		GmapUtil.move(getMap(),rg.lat(),rg.lng());
// 		    	for (var z = 0; at.graph && z < at.graph.length; z++) {
// 		    		at.graph[z].setXLine(ev.value);
// 		    	}
// // 		    	GmapUtil.fitBounds(getMap(),gpss);
// // 		    	if(oldZoom!=GmapUtil.getZoom(getMap()))
// // 		    	GmapUtil.setZoom(getMap(),oldZoom);
// 		    });
// 		});

		newLog.find("#"+toggle_id).click(function(){
			newLog.find("#"+body_id).toggle();
			newLog.find("#"+footer_id).toggle();
			if(data['toggle'])
				data['toggle']();
		});
		newLog.find("#"+edit_id).click(function(){
			if(data['edit'])
				data['edit']();
		});
		newLog.find("#"+remove_id).click(function(){
			if(data['remove'])
				data['remove']();
// 			$("#"+container_id).remove();
// 			log.remove(id);
		});
		
		
		
		
		
		
		
	 	var graphArry = new Array();
		var chart_data 	= new Array();
		var dataMap 	= transTypeChartData(dataObj);
		data['min_date'] = dataMap['min_date']||0;
		data['max_date'] = dataMap['max_date']||0;
		
	 	var keys = dataMap.getKeys();
		for (var i = 0; i < keys.length; i++) {
				var atKey = keys[i];
				
			//ignore
			if(atKey=="latlng"){//위도경도는 그릴수가없다.   
				continue;
			}
			var atData = dataMap.get(atKey);
			var canvas = document.createElement("canvas");
			canvas.id = graph_id+"_"+atKey;
			var jCanvas = $(canvas);
			jCanvas.css("width","100%");
			jCanvas.css("height","120px");
		 	//graphk
			var graph = new GraphK(canvas);
			graph.contentTitle = atKey;
			graph.chartDataVisible 		= false;
			graph.chartAxisScaleVisible = false;
			graph.setMargin(10,25,10,0); //t, r, b, l 
			graph.setPadding(1,1,1,1);
			graph.chartAxisXDataMinMarginPercent = 5;
			graph.chartAxisXDataMaxMarginPercent = 5;
			graph.chartAxisYDataMinMarginPercent = 5;
			graph.chartAxisYDataMaxMarginPercent = 5;
			graph.chartAxisXCount = data.chartAxisXCount==undefined?5:data.chartAxisXCount;
			graph.chartAxisYCount = data.chartAxisYCount==undefined?4:data.chartAxisYCount;
			graph.chartAxisXFnc = function(data,index){
				var date = new Date(Number(data));
// 				return DateUtil.getDate("yyyy:MM:dd HH:mm:ss",date); 
				return DateUtil.getDate("HH:mm:ss",date); 
			}
				
			//dataset
			var graphData = new GraphDataK("data", atData);
			graphData.setType(data['chartType']);
			graphData.setWidth(10);
			graphData.setFillStyle(GraphKUtil.getRandomColor());
			graphData.setStrokeStyle(GraphKUtil.getRandomColor());
			graphData.setFillStyle(GraphKUtil.getRandomColor());
			 
			var graphDataKSet = new GraphDataKSet();
			graphDataKSet.push(graphData);
			
			graph.setData(graphDataKSet);
			graph.canvas.width = jCanvas.width();
			graph.canvas.height = jCanvas.height();
			
			newLog.find("#"+body_id).append(jCanvas);
			graphArry.push(graph);
			
			
			
			
			
			
			jCanvas.click(function(){
				var at = log.get(id);
				///////slider
				 var option = {
				    		"min":at['min_date'],
				    		"max":at['max_date'],
				    		"value":0,
				    		"tooltip":"always",
				    		formatter: function(value) {
				    			var d = new Date(value);
				    			return DateUtil.getDate("yyyy:MM:dd HH:mm:ss",d);
				    		}
				    };
			    $('#slider').slider('destroy')
			    $('#slider').slider(option);
			    $('#slider').on('slide',function(ev){
			    	var keys = log.getKeys();
//	 		    	var oldZoom = GmapUtil.getZoom(getMap());
		    		var rg = at.setTime(ev.value);
		    		if(rg)
		    		GmapUtil.move(getMap(),rg.lat(),rg.lng());
			    	for (var z = 0; at.graph && z < at.graph.length; z++) {
			    		at.graph[z].setXLine(ev.value);
			    	}
//	 		    	GmapUtil.fitBounds(getMap(),gpss);
//	 		    	if(oldZoom!=GmapUtil.getZoom(getMap()))
//	 		    	GmapUtil.setZoom(getMap(),oldZoom);
			    });
			});
		}
			
		data.finalize();
		
		//////slider
		 var option = {
		    		"min":data['min_date'],
		    		"max":data['max_date'],
		    		"value":[data['min_date'],data['max_date']],
		    		"tooltip":"hide",
// 		    		"tooltip":"always",
		    		formatter: function(value) {
		    			var fd = new Date(value[0]);
		    			var td = new Date(value[1]);
		    			return DateUtil.getDate("HH:mm:ss",fd)+"~"+DateUtil.getDate("HH:mm:ss",td);
		    		}
		};
		newLog.find("#"+slider_id).slider(option);
		newLog.find("#"+slider_id).on('slide',function(ev){
			var at = log.get(id);
	    	for (var z = 0; at.graph && z < at.graph.length; z++) {
	    		at.graph[z].chartAxisXDataMin      = ev.value[0];
	    		at.graph[z].chartAxisXDataMax      = ev.value[1];
	    		at.graph[z].rendering();
// 	    		at.graph[z].setXLines(ev.value);
	    	}
	    });
		 
		
		
		
		$("#log-container").append(newLog);
		
		
		var keys = log.getKeys();
		for(var i=0 ; i < keys.length ; i ++){
			$("#log-list-item-"+log.get(keys[i]).id).remove();
			var logE = $("#log-list-"+log.get(keys[i]).type).append("<option id='log-list-item-"+log.get(keys[i]).id+"' value='"+log.get(keys[i]).id+"' data-subtext='("+DateUtil.getDate('yyyy:MM:dd HH:mm:ss',log.get(keys[i]).min_date)+"~"+DateUtil.getDate('yyyy:MM:dd HH:mm:ss',log.get(keys[i]).max_date)+")'>"+log.get(keys[i]).title+"</option>");
// 			var logE = $("#log-list-"+log.get(keys[i]).type).append("<option id='log-list-item-"+log.get(keys[i]).id+"' value='"+log.get(keys[i]).id+"'>"+log.get(keys[i]).title+"</option>");
			$("#log-list").append(logE);
		}
		$('#log-list').selectpicker('refresh');
		
		
		
		
		for (var i = 0; i < graphArry.length; i++) {
			var gc = graphArry[i];
			gc.rendering();
			//gc.onMouseTraking();   
			gc.onDrag();
		}
		$(window).resize(function(){
			for (var i = 0; i < graphArry.length; i++) {
				var gc = graphArry[i];
				gc.rendering();
			}
		});
		
		data['graph'] = graphArry;
	}catch(err){
		console.log(err);
		throw err;
	}
	return true;
}
function getMap(){
	if(!map){
		var gsStatoin = new google.maps.LatLng(38.898102, -77.036519);
		var mapOptions = {
			zoom: 13,
			mapTypeId: google.maps.MapTypeId.ROADMAP,
			center: gsStatoin
		};
		map = GmapUtil.createMap(document.getElementById("googlemap"),mapOptions);
		var marker = new google.maps.Marker({
			map:map,
			animation: google.maps.Animation.DROP
	 	});
	}
	$("#map-container").show();
	return map;
}







</script>
<body>
	<!-- nav start -->
	<fluid:insertView id="page-body-nav"/>
	<!-- nav end -->
	
  <!-- page Start --> 
	<div id="container" class="container-fluid" >
	
<!--     <div class="row row-centered"> -->
<!--         <div class="col-xs-6 col-centered"><div class="item"><div class="content">1</div> 11</div></div> -->
<!--         <div class="col-xs-6 col-centered"><div class="item"><div class="content">2</div> 22</div></div> -->
<!--         <div class="col-xs-3 col-centered"><div class="item"><div class="content">3</div> 33</div></div> -->
<!--         <div class="col-xs-3 col-centered"><div class="item"><div class="content">4</div> 44</div></div> -->
<!--         <div class="col-xs-3 col-centered"><div class="item"><div class="content">5</div> 55</div></div> -->
<!--     </div> -->
	
      <!-- Three columns of text below the carousel -->
      <div class="row row-centered">
        <div class="col-md-4 col-centered">
        </div>
        
        <div class="col-md-4 col-centered" >
        	<div class="item" style="width: 100%">
        		<div class="content">
			          <img class="img-circle" src="/user/profile.png?u=${param.u}" width="100" height="100"/>
			          <h2 id="user_name"></h2>
			          <p>
<!-- 			          <span id="introduce-container">you timelog introduce...edit</span> -->
<!-- 			          <a href="#" id="introduce-edit-btn"><span class="fa fa-pencil-square-o" aria-hidden="true"></span></a> -->
<!-- 			          <a href="#" id="introduce-save-btn"><span class="fa fa-floppy-o" aria-hidden="true"></span></a> -->
			          </p>
				</div>
			</div>
        </div><!-- /.col-lg-4 -->
        
        <div class="col-md-4 col-centered">
        </div>
      </div><!-- /.row -->
      <div class="row" style="padding: 10px;">
      			<div class="input-group">
					  <div>
					<!-- data-live-search="true" -->
				          <select id="log-list" data-width="100%"  data-showSubtext="true" data-selected-text-format="count" class="selectpicker" title="Selected Logs ..." multiple  data-live-search-placeholder="Search" data-actions-box="true" data-dropupAuto="false">
				           </select>
			          </div>
		          <c:if test="${ROLEK.USER_SEQ==param.u}">
				      <div class="input-group-btn">
					        <button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"><span class="fa fa-plus" aria-hidden="true"></span></button>
					        <ul id="addLog-container" class="dropdown-menu dropdown-menu-right">
	<!-- 				          <li><a id="map" href="#"><span class="fa fa-map"></span> Map</a></li> -->
					          <!-- li role="separator" class="divider"></li-->
					        </ul>
				      </div><!-- /btn-group -->
			      </c:if>
			     <span class="input-group-btn">
			        <button id="search" class="btn btn-default" type="button"><span class="fa fa-search" aria-hidden="true"></span><span class="hidden-xs"> Search</span></button>
			      </span>
			    </div><!-- /input-group -->
      </div>
	
	
	<div id="map-container" style="display: none;">
<!-- 	<div id="map-container"  style="margin-bottom:10px;"> -->
		<div class="panel panel-default">
			<div class="panel-heading" style="padding:3px; text-align: right;">map <button id="map-toggle" style="padding-top: 0px; padding-bottom: 0px;" class="btn btn-default" type="button"><span class="fa fa-bars" aria-hidden="true"></span></span></button></div>
		  <div class="panel-body" id="googlemap" style="height:280px; " >
		    Panel content
		  </div>
<!-- 		  <div class="panel-footer"> -->
<!-- 		  </div> -->
		  </div>
	</div>
	
	
	<div id="log-container"  >
	</div>
	
	<div id="slider-container"  >
	  <nav class="navbar-fixed-bottom" style="padding-bottom: 10px; padding-left: 60px; padding-right: 60px;">
	  	<div class="row">
	  		<div class="col-xs-12 col-md-12">
	  			<div class="slider slider-horizontal"  style="width: 100%" id="slider"></div>
	  		</div>
	  	</div>
	  </nav> 
    </div> <!-- /container -->
	<!-- page END -->
	<fluid:insertView id="page-body-footer"/>
	</div>
</body>