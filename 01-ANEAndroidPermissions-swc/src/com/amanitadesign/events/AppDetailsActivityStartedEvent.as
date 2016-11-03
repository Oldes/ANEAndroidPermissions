package com.amanitadesign.events
{
	import flash.events.Event;
	
	public class AppDetailsActivityStartedEvent extends Event
	{
		public static const ON_APP_DETAILS_ACTIVITY_STARTED:String = "onAppDetailsActivityStarted";
		
		public function AppDetailsActivityStartedEvent(type:String, value:String="", bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}