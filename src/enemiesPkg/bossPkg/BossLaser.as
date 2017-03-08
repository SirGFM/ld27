package enemiesPkg.bossPkg {
	
	import basics.Enemy;
	import enShooters.bossShooters.bsShLaser;
	import org.flixel.FlxPoint;
	
	/**
	 * ...
	 * @author GFM
	 */
	public class BossLaser extends Enemy {
		
		public var adjust:FlxPoint;
		
		public function BossLaser(X:Number, Y:Number) {
			super();
			moves = false;
			adjust = new FlxPoint(X, Y);
			if (!shooter)
				shooter = new bsShLaser();
			shooter.setParent(this);
			health = 30;
		}
		override public function destroy():void {
			super.destroy();
			adjust = null;
		}
		
		override public function reset(X:Number, Y:Number):void {
			super.reset(X, Y);
			moves = false;
			shooter.setParent(this);
			health = 30;
		}
	}
}
