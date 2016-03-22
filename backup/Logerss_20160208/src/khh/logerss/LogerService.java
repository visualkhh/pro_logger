package khh.logerss;

import java.io.BufferedReader;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Locale;

import android.content.Context;
import android.app.Service;
import android.content.Intent;
import android.location.Criteria;
import android.location.Location;
import android.location.LocationListener;
import android.location.LocationManager;
import android.os.AsyncTask;
import android.os.Bundle;
import android.os.IBinder;
import android.util.Log;
import ch.boye.httpclientandroidlib.HttpEntity;
import ch.boye.httpclientandroidlib.NameValuePair;
import ch.boye.httpclientandroidlib.client.entity.UrlEncodedFormEntity;
import ch.boye.httpclientandroidlib.client.methods.CloseableHttpResponse;
import ch.boye.httpclientandroidlib.client.methods.HttpPost;
import ch.boye.httpclientandroidlib.impl.client.CloseableHttpClient;
import ch.boye.httpclientandroidlib.impl.client.HttpClients;
import ch.boye.httpclientandroidlib.message.BasicNameValuePair;


public class LogerService extends Service implements LocationListener{
	final public String  TAG = "Logerss";
    public static double latitude = 0;
    public static double longitude = 0;
    public static double altitude = 0;
    public static float speed = 0;

    ProcessLogerssTask logerssTask = null;
    
    
	public LogerService() {
	}

	@Override
	public void onCreate() {
		super.onCreate();
		Log.d(TAG, "onCreate");
		
		
        String contextstr = Context.LOCATION_SERVICE;//안드로이드 시스템으로 부터 LocationManager 서비스를 요청하여 할당
        LocationManager locationManager = (LocationManager)this.getSystemService(contextstr);
        
        boolean isGPSEnabled = locationManager.isProviderEnabled(LocationManager.GPS_PROVIDER);
        boolean isNetworkEnabled  = locationManager.isProviderEnabled(LocationManager.NETWORK_PROVIDER);
        Log.d(TAG, "isGPSEnabled="+ isGPSEnabled);
        Log.d(TAG, "isNetworkEnabled="+ isNetworkEnabled);
        
        locationManager.requestLocationUpdates(LocationManager.NETWORK_PROVIDER, 0, 0, this);
        locationManager.requestLocationUpdates(LocationManager.GPS_PROVIDER, 0, 0, this);
        
        // 수동으로 위치 구하기
        String locationProvider = LocationManager.GPS_PROVIDER;
        Location lastKnownLocation = locationManager.getLastKnownLocation(locationProvider);
        if (lastKnownLocation != null) {
        	latitude = lastKnownLocation.getLatitude();
        	longitude = lastKnownLocation.getLatitude();
        }
        
        
//        //GPS 환경설정
        Criteria criteria = new Criteria();
        criteria.setAccuracy(Criteria.ACCURACY_FINE);       // 정확도
        criteria.setPowerRequirement(Criteria.POWER_LOW);   // 전원 소비량
        criteria.setAltitudeRequired(true);                // 고도, 높이 값을 얻어 올지를 결정
        criteria.setBearingRequired(false);                 // provider 기본 정보
        criteria.setSpeedRequired(true);                   //속도
        criteria.setCostAllowed(true);                      //위치 정보를 얻어 오는데 들어가는 금전적 비용
//       
//        //상기 조건을 이용하여 알맞은 GPS선택후 위치정보를 획득
//        //manifest xml  : <uses-permission android:name="android.permission.ACCESS_FINE_LOCATION" />//로케이션 메니저의 provider 
        String provider = locationManager.getBestProvider(criteria, true);
        locationManager.requestLocationUpdates(LocationManager.GPS_PROVIDER, 1000, 1, this);//현재정보를 업데이트
	}
	
	@Override
	public int onStartCommand(Intent intent, int flags, int startId) {
		Log.d(TAG, "onStartCommand");
		
		if(null!=intent){
			String s = intent.getStringExtra("command");
			if(null!=s && "start".equals(s)){
				Log.d(TAG, "----start--");
			}
		}
		
		return super.onStartCommand(intent, flags, startId);
	}
	
	

	private class ProcessLogerssTask extends AsyncTask<Void, Void, Void> {
		private Context context;
		public ProcessLogerssTask() {
		}

