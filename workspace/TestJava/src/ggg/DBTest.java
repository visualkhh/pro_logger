package ggg;

import java.sql.Connection;

import khh.db.connection.ConnectionCreator_I;
import khh.db.terminal.DBTerminal;
import khh.db.terminal.resultset.DBTResultRecord;
import khh.db.terminal.resultset.DBTResultSetContainer;
import khh.db.util.ConnectionUtil;
import khh.debug.LogK;

public class DBTest extends Thread{
	LogK log = LogK.getInstance();
	
	public static DBTerminal db = new DBTerminal(new ConnectionCreator_I() {
		@Override
		public Connection getMakeConnection() throws Exception {
			return ConnectionUtil.getConnection(ConnectionUtil.MYSQL, "localhost", ConnectionUtil.MYSQL_DAFAULT_PORT,
					"logersstest","root","javadev");
		}
	});
	static{
	db.addConfigfile("Z:\\me\\project\\personal\\web\\logger\\workspace\\logerss\\WebContent\\WEB-INF\\config\\dbterminal_config.xml");
	}
	
	
	public DBTest() {
	}
	
	
	public void run() {
		for (int z = 0; z < 10000; z++) {
			DBTResultSetContainer g;
			try {
				g = db.executeMapQuery("test");
				String a = "";
				for (int i = 0; i < g.size(); i++) {
					DBTResultRecord r = g.get(i);
					System.out.println("--> "+r.getString("A"));
					a+="_"+r.getString("A");
					//System.out.println(r.getString(0));
				}
				System.out.println(a);
				Thread.sleep(100);
			
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
	}
	
	
	public static void main(String[] args) throws Exception {

		
		DBTest d = new  DBTest();
		d.start();
		Thread.sleep(5000);
		new  DBTest().start();
		Thread.sleep(5000);
		new  DBTest().start();
		
		
	}
}
