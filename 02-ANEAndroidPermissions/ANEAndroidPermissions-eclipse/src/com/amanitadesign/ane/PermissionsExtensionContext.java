package com.amanitadesign.ane;

import java.util.HashMap;
import java.util.Map;

import android.util.Log;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;


public class PermissionsExtensionContext extends FREContext
{
    public PermissionsExtensionContext()
    {
    }

    @Override
	public void dispose() {
    	if(PermissionsExtension.VERBOSE > 0) Log.i(PermissionsExtension.TAG,"Context disposed.");
	}

	@Override
	public Map<String, FREFunction> getFunctions() {
		Map<String, FREFunction> functions = new HashMap<String, FREFunction>();
		functions.put("init", new PermissionsFunctions.Init());
		functions.put("checkPermission", new PermissionsFunctions.CheckPermission());
		functions.put("requestPermissions", new PermissionsFunctions.RequestPermissions());
		functions.put("shouldShowRequestPermissionRationale", new PermissionsFunctions.ShouldShowRequestPermissionRationale());
		functions.put("startInstalledAppDetails", new PermissionsFunctions.StartInstalledAppDetailsActivity());
		
		return functions;
	}

}
