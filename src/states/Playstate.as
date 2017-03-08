package states {
	
	import basics.Basic;
	import basics.Boss;
	import basics.Bullet;
	import basics.Player;
	import basics.Spawner;
	import collectibles.TypePUP;
	import enemiesPkg.BasicEnemy;
	import enemiesPkg.HalfTurnEnemy;
	import org.flixel.FlxEmitter;
	import org.flixel.FlxG;
	import org.flixel.FlxGroup;
	import org.flixel.FlxObject;
	import org.flixel.FlxParticle;
	import org.flixel.FlxSprite;
	import org.flixel.FlxState;
	import org.flixel.FlxU;
	import particlesPkg.ExplosionEmitter;
	import particlesPkg.ExplosionParticle;
	import particlesPkg.HitEmitter;
	import particlesPkg.MyParticle;
	import particlesPkg.ThrottleEmitter;
	import players.ZW_TOT;
	import plugins.LifeCounter;
	import plugins.MessageBox;
	import plugins.Score;
	import plugins.SpecialCounter;
	import plugins.TypePlugin;
	import plugins.WaveController;
	import utils.Registry;
	import utils.Sounds;
	import utils.Starfield;
	import utils.ZDrawer;
	
	/**
	 * ...
	 * @author GFM
	 */
	public class Playstate extends FlxState {
		
		static protected var reg:Registry = Registry.self;
		
		private var collideable:FlxGroup;
		private var gameover:Boolean;
		private var fading:Boolean;
		
		override public function create():void {
			FlxG.bgColor = 0xff48444c;
			
			var bg:FlxSprite;
			bg = new FlxSprite();
			bg.makeGraphic(256, 256, 0);
			bg.pixels.perlinNoise(256, 256, 8, FlxG.random(), false, true, 7, true);
			bg.color = 0xff8d888f;
			bg.dirty = true;
			add(bg);
			
			var sf:Starfield;
			sf = new Starfield(312, 256, 0.0025, 5);
			sf.allowCollisions = FlxObject.NONE;
			sf.velocity.y = 150;
			sf.x = -18;
			sf.alpha = 0.6;
			add(sf);
			sf = new Starfield(312, 256, 0.0075, 4);
			sf.allowCollisions = FlxObject.NONE;
			sf.velocity.y = 100;
			sf.x = -36;
			sf.alpha = 0.7;
			add(sf);
			sf = new Starfield(312, 256, 0.009, 6);
			sf.allowCollisions = FlxObject.NONE;
			sf.velocity.y = 51;
			sf.x = -54;
			sf.alpha = 0.8;
			add(sf);
			
			var waves:FlxGroup = new FlxGroup();
			waves.visible = false;
			var pl:Player = reg.player;
			pl.reset(128, 200);
			var plBullets:FlxGroup = new FlxGroup();
			var enemies:FlxGroup = new FlxGroup();
			var enBullets:FlxGroup = new ZDrawer();
			var collectibles:FlxGroup = new FlxGroup();
			
			var particle:FlxParticle;
			var hitParticles:HitEmitter = new HitEmitter();
			var explParticles:ExplosionEmitter = new ExplosionEmitter();
			
			collideable = new FlxGroup();
			collideable.add(pl);
			collideable.add(enemies);
			collideable.add(plBullets);
			collideable.add(enBullets);
			collideable.add(collectibles);
			
			add(waves);
			add(enemies);
			add(pl);
			add(plBullets);
			add(enBullets);
			add(collectibles);
			add(explParticles);
			add(hitParticles);
			
			var lc:LifeCounter = FlxG.getPlugin(LifeCounter) as LifeCounter;
			if (!lc)
				lc = FlxG.addPlugin(new LifeCounter()) as LifeCounter;
			lc.wakeup(5, 3);
			
			var sc:Score = FlxG.getPlugin(Score) as Score;
			if (!sc)
				sc = FlxG.addPlugin(new Score) as Score;
			sc.wakeup();
			
			var tp:TypePlugin = FlxG.getPlugin(TypePlugin) as TypePlugin;
			if (!tp)
				tp = FlxG.addPlugin(new TypePlugin) as TypePlugin;
			tp.revive();
			
			var sc2:SpecialCounter = FlxG.getPlugin(SpecialCounter) as SpecialCounter;
			if (!sc2)
				sc2 = FlxG.addPlugin(new SpecialCounter) as SpecialCounter;
			sc2.wakeup();
			
			var wc:WaveController = FlxG.getPlugin(WaveController) as WaveController;
			if (!wc)
				wc = FlxG.addPlugin(new WaveController) as WaveController;
			wc.wakeup(60);
			
			var mb:MessageBox = FlxG.getPlugin(MessageBox) as MessageBox;
			if (!mb)
				mb = FlxG.addPlugin(new MessageBox) as MessageBox;
			mb.wakeup(0);
			
			reg.waves = waves;
			reg.plBullets = plBullets;
			reg.player = pl;
			reg.enemies = enemies;
			reg.enBullets = enBullets;
			reg.hitParticles = hitParticles;
			reg.collectibles = collectibles;
			reg.explParticles = explParticles;
			reg.lifeCounter = lc;
			reg.score = sc;
			reg.specialCounter = sc2;
			reg.messageBox = mb;
			
			Sounds.playGameSong();
			
			gameover = false;
			fading = false;
		}
		
		override public function update():void {
			super.update();
			checkEndGame();
			
			FlxG.overlap(collideable, null, onOverlap, firstColCheck);
		}
		
		private function onOverlap(obj1:Basic, obj2:Basic):void {
			var id1:int = obj1.ID;
			var id2:int = obj2.ID;
			
			if (id1 & id2 || !obj1.alive || !obj2.alive)
				return;
			
			if ((id1 == CONST::COLLECTIBLEID) && (id2 & CONST::PLAYERID)) {
				if (obj1 is TypePUP)
					reg.player.type = obj1.frame;
				else
					reg.player.weapon = obj1.frame;
				obj1.kill();
			}
			else if ((id2 == CONST::COLLECTIBLEID) && (id1 & CONST::PLAYERID)) {
				if (obj2 is TypePUP)
					reg.player.type = obj2.frame;
				else
					reg.player.weapon = obj2.frame;
				obj2.kill();
			}
			else if (id1 & CONST::OBJECTID) {
				obj1.hurt(obj2.damage);
				obj2.kill();
			}
			else if (id2 & CONST::OBJECTID) {
				obj2.hurt(obj1.damage);
				obj1.kill();
			}
		}
		
		private function firstColCheck(obj1:FlxObject, obj2:FlxObject):Boolean {
			if ((obj1.ID & obj2.ID)|| (obj1.allowCollisions == FlxObject.NONE) || (obj2.allowCollisions == FlxObject.NONE))
				return false;
			
			var o1:Basic = obj1 as Basic;
			var o2:Basic = obj2 as Basic;
			if (!(o1 ||  o2))
				return false;
			
			var wasHit:Boolean;
			
			if (o1 is Boss)
				wasHit = o1.didCollide(o2);
			else
				wasHit = o2.didCollide(o1);
			
			if (!wasHit) {
				if ((o1 is Player) && !o2.grazed) {
					reg.score.inc(3);
					o2.grazed = true;
					reg.hitParticles.emitGraze(o1, o2);
				}
				else if ((o2 is Player) && !o1.grazed) {
					reg.score.inc(3);
					o1.grazed = true;
					reg.hitParticles.emitGraze(o2, o1);
				}
			}
			
			return wasHit;
		}
		
		private function getFromID(b1:Basic, b2:Basic, id:int):Basic {
			if (b1.ID == id)
				return b1;
			else if (b2.ID == id)
				return b2;
			return null;
		}
		
		private function checkEndGame():void {
			if (!reg.player.alive) {
				if (!gameover) {
					gameover = true;
					reg.messageBox.wakeup(2);
				}
				else if (!reg.messageBox.alive && !fading) {
					fading = true;
					FlxG.fade(0xff000000, 1, function():void { FlxG.switchState(new Menustate()); } );
				}
			}
			else if (reg.bossDefeated) {
				if (!gameover) {
					gameover = true;
					reg.messageBox.wakeup(3);
				}
				else if (!reg.messageBox.alive && !fading) {
					fading = true;
					reg.enableZaWarudo = true;
					FlxG.fade(0xff000000, 1, function():void { FlxG.switchState(new Menustate()); } );
				}
			}
		}
	}
}
