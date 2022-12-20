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
	public class WeaponCollectible extends Entity
	{
		private var myWeapon:String;
		private var myPlayer:Player;
		
		private var sprite:Spritemap;
		
		private var open:Boolean=true;
		
		public function WeaponCollectible(x:int,y:int,weaponType:String) 
		{
			this.x = x;
			this.y = y;
			
			setHitbox(16, 16, 0, 0);
			type = "collectible";
			myWeapon = weaponType;
			
			findSpriteMap();
		}
		
		override public function update():void 
		{
			var player:Player = collide("player", x, y) as Player;
			if (player) {
				myPlayer = player;
				if (player.currentWeapon != myWeapon) {
					SoundPlayer.playSfx(Assets.SFX_POWERUP);
					player.currentWeapon = myWeapon;
					graphic = sprite = new Spritemap(Assets.COLECTIBLE_CLOSE, 16, 16);
					sprite.add("close", [0, 1, 2, 3, 4, 5, 6, 7], 12, false);
					sprite.add("open", [7, 6, 5, 4, 3, 2, 1], 12, false);
					sprite.play("close");
				}
			}
			
			if (myPlayer && sprite.currentAnim != "default") {				
				if (myPlayer.currentWeapon != myWeapon  && sprite.currentAnim == "close") {
					sprite.play("open", true);
				}
				if (sprite.complete && sprite.currentAnim == "open") {
					findSpriteMap();
				}
			}
			super.update();
		}
		
		private function findSpriteMap():void
		{
			switch (myWeapon) {
				case "hook":
					graphic = sprite = new Spritemap(Assets.COLECTIBLE_HOOK, 16, 16);
					sprite.add("default", [0, 1, 2, 3], 12, true)
					sprite.play("default");
					break;
				case "pulse":
					graphic = sprite = new Spritemap(Assets.COLECTIBLE_PULSE, 16, 16);
					sprite.add("default", [0, 1, 2, 3], 12, true)
					sprite.play("default");
					break;
				case "quack":
					graphic = sprite = new Spritemap(Assets.COLECTIBLE_QUACK, 16, 16);
					sprite.add("default", [0, 1, 2, 3], 12, true)
					sprite.play("default");
					break;
			}
		}
		
	}

}