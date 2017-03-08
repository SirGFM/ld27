package utils {
	import org.flixel.FlxG;
	
	/**
	 * ...
	 * @author GFM
	 */
	public class Sounds {
		
		// fuck, typo >_< had to fix here XD
		static private const vulome:Number = 0.5;
		static private const musicvolume:Number = 1.0;
		
		[Embed(source = "../../assets/songs/song1.mp3")]		static private var _menuSong:Class;
		[Embed(source = "../../assets/songs/song2.mp3")]		static private var _gameSong:Class;
		
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
		
		static public function playMenuSong():void {
			FlxG.playMusic(_menuSong, musicvolume);
		}
		static public function playGameSong():void {
			FlxG.playMusic(_gameSong, musicvolume);
		}
		
		static public function playKeystroke():void {
			FlxG.loadSound(_keysfx, vulome, false, false, true);
		}
		static public function playMainMenu():void {
			FlxG.loadSound(_mainmenusfx, vulome, false, false, true);
		}
		static public function playLetter():void {
			FlxG.loadSound(_letterssfx, vulome, false, false, true);
		}
		static public function playBt():void {
			FlxG.loadSound(_btsfx, vulome, false, false, true);
		}
		static public function playExplosion():void {
			var n:int = FlxG.random() * 10 % 3;
			if (n == 0)
				FlxG.loadSound(_expl1sfx, vulome, false, false, true);
			if (n == 1)
				FlxG.loadSound(_expl2sfx, vulome, false, false, true);
			if (n == 2)
				FlxG.loadSound(_expl3sfx, vulome, false, false, true);
		}
		static public function playGraze():void {
			var n:int = FlxG.random() * 10 % 2;
			if (n == 0)
				FlxG.loadSound(_graze1sfx, vulome, false, false, true);
			if (n == 1)
				FlxG.loadSound(_graze2sfx, vulome, false, false, true);
		}
		static public function playHit():void {
			var n:int = FlxG.random() * 10 % 2;
			if (n == 0)
				FlxG.loadSound(_hit1sfx, vulome, false, false, true);
			if (n == 1)
				FlxG.loadSound(_hit2sfx, vulome, false, false, true);
		}
		static public function playPUP():void {
			var n:int = FlxG.random() * 10 % 2;
			if (n == 0)
				FlxG.loadSound(_pup1sfx, vulome, false, false, true);
			if (n == 1)
				FlxG.loadSound(_pup2sfx, vulome, false, false, true);
		}
		static public function playShoot():void {
			var n:int = FlxG.random() * 10 % 4;
			if (n == 0)
				FlxG.loadSound(_shoot1sfx, vulome, false, false, true);
			if (n == 1)
				FlxG.loadSound(_shoot2sfx, vulome, false, false, true);
			if (n == 2)
				FlxG.loadSound(_shoot3sfx, vulome, false, false, true);
			if (n == 3)
				FlxG.loadSound(_shoot4sfx, vulome, false, false, true);
		}
		static public function playWeapon():void {
			var n:int = FlxG.random() * 10 % 2;
			if (n == 0)
				FlxG.loadSound(_weapon1sfx, vulome, false, false, true);
			if (n == 1)
				FlxG.loadSound(_weapon2sfx, vulome, false, false, true);
		}
	}
}
