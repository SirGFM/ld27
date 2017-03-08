package basics {
	import collectibles.SwitchWeapon;
	import collectibles.TypePUP;
	import org.flixel.FlxG;
	import particlesPkg.ThrottleEmitter;
	import utils.Registry;
	
	/**
	 * ...
	 * @author GFM
	 */
	public class Enemy extends Basic {
		
		protected var score:int;
		protected var shooter:Spawner;
		
		protected var _throttle:ThrottleEmitter;
		
		public function Enemy(hasThrottle:Boolean = true, offsetY:Number = 0) {
			super();
			damage = 1000;
			ID = CONST::ENEMYID;
			score = 21;
			
			if (hasThrottle)
				_throttle = new ThrottleEmitter(true, 1, 3, offsetY);
		}
		override public function destroy():void {
			super.destroy();
			if (_throttle)
				_throttle.destroy();
			_throttle = null;
		}
		
		override public function update():void {
			super.update();
			if (shooter)
				if (shooter.alive)
					shooter.update();
				else
					shooter.revive();
			if (_throttle)
				_throttle.updateEmitter(this);
		}
		override public function draw():void {
			if (_throttle)
				_throttle.draw();
			super.draw();
		}
		
		override public function hurt(Damage:Number):void {
			super.hurt(Damage);
			if (!alive) {
				reg.score.inc(score);
				if (FlxG.random() < 0.3)
					(reg.collectibles.recycle(TypePUP) as Basic).reset(x + center.x, y + center.y);
				else if (FlxG.random() < 0.2)
					(reg.collectibles.recycle(SwitchWeapon) as Basic).reset(x + center.x, y + center.y);
			}
		}
		
		override public function revive():void {
			super.revive();
			health = 1;
			velocity.make();
			acceleration.make();
			maxVelocity.make(10000, 10000);
			angle = -90;
		}
	}
}
