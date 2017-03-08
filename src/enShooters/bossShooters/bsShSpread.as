package enShooters.bossShooters {
	
	import basics.Bullet;
	import basics.Spawner;
	import org.flixel.FlxG;
	import org.flixel.FlxObject;
	import org.flixel.FlxU;
	import utils.Registry;
	import utils.Resources;
	
	/**
	 * ...
	 * @author GFM
	 */
	public class bsShSpread extends Spawner {
		
		private var parent:FlxObject;
		
		override protected function spawn():void {
			var b:Bullet;
			var X:Number = parent.x + parent.width/2 - 6;
			var Y:Number = parent.y;
			var v:Number = reg.enBlSpeed/2;
			var n:int = 4 + (FlxG.random()*100) % 6;
			
			while (n > 0) {
				var x:Number = X + FlxG.random() * 12 - 6
				var y:Number = Y + FlxG.random() * 12;
				var vx:Number = FlxG.random() * 1.2 - 0.6;
				var vy:Number = 1 - Math.sqrt(vx*vx);
				create(X, Y, v * vx, v * vy * 0.5);
				n--;
			}
		}
		
		private function create(X:Number, Y:Number, vx:Number, vy:Number):void {
			var b:Bullet = reg.enBullets.recycle(Bullet) as Bullet;
			b.reset(X, Y);
			b.enPellet();
			b.velocity.x = vx;
			b.velocity.y = vy;
		}
		
		override public function revive():void {
			super.revive();
			wakeup(2.50, 0.8, 0.3);
		}
		
		override public function setParent(o:FlxObject):void {
			parent = o;
		}
	}
}
