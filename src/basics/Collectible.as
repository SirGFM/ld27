package basics {
	
	import org.flixel.FlxG;
	import org.flixel.FlxU;
	import utils.Registry;
	
	/**
	 * ...
	 * @author GFM
	 */
	public class Collectible extends Basic {
		
		override public function update():void {
			super.update();
			
			if (y > CONST::HEIGHT + 32)
				kill();
			else if (FlxU.abs(velocity.x) > 40)
				acceleration.x *= -1;
		}
		
		override public function reset(X:Number, Y:Number):void {
			super.reset(X, Y);
			maxVelocity.y = 80;
			acceleration.y = 500;
			acceleration.x = 60;
			health = 1000;
			ID = CONST::COLLECTIBLEID;
		}
	}
}
