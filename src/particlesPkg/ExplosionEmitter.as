package particlesPkg {
	
	import org.flixel.FlxEmitter;
	import org.flixel.FlxParticle;
	
	/**
	 * ...
	 * @author GFM
	 */
	public class ExplosionEmitter extends FlxEmitter {
		
		public function ExplosionEmitter(max:uint = 64) {
			super(0, 0, max);
			setRotation(0, 0);
			setXSpeed(-60, 60);
			setYSpeed(-60, 60);
			
			var i:int = 0;
			while (i < max) {
				var particle:FlxParticle = new ExplosionParticle();
				particle.kill();
				add(particle);
				i++;
			}
		}
	}
}
