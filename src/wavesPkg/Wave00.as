package wavesPkg {
	
	import basics.Spawner;
	import enemiesPkg.SimpleEnemy;
	import org.flixel.FlxG;
	import utils.Registry;
	
	/**
	 * ...
	 * @author GFM
	 */
	public class Wave00 extends Spawner {
		
		override protected function spawn():void {
			var x:int = (FlxG.random()*100) % 32;
			var e:SimpleEnemy = Registry.enemies.recycle(SimpleEnemy) as SimpleEnemy;
			e.reset(8*x, -16);
		}
		
		override public function revive():void {
			super.revive();
			wakeup(10, 8, 0.75);
		}
	}
}