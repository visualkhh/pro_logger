package loggerss.service;

import java.io.StringReader;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;

import khh.date.util.DateUtil;
import khh.db.terminal.DBTerminal;
import khh.db.terminal.resultset.DBTResultRecord;
import khh.db.terminal.resultset.DBTResultSetContainer;
import khh.db.util.DBUtil;
import khh.debug.LogK;
import khh.web.jsp.framework.compact.db.DBTerminalResovler;
import khh.web.jsp.framework.validate.rolek.Role;
import khh.web.jsp.framework.validate.rolek.RoleK;
import loggerss.INFO;

public class Log {
	LogK log = LogK.getInstance();
	DBTerminalResovler dbResovler = null;
	public Log(DBTerminalResovler dbResovler) {
		this.dbResovler=dbResovler;
	}
	public void getLogType(HttpServletRequest request, HttpServletResponse response){
		log.debug("getLogType "+request+"    "+response);
		//LOG_SEQ, TYPE, ICON, EXECUTEFNC
		try {
			DBTerminal db = dbResovler.getDBTerminal();
			DBTResultSetContainer dc = db.executeMapQuery("select_logtype");
			request.setAttribute("RESULT_ISCDATA", new Boolean(false));
			request.setAttribute("RESULT", DBUtil.getXMLTagString(dc));
			request.setAttribute("STATUS_CODE", INFO.STATUS_CODE_SUCCESS);
		} catch (Exception e) {
			request.setAttribute("STATUS_CODE", INFO.STATUS_CODE_FAIL);
			request.setAttribute("STATUS_MSG", e.getMessage());
		}
	}
	
	
	
	public void selectLog(HttpServletRequest request, HttpServletResponse response){
		log.debug("getLog"+request+"    "+response);
		//SELECT  LOG_SEQ, LOG_ID, TITLE, DATA, INSERT_DATE FROM LO_LOG 
		try { 
			DBTerminal db = dbResovler.getDBTerminal();
			Role role = (Role)request.getSession().getAttribute(RoleK.PARAM_NAME_SESSION);
			HashMap<String, Object> param = new HashMap<>();
			String key="user_seq";
			DBTResultSetContainer dc = null;
			String u = request.getParameter("u");
			
			if(null!=u && !u.equals(role.get("USER_SEQ"))){ //파라미터가 있고 유저시퀀스가 다르면  타인것
				param.put(key, u);
				dc = db.executeMapQuery("select_other_log",param);
			}else{
				param.put(key, role.get("USER_SEQ"));
				dc = db.executeMapQuery("select_log",param);
			}
			
			
			request.setAttribute("RESULT_ISCDATA", new Boolean(false));
			request.setAttribute("RESULT", DBUtil.getXMLTagString(dc));
			request.setAttribute("STATUS_CODE", INFO.STATUS_CODE_SUCCESS);
		} catch (Exception e) {
			request.setAttribute("STATUS_CODE", INFO.STATUS_CODE_FAIL);
			request.setAttribute("STATUS_MSG", e.getMessage());
		}
	}
	
	
	public void selectLogData(HttpServletRequest request, HttpServletResponse response) throws Exception{
		log.debug("saveLogData--> "+request+"    "+response);
		DBTerminal db = dbResovler.getDBTerminal();
		try {
			JSONParser jsonParser = new JSONParser();
			
			Role role = (Role)request.getSession().getAttribute(RoleK.PARAM_NAME_SESSION);
			HashMap<String, Object> param = new HashMap<>();
			String key="log_seq";
			param.put(key, request.getParameter(key));
			
			key="log_id";
			param.put(key, request.getParameter(key));
			 
			key="from_date";
			param.put(key, null==request.getParameter(key)?"0":request.getParameter(key));
			
			key="to_date";
			param.put(key, null==request.getParameter(key)?"50001231115959":request.getParameter(key));
			
			key="user_seq";
			DBTResultSetContainer dc = null;
			String u = request.getParameter("u");
			if(null!=u && !u.equals(role.get("USER_SEQ"))){ //파라미터가 있고 유저시퀀스가 다르면  타인것
				param.put(key, u);
				dc = db.executeMapQuery("select_other_logdata",param);
			}else{
				param.put(key, role.get("USER_SEQ"));
				dc = db.executeMapQuery("select_logdata",param);
			}
			
			
			for (int i = 0; i < dc.size(); i++) {
				key="LOG_DATE";
				DBTResultRecord rcd = dc.get(i);
//				String date = DateUtil.dateFormat(new Date(rcd.getLong(key)),"yyyy:MM:dd HH:mm:ss");
				String date = String.valueOf(rcd.getLong(key));
				rcd.remove(key);
				
				
				JSONObject dataObj= (JSONObject) jsonParser.parse(new StringReader( rcd.getString("LOG_DATA")));
				key="date";
				dataObj.put(key, date);
				
				key="LOG_DATA";
				rcd.set(key, dataObj.toString());
			}
			
			request.setAttribute("RESULT_ISCDATA", new Boolean(false));
			request.setAttribute("RESULT", DBUtil.getXMLTagString(dc));
			request.setAttribute("STATUS_CODE", INFO.STATUS_CODE_SUCCESS);
			
			
		} catch (Exception e) {
			request.setAttribute("STATUS_CODE", INFO.STATUS_CODE_FAIL);
			request.setAttribute("STATUS_MSG", e.getMessage());
			
			db.rollback();
		}
	}
	
	
	
