package utils {
	
	import org.flixel.FlxBasic;
	import org.flixel.FlxSprite;
	import org.flixel.FlxText;
	import utils.Registry;
	import utils.Resources;
	
	/**
	 * ...
	 * @author GFM
	 */
	public class StepCounter extends FlxBasic {
		
		static protected const reg:Registry = Registry.self;
		
		public var x:Number;
		public var y:Number;
		private var icon:FlxSprite;
		private var max:int;
		private var cur:int;
		
		public function StepCounter(X:Number, Y:Number, gfx:String="stariconGFX") {
			super();
			x = X;
			y = Y;
			icon = new FlxSprite(X, Y);
			Resources[gfx](icon);
		}
		override public function destroy():void {
			super.destroy();
			icon.destroy();
			icon = null;
		}
		
		override public function draw():void {
			icon.x = x;
			icon.y = y;
			icon.frame = 1;
			var i:int = 0;
			while (i < cur) {
				icon.draw();
				icon.x += icon.width+2;
				i++;
			}
			icon.frame = 0;
			while (i < max) {
				icon.draw();
				icon.x += icon.width+2;
				i++;
			}
		}
		
		public function set width(val:uint):void {
			icon.width = val;
		}
		
		public function setAll(Cur:int, Max:int):void {
			cur = Cur;
			max = Max;
		}
		
		public function dec():Boolean {
			cur--;
			return cur >= 0;
		}
		public function inc():void {
			if (cur < max)
				cur++;
		}
	}
}
