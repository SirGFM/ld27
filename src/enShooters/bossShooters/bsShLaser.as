package enShooters.bossShooters {
	
	import basics.Bullet;
	import basics.Spawner;
	import org.flixel.FlxObject;
	import utils.Registry;
	import utils.Resources;
	
	import basics.Spawner;
	
	/**
	 * ...
	 * @author GFM
	 */
	public class bsShLaser extends Spawner {
		
		private var parent:FlxObject;
		
		public function bsShLaser() {
			super()
		}
		
		override protected function spawn():void {
			var b:Bullet;
			var X:Number = parent.x + parent.width/2 - 16;
			var Y:Number = parent.y + 10;
			
			create(X, Y, Registry.enBlSpeed);
		}
		
		private function create(X:Number, Y:Number, v:Number):void {
			var b:Bullet = Registry.enBullets.recycle(Bullet) as Bullet;
			b.reset(X, Y);
			b.ID = Registry.ENBULLETID;
			Resources.bossLaserBullet(b);
			b.velocity.x = 0;
			b.velocity.y = v;
		}
		
		override public function revive():void {
			super.revive();
			wakeup(0.075, 0.075, 0.075);
		}
		
		override public function setParent(o:FlxObject):void {
			parent = o;
		}
	}
}
