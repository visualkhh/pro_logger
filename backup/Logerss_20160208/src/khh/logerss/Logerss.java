package khh.logerss;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.FileReader;
import java.io.IOException;
import java.io.OutputStream;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import android.R.id;
import android.annotation.SuppressLint;
import android.app.Activity;
import android.app.AlertDialog;
import android.content.Context;
import android.content.DialogInterface;
import android.content.Intent;
import android.os.AsyncTask;
import android.os.Bundle;
import android.os.Handler;
import android.util.Log;
import android.view.KeyEvent;
import android.webkit.GeolocationPermissions;
import android.webkit.JavascriptInterface;
import android.webkit.WebChromeClient;
import android.webkit.WebView;
import android.webkit.WebViewClient;
import android.widget.Toast;
import ch.boye.httpclientandroidlib.util.EncodingUtils;

@SuppressLint({"JavascriptInterface","SetJavaScriptEnabled"})
public class Logerss extends Activity {
	public final String TAG = "Logerss";
	private final Handler handler = new Handler();
	public static WebView webView = null;
	public static String contextUrl = "http://192.168.0.95:8080";
	
	class MyChromeClient extends WebChromeClient {
		@Override
		public void onGeolocationPermissionsShowPrompt(String origin, GeolocationPermissions.Callback callback) {
			// Should implement this function.
			final String myOrigin = origin;
			final GeolocationPermissions.Callback myCallback = callback;
			AlertDialog.Builder builder = new AlertDialog.Builder(Logerss.this);
	 
			builder.setTitle("Request message");
			builder.setMessage("Allow current location?");
			builder.setPositiveButton("Allow", new DialogInterface.OnClickListener() {
				public void onClick(DialogInterface dialog, int id) {
					myCallback.invoke(myOrigin, true, false);
				}
			});
	
			builder.setNegativeButton("Decline", new DialogInterface.OnClickListener() {
				public void onClick(DialogInterface dialog, int id) {
					myCallback.invoke(myOrigin, false, false);
				}
			});
	
			AlertDialog alert = builder.create();
			alert.show();
		}
	}
	
	public class JavaScriptInterface {
		Context mContext;
		JavaScriptInterface(Context c) {
			mContext = c;
		}
		@JavascriptInterface
		public void showToast(String webMessage) {
			final String msgeToast = webMessage;
				handler.post(new Runnable() {
					@Override
					public void run() {
						// This gets executed on the UI thread so it can safely
						// modify Views
						// myTextView.setText(msgeToast);
					}
				});
				Log.d(TAG, webMessage);
				Toast.makeText(mContext, webMessage, Toast.LENGTH_SHORT).show();
		}
		
		@JavascriptInterface
		public void login(String id, String pwd, String user_seq) throws IOException {
				//Toast.makeText(mContext, id+"/"+pwd, Toast.LENGTH_SHORT).show();
				File file = new File(mContext.getFilesDir(), "acount");
				writeFile(file, id+"\t"+pwd+"\t"+user_seq);
				
				Intent i = new Intent(getApplicationContext(),LogerService.class);
				i.putExtra("command", "start");
				startService(i);
		}
		
