package {
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filters.BitmapFilter;
	import flash.filters.BitmapFilterQuality;
	import flash.filters.GlowFilter;
	
	public class filtering extends Sprite {
		private var bgColor:uint = 0xFFCC00;
		private var size:uint    = 80;
		private var offset:uint  = 50;
		
		public function GlowFilterExample():void {
			//draw the rectangle using the draw() function below
			draw();
			
			//assign the values from getBitmapFilter function below
			//to a BitmapFilter object "glowFilter"
			var glowFilter:BitmapFilter = getBitmapFilter();
			
			//populate the filters property of the root display object with the array of values
			//from the glowFilter object.
			filters = [ glowFilter ];
		}
		
		private function getBitmapFilter():BitmapFilter {
			var color:Number = 0x000000;
			var alpha:Number = 0.8;
			var blurX:Number = 24;
			var blurY:Number = 24;
			var strength:Number = 2;
			var inner:Boolean = true;
			var knockout:Boolean = false;
			var quality:Number = BitmapFilterQuality.HIGH;
			
			
			return new GlowFilter(color,
				alpha,
				blurX,
				blurY,
				strength,
				quality,
				inner,
				knockout);
		}
		
		private function draw():void {
			graphics.beginFill(bgColor);
			graphics.drawRect(offset, offset, size, size);
			graphics.endFill();
		}
	}
}