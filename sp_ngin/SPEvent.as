package sp_ngin
{
	import flash.events.Event;

	public class SPEvent extends Event
	{
		public static const LOAD_DONE:String = "load_done";
		public static const MODEL_INIT_DONE:String = "model_init_done";
		public function SPEvent(_e:String)
		{
			super(_e);
		}
	}
}