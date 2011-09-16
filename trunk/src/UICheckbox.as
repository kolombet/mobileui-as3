package
{
	import com.somerandomdude.iconic.*;
	
	import flash.display.CapsStyle;
	import flash.display.GradientType;
	import flash.display.JointStyle;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.ColorTransform;
	import flash.geom.Matrix;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.utils.getQualifiedClassName;
	
	import mx.core.SpriteAsset;
	
	public class UICheckbox extends Sprite
	{
		
		
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
		private var icon:SpriteAsset;
		private var myColor:ColorTransform;
		
		public var selected:Boolean = false;
		public var customFunction:Function;
		public var iconWidth:Number  = 32;
		public var iconHeight:Number = 26;
		
		public function UICheckbox()
		{
			super();
		}
		
		
		public function createCheckbox(width:Number=40, height:Number = 40,x:Number=0, y:Number=0,color:Array=null, iconColor:uint=0x000000,_iconText:String=''):void
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
			
			
			icon =  new Iconic.check() as SpriteAsset;
			myShape = new Shape();
			gradientBoxMatrix = new Matrix();
			
			gradientBoxMatrix.createGradientBox(width, height, Math.PI/2, 0, 0);  
			
			myShape.graphics.beginGradientFill(GradientType.LINEAR,color,[1,1],[0,255],gradientBoxMatrix);
			myShape.graphics.lineStyle(2,0x000000,1,true);
			myShape.graphics.drawRoundRect(0,0,width,height,radius);
			myShape.graphics.endFill();
			
			
			
			// add the check
			
			myColor = icon.transform.colorTransform;
			myColor.color = 0xeeeeee;
			icon.transform.colorTransform = myColor; 
			icon.width  = iconWidth;
			icon.height = iconHeight;
			icon.y      = 6;
			icon.x		= width/2 - iconWidth/2;
			
			/*var tfl:TextField = new TextField();
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
			*/
			
			this.addChild(myShape);
			this.addChild(icon);
			//this.addChild(tfl);
		}
		
		public function registerListeners():void
		{
				this.addEventListener(MouseEvent.CLICK,click_Handler, false, 0, true);
		}
		
		private function click_Handler(e:MouseEvent):void
		{
			
			if(selected==false)
			{
				// add the check
				myColor = icon.transform.colorTransform;
				myColor.color = 0x000000;
				icon.transform.colorTransform = myColor; 
				selected = true;
			}
			else{
				myColor = icon.transform.colorTransform;
				myColor.color = 0xeeeeee;
				icon.transform.colorTransform = myColor; 
				selected = false;
			}
		}
		
		private function wasteland():Boolean
		{
			this.myShape.graphics.clear();
			this.removeEventListener(MouseEvent.MOUSE_DOWN,click_Handler);
			var num:Number = this.numChildren-1;
			for (var i:Number = num;i >= 0;i--)
			{
				this.removeChildAt(i);
			}
			
			return true;
		}
		
		public function remove():Boolean
		{
			var result:Boolean = wasteland();
			
			return result;
		}
	}
}