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
	import flash.utils.getQualifiedClassName;
	
	public class UIButton extends Sprite
	{
		[Embed(source="fonts/signify-webfont.ttf", fontFamily="Signify", embedAsCFF="false")] 	
		public static var signify:String;
		
		private var myShape:Shape;
		private var gradientBoxMatrix:Matrix;
		private var masterWidth:Number;
		private var masterHeight:Number;
		
		private var radius:Number = 10;
		private var gradientUp_:Array;
		private var gradientDown_:Array = [255,255,255];
		
		public function UIButton()
		{
			super();
			
			//createButton();
		}
		
		
		public function createButton(gradientColor_:Array = null,gradientDown:Array=null,width:Number=120,height:Number=60,x:Number=10, y:Number=10, _Icontext:String = 'E',text:String='',iconPosition:String='left',iconColor:uint=0x0e0e0e)
		{
			if(gradientColor_==null)
				gradientColor_ = [0xf7f7f7,0xf1f1f1,0xf0f0f0];
			else
				gradientUp_ = gradientColor_;
			
	
			gradientDown_ = gradientDown;
			
			masterWidth = width;
			masterHeight = height;
			this.x = x;
			this.y = y;
			myShape = new Shape();
			gradientBoxMatrix = new Matrix();
			
			gradientBoxMatrix.createGradientBox(width, height, Math.PI/2, 0, 0);  
			
			myShape.graphics.beginGradientFill(GradientType.LINEAR,gradientColor_,[1,1,1],[0,128,255],gradientBoxMatrix);
			myShape.graphics.lineStyle(2,0x1e1e1e,1,true);
			myShape.graphics.drawRoundRect(0,0,width,height,radius);
			myShape.graphics.endFill();
			
			var tfl:TextField = new TextField();
			tfl.text = _Icontext;
			tfl.width = width/2;
			tfl.height = height/2;
			tfl.textColor = iconColor;
			tfl.embedFonts = true;
			var tf:TextFormat = new TextFormat('Signify',38,iconColor);
			tfl.setTextFormat(tf);
			tfl.selectable = false;
			
			
			tfl.y = -10;
			
			
			if(text=='')
			tfl.x = width/2 - tfl.textWidth+19;
			
			if(text!=='')
			{
				var txt:TextField = new TextField();
				txt.text = text;
				txt.width = width;
				txt.height = height;
				txt.textColor = iconColor;
				txt.embedFonts = false;
				var tf:TextFormat = new TextFormat('Helvetica',32,iconColor);
				txt.setTextFormat(tf);
				txt.selectable = false;
				
				txt.y = 10;
				if(iconPosition=='left')
				{
					tfl.x = 20;
					txt.x = 80;
				}
				else if(iconPosition=='top')
				{
					tfl.x = width/2 - tfl.textWidth+19;
					tfl.y = -15;
					txt.y = 40;
					txt.x = width/2-txt.textWidth/2;
					
					myShape.graphics.clear();
					gradientBoxMatrix.createGradientBox(width, height+20, Math.PI/2, 0, 0);  
					
					myShape.graphics.beginGradientFill(GradientType.LINEAR,gradientColor_,[1,1,1],[0,128,255],gradientBoxMatrix);
					myShape.graphics.lineStyle(2,0x1e1e1e,1);
					myShape.graphics.drawRoundRect(0,0,width,(height+20),radius);
					myShape.graphics.endFill();
					
					masterHeight = height+20;
				}
				
			}
			
			
			
			if(width<(tfl.textWidth+txt.textWidth+80)&&(iconPosition=='left'||iconPosition=='right'))
			{
				myShape.graphics.clear();
				gradientBoxMatrix.createGradientBox(width, height, Math.PI/2, 0, 0);  
				
				myShape.graphics.beginGradientFill(GradientType.LINEAR,gradientColor_,[1,1,1],[0,128,255],gradientBoxMatrix);
				myShape.graphics.lineStyle(2,0x1e1e1e,1);
				myShape.graphics.drawRoundRect(0,0,(tfl.textWidth+txt.textWidth+60),height,radius);
				myShape.graphics.endFill();
				
				masterWidth = tfl.textWidth+txt.textWidth+60;
			}
			
			this.addChild(myShape);
			this.addChild(tfl);
			this.addChild(txt);
		}
		
		public function registerListeners()
		{
			this.addEventListener(MouseEvent.MOUSE_DOWN,mouseDown_Handler,false,0,true);
			
			this.addEventListener(MouseEvent.MOUSE_UP,mouseUp_Handler,false,0,true);
		}
		
		private function mouseDown_Handler(e:MouseEvent)
		{	
				var bg;
				if(flash.utils.getQualifiedClassName(e.target)=='flash.text::TextField'){
					bg = e.target.parent.getChildAt(0);
				}
				else
					bg = e.target.getChildAt(0);
				
				gradientBoxMatrix.createGradientBox(masterWidth, masterHeight, Math.PI/2, 0, 0);
				bg.graphics.clear();
				bg.graphics.beginGradientFill(GradientType.LINEAR,gradientDown_,[1,1,1],[0,128,255],gradientBoxMatrix);
				bg.graphics.lineStyle(2,0x3f3f3f);
				bg.graphics.drawRoundRect(0,0,masterWidth,masterHeight,radius);
				bg.graphics.endFill();	
		}
		
		private function mouseUp_Handler(e:MouseEvent)
		{
			var bg;
			if(flash.utils.getQualifiedClassName(e.target)=='flash.text::TextField'){
				bg = e.target.parent.getChildAt(0);
			}
			else
				bg = e.target.getChildAt(0);
			gradientBoxMatrix.createGradientBox(masterWidth, masterHeight, Math.PI/2, 0, 0);
			bg.graphics.clear();
			bg.graphics.beginGradientFill(GradientType.LINEAR,gradientUp_,[1,1,1],[0,128,255],gradientBoxMatrix);
			bg.graphics.lineStyle(2,0x1e1e1e);
			bg.graphics.drawRoundRect(0,0,masterWidth,masterHeight,radius);
			bg.graphics.endFill();
			
			wasteland();
		}
		
		public function wasteland()
		{
			this.myShape.graphics.clear();
			this.removeEventListener(MouseEvent.MOUSE_DOWN,mouseDown_Handler);
			this.removeEventListener(MouseEvent.MOUSE_UP,mouseUp_Handler);
			var num = this.numChildren-1;
			for (var i = num;i >= 0;i--)
			{
				this.removeChildAt(i);
			}
		}
		
		public function getHEX(r:Number, g:Number, b:Number){
		
			return "0x"+displayInHex(combineRGB(r,g,b));
		}
		
		function extractRed(c:uint):uint {
			
			return (( c >> 16 ) & 0xFF);
			
		}
		
		
		function extractGreen(c:uint):uint {
			
			return ( (c >> 8) & 0xFF );
			
		}
		
		
		function extractBlue(c:uint):uint {
			
			return ( c & 0xFF );
			
		}
		
		function combineRGB(r:uint,g:uint,b:uint):uint {
			
			return ( ( r << 16 ) | ( g << 8 ) | b );
			
		}
		
		function displayInHex(c:uint):String {
			
			var r:String=extractRed(c).toString(16).toUpperCase();
			
			var g:String=extractGreen(c).toString(16).toUpperCase();
			
			var b:String=extractBlue(c).toString(16).toUpperCase();
			
			var hs:String="";
			
			var zero:String="0";
			
			if(r.length==1){
				
				r=zero.concat(r);
				
			}
			
			if(g.length==1){
				
				g=zero.concat(g);
				
			}
			
			if(b.length==1){
				
				b=zero.concat(b);
				
			}
			
			hs=r+g+b;
			
			return hs;
		}
		
		
	}
}