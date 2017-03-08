package objs {
	
	import basics.Basic;
	import basics.Enemy;
	import basics.Spawner;
	import enemiesPkg.bossPkg.BossLaser;
	import enemiesPkg.bossPkg.BossMaze;
	import enemiesPkg.bossPkg.BossShotgun;
	import enemiesPkg.bossPkg.BossSpread;
	import org.flixel.FlxG;
	import org.flixel.FlxU;
	import utils.Registry;
	import utils.Resources;
	
	/**
	 * ...
	 * @author GFM
	 */
	public class Boss extends Enemy {
		
		// this is going to be a pain to do.... >_<
		private var _weapons:Array;
		
		public var _leftSpread:BossSpread;
		public var _rightSpread:BossSpread;
		public var _leftMaze:BossMaze;
		public var _rightMaze:BossMaze;
		public var _shootgun:BossShotgun;
		public var _laser:BossLaser;
		
		private var _timer:Number;
		private var _next:int;
		private var _current:int;
		private var _collided:int;
		
		private var _justEntered:Boolean;
		
		public function Boss() {
			super();
			
			_leftSpread = new BossSpread(29, 11);
			_rightSpread = new BossSpread(82, 11);
			_leftMaze = new BossMaze(47, 33, true);
			_rightMaze = new BossMaze(70, 33);
			_shootgun = new BossShotgun(56, 30);
			_laser = new BossLaser(55, 49);
			Resources.bossGFX(this);
			_weapons = new Array();
			dieOnExit = false;
			Registry.messageBox.wakeup(1);
		}
		override public function destroy():void {
			super.destroy();
			while (_weapons.length > 0)
				_weapons.pop();
			_weapons = null;
			_leftSpread = null;
			_rightSpread = null;
			_leftMaze = null;
			_rightMaze = null;
			_shootgun = null;
			_laser = null;
		}
		
		override public function update():void {
			var living:int;
			_collided = -1;
			super.update();
			
			if (_justEntered) {
				velocity.y = 64 / 3;
				if (y > 32) {
					velocity.y = -15;
					velocity.x = -50;
					_justEntered = false;
					acceleration.x = 20;
					acceleration.y = 20;
				}
				return;
			}
			else {
				if (FlxU.abs(velocity.x) > 50)
					acceleration.x *= -1;
				if (FlxU.abs(velocity.y) > 25)
					acceleration.y *= -1;
			}
			
			living = countLiving();
			if (living > 1)
				if (_timer > 0) {
					_timer -= FlxG.elapsed;
					modUpdate(_current);
				}
				else {
					if (_next == -1) {
						_next = FlxG.getRandom(_weapons) as int;
						modPlay(_current, "close");
						if (_current != _next)
							modPlay(_next, "open");
					}
					else {
						var a:Boolean = false;
						a = didFinish(_current);
						var b:Boolean = false;
						if (_current != _next)
							b = didFinish(_next);
						else if (a) {
							modPlay(_current, "open");
							b = didFinish(_current);
							_current = -1;
						}
						if (a && b) {
							_current = _next;
							_next = -1;
							_timer = 10;
						}
					}
				}
			else {
				kill();
				Registry.explParticles.start(true, 0, 0, 0);
			}
		}
		
		override public function draw():void {
			super.draw();
			if (_next != -1 && _next != _current)
				modDraw(_next);
			modDraw(_current);
		}
		
		private function countLiving():int {
			var i:int = 0;
			if (_leftSpread.alive)
				i++;
			if (_rightSpread.alive)
				i++;
			if (_rightMaze.alive)
				i++;
			if (_rightMaze.alive)
				i++;
			if (_shootgun.alive)
				i++;
			if (_laser.alive)
				i++;
			return i;
		}
		
		private function modUpdate(module:int):void {
			switch (module) {
				case 0: {
					if (_leftSpread.alive)
						_leftSpread.update();
					if (_rightSpread.alive)
						_rightSpread.update();
				}break;
				case 1: {
					if (_leftMaze.alive)
						_leftMaze.update();
					if (_rightMaze.alive)
						_rightMaze.update();
				}break;
				case 2: {
					if (_shootgun.alive)
						_shootgun.update();
				}break;
				case 3: {
					if (_laser.alive)
						_laser.update();
				}break;
			}
		}
		private function modDraw(module:int):void {
			switch (module) {
				case 0: {
					if (_leftSpread.alive) {
						_leftSpread.x = x + _leftSpread.adjust.x;
						_leftSpread.y = y + _leftSpread.adjust.y;
						_leftSpread.draw();
					}
					if (_rightSpread.alive) {
						_rightSpread.x = x + _rightSpread.adjust.x;
						_rightSpread.y = y + _rightSpread.adjust.y;
						_rightSpread.draw();
					}
				}break;
				case 1: {
					if (_leftMaze.alive) {
						_leftMaze.x = x + _leftMaze.adjust.x;
						_leftMaze.y = y + _leftMaze.adjust.y;
						_leftMaze.draw();
					}
					if (_rightMaze.alive) {
						_rightMaze.x = x + _rightMaze.adjust.x;
						_rightMaze.y = y + _rightMaze.adjust.y;
						_rightMaze.draw();
					}
				}break;
				case 2: {
					if (_shootgun.alive) {
						_shootgun.x = x + _shootgun.adjust.x;
						_shootgun.y = y + _shootgun.adjust.y;
						_shootgun.draw();
					}
				}break;
				case 3: {
					if (_laser.alive) {
						_laser.x = x + _laser.adjust.x;
						_laser.y = y + _laser.adjust.y;
						_laser.draw();
					}
				}break;
			}
		}
		private function didFinish(module:int):Boolean {
			switch (module) {
				case -1: return true;
				case 0: {
					if (_leftSpread.alive)
						_leftSpread.postUpdate();
					if (_rightSpread.alive)
						_rightSpread.postUpdate();
					return ( (!_leftSpread.alive || _leftSpread.finished) && (!_rightSpread.alive ||_rightSpread.finished));
				}
				case 1: {
					if (_leftMaze.alive)
						_leftMaze.postUpdate();
					if (_rightMaze.alive)
						_rightMaze.postUpdate();
					return ( (!_leftMaze.alive || _leftMaze.finished) && (!_rightMaze.alive ||_rightMaze.finished));
				}
				case 2: {
					_shootgun.postUpdate();
					return (!_shootgun.alive || _shootgun.finished);
				}
				case 3: {
					_laser.postUpdate();
					return (!_laser.alive || _laser.finished);
				}
			}
			return false;
		}
		private function modPlay(module:int, animation:String):void {
			switch (module) {
				case 0: {
					if (_leftSpread.alive)
						_leftSpread.play(animation);
					if (_rightSpread.alive)
						_rightSpread.play(animation);
				}break;
				case 1: {
					if (_leftMaze.alive)
						_leftMaze.play(animation);
					if (_rightMaze.alive)
						_rightMaze.play(animation);
				}break;
				case 2: _shootgun.play(animation); break;
				case 3: _laser.play(animation); break;
			}
		}
		
		override public function kill():void {
			super.kill();
			Registry.bossDefeated = true;
		}
		
		override public function reset(X:Number, Y:Number):void {
			super.reset(X, Y);
			_next = -1;
			_current = -1;
			_timer = 2;
			angle = 0;
			
			while (_weapons.length > 0)
				_weapons.pop();
			
			_weapons.push(0, 1, 2, 3);
			
			_justEntered = true;
		}
		
		override public function didCollide(b:Basic):Boolean {
			switch (_current) {
				case 0: {
					if (_leftSpread.alive && _leftSpread.didCollide(b)) {
						_collided = 0;
						return true;
					}
					else if (_rightSpread.alive && _rightSpread.didCollide(b)) {
						_collided = 1;
						return true;
					}
				}break;
				case 1: {
					if (_leftMaze.alive && _leftMaze.didCollide(b)) {
						_collided = 2;
						return true;
					}
					else if (_rightMaze.alive && _rightMaze.didCollide(b)) {
						_collided = 3;
						return true;
					}
				}break;
				case 2: {
					if (_shootgun.alive && _shootgun.didCollide(b)) {
						_collided = 4;
						return true;
					}
				}break;
				case 3: {
					if (_laser.alive && _laser.didCollide(b)) {
						_collided = 5;
						return true;
					}
				}break;
			}
			return false;
		}
		
		override public function hurt(Damage:Number):void {
			if (_collided < 0 || !didFinish(_current))
				return;
			var tmp:Boolean;
			switch(_collided) {
				case 0: {
					tmp = _laser.alive;
					_leftSpread.hurt(Damage);
					if (tmp && !_leftSpread.alive) {
						_leftSpread.kill();
						if (!_rightSpread.alive)
							removeWeapon(0);//_weapons.splice(_weapons.indexOf(0), 1);
					}
				}break;
				case 1: {
					tmp = _laser.alive;
					_rightSpread.hurt(Damage);
					if (tmp && !_rightSpread.alive) {
						_rightSpread.kill();
						if (!_leftSpread.alive)
							removeWeapon(0);//_weapons.splice(_weapons.indexOf(0), 1);
					}
				}break;
				case 2: {
					tmp = _laser.alive;
					_leftMaze.hurt(Damage);
					if (tmp && !_leftMaze.alive) {
						_leftMaze.kill();
						if (!_rightMaze.alive)
							removeWeapon(1);//_weapons.splice(_weapons.indexOf(1), 1);
					}
				}break;
				case 3: {
					tmp = _laser.alive;
					_rightMaze.hurt(Damage);
					if (tmp && !_rightMaze.alive) {
						_rightMaze.kill();
						if (!_leftMaze.alive)
							removeWeapon(1);// _weapons.splice(_weapons.indexOf(1), 1);
					}
				}break;
				case 4: {
					tmp = _laser.alive;
					_shootgun.hurt(Damage);
					if (tmp && !_shootgun.alive) {
						_shootgun.kill();
						removeWeapon(2);//_weapons.splice(_weapons.indexOf(2), 1);
					}
				}break;
				case 5: {
					tmp = _laser.alive;
					_laser.hurt(Damage);
					if (tmp && !_laser.alive) {
						_laser.kill();
						removeWeapon(3);//_weapons.splice(_weapons.indexOf(3), 1);
					}
				}break;
			}
		}
		
		private function removeWeapon(w:int):void {
			var tmp:Array = [];
			while (_weapons.length > 0) {
				var cur:int = _weapons.pop()
				if (cur != w)
					tmp.push(cur);
			}
			while (tmp.length > 0)
				_weapons.push(tmp.pop());
		}
	}
}
