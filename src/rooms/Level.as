package rooms 
{
	import actors.Actor;
	import actors.Barrel;
	import actors.Box;
	import actors.Player;
	import enviroment.Background;
	import enviroment.Door;
	import enviroment.Floors;
	import enviroment.Glossy;
	import enviroment.Lava;
	import enviroment.OneWayPlatform;
	import enviroment.Portal;
	import enviroment.RedKey;
	import enviroment.WeaponCollectible;
	import fx.Particles;
	import fx.ScreenFlash;
	import fx.Weather;
	import net.flashpunk.FP;
	import sound.SoundPlayer;
	/**
	 * Creates a new level from the XML file given.
	 * (Code based on Chevy Ray's Pink Game code)
	 * @author saint11
	 */
	public class Level extends LevelLoader
	{
		//Level size and camera
		public var width:uint;
		public var height:uint;
		public var player:Actor;
		
		/**
		 * Camera following information.
		 */
		public const FOLLOW_TRAIL:Number = 50;
		public const FOLLOW_RATE:Number = .9;
		
		public function Level(rawXML:Class) 
		{
			super (rawXML); //process the XML
			
			width = myXml.@width;
			height = myXml.@height;
			
			add(new Particles());
			add(new Weather());
			
			add(new Floors(myXml));
			add(new Message("hello world"));
			switch(int(myXml.@background))
			{
				case 0:	add(new Background(Assets.BG0)); SoundPlayer.playMusic(Assets.MUS0); break;
				case 1:	add(new Background(Assets.BG1)); SoundPlayer.playMusic(Assets.MUS1); break;
				case 2:	add(new Background(Assets.BG2)); SoundPlayer.playMusic(Assets.MUS0); break;
				case 3:	add(new Background(Assets.BG3)); SoundPlayer.playMusic(Assets.MUS1); break;
			}
			
			var o:XML;
			
			for each (o in myXml.objects[0].player)
			{
				player = new Player(o.@x, o.@y);
				player.adjustAxis();
				add(player);
			}
			for each (o in myXml.objects[0].actor)
			{
				var actor:Actor = new Actor(o.@x, o.@y);
				actor.adjustAxis();
				add(actor);
			}
			for each (o in myXml.objects[0].oneWayPlatform)
			{
				var oneWayPlatform:OneWayPlatform = new OneWayPlatform(o.@x, o.@y,player);
				add(oneWayPlatform);
			}
			for each (o in myXml.objects[0].box)
			{
				var box:Box = new Box(o.@x, o.@y);
				box.adjustAxis();
				add(box);
			}
			for each (o in myXml.objects[0].barrel)
			{
				var barrel:Barrel = new Barrel(o.@x, o.@y);
				barrel.adjustAxis();
				add(barrel);
			}
			
			for each (o in myXml.objects[0].hookCollectible)
			{
				var hook:WeaponCollectible = new WeaponCollectible(o.@x, o.@y,"hook");
				add(hook);
			}
			for each (o in myXml.objects[0].pulseCollectible)
			{
				var pulse:WeaponCollectible = new WeaponCollectible(o.@x, o.@y,"pulse");
				add(pulse);
			}
			for each (o in myXml.objects[0].quackCollectible)
			{
				var quack:WeaponCollectible = new WeaponCollectible(o.@x, o.@y,"quack");
				add(quack);
			}
			
			for each (o in myXml.objects[0].portal)
			{
				var portal:Portal= new Portal(o.@x, o.@y);
				add(portal);
			}
			
			for each (o in myXml.objects[0].redDoor)
			{
				var redDoor:Door= new Door(o.@x, o.@y,"red");
				add(redDoor);
			}
			for each (o in myXml.objects[0].redKey)
			{
				var redKey:RedKey= new RedKey(o.@x, o.@y);
				add(redKey);
			}
			for each (o in myXml.objects[0].glossy)
			{
				var glossy:Glossy= new Glossy(o.@x, o.@y);
				add(glossy);
			}
			for each (o in myXml.objects[0].lava)
			{
				var lava:Lava= new Lava(o.@x, o.@y);
				add(lava);
			}
			
		}
		override public function begin():void 
		{
			add(new ScreenFlash(0x0, 100));
			super.begin();
		}
		
		/**
		 * Update the level.
		 */
		override public function update():void 
		{
			// update entities
			super.update();
			// camera following
			if (player!=null) cameraFollow();
		}
		
		/**
		 * Makes the camera follow the player object.
		 */
		private function cameraFollow():void
		{
			FP.point.x = FP.camera.x - targetX;
			FP.point.y = FP.camera.y - targetY;
			var dist:Number = FP.point.length;
			if (dist > FOLLOW_TRAIL) dist = FOLLOW_TRAIL;
			FP.point.normalize(dist * FOLLOW_RATE);
			FP.camera.x = int(targetX + FP.point.x);
			FP.camera.y = int(targetY + FP.point.y);
			
			// keep camera in room bounds
			FP.camera.x = FP.clamp(FP.camera.x, 0, width - FP.width);
			FP.camera.y = FP.clamp(FP.camera.y, 0, height - FP.height);
		}
		
		/**
		 * Getter functions used to get the position to place the camera when following the player.
		 */
		private function get targetX():Number { return player.x - FP.width / 2; }
		private function get targetY():Number { return player.y - FP.height / 2; }
	}
}