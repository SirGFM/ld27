package basics {
	
	import org.flixel.FlxG;
	import org.flixel.FlxPoint;
	import org.flixel.FlxSprite;
	import utils.Registry;
	
	/**
	 * ...
	 * @author GFM
	 */
	public class Basic extends FlxSprite {
		
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
			if (dieOnExit && (x < -64 || x > FlxG.width + 64 || y < -64 || y > FlxG.height + 64)) {
				diedOnExit = true;
				kill();
			}
		}
		
		override public function kill():void {
			super.kill();
			if (!diedOnExit && !(ID & Registry.BULLETID)) {
				Registry.explParticles.at(this);
				Registry.explParticles.start(true, 0, 0, 4);
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
	}
}
