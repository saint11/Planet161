package enviroment 
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Spritemap;
	
	/**
	 * ...
	 * @author saint11
	 */
	public class Glossy extends Entity 
	{
		private var sprite:Spritemap
		
		public function Glossy(x:int,y:int) 
		{
			this.x = x;
			this.y = y;
			type = "glossy";
			setHitbox(16, 16, 0, 0);
			graphic = sprite = new Spritemap(Assets.GLOSSY, 16, 16);
			sprite.add("d", [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
							0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
							,1, 2, 3, 4, 5], 20, true);
			sprite.play("d");
		}
		
	}

}