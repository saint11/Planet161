package actors 
{
	import bullets.HookShot;
	import bullets.PulseShot;
	import bullets.QuackShot;
	import fx.Particles;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Emitter;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.utils.Input;
	import rooms.Level;
	import rooms.Menu;
	import sound.SoundPlayer;
	
	/**
	 * ...
	 * @author saint11
	 */
	public class Player extends Actor 
	{
		public var currentWeapon:String = "none";
		private var canPush:Boolean = false;
		public var redKey:Boolean = false;
		public function Player(x:int=0,y:int=0) 
		{
			super(x, y);
			type = "player";
			
			graphic = sprite = new Spritemap(Assets.SPR_PLAYER, 16, 16);

			sprite.originX = sprite.width / 2;
			sprite.originY = sprite.height / 2;
			sprite.x = -sprite.originX;
			sprite.y = -sprite.originY;
			sprite.smooth = false;
			
			setHitbox(sprite.width - 6, sprite.height - 4, 12, 12);
			SQUISHY_RATE = 0;
			
			sprite.add("run", [0, 1, 2, 3, 4, 5,6,7,8], 14, true);
			sprite.add("stand", [9,10,11,12,13], 10, true);
			sprite.add("win", [16,17,18,19,20,21,22,23,24,25,26], 15, false);
			sprite.play("run");
			
			STAND_ON_PLATFORMS = true;
			COLIDE_ON = ["solid", "box", "platform","glossy"];
		}
		
		override public function update():void 
		{	
			dropDown = false;
			
			// evaluate input
			accel = 0;
			
			if (canMove) {
				var box:Box
				if (Input.check("R")) {
					if (accel < 0) accel = 0;
					
					accel += WALK_ACCEL;
					if (canPush){
						box = collide("box",x+2,y) as Box
						if (box && onSolid) {
							box.accel += box.WALK_ACCEL;
							box.side = side;
						}
					}
				}
				if (Input.check("L")) {
					if (accel > 0) accel = 0;
					accel -= WALK_ACCEL;
					
					if (canPush) {
						box = collide("box",x-2,y) as Box
						if (box && onSolid) {
							box.accel -= box.WALK_ACCEL;
							box.side = side;
						}
					}
				}
				
				if (Input.check("D")) dropDown = true;
				
				if (Input.pressed("SHOT"))
				{
					if (currentWeapon == "hook" && onSolid)
					{
						emitter.emit("smoke", x+4*side -12, y - 8);
						world.add(new HookShot(x+ side*2, y-2, side, this));
						canMove = false;
						xSpeed = 0;
						accel = 0;
						SoundPlayer.playSfx(Assets.SFX_SHOT2)
					} else if (currentWeapon == "pulse")
					{
						emitter.emit("smoke", x+4*side -12, y - 8);
						world.add(new PulseShot(x + side * 2, y - 1, side, this));
						SoundPlayer.playSfx(Assets.SFX_SHOT)
					} else if (currentWeapon == "quack")
					{
						world.add(new QuackShot(x - 8 -side * 4, y - 2, side, this));
						SoundPlayer.playSfx(Assets.SFX_SHOT2)
					} 
				}
			}
			if (canMove) {
				if (Input.pressed("JUMP") && onSolid)
				{ jumpOrder = true;	SoundPlayer.playSfx(Assets.SFX_JUMP)}
				
				if (Input.check("JUMP"))
				{
					isJumping=true;
				} else isJumping = false;
			}
			
			if (Input.pressed("RESTART") && onSolid)
			{
				goToLevel(Global.currentLevel);
			}
			
			if (accel < 0)
				sprite.flipped = true;
			else if (accel > 0)
				sprite.flipped = false;
			if (sprite.currentAnim!="win"){
				if (Math.abs(accel) > 0) {
					sprite.play("run");
				} else {
					sprite.play("stand");
				}
			}
			if (sprite.flipped) side = -1;
			else side = 1;
			
			super.update();
		}
		
		public function nextLevel():void
		{
			Global.currentLevel ++;
			goToLevel(Global.currentLevel);
		}
		public function goToLevel(level:int):void
		{
			//level = 9;
			switch (level)
			{
				case 0: FP.world = new Level(Assets.XML_LEVEL0); break;
				case 1: FP.world = new Level(Assets.XML_LEVEL1); break;
				case 2: FP.world = new Level(Assets.XML_LEVEL2); break;
				case 3: FP.world = new Level(Assets.XML_LEVEL3); break;
				case 4: FP.world = new Level(Assets.XML_LEVEL4); break;
				case 5: FP.world = new Level(Assets.XML_LEVEL5); break;
				case 6: FP.world = new Level(Assets.XML_LEVEL6); break;
				case 7: FP.world = new Level(Assets.XML_LEVEL7); break;
				case 8: FP.world = new Level(Assets.XML_LEVEL8); break;
				case 9: FP.world = new Level(Assets.XML_LEVEL9); break;
			}
		}
		override protected function kill():void 
		{
			if (killTimer == 0) goToLevel(Global.currentLevel);
			super.kill();
		}
		public function win():void
		{
			canMove = false;
			sprite.play("win", true);
		}
	}

}