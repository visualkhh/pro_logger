package loggerss.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import khh.db.terminal.DBTerminal;
import khh.db.terminal.resultset.DBTResultSetContainer;
import khh.db.util.DBUtil;
import khh.debug.LogK;
import khh.std.adapter.AdapterMap;
import khh.web.jsp.framework.compact.db.DBTerminalResovler;
import loggerss.INFO;

public class Gis {
	DBTerminalResovler dbResovler = null;
	LogK log = LogK.getInstance();
	public Gis(DBTerminalResovler dbResovler) {
		this.dbResovler=dbResovler;
	}
	
	public void save(HttpServletRequest request, HttpServletResponse response){
		log.debug("Gis save   "+request+" "+response);
		DBTerminal db = dbResovler.getDBTerminal();
		try {
			AdapterMap<String, Object> param = new AdapterMap<>();
			String key="lat";
			param.add(key, request.getParameter(key));
			key="lng";
			param.add(key, request.getParameter(key));
			db.executeMapUpdate("insert_gis", param);
			request.setAttribute("STATUS_CODE", INFO.STATUS_CODE_SUCCESS);
		} catch (Exception e) {
			request.setAttribute("STATUS_CODE", INFO.STATUS_CODE_FAIL);
			request.setAttribute("STATUS_MSG", e.getMessage());
		}
	}
}
