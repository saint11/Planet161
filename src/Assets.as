package  
{
	/**
	 * ...
	 * @author saint11
	 */
	public class Assets 
	{
		//Music and Sound
		[Embed(source = "../assets/sound/Jump.mp3")]public static const SFX_JUMP:Class;
		[Embed(source = "../assets/sound/step.mp3")]public static const SFX_STEP:Class;
		[Embed(source = "../assets/sound/fall.mp3")]public static const SFX_FALL:Class;
		[Embed(source = "../assets/sound/shot.mp3")]public static const SFX_SHOT:Class;
		[Embed(source = "../assets/sound/shot2.mp3")]public static const SFX_SHOT2:Class;
		[Embed(source = "../assets/sound/hookCling.mp3")]public static const SFX_HOOK:Class;
		[Embed(source = "../assets/sound/quackWall.mp3")]public static const SFX_QUACK:Class;
		[Embed(source = "../assets/sound/portal.mp3")]public static const SFX_PORTAL:Class;
		[Embed(source = "../assets/sound/pulseHit.mp3")]public static const SFX_PULSEHIT:Class;
		[Embed(source = "../assets/sound/explosion.mp3")]public static const SFX_EXPLOSION:Class;
		[Embed(source = "../assets/sound/powerup.mp3")]public static const SFX_POWERUP:Class;
		[Embed(source = "../assets/sound/door.mp3")]public static const SFX_DOOR:Class;
		
		[Embed(source = "../assets/sound/music0.mp3")] public static const MUS0:Class;
		[Embed(source = "../assets/sound/music1.mp3")] public static const MUS1:Class;
		
		//Level Files
		[Embed(source = "../assets/level/level0.oel", mimeType = 'application/octet-stream')] public static var XML_LEVEL0:Class;
		[Embed(source = "../assets/level/level1.oel", mimeType = 'application/octet-stream')] public static var XML_LEVEL1:Class;
		[Embed(source = "../assets/level/level2.oel", mimeType = 'application/octet-stream')] public static var XML_LEVEL2:Class;
		[Embed(source = "../assets/level/level3.oel", mimeType = 'application/octet-stream')] public static var XML_LEVEL3:Class;
		[Embed(source = "../assets/level/level4.oel", mimeType = 'application/octet-stream')] public static var XML_LEVEL4:Class;
		[Embed(source = "../assets/level/level5.oel", mimeType = 'application/octet-stream')] public static var XML_LEVEL5:Class;
		[Embed(source = "../assets/level/level6.oel", mimeType = 'application/octet-stream')] public static var XML_LEVEL6:Class;
		[Embed(source = "../assets/level/level7.oel", mimeType = 'application/octet-stream')] public static var XML_LEVEL7:Class;
		[Embed(source = "../assets/level/level8.oel", mimeType = 'application/octet-stream')] public static var XML_LEVEL8:Class;
		[Embed(source = "../assets/level/level9.oel", mimeType = 'application/octet-stream')] public static var XML_LEVEL9:Class;
		
		//XML Files
		
		//Actor Images
		[Embed(source = "../assets/actors/barrel.png")]  public static const SPR_BARREL:Class;
		[Embed(source = "../assets/actors/box.png")]  public static const SPR_BOX:Class;
		[Embed(source = "../assets/actors/actor.png")]  public static const SPR_ACTOR:Class;
		[Embed(source = "../assets/actors/player.png")] public static const SPR_PLAYER:Class;
		
		//Bullets and FX
		[Embed(source = "../assets/others/quackShot.png")] public static const SPR_QUACK_SHOT:Class;
		[Embed(source = "../assets/others/hook.png")] public static const SPR_HOOK:Class;
		[Embed(source = "../assets/others/dots.png")] public static const SPR_DOTS:Class;
		[Embed(source = "../assets/others/pulseHit.png")] public static const SPR_PULSE_HIT:Class;
		[Embed(source = "../assets/others/pulseShot.png")] public static const SPR_PULSE_SHOT:Class;
		
		[Embed(source = "../assets/others/weather.png")] public static const SPR_WEATHER:Class;
		[Embed(source = "../assets/others/smoke.png")] public static const SPR_SMOKE:Class;
		
		//Enviroment Images
		[Embed(source = "../assets/enviroment/bgLighting.png")] public static const BG_LIGHTING:Class;
		[Embed(source = "../assets/enviroment/bg0.png")] public static const BG0:Class;
		[Embed(source = "../assets/enviroment/bg1.png")] public static const BG1:Class;
		[Embed(source = "../assets/enviroment/bg2.png")] public static const BG2:Class;
		[Embed(source = "../assets/enviroment/bg3.png")] public static const BG3:Class;
		
		[Embed(source = "../assets/enviroment/glossy.png")] public static const GLOSSY:Class;
		[Embed(source = "../assets/enviroment/oneWayPlatform.png")] public static const ONE_WAY:Class;
		[Embed(source = "../assets/enviroment/tileset.png")] public static const TILESET:Class;
		
		[Embed(source = "../assets/others/key.png")] public static const SPR_KEY:Class;
		[Embed(source = "../assets/enviroment/closePoint.png")] public static const COLECTIBLE_CLOSE:Class;
		[Embed(source = "../assets/enviroment/hook_point.png")] public static const COLECTIBLE_HOOK:Class;
		[Embed(source = "../assets/enviroment/pulseCollectible.png")] public static const COLECTIBLE_PULSE:Class;
		[Embed(source = "../assets/enviroment/quackCollectible.png")] public static const COLECTIBLE_QUACK:Class;
		[Embed(source = "../assets/enviroment/redDoor.png")] public static const SPR_RED_DOOR:Class;
		[Embed(source = "../assets/enviroment/portal.png")] public static const SPR_PORTAL:Class;
		
		//UI Images
		[Embed(source = "../assets/ui/Title.png")] public static const BG_TITLE:Class;
		
		public function Assets() 
		{
			
		}
		
	}

}