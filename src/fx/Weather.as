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
	public class Weather extends Entity 
	{
		public var emitter:Emitter = new Emitter(Assets.SPR_WEATHER,8,8);
		
		public function Weather() 
		{
			graphic = emitter;
			layer = 20;
			
			var p:ParticleType = emitter.newType("rain", [1,2]);
			p.setMotion(-60, 10,1, 4, 50, 0.5);
			p.setGravity(10);
			p.setAlpha(.75, 0, Ease.quadIn);
			
			
		}
		
	}

}