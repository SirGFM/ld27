package basics {
	
	import org.flixel.FlxBasic;
	import org.flixel.FlxG;
	import org.flixel.FlxObject;
	
	/**
	 * ...
	 * @author GFM
	 */
	public class Spawner extends FlxBasic {
		
		private var _time:Number;
		private var maxSpawnTime:Number;
		private var spawnDelay:Number;
		
		public function Spawner() {
			super();
		}
		
		override public function update():void {
			var step:Number = FlxG.elapsed;
			_time -= step;
			if (_time > 0) {
				if ((_time > maxSpawnTime) && ((_time % spawnDelay) <= step))
					spawn();
			}
			else
				kill();
		}
		
		protected function spawn():void { }
		
		protected function wakeup(Time:Number, MaxSpawnTime:Number, SpawnDelay:Number):void {
			_time = Time;
			maxSpawnTime = Time - MaxSpawnTime;
			spawnDelay = SpawnDelay;
		}
		
		public function get time():Number {
			return _time;
		}
		
		public function setParent(o:FlxObject):void { }
	}
}
