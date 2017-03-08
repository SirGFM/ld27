package plShooters {
	
	import basics.Bullet;
	import basics.Player;
	import basics.Spawner;
	import utils.Registry;
	import utils.Resources;
	
	/**
	 * ...
	 * @author GFM
	 */
	public class PlTurret extends Spawner {
		
		override protected function spawn():void {
			var pl:Player = reg.player;
			var x:Number = pl.x+2;
			var y:Number = pl.y;
			var v:Number = reg.plBlSpeed;
			var w:Number = (pl.width-4)/2;
			
			create(x, y, v);
			x += w;
			create(x, y, v);
		}
		
		private function create(x:Number, y:Number, v:Number):void {
			var b:Bullet = reg.plBullets.recycle(Bullet) as Bullet;
			b.plPellet();
			b.reset(x-b.center.x, y-b.center.y);
			b.velocity.y = -v;
			b.damage = reg.plDamage*0.5;
		}
		
		override public function revive():void {
			super.revive();
			wakeup(0.3, 0.26, 0.05);
		}
	}
}
