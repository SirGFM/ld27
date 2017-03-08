package plugins {
	
	import org.flixel.FlxBasic;
	import org.flixel.FlxG;
	import org.flixel.FlxText;
	
	/**
	 * ...
	 * @author GFM
	 */
	public class SpecialCounter extends FlxBasic {
		
		private var inUse:Boolean;
		private var dec:Boolean;
		private var cooldown:Number;
		private var label:FlxText;
		private var inc:Boolean;
		public var autoIncrease:Boolean;
		
		public function SpecialCounter() {
			super();
			label = new FlxText(0, 4, 256, "SPECIAL");
			label.alignment = "center";
			label.shadow = 0x333333;
			inc = true;
			dec = false;
			inUse = false;
			cooldown = 0;
			autoIncrease = true;
		}
		
		// TODO remove comments here
		
		override public function update():void {
			/*if (isEnabled) {
				if (inc)
					label.alpha += FlxG.elapsed * 2.5;
				else
					label.alpha -= FlxG.elapsed * 2.5;
				if (label.alpha == 1 || label.alpha == 0)
					inc = !inc;
			}
			else if (dec && autoIncrease) {
				cooldown -= FlxG.elapsed;
				label.alpha = 1.1 -  cooldown * 0.09;
				if (cooldown <= 0)
					dec = false;
			}*/
		}
		override public function draw():void {
			//label.draw();
		}
		
		public function get isEnabled():Boolean {
			return !(inUse || dec);
		}
		public function startCooldown():void {
			if (!dec) {
				cooldown = 10;
				dec = true;
				inUse = false;
			}
		}
		public function activate():void {
			inUse = true;
			label.alpha = 0.1;
		}
		
		public function wakeup():void {
			revive();
			inc = false;
			label.alpha = 1;
			cooldown = 0;
			dec = false;
			inUse = false;
		}
	}
}
