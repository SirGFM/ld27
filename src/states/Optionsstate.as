package states {
	
	import basics.SlideState;
	import flash.events.KeyboardEvent;
	import org.flixel.FlxG;
	import org.flixel.FlxSprite;
	import org.flixel.FlxState;
	import org.flixel.FlxText;
	import org.flixel.FlxU;
	import utils.Registry;
	import utils.Resources;
	import utils.Sounds;
	
	/**
	 * ...
	 * @author GFM
	 */
	public class Optionsstate extends SlideState {
		
		private var complete:Boolean;
		
		public var letters:Vector.<FlxSprite>;
		private var opts:Vector.<FlxText>;
		private var cur:int;
		private var back:int;
		
		public function Optionsstate(Previous:Menustate) {
			super(Previous, RIGHT);
			
			letters = new Vector.<FlxSprite>();
			opts = new Vector.<FlxText>();
		}
		override public function destroy():void {
			if (canDestroy) {
				super.destroy();
				while (letters.length > 0)
					letters.pop();
				letters = null;
				while (opts.length > 0)
					opts.pop();
				opts = null;
			}
		}
		
		override public function create():void {
			var step:Number = FlxG.elapsed;
			
			letters.push(add(new FlxSprite(12, 18)));
			letters.push(add(new FlxSprite(45, 18)));
			letters.push(add(new FlxSprite(85, 18)));
			letters.push(add(new FlxSprite(111, 18)));
			letters.push(add(new FlxSprite(130, 18)));
			letters.push(add(new FlxSprite(163, 18)));
			letters.push(add(new FlxSprite(196, 18)));
			
			var i:int = 0;
			while (i < 7) {
				letters[i].velocity.y = 20;
				letters[i].acceleration.y = 75;
				var t:Number = 0.2 * i;
				while (t > 0) {
					letters[i].postUpdate();
					updateAnimation();
					t -= step;
				}
				i++;
			}
			Resources.optionsGFX(this);
			
			addText(52, 83, "LIFE:");
			addText(49, 106, "MUSIC:");
			addText(59, 128, "SFX:");
			addText(12, 152, "UPDATE RATE:");
			addText(23, 175, "DRAW RATE:");
			
			opts.push(addText(89, 83, "1"));
			opts.push(addText(102, 83, "2"));
			opts.push(addText(117, 83, "3"));
			opts.push(addText(132, 83, "4"));
			opts.push(addText(142, 83, "5"));
			
			opts.push(addText(89, 106, "OFF"));
			opts.push(addText(117, 106, "25%"));
			opts.push(addText(145, 106, "50%"));
			opts.push(addText(173, 106, "75%"));
			opts.push(addText(201, 106, "100%"));
			
			opts.push(addText(89, 128, "OFF"));
			opts.push(addText(117, 128, "25%"));
			opts.push(addText(145, 128, "50%"));
			opts.push(addText(173, 128, "75%"));
			opts.push(addText(201, 128, "100%"));
			
			opts.push(addText(89, 152, "30"));
			opts.push(addText(110, 152, "60"));
			
			opts.push(addText(89, 175, "30"));
			opts.push(addText(110, 175, "60"));
			
			opts.push(addText(94, 198, "RESET DATA"));
			
			opts.push(addText(80, 221, "BACK"));
			opts.push(addText(134, 221, "DEFAULT"));
			
			setText();
			complete = false;
			cur = 0;
			back = 0;
			super.create();
		}
		
		override public function update():void {
			updateAnimation();
			
			super.update();
			reg.menuBg.update();
			
			checkMouseOver();
			
			var pressed:Boolean = (FlxG.keys.justPressed("ENTER") || FlxG.keys.justPressed("X") || FlxG.keys.justPressed("SPACE"));
			
			if (cur == 6 && back == 0 && pressed) {
				onBack();
			}
			else if (cur == 6 && back == 1 && pressed) {
				onDefault();
			}
			else if (cur == 5 && pressed) {
				onReset();
			}
		}
		
		override public function draw():void {
			if (!_prev)
				reg.menuBg.draw();
			super.draw();
		}
		
		private function updateAnimation():void {
			var step:Number = FlxG.elapsed;
			var i:int = 0;
			while (i < 7) {
				var t:FlxSprite = letters[i];
				var a:Number = FlxU.abs(t.acceleration.y);
				if (t.velocity.y >= 40)
					t.acceleration.y = -a;
				else if (t.velocity.y <= -40)
					t.acceleration.y = a;
				i++;
			}
		}
		
		private function checkMouseOver():void {
			if (!Main.mouseOnScreen)
				return;
			var last:int = cur;
			var i:int = 0;
			var b:Boolean = FlxG.mouse.justReleased();
			while (i < opts.length) {
				if (opts[i].overlapsPoint(FlxG.mouse)) {
					if (i < 5) {
						cur = 0;
						if (b)
							reg.life = i;
					}
					else if (i < 10) {
						cur = 1;
						if (b)
							reg.music = i - 5;
					}
					else if (i < 15) {
						cur = 2;
						if (b)
							reg.sfx = i - 10;
					}
					else if (i < 17) {
						cur = 3;
						if (b)
							reg.fps = i - 15;
					}
					else if (i < 19) {
						cur = 4;
						if (b)
							reg.dps = i - 17;
					}
					else if (i == 19) {
						cur = 5;
						if (b)
							onReset();
					}
					else {
						cur = 6;
						if (b)
							if (i == 20)
								onBack();
							else
								onDefault();
					}
					if (cur != last || b)
						setText();
					break;
				}
				i++;
			}
		}
		
		override protected function onCompleteSlide():void {
			reg.stage.addEventListener(KeyboardEvent.KEY_DOWN, onkey);
		}
		
		private function setText():void {
			for each (var item:FlxText in opts)
				item.color = 0x666666;
			
			opts[reg.life].color = 0x999999;
			opts[5+reg.music].color = 0x999999;
			opts[10+reg.sfx].color = 0x999999;
			opts[15+reg.fps].color = 0x999999;
			opts[17+reg.dps].color = 0x999999;
			
			var index:int;
			if (cur == 0)
				index = reg.life;
			else if (cur == 1)
				index = 5+reg.music;
			else if (cur == 2)
				index = 10+reg.sfx;
			else if (cur == 3)
				index = 15+reg.fps;
			else if (cur == 4)
				index = 17+reg.dps;
			else if (cur == 5)
				index = 19;
			else if (cur == 6)
				index = 20+back;
			
			opts[index].color = 0xffffff;
			
			Sounds.playMenuOption();
		}
		
		private function addText(X:Number, Y:Number, Text:String):FlxText {
			var txt:FlxText = new FlxText(X, Y, Text.length*8, Text);
			txt.shadow = 0x333333;
			txt.maxVelocity.y = 40;
			add(txt);
			return txt;
		}
		
		private function mod(inc:Boolean):void {
			var d:int;
			if (inc)
				d = 1;
			else
				d = -1;
			
			if (cur == 0)
				reg.life += d;
			else if (cur == 1)
				reg.music += d;
			else if (cur == 2)
				reg.sfx += d;
			else if (cur == 3)
				if (reg.fps == 1)
					reg.fps = 0;
				else
					reg.fps = 1;
			else if (cur == 4)
				if (reg.dps == 1)
					reg.dps = 0;
				else
					reg.dps = 1;
			else if (cur == 6)
				if (back == 1)
					back = 0;
				else
					back = 1;
		}
		
		// Callbacks
		
		private function onBack():void {
			reg.stage.removeEventListener(KeyboardEvent.KEY_DOWN, onkey);
			FlxG.switchState(new Menustate(this, true));
			Sounds.playBt();
		}
		private function onDefault():void {
			reg.life = 3;
			reg.music = 4;
			reg.sfx = 2;
			reg.fps = 0;
			setText();
		}
		private function onReset():void {
			onDefault();
		}
		
		private function onkey(e:KeyboardEvent):void {
			var modified:Boolean = true;
			
			// UP
			if (e.keyCode == 38)
				cur--;
			// DOWN
			else if(e.keyCode == 40)
				cur++;
			// left
			else if (e.keyCode == 37)
				mod(false);
			// right
			else if (e.keyCode == 39)
				mod(true);
			else
				modified = false;
			
			if (cur > 6)
				cur = 0;
			else if (cur < 0)
				cur = 6;
			
			if (modified)
				setText();
		}
	}
}
