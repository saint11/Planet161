package bullets
{
	import actors.Box;
	import actors.Player;
	import enviroment.QuackPlatform;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.utils.Draw;
	/**
	 * ...
	 * @author saint11
	 */
	public class QuackShot extends Bullet 
	{
		private var side:int;
		private var sprite:Spritemap;
		private var player:Player;
		
		public function QuackShot(x:int,y:int,side:int,player:Player) 
		{
			super(side);
			
			this.x = int(x-8);
			this.y = int(y - 8);
			this.side = side;
			this.player = player;
			
			graphic = sprite = new Spritemap(Assets.SPR_QUACK_SHOT,16,8);
			
			setHitbox (2, 8, -14, 0);
			if (side == -1)
			{
				sprite.flipped = true;
				setHitbox (2, 8, 0, 0);
			}
		}
		
		override public function update():void 
		{
			var destroy:Boolean = false;
			
			if (collide("glossy", x + FP.sign(xSpeed) , y) || collide("solid", x, y))
			{ 
				var quack:QuackPlatform = new QuackPlatform(x, y, side,player)
				world.add(quack);
				quack.timer = 10;
				destroy = true;
			}
			
			
			var box:Box = collide("box", x + FP.sign(xSpeed), y ) as Box;
			if (!box) box = collide("box", x, y) as Box;
			if (box)
			{
				world.add(new QuackPlatform(x, y,side,player));
				destroy = true;
			}
			
			if (collide("solid", x + FP.sign(xSpeed) , y) || collide("solid", x, y))
			{ 
				world.add(new QuackPlatform(x, y, side,player));
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
			//Draw.hitbox(this);
		}
		
		
	}

}