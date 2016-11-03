package com.amanitadesign
{
	import flash.events.EventDispatcher;
	import flash.external.ExtensionContext;
	import flash.system.Capabilities;

	import flash.events.Event;
	import flash.events.StatusEvent;
	import com.amanitadesign.events.RequestPermissionsResultEvent;
	import com.amanitadesign.events.AppDetailsActivityStartedEvent;
	
	public class AndroidPermissions extends EventDispatcher
	{
		
		private static var _instance:AndroidPermissions;
		private var extContext:ExtensionContext;
		
		
		public function AndroidPermissions( enforcer:SingletonEnforcer ) {
			super();
			
			extContext = ExtensionContext.createExtensionContext( "com.amanitadesign.AndroidPermissions", "" );
			
			if ( !extContext ) {
				throw new Error( "AndroidPermissions extension is not supported on this platform." );
			}
			extContext.addEventListener( StatusEvent.STATUS, onStatusHandler );
		}
		
		/** Extension is supported on Android devices. */
		public static function get isSupported() : Boolean
		{
			return Capabilities.manufacturer.indexOf("Android") != -1;
		}
		
		
		private function init():void {
			extContext.call( "init" );
			
		}

		private function onStatusHandler( event:StatusEvent ):void {
			trace("onStatusHandler: " + event)
			var e:Event;
			
			switch(event.code) {
				case RequestPermissionsResultEvent.ON_REQUEST_PERMISSIONS_RESULT:
					e = new RequestPermissionsResultEvent(event.code, event.level);
					break;
				case AppDetailsActivityStartedEvent.ON_APP_DETAILS_ACTIVITY_STARTED:
					e = new AppDetailsActivityStartedEvent(event.code);
					break;
			}
			if(e) {
				this.dispatchEvent(e);
			}
			//
			//
		}

		
		/**
		 * Cleans up the instance of the native extension. 
		 */		
		public function dispose():void { 
			extContext.dispose(); 
		}
		
		
		public static function get instance():AndroidPermissions {
			if ( !_instance ) {
				_instance = new AndroidPermissions( new SingletonEnforcer() );
				_instance.init();
			}
			return _instance;
		}
		
		
		//----------------------------------------
		//
		// Public Methods
		//
		//----------------------------------------
		
		public function checkPermission(permision:String): Boolean {
			return extContext.call("checkPermission", permision) as Boolean;
		}
		public function shouldShowRequestPermissionRationale(permision:String): Boolean {
			return extContext.call("shouldShowRequestPermissionRationale", permision) as Boolean;
		}
		public function requestPermissions(permisions:Array): Boolean {
			return extContext.call("requestPermissions", permisions) as Boolean;
		}
		public function startInstalledAppDetails(message:String, OK:String=null): Boolean {
			return extContext.call("startInstalledAppDetails", message, OK) as Boolean;
		}
		
	}
}

class SingletonEnforcer {}