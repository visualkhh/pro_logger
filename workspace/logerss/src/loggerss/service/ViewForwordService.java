package loggerss.service;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.sql.DataSource;


import khh.db.connection.ConnectionCreator_I;
import khh.db.terminal.DBTerminal;
import khh.db.terminal.resultset.DBTResultRecord;
import khh.db.terminal.resultset.DBTResultSetContainer;
import khh.debug.LogK;
import khh.std.Standard;
import khh.web.jsp.db.util.ConnectionWebUtil;
import khh.web.jsp.framework.compact.db.DBTerminalResovler;
import khh.web.jsp.framework.compact.view.ViewResovler;

public class ViewForwordService {
	LogK log = LogK.getInstance();
	
	DBTerminalResovler db = null;
	public ViewForwordService() {
	}
	
	public void setDB(DBTerminalResovler db){
		log.debug("setDB"+db);
		this.db = db;
	}
	
	synchronized public String doRequest(HttpServletRequest request, HttpServletResponse response) throws Exception{
	
		//t.addConfigfile(configfilepath);
		DBTResultSetContainer g = db.executeMapQuery("test");
		String a = "";
		for (int i = 0; i < g.size(); i++) {
			DBTResultRecord r = g.get(i);
			log.debug("--> "+r.getString("A"));
			a+="_"+r.getString("A");
			//System.out.println(r.getString(0));
		}
		
//		Context ic = new InitialContext(); 
//		DataSource ds = (DataSource) ic.lookup("java:comp/env/jdbc/TestDB"); 
//		Connection con = ds.getConnection();
//		Statement p  = con.createStatement();
//		ResultSet rs = p.executeQuery("SELECT A FROM TEST");
//		while(rs.next())
//		{
//		a+=" "+( rs.getString(1)+"</br>");
//		}
//		con.close();
		
		
		request.setAttribute("VAL", a);
		String viewId_param = (String)request.getParameter(ViewResovler.PARAM_VIEWID);
		log.debug("doRequest 메소드 실행 doRequest rq,rs "+request+"   "+response+"  :   "+viewId_param);
		request.setAttribute(ViewResovler.PARAM_VIEWID, viewId_param);
		return "FluidViewResovler";
	}
}
