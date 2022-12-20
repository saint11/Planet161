package bullets 
{
	import actors.Box;
	import actors.Player;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.utils.Draw;
	import sound.SoundPlayer;
	/**
	 * ...
	 * @author saint11
	 */
	public class HookShot extends Bullet 
	{
		
		private var sprite:Image
		private var goingBack:Boolean = false;
		private var myPlayer:Player;
		private var myBox:Box;
		private var step:int = 0;
		
		public function HookShot(x:int,y:int, side:int, myPlayer:Player) 
		{
			super(side);
			
			this.x = int(x-8);
			this.y = int(y - 8);
			this.myPlayer = myPlayer;
			
			setHitbox(8, 4, 0, -2);
			
			graphic = sprite = new Image(Assets.SPR_HOOK);
			if (side == -1) sprite.flipped = true;
			
			collideOn = [];
		}
		
		override public function update():void 
		{
			if (!goingBack){
				if (collide("solid", x + xSpeed , y) || collide("solid", x, y) || collide("box", x, y)) {
					xSpeed = -xSpeed;
					goingBack = true;
					collideOn = [];
				}
			}
			step++;
			if (step % 2 == 0 && !goingBack) world.add(new Chain(x, y));
			
			var box:Box = collide("box", x + xSpeed , y) as Box
			if (box && !goingBack) {
				xSpeed = -xSpeed;
				goingBack = true;
				myBox = box;
				SoundPlayer.playSfx(Assets.SFX_HOOK);
			}
			
			var chain:Chain = collide("chain", x, y) as Chain
			if (chain && goingBack) {
				chain.timer = 0;
			}
			
			var player:Player = collide("player", x, y) as Player
			if (player && goingBack) {
				player.canMove = true;
				world.remove(this);
			}
			
			if (myBox) {
				myBox.xSpeed = xSpeed;
				myBox.moveBy(FP.sign(xSpeed), 0,myBox.collideOn);
			}
			super.update();
		}
		override public function moveCollideX(e:Entity):Boolean 
		{
			//if (goingBack) x += FP.sign(xSpeed);
			return super.moveCollideX(e);
		}
		override public function render():void 
		{
			super.render();
			//Draw.hitbox(this, true);
		}
	}

}