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
			var pl:Player = Registry.player;
			var x:Number = pl.x+2;
			var y:Number = pl.y;
			var v:Number = Registry.plBlSpeed;
			var w:Number = (pl.width-4)/2;
			
			create(x, y, v);
			x += w;
			create(x, y, v);
		}
		
		private function create(x:Number, y:Number, v:Number):void {
			var b:Bullet = Registry.plBullets.recycle(Bullet) as Bullet;
			b.reset(x, y);
			b.velocity.y = -v;
			b.ID = Registry.PLBULLETID;
			b.damage = Registry.plDamage*0.5;
			Resources.plBulletPellet(b);
		}
		
		override public function revive():void {
			super.revive();
			wakeup(0.3, 0.3, 0.05);
		}
	}
}
