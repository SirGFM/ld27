package enShooters {
	
	import basics.Bullet;
	import basics.Player;
	import basics.Spawner;
	import org.flixel.FlxObject;
	import utils.Registry;
	import utils.Resources;
	
	/**
	 * ...
	 * @author GFM
	 */
	public class EnWeakTurret extends Spawner {
		
		private var parent:FlxObject;
		
		override protected function spawn():void {
			var x:Number = parent.x;
			var y:Number = parent.y+10;
			var v:Number = reg.enBlSpeed;
			var w:Number = parent.width/2;
			
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
			wakeup(0.6, 0.6, 0.6);
		}
		
		override public function setParent(o:FlxObject):void {
			parent = o;
		}
	}
}
