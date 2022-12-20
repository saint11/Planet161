package utils 
{
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	/**
	 * ...
	 * @author saint11
	 */
	public class initConfig 
	{
		
		public function initConfig() 
		{

		}
		
		public static function initialize():void
		{
			Input.define("D", Key.DOWN);
			Input.define("R", Key.RIGHT);
			Input.define("L", Key.LEFT);
			Input.define("RESTART", Key.R);
			Input.define("SHOT", Key.SHIFT, Key.X, Key.S);
			Input.define("JUMP", Key.SPACE, Key.CONTROL, Key.UP, Key.Z, Key.A);
		}
	}

}