package states {
	
	import basics.Player;
	import basics.SlideState;
	import flash.display.BitmapData;
	import flash.events.KeyboardEvent;
	import org.flixel.FlxButton;
	import org.flixel.FlxG;
	import org.flixel.FlxGroup;
	import org.flixel.FlxSprite;
	import org.flixel.FlxText;
	import org.flixel.FlxU;
	import players.ZW_TOT;
	import plugins.MessageBox;
	import utils.FlashingText;
	import utils.Registry;
	import utils.Resources;
	import utils.Sounds;
	import utils.Starfield;
	
	/**
	 * ...
	 * @author GFM
	 */
	public class Menustate extends SlideState {
		
		static private var firstFocus:Boolean = false;
		
		public var title:Vector.<FlxSprite>;
		private var opts:Vector.<FlxText>;
		
		private var complete:Boolean;
		private var _autoComplete:Boolean;
		
		private var timer:Number;
		
		private var cur:int;
		
		public function Menustate(Previous:SlideState = null, autocomplete:Boolean = false, Direction:uint = LEFT) {
			super(Previous, Direction);
			_autoComplete = autocomplete;
		}
		override public function destroy():void {
			if (canDestroy) {
				super.destroy();
				while (title && title.length > 0)
					title.pop();
				title = null;
				while (opts && opts.length > 0)
					opts.pop();
				opts = null;
			}
		}
		
		override public function create():void {
			reg.clear();
			
			createBg();
			
			if (!firstFocus) {
				var tmp:FlashingText = new FlashingText(76, 233, 256, "-- CLICK TO START --");
				add(tmp);
				return;
			}
			reg.stage.addEventListener(KeyboardEvent.KEY_DOWN, onkey);
			
			opts = new Vector.<FlxText>();
			title = new Vector.<FlxSprite>();
			
			//title.push(add(new FlxSprite(42, 22)));
			title.push(add(new FlxSprite(55, 62)));
			title.push(add(new FlxSprite(88, 62)));
			title.push(add(new FlxSprite(107, 62)));
			title.push(add(new FlxSprite(148, 62)));
			title.unshift(add(new FlxSprite(42, 22)));
			
			Resources.mainmenuGFX(this);
			
			title[0].x = -title[0].width;
			title[0].velocity.x = title[0].width * 3.5;
			title[0].acceleration.x = -title[0].width * 4;
			
			var i:int = 1;
			while (i < 5) {
				title[i].alpha = 0;
				title[i].y = title[0].y;
				i++;
			}
			
			complete = false;
			canDestroy = true;
			if (_autoComplete) {
				completeAnimation();
				addStuff();
			}
			
			Sounds.playMenuSong();
			timer = 0;
			super.create();
		}
		
		override public function update():void {
			if (!firstFocus) {
				if (FlxG.mouse.justReleased()) {
					firstFocus = true;
					remove(members[0]);
					create();
				}
			}
			else if (!complete) {
				if (FlxG.keys.any() || FlxG.mouse.justReleased())
					completeAnimation();
				else
					doAnimation();
				
				if (complete)
					addStuff();
			}
			else {
				timer += FlxG.elapsed;
				animateTitle();
				checkMouseOver();
				if (FlxG.keys.justPressed("ENTER")) 
					onSelected();
			}
			
			reg.menuBg.update();
			super.update();
		}
		
		private function checkMouseOver():void {
			if (!Main.mouseOnScreen)
				return;
			var last:int = cur;
			var i:int = 0;
			while (i < opts.length) {
				if (opts[i].overlapsPoint(FlxG.mouse)) {
					cur = i;
					if (cur != last)
						setText();
					if (FlxG.mouse.justReleased())
						onSelected();
				}
				i++;
			}
		}
		
		override public function draw():void {
			if (!_prev && reg.menuBg)
				reg.menuBg.draw();
			super.draw();
		}
		
		private function animateTitle():void {
			if (FlxU.abs(title[0].velocity.x) > 30)
				title[0].acceleration.x *= -1;
			
			var i:int = 1;
			while (i < 5) {
				var spr:FlxSprite = title[i];
				if (spr.y == 62 && spr.velocity.y == 0 && timer > 1+(i-1)*0.1 && timer < 2 ) {
					spr.velocity.y = -20;
					spr.acceleration.y = -50;
				}
				else if (FlxU.abs(spr.velocity.y) > 30)
					spr.acceleration.y *= -1;
				else if (timer > 2.5 + (i - 1) * 0.1 && spr.y >= 62 && spr.velocity.y > 0) {
					spr.y = 62;
					spr.velocity.y = 0;
					spr.acceleration.y = 0;
				}
				i++;
			}
			
			if (timer > 3.25)
				timer = 0;
		}
		
		public function addStuff():void {
			var bt:FlxButton;
			
			title[0].velocity.x = 20;
			title[0].acceleration.x = 60;
			
			opts.push(addText(98, 148, "START GAME"));
			opts.push(addText(107, 163, "OPTION"));
			opts.push(addText(106, 178, "JUKEBOX"));
			// TODO enable jukebox
			opts[opts.length - 1].visible = false;
			opts.push(addText(117, 193, "HELP"));
			opts.push(addText(109, 208, "CREDITS"));
			cur = 0;
			setText();
			
			if (!_autoComplete) {
				FlxG.flash(0xffffffff, 0.5);
				Sounds.playMainMenu();
			}
		}
		
		public function completeAnimation():void {
			title[0].x = 42;
			title[0].acceleration.x = 0;
			title[0].velocity.x = 0;
			
			var i:int = 1;
			while (i < 5) {
				title[i].alpha = 1.0;
				title[i].y = 62;
				title[i].velocity.y = 0;
				i++;
			}
			complete = true;
		}
		
		private function doAnimation():void {
			var step:Number = FlxG.elapsed*2;
			
			if (title[0].x <= 42 && title[0].velocity.x < 0) {
				title[0].x = 42;
				title[0].acceleration.x = 0;
				title[0].velocity.x = 0;
			}
			
			var i:int = 1;
			while (i < 5) {
				if (title[i].y >= 62) {
					title[i].y = 62;
					title[i].velocity.y = 0;
				}
				i++;
			}
			complete = title[4].y == 62;
			
			if (title[0].velocity.x == 0 && title[0].x == 42) {
				i = 1;
				while (i < 5) {
					if (title[i].y < 62 && title[i - 1].alpha > 0.3) {
						title[i].velocity.y = 64;
						if (title[i].alpha == 0)
							Sounds.playLetter();
						title[i].alpha += step;
					}
					i++;
				}
			}
		}
		
		private function createBg():void {
			if (reg.menuBg)
				return;
			
			var bgrp:FlxGroup = new FlxGroup();
			reg.menuBg = bgrp;
			
			var bg:FlxSprite;
			bg = new FlxSprite();
			bg.makeGraphic(256, 256, 0);
			bg.pixels.perlinNoise(256, 256, 8, FlxG.random(), false, true, 7, true);
			bg.color = 0xff1c3249;
			bg.dirty = true;
			bgrp.add(bg);
			
			var sf:Starfield;
			sf = new Starfield(312, 256, 0.00125, 5);
			sf.velocity.y = 150;
			sf.x = -18;
			sf.alpha = 0.6;
			bgrp.add(sf);
			sf = new Starfield(312, 256, 0.0035, 4);
			sf.velocity.y = 100;
			sf.x = -36;
			sf.alpha = 0.7;
			bgrp.add(sf);
			sf = new Starfield(312, 256, 0.005, 6);
			sf.velocity.y = 51;
			sf.x = -54;
			sf.alpha = 0.8;
			bgrp.add(sf);
		}
		
		private function setText():void {
			for each (var item:FlxText in opts)
				item.color = 0x666666;
			
			opts[cur].color = 0xffffff;
			Sounds.playMenuOption();
		}
		
		private function addText(X:Number, Y:Number, Text:String):FlxText {
			var txt:FlxText = new FlxText(X, Y, Text.length*8, Text);
			txt.shadow = 0x333333;
			add(txt);
			return txt;
		}
		
		// Callbacks
		
		private function switchstate():void {
			FlxG.switchState(new Playstate());
			reg.menuBg.destroy();
			reg.menuBg = null;
		}
		private function startGame():void {
			FlxG.switchState(new PlayerSelectstate(this));
		}
		
		private function helpMenu():void {
			var mb:MessageBox = FlxG.getPlugin(MessageBox) as MessageBox;
			if (!mb)
				mb = FlxG.addPlugin(new MessageBox) as MessageBox;
			
			if (!mb.alive)
				mb.wakeup(4);
		}
		
		private function options():void {
			FlxG.switchState(new Optionsstate(this));
		}
		private function playerSelection():void {
			FlxG.switchState(new PlayerSelectstate(this));
		}
		
		private function jukebox():void {
			// TODO jukebox
		}
		private function credits():void {
			// TODO credits
		}
		
		private function onSelected():void {
			var playSound:Boolean = true;
			
			if (cur == 0)
				startGame();
			else if (cur == 1)
				options();
			else if (cur == 2)
				jukebox();
			else if (cur == 3)
				helpMenu();
			else if (cur == 4)
				credits();
			else
				playSound = false;
			
			if (cur == 0 || cur == 1)
				reg.stage.removeEventListener(KeyboardEvent.KEY_DOWN, onkey);
			if (playSound)
				Sounds.playBt();
		}
		
		private function onkey(e:KeyboardEvent):void {
			if (opts.length == 0)
				return;
			var modified:Boolean = true;
			
			// UP
			if (e.keyCode == 38)
				cur--;
			// DOWN
			else if(e.keyCode == 40)
				cur++;
			else
				modified = false;
			
			if (cur > 4)
				cur = 0;
			else if (cur < 0)
				cur = 4;
			
			if (!opts[cur].visible)
				// UP
				if (e.keyCode == 38)
					cur--;
				// DOWN
				else if(e.keyCode == 40)
					cur++;
			
			if (modified)
				setText();
		}
	}
}
