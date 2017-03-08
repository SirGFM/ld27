package basics {
	
	import org.flixel.FlxG;
	import org.flixel.FlxObject;
	import org.flixel.FlxPoint;
	import org.flixel.FlxSprite;
	import utils.Registry;
	
	/**
	 * ...
	 * @author GFM
	 */
	public class Basic extends FlxSprite {
		
		static protected var reg:Registry = Registry.self;
		
		public var grazed:Boolean;
		public var damage:Number;
		
		public var center:FlxPoint;
		public var radius:Number;
		
		protected var dieOnExit:Boolean;
		protected var diedOnExit:Boolean;
		
		public function Basic() {
			super();
			damage = 1;
			center = new FlxPoint();
			dieOnExit = true;
			diedOnExit = false;
		}
		override public function destroy():void {
			super.destroy();
			center = null;
		}
		
		override public function update():void {
			if (dieOnExit && (x < -16 || x > CONST::WIDTH + 16 || y < -16 || y > CONST::HEIGHT + 16)) {
				diedOnExit = true;
				kill();
			}
		}
		
		override public function kill():void {
			super.kill();
			if (!diedOnExit && !(ID & CONST::BULLETID)) {
				reg.explParticles.at(this);
				reg.explParticles.start(true, 0, 0, 4);
			}
			diedOnExit = false;
		}
		override public function reset(X:Number, Y:Number):void {
			super.reset(X, Y);
			grazed = false;
		}
		public function didCollide(b:Basic):Boolean {
			var maxR:Number = radius + b.radius;
			var dx:Number = (x + center.x) - (b.x + b.center.x);
			var dy:Number = (y + center.y) - (b.y + b.center.y);
			var dist:Number = dx*dx + dy*dy;
			if (dist <= maxR*maxR){
				return Math.sqrt(dist) < maxR;
			}
			return false;
		}
		public function targetThis(other:FlxObject, speed:Number, alpha:Number):void {
			var dx:Number = x + center.x - other.x;
			var dy:Number = y + center.y - other.y;
			var d:Number = 1 / Math.sqrt(dx *dx + dy*dy);
			
			// TODO optimize
			
			dx += velocity.x*d;
			dy += velocity.y*d;
			d = 1 / Math.sqrt(dx*dx + dy*dy);
			
			other.velocity.x = (1-alpha)*other.velocity.x + alpha*dx*d*speed;
			other.velocity.y = (1-alpha)*other.velocity.y + alpha*dy*d*speed;
		}
	}
}
