package actors 
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Spritemap;
	/**
	 * ...
	 * @author saint11
	 */
	public class Box extends Actor 
	{
		public var hp:int = 0;
		private var adjusting:Boolean = false;
		public function Box(x:int,y:int) 
		{
			type = "box"
			super(x, y);
			
			graphic = sprite = new Spritemap(Assets.SPR_BOX, 16, 16);

			sprite.originX = sprite.width / 2;
			sprite.originY = sprite.height / 2;
			sprite.x = -sprite.originX;
			sprite.y = -sprite.originY;
			sprite.smooth = true;
			
			setHitbox(sprite.width, sprite.height, 16, 16);
			
			layer = 5;
			
			COLIDE_ON = ["solid", "box", "player","glossy"];
			SQUISHY_RATE = 0.2;
			GRAVITY = 0.3;
			WALK_ACCEL = 1
			collideOn = COLIDE_ON;
		}
		
		override public function update():void 
		{
			adjusting = false;
			super.update();
			if (x % 16 != 0 && onSolid)
			{
				//for (var i:int = x; i > 0; i-= 16);
				//trace (i.toString());
				if (side > 0) {
					adjusting = true;
					moveBy(1, 1, collideOn, true);
				}
				else {
					adjusting = true;
					moveBy(-1, 1, collideOn, true);
				}
				adjusting = false;
			}
			
		}
		override public function moveCollideX(e:Entity):Boolean 
		{
			if (adjusting) side = -side;
			return super.moveCollideX(e);
		}
	}

}