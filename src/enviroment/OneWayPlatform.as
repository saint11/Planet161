package enviroment 
{
	import actors.Actor;
	import net.flashpunk.Entity;
	import net.flashpunk.Graphic;
	import net.flashpunk.graphics.Image;
	
	/**
	 * ...
	 * @author saint11
	 */
	public class OneWayPlatform extends Entity 
	{
		protected var myImage:Graphic
		protected var player:Actor;
		
		public function OneWayPlatform(x:int,y:int,player:Actor) 
		{
			this.x = x;
			this.y = y;
			this.player = player;
			type = "none";
			
			setHitbox(16, 1, 0, 0);
			layer = 10;
			
			graphic = myImage = new Image(Assets.ONE_WAY);
		}
		
		override public function update():void 
		{
			if (player.y - 3 <= y && player.ySpeed>=0) {
				type = "platform";
			}
			else type = "none";
			super.update();
		}
		
	}

}