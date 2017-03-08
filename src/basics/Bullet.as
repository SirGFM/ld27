package basics {
	
	import org.flixel.FlxG;
	import org.flixel.FlxSprite;
	import utils.Sounds;
	
	/**
	 * ...
	 * @author GFM
	 */
	public class Bullet extends Basic {
		
		public function Bullet() {
			super();
		}
		
		override public function reset(X:Number, Y:Number):void {
			super.reset(X, Y);
			health = 1000;
			damage = 1;
			Sounds.playShoot();
		}
	}
}
