package rooms 
{
	import flash.utils.ByteArray;
	import net.flashpunk.World;
	/**
	 * Base level loader for XML files.
	 * @author saint11
	 */
	public class LevelLoader extends World
	{
		//(Based on Chevy Ray's Pink Game Code)
		public var myXml:XML

		public function LevelLoader(source:Class) 
		{
			var file:ByteArray = new source;
			myXml = XML(file.readUTFBytes(file.length));
		}
		
	}

}