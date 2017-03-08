package particlesPkg {
	
	import org.flixel.FlxSprite;
	import utils.Registry;
	import utils.Resources;
	import utils.Sounds;
	
	/**
	 * ...
	 * @author GFM
	 */
	public class MyParticle extends FlxSprite {
		
		static protected var reg:Registry = Registry.self;
		
		public function MyParticle() {
			super();
			allowCollisions = NONE;
			Resources.hitGFX(this);
		}
		
		override public function update():void {
			super.update();
			if (finished)
				kill();
		}
		
		override public function revive():void {
			super.revive();
			allowCollisions = NONE;
		}
	}
}
