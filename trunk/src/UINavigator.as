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
	
	public class UINavigator extends Sprite
	{
		public var stableParts:Array;
		public var movingParts:Array;
		
		private var gradientBoxMatrix:Matrix;
		private var topBarRect:Shape;
		
		public function UINavigator()
		{
			super();
		}
		
		public function createTopBar(width:Number = 480, height:Number=80,color:Array=null,backBtn:Boolean=false,actionBtn:Boolean=false,title:String='')
		{
			this.x = 0;
			this.y = 0;
			
			if(color==null)
			{
				color = [0xffffff,0xf1f1f1];
			}
			
			topBarRect = new Shape();
			
			gradientBoxMatrix = new Matrix();
			gradientBoxMatrix.createGradientBox(width, height, Math.PI/2, 0, 0);  
			
			topBarRect.graphics.beginGradientFill(GradientType.LINEAR,color,[1,1],[0,128],gradientBoxMatrix);
			//topBarRect.graphics.lineStyle(1,0x1e1e1e,1,true);
			topBarRect.graphics.drawRoundRect(0,0,width,height,0);
			topBarRect.graphics.endFill();
			topBarRect.x = 0;
			topBarRect.y = 0;
			
			//border on the bottom of the topBar
			var line:Shape = new Shape();
			line.graphics.lineStyle(2,0x1e1e1e,1,true,'normal');
			line.graphics.moveTo(0,80);
			line.graphics.lineTo(width,80);
			
			// Creating title
			if(title!=='')
			{
				var tfl:TextField = new TextField();
				tfl.text = title;
				tfl.width = width;
				tfl.height = height;
				tfl.textColor = 0x1e1e1e;
				tfl.embedFonts = false;
				var tf:TextFormat = new TextFormat(null,22,0x1e1e1e);
				tfl.setTextFormat(tf);
				tfl.selectable = false;
				
				tfl.x = width/2 - tfl.textWidth/2;
				tfl.y = height/2 - tfl.textHeight/2;
			}
			
			this.addChild(topBarRect);
			this.addChild(line);
			
			if(title!=='')
			{
				this.addChild(tfl);
			}
		}
		
		public function createNavigator()
		{
			
		}
		
		
	}
}