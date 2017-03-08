package basics {
	
	import org.flixel.FlxG;
	import particlesPkg.MyParticle;
	import utils.Registry;
	import utils.Resources;
	import utils.Sounds;
	
	/**
	 * ...
	 * @author GFM
	 */
	public class Bullet extends Basic {
		
		public var immortal:Boolean;
		public var target:Basic;
		public var speed:Number;
		private var alphaTgt:Number;
		
		public function Bullet() {
			super();
			Resources.bulletGFX(this);
		}
		
		override public function update():void {
			if (target) {
				if (!target.alive)
					target = null;
				else {
					if (alphaTgt < 1)
						alphaTgt += FlxG.elapsed;
					target.targetThis(this, speed, alphaTgt);
				}
			}
			super.update();
		}
		
		override public function kill():void {
			if (!diedOnExit) {
				if (ID & CONST::ENEMYID)
					reg.hitParticles.emitPlBullet(this);
				else if (ID & CONST::PLAYERID)
					reg.hitParticles.emitEnBullet(this);
			}
			if (diedOnExit || !immortal)
				super.kill();
		}
		
		override public function reset(X:Number, Y:Number):void {
			super.reset(X, Y);
			health = 1000;
			damage = 1;
			immortal = false;
			target = null;
			alphaTgt = 0;
			speed = 0;
			Sounds.playShoot();
		}
		
		public function bsLaser():void {
			width = frameWidth = 32;
			height = frameHeight = 32;
			resetHelpers();
			frame = 0;
			
			center.make(16, 16);
			radius = 14;
			ID = CONST::ENBULLETID;
		}
		public function plPellet():void {
			width = frameWidth = 5;
			height = frameHeight = 8;
			resetHelpers();
			frame = 28;
			
			center.make(2, 4);
			radius = 2.25;
			ID = CONST::PLBULLETID;
		}
		public function plSpike():void {
			width = frameWidth = 5;
			height = frameHeight = 8;
			resetHelpers();
			frame = 29;
			
			center.make(2, 4);
			radius = 2.75;
			ID = CONST::PLBULLETID;
		}
		public function plBucky():void {
			width = frameWidth = 5;
			height = frameHeight = 8;
			resetHelpers();
			frame = 30;
			
			center.make(2, 3);
			radius = 2.75;
			ID = CONST::PLBULLETID;
		}
		public function plLaser():void {
			width = frameWidth = 5;
			height = frameHeight = 8;
			resetHelpers();
			frame = 31;
			
			center.make(3, 3.5);
			radius = 3;
			ID = CONST::PLBULLETID;
		}
		public function enPellet():void {
			width = frameWidth = 5;
			height = frameHeight = 8;
			resetHelpers();
			frame = 32;
			
			center.make(2, 4);
			radius = 1.8;
			ID = CONST::ENBULLETID;
		}
		public function enBucky():void {
			width = frameWidth = 5;
			height = frameHeight = 8;
			resetHelpers();
			frame = 33;
			
			center.make(2, 3);
			radius = 2.2;
			ID = CONST::ENBULLETID;
		}
		public function enSpike():void {
			width = frameWidth = 5;
			height = frameHeight = 8;
			resetHelpers();
			frame = 34;
			
			center.make(2, 4);
			radius = 2.2;
			ID = CONST::ENBULLETID;
		}
		public function enLaser():void {
			width = frameWidth = 5;
			height = frameHeight = 8;
			resetHelpers();
			frame = 35;
			
			center.make(3, 3.5);
			radius = 2.25;
			ID = CONST::ENBULLETID;
		}
	}
}
