package utils {
	
	import basics.Basic;
	import basics.Boss;
	import basics.BossWeapon;
	import collectibles.TypePUP;
	import org.flixel.FlxSprite;
	import states.Menustate;
	import states.Optionsstate;
	
	/**
	 * ...
	 * @author GFM
	 */
	public class Resources {
		
		[Embed(source = "../../assets/gfx/ships/boss/boss.png")]				static private var _boss:Class;
		[Embed(source = "../../assets/gfx/ships/boss/leftSpread.png")]			static private var _bossLSpread:Class;
		[Embed(source = "../../assets/gfx/ships/boss/rightSpread.png")]			static private var _bossRSpread:Class;
		[Embed(source = "../../assets/gfx/ships/boss/leftMaze.png")]			static private var _bossLMaze:Class;
		[Embed(source = "../../assets/gfx/ships/boss/rightMaze.png")]			static private var _bossRMaze:Class;
		[Embed(source = "../../assets/gfx/ships/boss/shootgun.png")]			static private var _bossShootgun:Class;
		[Embed(source = "../../assets/gfx/ships/boss/laser.png")]				static private var _bossLaser:Class;
		
		[Embed(source = "../../assets/gfx/ships/enemies/enemy1.png")]		static private var _enemy1:Class;
		[Embed(source = "../../assets/gfx/ships/enemies/enemy2.png")]		static private var _enemy2:Class;
		[Embed(source = "../../assets/gfx/ships/enemies/enemy3.png")]		static private var _enemy3:Class;
		
		[Embed(source = "../../assets/gfx/bullets/bullets_atlas.png")]		static private var _bullets:Class;
		[Embed(source = "../../assets/gfx/bullets/boss_laser.png")]			static private var _bsLaserBullet:Class;
		[Embed(source = "../../assets/gfx/particles/items.png")]			static private var _items:Class;
		[Embed(source = "../../assets/gfx/particles/powerups.png")]			static private var _pups:Class;
		[Embed(source = "../../assets/gfx/particles/hit.png")]				static private var _hit:Class;
		[Embed(source = "../../assets/gfx/particles/explosion.png")]		static private var _explosion:Class;
		[Embed(source = "../../assets/gfx/particles/throttle.png")]			static private var _throttle:Class;
		
		[Embed(source = "../../assets/gfx/ships/player/mainShip.png")]		static private var _plMain:Class;
		[Embed(source = "../../assets/gfx/ships/player/zw-tot.png")]		static private var _plZaWarudo:Class;
		[Embed(source = "../../assets/gfx/ships/player/sk-dmg.png")]		static private var _plSpikey:Class;
		
		[Embed(source = "../../assets/gfx/hud/life.png")]			static private var _life:Class;
		[Embed(source = "../../assets/gfx/hud/bomb.png")]			static private var _bomb:Class;
		[Embed(source = "../../assets/gfx/hud/star.png")]			static private var _star:Class;
		[Embed(source = "../../assets/gfx/hud/plSelectShip.png")]	static private var _plSelectShip:Class;
		[Embed(source = "../../assets/gfx/hud/hitbox.png")]			static private var _hitbox:Class;
		
		[Embed(source = "../../assets/gfx/hud/plSelect/plSelect.png")]				static private var _plSelect:Class;
		[Embed(source = "../../assets/gfx/hud/plSelect/plSelect_color1.png")]		static private var _plSelect1:Class;
		[Embed(source = "../../assets/gfx/hud/plSelect/plSelect_color2.png")]		static private var _plSelect2:Class;
		[Embed(source = "../../assets/gfx/hud/plSelect/plSelect_color3.png")]		static private var _plSelect3:Class;
		[Embed(source = "../../assets/gfx/hud/plSelect/plSelect_color4.png")]		static private var _plSelect4:Class;
		
		[Embed(source = "../../assets/gfx/hud/title/space.png")]		static private var _space:Class;
		[Embed(source = "../../assets/gfx/hud/title/title_R.png")]		static private var _title_R:Class;
		[Embed(source = "../../assets/gfx/hud/title/title_I.png")]		static private var _title_I:Class;
		[Embed(source = "../../assets/gfx/hud/title/title_F.png")]		static private var _title_F:Class;
		[Embed(source = "../../assets/gfx/hud/title/title_T.png")]		static private var _title_T:Class;
		[Embed(source = "../../assets/gfx/hud/options/opt1_O.png")]		static private var _opt_O:Class;
		[Embed(source = "../../assets/gfx/hud/options/opt2_P.png")]		static private var _opt_P:Class;
		[Embed(source = "../../assets/gfx/hud/options/opt3_T.png")]		static private var _opt_T2:Class;
		[Embed(source = "../../assets/gfx/hud/options/opt4_I.png")]		static private var _opt_I2:Class;
		[Embed(source = "../../assets/gfx/hud/options/opt5_O.png")]		static private var _opt_O2:Class;
		[Embed(source = "../../assets/gfx/hud/options/opt6_N.png")]		static private var _opt_N:Class;
		[Embed(source = "../../assets/gfx/hud/options/opt7_S.png")]		static private var _opt_S:Class;
		
		
		
		// I'll probably randomize this into the enemy, afterwards
		static public function enemy1GFX(self:FlxSprite):void {
			self.loadRotatedGraphic(_enemy1, 16, -1, false, true);
			self.width = 24*1.5;
			self.height = 16*1.5;
			self.centerOffsets();
			
			var basic:Basic = self as Basic;
			if (basic) {
				basic.center.make(18, 12);
				basic.radius = 12;
			}
		}
		static public function enemy2GFX(self:FlxSprite):void {
			self.loadRotatedGraphic(_enemy2, 16, -1, false, true);
			self.width = 24*1.5;
			self.height = 16*1.5;
			self.centerOffsets();
			
			var basic:Basic = self as Basic;
			if (basic) {
				basic.center.make(18, 12);
				basic.radius = 12;
			}
		}
		static public function enemy3GFX(self:FlxSprite):void {
			self.loadRotatedGraphic(_enemy3, 16, -1, false, true);
			self.width = 24*1.5;
			self.height = 16*1.5;
			self.centerOffsets();
			
			var basic:Basic = self as Basic;
			if (basic) {
				basic.center.make(18, 12);
				basic.radius = 12;
			}
		}
		
		static public function bossGFX(b:Boss):void {
			b.loadGraphic(_boss, false, false, 128, 64);
		}
		static public function bossLSpread(b:BossWeapon):void {
			b.loadGraphic(_bossLSpread, true, false, 17, 19);
			b.center.make(8.5, 9.5);
			b.radius = 9;
			if (!b.play("def")) {
				b.addAnimation("def", [3], 0, false);
				b.addAnimation("open", [0, 1, 2, 3], 8, false);
				b.addAnimation("close", [3, 2, 1, 0], 8, false);
				b.addAnimation("destroy", [4, 5, 6, 7], 10, true);
			}
		}
		static public function bossRSpread(b:BossWeapon):void {
			b.loadGraphic(_bossRSpread, true, false, 17, 19);
			b.center.make(8.5, 9.5);
			b.radius = 9;
			if (!b.play("def")) {
				b.addAnimation("def", [3], 0, false);
				b.addAnimation("open", [0, 1, 2, 3], 8, false);
				b.addAnimation("close", [3, 2, 1, 0], 8, false);
				b.addAnimation("destroy", [4, 5, 6, 7], 10, true);
			}
		}
		static public function bossLMaze(b:BossWeapon):void {
			b.loadGraphic(_bossLMaze, true, false, 11, 24);
			b.center.make(5.5, 12);
			b.radius = 6;
			if (!b.play("def")) {
				b.addAnimation("def", [3], 0, false);
				b.addAnimation("open", [0, 1, 2, 3], 8, false);
				b.addAnimation("close", [3, 2, 1, 0], 8, false);
				b.addAnimation("destroy", [4, 5, 6, 7], 10, true);
			}
		}
		static public function bossRMaze(b:BossWeapon):void {
			b.loadGraphic(_bossRMaze, true, false, 11, 24);
			b.center.make(5.5, 12);
			b.radius = 6;
			if (!b.play("def")) {
				b.addAnimation("def", [3], 0, false);
				b.addAnimation("open", [0, 1, 2, 3], 8, false);
				b.addAnimation("close", [3, 2, 1, 0], 8, false);
				b.addAnimation("destroy", [4, 5, 6, 7], 10, true);
			}
		}
		static public function bossShootgun(b:BossWeapon):void {
			b.loadGraphic(_bossShootgun, true, false, 16, 12);
			b.center.make(8, 6);
			b.radius = 7;
			if (!b.play("def")) {
				b.addAnimation("def", [3], 0, false);
				b.addAnimation("open", [0, 1, 2, 3], 8, false);
				b.addAnimation("close", [3, 2, 1, 0], 8, false);
				b.addAnimation("destroy", [4, 5, 6, 7], 10, true);
			}
		}
		static public function bossLaser(b:BossWeapon):void {
			b.loadGraphic(_bossLaser, true, false, 18, 15);
			b.center.make(9, 7.5);
			b.radius = 8.25;
			if (!b.play("def")) {
				b.addAnimation("def", [7], 0, false);
				b.addAnimation("open", [0, 1, 2, 3, 4, 5, 6, 7], 16, false);
				b.addAnimation("close", [7, 6, 5, 4, 3, 2, 1, 0], 16, false);
				b.addAnimation("destroy", [8, 9, 10, 11, 12, 13, 14, 15], 14, true);
			}
		}
		
		static public function playerGFX(self:FlxSprite):void {
			//self.makeGraphic(16, 16, 0xffaaaaff);
			self.loadGraphic(_plMain, true, false, 24, 16);
			if (!self.play("def")) {
				self.addAnimation("def", [0], 0, false);
				self.addAnimation("left", [1], 0, false);
				self.addAnimation("right", [2], 0, false);
				self.addAnimation("bw", [3], 0, false);
			}
		}
		static public function zaWarudoGFX(self:FlxSprite):void {
			self.loadGraphic(_plZaWarudo, true, false, 24, 16);
			if (!self.play("def")) {
				self.addAnimation("def", [0], 0, false);
				self.addAnimation("left", [1], 0, false);
				self.addAnimation("right", [2], 0, false);
				self.addAnimation("bw", [3], 0, false);
			}
		}
		static public function plSpikeyGFX(self:FlxSprite):void {
			self.loadGraphic(_plSpikey, true, false, 24, 16);
			if (!self.play("def")) {
				self.addAnimation("def", [0], 0, false);
				self.addAnimation("left", [1], 0, false);
				self.addAnimation("right", [2], 0, false);
				self.addAnimation("bw", [3], 0, false);
			}
		}
		
		static public function bulletGFX(self:FlxSprite):void {
			self.loadGraphic(_bullets);
		}
		
		static public function itemsGFX(self:FlxSprite):void {
			self.loadGraphic(_items, true, false, 8, 8);
			var b:Basic = self as Basic;
			if (b) {
				b.width = 32;
				b.height =  32;
				b.centerOffsets();
				b.center.make(16, 16);
				b.radius = 12;
			}
		}
		static public function pupGFX(self:Basic):void {
			self.loadGraphic(_pups, true, false, 16, 16);
			self.width = 32;
			self.height =  32;
			self.centerOffsets();
			self.center.make(16, 16);
			self.radius = 12;
		}
		static public function hitGFX(self:FlxSprite):void {
			self.loadGraphic(_hit, true, false, 8, 8);
			if (!self.play("def")) {
				self.addAnimation("def", [0], 0, false);
				self.addAnimation("hitEnemy", [0, 1, 2, 3, 4], 10, false);
				self.addAnimation("hitPlayer", [5, 6, 7, 8, 9], 10, false);
				self.addAnimation("graze", [10, 11, 12, 13, 14], 10, false);
			}
		}
		static public function explosionGFX(self:FlxSprite):void {
			self.loadGraphic(_explosion, true, false, 16, 16);
			if (!self.play("explode")) {
				self.addAnimation("detonate", [0, 1, 2, 3, 4, 5], 12, false);
			}
		}
		static public function throttleGFX():Class {
			return _throttle;
		}
		
		static public function lifeiconGFX(self:FlxSprite):void {
			self.loadGraphic(_life, true, false, 8, 8);
		}
		static public function bombiconGFX(self:FlxSprite):void {
			self.loadGraphic(_bomb, true, false, 8, 8);
		}
		static public function stariconGFX(self:FlxSprite):void {
			self.loadGraphic(_star, true, false, 9, 8);
		}
		static public function selectShipGFX(self:FlxSprite):void {
			self.loadGraphic(_plSelectShip, true, false, 25, 17);
		}
		static public function hitboxGFX(self:FlxSprite):void {
			self.loadGraphic(_hitbox, true, false, 8, 8);
			if (!self.play("def")) {
				self.addAnimation("def", [0], 0, false);
				self.addAnimation("MainShip", [0,1,2,3], 8, true);
				self.addAnimation("ZW_TOT", [4,5,6,7], 8, true);
				self.addAnimation("SK_DMG", [8,9,10,11], 8, true);
			}
		}
		
		static public function barGFX(self:FlxSprite, Width:int = 200, Height:int = 16):void {
			var halfH:int = Height / 2;
			var w_1:int = Width - 1;
			var h_1:int = Height - 1;
			self.makeGraphic(Width, Height, 0, true, "bar."+Width.toString+"x"+Height.toString());
			var i:int = 2;
			while (i < halfH-2) {
				self.drawLine(2, i, Width-2, i, 0xffffffff);
				i++;
			}
			i = Height;
			while (i < Height) {
				self.drawLine(0, i, Width, i, 0x33333333);
				i++;
			}
			self.drawLine(0, halfH, Width, halfH, 0xff333333);
			self.drawLine(0, halfH, 0, Height, 0xff333333);
			self.drawLine(0, h_1, Width, h_1, 0xff333333);
			self.drawLine(w_1, 0, w_1, h_1, 0xff333333);
			self.frameHeight = Height/2;
		}
		static public function mainmenuGFX(menu:Menustate):void {
			menu.title[0].loadGraphic(_space);
			menu.title[1].loadGraphic(_title_R);
			menu.title[2].loadGraphic(_title_I);
			menu.title[3].loadGraphic(_title_F);
			menu.title[4].loadGraphic(_title_T);
		}
		static public function optionsGFX(menu:Optionsstate):void {
			menu.letters[0].loadGraphic(_opt_O);
			menu.letters[1].loadGraphic(_opt_P);
			menu.letters[2].loadGraphic(_opt_T2);
			menu.letters[3].loadGraphic(_opt_I2);
			menu.letters[4].loadGraphic(_opt_O2);
			menu.letters[5].loadGraphic(_opt_N);
			menu.letters[6].loadGraphic(_opt_S);
		}
		
		static public function plSelectGFX(spr:FlxSprite, frame:uint):void {
			if (frame == 0) {
				spr.loadGraphic(_plSelect, false, false, 224, 48, false);
				if (!spr.play("none")) {
					spr.addAnimation("none", [0], 0, false);
					spr.play("none");
				}
			}
			else {
				spr.loadGraphic(Resources["_plSelect" + frame.toString()], true, false, 224, 48, false);
				if (!spr.play("selected")) {
					spr.addAnimation("selected", [0, 1, 2, 3, 4, 5, 6, 7], 16, true);
					spr.play("selected");
				}
			}
		}
	}
}
