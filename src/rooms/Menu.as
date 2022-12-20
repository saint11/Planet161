package rooms 
{
	import enviroment.Background;
	import menu.GameMenu;
	import net.flashpunk.FP;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	import net.flashpunk.World;
	/**
	 * ...
	 * @author saint11
	 */
	public class Menu extends World
	{
		
		public function Menu() 
		{
			add(new Background(Assets.BG0));
			add(new GameMenu());
		}
		
		override public function update():void 
		{
			if (Input.pressed(Key.ANY)) FP.world = new Level(Assets.XML_LEVEL0);
			Global.currentLevel = 0;
			super.update();
		}
		
	}

}