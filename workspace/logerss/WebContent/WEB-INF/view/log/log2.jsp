<%@page import="khh.web.jsp.framework.validate.rolek.RoleK"%>
<%@page import="khh.web.jsp.framework.validate.rolek.Role"%>
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="khh.property.util.PropertyUtil"%>
<%@taglib prefix="fluid"  uri="http://visualkhh.com/fluid"%>
<script src="/front-end/javascript/exif/exif-js-master/exif.js"></script>
<script src="/front-end/javascript/visualkhh/device_util.js"></script>
<script src="/front-end/javascript/visualkhh/googlemap_util.js"></script>
<script src="/front-end/graphK/graphk_util.js"></script>
<script src="/front-end/graphK/graphk_object.js"></script>
<script src="/front-end/graphK/graphk.js"></script>
<script type="text/javascript" src="https://maps.google.com/maps/api/js?v=3.exp"></script>
<script type="text/javascript">

// class..........
function MapLog(){};
MapLog.prototype = new Object();
MapLog.prototype.id;
MapLog.prototype.type='map';
MapLog.prototype.chartType='linefill';
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
MapLog.prototype.add		= function(){return addLog(this.id);};
MapLog.prototype.insertData	= function(){return JavaScriptUtil.arrayToString(this.data);};		//DB에 저장히기전에 디코딩 컨버팅 역활한다
MapLog.prototype.selectData	= function(getData){this.data=getData;};		// DB에서 가져온뒤 엔코딩 컨버팅 역활을한다.
MapLog.prototype.setTime	= function(time){
	if(this.graph==undefined || this.graph[0]==undefined || this.data==undefined || this.graph[0].data.getDataXMin()> time || time > this.graph[0].data.getDataXMax() ){return};
	
	
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
MapLog.prototype.finalize	= function(){
	if(this.point)
		GmapUtil.removeMarker(getMap(),this.point);
	this.polyline.setMap(null);
	this.markers = [];
	$("#container-"+this.id).remove();
};


function DataLog(){};
DataLog.prototype = new Object();
DataLog.prototype.id;
DataLog.prototype.type		= 'data';
DataLog.prototype.chartType	= 'linefill',
DataLog.prototype.min_date;//14554165155 초기 
DataLog.prototype.max_date;//14554165155 초기
DataLog.prototype.title;//:$('#data-form-title').val(),
DataLog.prototype.data;//:eval($('#data-form-data').val()),
DataLog.prototype.save		= function(){return save(this.id);};
DataLog.prototype.remove	= function(){return remove(this.id);};
DataLog.prototype.edit		= function(){return loadDataForm(this.id);};
DataLog.prototype.add		= function(){return addLog(this.id);};
DataLog.prototype.insertData	= function(){return JavaScriptUtil.arrayToString(this.data);};
DataLog.prototype.selectData	= function(getData){this.data=getData;};
DataLog.prototype.setTime	= function(time){
	
}
DataLog.prototype.finalize 	= function(){
			$("#container-"+this.id).remove();
}




function PhotoLog(){};
PhotoLog.prototype = new Object();
PhotoLog.prototype.id;
PhotoLog.prototype.type				= 'photo';
PhotoLog.prototype.chartType		= 'dot';
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
PhotoLog.prototype.add =  function(){return addLog(this.id);};
PhotoLog.prototype.insertData	= function(){return JavaScriptUtil.arrayToString(this.data);};
PhotoLog.prototype.selectData	= function(getData){this.data=getData;};
PhotoLog.prototype.setTime	= function(time){
	if(this.graph==undefined || this.graph[0]==undefined || this.data==undefined || this.graph[0].data.getDataXMin()> time || time > this.graph[0].data.getDataXMax() ){return};if(this.graph==undefined || this.graph[0]==undefined || this.graph[0].data.getDataXMin()> time || time > this.graph[0].data.getDataXMax() ){return};
	
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
	if(this.point)
		GmapUtil.removeMarker(getMap(),this.point);
	for(var i=0;i<this.markers.length;i++)
		this.markers[i].setMap(null);
	this.markers = [];
	$("#container-"+this.id).remove();
}


function MsgLog(){};
MsgLog.prototype = new Object();
MsgLog.prototype.id;
MsgLog.prototype.type			= 'msg';
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
MsgLog.prototype.add=function(){return addLog(this.id);};
MsgLog.prototype.insertData	= function(){return JavaScriptUtil.arrayToString(this.data);};
MsgLog.prototype.selectData	= function(getData){this.data=getData;};
MsgLog.prototype.setTime	= function(time){
	if(this.graph==undefined || this.graph[0]==undefined || this.data==undefined || this.graph[0].data.getDataXMin()> time || time > this.graph[0].data.getDataXMax() ){return};
	
	var btw = MathUtil.getBetweenSize($("#slider").data("slider").options.min, $("#slider").data("slider").options.max) //전체크기차
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
	return GmapUtil.createLatLng(Number(lat),Number(lng));
}
MsgLog.prototype.finalize=function(){
	if(this.point)
		GmapUtil.removeMarker(getMap(),this.point);
	for(var i=0;this.markers&&i<this.markers.length;i++)
		this.markers[i].setMap(null);
	this.markers = [];
	$("#container-"+this.id).remove();
};



var map;
var FROM_DATE;
var TO_DATE;
var log = new HashMap(); 
var logmeta = new HashMap(); 
EventUtil.addOnloadEventListener(function(){
	settingTimeLine();
	
	
	var param_logtype = {
			"url":"/ajax/log",
			"data" : 	{"MN":"getLogType"},
			"async": false,
			onSuccess : function(data){
				for (var i = 0; i < data.length; i++) {
					logmeta.put(data[i].TYPE,data[i]);
					var btn = $("<li><a href='#'><span class='"+data[i].ICON+"'></span> "+data[i].TYPE+"</a></li>");
					(function(fnc){
						btn.click(function(e){ eval(fnc)(); });	
					})(data[i].EXECUTEFNC);
					$("#addLog-container").append(btn);
				}
			}
		};
	request(param_logtype,"loading log infomation request..",false)
	
	var param_log = {
			"url":"/ajax/log",
			"data" : 	{"MN":"selectLog"},
			onSuccess : function(data){
				for (var i = 0; i < data.length; i++) {
					var obj;
					eval("obj = new "+data[i].PROTOTYPE+"()");
					obj.id 		= data[i].LOG_ID;
					obj.title	= data[i].TITLE;
					obj.type 	= data[i].TYPE;
					obj.min_date= Number(data[i].MIN_DATE);
					obj.max_date= Number(data[i].MAX_DATE);
					obj.type 	= data[i].TYPE;
					log.put(data[i].LOG_ID,obj);
					obj.add();
					//addLog(data[i].LOG_ID);
				}
			}
		};
	request(param_log,"loading log infomation request..")
});

function save(id){
	
	if(FROM_DATE==undefined || TO_DATE==undefined){ alert("You must have a selected date.!<br/>from ~ to!!");return;}
	var from_date_param = DateUtil.getDate("yyyy:MM:dd HH:mm:ss",FROM_DATE)
	var to_date_param = DateUtil.getDate("yyyy:MM:dd HH:mm:ss",TO_DATE)
	
	
	confirm("title:"+log.get(id).title+" (type:"+log.get(id).type+") <br/> "+from_date_param+" ~ "+to_date_param+"<br/><h4>Log SAVE?</h4>",function(){
		var atData = log.get(id);
		var param = {
				"url":"/ajax/log",
				"data" :{
						"MN":"saveLog",
						"from_date":DateUtil.getDate("yyyy:MM:dd HH:mm:ss",FROM_DATE),
						"to_date":DateUtil.getDate("yyyy:MM:dd HH:mm:ss",TO_DATE),
						"log_seq":logmeta.get(atData.type).LOG_SEQ,
						"log_id":id,
						"title":atData.title,
						"data":atData.insertData()
					},
				onSuccess : function(data){
					alert("save Success!");
				}
			};
		request(param,"save log ...")
	});
}
function remove(id){
	if(FROM_DATE==undefined || TO_DATE==undefined){ alert("You must have a selected date.!<br/>from ~ to!!");return;}
	var from_date_param = DateUtil.getDate("yyyy:MM:dd HH:mm:ss",FROM_DATE)
	var to_date_param = DateUtil.getDate("yyyy:MM:dd HH:mm:ss",TO_DATE)
	
	confirm("title:"+log.get(id).title+" (type:"+log.get(id).type+") <br/> "+from_date_param+" ~ "+to_date_param+"<br/><h4>Log DELETE?</h4>",function(){
		var atData = log.get(id);
		var param = {
				"url":"/ajax/log",
				"data" :{
						"MN":"deleteLog",
						"from_date":DateUtil.getDate("yyyy:MM:dd HH:mm:ss",FROM_DATE),
						"to_date":DateUtil.getDate("yyyy:MM:dd HH:mm:ss",TO_DATE),
						"log_seq":logmeta.get(atData.type).LOG_SEQ,
						"log_id":id
					},
				onSuccess : function(data){
					alert("remove Success!");
					log.remove(id);
				}
			};
		request(param,"remove log ...")
	});

}

function select(){
	if(FROM_DATE==undefined || TO_DATE==undefined){ alert("You must have a selected date.!<br/>from ~ to!!");return;}
	
	
	if(FROM_DATE.getTime()>=TO_DATE.getTime()){
		alert("The start date is greater than the ending date.!!");
		return;
	}
	
	
	
	
	
	var from_date_param = DateUtil.getDate("yyyy:MM:dd HH:mm:ss",FROM_DATE)
	var to_date_param = DateUtil.getDate("yyyy:MM:dd HH:mm:ss",TO_DATE)
// 	confirm("you choice:<br/>"+from_date_param+" ~ "+to_date_param+"<br/><h4>Log load?</h4>",function(){
// 	})


	var keys = log.getKeys();
	for (var i = 0; i < keys.length; i++) {
		var atData = log.get(keys[i]);
		var param = {
				"url":"/ajax/log",
				"data" :{
					"MN":"selectLogData",
					"from_date":DateUtil.getDate("yyyy:MM:dd HH:mm:ss",FROM_DATE),
					"to_date":DateUtil.getDate("yyyy:MM:dd HH:mm:ss",TO_DATE),
					"log_seq":logmeta.get(atData.type).LOG_SEQ,
					"log_id":atData.id
				},
				onSuccess :(function(pData){
					return function(data){
// 						console.log(pData);
// 						console.log(data);
// 						console.log("----------");
						var loadData = new Array();
						for (var i = 0; i < data.length; i++) {
							loadData.push(ConvertingUtil.JsonStringToObject(data[i].LOG_DATA));
						}
						pData.selectData(loadData);
						try{
							pData.finalize();
						}catch(err){};
						pData.add();
					}
				})(atData)
			};
	 	request(param,"loading log ["+i+"] request..")
// 	 	break;
	}



}

function loadMapForm(id){
	if(FROM_DATE==undefined || TO_DATE==undefined){ alert("You must have a selected date.!<br/>from ~ to!!");return;}
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
							var o = new MapLog();
							o.id	= id;
							o.title	= $('#map-form-title').val();
							o.data	= eval($('#map-form-data').val())
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
		if(log.get(id) && log.get(id).data){
			var pdata = log.get(id);
			$("#map-form-title").val(pdata['title']);
			$("#map-form-data").val(JavaScriptUtil.arrayToString(pdata['data']));
		}
		/////
	});
}


