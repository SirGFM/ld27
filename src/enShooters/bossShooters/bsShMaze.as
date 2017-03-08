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
	public class bsShMaze extends Spawner {
		
		private var parent:FlxObject;
		private var isLeft:Boolean;
		
		public function bsShMaze(Left:Boolean):void {
			super();
			isLeft = Left;
		}
		
		override protected function spawn():void {
			var b:Bullet;
			var X:Number = parent.x;
			var Y:Number = parent.y;
			var v:Number = reg.enBlSpeed;
			
			if (time > 1.2) {
				X += 6;
				if (isLeft)
					Y += 20;
				else
					Y += 8;
			}
			else
				if (!isLeft)
					Y += 20;
				else
					Y += 8;
			
			create(X, Y, v);
		}
		
		private function create(X:Number, Y:Number, v:Number):void {
			var b:Bullet = reg.enBullets.recycle(Bullet) as Bullet;
			b.reset(X, Y);
			b.enBucky();
			b.velocity.x = 0;
			b.velocity.y = v;
		}
		
		override public function revive():void {
			super.revive();
			wakeup(1.8, 1.2, 0.15);
		}
		
		override public function setParent(o:FlxObject):void {
			parent = o;
		}
	}
}
