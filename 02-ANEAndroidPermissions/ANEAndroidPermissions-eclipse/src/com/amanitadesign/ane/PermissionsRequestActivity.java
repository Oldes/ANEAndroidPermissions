/*
 * 
 * This code was partially stolen from Wadedwalker as is explained here:
 * https://forums.adobe.com/message/9088185#9088185
 * 
 */

package com.amanitadesign.ane;

import android.annotation.TargetApi;
import android.app.Activity;
import android.content.pm.PackageManager;
import android.os.Bundle;
import android.util.Log;

@TargetApi(23)
final public class PermissionsRequestActivity extends Activity {  
  
	
	@Override  
	final protected void onCreate(Bundle savedInstanceState) {  
		super.onCreate(savedInstanceState);  
		this.requestPermissions(getIntent().getExtras().getStringArray("permissions"), android.os.Process.myUid());
	}

	@Override  
	final public void onRequestPermissionsResult(int requestCode, String[] permissions, int[] grantResults) {  
		super.onRequestPermissionsResult(requestCode, permissions, grantResults);  

		String results = "";  

		int i = permissions.length;
		while(i-->0) {
			results += permissions[i] + " " + ((grantResults[i] == PackageManager.PERMISSION_GRANTED)? "1":"0") + " ";  
		}
		if(results.length() > 0) results = results.substring(0, results.length()-1);
		
		if(PermissionsExtension.VERBOSE > 1) Log.d(PermissionsExtension.TAG, "onRequestPermissionsResult: "+ results+";");

		finish();  
		this.overridePendingTransition(0,0);  
		PermissionsExtension.extensionContext.dispatchStatusEventAsync("onRequestPermissionsResult", results);
	}
}  