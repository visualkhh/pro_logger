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

import khh.conversion.util.ConversionUtil;
import khh.db.terminal.DBTerminal;
import khh.db.terminal.resultset.DBTResultRecord;
import khh.db.terminal.resultset.DBTResultSetContainer;
import khh.db.util.DBUtil;
import khh.debug.LogK;
import khh.encryption.base64.Base64;
import khh.file.util.FileUtil;
import khh.image.ImageUtil;
import khh.std.adapter.AdapterMap;
import khh.web.jsp.framework.compact.db.DBTerminalResovler;
import khh.web.jsp.framework.validate.rolek.Join;
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
		try {
			DBTerminal db = dbResovler.getDBTerminal();
			HashMap<String, Object> param = new HashMap<>();
			String key="name";
			String name = request.getParameter(key);
			param.put(key, name);
			
			key="email";
			String email = request.getParameter(key);
			param.put(key, email);
			
			key="password";
			param.put(key, request.getParameter(key));
			
			DBTResultSetContainer r = db.executeMapQuery("is_user", param);
			if(r.size()<=0){
				int c = db.executeMapUpdate("insert_user", param);
				DBTResultSetContainer ur = db.executeMapQuery("select_user_find", param);
				if(ur.size()>=0){
					for(int i = 0 ; i < ur.size(); i++){
						DBTResultRecord urow = ur.get(i);
						request.setAttribute("STATUS_CODE", INFO.STATUS_CODE_SUCCESS); 
						String userFolder = request.getSession().getServletContext().getRealPath("/WEB-INF/users/"+urow.getString("USER_SEQ"));
						log.debug("sign up user folder realpath:"+userFolder);
						FileUtil.mkdirs(userFolder);
						int width = 30;
						int height = 30;
						int type = BufferedImage.TYPE_INT_ARGB;
				        BufferedImage thum = ImageUtil.getRandomImage(width, height, type);
				        Graphics2D g = thum.createGraphics(); // 가상이미지에 씀 
				        g.setColor(ImageUtil.getRandomColor()); 
				        g.setFont(new Font( "SansSerif", Font.BOLD, 48 ));
				        g.drawString(email.substring(0, 1), 2, 28);
				        g.setColor(ImageUtil.getRandomColor()); 
				        g.setFont(new Font( "SansSerif", Font.BOLD, 40 ));
				        g.drawString(email.substring(0, 1), 5, 25);
				        FileUtil.writeFile(new File(userFolder+"/profile.png"), thum, "png");
					}
				}else{
					request.setAttribute("STATUS_CODE", INFO.STATUS_CODE_FAIL);
					request.setAttribute("STATUS_MSG", "No SignUp");
				}
			}else{
				request.setAttribute("STATUS_CODE", INFO.STATUS_CODE_FAIL);
				request.setAttribute("STATUS_MSG", "Your email has been duplicated");
			}
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
			HashMap<String, Object> param = new HashMap<>();
			String key="password";
			param.put(key, request.getParameter(key));
			key="email";
			param.put(key, request.getParameter(key));
			DBTResultSetContainer dc = db.executeMapQuery("select_user_find",param);
			for (int i = 0; i < dc.size(); i++) {
	    		 DBTResultRecord row = dc.get(i);
	    		 role.put("USER_SEQ", 			row.getString("USER_SEQ"));
	    		 role.put("USER_NAME", 			row.getString("NAME"));
	    		 role.put("USER_EMAIL", 		row.getString("EMAIL"));
	    		 role.put("USER_PASSWORD", 		row.getString("PASSWORD"));
	    		 role.put("USER_ROLE_BASE_SEQ", row.getString("ROLE_BASE_SEQ"));
	    		 role.put("USER_ROLE_SEQ", 		row.getString("ROLE_SEQ"));
	    		 role.put("USER_ROLE_NAME", 	row.getString("ROLE_NAME"));
	    		 //row.getString("USER_NAME",row.get)
	    		// for (int j = 0; j < row.size(); j++) {
	    			 //role.putInfo("USER_ROLE", value);
	    		// }
			}
			if(dc.size()>0){
				ArrayList<Join> baseJoin = RoleK.getBaseJoin(role.get("USER_ROLE_NAME"));
				/*여기에 고객role로  덮어버릴건 버리고..baseRole...*/
				role.setJoinList(baseJoin);
				request.setAttribute("STATUS_CODE", INFO.STATUS_CODE_SUCCESS);
			}else{
				request.setAttribute("STATUS_CODE", INFO.STATUS_CODE_FAIL);
				request.setAttribute("STATUS_MSG", "not find User");
			}
		}catch(Exception e){
			request.setAttribute("STATUS_CODE", INFO.STATUS_CODE_FAIL);
			request.setAttribute("STATUS_MSG", e.getMessage());
		}
	}
	
	
	
	
	
	
	
	
	public void profile(HttpServletRequest request, HttpServletResponse response){
		log.debug("profile "+request+"    "+response);
		try {
			HashMap<String, Object> param = new HashMap<>();
			String key="base64";
			String base64 = request.getParameter(key);
			base64 = base64.split(",")[1];
			base64=base64.replaceAll("-", "+").replaceAll("_", "/");
			Role role = (Role) request.getSession().getAttribute(RoleK.PARAM_NAME_SESSION);
			
			byte[] b = Base64.decode(base64);
			String userFolder = request.getSession().getServletContext().getRealPath("/WEB-INF/users/"+role.get("USER_SEQ")+"/profile.png");
			FileUtil.writeFile(userFolder, b);
	        request.setAttribute("STATUS_CODE", INFO.STATUS_CODE_SUCCESS); 
		} catch (Exception e) {
			request.setAttribute("STATUS_CODE", INFO.STATUS_CODE_FAIL);
			request.setAttribute("STATUS_MSG", e.getMessage());
		}
	}
	
	public void modify(HttpServletRequest request, HttpServletResponse response){
		log.debug("modify "+request+"    "+response);
		response.setHeader("Access-Control-Allow-Origin", "*");
		response.setHeader("Access-Control-Allow-Headers", "X-Requested-With");
		try {
			DBTerminal db = dbResovler.getDBTerminal();
			HashMap<String, Object> param = new HashMap<>();
			String key="name";
			String name = request.getParameter(key);
			param.put(key, name);
			
			key="email";
			String email = request.getParameter(key);
			param.put(key, email);
			 
			key="password";
			param.put(key, request.getParameter(key));
			key="new_password";
			param.put(key, request.getParameter(key));
			int i = db.executeMapUpdate("update_user", param);
			if(i>0){
				request.setAttribute("STATUS_CODE", INFO.STATUS_CODE_SUCCESS); 
			}else{
				request.setAttribute("STATUS_CODE", INFO.STATUS_CODE_FAIL);
				request.setAttribute("STATUS_MSG", "no insert");
			}
		} catch (Exception e) {
			request.setAttribute("STATUS_CODE", INFO.STATUS_CODE_FAIL);
			request.setAttribute("STATUS_MSG", e.getMessage());
		}
	}
	
	
	
	
}
