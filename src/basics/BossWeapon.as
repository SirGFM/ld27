package basics {
	import org.flixel.FlxPoint;
	
	/**
	 * ...
	 * @author GFM
	 */
	public class BossWeapon extends Enemy {
		
		private var adjust:FlxPoint;
		
		public function BossWeapon(X:Number, Y:Number) {
			super(false);
			adjust = new FlxPoint(X, Y);
		}
		override public function destroy():void {
			super.destroy();
			adjust = null;
		}
		
		override public function kill():void {
			play("destroy");
			super.kill();
		}
		override public function play(AnimName:String, Force:Boolean = false):Boolean {
			if (!alive)
				return false;
			return super.play(AnimName, Force);
		}
		
		public function playAnimation():void {
			super.updateAnimation();
		}
		
		public function playDestroyed(X:Number, Y:Number):void {
			if (alive)
				return;
			super.updateAnimation();
			x = X + adjust.x;
			y = Y + adjust.y;
			super.draw();
		}
		public function weaponDraw(X:Number, Y:Number):void {
			x = X + adjust.x;
			y = Y + adjust.y;
			super.draw();
		}
		
		public function weaponCollide(X:Number, Y:Number, b:Basic):Boolean {
			x = X + adjust.x;
			y = Y + adjust.y;
			return super.didCollide(b);
		}
		
		public function setShooter(s:Spawner):void {
			shooter = s;
			shooter.setParent(this);
		}
	}
}
