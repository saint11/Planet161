package enviroment 
{
	import net.flashpunk.FP;
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Backdrop;
	import net.flashpunk.graphics.Image;
	/**
	 * ...
	 * @author saint11
	 */
	public class Background extends Entity
	{
		public var scrollX:Number=15;
		public var scrollY:Number = 0;
		private var lighting:int = 0;
		private var image:Backdrop
		private var struck:int = -1;
		
		public function Background(rawImage:Class) 
		{
			// set the background graphic and parallax rates.
			graphic = image = new Backdrop(rawImage);
			graphic.scrollX = .5;
			graphic.scrollY = .5;
			
			// put it on layer 100, so it appears behind other entities.
			layer = 100;
		}
		
		/**
		 * Updates the background, makes it scroll.
		 */
		override public function update():void 
		{
			x -= FP.elapsed * scrollX;
			y -= FP.elapsed * scrollY;
			
			lighting++;
			if ((lighting > 50 && Math.random() < 0.01) || (struck>0 && struck%2==0))
			{
				graphic = new Backdrop(Assets.BG_LIGHTING)
				struck = Math.random() * 5;
			} else graphic = image;
			struck--;
		}
	}

}