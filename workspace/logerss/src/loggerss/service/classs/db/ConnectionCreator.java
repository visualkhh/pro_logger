package loggerss.service.classs.db;

import java.sql.Connection;

import khh.db.connection.ConnectionCreator_I;
import khh.db.util.ConnectionUtil;
import khh.web.jsp.db.util.ConnectionWebUtil;

public class ConnectionCreator implements ConnectionCreator_I {

	@Override
	public Connection getMakeConnection() throws Exception {
		return ConnectionUtil.getConnection(ConnectionUtil.MYSQL, "localhost", ConnectionUtil.MYSQL_DAFAULT_PORT,
				"logersstest","root","javadev");
		//return ConnectionWebUtil.getConnectionByJNDI("jdbc/TestDB");
	}

}
