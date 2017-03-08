package plShooters {
	
	import basics.Bullet;
	import basics.Player;
	import basics.Spawner;
	import utils.Resources;
	
	/**
	 * ...
	 * @author GFM
	 */
	public class PlSpike extends Spawner {
		
		private function create(x:Number, y:Number, tgtX:Number, tgtY:Number):void {
			var b:Bullet = reg.plBullets.recycle(Bullet) as Bullet;
			var speed:Number = reg.plBlSpeed;
			b.reset(x, y);
			b.plSpike();
			b.damage = reg.plDamage*0.6;
			
			var vx:Number = tgtX - x;
			var vy:Number = tgtY - y;
			var h:Number = 1 / Math.sqrt(vx*vx + vy*vy);
			
			b.velocity.x = speed * vx * h;
			b.velocity.y = speed * vy * h;
		}
		
		override protected function spawn():void {
			var pos:Player = reg.player;
			var x:Number = pos.x + pos.center.x;
			var y:Number = pos.y;
			var tgtY:Number = pos.y - 64;
			
			create(x-7.5, y+5, x, tgtY);
			create(x, y, x, tgtY);
			create(x+7.5, y+5, x, tgtY);
		}
		
		override public function revive():void {
			super.revive();
			wakeup(0.6, 0.5, 0.2);
		}
	}
}