	public void searchLog(HttpServletRequest request, HttpServletResponse response) throws Exception{
		log.debug("searchLog--> "+request+"    "+response);
		DBTerminal db = dbResovler.getDBTerminal();
		try {
			
			HashMap<String, Object> param = new HashMap<>();
			String key="title";
			param.put(key, request.getParameter(key));
			
			DBTResultSetContainer dc = db.executeMapQuery("search_log",param);
			request.setAttribute("RESULT_ISCDATA", new Boolean(false));
			request.setAttribute("RESULT", DBUtil.getXMLTagString(dc));
			request.setAttribute("STATUS_CODE", INFO.STATUS_CODE_SUCCESS);
		} catch (Exception e) {
			request.setAttribute("STATUS_CODE", INFO.STATUS_CODE_FAIL);
			request.setAttribute("STATUS_MSG", e.getMessage());
		}
	}
	
	
	
	
	
	public void saveLog(HttpServletRequest request, HttpServletResponse response) throws Exception{
		log.debug("saveLog--> "+request+"    "+response);
		DBTerminal db = dbResovler.getDBTerminal();
		try {
			Role role = (Role)request.getSession().getAttribute(RoleK.PARAM_NAME_SESSION);
			HashMap<String, Object> param = new HashMap<>();
			String key="user_seq";
			param.put(key, role.get("USER_SEQ"));
			
			key="log_seq";
			param.put(key, request.getParameter(key));
			
			key="log_id";
			param.put(key, request.getParameter(key));
			
			key="title";
			param.put(key, request.getParameter(key));
			
			key="open";
			param.put(key, request.getParameter(key));
			
			key="date";
			param.put(key, DateUtil.getDate("yyyyMMddHHmmss"));			
			int logUpdateCnt = db.executeMapUpdate("insert_log", param);
			
			if(logUpdateCnt>0){
				DBTResultSetContainer dc = db.executeMapQuery("select_at_log", param);
				request.setAttribute("RESULT_ISCDATA", new Boolean(false));
				request.setAttribute("RESULT", DBUtil.getXMLTagString(dc));
				request.setAttribute("STATUS_CODE", INFO.STATUS_CODE_SUCCESS); 
			}else{
				request.setAttribute("STATUS_CODE", INFO.STATUS_CODE_FAIL);
				request.setAttribute("STATUS_MSG", "no insert");
			} 
		} catch (Exception e) {
			request.setAttribute("STATUS_CODE", INFO.STATUS_CODE_FAIL);
			request.setAttribute("STATUS_MSG", e.getMessage());
			
			db.rollback();
		}
	}
	public void saveLogData(HttpServletRequest request, HttpServletResponse response) throws Exception{
		log.debug("saveLogData--> "+request+"    "+response);
		DBTerminal db = dbResovler.getDBTerminal();
		try {
			Role role = (Role)request.getSession().getAttribute(RoleK.PARAM_NAME_SESSION);
			HashMap<String, Object> param = new HashMap<>();
			String key="user_seq";
			param.put(key, role.get("USER_SEQ"));
			
			key="log_seq";
			param.put(key, request.getParameter(key));
			
			key="log_id";
			param.put(key, request.getParameter(key));
			 
			key="title";
			param.put(key, request.getParameter(key));
			
			key="open";
			param.put(key, request.getParameter(key));
			
			key="data";
			//"[{\"date\":\"2015:05:29 19:16:00\",\"latlng\":\"37.66212036833167,127.04516300931573\", \"ele\":\"76.19999694824219\", \"atemp\":\"23.0\"},{\"date\":\"2015:05:29 19:16:24\",\"latlng\":\"37.662154817953706,127.0452713035047\", \"ele\":\"76.4000015258789\", \"atemp\":\"23.0\"}]"
			JSONParser jsonParser = new JSONParser();
			JSONArray dataArray = (JSONArray) jsonParser.parse(new StringReader( request.getParameter(key)));
			
//			String[] datasplit = ((String)request.getParameter(key)).split(",");
//			for (int i = 0; i < array.length; i++) {
//				
//			}
			
			
			key="date";
			param.put(key, DateUtil.getDate("yyyyMMddHHmmss"));			
			db.setAutoCommit(false);
			
			int logUpdateCnt = db.executeMapUpdate("insert_log", param);
			logUpdateCnt += db.executeMapUpdate("delete_logdata_all", param);
			
			/*
			 * 		INSERT INTO LO_LOG_DATA (USER_SEQ, LOG_SEQ, LOG_ID, LOG_DATA)
					VALUES (#user_seq#, #log_seq#, #log_id#, #log_data#)
			 */
			 for(int i=0; i<dataArray.size(); i++){
				 JSONObject dataObject = (JSONObject) dataArray.get(i);
//				 Date d = DateUtil.getDate("yyyy:MM:dd HH:mm:ss",(String)dataObject.get("date"));
				 long d = Long.valueOf((String)dataObject.get("date"));
				 dataObject.remove("date");
				 
				 param.put("log_date", d);
				 param.put("log_data", dataObject.toString());
				 logUpdateCnt += db.executeMapUpdate("insert_logdata", param);
			 }
			
			db.commit();
			
			
			if(logUpdateCnt>0){
				DBTResultSetContainer dc = db.executeMapQuery("select_at_log", param);
				request.setAttribute("RESULT_ISCDATA", new Boolean(false));
				request.setAttribute("RESULT", DBUtil.getXMLTagString(dc));
				request.setAttribute("STATUS_CODE", INFO.STATUS_CODE_SUCCESS); 
			}else{
				request.setAttribute("STATUS_CODE", INFO.STATUS_CODE_FAIL);
				request.setAttribute("STATUS_MSG", "no insert");
			} 
		} catch (Exception e) {
			request.setAttribute("STATUS_CODE", INFO.STATUS_CODE_FAIL);
			request.setAttribute("STATUS_MSG", e.getMessage());
			
			db.rollback();
		}
	}
	public void deleteLog(HttpServletRequest request, HttpServletResponse response){
		log.debug("deleteLog "+request+"    "+response);
		DBTerminal db = dbResovler.getDBTerminal();
		try {
			Role role = (Role)request.getSession().getAttribute(RoleK.PARAM_NAME_SESSION);
			HashMap<String, Object> param = new HashMap<>();
			String key="user_seq";
			param.put(key, role.get("USER_SEQ"));
			
			key="log_seq";
			param.put(key, request.getParameter(key));
			
			key="log_id";
			param.put(key, request.getParameter(key));
			
			int i = db.executeMapUpdate("delete_log", param);
			i += db.executeMapUpdate("delete_logdata_all", param);
			request.setAttribute("STATUS_CODE", INFO.STATUS_CODE_SUCCESS); 
		} catch (Exception e) {
			request.setAttribute("STATUS_CODE", INFO.STATUS_CODE_FAIL);
			request.setAttribute("STATUS_MSG", e.getMessage());
		}
	}
	
}
