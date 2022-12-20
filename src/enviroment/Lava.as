package enviroment 
{
	import fx.Particles;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Emitter;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Particle;
	/**
	 * ...
	 * @author saint11
	 */
	public class Lava extends Entity
	{
		private var emitter:Emitter
		private var timer:int = 0;
		public function Lava(x:int,y:int) 
		{
			type = "hazzard";
			this.x = x;
			this.y = y;
			
			graphic = Image.createRect(16, 16, 0xFF3311);
			setHitbox(16, 16, 0, 0);
			
			
		}
		
		override public function added():void 
		{
			super.added();
			emitter = (FP.world.classFirst(Particles) as Particles).emitter;
		}
		
		override public function update():void 
		{
			if (timer++ == 30) {
				emitter.emit("explosion", x + 8, y + 8);
				timer = 0;
			}
			
			super.update();
		}
	}

}