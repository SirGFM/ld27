package plShooters {
	
	import basics.Bullet;
	import basics.Player;
	import basics.Spawner;
	
	/**
	 * ...
	 * @author GFM
	 */
	public class PlBomb extends Spawner {
		
		override protected function spawn():void {
			var pos:Player = reg.player;
			var b:Bullet = reg.plBullets.recycle(Bullet) as Bullet;
			b.reset(pos.x+pos.center.x, pos.y+pos.center.y);
			
		}
		
		override public function revive():void {
			super.revive();
			super.wakeup(0.8, 0.2, 0.1);
		}
	}
}
