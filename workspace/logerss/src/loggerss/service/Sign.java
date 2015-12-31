package loggerss.service;

import java.util.LinkedHashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import khh.db.terminal.DBTerminal;
import khh.db.terminal.resultset.DBTResultRecord;
import khh.db.terminal.resultset.DBTResultSetContainer;
import khh.db.util.DBUtil;
import khh.debug.LogK;
import khh.std.adapter.AdapterMap;
import khh.web.jsp.framework.compact.db.DBTerminalResovler;
import khh.web.jsp.framework.validate.rolek.Role;
import khh.web.jsp.framework.validate.rolek.RoleK;
import loggerss.INFO;

public class Sign {
	LogK log = LogK.getInstance();
	DBTerminalResovler dbResovler = null;
	public Sign(DBTerminalResovler dbResovler) {
		this.dbResovler=dbResovler;
	}
	public void out(HttpServletRequest request, HttpServletResponse response){
		log.debug("signout "+request+"    "+response);
		try {
			request.getSession().invalidate();
			request.setAttribute("STATUS_CODE", INFO.STATUS_CODE_SUCCESS);
			log.debug("logout!!");
		} catch (Exception e) {
			request.setAttribute("STATUS_CODE", INFO.STATUS_CODE_FAIL);
			request.setAttribute("STATUS_MSG", e.getMessage());
		}
	}
	public void up(HttpServletRequest request, HttpServletResponse response){
		log.debug("signup "+request+"    "+response);
		DBTerminal db = dbResovler.getDBTerminal();
		try {
			AdapterMap<String, Object> param = new AdapterMap<>();
			String key="name";
			param.add(key, request.getParameter(key));
			key="email";
			param.add(key, request.getParameter(key));
			key="password";
			param.add(key, request.getParameter(key));
			db.executeMapUpdate("insert_user", param);
			request.setAttribute("STATUS_CODE", INFO.STATUS_CODE_SUCCESS);
		} catch (Exception e) {
			request.setAttribute("STATUS_CODE", INFO.STATUS_CODE_FAIL);
			request.setAttribute("STATUS_MSG", e.getMessage());
		}
	}
	public void in(HttpServletRequest request, HttpServletResponse response){
		log.debug("signin "+request+"    "+response);
		Role role = (Role) request.getSession().getAttribute(RoleK.PARAM_NAME_SESSION);
		try{
			DBTerminal db = dbResovler.getDBTerminal();
			AdapterMap<String, Object> param = new AdapterMap<>();
			String key="password";
			param.add(key, request.getParameter(key));
			key="email";
			param.add(key, request.getParameter(key));
			DBTResultSetContainer dc = db.executeMapQuery("select_user_find",param);
			for (int i = 0; i < dc.size(); i++) {
	    		 DBTResultRecord row = dc.get(i);
	    		 role.putSession("USER_NAME", 			row.getString("NAME"));
	    		 role.putSession("USER_EMAIL", 		row.getString("EMAIL"));
	    		 role.putSession("USER_PASSWORD", 		row.getString("PASSWORD"));
	    		 role.putSession("USER_ROLE_BASE_SEQ", row.getString("ROLE_BASE_SEQ"));
	    		 role.putSession("USER_ROLE_SEQ", 		row.getString("ROLE_SEQ"));
	    		 role.putSession("USER_ROLE_NAME", 	row.getString("ROLE_NAME"));
	    		 //row.getString("USER_NAME",row.get)
	    		// for (int j = 0; j < row.size(); j++) {
	    			 //role.putInfo("USER_ROLE", value);
	    		// }
			}
			if(dc.size()>0){
				LinkedHashMap<String, LinkedHashMap<String, String>> baseRole = RoleK.getBaseRole(role.getSession("USER_ROLE_NAME"));
				/*여기에 고객role로  덮어버릴건 버리고..baseRole...*/
				role.setRoleList(baseRole);
				request.setAttribute("STATUS_CODE", INFO.STATUS_CODE_SUCCESS);
			}else{
				request.setAttribute("STATUS_CODE", INFO.STATUS_CODE_FAIL);
				request.setAttribute("STATUS_MSG", "not find User");
			}
			//request.setAttribute("RESULT_ISCDATA", new Boolean(false));
			//request.setAttribute("RESULT", DBUtil.getXMLTagString(dc));
		}catch(Exception e){
			request.setAttribute("STATUS_CODE", INFO.STATUS_CODE_FAIL);
			request.setAttribute("STATUS_MSG", e.getMessage());
		}
	}
	
}
