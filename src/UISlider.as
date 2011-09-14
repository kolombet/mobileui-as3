package
{
	import flash.display.GradientType;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;
	
	public class UISlider extends Sprite
	{
		private var scrolling:Boolean = false;
		private var slider:Sprite;
		private var bounds:Rectangle;
		private var gradientBoxMatrix:Matrix;
		
		private var maxMove:Number;
		public var _stage:Stage;
		
		public function UISlider()
		{
			super();
		}
		
		public function createSlider(width:Number=20,height:Number=100,x:Number=0,y:Number=0,boxWidth:Number=30, boxHeight:Number=100)
		{
			maxMove = boxHeight;
			
			this.x = x;
			this.y = y;
			slider = new Sprite();
			gradientBoxMatrix = new Matrix();
			
			gradientBoxMatrix.createGradientBox(width, height, Math.PI/2, 0, 0);
			
			var littleSlider:Sprite = new Sprite();
			
			slider.graphics.beginGradientFill(GradientType.LINEAR,[0x000000,0x6a6a6a,0xb8b8b8,0xe9e9e9,0xffffff],[1,1,1,1,1],[0,60,130,210,255],gradientBoxMatrix);
			slider.graphics.lineStyle(1,0x999999,1);
			slider.graphics.drawCircle(12,12,12);
			slider.graphics.endFill();
			slider.x = boxWidth/2-12;
			slider.y = 7;
			
			littleSlider.graphics.beginGradientFill(GradientType.LINEAR,[0xdfdfdf,0xF8F8F8,0xf5f5f5,0xe9e9e9,0xffffff],[1,1,1,1,1],[0,20,128,200,255],gradientBoxMatrix);
			littleSlider.graphics.lineStyle(1,0x000000,1);
			littleSlider.graphics.drawCircle(6,6,6);
			littleSlider.graphics.endFill();
			littleSlider.x = slider.width/2-6.5;
			littleSlider.y = 6.5;
			
			var middleLine:Shape = new Shape();
			middleLine.graphics.beginFill(0xcacaca,1);
			middleLine.graphics.lineStyle(4,0xeeeeee,1);
			middleLine.graphics.moveTo(boxWidth/2-4,-maxMove+2);
			middleLine.graphics.lineTo(boxWidth/2-4,30);
			middleLine.graphics.endFill();
			middleLine.x = slider.width/2-8;
			
			slider.addChild(littleSlider);
			
			var box:Sprite = new Sprite();
			box.graphics.beginGradientFill(GradientType.LINEAR,[0x292929,0x000000,0x313232],[1,1,1],[0,128,255],gradientBoxMatrix);
			box.graphics.lineStyle(1,0x0d0d0d,1);
			box.graphics.drawRect(0,-maxMove,boxWidth,maxMove+32);
			box.graphics.endFill();
			box.addChild(middleLine);
			
			bounds = new Rectangle(this.slider.x, this.slider.y, 0, -maxMove-4);
			
			box.addChild(slider);
			this.addChild(box);
			registerListeners();
		}
		
		private function registerListeners():void
		{
			this.slider.addEventListener (MouseEvent.MOUSE_DOWN, startScroll);
			_stage.addEventListener (MouseEvent.MOUSE_UP, stopScroll);
		}
		
		private function startScroll (e:Event):void {
			scrolling = true;
			this.slider.startDrag (false,bounds);
		}
		
		private function stopScroll (e:Event):void {
			scrolling = false;
			this.slider.stopDrag ();
			trace(1-((bounds.x-this.slider.y)/maxMove));
		}
		
		private function wasteland():Boolean
		{
			
			return true;
		}
		
		public function remove():void
		{
			
			var result = remove();
			
			if(result)
				return;.....
		}
	
	}	

}