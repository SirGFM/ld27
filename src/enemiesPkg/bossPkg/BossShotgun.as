package enemiesPkg.bossPkg {
	
	import basics.Enemy;
	import enShooters.bossShooters.bsShShootgun;
	import org.flixel.FlxPoint;
	
	/**
	 * ...
	 * @author GFM
	 */
	public class BossShotgun extends Enemy {
		
		public var adjust:FlxPoint;
		
		
		public function BossShotgun(X:Number, Y:Number) {
			super();
			moves = false;
			adjust = new FlxPoint(X, Y);
			if (!shooter) {
				shooter = new bsShShootgun();
			}
			shooter.setParent(this);
			health = 30;
		}
		override public function destroy():void {
			super.destroy();
			adjust = null;
		}
		
		override public function update():void {
			if (finished)
				super.update();
		}
		
		override public function reset(X:Number, Y:Number):void {
			super.reset(X, Y);
			moves = false;
			if (!shooter) {
				shooter = new bsShShootgun();
			}
			shooter.setParent(this);
			health = 30;
		}
	}
}
