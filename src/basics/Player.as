package basics {
	
	import collectibles.SwitchWeapon;
	import org.flixel.FlxG;
	import org.flixel.FlxPoint;
	import org.flixel.FlxSprite;
	import org.flixel.FlxU;
	import particlesPkg.ThrottleEmitter;
	import plShooters.PlLaserBurst;
	import plShooters.PlSeeker;
	import plShooters.PlShootgun;
	import plShooters.PlSpike;
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
		
		private var _invunerable:Number;
		private var _type:uint;
		
		private var timer:Number;
		private var shooter:Spawner;
		private var mainShooter:uint;
		private var curShooter:uint;
		
		protected var specialTimer:Number;
		
		protected var _throttle:ThrottleEmitter;
		private var _hitbox:FlxSprite;
		
		public function Player(Shooter:uint = 0xffffffff) {
			super();
			
			ID = CONST::PLAYERID;
			
			curShooter = 0xffffffff;
			if (Shooter == 0xffffffff)
				Shooter = SwitchWeapon.TURRET;
			weapon = Shooter;
			mainShooter = Shooter;
			
			specialTimer = 0;
			type = 0;
			_throttle = new ThrottleEmitter(false, 0.25, 0.33, 8);
			
			_hitbox = new FlxSprite();
			_hitbox.visible = false;
			_hitbox.moves = false;
			Resources.hitboxGFX(_hitbox);
			var str:String = FlxU.getClassName(this, true);
			_hitbox.play(str);
		}
		override public function destroy():void {
			super.destroy();
			shooter.destroy();
			shooter = null;
			_throttle.destroy();
			_throttle = null;
			_hitbox.destroy();
			_hitbox = null;
		}
		
		override public function update():void {
			var step:Number = FlxG.elapsed;
			
			manageMovement();
			
			if (timer > 0) {
				if (shooter.alive)
					shooter.update();
				timer -= step;
			}
			else if (FlxG.keys.pressed(reg.shoot)) {
				shooter.revive();
				timer += shooter.time;
			}
			
			if (specialTimer <= 0) { 
				if (!reg.specialCounter.isEnabled)
					reg.specialCounter.startCooldown();
				else if (FlxG.keys.justPressed(reg.special)) {
					specialTimer = 10;
					reg.specialCounter.activate();
					// TODO enable special again
					//special();
				}
			}
			else {
				specialTimer -= step;
			}
			
			if (_invunerable > 0) {
				_invunerable -= step;
			}
			else if (_invunerable > -1) {
				flicker(0);
				_invunerable = -1;
				allowCollisions = ANY;
			}
			
			_throttle.updateEmitter(this);
			
			manageAnimations();
		}
		
		override public function postUpdate():void {
			super.postUpdate();
			if (x < 0)
				x = 0;
			else if (x + width > CONST::WIDTH)
				x = CONST::WIDTH - width;
			if (y < 0)
				y = 0;
			else if (y + height > CONST::HEIGHT)
				y = CONST::HEIGHT - height;
		}
		
		override public function draw():void {
			_throttle.draw();
			super.draw();
			if (_hitbox.visible) {
				_hitbox.x = x + 8;
				_hitbox.y = y + 8;
				_hitbox.postUpdate();
				_hitbox.draw();
			}
		}
		
		private function manageMovement():void {
			var vx:Number = 0;
			var vy:Number = 0;
			var speed:Number = reg.plSpeed
			
			if (FlxG.keys.pressed(reg.left))
				vx = -speed;
			else if (FlxG.keys.pressed(reg.right))
				vx = speed;
			if (FlxG.keys.pressed(reg.up))
				vy = -speed;
			else if (FlxG.keys.pressed(reg.down))
				vy = speed;
			
			if (vx != 0 && vy != 0) {
				// sqrt(2) = 1.414
				// sin(45) = cos(45) = aprox 0.707
				vx *= 0.707;
				vy *= 0.707;
			}
			_hitbox.visible = FlxG.keys.pressed(reg.focus);
			if (_hitbox.visible) {
				vx *= 0.5;
				vy *= 0.5;
			}
			
			velocity.x = vx;
			velocity.y = vy;
		}
		private function manageAnimations():void {
			if (velocity.x > 0)
				play("right");
			else if (velocity.x < 0)
				play("left");
			else
				play("def");
		}
		
		override public function kill():void {
			super.kill();
			if (reg.lifeCounter.dec()) {
				reset(128, 200);
				invunerable = 3;
			}
		}
		
		public function get type():uint {
			return _type;
		}
		public function set type(val:uint):void {
			if (val != LIFE)
				_type = val;
			
			if (val == POWER)
				reg.plDamage = 0.5;
			else
				reg.plDamage = 0.25;
			
			if (val == AGI)
				reg.plSpeed = 150;
			else
				reg.plSpeed = 100;
			
			if (val == LIFE)
				reg.lifeCounter.inc();
			
			Sounds.playPUP();
		}
		
		public function set weapon(val:uint):void {
			if (val == curShooter)
				return;
			if (shooter) {
				shooter.destroy();
				Sounds.playWeapon();
			}
			if (val == SwitchWeapon.TURRET)
				shooter = new PlTurret();
			else if (val == SwitchWeapon.SHOOTGUN)
				shooter = new PlShootgun();
			else if (val == SwitchWeapon.LASER)
				shooter = new PlLaserBurst();
			else if (val == SwitchWeapon.SEEK)
				shooter = new PlSeeker();
			else if (val == SwitchWeapon.SPIKE)
				shooter = new PlSpike();
			curShooter = val;
		}
		
		protected function special():void { }
		
		protected function set invunerable(val:Number):void {
			_invunerable = val;
			flicker(-1);
			allowCollisions = NONE;
		}
		
		override public function reset(X:Number, Y:Number):void {
			super.reset(X, Y);
			timer = 0;
			health = reg.plHealth;
			damage = 1;
			specialTimer = 0;
			type = NOTYPE;
			
			if (reg.specialCounter)
				reg.specialCounter.wakeup();
			
			weapon = mainShooter;
		}
	}
}
