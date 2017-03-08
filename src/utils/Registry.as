package utils {
	import basics.Player;
	import org.flixel.FlxBasic;
	import org.flixel.FlxEmitter;
	import org.flixel.FlxG;
	import org.flixel.FlxGroup;
	import plugins.LifeCounter;
	import plugins.MessageBox;
	import plugins.Score;
	import plugins.SpecialCounter;
	
	/**
	 * ...
	 * @author GFM
	 */
	public class Registry {
		
		// key definitions (so it can be customizable)
		static public var left:String = "LEFT";
		static public var right:String = "RIGHT";
		static public var up:String = "UP";
		static public var down:String = "DOWN";
		static public var shoot:String = "X";
		static public var special:String = "C";
		
		// constants
		static public const PLAYERID:uint = 1;
		static public const ENEMYID:uint = 2;
		static public const OBJECTID:uint = 3;	// PL | ENE
		static public const BULLETID:uint = 4;
		static public const PLBULLETID:uint = 5;// 1 | BUL
		static public const ENBULLETID:uint = 6;// 2 | BUL
		static public const COLLECTIBLEID:uint = 14;// 8 | BUL | ENE
		static public var plSpeed:Number = 100;
		static public var plDamage:Number = 0.25;
		static public var plHealth:Number = 1;
		static public var plBlSpeed:Number = 175;
		static public var enSpeed:Number = 100;
		static public var enBlSpeed:Number = 175;
		
		// references (easier to acess than make an "static self" on the playstate...)
		static public var waves:FlxGroup = null;
		static public var player:Player = null;
		static public var plBullets:FlxGroup = null;
		static public var enemies:FlxGroup = null;
		static public var enBullets:FlxGroup = null;
		static public var collectibles:FlxGroup = null;
		static public var plParticles:FlxEmitter = null;
		static public var eneParticles:FlxEmitter = null;
		static public var explParticles:FlxEmitter = null;
		
		// plugins
		static public var lifeCounter:LifeCounter = null;
		static public var score:Score = null;
		static public var specialCounter:SpecialCounter = null;
		static public var messageBox:MessageBox = null;
		
		static public var enableZaWarudo:Boolean = false;
		static public var bossDefeated:Boolean = false;
		
		static public function clear():void {
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
			plParticles = null;
			eneParticles = null;
			explParticles = null;
			messageBox = null;
			
			bossDefeated = false;
			
			for each(var p:FlxBasic in FlxG.plugins)
				p.kill();
		}
	}
}
