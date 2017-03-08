package enemiesPkg.bossPkg {
	
	import basics.Enemy;
	import enShooters.bossShooters.bsShSpread;
	import org.flixel.FlxPoint;
	
	/**
	 * ...
	 * @author GFM
	 */
	public class BossSpread extends Enemy {
		
		public var adjust:FlxPoint;
		
		public function BossSpread(X:Number, Y:Number) {
			super();
			moves = false;
			adjust = new FlxPoint(X, Y);
			if (!shooter)
				shooter = new bsShSpread();
			shooter.setParent(this);
			health = 22.5;
		}
		override public function destroy():void {
			super.destroy();
			adjust = null;
		}
		
		override public function reset(X:Number, Y:Number):void {
			super.reset(X, Y);
			moves = false;
			if (!shooter)
				shooter = new bsShSpread();
			shooter.setParent(this);
			health = 22.5;
		}
	}
}
