package com.amanitadesign.ane;

import com.amanitadesign.ane.PermissionsExtensionContext;
import android.content.Context;
import android.util.Log;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREExtension;

/**
 * Created by Oldes on 9/16/2016.
 */
public class PermissionsExtension implements FREExtension {
    public static final String TAG = "AmanitaNativeExtension";
    public static final int VERBOSE = 0;

    public static PermissionsExtensionContext extensionContext;
    public static Context appContext;

    @Override
    public FREContext createContext(String contextType) {
        return extensionContext = new PermissionsExtensionContext();
    }

    @Override
    public void dispose() {
        if(VERBOSE > 0) Log.i(TAG, "Extension disposed.");

        appContext = null;
        extensionContext = null;
    }

    @Override
    public void initialize() {
    	if(VERBOSE > 0) Log.i(TAG, "Extension initialized.");
    }

}
