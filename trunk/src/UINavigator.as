package
{
	/**
	 * This class is responsible to offer basic navigation between views, this contains a top bar and a tab at the bottom
	 * it slides with TweenLite when a click is made it constructs new children from the given view, when the slide stops
	 * it destroys previous views.
	 * 
	 * */
	import flash.display.CapsStyle;
	import flash.display.GradientType;
	import flash.display.JointStyle;
	import flash.display.Shader;
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
			
			//if a back button is required
			if(backBtn==true)
			{
				//draw the line
				var vLine:Shape = new Shape();
				vLine.graphics.lineStyle(2,0xcccccc,1,true,'normal');
				vLine.graphics.moveTo(80,0);
				vLine.graphics.lineTo(80,78);
				
				//draw the btn
				var backButton:Shape = new Shape();
				backButton.graphics.beginGradientFill(GradientType.LINEAR,color,[1,1],[0,128],gradientBoxMatrix);
				//topBarRect.graphics.lineStyle(1,0x1e1e1e,1,true);
				backButton.graphics.drawRoundRect(0,0,80,height-2,0);
				backButton.graphics.endFill();
				
				//create the arrow
				var tflBack:TextField = new TextField();
				tflBack.text = '4';
				tflBack.width = 80;
				tflBack.textColor = 0x1e1e1e;
				tflBack.embedFonts = true;
				var tf:TextFormat = new TextFormat('Signify',42,0x1e1e1e);
				tflBack.setTextFormat(tf);
				tflBack.selectable = false;
				
				tflBack.x = 20;
				tflBack.y = -5;
				
				backButton.x = 0;
				backButton.y = 0;
				
				
			}
				
			this.addChild(topBarRect);
			this.addChild(line);
			
			if(title!=='')
			{
				this.addChild(tfl);
			}
			
			if(backBtn==true)
			{
				this.addChild(backButton);
				this.addChild(tflBack);
				this.addChild(vLine);
			}
		}
		
		private function registerListeners()
		{
			
		}
		
		public function createNavigator(bgColor:uint=0xffffff,width:Number = 480,height:Number=800,items:Array = null):void
		{
			
			var mainRect:Sprite = new Sprite();
			mainRect.graphics.beginFill(bgColor,1);
			mainRect.graphics.drawRect(0,0,width,height-82);
			mainRect.graphics.endFill();
			mainRect.x = 0;
			mainRect.y = 82;
			mainRect.name = 'container';
			mainRect.width = width;
			mainRect.height = height-82;
			
			for each(var item in items)
			{
				mainRect.addChild(item);
			}
			
			this.addChild(mainRect);
		}
		
		private function wasteland()
		{
			
			var num = this.numChildren-1;
			//search and destroy
			for (var i = num;i >= 0;i--)
			{
				var item = this.getChildAt(i);
				//all outside children are in here
				if(item.name=='container')
				{
					var internalItems = item.numChildren-1;
					//internal removal
					for(var j = internalItems;j>=0;j--)
					{
						item.getChildAt(j).remove();
						item.removeChildAt(j);
					}
				}
				
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