		@JavascriptInterface
		public void changeSw(String seq,String id) throws IOException { //seq,seq,seq // id,id,id
				//Toast.makeText(mContext, id+"/"+pwd, Toast.LENGTH_SHORT).show();
				Log.d(TAG,seq);
				Log.d(TAG,id);
				File file = new File(mContext.getFilesDir(), "sesnsor_seq");
				writeFile(file, seq);
				file = new File(mContext.getFilesDir(), "sesnsor_id");
				writeFile(file, id);
				Toast.makeText(mContext, "Start Loging~", Toast.LENGTH_SHORT).show();
				
		}
		
	}
	private class WebViewClientClass extends WebViewClient {
		Context mContext;
		public WebViewClientClass(Context c) {
			mContext = c;
		}
		public WebViewClientClass() {
		}
		public boolean shouldOverrideUrlLoading(WebView view, String url) {
			view.loadUrl(url);
			return true;
		}
	   public void onPageFinished(WebView view, String url) {
		   String pattern = "\\/view\\/(.*)";
		   Pattern r = Pattern.compile(pattern);
		   Matcher m = r.matcher(url);
		   if(m.find()){
			   try {
				   
				   String path = m.group();
				   Log.d(TAG, path);
				   
				   
				   
				   
				   String user_seq = "";
				   try{
					   File file = new File(mContext.getFilesDir(), "acount");
						String idpwd = readFile(file);
						String[] idpwdar = idpwd.split("\t");
						user_seq = idpwdar[2];
				   }catch(Exception e){
				   }
				   
				   
				   
				   if(path.equals("/view/signin")){
					   File file = new File(mContext.getFilesDir(), "acount");
						String idpwd = readFile(file);
						String[] idpwdar = idpwd.split("\t");
						view.loadUrl("javascript:$('#email').val('"+idpwdar[0]+"')");        
						view.loadUrl("javascript:$('#password').val('"+idpwdar[1]+"')");        
						view.loadUrl("javascript:submit()");        
						
						
				   }else if(path.equals("/view/log?u="+user_seq)){
					   
					   File file = new File(mContext.getFilesDir(), "sesnsor_id");//seq,seq,seq // id,id,id
						String seq = Logerss.readFile(file);
						String[] seqar= seq.split(",");
						for (int j = 0; j < seqar.length; j++) {
							view.loadUrl("javascript:select('"+seqar[j]+"');");      
							view.loadUrl("javascript:log.get('"+seqar[j]+"').sw=true;");      
						}
						
				   }
				   
				   
				
			   } catch (IOException e) {
				   e.printStackTrace();
			   }
		   }
			
			//writeFile(file, id+"\t"+pwd);
	    }
		
	}
	@Override
	public boolean onKeyDown(int keyCode, KeyEvent event) {
		return super.onKeyDown(keyCode, event);
	}
	
	
	@SuppressLint("JavascriptInterface")
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.activity_logerss);
		
//		String contextUrl = "https://logerss.com";
		 String url ="/view/signin";
		webView = (WebView) findViewById(R.id.webView);
		// 웹뷰에서 자바스크립트실행가능
		webView.getSettings().setJavaScriptEnabled(true);
		final JavaScriptInterface myJavaScriptInterface = new JavaScriptInterface(this);
		webView.addJavascriptInterface(myJavaScriptInterface, "Android");
		// 구글홈페이지 지정
		// WebViewClient 지정
		webView.setWebViewClient(new WebViewClientClass(this));
		webView.setWebChromeClient(new MyChromeClient());

		String postData = "divice=android"; 
		webView.postUrl(contextUrl+url, EncodingUtils.getBytes(postData, "BASE64"));
		
//		webView.postUrl(contextUrl, postData.getBytes());
//		webView.loadUrl(contextUrl);
		// String url = "/view/test";
//		url = "/view";
//		Log.d(TAG, contextUrl + url);
//		webView.loadUrl(contextUrl + url);
	}
	
	
	
	
	
	public static void writeFile(File file, String a) throws IOException{
		OutputStream out = new FileOutputStream(file, false);
		out.write(a.getBytes());
		out.flush();
		out.close();
	}
	public static String readFile(File file) throws IOException {
		BufferedReader in = new BufferedReader(new FileReader(file));
		StringBuffer returnvalue = new StringBuffer();
		String inputLine;
		int count = 0;
		while((inputLine = in.readLine()) != null){
			if(count != 0)
				returnvalue.append("\r\n"); // 
			returnvalue.append(inputLine);
			count++;
		}
		in.close();
		return returnvalue.toString();
	}
	public static String getDate() throws IOException {
		SimpleDateFormat formatter = new SimpleDateFormat ( "yyyyMMddHHmmss");
        String dTime = formatter.format (new Date() );
		return dTime;
	}
	
	
	private class ProcessFacebookTask extends AsyncTask<Void, Void, Void> {
		@Override
		protected Void doInBackground(Void... params) {
			return null;
		}
	}
	
}
