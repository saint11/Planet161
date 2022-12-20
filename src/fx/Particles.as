package fx 
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Emitter;
	import net.flashpunk.graphics.Particle;
	import net.flashpunk.graphics.ParticleType;
	import net.flashpunk.utils.Ease;
	
	/**
	 * ...
	 * @author saint11
	 */
	public class Particles extends Entity 
	{
		public var emitter:Emitter = new Emitter(Assets.SPR_SMOKE,8,8);
		
		public function Particles() 
		{
			graphic = emitter;
			layer = -10;
			
			var p:ParticleType = emitter.newType("dust", [5,6,7]);
			p.setMotion(90, 2.5, .5, 180, 5, .5, Ease.cubeOut);
			p.setColor(0xFFFFFF, 0xFF33FF, Ease.quadIn);
			p.setAlpha(1, 0, Ease.quadOut);
			
			p = emitter.newType("explosion", [8,9,10,11,12]);
			p.setMotion(90, 8, 1.0, 360, 20, .5, Ease.quadOut);
			p.setColor(0xFFFFFF, 0xFFFF33, Ease.quadOut);
			
			p = emitter.newType("quick_dust", [5, 6, 7]);
			p.setMotion(90, 2.5, .5, 180, 5, .5, Ease.quadIn);
			p.setColor(0xFFFFFF, 0xFF33FF, Ease.quadIn);
			p.setAlpha(.6, 0, Ease.quadOut);
			
			p = emitter.newType("smoke", [0, 1, 2, 3, 4]);
			p.setMotion(0, 2.5, .5, 180, 5, .5, Ease.cubeOut);
			p.setColor(0xFFFFFF, 0xFF3366, Ease.quadIn);
			p.setGravity( -1);
			
			p.setAlpha(1, 0);
		}
		
	}

}