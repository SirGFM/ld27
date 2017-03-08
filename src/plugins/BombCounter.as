package plugins {
	
	import org.flixel.FlxText;
	import utils.StepCounter;
	
	/**
	 * ...
	 * @author GFM
	 */
	public class BombCounter extends StepCounter {
		
		private var label:FlxText;
		
		public function BombCounter() {
			super(64, 16, "bombiconGFX");
			label = new FlxText(76, 4, 100, "SPECIALS");
			label.shadow = 0x333333;
		}
		override public function destroy():void {
			super.destroy();
			label.destroy();
			label = null;
		}
		
		// TODO remove comments here
		override public function draw():void {
			//label.draw();
			//super.draw();
		}
	}
}
