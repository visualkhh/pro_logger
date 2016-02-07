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

public class Api {
	LogK log = LogK.getInstance();
	DBTerminalResovler dbResovler = null;
	public Api(DBTerminalResovler dbResovler) {
		this.dbResovler=dbResovler;
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
			 
			key="data";
			//"[{\"date\":\"2015:05:29 19:16:00\",\"latlng\":\"37.66212036833167,127.04516300931573\", \"ele\":\"76.19999694824219\", \"atemp\":\"23.0\"},{\"date\":\"2015:05:29 19:16:24\",\"latlng\":\"37.662154817953706,127.0452713035047\", \"ele\":\"76.4000015258789\", \"atemp\":\"23.0\"}]"
			JSONParser jsonParser = new JSONParser();
			JSONArray dataArray = (JSONArray) jsonParser.parse(new StringReader( request.getParameter(key)));
			
			db.setAutoCommit(false);
			
			int logUpdateCnt =0;
			/*
			 * 		INSERT INTO LO_LOG_DATA (USER_SEQ, LOG_SEQ, LOG_ID, LOG_DATA)
					VALUES (#user_seq#, #log_seq#, #log_id#, #log_data#)
			 */
			 for(int i=0; i<dataArray.size(); i++){
				 JSONObject dataObject = (JSONObject) dataArray.get(i);
				 Date d = DateUtil.getDate("yyyy:MM:dd HH:mm:ss",(String)dataObject.get("date"));
				 dataObject.remove("date");
				 param.put("log_date", d.getTime());
				 param.put("log_data", dataObject.toString());
				 logUpdateCnt += db.executeMapUpdate("insert_logdata", param);
			 }
			
			db.commit();
			
			if(logUpdateCnt>0){
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
	
}
