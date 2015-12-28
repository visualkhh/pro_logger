package loggerss.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import khh.db.terminal.DBTerminal;
import khh.db.terminal.resultset.DBTResultRecord;
import khh.db.terminal.resultset.DBTResultSetContainer;
import khh.db.util.DBUtil;
import khh.debug.LogK;
import khh.web.jsp.framework.compact.db.DBTerminalResovler;
import loggerss.INFO;

public class Info {
	DBTerminalResovler dbResovler = null;
	LogK log = LogK.getInstance();
	public Info(DBTerminalResovler dbResovler) {
		this.dbResovler=dbResovler;
	}
	
	public void main(HttpServletRequest request, HttpServletResponse response){
		log.debug("Info main   "+request+" "+response);
		try{
			DBTerminal db = dbResovler.getDBTerminal();
			DBTResultSetContainer dc = db.executeMapQuery("select_notice");
			request.setAttribute("RESULT_ISCDATA", new Boolean(false));
			request.setAttribute("RESULT", DBUtil.getXMLTagString(dc));
			request.setAttribute("STATUS_CODE", INFO.STATUS_CODE_SUCCESS);
		}catch(Exception e){
			request.setAttribute("STATUS_CODE", INFO.STATUS_CODE_FAIL);
			request.setAttribute("STATUS_MSG", e.getMessage());
		}
	}
	
}
