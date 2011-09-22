package
{
	import flash.display.CapsStyle;
	import flash.display.GradientType;
	import flash.display.JointStyle;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Matrix;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.utils.flash_proxy;
	import flash.utils.getQualifiedClassName;
	
	public class UISeekSlider extends Sprite
	{
		public function UISeekSlider()
		{
			super();
		}
		
		public var bg:uint = 0xb1b1b1;
		public var seekerColor:uint = 0xff0000;
		public var seeker:Sprite;
		private var gradientBoxMatrix:Matrix;
		
		public function createSlider(width:Number=200,height:Number = 20,x:Number=0,y:Number=0):void
		{
			
			this.x = x;
			this.y = y;
			
			gradientBoxMatrix = new Matrix();
			gradientBoxMatrix.createGradientBox(width, height, Math.PI/2, 0, 0);  
			var slider:Sprite = new Sprite();
			slider.graphics.lineStyle(4,0x2d2d2d,1,true);
			slider.graphics.drawRoundRectComplex(0,0,width,height,2,2,2,2);
			slider.graphics.endFill();
			
			seeker = new Sprite();
			seeker.graphics.lineStyle(1,0x2e2e2e,1,true);
			seeker.graphics.beginGradientFill(GradientType.LINEAR,[0xd0e4f7,0x73b1e7,0x0a77d5,0x539fe1,0x87bcea],[1,1,1,1,1],[0,64,128,174,255],gradientBoxMatrix);
			seeker.graphics.drawRect(0,0,1,15);
			seeker.graphics.endFill();
			
			seeker.y = (height)/2-8;
			
			
			this.addChild(seeker);
			
			this.addChild(slider);
		}
		
		//This runs on enter frame... should monitor this
		public function increaseSeeker(value:*):void
		{
			if(value!==undefined){
				
				seeker.graphics.clear();
				seeker.graphics.lineStyle(1,0x2e2e2e,1,true);
				seeker.graphics.beginGradientFill(GradientType.LINEAR,[0xd0e4f7,0x73b1e7,0x0a77d5,0x539fe1,0x87bcea],[1,1,1,1,1],[0,64,128,174,255],gradientBoxMatrix);
				seeker.graphics.drawRect(2,0,value,15);
				seeker.graphics.endFill();
			}
		}
		
		
		private function wasteland():Boolean{
			
			seeker.graphics.clear();
			var num:Number = this.numChildren-1;
			for (var i:Number = num;i >= 0;i--)
			{
				this.removeChildAt(i);
			}
			
			return true;
		}
		
		public function remove():void
		{
			var result:Boolean = wasteland();
		}
		
		
		
	}
}