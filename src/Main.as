package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import net.flashpunk.Engine;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Text;
	import flash.system.Security;
	import rooms.Level;
	import rooms.Menu;
	import utils.initConfig;

	/**
	 * ...
	 * @author saint11
	 */
	public class Main extends Engine
	{		
		public function Main():void 
		{
			super(240, 160, 60, false);	
			FP.screen.color = 0x000000;
			FP.screen.scale = 2;
			
			Text.size = 8;
			
			addEventListener(Event.ACTIVATE, onActivate);
			addEventListener(Event.DEACTIVATE, onDeactivate);
			Security.allowDomain("studiominiboss.com");
			
			FP.world = new Menu();
			
			initConfig.initialize();
		}
		
		public function onActivate(e:Event = null):void
		{
			// When the game gains focus.
		}
		
		public function onDeactivate(e:Event = null):void
		{
			// When the game loses focus.
		}
	}

}