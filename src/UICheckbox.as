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
	
	
	public class UICheckbox extends Sprite
	{
		[Embed(source="fonts/signify-webfont.ttf", fontFamily="Signify", embedAsCFF="false")] 	
		public static var signify:String;
		
		private var myShape:Shape;
		private var gradientBoxMatrix:Matrix;
		private var masterWidth:Number;
		private var masterHeight:Number;
		private var bgColor:Array = [0xffffff];
		private var radius:Number = 5;
		private var gradientUp_:Array;
		private var gradientDown_:Array = [255,255,255];
		
		private var $iconColor:uint;
		private var $iconText:String = '';
		
		public var selected:Boolean = false;
		public var customFunction:Function;
		
		public function UICheckbox()
		{
			super();
		}
		
		
		public function createCheckbox(width:Number=40, height:Number = 40,x:Number=0, y:Number=0,color:Array=null, iconColor=0x000000,_iconText='')
		{
			if(color==null)
				color = [0xeeeeee,0xcccccc];
			
			bgColor = color;
			
			$iconColor = iconColor;
			$iconText  = _iconText;
			
			masterWidth = width;
			masterHeight = height;
			this.x = x;
			this.y = y;
			myShape = new Shape();
			gradientBoxMatrix = new Matrix();
			
			gradientBoxMatrix.createGradientBox(width, height, Math.PI/2, 0, 0);  
			
			myShape.graphics.beginGradientFill(GradientType.LINEAR,color,[1,1],[0,255],gradientBoxMatrix);
			myShape.graphics.lineStyle(2,0x000000,1,true);
			myShape.graphics.drawRoundRect(0,0,width,height,radius);
			myShape.graphics.endFill();
			
			
			// add the check
			
			var tfl:TextField = new TextField();
			tfl.text = $iconText;
			tfl.width = width/2 - 28;
			tfl.height = height/2 - 28;
			tfl.textColor = color[0];
			tfl.embedFonts = true;
			var tf:TextFormat = new TextFormat('Signify',28,color[0]);
			tfl.setTextFormat(tf);
			tfl.selectable = false;
			
			tfl.y = -10;
			tfl.x = width/2-tfl.textWidth/2-2;
			this.selected = false;
			
			
			this.addChild(myShape);
			this.addChild(tfl);
		}
		
		public function registerListeners()
		{
				this.addEventListener(MouseEvent.CLICK,click_Handler, false, 0, true);
		}
		
		private function click_Handler(e:MouseEvent)
		{
			var bg;
			if(flash.utils.getQualifiedClassName(e.target)=='flash.text::TextField'){
				bg = e.target.parent.getChildAt(0);
			}
			else
				bg = e.target.getChildAt(0);
			
			/*gradientBoxMatrix.createGradientBox(width, height, Math.PI/2, 0, 0);  
			bg.graphics.clear();
			bg.graphics.beginGradientFill(GradientType.LINEAR,bgColor,[1,1],[0,255],gradientBoxMatrix);
			bg.graphics.lineStyle(2,0x000000,1,true);
			bg.graphics.drawRoundRect(0,0,width,height,radius);
			bg.graphics.endFill();
			*/
			
			if(selected==false)
			{
				// add the check
				this.removeChildAt(this.numChildren-1);
				var tfl:TextField = new TextField();
				tfl.text = $iconText;
				tfl.width = width/2 - 28;
				tfl.height = height/2 - 28;
				tfl.textColor = $iconColor;
				tfl.embedFonts = true;
				var tf:TextFormat = new TextFormat('Signify',28,$iconColor);
				tfl.setTextFormat(tf);
				tfl.selectable = false;
				
				tfl.y = -10;
				tfl.x = width/2-tfl.textWidth/2-2;
				this.selected = true;
				this.addChild(tfl);
			}
			else{
				
				this.removeChildAt(this.numChildren-1);
				this.selected = false;
				var tfl:TextField = new TextField();
				tfl.text = $iconText;
				tfl.width = width/2 - 28;
				tfl.height = height/2 - 28;
				tfl.textColor = 0xeeeeee;
				tfl.embedFonts = true;
				var tf:TextFormat = new TextFormat('Signify',28,0xeeeeee);
				tfl.setTextFormat(tf);
				tfl.selectable = false;
				
				tfl.y = -10;
				tfl.x = width/2-tfl.textWidth/2-2;
				
				this.addChild(tfl);
			}
		}
		
		public function wasteland()
		{
			this.myShape.graphics.clear();
			this.removeEventListener(MouseEvent.MOUSE_DOWN,click_Handler);
			var num = this.numChildren-1;
			for (var i = num;i >= 0;i--)
			{
				this.removeChildAt(i);
			}
		}
	}
}