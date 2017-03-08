package collectibles {
	
	import basics.Basic;
	import org.flixel.FlxG;
	import utils.Registry;
	import utils.Resources;
	
	/**
	 * ...
	 * @author GFM
	 */
	public class SwitchWeapon extends Basic {
		
		public function SwitchWeapon() {
			super();
			Resources.pupGFX(this);
		}
		
		override public function reset(X:Number, Y:Number):void {
			super.reset(X, Y);
			frame = (FlxG.random() * 10) % 2;
			maxVelocity.y = 80;
			acceleration.y = 500;
			acceleration.x = 60;
			health = 1000;
			ID = Registry.COLLECTIBLEID;
		}
	}
}
