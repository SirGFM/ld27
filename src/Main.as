package {
	
	import com.wordpress.gfmgamecorner.LogoGFM;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.events.Event;
	import org.flixel.FlxGame;
	import org.flixel.FlxU;
	import states.Menustate;
	import states.Playstate;
	import states.Teststate;
	
	// Game link:
	// https://dl.dropboxusercontent.com/u/55733901/LD48/ld27/gfm_ld27.html
	
	[SWF(width="512",height="512",backgroundColor="0x000000")]
	[Frame(factoryClass="Preloader")]
	
	/**
	 * ...
	 * @author GFM
	 */
	public class Main extends FlxGame {
		
		private var logo:LogoGFM;
		
		public function Main():void {
			super(256, 256, Menustate, 2, 60, 30, true);
			
			logo = null;
			return;
			
			logo = new LogoGFM(true);
			logo.scaleX = 2;
			logo.scaleY = 2;
			logo.x = (512 - logo.width) / 2;
			logo.y = (512 - logo.height) / 2;
			addChild(logo);
		}
		
		override protected function create(FlashEvent:Event):void {
			if (logo)
				if (logo.visible)
					return;
				else {
					removeChild(logo);
					logo.destroy();
					logo = null;
				}
			
			super.create(FlashEvent);
			
			createOverlay();
		}
		
		private function createOverlay():void {
			var bm:BitmapData = new BitmapData(512, 512, true, 0);
			var data:Vector.<uint> = bm.getVector(bm.rect);
			var j:int = 0;
			while (j < 512){
				var i:int = 0;
				var color:uint = FlxU.abs(j - 256) / 8;
				color *= 0x10101;
				if (j % 2 == 0)
					color += 0x33000000;
				else
					color += 0x55000000;
				while (i < 512) {
					data[i + j*512] = color;
					i++;
				}
				j++;
			}
			bm.setVector(bm.rect, data);
			addChild(new Bitmap(bm));
		}
	}
}
