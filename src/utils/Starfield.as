package utils {
	
	import flash.display.BitmapData;
	import org.flixel.FlxG;
	import org.flixel.FlxSprite;
	import org.flixel.FlxU;
	
	/**
	 * ...
	 * @author GFM
	 */
	public class Starfield extends FlxSprite {
		
		//http://www.bitblit.org/articles/starfield/index.shtml
		
		private var data:Vector.<uint>;
		private var max:uint;
		
		public function Starfield(w:int = 256, h:int = 256, global_desity:Number = 0.0025, octaves:int = 2, seed:Number = -1, max_size:Number = 2, max_brightness:int = 320, brightness_limit:int = 255) {
			super();
			
			makeGraphic(w, h, 0);
			data = pixels.getVector(pixels.rect);
			max = w * h;
			
			if (seed < 0)
				seed = FlxG.random();
			
			var bm:BitmapData = new BitmapData(w, h, true, 0);
			bm.perlinNoise(w, h, octaves, seed, false, true, 7, true);
			var local_density:Vector.<uint> = bm.getVector(bm.rect);
			
			var j:int = 0;
			while (j < h) {
				var i:int = 0;
				while (i < w) {
					var ld:Number = (local_density[i + j * w] & 0xff)/0xff;
					if (FlxG.random() < ld * global_desity) {
						var weight:Number = FlxG.random() * ld;
						var size:Number = weight * max_size;
						var brightness:Number = weight * max_brightness;
						if (brightness > brightness_limit)
							draw_halo_star(i, j, FlxU.floor(size), brightness_limit)
						else
							draw_star(i, j, FlxU.floor(size), brightness)
					}
					i++;
				}
				j++;
			}
			bm.dispose();
			bm = null;
			
			pixels.setVector(pixels.rect, data);
			data = null;
			local_density = null;
			dirty = true;
			y = -CONST::HEIGHT;
		}
		
		override public function update():void {
			if (y > 256)
				y -= CONST::HEIGHT;
		}
		override public function draw():void {
			var dy:Number;
			if (y > 0)
				dy = -CONST::HEIGHT;
			else
				dy = CONST::HEIGHT;
			super.draw();
			y += dy;
			super.draw();
			y -= dy;
		}
		
		private function draw_halo_star(X0:Number, Y0:Number, size:Number, brightness:int):void {
			var i:int;
			var f:int = 1 - size;
			var ddF_x:int = 1;
			var ddF_y:int = -2 * size;
			var X:int = 0;
			var Y:int = size;
			var color:uint = 0x1000000 * (brightness - 255) + 0xffffff;
			if (brightness & 0x1000000)
				color = brightness;
			
			i = X0 + (Y0 + size) * width;
			if (i > 0 && i < max)
				data[i] = color;
			i = X0 + (Y0 - size) * width;
			if (i > 0 && i < max)
				data[i] = color;
			i = X0 + size + Y0 * width;
			if (i > 0 && i < max)
				data[i] = color;
			i = X0 - size + Y0 * width;
			if (i > 0 && i < max)
				data[i] = color;
			
			while (X < Y) {
				if (f >= 0) {
					Y--;
					ddF_y += 2;
					f += ddF_y;
				}
				X++;
				ddF_x += 2;
				f += ddF_x;
				i = X0 + X + (Y0 + Y) * width;
				if (i > 0 && i < max)
					data[i] = color;
				i = X0 - X + (Y0 + Y) * width;
				if (i > 0 && i < max)
					data[i] = color;
				i = X0 + X + (Y0 - Y) * width;
				if (i > 0 && i < max)
					data[i] = color;
				i = X0 - X + (Y0 - Y) * width;
				if (i > 0 && i < max)
					data[i] = color;
				i = X0 + Y + (Y0 + X) * width;
				if (i > 0 && i < max)
					data[i] = color;
				i = X0 + Y + (Y0 - X) * width;
				if (i > 0 && i < max)
					data[i] = color;
				i = X0 - Y + (Y0 + X) * width;
				if (i > 0 && i < max)
					data[i] = color;
				i = X0 + Y + (Y0 - X) * width;
				if (i > 0 && i < max)
					data[i] = color;
			}
		}
		private function draw_star(X:Number, Y:Number, size:Number, brightness:int):void {
			var color:uint = 0x1000000 * brightness;
			/**
			if (brightness < 35)
				color += 0xffbd6f;
			else if (brightness < 60)
				color += 0xffddb4;
			else if (brightness < 80)
				color += 0xfff4e8;
			else if (brightness < 110)
				color += 0xfbf8ff;
			else if (brightness < 165)
				color += 0xcad8ff;
			else if (brightness < 200)
				color += 0xaabfff;
			else
				color += 0x9db4ff;
			/**/
			if (brightness < 100)
				color += 0x8080aa;
			else if (brightness < 180)
				color += 0xb0a080;
			else if (brightness < 210)
				color += 0xb8c080;
			else
				color += 0xffffff;
			/**/
			//color += 0xffffff;
			color |= 0x1000000;
			draw_halo_star(X, Y, size, color);
			//pixels.floodFill(50, 50, 0xffffffff);
		}
	}
}
