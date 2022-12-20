package bullets 
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	/**
	 * ...
	 * @author saint11
	 */
	public class Bullet extends Entity
	{
		protected var xSpeed:Number;
		protected var collideOn:Array = new Array("solid", "box","glossy")
		public function Bullet(direction:int=1) 
		{
			xSpeed = 4 * direction;
		}
		
		override public function update():void 
		{
			moveBy(xSpeed * FP.elapsed * 60, 0, collideOn, true)
			//if (collide("solid", x + FP.sign(xSpeed), y) || collide("box", x + FP.sign(xSpeed), y))
			
			super.update();
		}
	}

}