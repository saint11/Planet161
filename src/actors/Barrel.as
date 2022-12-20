package actors 
{
	import net.flashpunk.graphics.Spritemap;
	import sound.SoundPlayer;
	/**
	 * ...
	 * @author saint11
	 */
	public class Barrel extends Box 
	{
		private var killTag:Boolean = false;
		public function Barrel(x:int,y:int) 
		{
			super(x, y);
			
			hp = 1;
			SQUISHY_RATE = 0.1;
			
			graphic = sprite = new Spritemap(Assets.SPR_BARREL, 16, 16);

			sprite.originX = sprite.width / 2;
			sprite.originY = sprite.height / 2;
			sprite.x = -sprite.originX;
			sprite.y = -sprite.originY;
			sprite.smooth = true;
			
			setHitbox(sprite.width, sprite.height, 16, 16);
		}
		override public function update():void 
		{
			super.update();
			
			if (killTag){
				SoundPlayer.playSfx(Assets.SFX_EXPLOSION);
				layer = -20;
				x -= 20;
				y -= 20;
				graphic = null;
				
				var box:Barrel = collide("box", x - 16, y) as Barrel;
				if (box) box.hp -= 5;
				box =  collide("box", x - 16, y -16) as Barrel;
				if (box) box.hp -= 5;
				box =  collide("box", x , y -16) as Barrel;
				if (box) box.hp -= 5;
				box =  collide("box", x +16, y -16) as Barrel;
				if (box) box.hp -= 5;
				box =  collide("box", x -16, y +16) as Barrel;
				if (box) box.hp -= 5;
				box =  collide("box", x , y +16) as Barrel;
				if (box) box.hp -= 5;
				box =  collide("box", x +16, y) as Barrel;
				if (box) box.hp -= 5;
				box =  collide("box", x +16, y +16) as Barrel;
				if (box) box.hp -= 5;
				killTag = false;	
			}
			if (hp <= 0 && !destroy) {
				killTag = true
				destroy = true;
			}
		}
		
	}

}