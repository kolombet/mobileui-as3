package
{
	import Utils.Utils;
	
	import com.somerandomdude.iconic.*;
	
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
	
	import mx.core.SpriteAsset;
	
	public class UIButton extends Sprite
	{
		
		[Embed(source="fonts/iconic_stroke.ttf", fontFamily="iconic", embedAsCFF="false")]
		public static var iconic:Class;
		
		private var ShapeSprite:Shape;
		private var gradientBoxMatrix:Matrix;
		private var masterWidth:Number;
		private var masterHeight:Number;
		
		private var radius:Number = 10;
		private var gradientUp_:Array;
		private var gradientDown_:Array = [255,255,255];
		private var icon:SpriteAsset;
		
		private var utils:Utils = new Utils();
		public var iconWidth:Number = 40;
		public var iconHeight:Number = 30;
		public function UIButton()
		{
			super();
			
			//createButton();
		}
		
		public function createButton(gradientColor_:Array = null,gradientDown:Array=null,width:Number=120,height:Number=60,x:Number=10, y:Number=10, _Icontext:String = 'mail',text:String='',iconPosition:String='left',iconColor:uint=0x0e0e0e,iconSize:Number=32):void
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
			
			icon = utils.getIcon(_Icontext);
			
			if(icon.width!=icon.height){
				var iconRatio:Number = icon.width/icon.height;
				
				icon.width  = Math.round(iconSize*iconRatio);
				icon.height = icon.width/iconRatio;
				
			}
			else{
				icon.width = iconSize;
				icon.height = iconSize;
			}
			
			var txt:TextField = new TextField();
			txt.selectable = false;
			ShapeSprite = new Shape();
			
			gradientBoxMatrix = new Matrix();
			gradientBoxMatrix.createGradientBox(width, height, Math.PI/2, 0, 0);  
			
			ShapeSprite.graphics.beginGradientFill(GradientType.LINEAR,gradientColor_,[1,1,1],[0,128,255],gradientBoxMatrix);
			ShapeSprite.graphics.lineStyle(2,0x1e1e1e,1,true);
			ShapeSprite.graphics.drawRoundRect(0,0,width,height,radius);
			ShapeSprite.graphics.endFill();
			
			
			if(text==''){
				//icon.width = iconWidth;
				//icon.height = iconHeight;
				icon.x = width/2 - icon.width/2;
				icon.y = height/2 - icon.height/2;
			}
			
			if(text!=='')
			{	
				
				txt.text = text;
				txt.width = width;
				txt.height = height;
				txt.textColor = iconColor;
				txt.embedFonts = false;
				var tf2:TextFormat = new TextFormat('Helvetica',32,iconColor);
				txt.setTextFormat(tf2);
				txt.selectable = false;
				
				txt.y = 10;
				if(iconPosition=='left')
				{
					icon.x = 20;
					icon.y = 14;
					txt.x = icon.x+iconWidth+15;
				}
				else if(iconPosition=='top')
				{
					icon.x = width/2 - icon.width;
					icon.y = 5;
					txt.y = 40;
					txt.x = width/2-txt.textWidth/2;
					
					ShapeSprite.graphics.clear();
					gradientBoxMatrix.createGradientBox(width, height+20, Math.PI/2, 0, 0);  
					
					ShapeSprite.graphics.beginGradientFill(GradientType.LINEAR,gradientColor_,[1,1,1],[0,128,255],gradientBoxMatrix);
					ShapeSprite.graphics.lineStyle(2,0x1e1e1e,1);
					ShapeSprite.graphics.drawRoundRect(0,0,width,(height+20),radius);
					ShapeSprite.graphics.endFill();
					
					masterHeight = height+20;
				}
				
			}
			
			
			
			if(width<(iconWidth+txt.textWidth+80)&&(iconPosition=='left'||iconPosition=='right')&&(text!==''))
			{
				ShapeSprite.graphics.clear();
				gradientBoxMatrix.createGradientBox(width, height, Math.PI/2, 0, 0);  
				
				ShapeSprite.graphics.beginGradientFill(GradientType.LINEAR,gradientColor_,[1,1,1],[0,128,255],gradientBoxMatrix);
				ShapeSprite.graphics.lineStyle(2,0x1e1e1e,1);
				ShapeSprite.graphics.drawRoundRect(0,0,(iconWidth+txt.textWidth+60),height,radius);
				ShapeSprite.graphics.endFill();
				
				masterWidth = iconWidth+txt.textWidth+60;
			}
			
			this.addChild(ShapeSprite);
			this.addChild(icon);
			this.addChild(txt);
		}
		
		public function registerListeners():void
		{
			this.addEventListener(MouseEvent.MOUSE_DOWN,mouseDown_Handler,false,0,true);
			
			this.addEventListener(MouseEvent.MOUSE_UP,mouseUp_Handler,false,0,true);
		}
		
		private function mouseDown_Handler(e:MouseEvent):void
		{	
				var bg:Object;
			
				bg = ShapeSprite;
				gradientBoxMatrix.createGradientBox(masterWidth, masterHeight, Math.PI/2, 0, 0);
				bg.graphics.clear();
				bg.graphics.beginGradientFill(GradientType.LINEAR,gradientDown_,[1,1,1],[0,128,255],gradientBoxMatrix);
				bg.graphics.lineStyle(2,0x3f3f3f);
				bg.graphics.drawRoundRect(0,0,masterWidth,masterHeight,radius);
				bg.graphics.endFill();	
		}
		
		private function mouseUp_Handler(e:MouseEvent):void
		{
			var bg:Object;
			
			bg = ShapeSprite;
			gradientBoxMatrix.createGradientBox(masterWidth, masterHeight, Math.PI/2, 0, 0);
			bg.graphics.clear();
			bg.graphics.beginGradientFill(GradientType.LINEAR,gradientUp_,[1,1,1],[0,128,255],gradientBoxMatrix);
			bg.graphics.lineStyle(2,0x1e1e1e);
			bg.graphics.drawRoundRect(0,0,masterWidth,masterHeight,radius);
			bg.graphics.endFill();
			
			
		}
		
		public function remove():Boolean
		{
			var result:Boolean = wasteland();
			
			
			return result;
		}
		
		private function wasteland():Boolean
		{
			this.ShapeSprite.graphics.clear();
			this.removeEventListener(MouseEvent.MOUSE_DOWN,mouseDown_Handler);
			this.removeEventListener(MouseEvent.MOUSE_UP,mouseUp_Handler);
			
			var num:Number = this.numChildren-1;
			for (var i:Number = num;i >= 0;i--)
			{
				this.removeChildAt(i);
			}
			
			return true;
		}
		
		
		
		
		
		
		
	}
}