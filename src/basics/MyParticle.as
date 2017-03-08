package basics {
	
	import org.flixel.FlxParticle;
	import utils.Registry;
	import utils.Resources;
	import utils.Sounds;
	
	/**
	 * ...
	 * @author GFM
	 */
	public class MyParticle extends FlxParticle {
		
		public function MyParticle() {
			super();
			allowCollisions = NONE;
			Resources.hitGFX(this);
		}
		
		override public function update():void {
			super.update();
			if (finished)
				kill();
		}
		
		override public function onEmit():void {
			super.onEmit();
			if (ID & Registry.PLAYERID)
				play("hitEnemy");
			else if (ID & Registry.ENEMYID)
				play("hitPlayer");
			Sounds.playHit();
		}
	}
}
