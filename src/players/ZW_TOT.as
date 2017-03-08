package players {
	
	import basics.Player;
	import org.flixel.FlxG;
	import plShooters.PlShootgun;
	import utils.Registry;
	import utils.Resources;
	
	/**
	 * ...
	 * @author GFM
	 */
	public class ZW_TOT extends Player {
		
		public function ZW_TOT() {
			super(new PlShootgun());
			Resources.zaWarudoGFX(this);
			canBurnout = false;
		}
		
		override public function update():void {
			if (FlxG.timeScale != 1) {
				var step:uint = 1000 / FlxG.framerate;
				FlxG.elapsed = step/1000;
				FlxG.timeScale = 1.0;
			}
			super.update();
		}
		
		override public function postUpdate():void {
			super.postUpdate();
			if (specialTimer > 8) {
				Registry.plBullets.update();
				FlxG.timeScale = 0.0;
				FlxG.elapsed = 0;
			}
		}
		
		override protected function special():void {
			invunerable = 5;
		}
		
		override public function reset(X:Number, Y:Number):void {
			super.reset(X, Y);
		}
	}
}
