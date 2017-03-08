package basics {
	
	import org.flixel.FlxG;
	import org.flixel.FlxParticle;
	import utils.Resources;
	import utils.Sounds;
	
	/**
	 * ...
	 * @author GFM
	 */
	public class ExplosionParticle extends FlxParticle {
		
		private var timer:Number;
		
		public function ExplosionParticle() {
			super();
			allowCollisions = NONE;
			Resources.explosionGFX(this);
		}
		
		override public function update():void {
			super.update();
			if (finished) {
				timer -= FlxG.elapsed;
				if (timer <= 0)
					kill();
			}
		}
		
		override public function onEmit():void {
			super.onEmit();
			play("detonate");
			timer = 2;
			Sounds.playExplosion();
		}
	}
}
