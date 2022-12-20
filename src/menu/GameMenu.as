package menu 
{
	import flash.geom.Point;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Text;
	
	/**
	 * ...
	 * @author saint11
	 */
	public class GameMenu extends Entity 
	{
		public var title:Text = new Text("WORLD 1 - 1",0,0,{width:FP.width,align:"center",size:8});
		
		public function GameMenu() 
		{
			x = 0;
			y = 0;
		}
		
		override public function render():void 
		{
			super.render();
			title.render(FP.buffer, new Point(0, 60), new Point())
			
		}
		
	}

}