package basics {
	
	import org.flixel.FlxG;
	import org.flixel.FlxPoint;
	import org.flixel.FlxSprite;
	import plShooters.PlShootgun;
	import plShooters.PlTurret;
	import utils.Registry;
	import utils.Resources;
	import utils.Sounds;
	
	/**
	 * ...
	 * @author GFM
	 */
	public class Player extends Basic {
		
		static public const NOTYPE:uint = 0xff;
		static public const POWER:uint = 0x0;
		static public const AGI:uint = 0x1;
		static public const LIFE:uint = 0x2;
		
		static public const TURRET:uint = 0x0;
		static public const SHOOTGUN:uint = 0x1;
		
		private var _invunerable:Number;
		private var _type:uint;
		
		private var timer:Number;
		private var shooter:Spawner;
		
		protected var canBurnout:Boolean;
		private var shootingTime:Number;
		private var burnout:Number;
		
		protected var specialTimer:Number;
		
		public function Player(Shooter:Spawner = null) {
			super();
			Resources.playerGFX(this);
			ID = Registry.PLAYERID;
			if (Shooter == null)
				shooter = new PlTurret();
			else
				shooter = Shooter;
			specialTimer = 0;
			shootingTime = 0;
			burnout = 0;
			canBurnout = true;
			type = 0;
		}
		override public function destroy():void {
			super.destroy();
			shooter.destroy();
			shooter = null;
		}
		
		override public function update():void {
			var step:Number = FlxG.elapsed;
			
			manageMovement();
			
			if (timer > 0) {
				if (shooter.alive)
					shooter.update();
				timer -= step;
			}
			else if (burnout <= 0 && FlxG.keys.pressed(Registry.shoot)) {
				shooter.revive();
				timer += shooter.time;
			}
			
			if (canBurnout)
				manageBurnout(step);
			
			if (specialTimer <= 0) { 
				if (!Registry.specialCounter.isEnabled)
					Registry.specialCounter.startCooldown();
				else if (FlxG.keys.justPressed(Registry.special)) {
					specialTimer = 10;
					Registry.specialCounter.activate();
					special();
				}
			}
			else {
				specialTimer -= step;
			}
			
			if (_invunerable > 0) {
				_invunerable -= step;
				burnout = 0;
				shootingTime = 0;
				calcColorShooting();
			}
			else if (_invunerable > -1) {
				flicker(0);
				_invunerable = -1;
				allowCollisions = ANY;
			}
			
			manageAnimations();
		}
		
		override public function postUpdate():void {
			super.postUpdate();
			if (x < 0)
				x = 0;
			else if (x + width > FlxG.width)
				x = FlxG.width - width;
			if (y < 0)
				y = 0;
			else if (y + height > FlxG.height)
				y = FlxG.height - height;
		}
		
		private function manageMovement():void {
			if (FlxG.keys.pressed(Registry.left))
				velocity.x = -Registry.plSpeed;
			else if (FlxG.keys.pressed(Registry.right))
				velocity.x = Registry.plSpeed;
			else
				velocity.x = 0;
			if (FlxG.keys.pressed(Registry.up))
				velocity.y = -Registry.plSpeed;
			else if (FlxG.keys.pressed(Registry.down))
				velocity.y = Registry.plSpeed;
			else
				velocity.y = 0;
		}
		private function manageAnimations():void {
			if (velocity.x > 0)
				play("right");
			else if (velocity.x < 0)
				play("left");
			else
				play("def");
		}
		
		private function manageBurnout(step:Number):void {
			if (shootingTime >= 10) {
				burnout = 10;
				shootingTime = 0;
				shooter.kill();
			}
			if (burnout > 0) {
				burnout -= step;
				var j:int = 0xff * (1 - burnout / 10);
				color = 0xffff0000 + 0x101*j;
			}
			
			if (shooter.alive) {
				shootingTime += step;
				calcColorShooting();
			}
			else if (shootingTime != 0 && !FlxG.keys.pressed(Registry.shoot)) {
				shootingTime -= step;
				if (shootingTime < 0)
					shootingTime = 0;
				calcColorShooting();
			}
		}
		private function calcColorShooting():void {
			var i:int = shootingTime;
			var f:Number = 10 - shootingTime - i;
			f *= 10;
			f %= i+1;
			f /= 10;
			i = f * 0xff & 0xff;
			var ni:int = 0xff * (1 - f) & 0xff;
			color = 0xffff0000+0x101*ni;
		}
		
		override public function kill():void {
			super.kill();
			if (Registry.lifeCounter.dec()) {
				reset(128, 200);
				invunerable = 3;
			}
		}
		
		protected function special():void {
			invunerable = 10;
		}
		
		public function get type():uint {
			return _type;
		}
		public function set type(val:uint):void {
			if (val != LIFE)
				_type = val;
			
			if (val == POWER)
				Registry.plDamage = 0.5;
			else
				Registry.plDamage = 0.25;
			
			if (val == AGI)
				Registry.plSpeed = 150;
			else
				Registry.plSpeed = 100;
			
			if (val == LIFE)
				Registry.lifeCounter.inc();
			
			Sounds.playPUP();
		}
		
		public function set weapon(val:uint):void {
			if (val == TURRET && !(shooter is PlTurret)) {
				shooter.destroy();
				shooter = new PlTurret();
				Sounds.playWeapon();
			}
			else if (val == SHOOTGUN && !(shooter is PlShootgun)) {
				shooter.destroy();
				shooter = new PlShootgun();
				Sounds.playWeapon();
			}
		}
		
		protected function set invunerable(val:Number):void {
			_invunerable = val;
			flicker(-1);
			allowCollisions = NONE;
		}
		
		override public function reset(X:Number, Y:Number):void {
			super.reset(X, Y);
			timer = 0;
			health = Registry.plHealth;
			damage = 1;
			specialTimer = 0;
			shootingTime = 0;
			burnout = 0;
			type = NOTYPE;
			calcColorShooting();
			
			if (Registry.specialCounter)
				Registry.specialCounter.wakeup();
			
			shooter.kill();
			if (!(shooter is PlTurret)) {
				shooter.destroy();
				shooter = new PlTurret();
			}
		}
	}
}
