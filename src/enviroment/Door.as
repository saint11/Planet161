package enviroment 
{
	import actors.Player;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Spritemap;
	import sound.SoundPlayer;
	/**
	 * ...
	 * @author saint11
	 */
	public class Door extends Entity
	{
		private var color:String;
		private var sprite:Spritemap;
		
		public function Door(x:int,y:int,color:String) 
		{
			type = "solid";
			this.x = x;
			this.y = y;
			this.color = color;
			setHitbox(16, 16, 0, 0);
			switch(color)
			{
				case "red":
					graphic = sprite = new Spritemap(Assets.SPR_RED_DOOR, 16, 16);
					sprite.add("default", [0, 1, 2, 3], 30, true);
					sprite.add("open", [4, 5, 6, 7, 8], 30, false);
			}
			
			sprite.play("default");
		}
		
		override public function update():void 
		{
			super.update();
			if (collide("player", x + 4, y) || collide("player", x - 4, y))
			{
				var player:Player = (FP.world.classFirst(Player) as Player);
				if (player.redKey) {
					SoundPlayer.playSfx(Assets.SFX_DOOR);
					sprite.play( "open");
					type = "none";
					player.redKey = false;
				}
			}
		}
	}

}