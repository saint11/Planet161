package rooms 
{
	import flash.geom.Point;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Text;
	
	/**
	 * ...
	 * @author saint11
	 */
	public class Message extends Entity 
	{
		public var bg:Image = Image.createRect(100, 16, 0x0);
		private var myText:Text;
		private var timer:int = 300;
		public function Message(message:String) 
		{
			x = FP.halfWidth - 50;
			y = FP.height - 32;
			layer = -100;
			graphic = bg;
			myText = new Text(message, 0, 3, { width:100, align:"center", size:8 } );
		}
		
		override public function render():void 
		{
			super.render();
			if (timer > 15 || timer % 2 == 0)
				myText.render(FP.buffer, new Point(x, y), new Point(FP.camera.x, FP.camera.y));
		}
		
		override public function update():void 
		{
			super.update();
			timer --;
			
			if (timer < 10) {
				bg.scaleY = timer / 10;
				myText.y -= 1;
				y += 1;
			}
			if (timer < 0) world.remove(this);
		}
		
	}

}