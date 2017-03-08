package enemiesPkg {
	
	import basics.Enemy;
	import enShooters.EnTargeted;
	import org.flixel.FlxG;
	import utils.Registry;
	import utils.Resources;
	
	/**
	 * ...
	 * @author GFM
	 */
	public class GoAroundEnemy extends Enemy {
		
		public function GoAroundEnemy() {
			super();
			Resources.enemy1GFX(this);
		}
		
		override public function update():void {
			super.update();
			
			if (y > 224) {
				y = 224;
				velocity.y = 0;
				if (x == 16) {
					velocity.x = Registry.enSpeed*1.25;
					angle = 180;
				}
				else
					velocity.x = -Registry.enSpeed*1.25;
					angle = 0;
			}
			else if (x > 224) {
				x = 224;
				velocity.x = 0;
				velocity.y = -Registry.enSpeed*1.25;
				angle = 90;
			}
			else if (x < 16) {
				x = 16
				velocity.x = 0;
				velocity.y = -Registry.enSpeed*1.25;
				angle = 90;
			}
		}
		
		override public function reset(X:Number, Y:Number):void {
			super.reset(X, Y);
			if (X < FlxG.width / 2)
				x = 16;
			else
				x = 224;
			velocity.y = Registry.enSpeed*1.25;
			if (!shooter)
				shooter = new EnTargeted();
			shooter.revive();
			shooter.setParent(this);
			angle = -90;
		}
	}
}
