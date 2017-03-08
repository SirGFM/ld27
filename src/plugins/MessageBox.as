package plugins {
	
	import org.flixel.FlxBasic;
	import org.flixel.FlxG;
	import org.flixel.FlxSprite;
	import org.flixel.FlxText;
	import utils.Sounds;
	
	/**
	 * ...
	 * @author GFM
	 */
	public class MessageBox extends FlxBasic {
		
		[Embed(source = "../../assets/Boss.txt", mimeType = "application/octet-stream")]	private var _boss:Class;
		[Embed(source = "../../assets/GameOver.txt", mimeType = "application/octet-stream")]	private var _gameover:Class;
		[Embed(source = "../../assets/Lines.txt", mimeType = "application/octet-stream")]	private var _lines:Class;
		[Embed(source = "../../assets/youwin.txt", mimeType = "application/octet-stream")]	private var _youwin:Class;
		[Embed(source = "../../assets/help.txt", mimeType = "application/octet-stream")]	private var _help:Class;
		
		private var wnd:FlxSprite;
		private var label:FlxText;
		private var txt:String;
		private var lines:Array;
		
		private var timer:Number;
		
		public function MessageBox() {
			super();
			
			wnd = new FlxSprite(16, 64);
			wnd.makeGraphic(224, 64, 0x33333333);
			wnd.drawLine(0, 0, 224, 0, 0xa0333333);
			wnd.drawLine(223, 0, 223, 64, 0xa0333333);
			wnd.drawLine(0, 63, 224, 63, 0xa0333333);
			wnd.drawLine(0, 0, 0, 64, 0xa0333333);
			label = new FlxText(18, 66, 220, "");
			label.shadow = 0x33333333;
			kill();
		}
		
		override public function update():void {
			if (txt.length > 0) {
				if (timer > 0)
					timer -= FlxG.elapsed;
				else {
					label.text += txt.substr(0, 1);
					txt = txt.substr(1);
					timer = 0.015;
					Sounds.playKeystroke();
					if (txt.length == 0)
						timer = 0.7;
				}
			}
			else if (timer > 0)
				timer -= FlxG.elapsed;
			else if (lines.length > 0) {
				label.text = "";
				txt = lines.shift();
			}
			else
				kill();
		}
		override public function draw():void {
			wnd.draw();
			label.draw();
		}
		
		public function wakeup(src:int):void {
			revive();
			var s:String;
			if (src == 0)
				s = new _lines;
			else if (src == 1)
				s = new _boss;
			else if (src == 2)
				s = new _gameover;
			else if (src == 3)
				s = new _youwin;
			else if (src == 4)
				s = new _help;
			else {
				kill();
				return;
			}
			lines = s.split("\n");
			txt = "";
			timer = 0;
		}
	}
}
