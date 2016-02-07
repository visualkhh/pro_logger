package loggerss.service;

import java.util.Calendar;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import khh.date.util.DateUtil;
import khh.db.terminal.DBTerminal;
import khh.db.terminal.resultset.DBTResultSetContainer;
import khh.db.util.DBUtil;
import khh.debug.LogK;
import khh.std.adapter.AdapterMap;
import khh.web.jsp.framework.compact.db.DBTerminalResovler;
import khh.web.jsp.request.RequestUtil;
import loggerss.INFO;

public class Gis {
	DBTerminalResovler dbResovler = null;
	LogK log = LogK.getInstance();
	public Gis(DBTerminalResovler dbResovler) {
		this.dbResovler=dbResovler;
	}
	
	public void get(HttpServletRequest request, HttpServletResponse response){
		log.debug("Gis get   "+request+" "+response);
		String lat = request.getParameter("lat");
		if(null!=lat&&lat.length()>0){
			save(request,response);
		}
		select(request,response);
	}
	 
	
	public void save(HttpServletRequest request, HttpServletResponse response){
		log.debug("Gis save   "+request+" "+response);
		try {
			DBTerminal db = dbResovler.getDBTerminal();
			HashMap<String, Object> param = new HashMap<>();
			String key="ip";
			param.put(key, RequestUtil.getRemoteAddr(request)+":"+RequestUtil.getServerPort(request));
			key="lat";
			param.put(key, request.getParameter(key));
			key="lng";
			param.put(key, request.getParameter(key));
			key="date";
			param.put(key, DateUtil.getDate("yyyyMMddHHmmss"));
			key="session";
			param.put(key, request.getSession().getId());
			db.executeMapUpdate("insert_gis", param);
			request.setAttribute("STATUS_CODE", INFO.STATUS_CODE_SUCCESS);
		} catch (Exception e) {
			request.setAttribute("STATUS_CODE", INFO.STATUS_CODE_FAIL);
			request.setAttribute("STATUS_MSG", e.getMessage());
		}
	}
	
	public void select(HttpServletRequest request, HttpServletResponse response){
		log.debug("Gis select   "+request+" "+response);
		try{
			DBTerminal db = dbResovler.getDBTerminal();
			HashMap<String, Object> param = new HashMap<>();
			String key="date";
			param.put(key, DateUtil.dateFormat(DateUtil.modifyDate(Calendar.MINUTE, -5),"yyyyMMddHHmmss"));
			 
			DBTResultSetContainer dc = db.executeMapQuery("select_gis",param);
			request.setAttribute("RESULT_ISCDATA", new Boolean(false));
			request.setAttribute("RESULT", DBUtil.getXMLTagString(dc));
			request.setAttribute("STATUS_CODE", INFO.STATUS_CODE_SUCCESS);
		}catch(Exception e){
			request.setAttribute("STATUS_CODE", INFO.STATUS_CODE_FAIL);
			request.setAttribute("STATUS_MSG", e.getMessage());
		}
	}
	
	
}
