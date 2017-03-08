package plugins {
	
	import org.flixel.FlxBasic;
	import org.flixel.FlxG;
	import org.flixel.FlxText;
	
	/**
	 * ...
	 * @author GFM
	 */
	public class Score extends FlxBasic {
		
		private var label:FlxText;
		private var scoreTxt:FlxText;
		
		private var _curScore:int;
		private var _accScore:Number;
		
		public function Score() {
			super();
			label = new FlxText(201, 4, 100, "SCORE");
			label.shadow = 0x333333;
			scoreTxt = new FlxText(185, 16, 64, "0");
			scoreTxt.shadow = 0x333333;
		}
		override public function destroy():void {
			super.destroy();
			label.destroy();
			scoreTxt.destroy();
			label = null;
			scoreTxt = null;
		}
		
		override public function update():void {
			if (_accScore < _curScore) {
				var delta:Number = _curScore - _accScore;
				
				if (delta < 50)
					_accScore += 100 * FlxG.elapsed;
				else if (delta < 100)
					_accScore += 200 * FlxG.elapsed;
				else
					_accScore += 400 * FlxG.elapsed;
				
				if (_accScore > _curScore)
					_accScore = _curScore;
				
				setText();
			}
		}
		
		override public function draw():void {
			label.draw();
			scoreTxt.draw();
		}
		
		public function inc(val:int):void {
			_curScore += val;
		}
		
		private function setText():void {
			var s:String = _accScore.toFixed(0);
			if (_accScore == 0)
				s = "0000000000";
			while (s.length < 10)
				s = "0"+s;
			scoreTxt.text = s.substr(0, 10);
		}
		
		public function wakeup():void {
			revive();
			_curScore = 0;
			_accScore = 0;
			setText();
		}
	}
}
