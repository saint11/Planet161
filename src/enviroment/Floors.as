package enviroment 
{
	import flash.display.Graphics;
	import fx.Weather;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Emitter;
	import net.flashpunk.graphics.Tilemap;
	import net.flashpunk.masks.Grid;
	import net.flashpunk.utils.Draw;
	/**
	 * Floor entity with the collision map
	 * @author saint11
	 */
	public class Floors extends Entity
	{
		//Constants
		private const TILE_WIDTH:uint=16, TILE_HEIGHT:uint=16;
		
		private var tiles:Tilemap;
		public var grid:Grid;
		private var rain:Emitter;
		
		public function Floors(level:XML) 
		{
			type = "solid";
			
			graphic = tiles = new Tilemap(Assets.TILESET, level.@width, level.@height, TILE_WIDTH, TILE_HEIGHT);
			
			for each (var tile:XML in level.tiles[0].tile)
			{
				tiles.setTile(int(tile.@x), int(tile.@y), tile.@id);
			}
			
			mask = grid = new Grid(level.@width, level.@height, TILE_WIDTH, TILE_HEIGHT);
			
			for each (var rect:XML in level.solids[0].rect)
			{
				grid.setRect(rect.@x/TILE_WIDTH, rect.@y/TILE_HEIGHT, rect.@w/TILE_WIDTH, rect.@h/TILE_HEIGHT, true);
			}
			
		}
		override public function added():void 
		{
			super.added();
			rain = (FP.world.classFirst(Weather) as Weather).emitter;
			var i:int = 500;
			while (i--)
			{
				rain.emit("rain", (x - width / 2) + Math.random() * width * 2, FP.camera.y - 10);
				rain.update();
			}
			
		}
		override public function update():void 
		{
			super.update();
			
			var i:int = 2;
			while (i--)	rain.emit("rain", (x-width/2) + Math.random() * width * 2, FP.camera.y-10);
		}
	}

}