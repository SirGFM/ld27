package utils {
	import org.flixel.FlxG;
	import org.flixel.FlxSound;
	
	/**
	 * ...
	 * @author GFM
	 */
	public class Sounds {
		
		static public var sfxvolume:Number = 0.5;
		static private var _musicvolume:Number = 1.0;
		
		static private const _sounds:Vector.<Vector.<FlxSound>> = new Vector.<Vector.<FlxSound>>();
		// 0-bt
		_sounds.push(new Vector.<FlxSound>());
		// 1-explosion
		_sounds.push(new Vector.<FlxSound>());
		// 2-graze
		_sounds.push(new Vector.<FlxSound>());
		// 3-hit
		_sounds.push(new Vector.<FlxSound>());
		// 4-keystroke
		_sounds.push(new Vector.<FlxSound>());
		// 5-mainmenu
		_sounds.push(new Vector.<FlxSound>());
		// 6-letters
		_sounds.push(new Vector.<FlxSound>());
		// 7-pup
		_sounds.push(new Vector.<FlxSound>());
		// 8-shoot
		_sounds.push(new Vector.<FlxSound>());
		// 9-weapon
		_sounds.push(new Vector.<FlxSound>());
		// 10-menu opts
		_sounds.push(new Vector.<FlxSound>());
		
		static private var curSong:int = -1;
		[Embed(source = "../../assets/songs/song0_eq_new.mp3")]		static private var _menuSong:Class;
		//[Embed(source = "../../assets/songs/song1.mp3")]		static private var _menuSong:Class;
		[Embed(source = "../../assets/songs/old_song2_eq.mp3")]		static private var _gameSong:Class;
		[Embed(source = "../../assets/songs/song3_new.mp3")]		static private var _bossSong:Class;
		
		[Embed(source = "../../assets/sfx/bt.mp3")]				static private var _btsfx:Class;
		[Embed(source = "../../assets/sfx/explosion1.mp3")]		static private var _expl1sfx:Class;
		[Embed(source = "../../assets/sfx/explosion2.mp3")]		static private var _expl2sfx:Class;
		[Embed(source = "../../assets/sfx/explosion3.mp3")]		static private var _expl3sfx:Class;
		[Embed(source = "../../assets/sfx/graze1.mp3")]			static private var _graze1sfx:Class;
		[Embed(source = "../../assets/sfx/graze2.mp3")]			static private var _graze2sfx:Class;
		[Embed(source = "../../assets/sfx/hit1.mp3")]			static private var _hit1sfx:Class;
		[Embed(source = "../../assets/sfx/hit2.mp3")]			static private var _hit2sfx:Class;
		[Embed(source = "../../assets/sfx/keystroke.mp3")]		static private var _keysfx:Class;
		[Embed(source = "../../assets/sfx/mainmenu.mp3")]		static private var _mainmenusfx:Class;
		[Embed(source = "../../assets/sfx/menuLetter.mp3")]		static private var _letterssfx:Class;
		[Embed(source = "../../assets/sfx/pup1.mp3")]			static private var _pup1sfx:Class;
		[Embed(source = "../../assets/sfx/pup2.mp3")]			static private var _pup2sfx:Class;
		[Embed(source = "../../assets/sfx/shoot1.mp3")]			static private var _shoot1sfx:Class;
		[Embed(source = "../../assets/sfx/shoot2.mp3")]			static private var _shoot2sfx:Class;
		[Embed(source = "../../assets/sfx/shoot3.mp3")]			static private var _shoot3sfx:Class;
		[Embed(source = "../../assets/sfx/shoot4.mp3")]			static private var _shoot4sfx:Class;
		[Embed(source = "../../assets/sfx/weapon1.mp3")]		static private var _weapon1sfx:Class;
		[Embed(source = "../../assets/sfx/weapon2.mp3")]		static private var _weapon2sfx:Class;
		[Embed(source = "../../assets/sfx/menu2.mp3")]			static private var _menuoptsfx:Class;
		
		static public function get musicvolume():Number {
			return _musicvolume;
		}
		static public function set musicvolume(value:Number):void {
			_musicvolume = value;
			if (FlxG.music)
				FlxG.music.volume = value;
		}
		
		static public function playMenuSong():void {
			if (curSong == 0)
				return;
			curSong = 0;
			FlxG.playMusic(_menuSong, _musicvolume);
		}
		static public function playGameSong():void {
			if (curSong == 1)
				return;
			curSong = 1;
			FlxG.playMusic(_gameSong, _musicvolume);
		}
		static public function playBossSong():void {
			if (curSong == 2)
				return;
			curSong = 2;
			FlxG.playMusic(_bossSong, _musicvolume);
		}
		
		static public function playKeystroke():void {
			var s:FlxSound = getSoundFrom(4);
			if (s) {
				s.volume = sfxvolume;
				s.play(true);
			}
			else
				pushSoundInto(4, FlxG.loadSound(_keysfx, sfxvolume, false, false, true));
		}
		static public function playMainMenu():void {
			var s:FlxSound = getSoundFrom(5);
			if (s) {
				s.volume = sfxvolume;
				s.play(true);
			}
			else
				pushSoundInto(5, FlxG.loadSound(_mainmenusfx, sfxvolume, false, false, true));
		}
		static public function playLetter():void {
			var s:FlxSound = getSoundFrom(6);
			if (s) {
				s.volume = sfxvolume;
				s.play(true);
			}
			else
				pushSoundInto(6, FlxG.loadSound(_letterssfx, sfxvolume, false, false, true));
		}
		static public function playBt():void {
			var s:FlxSound = getSoundFrom(0);
			if (s) {
				s.volume = sfxvolume;
				s.play(true);
			}
			else
				pushSoundInto(0, FlxG.loadSound(_btsfx, sfxvolume, false, false, true));
		}
		static public function playExplosion():void {
			var s:FlxSound = getSoundFrom(1);
			if (s) {
				s.volume = sfxvolume;
				s.play(true);
			}
			else {
				var n:int = FlxG.random() * 10 % 3;
				if (n == 0)
					s = FlxG.loadSound(_expl1sfx, sfxvolume, false, false, true);
				else if (n == 1)
					s = FlxG.loadSound(_expl2sfx, sfxvolume, false, false, true);
				else if (n == 2)
					s = FlxG.loadSound(_expl3sfx, sfxvolume, false, false, true);
				pushSoundInto(1, s);
			}
		}
		static public function playGraze():void {
			var s:FlxSound = getSoundFrom(2);
			if (s) {
				s.volume = sfxvolume;
				s.play(true);
			}
			else {
				var n:int = FlxG.random() * 10 % 2;
				if (n == 0)
					s = FlxG.loadSound(_graze1sfx, sfxvolume, false, false, true);
				else if (n == 1)
					s = FlxG.loadSound(_graze2sfx, sfxvolume, false, false, true);
				pushSoundInto(2, s);
			}
		}
		static public function playHit():void {
			var s:FlxSound = getSoundFrom(3);
			if (s) {
				s.volume = sfxvolume;
				s.play(true);
			}
			else {
				var n:int = FlxG.random() * 10 % 2;
				if (n == 0)
					s = FlxG.loadSound(_hit1sfx, sfxvolume, false, false, true);
				else if (n == 1)
					s = FlxG.loadSound(_hit2sfx, sfxvolume, false, false, true);
				pushSoundInto(3, s);
			}
		}
		static public function playPUP():void {
			var s:FlxSound = getSoundFrom(7);
			if (s) {
				s.volume = sfxvolume;
				s.play(true);
			}
			else {
				var n:int = FlxG.random() * 10 % 2;
				if (n == 0)
					s = FlxG.loadSound(_pup1sfx, sfxvolume, false, false, true);
				else if (n == 1)
					s = FlxG.loadSound(_pup2sfx, sfxvolume, false, false, true);
				pushSoundInto(7, s);
			}
		}
		static public function playShoot():void {
			var s:FlxSound = getSoundFrom(8);
			if (s) {
				s.volume = sfxvolume;
				s.play(true);
			}
			else {
				var n:int = FlxG.random() * 10 % 4;
				if (n == 0)
					s = FlxG.loadSound(_shoot1sfx, sfxvolume, false, false, true);
				else if (n == 1)
					s = FlxG.loadSound(_shoot2sfx, sfxvolume, false, false, true);
				else if (n == 2)
					s = FlxG.loadSound(_shoot3sfx, sfxvolume, false, false, true);
				else if (n == 3)
					s = FlxG.loadSound(_shoot4sfx, sfxvolume, false, false, true);
				pushSoundInto(8, s);
			}
		}
		static public function playWeapon():void {
			var s:FlxSound = getSoundFrom(9);
			if (s) {
				s.volume = sfxvolume;
				s.play(true);
			}
			else {
				var n:int = FlxG.random() * 10 % 2;
				if (n == 0)
					s = FlxG.loadSound(_weapon1sfx, sfxvolume, false, false, true);
				else if (n == 1)
					s = FlxG.loadSound(_weapon2sfx, sfxvolume, false, false, true);
				pushSoundInto(9, s);
			}
		}
		static public function playMenuOption():void {
			var s:FlxSound = getSoundFrom(10);
			if (s) {
				s.volume = sfxvolume;
				s.play(true);
			}
			else
				pushSoundInto(10, FlxG.loadSound(_menuoptsfx, sfxvolume, false, false, true));
		}
		
		static private function getSoundFrom(n:uint):FlxSound {
			var v:Vector.<FlxSound> = _sounds[n];
			var i:int = 0;
			var l:int = v.length;
			while (i < l) {
				var s:FlxSound = v[i++];
				if (!s.active)
					return s;
			}
			return null;
		}
		static private function pushSoundInto(n:uint, s:FlxSound):void {
			s.survive = true;
			_sounds[n].push(s);
		}
	}
}
