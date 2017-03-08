package plShooters {
	
	import basics.Bullet;
	import basics.Spawner;
	import org.flixel.FlxObject;
	import utils.Registry;
	import utils.Resources;
	
	/**
	 * ...
	 * @author GFM
	 */
	public class PlShootgun extends Spawner {
		
		override protected function spawn():void {
			var b:Bullet;
			var parent:FlxObject = Registry.player
			var X:Number = parent.x;
			var Y:Number = parent.y;
			var W:Number = parent.width / 7;
			var v:Number = Registry.plBlSpeed;
			
			// these angles are all wrong... it's shifted -90 degrees!
			// (0 being to the right and spining counter-clockwise)
			// -45
			create(X, Y, -v*0.71, -v*0.71);
			X += W;
			// -30
			create(X, Y, -v*0.5, -v*0.87);
			X += W;
			// -15
			create(X, Y, -v*0.26, -v*0.97);
			X += W;
			// 0
			create(X, Y, 0, -v);
			X += W;
			// 15
			create(X, Y, v*0.26, -v*0.97);
			X += W;
			// 30
			create(X, Y, v*0.5, -v*0.87);
			X += W;
			// 45
			create(X, Y, v*0.71, -v*0.71);
		}
		
		private function create(X:Number, Y:Number, vx:Number, vy:Number):void {
			var b:Bullet = Registry.plBullets.recycle(Bullet) as Bullet;
			b.reset(X, Y);
			b.ID = Registry.PLBULLETID;
			b.damage = Registry.plDamage*1.5;
			Resources.plBulletBucky(b);
			b.velocity.x = vx;
			b.velocity.y = vy;
		}
		
		override public function revive():void {
			super.revive();
			wakeup(0.3, 0.2, 0.2);
		}
	}
}
