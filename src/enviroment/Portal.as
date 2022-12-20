package enviroment 
{
	import actors.Player;
	import fx.FadeOut;
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Spritemap;
	import sound.SoundPlayer;
	
	/**
	 * ...
	 * @author saint11
	 */
	public class Portal extends Entity 
	{
		private var sprite:Spritemap
		private var collided:Boolean = false;
		public function Portal(x:int,y:int) 
		{
			layer = 5;
			this.x = x;
			this.y = y;
			graphic = sprite = new Spritemap(Assets.SPR_PORTAL, 16, 16);
			sprite.add("d", [0, 1, 2, 3], 30, true);
			sprite.play("d");
			
			setHitbox(16, 16, 0, 0);
		}
		override public function update():void 
		{
			var player:Player = collide("player", x, y) as Player;
			if (player && !collided)
			{
				collided = true;
				world.add(new FadeOut(0xFFFFFF, 100, 1, "normal", player.nextLevel));
				SoundPlayer.playSfx(Assets.SFX_PORTAL);
				player.win();
			}
			super.update();
		}
	}

}