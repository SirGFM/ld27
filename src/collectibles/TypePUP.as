package collectibles {
	
	import basics.Basic;
	import org.flixel.FlxG;
	import org.flixel.FlxU;
	import utils.Registry;
	import utils.Resources;
	
	/**
	 * ...
	 * @author GFM
	 */
	public class TypePUP extends Basic {
		
		public function TypePUP() {
			super();
			Resources.itemsGFX(this);
		}
		
		override public function update():void {
			super.update();
			
			if (FlxU.abs(velocity.x) > 40)
				acceleration.x *= -1;
		}
		
		override public function reset(X:Number, Y:Number):void {
			super.reset(X, Y);
			frame = (FlxG.random() * 100) % 3;
			maxVelocity.y = 80;
			acceleration.y = 500;
			acceleration.x = 60;
			health = 1000;
			ID = Registry.COLLECTIBLEID;
		}
	}
}
