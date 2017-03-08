package wavesPkg {
	
	import basics.Spawner;
	import enemiesPkg.BasicEnemy;
	import org.flixel.FlxG;
	import utils.Registry;
	
	/**
	 * ...
	 * @author GFM
	 */
	public class Wave01 extends Spawner {
		
		private var X:Number;
		
		override protected function spawn():void {
			var e:BasicEnemy = Registry.enemies.recycle(BasicEnemy) as BasicEnemy;
			e.reset(X, -16);
			e = Registry.enemies.recycle(BasicEnemy) as BasicEnemy;
			e.reset(X+20, -16);
		}
		
		override public function revive():void {
			super.revive();
			wakeup(10, 7, 1);
			if (FlxG.random() > 0.5)
				X = 10;
			else
				X = FlxG.width - 36;
		}
	}
}
