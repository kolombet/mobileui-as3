package
{
	import com.greensock.*;
	import com.greensock.easing.*;
	import com.greensock.plugins.*;
	
	import flash.display.Shape;
	import flash.display.Sprite;
	
	TweenPlugin.activate([TintPlugin]);
	
	public class UILoader extends Sprite
	{
		
		private var counter:Number = 0;
		private var bg:Sprite;
		public function UILoader()
		{
			super();
		}
		
		
		
		public function createLoader(bgColor:uint=0x0d0d0d):void
		{
			bg = new Sprite();
			bg.graphics.beginFill(bgColor,1);
			bg.graphics.lineStyle(3,0xf7f7f7,1,true);
			bg.graphics.drawRoundRectComplex(0,0,200,100,5,5,5,5);
			bg.graphics.endFill();
			var gap:Number = 45;
			var block:Sprite;
			
			for(var i:int = 0;i<6;i++){
				block = new Sprite();
				block.graphics.beginFill(0xffffff,1);
				block.graphics.lineStyle(1,0x7e7e7e,1,false);
				block.graphics.drawRect(gap+(20*i),40,9,22);
				block.graphics.endFill();
				bg.addChild(block);
			}
			
			this.addChild(bg);
			tint();
		}
		
		private function registerListeners():void
		{
			
		}
		
		private function tint(value:Number=0):void
		{
			var length:Number = bg.numChildren;
			var indexItem:Number;
			if(value>length-1)
			{
				indexItem = 0;
			}
			else
			{
				indexItem = value;
			}
			
			TweenMax.to(bg.getChildAt(indexItem), .2, {colorMatrixFilter:{colorize:0x3399ff, amount:1.2, contrast:1, brightness:1, saturation:1, hue:50}, onComplete:function(){
				
				TweenMax.to(bg.getChildAt(indexItem), .6, {colorMatrixFilter:{colorize:0xffffff, amount:1}, ease:Quad.easeInOut});
				tint(indexItem+1);
			}});
		}
		
		private function wasteland():Boolean
		{
			
			return true;
		}
		
		public function remove():void
		{
		}
	}
}