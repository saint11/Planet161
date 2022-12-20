package bullets 
{
	import actors.Box;
	import actors.Player;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.utils.Draw;
	/**	
	 * ...
	 * @author saint11
	 */
	public class PulseShot extends Bullet
	{
		private var sprite:Spritemap;
		private var side:int;
		
		public function PulseShot(x:int,y:int, side:int, myPlayer:Player)
		{
			super(side);
			this.side = side;
			this.x = int(x+4*side -12);
			this.y = int(y - 8);
			
			graphic = sprite = new Spritemap(Assets.SPR_PULSE_SHOT,8,8);
			sprite.add("default", [0, 1, 2], 20, true);
			sprite.play("default");
			
			setHitbox (2, 4, -6, -1);
			if (side == -1)
			{
				sprite.flipped = true;
				setHitbox (2, 4, 0, -1);
			}
		}
		
		override public function update():void 
		{
			var destroy:Boolean = false;
			var box:Box = collide("box", x + FP.sign(xSpeed), y ) as Box;
			if (!box) box = collide("box", x, y) as Box;
			if (box)
			{
				world.add(new PulseHit(x, y,side,box));
				box.moveBy(box.WALK_ACCEL*side, 0, box.collideOn, true);
				box.side = side;
				box.hp -= 1;
				destroy = true;
			}
			
			if (collide("solid", x + FP.sign(xSpeed) , y) || collide("solid", x, y) || collide("glossy", x + FP.sign(xSpeed) , y))
			{ 
				world.add(new PulseHit(x, y, side));
				destroy = true;
			}
			
			if (destroy)
			{
				world.remove(this);
			}
			super.update();
		}
		override public function render():void 
		{
			super.render();
			//Draw.hitbox(this)
		}
	}

}