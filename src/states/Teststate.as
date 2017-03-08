package states {
	
	import basics.Basic;
	import org.flixel.FlxG;
	import org.flixel.FlxState;
	import players.MainShip;
	import players.SK_DMG;
	import players.ZW_TOT;
	
	/**
	 * ...
	 * @author GFM
	 */
	public class Teststate extends FlxState {
		
		override public function create():void {
			var b:Basic;
			
			b = add(new MainShip()) as Basic;
			b.x = 100;
			b.y = 100;
			b = add(new ZW_TOT()) as Basic;
			b.x = 100;
			b.y = 140;
			b = add(new SK_DMG()) as Basic;
			b.x = 100;
			b.y = 180;
			
			b = add(new Basic()) as Basic;
			b.center.make();
			b.radius = 1;
			b.makeGraphic(1, 1);
		}
		
		override public function update():void {
			var mouse:Basic = members[3] as Basic;
			mouse.x = FlxG.mouse.x;
			mouse.y = FlxG.mouse.y;
			
			var i:int = 0;
			while (i < 3) {
				var b:Basic = members[i++];
				if (b.didCollide(mouse))
					b.flicker( -1);
				else
					b.flicker(0);
			}
			
			super.update();
		}
	}
}
