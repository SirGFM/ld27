package basics {
	
	import org.flixel.FlxG;
	import org.flixel.FlxObject;
	
	/**
	 * ...
	 * @author GFM
	 */
	public class Boss extends Enemy {
		
		private var _rnd:Array;
		private var _weapons:Vector.<BossWeapon>;
		
		private var _curWeapon:BossWeapon;
		private var _nextWeapon:BossWeapon;
		
		private var _living:int;
		private var _timer:Number;
		protected var _maxTimer:Number;
		
		public function Boss(MaxTimer:Number) {
			super(true, -32);
			
			_maxTimer = MaxTimer;
			_weapons = new Vector.<BossWeapon>();
			_rnd = new Array();
			dieOnExit = false;
		}
		override public function destroy():void {
			super.destroy();
			while (_weapons && _weapons.length > 0) {
				var w:BossWeapon = _weapons.pop();
				w.destroy();
			}
			while (_rnd && _rnd.length > 0)
				_rnd.pop();
			
			_weapons = null;
			_rnd = null;
		}
		
		override public function update():void {
			super.update();
			
			if (_timer > 0) {
				_timer -= FlxG.elapsed;
				if (_curWeapon.alive)
					_curWeapon.update();
			}
			else if (!alive) {
				reg.explParticles.start(true, 0, 0, 0);
				kill();
			}
			else if (_nextWeapon == null) {
				_nextWeapon = _weapons[FlxG.getRandom(_rnd)];
				if (_curWeapon)
					_curWeapon.play("close");
				if (_nextWeapon != _curWeapon)
					_nextWeapon.play("open");
				else
					_nextWeapon = null;
			}
			else {
				if (_curWeapon) {
					_curWeapon.playAnimation();
					if (!_nextWeapon && _curWeapon.finished) {
						_nextWeapon = _curWeapon;
						_nextWeapon.play("open");
						_curWeapon = null;
					}
				}
				if (_nextWeapon != _curWeapon) {
					_nextWeapon.playAnimation();
					if (_nextWeapon.finished) {
						_curWeapon = _nextWeapon;
						_nextWeapon = null;
						_timer = _maxTimer;
					}
				}
			}
		}
		
		override public function draw():void {
			var i:int;
			var l:int;
			var e:BossWeapon;
			super.draw();
			if (_curWeapon)
				_curWeapon.weaponDraw(x, y);
			if (_nextWeapon)
				_nextWeapon.weaponDraw(x, y);
			i = 0;
			l = _weapons.length;
			while (i < l) {
				_weapons[i++].playDestroyed(x, y);
			}
		}
		
		public function countLiving():int {
			var e:Enemy;
			var i:int = 0;
			var s:int = 0;
			var l:int = _weapons.length;
			while (i < l)
				if (_weapons[i++].alive)
					s++;
			return s;
		}
		
		override public function didCollide(b:Basic):Boolean {
			if (_curWeapon)
				return _curWeapon.alive && _curWeapon.weaponCollide(x, y, b);
			return false;
		}
		
		override public function hurt(Damage:Number):void {
			var b:Boolean = _curWeapon.alive;
			_curWeapon.hurt(Damage);
			if (b && !_curWeapon.alive) {
				removeWeapon(_weapons.indexOf(_curWeapon));
				_timer = 0;
				if (countLiving() == 0)
					kill();
			}
		}
		override public function kill():void {
			if (!alive) {
				super.kill();
				return;
			}
			alive = false;
			reg.explParticles.start(false, 0, 0.25, 6);
			_timer = 2.5;
		}
		
		private function removeWeapon(w:int):void {
			var tmp:Array = [];
			while (_rnd.length > 0) {
				var cur:int = _rnd.pop()
				if (cur != w)
					tmp.push(cur);
			}
			while (tmp.length > 0)
				_rnd.push(tmp.pop());
		}
		
		public function addWeapon(w:BossWeapon):void {
			_rnd.push(_weapons.length);
			_weapons.push(w);
		}
		
		override public function revive():void {
			super.revive();
			angle = 0;
			dieOnExit = false;
		}
		
		override public function targetThis(other:FlxObject, speed:Number, alpha:Number):void {
			if (_curWeapon)
				_curWeapon.targetThis(other, speed, alpha);
		}
	}
}
