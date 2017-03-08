package basics {
	
	import org.flixel.FlxBasic;
	import org.flixel.FlxG;
	import org.flixel.FlxObject;
	import org.flixel.FlxState;
	import utils.Registry;
	
	/**
	 * ...
	 * @author GFM
	 */
	public class SlideState extends FlxState {
		
		static protected var reg:Registry = Registry.self;
		
		static public const LEFT:uint = 1;
		static public const RIGHT:uint = 2;
		static public const UP:uint = 4;
		static public const DOWN:uint = 8;
		
		public var canDestroy:Boolean;
		
		private var x:Number;
		private var y:Number;
		protected var _prev:SlideState;
		private var _complete:Boolean;
		private var _dir:uint;
		
		public function SlideState(Previous:SlideState = null, Direction:uint = LEFT) {
			super();
			x = 0;
			y = 0;
			_prev = Previous;
			if (_prev) {
				_prev.canDestroy = false;
				_prev._dir = Direction;
			}
			_dir = Direction;
			_complete = false;
			canDestroy = true;
		}
		override public function destroy():void {
			if (canDestroy)
				super.destroy();
		}
		
		override public function create():void {
			if (_prev) {
				if (_dir == LEFT)
					setRight();
				else if (_dir == RIGHT)
					setLeft();
				else if (_dir == UP)
					setUp();
				else if (_dir == DOWN)
					setDown();
			}
			else
				_complete = true;
		}
		
		override public function update():void {
			if (_prev) {
				if (_prev.slide(true)) {
					_prev.canDestroy = true;
					_prev.destroy();
					_prev = null;
				}
			}
			if (!_complete)
				if (slide(false)) {
					_complete = true;
					onCompleteSlide();
				}
			
			super.update();
		}
		override public function draw():void {
			if (_prev)
				_prev.draw();
			super.draw();
		}
		
		protected function onCompleteSlide():void { }
		
		public function slide(toOutside:Boolean = true, v:Number = CONST::WIDTH):Boolean {
			var vx:Number = 0;
			var vy:Number = 0;
			
			v *= FlxG.elapsed;
			if (_dir == LEFT)
				vx = -v;
			else if (_dir == RIGHT)
				vx = v;
			else if (_dir == UP)
				vy = -v;
			else if (_dir == DOWN)
				vy = v;
			
			for each (var item:FlxBasic in members) {
				var o:FlxObject = item as FlxObject;
				if (o) {
					o.x += vx;
					o.y += vy;
					o.update();
				}
			}
			x += vx;
			y += vy;
			
			var b:Boolean;
			b = toOutside && (
					(_dir == LEFT) && x <= -CONST::WIDTH ||
					(_dir == RIGHT) && x >= CONST::WIDTH ||
					(_dir == UP) && y <= -CONST::HEIGHT ||
					(_dir == DOWN) && y >= CONST::HEIGHT);
			b = b || !toOutside && (
					(_dir == LEFT) && x <= 0 ||
					(_dir == RIGHT) && x >= 0 ||
					(_dir == UP) && y <= 0 ||
					(_dir == DOWN) && y >= 0);
			
			return b;
		}
		
		public function setLeft():void {
			for each (var item:FlxBasic in members) {
				var o:FlxObject = item as FlxObject;
				if (o) {
					o.x -= CONST::WIDTH;
					o.update();
				}
			}
			x -= CONST::WIDTH;
		}
		public function setRight():void {
			for each (var item:FlxBasic in members) {
				var o:FlxObject = item as FlxObject;
				if (o) {
					o.x += CONST::WIDTH;
					o.update();
				}
			}
			x += CONST::WIDTH;
		}
		public function setDown():void {
			for each (var item:FlxBasic in members) {
				var o:FlxObject = item as FlxObject;
				if (o) {
					o.y -= CONST::HEIGHT;
					o.update();
				}
			}
			y -= CONST::HEIGHT;
		}
		public function setUp():void {
			for each (var item:FlxBasic in members) {
				var o:FlxObject = item as FlxObject;
				if (o) {
					o.y += CONST::HEIGHT;
					o.update();
				}
			}
			y += CONST::HEIGHT;
		}
	}
}
