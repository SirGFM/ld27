package wavesPkg {
	
	import basics.Spawner;
	import enemiesPkg.GoAroundEnemy;
	import org.flixel.FlxG;
	import utils.Registry;
	
	/**
	 * ...
	 * @author GFM
	 */
	public class Wave03 extends Spawner {
		
		private var X:Number;
		
		override protected function spawn():void {
			var e:GoAroundEnemy = reg.enemies.recycle(GoAroundEnemy) as GoAroundEnemy;
			e.reset(X, -16);
		}
		
		override public function revive():void {
			super.revive();
			wakeup(10, 8, 2.5);
			X = (FlxG.random() * 1000) % CONST::WIDTH;
		}
	}
}
