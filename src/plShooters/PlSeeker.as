package plShooters {
	
	import basics.Basic;
	import basics.Bullet;
	import basics.Player;
	import basics.Spawner;
	import utils.Resources;
	
	/**
	 * ...
	 * @author GFM
	 */
	public class PlSeeker extends Spawner {
		
		private function create(x:Number, y:Number, right:Boolean):void {
			var b:Bullet = reg.plBullets.recycle(Bullet) as Bullet;
			b.reset(x, y);
			b.plPellet();
			b.x -= b.radius;
			b.velocity.x = reg.plBlSpeed * 0.866;
			if (right)
				b.velocity.x *= -1;
			b.velocity.y = reg.plBlSpeed * 0.5;
			
			var bas:Basic = reg.enemies.getFirstAlive() as Basic;
			b.target = bas;
			b.speed = reg.plBlSpeed;
			b.damage = reg.plDamage / 5;
		}
		
		override protected function spawn():void {
			var pos:Player = reg.player;
			var x:Number = pos.x + pos.center.x;
			var y:Number = pos.y;
			
			create(x - 4.5, y + 10, false);
			create(x + 4.5, y + 10, true);
		}
		
		override public function revive():void {
			super.revive();
			super.wakeup(0.4, 0.3, 0.075);
		}
	}
}
