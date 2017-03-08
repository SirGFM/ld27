package states {
	
	import basics.SlideState;
	import flash.events.KeyboardEvent;
	import org.flixel.FlxG;
	import org.flixel.FlxObject;
	import org.flixel.FlxSprite;
	import org.flixel.FlxText;
	import players.MainShip;
	import players.SK_DMG;
	import players.ZW_TOT;
	import utils.Resources;
	import utils.Sounds;
	import utils.StepCounter;
	
	/**
	 * ...
	 * @author GFM
	 */
	public class PlayerSelectstate extends SlideState {
		
		private var pls:Vector.<FlxSprite>;
		private var opts:Vector.<FlxSprite>;
		private var txts:Vector.<FlxText>;
		private var cnts:Vector.<StepCounter>;
		private var cur:int;
		private var fading:Boolean;
		
		public function PlayerSelectstate(Previous:Menustate) {
			super(Previous, LEFT);
		}
		override public function destroy():void {
			if (canDestroy) {
				while (opts && opts.length > 0)
					opts.pop();
				opts = null;
				while (pls && pls.length > 0)
					pls.pop();
				pls = null;
				while (txts && txts.length > 0)
					txts.pop();
				txts = null;
				while (cnts && cnts.length > 0)
					cnts.pop();
				cnts = null;
				super.destroy();
			}
		}
		
		override public function create():void {
			opts = new Vector.<FlxSprite>();
			
			Resources.plSelectGFX(addSprite(39, 64, opts), 0);
			Resources.plSelectGFX(addSprite(39, 116, opts), 0);
			Resources.plSelectGFX(addSprite(39, 168, opts), 0);
			
			var t:FlxText = new FlxText(0, 233, 256, "BACK");
			t.shadow = 0x333333;
			t.alignment = "center";
			add(t);
			opts.push(t);
			
			pls = new Vector.<FlxSprite>();
			Resources.selectShipGFX(addSprite(80, 64 + 16, pls));
			pls[0].frame = 2;
			Resources.selectShipGFX(addSprite(80, 116 + 16, pls));
			pls[1].frame = 4;
			Resources.selectShipGFX(addSprite(80, 168 + 16, pls));
			pls[2].frame = 6;
			
			txts = new Vector.<FlxText>();
			addText(110, 64+12, 32, "POW:").alignment="right";
			addText(110, 64+22, 32, "AGI:").alignment="right";
			addText(168, 64+12, 32, "TEC:").alignment="right";
			addText(168, 64+22, 32, "DIF:").alignment="right";
			
			addText(132, 64+2, 100, "MAIN SHIP");
			addText(132, 116+2, 100, "ZW-TOT");
			addText(132, 168+2, 100, "SK-DMG");
			
			setOption();
			
			reg.stage.addEventListener(KeyboardEvent.KEY_DOWN, onkey);
			cur = 0;
			fading = false;
			super.create();
		}
		override protected function onCompleteSlide():void {
			cnts = new Vector.<StepCounter>();
			addCounter(135, 64+15);
			addCounter(135, 64+25);
			addCounter(193, 64+15);
			addCounter(193, 64+25);
			
			setOption();
		}
		
		override public function update():void {
			super.update();
			reg.menuBg.update();
			checkMouse();
		}
		
		override public function draw():void {
			if (!_prev)
				reg.menuBg.draw();
			super.draw();
		}
		
		private function setOption():void {
			var i:int = 0;
			while (i < 3) {
				var tmp:FlxSprite = pls[i];
				tmp.frame &= 14;
				Resources.plSelectGFX(opts[i++], 0);
			}
			(opts[i] as FlxText).color = 0x666666;
			
			if (cur < 3) {
				Resources.plSelectGFX(opts[cur], cur + 1);
				pls[cur].frame |= 1;
				i = 0;
				var y:int = 64 + 52*cur;
				while (i < 2) {
					txts[i].y = y + 12 + 10*i;
					txts[i].visible = true;
					txts[i+2].y = y + 12 + 10*i;
					txts[i+2].visible = true;
					if (cnts) {
						cnts[i].y = y + 15 + 10*i;
						cnts[i].visible = true;
						cnts[i+2].y = y + 15 + 10*i;
						cnts[i+2].visible = true;
					}
					i++;
				}
				if (cnts) {
					if (cur == 0) {
						cnts[0].setAll(1, 3);
						cnts[1].setAll(2, 3);
						cnts[2].setAll(3, 3);
						cnts[3].setAll(1, 3);
					}
					else if (cur == 1) {
						cnts[0].setAll(2, 3);
						cnts[1].setAll(3, 3);
						cnts[2].setAll(1, 3);
						cnts[3].setAll(2, 3);
					}
					else if (cur == 2) {
						cnts[0].setAll(3, 3);
						cnts[1].setAll(1, 3);
						cnts[2].setAll(2, 3);
						cnts[3].setAll(3, 3);
					}
				}
			}
			else if (cur == 3) {
				(opts[cur] as FlxText).color = 0xffffff;
				i = 0;
				while (i < 4) {
					txts[i].visible = false;
					if (cnts)
						cnts[i].visible = false;
					i++;
				}
			}
			Sounds.playMenuOption();
		}
		
		private function fadeCallback():void {
			if (cur == 0)
				reg.player = new MainShip();
			else if (cur == 1)
				reg.player = new ZW_TOT();
			else if (cur == 2)
				reg.player = new SK_DMG();
			
			FlxG.switchState(new Playstate());
		}
		
		private function onenter():void {
			if (cur < 3) {
				FlxG.fade(0xff000000, 0.5, fadeCallback);
			}
			else
				FlxG.switchState(new Menustate(this, true, RIGHT));
			
			reg.stage.removeEventListener(KeyboardEvent.KEY_DOWN, onkey);
		}
		
		private function onkey(e:KeyboardEvent):void {
			var modified:Boolean = true;
			
			// enter
			if (e.keyCode == 13) {
				onenter();
				return;
			}
			
			// UP
			else if (e.keyCode == 38)
				cur--;
			// DOWN
			else if(e.keyCode == 40)
				cur++;
			else
				modified = false;
			
			if (cur > 3)
				cur = 0;
			else if (cur < 0)
				cur = 3;
			
			if (modified)
				setOption();
		}
		
		private function addSprite(X:Number, Y:Number, v:Vector.<FlxSprite>):FlxSprite {
			var tmp:FlxSprite = new FlxSprite(X, Y);
			add(tmp);
			v.push(tmp);
			return tmp;
		}
		private function addText(X:Number, Y:Number, Width:uint, Text:String):FlxText {
			var tmp:FlxText = new FlxText(X, Y, Width, Text);
			tmp.shadow = 0x333333;
			add(tmp);
			txts.push(tmp);
			return tmp;
		}
		private function addCounter(X:Number, Y:Number):StepCounter {
			var tmp:StepCounter = new StepCounter(X, Y, "selectShipGFX");
			tmp.width = 8;
			tmp.setAll(0, 3);
			add(tmp);
			cnts.push(tmp);
			return tmp;
		}
		
		private function checkMouse():void {
			if (!Main.mouseOnScreen)
				return;
			var last:int = cur;
			var i:int = 0;
			var l:int = opts.length;
			while (i < l) {
				var o:FlxObject = opts[i] as FlxObject;
				if (o.overlapsPoint(FlxG.mouse)) {
					cur = i;
					if (cur != last)
						setOption();
					if (FlxG.mouse.justPressed())
						onenter();
					break;
				}
				i++
			}
		}
	}
}
