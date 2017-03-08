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
	public class EnTargeted extends Spawner {
		
		private var parent:FlxObject;
		
		override protected function spawn():void {
			var x:Number = parent.x +parent.width / 2;
			var y:Number = parent.y;
			var b:Bullet = Registry.enBullets.recycle(Bullet) as Bullet;
			var pl:Player = Registry.player;
			var speed:Number = Registry.enBlSpeed;
			
			b.reset(x, y);
			b.ID = Registry.ENBULLETID;
			Resources.enBulletPellet(b);
			
			var vy:Number = (pl.y + pl.height*0.5) - (b.y + b.height*0.5);
			var vx:Number = (pl.x + pl.width * 0.5) - (b.x + b.width * 0.5);
			var norm:Number = vx*vx + vy*vy;
			norm = 1 / Math.sqrt(norm);
			
			b.velocity.x = speed * vx * norm;
			b.velocity.y = speed * vy * norm;
		}
		
		override public function revive():void {
			super.revive();
			wakeup(1.25, 0.2, 0.1);
		}
		
		override public function setParent(o:FlxObject):void {
			parent = o;
		}
	}
}
