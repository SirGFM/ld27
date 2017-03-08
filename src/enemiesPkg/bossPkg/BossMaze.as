package enemiesPkg.bossPkg {
	
	import basics.Enemy;
	import enShooters.bossShooters.bsShMaze;
	import org.flixel.FlxPoint;
	
	/**
	 * ...
	 * @author GFM
	 */
	public class BossMaze extends Enemy {
		
		public var adjust:FlxPoint;
		
		public function BossMaze(X:Number, Y:Number, Left:Boolean = false) {
			super();
			moves = false;
			adjust = new FlxPoint(X, Y);
			if (!shooter)
				shooter = new bsShMaze(Left);
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
			shooter.setParent(this);
			health = 22.5;
		}
	}
}
