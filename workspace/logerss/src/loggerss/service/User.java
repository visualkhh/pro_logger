package loggerss.service;

import java.awt.Font;
import java.awt.Graphics2D;
import java.awt.image.BufferedImage;
import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.LinkedHashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import khh.db.terminal.DBTerminal;
import khh.db.terminal.resultset.DBTResultRecord;
import khh.db.terminal.resultset.DBTResultSetContainer;
import khh.db.util.DBUtil;
import khh.debug.LogK;
import khh.file.util.FileUtil;
import khh.image.ImageUtil;
import khh.std.adapter.AdapterMap;
import khh.web.jsp.framework.compact.db.DBTerminalResovler;
import khh.web.jsp.framework.validate.rolek.Join;
import khh.web.jsp.framework.validate.rolek.Role;
import khh.web.jsp.framework.validate.rolek.RoleK;
import loggerss.INFO;

public class User {
	LogK log = LogK.getInstance();
	DBTerminalResovler dbResovler = null;
	public User(DBTerminalResovler dbResovler) {
		this.dbResovler=dbResovler;
	}
	
	public void getUser(HttpServletRequest request, HttpServletResponse response){
		log.debug("sign select "+request+"    "+response);
		try{
			DBTerminal db = dbResovler.getDBTerminal();
			HashMap<String, Object> param = new HashMap<>();
			String key="u";
			param.put("user_seq", request.getParameter(key));
			DBTResultSetContainer dc = db.executeMapQuery("user_by_seq",param);
			request.setAttribute("RESULT_ISCDATA", new Boolean(false));
			request.setAttribute("RESULT", DBUtil.getXMLTagString(dc));
			request.setAttribute("STATUS_CODE", INFO.STATUS_CODE_SUCCESS);
		}catch(Exception e){
			request.setAttribute("STATUS_CODE", INFO.STATUS_CODE_FAIL);
			request.setAttribute("STATUS_MSG", e.getMessage());
		}
	}
	
	
	
	
}
