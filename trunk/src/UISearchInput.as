package
{
	import com.greensock.*;
	import com.greensock.plugins.*;
	
	import flash.display.CapsStyle;
	import flash.display.GradientType;
	import flash.display.JointStyle;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.filters.*;
	import flash.geom.Matrix;
	import flash.text.*;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.utils.getQualifiedClassName;
	
	TweenPlugin.activate([GlowFilterPlugin]);
	
	public class UISearchInput extends Sprite
	{
		
		[Embed(source="fonts/signify-webfont.ttf", fontFamily="Signify2", embedAsCFF="false")] 	
		public static var signify2:String;
		
		private var myShape:Shape;
		private var gradientBoxMatrix:Matrix;
		private var masterWidth:Number;
		private var masterHeight:Number;
		
		private var radius:Number = 15;
		private var gradientUp_:Array;
		private var gradientDown_:Array = [255,255,255];
		
		public var iconSize:Number = 28;
		public var textSize:Number = 20;
		
		public var borderColor:uint = 0xeeeeee;
		public var iconColor:uint   = 0x999999;
		
		public var iconOffsetY:Number = 8;
		public var iconOffsetX:Number = 0;
		
		public function UISearchInput()
		{
			super();
		}
		
		
		
		public function createSearchInput(width:Number=150, height:Number=40,x:Number=0, y:Number=0,text:String='',color:Array=null):void
		{
			if(color==null)
			{
				color = [0xffffff,0xffffff];
			}
			
			this.x = x;
			this.y = y;
			
			// draw the rectancle
			myShape = new Shape();
			gradientBoxMatrix = new Matrix();
			
			gradientBoxMatrix.createGradientBox(width, height, Math.PI/2, 0, 0);  
			
			myShape.graphics.beginGradientFill(GradientType.LINEAR,color,[1,1],[0,255],gradientBoxMatrix);
			myShape.graphics.lineStyle(2,borderColor,1,true);
			myShape.graphics.drawRoundRect(0,0,width,height,radius,radius);
			myShape.graphics.endFill();
			
			//create the text input
			var txtInput:TextField = new TextField();
			txtInput.type = TextFieldType.INPUT;
			txtInput.width = width-30;
			txtInput.height = height-10;
			txtInput.textColor = 0x000000;
			txtInput.embedFonts = false;
			txtInput.text = 'Search';
			
			var tf:TextFormat = new TextFormat(null,textSize,0x000000);
			txtInput.setTextFormat(tf);
			txtInput.defaultTextFormat = tf;
			txtInput.x = 32;
			txtInput.y = height/2-txtInput.textHeight/2;
			
			//create the searchIcon
			var tfl:TextField = new TextField();
			tfl.text = '2';
			tfl.width = width/2;
			//tfl.height = height/2;
			tfl.textColor = 0x999999;
			tfl.embedFonts = true;
			tfl.antiAliasType = flash.text.AntiAliasType.ADVANCED;
			tfl.gridFitType = flash.text.GridFitType.PIXEL;
			tfl.thickness = -100;
			tfl.sharpness = -200;
			var tf2:TextFormat = new TextFormat('Signify2',iconSize,iconColor,null,null);
			tfl.setTextFormat(tf2);
			tfl.selectable = false;
			
			tfl.x = 3;
			tfl.y = tfl.y - iconOffsetY;
			
			//add some mobile goodness
			var myGlow:BitmapFilter = getBitmapFilter();
			myShape.filters = [myGlow]; // apply inner glow filter;
			
			// ADD TO SPRITE
			this.addChild(myShape);
			this.addChild(tfl);
			this.addChild(txtInput);
			
			
		}
		
		private function getBitmapFilter():BitmapFilter {
			var color:Number = 0x1e1e1e;
			var alpha:Number = 0.2;
			var blurX:Number = 14;
			var blurY:Number = 14;
			var strength:Number = 1;
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
	}
}