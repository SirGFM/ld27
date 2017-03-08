package enemiesPkg {
	
	import basics.Basic;
	import basics.Enemy;
	import basics.Spawner;
	import enShooters.EnWeakTurret;
	import utils.Registry;
	import utils.Resources;
	
	/**
	 * ...
	 * @author GFM
	 */
	public class SimpleEnemy extends Enemy {
		
		public function SimpleEnemy() {
			super();
			Resources.enemy3GFX(this);
		}
		
		override public function reset(X:Number, Y:Number):void {
			super.reset(X, Y);
			velocity.y = Registry.enSpeed;
			if (!shooter)
				shooter = new EnWeakTurret();
			shooter.revive();
			shooter.setParent(this);
			health = 0.8;
		}
	}
}
