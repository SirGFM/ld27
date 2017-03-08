package collectibles {
	
	import basics.Basic;
	import basics.Collectible;
	import org.flixel.FlxG;
	import utils.Registry;
	import utils.Resources;
	
	/**
	 * ...
	 * @author GFM
	 */
	public class SwitchWeapon extends Collectible {
		
		static public const SHOOTGUN:uint = 0;
		static public const LASER:uint = 1;
		static public const SPIKE:uint = 2;
		static public const SEEK:uint = 3;
		static public const TURRET:uint = 4;
		
		public function SwitchWeapon() {
			super();
			Resources.pupGFX(this);
		}
		
		override public function reset(X:Number, Y:Number):void {
			super.reset(X, Y);
			frame = (FlxG.random() * 10) % 5;
		}
	}
}
