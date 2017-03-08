package basics {
	import collectibles.SwitchWeapon;
	import collectibles.TypePUP;
	import org.flixel.FlxG;
	import utils.Registry;
	
	/**
	 * ...
	 * @author GFM
	 */
	public class Enemy extends Basic {
		
		protected var score:int;
		protected var shooter:Spawner;
		
		public function Enemy() {
			super();
			damage = 1000;
			ID = Registry.ENEMYID;
			score = 21;
		}
		
		override public function update():void {
			super.update();
			if (shooter)
				if (shooter.alive)
					shooter.update();
				else
					shooter.revive();
			
		}
		
		override public function hurt(Damage:Number):void {
			super.hurt(Damage);
			if (!alive) {
				Registry.score.inc(score);
				if (FlxG.random() < 0.3)
					(Registry.collectibles.recycle(TypePUP) as Basic).reset(x + center.x, y + center.y);
				else if (FlxG.random() < 0.2)
					(Registry.collectibles.recycle(SwitchWeapon) as Basic).reset(x + center.x, y + center.y);
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
