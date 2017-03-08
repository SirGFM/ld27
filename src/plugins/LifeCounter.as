package plugins {
	
	import org.flixel.FlxBasic;
	import org.flixel.FlxSprite;
	import org.flixel.FlxText;
	import utils.Resources;
	
	/**
	 * ...
	 * @author GFM
	 */
	public class LifeCounter extends FlxBasic {
		
		private var label:FlxText;
		private var life:FlxSprite;
		private var max:int;
		private var cur:int;
		
		public function LifeCounter() {
			super();
			label = new FlxText(16, 4, 100, "LIFES");
			label.shadow = 0x333333;
			life = new FlxSprite(4, 16);
			Resources.lifeiconGFX(life);
		}
		override public function destroy():void {
			super.destroy();
			label.destroy();
			life.destroy();
			label = null;
			life = null;
		}
		
		override public function draw():void {
			label.draw();
			
			life.x = 4;
			life.frame = 0;
			var i:int = 0;
			while (i < cur) {
				life.draw();
				life.x += 10;
				i++;
			}
			life.frame = 1;
			while (i < max) {
				life.draw();
				life.x += 10;
				i++;
			}
		}
		
		public function dec():Boolean {
			cur--;
			return cur >= 0;
		}
		public function inc():void {
			if (cur < max)
				cur++;
		}
		
		public function wakeup(Max:int, Cur:int):void {
			revive();
			max = Max;
			cur = Cur;
		}
	}
}
