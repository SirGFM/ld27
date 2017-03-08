package enemiesPkg.boss01 {
	
	import basics.Boss;
	import org.flixel.FlxU;
	import utils.Resources;
	
	/**
	 * ...
	 * @author GFM
	 */
	public class Boss01 extends Boss {
		
		private var _justEntered:Boolean;
		
		public function Boss01() {
			super(10);
			Resources.bossGFX(this);
			addWeapon(new Boss01Spread());
			addWeapon(new Boss01Maze());
			addWeapon(new Boss01Shootgun());
			addWeapon(new Boss01Laser());
		}
		
		override public function update():void {
			if (_justEntered) {
				velocity.y = 64 / 3;
				if (y > 32) {
					velocity.y = -15;
					velocity.x = -50;
					_justEntered = false;
					acceleration.x = 20;
					acceleration.y = 20;
				}
				return;
			}
			else {
				if (FlxU.abs(velocity.x) > 50)
					acceleration.x *= -1;
				if (FlxU.abs(velocity.y) > 25)
					acceleration.y *= -1;
			}
			
			super.update();
		}
		
		override public function reset(X:Number, Y:Number):void {
			super.reset(X, Y);
			_justEntered = true;
		}
	}
}
