package com.amanitadesign.events
{
	import flash.events.Event;
	
	public class RequestPermissionsResultEvent extends Event
	{
		public static const ON_REQUEST_PERMISSIONS_RESULT:String = "onRequestPermissionsResult";
		private var mResults:Array;
		
		public function RequestPermissionsResultEvent(type:String, value:String="", bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			mResults = new Array();
			var values:Array = value.split(" ");
			var i:uint;
			var length:uint = values.length;
			while(i < length) {
				mResults[String(values[i++])] = (values[i++] == "1");
			}
			
			
		}
		public final function get results():Array {
			return mResults;
		}
	}
}