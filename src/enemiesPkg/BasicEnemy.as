package enemiesPkg {
	
	import basics.Enemy;
	import enShooters.EnTurret;
	import org.flixel.FlxG;
	import utils.Registry;
	import utils.Resources;
	
	/**
	 * ...
	 * @author GFM
	 */
	public class BasicEnemy extends Enemy {
		
		public function BasicEnemy() {
			super();
			Resources.enemy1GFX(this);
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
			if (X > FlxG.width / 2)
				velocity.x = -Registry.enSpeed*0.8;
			else
				velocity.x = Registry.enSpeed*0.8;
			velocity.y = Registry.enSpeed * 1.5;
			maxVelocity.y = Registry.enSpeed * 1.5;
			acceleration.y = -Registry.enSpeed*0.75;
			if (!shooter)
				shooter = new EnTurret();
			shooter.revive();
			shooter.setParent(this);
			health = 0.75;
		}
	}
}
