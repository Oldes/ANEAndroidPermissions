package
{
	import flash.desktop.NativeApplication;
	import flash.events.Event;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.text.TextFormat;
	import flash.ui.Multitouch;
	import flash.ui.MultitouchInputMode;
	
	import flash.text.TextField;
	
	import com.amanitadesign.AndroidPermissions;
	import com.amanitadesign.events.RequestPermissionsResultEvent;
	import com.amanitadesign.events.AppDetailsActivityStartedEvent;
	/**
	 * ...
	 * @author Oldes
	 */
	public class Main extends Sprite 
	{
		
		public var tf:TextField;
		
		public function Main() 
		{
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			stage.addEventListener(Event.DEACTIVATE, deactivate);
			
			// touch or gesture?
			Multitouch.inputMode = MultitouchInputMode.TOUCH_POINT;
			
			tf = new TextField();
			tf.width = stage.stageWidth;
			tf.height = stage.stageHeight;
			tf.defaultTextFormat = new TextFormat(null, 24);
			addChild(tf);
			
			log("Testing Amanita Android ANE...");
			log("AndroidPermissions is supported: " + AndroidPermissions.isSupported);
			
			//Permissions test example:
			AndroidPermissions.instance.addEventListener(RequestPermissionsResultEvent.ON_REQUEST_PERMISSIONS_RESULT, onRequestPermissionsResult);
			log("PERMISION WRITE: " + AndroidPermissions.instance.checkPermission("android.permission.READ_EXTERNAL_STORAGE"));
			requestForPermissions();
			
		}
		
		private function requestForPermissions():void {
			/** NOTE: you must have the rights in the request specified in application manifest as it was required for SDK < 23, else it would not work! **/
			log("Requesting for permissions: "
				+ AndroidPermissions.instance.requestPermissions(
					//["android.permission.READ_EXTERNAL_STORAGE", "android.permission.RECEIVE_SMS"]
					["android.permission.READ_EXTERNAL_STORAGE"]
				)
			);
		}
		
		private function onAppDetailsActivityStarted( event:AppDetailsActivityStartedEvent):void {
			log("onAppDetailsActivityStarted");
			NativeApplication.nativeApplication.exit();
		}
		
		private function onRequestPermissionsResult( event:RequestPermissionsResultEvent ):void {
			log("Request Permissions Result:");
			var results:Array = event.results;
			var canWrite:Boolean, shouldShowRationale:Boolean;
			if(results) {
				for (var key:String in results) {
					log("\t" + key + " " + results[key]);
				}
				log("PERMISION READ (using result): " + results["android.permission.READ_EXTERNAL_STORAGE"]);
			}
			canWrite = AndroidPermissions.instance.checkPermission("android.permission.READ_EXTERNAL_STORAGE");
			log("PERMISION READ (using check) : " + canWrite);
			if (!canWrite) {
				shouldShowRationale = AndroidPermissions.instance.shouldShowRequestPermissionRationale("android.permission.READ_EXTERNAL_STORAGE");
				log("shouldShowRequestPermissionRationale for STORAGE: " + shouldShowRationale);
				if (shouldShowRationale) {
					requestForPermissions();
				} else {
					AndroidPermissions.instance.addEventListener(AppDetailsActivityStartedEvent.ON_APP_DETAILS_ACTIVITY_STARTED, onAppDetailsActivityStarted);
					log("startInstalledAppDetails: " + AndroidPermissions.instance.startInstalledAppDetails("Please grant \"Storage\" permission to run this application."));
				}
			}
		}
		
		private function log(value:String):void {
			trace(value);
			tf.appendText(value+"\n");
			tf.scrollV = tf.maxScrollV;
		}
		
		private function deactivate(e:Event):void 
		{
			// make sure the app behaves well (or exits) when in background
			//NativeApplication.nativeApplication.exit();
		}
		
	}
	
}