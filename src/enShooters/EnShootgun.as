package enShooters {
	
	import basics.Bullet;
	import basics.Spawner;
	import org.flixel.FlxObject;
	import utils.Registry;
	import utils.Resources;
	
	/**
	 * ...
	 * @author GFM
	 */
	public class EnShootgun extends Spawner {
		
		private var parent:FlxObject;
		
		override protected function spawn():void {
			var b:Bullet;
			var X:Number = parent.x;
			var Y:Number = parent.y;
			var W:Number = parent.width / 7;
			var v:Number = reg.enBlSpeed;
			X += 2 * W;
			
			// these angles are all wrong... it's shifted -90 degrees!
			// (0 being to the right and spining counter-clockwise)
			// -15
			create(X, Y, -v*0.26, v*0.97);
			X += W;
			// 0
			create(X, Y, 0, v);
			X += W;
			// 15
			create(X, Y, v*0.26, v*0.97);
		}
		
		private function create(X:Number, Y:Number, vx:Number, vy:Number):void {
			var b:Bullet = reg.enBullets.recycle(Bullet) as Bullet;
			b.reset(X, Y);
			b.enBucky();
			b.velocity.x = vx;
			b.velocity.y = vy;
		}
		
		override public function revive():void {
			super.revive();
			wakeup(0.85, 0.85, 0.85);
		}
		
		override public function setParent(o:FlxObject):void {
			parent = o;
		}
	}
}
