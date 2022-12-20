package enviroment 
{
	import actors.Player;
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Spritemap;
	import sound.SoundPlayer;
	
	/**
	 * ...
	 * @author saint11
	 */
	public class RedKey extends Entity 
	{
		private var sprite:Spritemap;
		
		public function RedKey(x:int,y:int) 
		{
			this.x = x;
			this.y = y;
			
			graphic = sprite = new Spritemap(Assets.SPR_KEY, 16, 16);
			sprite.add ("d", [0, 1], 30);
			sprite.play("d");
			
			setHitbox(16, 16, 0, 0);
		}
		
		override public function update():void 
		{
			super.update();
			var player:Player = collide("player", x, y) as Player;
			
			if (player) {
				SoundPlayer.playSfx(Assets.SFX_POWERUP);
				player.redKey = true;
				world.remove(this);
			}
		}
		
	}

}