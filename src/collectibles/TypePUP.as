package collectibles {
	
	import basics.Basic;
	import basics.Collectible;
	import org.flixel.FlxG;
	import org.flixel.FlxU;
	import utils.Registry;
	import utils.Resources;
	
	/**
	 * ...
	 * @author GFM
	 */
	public class TypePUP extends Collectible {
		
		public function TypePUP() {
			super();
			Resources.itemsGFX(this);
		}
		
		override public function reset(X:Number, Y:Number):void {
			super.reset(X, Y);
			frame = (FlxG.random() * 100) % 3;
		}
	}
}
