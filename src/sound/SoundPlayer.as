package sound 
{
	import net.flashpunk.Sfx;
	/**
	 * ...
	 * @author saint11
	 */
	public class SoundPlayer 
	{
		
		private static var currentSound:Sfx
		private static var currentMusic:Sfx
		
		public function SoundPlayer() 
		{
			
		}
		
		public static function playSfx(soundName:Class):void
		{
			currentSound = new Sfx(soundName);
			currentSound.specialPlay();
		}
		public static function playMusic(musicName:Class):void
		{
			if (currentMusic) currentMusic.stop();
			
			currentMusic = new Sfx(musicName);
			currentMusic.loop();
		}
	}

}