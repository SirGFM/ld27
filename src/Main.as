package {
	
	import com.wordpress.gfmgamecorner.LogoGFM;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.StageDisplayState;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import org.flixel.FlxGame;
	import org.flixel.FlxU;
	import states.Menustate;
	import states.Playstate;
	import states.Teststate;
	import utils.Registry;
	
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
		static private var _mouseOnScreen:Boolean;
		
		public function Main():void {
			super(CONST::WIDTH, CONST::HEIGHT, Menustate, 2, 30, 30, true);
			
			//logo = null;
			//return;
			
			logo = new LogoGFM(true);
			logo.scaleX = 2;
			logo.scaleY = 2;
			logo.x = (512 - logo.width) / 2;
			logo.y = (512 - logo.height) / 2;
			addChild(logo);
			_mouseOnScreen = false;
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
			Registry.self.stage = stage;
			
			addEventListener(MouseEvent.MOUSE_OVER, onActivate, false, 0, true);
			addEventListener(MouseEvent.MOUSE_OUT, onDeactivate, false, 0, true);
			
			// stage.displayState = StageDisplayState.FULL_SCREEN;
		}
		
		private function createOverlay():void {
			var bm:BitmapData = new BitmapData(512, 512, true, 0);
			var data:Vector.<uint> = bm.getVector(bm.rect);
			var j:int = 1;
			while (j < 512){
				var i:int = 0;
				while (i < 512) {
					data[i + j*512] = 0x88000000;
					i++;
				}
				j += 2;
			}
			bm.setVector(bm.rect, data);
			var b:Bitmap = new Bitmap(bm);
			addChild(b);
		}
		
		static public function get mouseOnScreen():Boolean {
			return _mouseOnScreen;
		}
		private function onActivate(ev:Event):void {
			_mouseOnScreen = true;
		}
		private function onDeactivate(ev:Event):void {
			_mouseOnScreen = false;
		}
	}
}