function loadDataForm(id){
	if(FROM_DATE==undefined || TO_DATE==undefined){ alert("You must have a selected date.!<br/>from ~ to!!");return;}
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
							var o 	= new DataLog();
							o.id	= id;
							o.title	= $('#data-form-title').val();
							o.data	= eval($('#data-form-data').val());
							log.put(id,o);
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
	if(FROM_DATE==undefined || TO_DATE==undefined){ alert("You must have a selected date.!<br/>from ~ to!!");return;}
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
							var o = new PhotoLog();
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
	if(FROM_DATE==undefined || TO_DATE==undefined){ alert("You must have a selected date.!<br/>from ~ to!!");return;}
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
							var o = new MsgLog();
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
				dataObj[i]['speed'] = tt.toFixed(2);
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


function transDate(data){
	var yyyyMMddHHmmss =  data.split(" ");
	var yyyyMMdd = yyyyMMddHHmmss[0];
	var HHmmss = yyyyMMddHHmmss[1];
	
	yyyyMMdd = yyyyMMdd.split(":");
	var yyyy = yyyyMMdd[0]; 
	var MM = Number(yyyyMMdd[1])-1; 
	var dd = yyyyMMdd[2];
	
	HHmmss = HHmmss.split(":");
	var HH = HHmmss[0]; 
	var mm = HHmmss[1]; 
	var ss = HHmmss[2];
	var d = new Date(yyyy, MM, dd, HH, mm, ss, 0);
	return d;
}

function transTypeChartData(data){
	var dataMap = new HashMap();
	for (var i = 0; i < data.length; i++) {
		var obj = data[i];
		for (var property in obj) { //property
			if(property=='date'){continue;}
			if(dataMap.get(property)==undefined){dataMap.put(property,new Array())}
			
			var addObj = new Object();
			addObj['x']=transDate(obj['date']).getTime();
			if(isNaN(obj[property]))
			addObj['y']= obj[property];
			else
			addObj['y']= Number(obj[property]);
				
			dataMap.get(property).push(addObj);
	    }	
	}
	return dataMap;
}



function settingTimeLine(){
	var from=$('#from-date').datetimepicker({
		format: "yyyy:mm:dd hh:ii",
        weekStart: 1,
        todayBtn:  1,
		autoclose: 1,
		todayHighlight: 1,
		startView: 2,
		forceParse: 0,
        showMeridian: 0,
        minuteStep: 1
//         pickerPosition: "bottom-"
    });
	var to=$('#to-date').datetimepicker({
		format: "yyyy:mm:dd hh:ii",
        weekStart: 1,
        todayBtn:  1,
		autoclose: 1,
		todayHighlight: 1,
		startView: 2,
		forceParse: 0,
        showMeridian: 0,
        minuteStep: 1,
        pickerPosition: "bottom-left"
    });
	
	from.on('changeDate', function(ev){
		FROM_DATE = ev.date;
		FROM_DATE.setSeconds(0);
		FROM_DATE.setMilliseconds(0);
		FROM_DATE.setHours(FROM_DATE.getHours() + FROM_DATE.getTimezoneOffset()/60)
		var strDate = DateUtil.getDate("yyyy:MM:dd HH:mm",FROM_DATE);
		$(this).text(strDate);
// 		console.log(FROM_DATE + "   "+strDate);
		changeDate(FROM_DATE, TO_DATE);
	});
	to.on('changeDate', function(ev){
		TO_DATE = ev.date;
		TO_DATE.setSeconds(0);
		TO_DATE.setMilliseconds(0);
		TO_DATE.setHours(TO_DATE.getHours() + TO_DATE.getTimezoneOffset()/60)
		var strDate = DateUtil.getDate("yyyy:MM:dd HH:mm",TO_DATE);
		$(this).text(strDate);
// 		console.log(to_date + "   "+strDate);
		changeDate(FROM_DATE, TO_DATE);
	});
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
		var save_id = "save-"+id;
		var scope_id = "scope-"+id;
		var body_id = "body-"+id;
		var h="";
		h+='<div id="'+container_id+'" class="panel panel-default" style="margin-bottom:10px;">';
		h+='	<div class="panel-heading" style="padding:3px;">';
		h+='	<h3 class="panel-title">';
		h+='				<div class="input-group input-group-sm" >';
		h+='		  			<span class="input-group-addon"  id="sizing-addon3"><span class="fa '+logmeta.get(data['type']).ICON+' aria-hidden="true"></span></span>';
		h+='		  			<input id="'+title_id+'" readonly type="text" class="form-control" placeholder="title" aria-describedby="sizing-addon3" value="'+data['title']+'"/>';
		h+='						<span class="input-group-btn" style="padding-left:10px;">';
		h+='							<button id="'+scope_id+'" class="btn btn-default" style="border-top-left-radius:4px;border-bottom-left-radius:4px;" type="button"><span class="fa fa-arrows-h" aria-hidden="true"></span></span></button>';
		if(dataObj){//데이터있을때만 
			h+='							<button id="'+save_id+'" class="btn btn-default" style="border-top-left-radius:4px;border-bottom-left-radius:4px;" type="button"><span class="fa fa-floppy-o" aria-hidden="true"></span></span></button>';
			h+='							<button id="'+edit_id+'" class="btn btn-default" style="border-top-right-radius:4px;border-bottom-right-radius:4px;" type="button"><span class="fa fa-pencil-square-o" aria-hidden="true"></span></span></button>';
			h+='							<button id="'+toggle_id+'" class="btn btn-default" style="border-top-left-radius:4px;border-bottom-left-radius:4px;" type="button"><span class="fa fa-bars" aria-hidden="true"></span></span></button>';
			h+='							<button id="'+remove_id+'" class="btn btn-default"  type="button"><span class="fa fa-times" aria-hidden="true"></span></button>';
		}
		h+='						</span>';
		h+='				</div>';
		h+='	</h3>';
		h+='	</div>';
		h+='	<div id="'+body_id+'" class="panel-body" style="padding:0px;">';
		//h+='		<canvas id="'+graph_id+'"  style="width:100%; height:100px;"></canvas>';
		h+='	</div>';
		h+='</div>';
		
		var newLog=$(h);	
		
		

		newLog.find("#"+save_id).click(function(){
			if(data['save'])
				data['save']();
		});

		newLog.find("#"+scope_id).click(function(){
			var at = log.get(id);
			var from_date;
			var to_date;
			if(at.data && at.data.length>0){
				var atData = at.graph;
				var valArr = new Array();
				for (var i = 0; i < atData.length; i++) {
					valArr.push(atData[i].data.getDataXMin());
					valArr.push(atData[i].data.getDataXMax());
				}
				from_date = new Date(MathUtil.min(valArr));
				to_date = new Date(MathUtil.max(valArr));
			}else{
				from_date = new Date(at.min_date);
				to_date = new Date(at.max_date);
			}
			
			
			$('#from-date').datetimepicker('update', from_date);
			$('#to-date').datetimepicker('update', to_date);
			FROM_DATE = from_date;
			TO_DATE = to_date;
			var fromStr = DateUtil.getDate("yyyy:MM:dd HH:mm",from_date);
			$("#from-date").text(fromStr);
			var toStr = DateUtil.getDate("yyyy:MM:dd HH:mm",to_date);
			$("#to-date").text(toStr);
			changeDate(from_date, to_date);
			
			//data['prah']
		});
		newLog.find("#"+toggle_id).click(function(){
			newLog.find("#"+body_id).toggle();
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
		if(dataObj){ //데이터 있어야지 뿌리지.
			var chart_data 	= new Array();
			var dataMap 	= transTypeChartData(dataObj);
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
				//graph.onMouseTraking();
				//graph.onDrag();
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
					return DateUtil.getDate("yyyy:MM:dd HH:mm:ss",date); 
// 					return DateUtil.getDate("HH:mm:ss",date); 
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
			}
			
		}else{//데이터 없으면 그냥 하나 넣어라.-_- 없다는거 표시.
			var canvas = document.createElement("canvas");
			var jCanvas = $(canvas);
			jCanvas.css("width","100%");
			jCanvas.css("height","120px");
			var graph = new GraphK(canvas);
			graph.contentTitle = data.title;
			newLog.find("#"+body_id).append(jCanvas);
			graphArry.push(graph);
		}
			
		$("#"+container_id).remove();
		$("#log-container").append(newLog);
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



function changeDate(from_date, to_date){
	
	if(from_date==undefined || to_date==undefined){return;}
	
// 	console.log("changeDate f: "+  from_date + "   "+DateUtil.getDate("yyyy.MM.dd(HH:mm)",from_date));
// 	console.log("changeDate t: "+  to_date + "   "+DateUtil.getDate("yyyy.MM.dd(HH:mm)",to_date));
    var option = {
    		"min":from_date.getTime(),
    		"max":to_date.getTime(),
    		"value":0,
    		"tooltip":"always",
    		formatter: function(value) {
    			var d = new Date();
    			d.setTime(value);
//     			console.log(d);
    			return DateUtil.getDate("yyyy:MM:dd HH:mm:ss",d);
    		}
    };
    $('#slider').slider('destroy')
    $('#slider').slider(option);
    $('#slider').on('slide',function(ev){
    	var keys = log.getKeys();
    	var gpss = new Array();
    	var oldZoom = GmapUtil.getZoom(getMap());
    	for (var i = 0; i < keys.length; i++) {
    		var atData = log.get(keys[i]);
    		var rg = atData.setTime(ev.value);
    		if(rg){gpss.push(rg)}
	    	for (var z = 0; atData.graph && z < atData.graph.length; z++) {
	    		atData.graph[z].setXLine(ev.value);
	    		//console.log("key:"+keys[i]+"   "+atData.graph[z]+"   "+ev.value);
	    	}
    		
    	}
    	GmapUtil.fitBounds(getMap(),gpss);
    	if(oldZoom!=GmapUtil.getZoom(getMap()))
    	GmapUtil.setZoom(getMap(),oldZoom);
    	
    	//alert(ev);
    });
    select();
    
}




</script>
<body style="margin-top: 85px;" data-spy="scroll">
<!-- <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#alert">Windows 8 modal - Click to View</button> -->
	<!-- nav start -->
	<fluid:insertView id="page-body-nav"/>
	<!-- nav end -->
  <!-- page Start --> 
  
  <nav class="navbar-fixed-top" style="margin-top: 36px; padding: 15px; z-index: 10;">
  	<div class="row">
           <div  class="input-group date form_datetime col-xs-5 col-md-6" style="float: left;">
<!--            		<span class="input-group-addon" style="background-color:#fff;">from</span> -->
				<span class="input-group-addon" style="padding:5px;"><span class="glyphicon glyphicon-calendar"></span></span>
				<button id="from-date" class="form-control btn btn-default" style="padding:2px" type="button">fromDate</button>
           </div>
           <div  class="input-group date form_datetime col-xs-7 col-md-6" style="float: left;">
				<span class="input-group-addon" style="padding:5px;" >~<span class="glyphicon glyphicon-calendar"></span></span>
				<button id="to-date" class="form-control btn btn-default" style="padding:2px" type="button">toDate</button>
				<div class="input-group-btn">
				        <button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"><span class="fa fa-plus" aria-hidden="true"></span></button>
				        <ul id="addLog-container" class="dropdown-menu dropdown-menu-right">
<!-- 				          <li><a id="map" href="#"><span class="fa fa-map"></span> Map</a></li> -->
				          <!-- li role="separator" class="divider"></li-->
				        </ul>
				 </div>
           </div>
	</div>
  </nav> 
  
	<div id="map-container" class="container-fluid" style="display: none;">
		<div class="panel panel-default">
		  <div class="panel-body" id="googlemap" style="height:300px;" >
		    Panel content
		  </div>
		  <div class="panel-footer">
		  <button id="mygis" class="btn btn-default" style="border-radius:4px;" type="button"><span class="fa fa-map-marker" aria-hidden="true"></span></span></button>
		  </div>
		</div>
	</div>
	
	<div id="log-container" class="container-fluid" >
	</div>
	
	<div id="slider-container" class="container-fluid" >
	  <nav class="navbar-fixed-bottom" style="padding-bottom: 10px; padding-left: 60px; padding-right: 60px;">
	  	<div class="row">
	  		<div class="col-xs-12 col-md-12">
	  			<div class="slider slider-horizontal"  style="width: 100%" id="slider"></div>
	  		</div>
	  	</div>
	  </nav> 
		<!-- page END -->
		<fluid:insertView id="page-body-footer"/>
    </div> <!-- /container -->
</body>