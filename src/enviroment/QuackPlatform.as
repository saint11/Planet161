package enviroment 
{
	import actors.Actor;
	import net.flashpunk.graphics.Spritemap;
	import sound.SoundPlayer;
	/**
	 * ...
	 * @author saint11
	 */
	public class QuackPlatform extends OneWayPlatform 
	{
		protected var sprite:Spritemap;
		public var timer:int = 120;
		public function QuackPlatform(x:int,y:int,side:int,player:Actor) 
		{
			this.x = x;
			this.y = y;
			super(x, y, player);
			
			graphic = sprite = new Spritemap(Assets.SPR_QUACK_SHOT, 16, 8);
			sprite.add('d', [1, 2, 3, 4, 5, 0], 25, false);
			sprite.play('d');
			if (side == -1) sprite.flipped = true;
			
			setHitbox (16, 1, 0, -3);
		}
		override public function added():void 
		{
			super.added();
			SoundPlayer.playSfx(Assets.SFX_QUACK);
		}
		override public function update():void 
		{
			timer--;
			if (timer < 10)
			{
				setHitbox(0, 0, 0, 0);
				y += 1;
				if (timer % 2 == 0) sprite.alpha = 0.1;
				else sprite.alpha = 0.6;
			}else if (timer < 30 && timer % 4 == 0)
			{
				sprite.alpha = 0.2;
			} else sprite.alpha = 1;
			
			if (player.y - 3 <= y) {
				type = "platform";
			}
			else {
				type = "none";
			}
			
			//super.update();
			if (timer < 0) world.remove(this);
		}
		
	}

}