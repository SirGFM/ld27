package utils {
	
	import basics.Basic;
	import collectibles.TypePUP;
	import objs.Boss;
	import org.flixel.FlxSprite;
	import states.Menustate;
	
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
		
		[Embed(source = "../../assets/gfx/ships/player/mainShip.png")]		static private var _plMain:Class;
		[Embed(source = "../../assets/gfx/ships/player/zw-tot.png")]		static private var _plZaWarudo:Class;
		
		[Embed(source = "../../assets/gfx/hud/life.png")]			static private var _life:Class;
		[Embed(source = "../../assets/gfx/hud/space.png")]			static private var _space:Class;
		[Embed(source = "../../assets/gfx/hud/title_R.png")]		static private var _title_R:Class;
		[Embed(source = "../../assets/gfx/hud/title_I.png")]		static private var _title_I:Class;
		[Embed(source = "../../assets/gfx/hud/title_F.png")]		static private var _title_F:Class;
		[Embed(source = "../../assets/gfx/hud/title_T.png")]		static private var _title_T:Class;
		
		
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
			
			b._leftSpread.loadGraphic(_bossLSpread, true, false, 17, 19);
			b._leftSpread.center.make(8.5, 9.5);
			b._leftSpread.radius = 9;
			if (!b._leftSpread.play("def")) {
				b._leftSpread.addAnimation("def", [3], 0, false);
				b._leftSpread.addAnimation("open", [0, 1, 2, 3], 8, false);
				b._leftSpread.addAnimation("close", [3, 2, 1, 0], 8, false);
			}
			
			b._rightSpread.loadGraphic(_bossRSpread, true, false, 17, 19);
			b._rightSpread.center.make(8.5, 9.5);
			b._rightSpread.radius = 9;
			if (!b._rightSpread.play("def")) {
				b._rightSpread.addAnimation("def", [3], 0, false);
				b._rightSpread.addAnimation("open", [0, 1, 2, 3], 8, false);
				b._rightSpread.addAnimation("close", [3, 2, 1, 0], 8, false);
			}
			
			b._leftMaze.loadGraphic(_bossLMaze, true, false, 11, 24);
			b._leftMaze.center.make(5.5, 12);
			b._leftMaze.radius = 6;
			if (!b._leftMaze.play("def")) {
				b._leftMaze.addAnimation("def", [3], 0, false);
				b._leftMaze.addAnimation("open", [0, 1, 2, 3], 8, false);
				b._leftMaze.addAnimation("close", [3, 2, 1, 0], 8, false);
			}
			
			b._rightMaze.loadGraphic(_bossRMaze, true, false, 11, 24);
			b._rightMaze.center.make(5.5, 12);
			b._rightMaze.radius = 6;
			if (!b._rightMaze.play("def")) {
				b._rightMaze.addAnimation("def", [3], 0, false);
				b._rightMaze.addAnimation("open", [0, 1, 2, 3], 8, false);
				b._rightMaze.addAnimation("close", [3, 2, 1, 0], 8, false);
			}
			
			b._shootgun.loadGraphic(_bossShootgun, true, false, 16, 12);
			b._shootgun.center.make(8, 6);
			b._shootgun.radius = 7;
			if (!b._shootgun.play("def")) {
				b._shootgun.addAnimation("def", [3], 0, false);
				b._shootgun.addAnimation("open", [0, 1, 2, 3], 8, false);
				b._shootgun.addAnimation("close", [3, 2, 1, 0], 8, false);
			}
			
			b._laser.loadGraphic(_bossLaser, true, false, 18, 15);
			b._laser.center.make(9, 7.5);
			b._laser.radius = 8.25;
			if (!b._laser.play("def")) {
				b._laser.addAnimation("def", [7], 0, false);
				b._laser.addAnimation("open", [0, 1, 2, 3, 4, 5, 6, 7], 16, false);
				b._laser.addAnimation("close", [7, 6, 5, 4, 3, 2, 1, 0], 16, false);
			}
		}
		
		static public function playerGFX(self:FlxSprite):void {
			//self.makeGraphic(16, 16, 0xffaaaaff);
			self.loadGraphic(_plMain, true, false, 24, 16);
			if (!self.play("def")) {
				self.addAnimation("def", [0], 0, false);
				self.addAnimation("left", [1], 0, false);
				self.addAnimation("right", [2], 0, false);
			}
			
			var basic:Basic = self as Basic;
			if (basic) {
				basic.center.make(12, 8);
				basic.radius = 4.5;
			}
		}
		static public function zaWarudoGFX(self:FlxSprite):void {
			self.loadGraphic(_plZaWarudo, true, false, 24, 16);
			if (!self.play("def")) {
				self.addAnimation("def", [0], 0, false);
				self.addAnimation("left", [1], 0, false);
				self.addAnimation("right", [2], 0, false);
			}
			
			var basic:Basic = self as Basic;
			if (basic) {
				basic.center.make(8, 8);
				basic.radius = 4.5;
			}
		}
		
		// Bullets!
		static public function plBulletPellet(self:FlxSprite):void {
			self.loadGraphic(_bullets, true, false, 5, 8);
			self.frame = 0;
			
			var basic:Basic = self as Basic;
			if (basic) {
				basic.center.make(2, 4);
				basic.radius = 2.25;
			}
		}
		static public function plBulletBucky(self:FlxSprite):void {
			self.loadGraphic(_bullets, true, false, 5, 8);
			self.frame = 1;
			
			var basic:Basic = self as Basic;
			if (basic) {
				basic.center.make(2, 3);
				basic.radius = 2.75;
			}
		}
		static public function enBulletPellet(self:FlxSprite):void {
			self.loadGraphic(_bullets, true, false, 5, 8);
			self.frame = 2;
			self.height = 5;
			self.centerOffsets();
			
			var basic:Basic = self as Basic;
			if (basic) {
				basic.center.make(2, 4);
				basic.radius = 1.8;
			}
		}
		static public function enBulletBucky(self:FlxSprite):void {
			self.loadGraphic(_bullets, true, false, 5, 8);
			self.frame = 3;
			
			var basic:Basic = self as Basic;
			if (basic) {
				basic.center.make(2, 3);
				basic.radius = 2.5;
			}
		}
		
		static public function bossLaserBullet(self:Basic):void {
			self.loadGraphic(_bsLaserBullet, false, false, 32, 32);
			self.center.make(16, 16);
			self.radius = 14;
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
			}
		}
		static public function explosionGFX(self:FlxSprite):void {
			self.loadGraphic(_explosion, true, false, 16, 16);
			if (!self.play("explode")) {
				self.addAnimation("detonate", [0, 1, 2, 3, 4, 5], 8, false);
			}
		}
		
		static public function lifeiconGFX(self:FlxSprite):void {
			self.loadGraphic(_life, true, false, 8, 8);
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
			menu._space.loadGraphic(_space);
			menu._R.loadGraphic(_title_R);
			menu._I.loadGraphic(_title_I);
			menu._F.loadGraphic(_title_F);
			menu._T.loadGraphic(_title_T);
		}
	}
}
