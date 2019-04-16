package com.amanitadesign.ane;

import android.annotation.TargetApi;
import android.app.Activity;
import android.app.AlertDialog;
import android.content.Context;
import android.content.DialogInterface;
import android.content.Intent;
import android.content.pm.PackageManager;
import android.net.Uri;
import android.os.Build;
import android.provider.Settings;
import android.util.Log;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.adobe.fre.FREObject;
import com.adobe.fre.FREArray;

@TargetApi(23)
public class PermissionsFunctions {
	
	static public class Init implements FREFunction {
		@Override
		public FREObject call(FREContext context, FREObject[] args) {
			Context appContext = context.getActivity().getApplicationContext();
			PermissionsExtension.appContext = appContext;
			return null;
		}
	}
	
	static public class CheckPermission implements FREFunction {
		@Override
		final public FREObject call(FREContext context, FREObject[] args) {
			try {
				String permission = args[0].getAsString();
				if(PermissionsExtension.VERBOSE > 1) Log.d(PermissionsExtension.TAG, "Checking permission: "+ permission +" SDK: "+Build.VERSION.SDK_INT);
				if (Build.VERSION.SDK_INT > 18 && (
					permission.equals("android.permission.READ_EXTERNAL_STORAGE")
					|| permission.equals("android.permission.WRITE_EXTERNAL_STORAGE")
				)) {
					return 	FREObject.newObject(true);
				}
				int permissionCheck = context.getActivity().checkPermission(permission, android.os.Process.myPid(), android.os.Process.myUid());
				if(PermissionsExtension.VERBOSE > 0) Log.d(PermissionsExtension.TAG, "Checking permission: "+ permission+" "+ permissionCheck);
				return 	FREObject.newObject(permissionCheck == PackageManager.PERMISSION_GRANTED);
			}
			catch (Exception e) {
				return null;
			}
		}
	}

	static public class RequestPermissions implements FREFunction {
		/* This code was partially stolen from Wadedwalker as is explained here:
		 * https://forums.adobe.com/message/9088185#9088185 
		 */
		@Override
		final public FREObject call(FREContext context, FREObject[] args) {
			try {
				if (Build.VERSION.SDK_INT > Build.VERSION_CODES.LOLLIPOP_MR1) {
					Activity act = context.getActivity();
					act.overridePendingTransition(0,0);
					
					final FREArray array = (FREArray) args[0];
					final int lng = (int) array.getLength();
				    final String[] permissions = new String[(int) array.getLength()];
				    
				    for (int i = 0; i < lng; i += 1) {
				    	String permission = array.getObjectAt(i).getAsString();
				    	if(permission != null) permissions[i] = permission;
				    }
				    
				    if(PermissionsExtension.VERBOSE > 0) Log.d(PermissionsExtension.TAG, "Checking permissions: "+ permissions);
				    
					final Intent intent = new Intent(act, PermissionsRequestActivity.class);
					intent.putExtra("permissions", permissions);
					act.startActivity(intent);
					
					act.overridePendingTransition(0,0);
					
					return FREObject.newObject(true); //true means that we should wait for callback on AS3 side
				}
				else {
					return FREObject.newObject(false); //false means that we can continue without waiting for callback
				}
			}
			catch (Exception e) {
				e.printStackTrace();
				return null;
			}
		}
	}
	
	static public class ShouldShowRequestPermissionRationale implements FREFunction {
		@Override
		final public FREObject call(FREContext context, FREObject[] args) {
			try {
				if(PermissionsExtension.VERBOSE > 1) Log.d(PermissionsExtension.TAG, "ShouldShowRequestPermissionRationale");
				if (Build.VERSION.SDK_INT > Build.VERSION_CODES.LOLLIPOP_MR1) {
					return 	FREObject.newObject(
						context.getActivity().shouldShowRequestPermissionRationale(args[0].getAsString())
					);
				}
				else {
					return FREObject.newObject(false);
				}
			}
			catch (Exception e) {
				return null;
			}
		}
	}
	
	static public class StartInstalledAppDetailsActivity implements FREFunction {
		@Override
		final public FREObject call(FREContext context, FREObject[] args) {
			try {
				if(PermissionsExtension.VERBOSE > 1) Log.d(PermissionsExtension.TAG, "StartInstalledAppDetailsActivity");
				
				String message = args[0].getAsString();
				String OK = (args[1] == null) ? "OK" : args[1].getAsString();

				AlertDialog.Builder alertDialogBuilder = new AlertDialog.Builder(context.getActivity());
				alertDialogBuilder
					.setMessage(message)
					.setCancelable(false)
					.setPositiveButton(OK,new DialogInterface.OnClickListener() {
						public void onClick(DialogInterface dialog,int id) {
							// if this button is clicked, close
							// current activity
							 
							 //This code is from: http://stackoverflow.com/a/32822298/494472

							final Intent i = new Intent();
						    i.setAction(Settings.ACTION_APPLICATION_DETAILS_SETTINGS);
						    i.addCategory(Intent.CATEGORY_DEFAULT);
						    i.setData(Uri.parse("package:" + PermissionsExtension.extensionContext.getActivity().getPackageName()));
						    i.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
						  //  i.addFlags(Intent.FLAG_ACTIVITY_NO_HISTORY);
						    i.addFlags(Intent.FLAG_ACTIVITY_EXCLUDE_FROM_RECENTS);
						    PermissionsExtension.extensionContext.getActivity().startActivity(i);
						    PermissionsExtension.extensionContext.dispatchStatusEventAsync("onAppDetailsActivityStarted", "");
						}
					});
				// create alert dialog
				AlertDialog alertDialog = alertDialogBuilder.create();

				// show it
				alertDialog.show();
				
			    return FREObject.newObject(true);
			}
			catch (Exception e) {
				return null;
			}
		}
	}
	
}
