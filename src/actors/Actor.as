package actors 
{
	import enviroment.OneWayPlatform;
	import flash.geom.Point;
	import fx.Particles;
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Emitter;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.tweens.misc.NumTween;
	import net.flashpunk.tweens.motion.LinearMotion;
	import net.flashpunk.utils.Ease;
	import net.flashpunk.utils.Input;
	import net.flashpunk.FP;
	import sound.SoundPlayer;
	
	/**
	 * ...
	 * @author saint11
	 */
	public class Actor extends Entity 
	{
		/**
		 * Tweeners.
		 */
		public const SCALE:LinearMotion = new LinearMotion;
		public const ROTATE:NumTween = new NumTween;
		
		/**
		 * Physics stuff.
		 */
		protected var GRAVITY:Number = 0.1;
		protected var MAX_Y_SPEED:Number = 5;
		protected const FLOAT:Number = 0.29;
		protected const JUMP_SPEED:Number = -2.8;
		protected const LEAP:Number = 1.2;
		protected var STAND_ON_PLATFORMS:Boolean = false;
		
		public var WALK_ACCEL:Number=3;
		protected const MAX_HORIZONTAL_SPEED:Number = 1.5;
		protected const DAMPING:Number = 0.86;
		
		protected var COLIDE_ON:Array = new Array("solid", "box","glossy");
		
		public var ySpeed:Number = 0;
		public var jumpOrder:Boolean = false, isJumping:Boolean = false, dropDown:Boolean = false;
		public var onSolid:Boolean = false, collideOn:Array = COLIDE_ON;
		
		public var xSpeed:Number = 0;
		public var accel:Number=0;

		/**
		 * Image and Animation.
		 */
		public var side:int = 1;
		protected const JUMP_ROTATING:Boolean=false;
		protected const BOUNCY:Boolean=true;
		protected var SQUISHY_RATE:Number=0.2;
		protected const X_BOUNCE_MIN_SPEED:Number=2;
		protected var sprite:Spritemap;
		protected var emitter:Emitter;
	
		protected var killTimer:int = 10, destroy:Boolean=false;

		private var debugpoint1:int =0;
		/**
		 * Controls
		 */
		public var canMove:Boolean = true;
		
		public function Actor(x:int=0,y:int=0) 
		{
			this.x = x;
			this.y = y;

			graphic = sprite = new Spritemap(Assets.SPR_ACTOR, 16, 16);

			sprite.originX = sprite.width / 2;
			sprite.originY = sprite.height / 2;
			sprite.x = -sprite.originX;
			sprite.y = -sprite.originY;
			x += sprite.width;
			y += sprite.height;
			
			sprite.smooth = true;
			
			setHitbox(sprite.width, sprite.height, 16, 16);
			
			if (JUMP_ROTATING) addTween(ROTATE);
			if (BOUNCY)	addTween(SCALE);
		}
		
		override public function added():void 
		{
			super.added();
			emitter = (FP.world.classFirst(Particles) as Particles).emitter;
		}
		override public function update():void 
		{		
			handleXSpeed();
			
			applyGravity();
			checkFloor();
			jumping();
			
			moveBy(xSpeed * FP.elapsed * 60, ySpeed * FP.elapsed * 60, collideOn, true);
			
			animation();
			
			
			if (collide("hazzard", x, y) && !destroy)
			{
				var i:int = 15;
				while (i--) emitter.emit("explosion", x - 16 + Math.random() * 16, y  - 16 + Math.random() * 16);
				destroy = true;
				layer = -20;
				x -= 18;
				y -= 16;
				SoundPlayer.playSfx(Assets.SFX_EXPLOSION);
			}
			if (destroy) kill();
			
			super.update();
		}
		
		protected function kill():void
		{
			setOrigin(0, 0);
			x += 1;
			y += 1;
			graphic = Image.createCircle(killTimer + 2, 0xFFFFFF);
			if (!killTimer--) world.remove(this);
		}

		
		/**
		 * Check if I'm on the floor
		 */
		protected function checkFloor():void
		{
			onSolid = false;
			for each (var collider:String in collideOn) {
			if (collide(collider, x, y + 1))
				{
					onSolid = true;
					ySpeed = 0;
				}
			}
			
			/*if (STAND_ON_PLATFORMS && (ySpeed >= 0))
			{
				var platform:OneWayPlatform = collide("platform", x, y + Math.max(1, ySpeed)) as OneWayPlatform;
				if (platform) {
					debugpoint1 = platform.y;
					if (platform.y > y -3) platform = null;
				}
				
				if (platform && !dropDown) {
					onSolid=true;
					platform.type = "solid"
				}
				//if (platform && !dropDown) {
					//onSolid = true;
					//
					//var fail:Boolean = false;
					//for each (var c:String in collideOn)
					//{ if (c == "platform"){ fail = true; break; }}
					//
					//if (!fail) collideOn.push("platform");
				//} else collideOn = COLIDE_ON.concat();
			} else collideOn = COLIDE_ON.concat();*/
		}
		override public function render():void 
		{
			super.render();
			//Image.createRect(8,1,0x00FF00).render(FP.buffer,new Point(x,y-3),new Point(FP.camera.x,FP.camera.y))
			//Image.createRect(8,1,0xFF0000).render(FP.buffer,new Point(x,debugpoint1),new Point(FP.camera.x,FP.camera.y))
		}
		/**
		 * Apply the gravity to the ySpeed if the Actor is not on the ground
		 */
		protected function applyGravity():void
		{
			if (onSolid) return;
			
			var g:Number = GRAVITY;
			if (ySpeed < 0 && !isJumping)
			{
				g += FLOAT * FP.elapsed*60;
			}
			
			ySpeed += g * FP.elapsed*60;
			if (ySpeed > MAX_Y_SPEED) ySpeed = MAX_Y_SPEED;
		}
		
		/**
		 * Handle the horizontal speed, including acceleration.
		 */
		protected function handleXSpeed():void
		{
			// handle decelleration
			if (accel == 0)
			{
				xSpeed *= DAMPING;
			}
			
			// handle acceleration
			if (accel != 0)
			{
				if (FP.sign(xSpeed) != FP.sign(accel)) xSpeed *= DAMPING;
				xSpeed += accel * FP.elapsed;
				
				if (accel > 0) { // accelerate right
					if (xSpeed > MAX_HORIZONTAL_SPEED)
					{
						xSpeed = MAX_HORIZONTAL_SPEED;
						if (x % 8 == 0 && onSolid) emitter.emit("dust", x - 8, y - 4);
					}
					else accel = 0;
				} else { // accelerate left
					if (xSpeed < -MAX_HORIZONTAL_SPEED)
					{
						xSpeed = -MAX_HORIZONTAL_SPEED;
						if (x % 8 == 0 && onSolid) emitter.emit("dust", x - 8, y - 4);
					}
					else accel = 0;
				}
			}
		}
		
		/**
		 * Handles jumping.
		 */
		private function jumping():void
		{
			if (onSolid)
			{
				if (jumpOrder)
				{
					collideOn = COLIDE_ON; 
					ySpeed = JUMP_SPEED;
					onSolid = false;
					if (xSpeed < 0 && sprite.flipped) xSpeed *= LEAP;
					else if (xSpeed > 0 && !sprite.flipped) xSpeed *= LEAP;
					
					SCALE.setMotion(1, 1+SQUISHY_RATE, 1, 1, 0.2, Ease.quadIn);
					if (JUMP_ROTATING && Math.abs(xSpeed)>1){
						ROTATE.tween(0, 360 * -FP.sign(xSpeed),
									FP.scale(Math.abs(ySpeed), 0, MAX_Y_SPEED, .7, 0.9),
									Ease.quadInOut);
					}
					
					jumpOrder = false;
				}
			}
		}
		
		/**
		 * Handles animation.
		 */
		private function animation():void
		{
			// control facing direction
			//if (xSpeed != 0) sprite.flipped = xSpeed < 0;
			
			// image scale tweening
			if (BOUNCY){
				sprite.scaleX = SCALE.x;
				sprite.scaleY = SCALE.y;
				SCALE.x = SCALE.y = 1;
			}
			// image rotation
			if (JUMP_ROTATING){
				if (onSolid)
				{
					sprite.angle = 0;
					ROTATE.active = false;
					ROTATE.value = 0;
				}
				else
				{
					sprite.angle = (xSpeed / MAX_HORIZONTAL_SPEED) * 10 + ROTATE.value;
				}
			}
			
		}
		
		/**
		 * Vertical collision handler.
		 */
		override public function moveCollideY(e:Entity):Boolean 
		{	
			var i:int = 5;
			if (ySpeed > 0)
			{
				if (ySpeed > 2) SCALE.setMotion(1 + SQUISHY_RATE, 1, 1, 1, 0.2, Ease.quadIn);
				ySpeed = 0;
				xSpeed /= 2;
				
				while (i--) emitter.emit("smoke", x - 8, y - 2);
				SoundPlayer.playSfx(Assets.SFX_FALL );
			}
			else
			{
				if (ySpeed < 0) SCALE.setMotion(1 + SQUISHY_RATE, 1, 1, 1, 0.2, Ease.quadOut);
				xSpeed /= 2;
				ySpeed = 0;
				
				i = 1;
				while (i--) emitter.emit("dust", x - 8, y - 4);
				SoundPlayer.playSfx(Assets.SFX_STEP );
				
			}
			
			return super.moveCollideY(e);
		}
		
		/**
		 * Horizontal collision handler.
		 */
		override public function moveCollideX(e:Entity):Boolean 
		{
			if (xSpeed > X_BOUNCE_MIN_SPEED || xSpeed < -X_BOUNCE_MIN_SPEED)
			{
				SCALE.setMotion(1, 1 + SQUISHY_RATE, 1, 1, 0.2, Ease.quadIn);
			}
			xSpeed = 0;

			return super.moveCollideX(e);
		}
		
		/**
		 * Ajusts the axis
		 */
		public function adjustAxis():void
		{
			x += sprite.width;
			y += sprite.height;
		}
	}

}