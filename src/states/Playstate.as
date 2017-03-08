package states {
	
	import basics.Basic;
	import basics.ExplosionParticle;
	import basics.MyParticle;
	import basics.Player;
	import basics.Spawner;
	import collectibles.TypePUP;
	import enemiesPkg.BasicEnemy;
	import enemiesPkg.HalfTurnEnemy;
	import objs.Boss;
	import org.flixel.FlxEmitter;
	import org.flixel.FlxG;
	import org.flixel.FlxGroup;
	import org.flixel.FlxObject;
	import org.flixel.FlxParticle;
	import org.flixel.FlxSprite;
	import org.flixel.FlxState;
	import org.flixel.FlxU;
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
			var pl:Player = Registry.player;
			pl.reset(128, 200);
			var plBullets:FlxGroup = new FlxGroup();
			var enemies:FlxGroup = new FlxGroup();
			var enBullets:FlxGroup = new ZDrawer();
			var collectibles:FlxGroup = new FlxGroup();
			
			var particle:FlxParticle;
			var plEmitter:FlxEmitter = new FlxEmitter(0, 0, 64);
			var eneEmitter:FlxEmitter = new FlxEmitter(0, 0, 16);
			var explParticles:FlxEmitter = new FlxEmitter(0, 0, 64);
			plEmitter.setRotation(0, 0);
			plEmitter.setXSpeed(0, 0);
			plEmitter.setYSpeed(0, 0);
			eneEmitter.setRotation(0, 0);
			eneEmitter.setXSpeed(0, 0);
			eneEmitter.setYSpeed(0, 0);
			explParticles.setRotation(0, 0);
			explParticles.setXSpeed(-20, 20);
			explParticles.setYSpeed(-20, 20);
			var i:int = 0;
			while (i < 64) {
				particle = new MyParticle();
				particle.ID = Registry.PLAYERID;
				particle.kill();
				plEmitter.add(particle);
				i++;
			}
			i = 0;
			while (i < 64) {
				particle = new ExplosionParticle();
				particle.kill();
				explParticles.add(particle);
				i++;
			}
			i = 0;
			while (i < 16) {
				particle = new MyParticle();
				particle.ID = Registry.ENEMYID;
				particle.kill();
				eneEmitter.add(particle);
				i++;
			}
			
			add(waves);
			add(pl);
			add(enemies);
			add(plBullets);
			add(enBullets);
			add(collectibles);
			add(plEmitter);
			add(eneEmitter);
			add(explParticles);
			
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
			
			Registry.waves = waves;
			Registry.plBullets = plBullets;
			Registry.player = pl;
			Registry.enemies = enemies;
			Registry.enBullets = enBullets;
			Registry.plParticles = plEmitter;
			Registry.eneParticles = eneEmitter;
			Registry.collectibles = collectibles;
			Registry.explParticles = explParticles;
			Registry.lifeCounter = lc;
			Registry.score = sc;
			Registry.specialCounter = sc2;
			Registry.messageBox = mb;
			
			Sounds.playGameSong();
			
			gameover = false;
			fading = false;
		}
		
		override public function update():void {
			super.update();
			if (!Registry.player.alive) {
				if (!gameover) {
					gameover = true;
					Registry.messageBox.wakeup(2);
				}
				else if (!Registry.messageBox.alive && !fading) {
					fading = true;
					FlxG.fade(0xff000000, 1, function():void { FlxG.switchState(new Menustate()); } );
				}
			}
			else if (Registry.bossDefeated) {
				if (!gameover) {
					gameover = true;
					Registry.messageBox.wakeup(3);
				}
				else if (!Registry.messageBox.alive && !fading) {
					fading = true;
					Registry.enableZaWarudo = true;
					FlxG.fade(0xff000000, 1, function():void { FlxG.switchState(new Menustate()); } );
				}
			}
			FlxG.overlap(this, null, onOverlap, firstColCheck);
		}
		
		private function onOverlap(obj1:Basic, obj2:Basic):void {
			if ((obj1.ID == Registry.COLLECTIBLEID) && (obj2.ID & Registry.PLAYERID)) {
				if (obj1 is TypePUP)
					Registry.player.type = obj1.frame;
				else
					Registry.player.weapon = obj1.frame;
				obj1.kill();
			}
			else if ((obj2.ID == Registry.COLLECTIBLEID) && (obj1.ID & Registry.PLAYERID)) {
				if (obj2 is TypePUP)
					Registry.player.type = obj2.frame;
				else
					Registry.player.weapon = obj2.frame;
				obj2.kill();
			}
			else if (obj1.ID & Registry.OBJECTID) {
				obj1.hurt(obj2.damage);
				obj2.kill();
				if (obj2.ID & Registry.PLBULLETID) {
					Registry.plParticles.at(obj1);
					Registry.plParticles.emitParticle();
				}
				else if (obj2.ID & Registry.ENBULLETID) {
					Registry.eneParticles.at(obj1);
					Registry.eneParticles.emitParticle();
				}
			}
			else {
				obj2.hurt(obj1.damage);
				obj1.kill();
				if (obj1.ID & Registry.PLBULLETID) {
					Registry.plParticles.at(obj2);
					Registry.plParticles.emitParticle();
				}
				else if (obj1.ID & Registry.ENBULLETID) {
					Registry.eneParticles.at(obj2);
					Registry.eneParticles.emitParticle();
				}
			}
		}
		
		private function firstColCheck(obj1:FlxObject, obj2:FlxObject):Boolean {
			if (((obj1.ID & obj2.ID) != 0) || (obj1.allowCollisions==FlxObject.NONE) || (obj2.allowCollisions==FlxObject.NONE))
				return false;
			
			var o1:Basic = obj1 as Basic;
			var o2:Basic = obj2 as Basic;
			if (!(o1 ||  o2))
				return false;
			
			var wasHit:Boolean
			
			if (o1 is Boss)
				wasHit = o1.didCollide(o2);
			else
				wasHit = o2.didCollide(o1);
			
			if (!wasHit) {
				if ((o1 is Player) && !o2.grazed) {
					Sounds.playGraze();
					Registry.score.inc(3);
					o2.grazed = true;
				}
				else if ((o2 is Player) && !o1.grazed) {
					Sounds.playGraze();
					Registry.score.inc(3);
					o1.grazed = true;
				}
			}
			
			return wasHit;
		}
	}
}
