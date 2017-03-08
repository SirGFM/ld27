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
	public class EnTurret extends Spawner {
		
		private var parent:FlxObject;
		
		override protected function spawn():void {
			var x:Number = parent.x+4;
			var y:Number = parent.y;
			var v:Number = reg.enBlSpeed;
			var w:Number = (parent.width-8)/2;
			
			create(x, y, v);
			x += w;
			create(x, y, v);
		}
		
		private function create(x:Number, y:Number, v:Number):void {
			var b:Bullet = reg.enBullets.recycle(Bullet) as Bullet;
			b.reset(x, y);
			b.velocity.y = v;
			b.enPellet();
		}
		
		override public function revive():void {
			super.revive();
			wakeup(0.5, 0.5, 0.5);
		}
		
		override public function setParent(o:FlxObject):void {
			parent = o;
		}
	}
}
