package bullets 
{
	import actors.Player;
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	
	/**
	 * ...
	 * @author saint11
	 */
	public class Chain extends Entity 
	{
		public var timer:Number = 1;
		private var rate:Number = 0.02;
		
		private var sprite:Image;
		
		public function Chain(x:int,y:int)  
		{
			type = "chain";
			this.x = x;
			this.y = y;
			
			setHitbox(8, 8, 0, 0);
			graphic = sprite = new Image(Assets.SPR_DOTS)
		}
		override public function update():void 
		{
			timer -= rate;
			sprite.alpha = timer;
			
			if (timer < 0) world.remove(this);
			
			var player:Player = collide("player", x, y) as Player
			if (player) {
				world.remove(this);
			}
			
			super.update();
		}
		
	}

}