		public ProcessLogerssTask(Context context){
			this.context = context;
		}
		
		@Override
		protected Void doInBackground(Void... params) {
			CloseableHttpClient httpclient = null;
			httpclient = HttpClients.createDefault();
			HttpPost httpPost = new HttpPost(Logerss.contextUrl+"/ajax/log");
			try {
				
				File file = new File(context.getFilesDir(), "acount");
				String idpwd = Logerss.readFile(file);
				String[] idpwdar = idpwd.split("\t");
				
				
				
				file = new File(context.getFilesDir(), "sesnsor_seq");//seq,seq,seq // id,id,id
				String seq = Logerss.readFile(file);
				String[] seqar= seq.split(",");
				
				file = new File(context.getFilesDir(), "sesnsor_id");//seq,seq,seq // id,id,id
				String id = Logerss.readFile(file);
				String[] idar= id.split(",");
				
				for (int i = 0; i < idar.length; i++) {
					List<NameValuePair> nvps = new ArrayList<NameValuePair>();
					nvps.add(new BasicNameValuePair("MN", "saveLogSensorGPSData"));
					nvps.add(new BasicNameValuePair("email", idpwdar[0]));
					nvps.add(new BasicNameValuePair("password", idpwdar[1]));
					nvps.add(new BasicNameValuePair("user_seq", idpwdar[2]));
					
					
					String log_seq = seqar[i];
					String log_id = idar[i];
					
					nvps.add(new BasicNameValuePair("log_seq", log_seq));
					nvps.add(new BasicNameValuePair("log_id", log_id));
					
			        
			        nvps.add(new BasicNameValuePair("log_date", Logerss.getDate()));
			        
			        nvps.add(new BasicNameValuePair("log_data_lat", String.valueOf(latitude)));
			        nvps.add(new BasicNameValuePair("log_data_lng",  String.valueOf(longitude)));
			        nvps.add(new BasicNameValuePair("log_data_altitude", String.valueOf(altitude)));
			        nvps.add(new BasicNameValuePair("log_data_speed",  String.valueOf(speed)));
			        
					httpPost.setEntity(new UrlEncodedFormEntity(nvps));
					CloseableHttpResponse response2 = httpclient.execute(httpPost);
					Log.d(TAG,response2.getStatusLine().toString());
					HttpEntity entity = response2.getEntity();
					StringBuffer r = getString(entity.getContent());
					Log.d(TAG,r.toString());
					
					
					
					
					
				}
				Log.d(TAG,"------------------");
				
			} catch (Exception e) {
				e.printStackTrace();
			}
			return null;
		}

	}
	
	
	
	
	
	
	@Override
	public void onDestroy() {
		Log.d(TAG, "onDestroy");
		super.onDestroy();
	}
	
	@Override
	public IBinder onBind(Intent intent) {
		return null;
	}

	@Override
	public void onLocationChanged(Location location) {
		latitude = location.getLatitude();
		longitude = location.getLongitude();
		altitude = location.getAltitude();
		speed = location.getSpeed();
		
		logerssTask = new ProcessLogerssTask(this);
		logerssTask.execute(null,null,null);
		
		try {
			File file = new File(this.getFilesDir(), "sesnsor_id");//seq,seq,seq // id,id,id
			String id;
			id = Logerss.readFile(file);
			String[] idar= id.split(",");
			for (int i = 0; i < idar.length; i++) {
				String data = "{\"date\":\""+Logerss.getDate()+"\",\"latlng\":\""+latitude+","+longitude+"\", \"altitude\":\""+altitude+"\", \"speed\":\""+speed+"\"}";
				String push = "log.get('"+idar[i]+"').data.push("+data+");";
				String add = "log.get('"+idar[i]+"').add()";
				Logerss.webView.loadUrl("javascript:"+push);
				Logerss.webView.loadUrl("javascript:"+add);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	
	@Override
	public void onStatusChanged(String provider, int status, Bundle extras) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void onProviderEnabled(String provider) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void onProviderDisabled(String provider) {
		// TODO Auto-generated method stub
		
	}
	
	public StringBuffer getString(InputStream i) throws IOException{
		BufferedReader rd = new BufferedReader(new InputStreamReader(i));
		StringBuffer b = new StringBuffer();
		String line=null;
		while ((line = rd.readLine()) != null) {
			b.append(line);
		}
		return b;
	}

}
