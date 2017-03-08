package wavesPkg {
	
	import basics.Spawner;
	import enemiesPkg.HalfTurnEnemy;
	import org.flixel.FlxG;
	import utils.Registry;
	
	/**
	 * ...
	 * @author GFM
	 */
	public class Wave02 extends Spawner {
		
		override protected function spawn():void {
			var e:HalfTurnEnemy = Registry.enemies.recycle(HalfTurnEnemy) as HalfTurnEnemy;
			var i:int = (FlxG.random() * 100) % 16;
			e.reset(16*i, -16);
		}
		
		override public function revive():void {
			super.revive();
			wakeup(10, 6, 1);
		}
	}
}