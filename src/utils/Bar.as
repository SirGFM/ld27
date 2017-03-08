package utils {
	
	import org.flixel.FlxSprite;
	
	/**
	 * ...
	 * @author GFM
	 */
	public class Bar extends FlxSprite {
		
		private var obj:Object;
		private var param:String;
		private var maxVal:Number;
		private var curVal:Number;
		
		public function Bar(X:Number, Y:Number, Obj:Object, Param:String, MaxVal:Number, Width:int=200, Height:int=16) {
			super(X, Y);
			
			obj = Obj;
			param = Param;
			maxVal = MaxVal;
			curVal = obj[param];
			
			Resources.barGFX(this, Width, Height);
		}
		
		override public function update():void {
			super.update();
			
			if (curVal != obj[param]) {
				curVal = obj[param];
				updateBar();
			}
		}
		override public function draw():void {
			var w:Number = frameWidth;
			frameWidth = width;
			resetHelpers();
			frame = 1;
			super.draw();
			frame = 0;
			frameWidth = w;
			resetHelpers();
			super.draw();
		}
		
		private function updateBar():void {
			var w:Number;
			
			if (curVal > maxVal)
				curVal = maxVal;
			
			w = curVal / maxVal;
			frameWidth = width * w;
			resetHelpers();
		}
	}
}
