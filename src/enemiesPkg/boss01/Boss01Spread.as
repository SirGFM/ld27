package enemiesPkg.boss01 {
	
	import basics.Basic;
	import basics.BossWeapon;
	import enShooters.bossShooters.bsShSpread;
	import org.flixel.FlxObject;
	import utils.Resources;
	
	/**
	 * ...
	 * @author GFM
	 */
	public class Boss01Spread extends BossWeapon {
		
		private var wasKilled:Boolean;
		private var thisWasHit:Boolean;
		private var right:BossWeapon;
		
		public function Boss01Spread() {
			super(29, 11);
			
			right = new BossWeapon(82, 11);
			right.setShooter(new bsShSpread());
			right.health = 22.5;
			Resources.bossRSpread(right);
			
			shooter = new bsShSpread();
			shooter.setParent(this);
			health = 22.5;
			Resources.bossLSpread(this);
			
			width += 82 - 29;
			
			wasKilled = false;
		}
		override public function destroy():void {
			super.destroy();
			right.destroy();
		}
		
		override public function update():void {
			if (!wasKilled)
				super.update();
			if (right.alive)
				right.update();
		}
		
		override public function kill():void {
			super.kill();
			wasKilled = true;
			if (right.alive) {
				alive = true;
				exists = true;
			}
		}
		override public function hurt(Damage:Number):void {
			if (thisWasHit && !wasKilled)
				super.hurt(Damage);
			else if (right.alive) {
				right.hurt(Damage);
				if (!right.alive && wasKilled) {
					alive = false;
					exists = false;
				}
			}
		}
		override public function play(AnimName:String, Force:Boolean = false):Boolean {
			if (AnimName != "destroy")
				right.play(AnimName, Force);
			if (wasKilled)
				return false;
			return super.play(AnimName, Force);
		}
		override public function playAnimation():void {
			if (!wasKilled)
				super.playAnimation();
			if (right.alive) {
				right.playAnimation();
				if (wasKilled)
					finished = right.finished;
			}
		}
		override public function playDestroyed(X:Number, Y:Number):void {
			if (wasKilled) {
				alive = false;
				super.playDestroyed(X, Y);
				alive = right.alive;
			}
			right.playDestroyed(X, Y);
		}
		override public function weaponDraw(X:Number, Y:Number):void {
			if (!wasKilled)
				super.weaponDraw(X, Y);
			if (right.alive)
				right.weaponDraw(X, Y);
		}
		override public function weaponCollide(X:Number, Y:Number, b:Basic):Boolean {
			var hit:Boolean;
			if (!wasKilled && super.weaponCollide(X, Y, b)) {
				hit = true
				thisWasHit = true;
			}
			else if (right.alive && right.weaponCollide(X, Y, b)) {
				hit = true
				thisWasHit = false;
			}
			return hit;
		}
		
		override public function targetThis(other:FlxObject, speed:Number, alpha:Number):void {
			if (!wasKilled)
				super.targetThis(other, speed, alpha);
			else if (right.alive)
				right.targetThis(other, speed, alpha);
		}
	}
}
