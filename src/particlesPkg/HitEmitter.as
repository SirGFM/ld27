package particlesPkg {
	
	import basics.Basic;
	import org.flixel.FlxGroup;
	import utils.Sounds;
	
	/**
	 * ...
	 * @author GFM
	 */
	public class HitEmitter extends FlxGroup {
		
		public function HitEmitter(max:uint = 64) {
			super(max);
			
			var i:int = 0;
			while (i < max) {
				add(new MyParticle()).kill();
				i++;
			}
		}
		
		public function emitPlBullet(at:Basic):void {
			var p:MyParticle;
			p = recycle(MyParticle) as MyParticle;
			p.reset(at.x+at.center.x, at.y+at.center.y);
			p.play("hitPlayer");
			Sounds.playHit();
		}
		public function emitEnBullet(at:Basic):void {
			var p:MyParticle;
			p = recycle(MyParticle) as MyParticle;
			p.reset(at.x+at.center.x, at.y+at.center.y);
			p.play("hitEnemy");
			Sounds.playHit();
		}
		public function emitGraze(o1:Basic, o2:Basic):void {
			var p:MyParticle = recycle(MyParticle) as MyParticle;
			
			var x:Number = o1.x + o1.center.x;
			var y:Number = o1.y + o1.center.y;
			var dx:Number = x - (o2.x+o2.center.x);
			var dy:Number = y - (o2.y+o2.center.y);
			
			p.reset(x-dx/2, y-dy/2);
			p.play("graze");
			
			Sounds.playGraze();
		}
	}
}
