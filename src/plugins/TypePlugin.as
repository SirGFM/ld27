package plugins {
	
	import basics.Player;
	import org.flixel.FlxBasic;
	import org.flixel.FlxSprite;
	import org.flixel.FlxText;
	import utils.Registry;
	import utils.Resources;
	
	/**
	 * ...
	 * @author GFM
	 */
	public class TypePlugin extends FlxBasic {
		
		private var label:FlxText;
		private var icon:FlxSprite;
		
		public function TypePlugin() {
			super();
			label = new FlxText(4, 26, 100, "TYPE:");
			label.shadow = 0x333333;
			icon = new FlxSprite(36, 28);
			Resources.itemsGFX(icon);
			kill();
		}
		override public function destroy():void {
			super.destroy();
			label.destroy();
			icon.destroy();
			label = null;
			icon = null;
		}
		
		override public function draw():void {
			var t:uint = Registry.player.type;
			label.draw();
			if (t != Player.NOTYPE) {
				icon.frame = t;
				icon.draw();
			}
		}
	}
}
