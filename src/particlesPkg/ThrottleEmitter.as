package particlesPkg {
	
	import org.flixel.FlxEmitter;
	import org.flixel.FlxObject;
	import org.flixel.FlxU;
	import utils.Resources;
	
	/**
	 * ...
	 * @author GFM
	 */
	public class ThrottleEmitter extends FlxEmitter {
		
		private var _anyDirection:Boolean;
		private var _xWeight:Number;
		private var _yWeight:Number;
		private var _offsetY:Number;
		
		public function ThrottleEmitter(anyDirection:Boolean = true, xWeight:Number = 1, yWeight:Number = 1, offsetY:Number = 0) {
			super();
			makeParticles(Resources.throttleGFX(), 10, 64, true, 0);
			width = 24;
			height = 8;
			start(false, 0.3, 0.01);
			_anyDirection = anyDirection;
			_xWeight = xWeight;
			_yWeight = yWeight;
			_offsetY = offsetY;
		}
		
		public function updateEmitter(o:FlxObject):void {
			if (!on)
				start(false, 0.3, 0.01);
			
			at(o);
			y += _offsetY;
			
			var vx:Number = -o.velocity.x*_xWeight;
			setXSpeed(vx-15, vx+15);
			
			var vy:Number = -o.velocity.y*_yWeight;
			if (!_anyDirection) {
				vy = FlxU.abs(vy);
				if (o.velocity.y > 0)
					vy *= 0.25;
			}
			
			setYSpeed(vy+30, vy+15);
			super.update();
		}
	}
}
