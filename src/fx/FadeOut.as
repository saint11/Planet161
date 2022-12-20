package fx 
{
	import flash.display.BlendMode;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.*;
	
	public class FadeOut extends Entity 
	{
		private var i:int, maxi:int;
		private var color:uint, alpha:Number, mode:String;
		private var _function:Function;
		
		public function FadeOut(myColor:uint, duration:int, myAlpha:Number = 1, myMode:String = "normal",myFunction:Function=null)
		{		
			color = myColor;
			i = 0;
			maxi = duration;
			alpha = myAlpha
			mode = myMode;
			_function = myFunction;
			layer = -20;
		}
		
		override public function render():void 
		{
			x = FP.camera.x;
			y = FP.camera.y;
			super.render();
		}
		override public function update():void 
		{
			super.update();
			
			var fillImage:Image = Image.createRect(FP.width, FP.height, color);
			fillImage.alpha = (i / maxi) * alpha ;
			
			switch (mode) {
				case "add": fillImage.blend = BlendMode.ADD; break;
				case "multiply": fillImage.blend = BlendMode.MULTIPLY; break;
				case "overlay": fillImage.blend = BlendMode.OVERLAY; break;
				case "normal": fillImage.blend = BlendMode.NORMAL; break;
			}
			
			graphic = fillImage;
			
			i++;
			if (i/maxi > 1) {
				_function();
				Destroy();
			}
		}
		
		public function Destroy():void
		{
			world.remove(this);
		}
	}

}