package utils {
	import basics.Player;
	import flash.display.Stage;
	import org.flixel.FlxBasic;
	import org.flixel.FlxEmitter;
	import org.flixel.FlxG;
	import org.flixel.FlxGroup;
	import particlesPkg.ExplosionEmitter;
	import particlesPkg.HitEmitter;
	import particlesPkg.ThrottleEmitter;
	import plugins.LifeCounter;
	import plugins.MessageBox;
	import plugins.Score;
	import plugins.SpecialCounter;
	
	/**
	 * ...
	 * @author GFM
	 */
	public class Registry {
		
		static public const self:Registry = new Registry;
		
		public var menuBg:FlxGroup = null;
		
		public var stage:Stage = null;
		
		// options stuff
		private var _life:int = 3;
		private var _music:int = 4;
		private var _sfx:int = 2;
		private var _fps:int = 0;
		private var _dps:int = 0;		// draws-per-second
		
		public function set life(val:int):void {
			_life = val;
			if (_life > 4)
				_life = 0;
			else if (_life < 0)
				_life = 4;
		}
		public function get life():int {
			return _life;
		}
		public function set fps(val:int):void {
			_fps = val;
			if (_fps == 1)
				FlxG.framerate = 60;
			else
				FlxG.framerate = 30;
			
		}
		public function get fps():int {
			return _fps;
		}
		public function set dps(val:int):void {
			_dps = val;
			if (_dps == 1)
				FlxG.flashFramerate = 60;
			else
				FlxG.flashFramerate = 30;
			
		}
		public function get dps():int {
			return _dps;
		}
		public function set music(val:int):void {
			_music = val;
			if (_music > 4)
				_music = 0;
			else if (_music < 0)
				_music = 4;
			Sounds.musicvolume = _music / 4;
		}
		public function get music():int {
			return _music;
		}
		public function set sfx(val:int):void {
			_sfx = val;
			if (_sfx > 4)
				_sfx = 0;
			else if (_sfx < 0)
				_sfx = 4;
			Sounds.sfxvolume = _sfx / 4;
		}
		public function get sfx():int {
			return _sfx;
		}
		
		// key definitions (so it can be customizable)
		public var left:String = "LEFT";
		public var right:String = "RIGHT";
		public var up:String = "UP";
		public var down:String = "DOWN";
		public var focus:String = "SHIFT";
		public var shoot:String = "X";
		public var special:String = "SPACE";
		
		public var plSpeed:Number = 100;
		public var plDamage:Number = 0.25;
		public var plHealth:Number = 1;
		public var plBlSpeed:Number = 175;
		public var enSpeed:Number = 100;
		public var enBlSpeed:Number = 150;
		
		// references (easier to acess than make an "static self" on the playstate...)
		public var waves:FlxGroup = null;
		public var player:Player = null;
		public var plBullets:FlxGroup = null;
		public var enemies:FlxGroup = null;
		public var enBullets:FlxGroup = null;
		public var collectibles:FlxGroup = null;
		public var hitParticles:HitEmitter = null;
		public var explParticles:ExplosionEmitter = null;
		
		// plugins
		public var lifeCounter:LifeCounter = null;
		public var score:Score = null;
		public var specialCounter:SpecialCounter = null;
		public var messageBox:MessageBox = null;
		
		public var enableZaWarudo:Boolean = false;
		public var bossDefeated:Boolean = false;
		
		public function garbagecollect(plbul:Boolean=true, ene:Boolean=true, enbul:Boolean=true, col:Boolean=true):void {
			var item:FlxBasic;
			if (plbul) {
				for each (item in plBullets) {
					if (!item.exists)
						plBullets.remove(item, true);
				}
			}
			if (ene) {
				for each (item in enemies) {
					if (!item.exists)
						enemies.remove(item, true);
				}
			}
			if (enbul) {
				for each (item in enBullets) {
					if (!item.exists)
						enBullets.remove(item, true);
				}
			}
			if (col) {
				for each (item in collectibles) {
					if (!item.exists)
						collectibles.remove(item, true);
				}
			}
		}
		
		public function clear():void {
			left = "LEFT";
			right = "RIGHT";
			up = "UP";
			down = "DOWN";
			shoot = "X";
			special = "C";
			
			waves = null;
			player = null;
			plBullets = null;
			enemies = null;
			enBullets = null;
			collectibles = null;
			hitParticles = null;
			explParticles = null;
			messageBox = null;
			
			bossDefeated = false;
			
			for each(var p:FlxBasic in FlxG.plugins)
				p.kill();
		}
	}
}
