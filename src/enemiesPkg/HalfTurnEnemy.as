package enemiesPkg {
	
	import basics.Enemy;
	import enShooters.EnShootgun;
	import org.flixel.FlxG;
	import utils.Registry;
	import utils.Resources;
	
	/**
	 * ...
	 * @author GFM
	 */
	public class HalfTurnEnemy extends Enemy {
		
		public function HalfTurnEnemy() {
			super();
			Resources.enemy2GFX(this);
		}
		
		override public function update():void {
			super.update();
			
			if (velocity.x < 0)
				if (velocity.y > 0)
					angle = (-velocity.y / maxVelocity.y) * 90;
				else
					angle = (-velocity.y / maxVelocity.y) * 90;
			else
				if (velocity.y > 0)
					angle = (velocity.y / maxVelocity.y - 2) * 90;
				else
					angle = (velocity.y / maxVelocity.y - 2) * 90;
		}
		
		override public function reset(X:Number, Y:Number):void {
			super.reset(X, Y);
			if (X > CONST::WIDTH/2)
				velocity.x = -reg.enSpeed * 0.175;
			else
				velocity.x = reg.enSpeed * 0.175;
			velocity.y = reg.enSpeed * 1.8;
			maxVelocity.y = reg.enSpeed * 1.8;
			acceleration.y = -reg.enSpeed*1.2;
			if (!shooter)
				shooter = new EnShootgun();
			shooter.revive();
			shooter.setParent(this);
		}
	}
}
