package states {
	
	import basics.Player;
	import org.flixel.FlxButton;
	import org.flixel.FlxG;
	import org.flixel.FlxSprite;
	import org.flixel.FlxState;
	import players.ZW_TOT;
	import plugins.MessageBox;
	import utils.Registry;
	import utils.Resources;
	import utils.Sounds;
	import utils.Starfield;
	
	/**
	 * ...
	 * @author GFM
	 */
	public class Menustate extends FlxState {
		
		public var _space:FlxSprite;
		public var _R:FlxSprite;
		public var _I:FlxSprite;
		public var _F:FlxSprite;
		public var _T:FlxSprite;
		
		private var complete:Boolean;
		
		override public function create():void {
			Registry.clear();
			
			_space = new FlxSprite(42, 22);
			_R = new FlxSprite(55, 62);
			_I = new FlxSprite(88, 62);
			_F = new FlxSprite(107, 62);
			_T = new FlxSprite(148, 62);
			
			Resources.mainmenuGFX(this);
			
			createBg();
			add(_R);
			add(_I);
			add(_F);
			add(_T);
			add(_space);
			
			_space.x = -_space.width;
			_space.velocity.x = _space.width * 3.5;
			_space.acceleration.x = -_space.width * 4;
			
			_R.alpha = 0;
			_R.y = _space.y;
			_I.alpha = 0;
			_I.y = _space.y;
			_F.alpha = 0;
			_F.y = _space.y;
			_T.alpha = 0;
			_T.y = _space.y;
			
			complete = false;
			
			Sounds.playMenuSong();
		}
		
		override public function update():void {
			if (!complete) {
				if (FlxG.keys.any())
					completeAnimation();
				else
					doAnimation();
				
				if (complete)
					addStuff();
			}
			
			super.update();
		}
		
		private function startGame():void {
			Sounds.playBt();
			Registry.player = new Player();
			FlxG.fade(0xff000000, 0.5, function():void { FlxG.switchState(new Playstate()); } );
		}
		private function startGamePlus():void {
			Sounds.playBt();
			Registry.player = new ZW_TOT();
			FlxG.fade(0xff000000, 0.5, function():void { FlxG.switchState(new Playstate()); } );
		}
		
		private function helpMenu():void {
			var mb:MessageBox = FlxG.getPlugin(MessageBox) as MessageBox;
			if (!mb)
				mb = FlxG.addPlugin(new MessageBox) as MessageBox;
			
			if (!mb.alive) {
				Sounds.playBt();
				mb.wakeup(4);
			}
		}
		
		private function addStuff():void {
			var bt:FlxButton;
			
			if (Registry.enableZaWarudo) {
				var spr:FlxSprite;
				
				bt = new FlxButton(0, 127, "START", startGame);
				bt.x = 123 - bt.width;
				add(bt);
				spr = new FlxSprite(bt.x + 8, bt.y - 16);
				Resources.playerGFX(spr);
				add(spr);
				
				bt = new FlxButton(bt.x+bt.width+10, 127, "START", startGamePlus);
				add(bt);
				spr = new FlxSprite(bt.x + 8, bt.y - 16);
				Resources.zaWarudoGFX(spr);
				add(spr);
			}
			else {
				bt = new FlxButton(0, 127, "START", startGame);
				bt.x = (256 - bt.width) / 2;
				add(bt);
			}
			bt = new FlxButton(0, 127+bt.height+8, "HELP", helpMenu);
			bt.x = (256 - bt.width) / 2;
			add(bt);
			FlxG.flash(0xffffffff, 0.5);
			Sounds.playMainMenu();
		}
		
		private function completeAnimation():void {
			_space.x = 42;
			_space.acceleration.x = 0;
			_space.velocity.x = 0;
			_R.y = 62;
			_R.alpha = 1.0;
			_R.velocity.y = 0;
			_I.y = 62;
			_I.alpha = 1.0;
			_I.velocity.y = 0;
			_F.y = 62;
			_F.alpha = 1.0;
			_F.velocity.y = 0;
			_T.y = 62;
			_T.alpha = 1.0;
			_T.velocity.y = 0;
			complete = true;
		}
		
		private function doAnimation():void {
			var step:Number = FlxG.elapsed*2;
			
			if (_space.x <= 42 && _space.velocity.x < 0) {
				_space.x = 42;
				_space.acceleration.x = 0;
				_space.velocity.x = 0;
			}
			if (_R.y >= 62) {
				_R.y = 62;
				_R.velocity.y = 0;
			}
			if (_I.y >= 62) {
				_I.y = 62;
				_I.velocity.y = 0;
			}
			if (_F.y >= 62) {
				_F.y = 62;
				_F.velocity.y = 0;
			}
			if (_T.y >= 62) {
				_T.y = 62;
				_T.velocity.y = 0;
				complete = true;
			}
			
			if (_R.y < 62 && _space.x == 42 && _space.velocity.x == 0) {
				_R.velocity.y = 64;
				if (_R.alpha == 0)
					Sounds.playLetter();
				_R.alpha += step;
			}
			if (_I.y < 62 && _R.alpha >= 0.3) {
				_I.velocity.y = 64;
				if (_I.alpha == 0)
					Sounds.playLetter();
				_I.alpha += step;
			}
			if (_F.y < 62 && _I.alpha >= 0.3) {
				_F.velocity.y = 64;
				if (_F.alpha == 0)
					Sounds.playLetter();
				_F.alpha += step;
			}
			if (_T.y < 62 && _F.alpha >= 0.3) {
				_T.velocity.y = 64;
				if (_T.alpha == 0)
					Sounds.playLetter();
				_T.alpha += step;
			}
		}
		
		private function createBg():void {
			var bg:FlxSprite;
			bg = new FlxSprite();
			bg.makeGraphic(256, 256, 0);
			bg.pixels.perlinNoise(256, 256, 8, FlxG.random(), false, true, 7, true);
			bg.color = 0xff1c3249;
			bg.dirty = true;
			add(bg);
			
			var sf:Starfield;
			sf = new Starfield(312, 256, 0.00125, 5);
			sf.velocity.y = 150;
			sf.x = -18;
			sf.alpha = 0.6;
			add(sf);
			sf = new Starfield(312, 256, 0.0035, 4);
			sf.velocity.y = 100;
			sf.x = -36;
			sf.alpha = 0.7;
			add(sf);
			sf = new Starfield(312, 256, 0.005, 6);
			sf.velocity.y = 51;
			sf.x = -54;
			sf.alpha = 0.8;
			add(sf);
		}
	}
}
