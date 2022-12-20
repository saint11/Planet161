package fx 
{
	import flash.display.BlendMode;
	import net.flashpunk.Entity	;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.*;
	
	public class ScreenFlash extends Entity 
	{
		private var i:int, maxi:int;
		private var color:uint, alpha:Number, mode:String;
		private static var isFlashing:Boolean;
		
		public function ScreenFlash(myColor:uint,duration:int,myAlpha:Number = 1,myMode:String = "normal")
		{
			if (!isFlashing) {
				isFlashing = true;
				
				color = myColor;
				i = duration;
				maxi = duration;
				alpha = myAlpha
				mode = myMode;
				layer = -100
			}
		}
		
		override public function render():void 
		{
			x = FP.camera.x;
			y = FP.camera.y;
			var flashImage:Image = Image.createRect(FP.width, FP.height, color);
			flashImage.alpha = (i / maxi) * alpha ;
			
			switch (mode) {
				case "add": flashImage.blend = BlendMode.ADD; break;
				case "multiply": flashImage.blend = BlendMode.MULTIPLY; break;
				case "overlay": flashImage.blend = BlendMode.OVERLAY; break;
				case "normal": flashImage.blend = BlendMode.NORMAL; break;
			}
			graphic = flashImage;
			super.render();
		}
		override public function update():void 
		{
			super.update();
			i--;
			if (i < 0) Destroy();
		}
		
		public function Destroy():void
		{
			isFlashing = false;
			world.remove(this);
		}
	}

}