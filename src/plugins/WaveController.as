package plugins {
	
	import basics.Spawner;
	import objs.Boss;
	import org.flixel.FlxBasic;
	import org.flixel.FlxG;
	import org.flixel.FlxObject;
	import org.flixel.FlxText;
	import utils.Bar;
	import utils.Registry;
	import wavesPkg.Wave00;
	import wavesPkg.Wave01;
	import wavesPkg.Wave02;
	import wavesPkg.Wave03;
	
	/**
	 * ...
	 * @author GFM
	 */
	public class WaveController extends FlxBasic {
		
		private var bar:Bar;
		private var bossbar:Bar;
		private var sec:FlxText;
		private var ms:FlxText;
		private var label:FlxText;
		private var _timer:Number;
		private var _timeUntilBoss:Number;
		private var _justentered:Number;
		
		public function WaveController() {
			super();
			
			_timer = 0;
			//bar = new Bar(32, 240, this, "timer", 10, 190);
			bar = new Bar(32, 237, this, "timer", 10, 190);
			label = new FlxText(2, 232, 100, "NEXT\nWAVE");
			label.shadow = 0x333333;
			
			sec = new FlxText(0, 238, 237, "0");
			sec.alignment = "right";
			sec.shadow = 0x333333;
			ms = new FlxText(234, 238, 26, ".0");
			ms.shadow = 0x333333;
			
			_timeUntilBoss = 0;
			kill();
		}
		
		override public function update():void {
			var step:Number = FlxG.elapsed;
			
			if (_justentered > 0) {
				_justentered -= step;
				return;
			}
			
			if (_timeUntilBoss > 0)
				_timeUntilBoss -= step;
			else {
				(Registry.enemies.recycle(Boss) as FlxObject).reset(64, -64);
				label.text = "LAST\nWAVE";
				active = false;
			}
			
			if (_timer > 0) {
				_timer -= step;
				
				var s:int = _timer;
				var str:String = (_timer - s).toFixed(2);
				sec.text = s.toString();
				if (s == 10)
					ms.text = ".00";
				else if (_timer <= 0) {
					sec.text = "0";
					ms.text = ".00";
				}
				else
					ms.text = str.substring(1);
			}
			else {
				var w:Spawner;
				var i:int = (FlxG.random() * 10) % 4;
				switch(i) {
					case 0: w = Registry.waves.recycle(Wave00) as Spawner; break;
					case 1: w = Registry.waves.recycle(Wave01) as Spawner; break;
					case 2: w = Registry.waves.recycle(Wave02) as Spawner; break;
					case 3: w = Registry.waves.recycle(Wave03) as Spawner; break;
				}
				w.revive();
				_timer += 10;
			}
			bar.update();
			bossbar.update();
		}
		override public function draw():void {
			label.draw();
			if (active) {
				bar.draw();
				bossbar.draw();
				sec.draw();
				ms.draw();
			}
		}
		
		public function wakeup(TimeUntilBoss:Number):void {
			revive();
			_timer = 0;
			_timeUntilBoss = TimeUntilBoss;
			if (bossbar)
				bossbar.destroy();
			bossbar = new Bar(34, 247, this, "timeUntilBoss", TimeUntilBoss, 186, 10);
			active = true;
			_justentered = 10;
		}
		
		public function get timer():Number {
			return _timer;
		}
		public function get timeUntilBoss():Number {
			return _timeUntilBoss;
		}
	}
}
