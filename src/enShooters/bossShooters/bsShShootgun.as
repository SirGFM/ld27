package enShooters.bossShooters {
	
	import basics.Bullet;
	import basics.Spawner;
	import org.flixel.FlxG;
	import org.flixel.FlxObject;
	import utils.Registry;
	import utils.Resources;
	
	/**
	 * ...
	 * @author GFM
	 */
	public class bsShShootgun extends Spawner {
		
		private var parent:FlxObject;
		
		override protected function spawn():void {
			var b:Bullet;
			var X:Number = parent.x + parent.width/2 - 6;
			var Y:Number = parent.y;
			var W:Number = (parent.width - 12) / 9;
			var v:Number = reg.enBlSpeed;
			
			var ang:Number = (75 + (FlxG.random() * 100 % 50 - 25)) * Math.PI / 180;
			var dang:Number = 75 * Math.PI / 180 / 9;
			X += 2 * W;
			
			var i:int = 0;
			while (i < 9 ) {
				create(X, Y, v, ang);
				X += W;
				ang += dang;
				i++;
			}
		}
		
		private function create(X:Number, Y:Number, v:Number, ang:Number):void {
			var b:Bullet = reg.enBullets.recycle(Bullet) as Bullet;
			b.reset(X, Y);
			b.enBucky();
			b.velocity.x = v*Math.cos(ang);
			b.velocity.y = v*Math.sin(ang);
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