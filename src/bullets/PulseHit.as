package bullets 
{
	import actors.Actor;
	import fx.Particles;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Emitter;
	import net.flashpunk.graphics.Spritemap;
	import sound.SoundPlayer;
	
	/**
	 * ...
	 * @author saint11
	 */
	public class PulseHit extends Entity 
	{
		private var sprite:Spritemap;
		private var xSpeed:Actor;
		private var emitter:Emitter;
		
		public function PulseHit(x:int,y:int,side:int,xSpeed:Actor=null) 
		{
			this.x = x;
			this.y = y - 2;
			this.xSpeed = xSpeed;
			
			graphic = sprite = new Spritemap(Assets.SPR_PULSE_HIT, 8, 8, kill);
			sprite.add("default", [0, 1, 2, 3], 20, false);
			sprite.play("default");
			if (side == -1) sprite.flipped = true;
			
			setHitbox (8, 8, 0, 0);
		}
		override public function added():void 
		{
			super.added();
			SoundPlayer.playSfx(Assets.SFX_PULSEHIT);
			emitter = (FP.world.classFirst(Particles) as Particles).emitter;
			var i:int = 1;
			while (i--) emitter.emit("explosion", x + 4, y + 4);
			i = 3;
			while (i--) emitter.emit("smoke", x + 4, y + 4);
		}
		override public function update():void 
		{
			if (xSpeed != null) x += (xSpeed.xSpeed + (FP.sign(xSpeed.xSpeed)/2))*FP.elapsed*60;
			super.update();
		}
		private function kill():void
		{
			world.remove(this);
		}
		
	}

}