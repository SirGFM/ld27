package plShooters {
	
	import basics.Bullet;
	import basics.Player;
	import basics.Spawner;
	import org.flixel.FlxG;
	import utils.Resources;
	
	/**
	 * ...
	 * @author GFM
	 */
	public class PlLaserBurst extends Spawner {
		
		private function create(x:Number, y:Number):void {
			var b:Bullet = reg.plBullets.recycle(Bullet) as Bullet;
			b.plLaser();
			b.reset(x-b.center.x, y-b.center.y);
			b.immortal = true;
			b.damage = reg.plDamage / 10;
			b.velocity.y = -reg.plBlSpeed;
		}
		
		override protected function spawn():void {
			var pos:Player = reg.player;
			var x:Number = pos.x + pos.center.x;
			var y:Number = pos.y;
			
			create(x - 3.5, y);
			create(x + 3.5, y);
		}
		
		override public function revive():void {
			super.revive();
			super.wakeup(0.3, 0.3, 0.15);
		}
	}
}
