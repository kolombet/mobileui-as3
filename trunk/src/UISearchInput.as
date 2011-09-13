package
{
	import com.greensock.*;
	import com.greensock.plugins.*;
	
	import flash.display.CapsStyle;
	import flash.display.GradientType;
	import flash.display.JointStyle;
	import flash.display.Shader;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.FocusEvent;
	import flash.events.KeyboardEvent;
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
		public const INPUT_TYPE_SEARCH 		= 'search';
		public const INPUT_TYPE_INPUT  		= 'input';
		public const INPUT_TYPE_PASSWORD 	= 'password';
		
		[Embed(source="fonts/signify-webfont.ttf", fontFamily="Signify2", embedAsCFF="false")] 	
		public static var signify2:String;
		
		private var myShape:Shape;
		private var txtInput:TextField;
		private var gradientBoxMatrix:Matrix;
		private var masterWidth:Number;
		private var masterHeight:Number;
		
		private var radius:Number = 15;
		private var gradientUp_:Array;
		private var gradientDown_:Array = [255,255,255];
		
		public var iconSize:Number = 28;
		public var textSize:Number = 20;
		
		public var borderColor:uint = 0xb1b1b1;
		public var iconColor:uint   = 0x999999;
		
		public var iconOffsetY:Number = 8;
		public var iconOffsetX:Number = 0;
		
		public function UISearchInput()
		{
			super();
		}
		
		
		
		public function createSearchInput(type:String=INPUT_TYPE_SEARCH,width:Number=150, height:Number=40,x:Number=0, y:Number=0,text:String='',color:Array=null, validate:String='numOnly'):void
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
			txtInput = new TextField();
			txtInput.type = TextFieldType.INPUT;
			if(type=='search')
				txtInput.width = width-30;
			else
				txtInput.width = width - 10;
			
			txtInput.height = height-10;
			if(type=='password')
				txtInput.displayAsPassword = true;
			
			if(validate=='numOnly')
				txtInput.restrict = '[0-9]';
			
			txtInput.textColor = 0x2e2e2e;
			txtInput.embedFonts = false;
			
			if(type=='search')
				txtInput.text = 'Search';
			
			var tf:TextFormat = new TextFormat(null,textSize,0x2e2e2e);
			txtInput.setTextFormat(tf);
			txtInput.defaultTextFormat = tf;
			if(type=='search')
				txtInput.x = 32;
			else
				txtInput.x = 10;
			
			txtInput.y = height/2-txtInput.textHeight/2;
			
			if(type=='search'){
			//create the searchIcon
			//draw circle
				var circ:Shape = new Shape();
				circ.graphics.beginFill(0xffffff,0.7);
				circ.graphics.lineStyle(2,iconColor,1);
				circ.graphics.drawCircle(8,8,8);
				circ.graphics.endFill();
				circ.x = 8;
				circ.y = iconOffsetY;
				
				var iconLine:Shape = new Shape();
				iconLine.graphics.lineStyle(3,iconColor,1,true);
				iconLine.graphics.moveTo(5,iconOffsetY+10);
				iconLine.graphics.lineTo(10,iconOffsetY+(10+8));
				iconLine.graphics.endFill();
				
				iconLine.x = 17;
				iconLine.y = iconLine.y+7;
			}
			
			//add some mobile goodness
			var myGlow:BitmapFilter = getBitmapFilter();
			myShape.filters = [myGlow]; // apply inner glow filter;
			
			// ADD TO SPRITE
			this.addChild(myShape);
			if(type=='search'){
				this.addChild(circ);
				this.addChild(iconLine);
				
			}
			this.addChild(txtInput);
			registerListeners();
			
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
		
		public function registerListeners():void
		{
			txtInput.addEventListener(FocusEvent.FOCUS_IN,removeText,false,0,true);
			txtInput.addEventListener(FocusEvent.FOCUS_OUT,removeText,false,0,true);
			txtInput.addEventListener(KeyboardEvent.KEY_DOWN,validate,false,0,true);
		}
		
		private function removeText(e:FocusEvent):void
		{
			if(e.type=='focusIn')
				e.currentTarget.text = '';
			else{
				if(e.currentTarget.text == '')
					e.currentTarget.text = 'Search';
			}
		}
		
		private function validate(e:KeyboardEvent)
		{
			if(e.keyCode==13)
			{
				validateInput('numOnly');
			}
		}
		
		private function validateInput(type:String, numOfChars:Number=1)
		{
			var result = true;
			if(type=='mail')
			{
				var validEmailRegExp:RegExp = /([a-z0-9._-]+)@([a-z0-9.-]+)\.([a-z]{2,4})/;
				return validEmailRegExp;
			}
			else if(type=='numOnly')
			{
				var validInput:RegExp = /([\d][^a-zA-Z].)/gs;
				
				return validInput;
			}
			else if(type=='numOfChars')
			{
				if(txtInput.length<numOfChars)
				return false;
			}
			
			return result;
		}
		
		private function wasteland():Boolean
		{
			txtInput.removeEventListener(FocusEvent.FOCUS_IN,removeText,false);
			txtInput.removeEventListener(FocusEvent.FOCUS_OUT,removeText,false);
			var num = this.numChildren-1;
			for (var i = num;i >= 0;i--)
			{
				this.removeChildAt(i);
			}
			
			return true;
		}
		
		public function remove()
		{
			var result = wasteland();
			if(result==true)
				return;
		}
		
		
	}
}