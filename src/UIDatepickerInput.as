package
{
	import Utils.Utils;
	
	import com.andrevenancio.component.Calendar;
	import com.greensock.*;
	import com.greensock.plugins.*;
	
	import flash.display.CapsStyle;
	import flash.display.GradientType;
	import flash.display.JointStyle;
	import flash.display.Shader;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.FocusEvent;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.filters.*;
	import flash.geom.ColorTransform;
	import flash.geom.Matrix;
	import flash.text.*;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.utils.getQualifiedClassName;
	
	import mx.core.SpriteAsset;
	
	public class UIDatepickerInput extends Sprite
	{
		
		private var inputBox:Shape;
		private var txtInput:TextField;
		private var radius:Number = 15;
		private var gradientBoxMatrix:Matrix;
		private var utils:Utils = new Utils();
		private var icon:Sprite
		
		public var textSize:Number = 22;
		public var borderColor:uint = 0xb1b1b1;
		public var iconColor:uint   = 0x999999;
		public var iconContainer:Sprite = new Sprite();
		public var $stage:Stage;
		
		public function UIDatepickerInput()
		{
			super();
		}
		
		
		
		public function createUIDatepicker(width:Number,height:Number,x:Number=0,y:Number=0,onFocus:Boolean=true):void
		{
			this.x = x;
			this.y = y;
			
			var color:Array = [0xffffff,0xffffff];
			
			// create the input
			// draw the rectancle
			inputBox = new Shape();
			gradientBoxMatrix = new Matrix();
			
			gradientBoxMatrix.createGradientBox(width, height, Math.PI/2, 0, 0);  
			
			inputBox.graphics.beginGradientFill(GradientType.LINEAR,color,[1,1],[0,255],gradientBoxMatrix);
			inputBox.graphics.lineStyle(2,borderColor,1,true);
			inputBox.graphics.drawRoundRect(0,0,width,height,radius,radius);
			inputBox.graphics.endFill();
			
			var myGlow:BitmapFilter = getBitmapFilter();
			inputBox.filters = [myGlow]; // apply inner glow filter;
			
			//the Input
			txtInput = new TextField();
			txtInput.type = TextFieldType.INPUT;
			txtInput.width = width-30;
			var tf:TextFormat = new TextFormat(null,textSize,0x2e2e2e);
			txtInput.setTextFormat(tf);
			txtInput.defaultTextFormat = tf;
			txtInput.y = height/2-txtInput.textHeight/2-2;
			txtInput.x = 6;
			
			//create a rect with the icon
			
			iconContainer.graphics.beginGradientFill(GradientType.LINEAR,[0xffffff,0xe5e5e5],[1,1],[0,255],gradientBoxMatrix);
			iconContainer.graphics.lineStyle(1,0xb1b1b1,1,true);
			iconContainer.graphics.drawCircle(28,28,28);
			iconContainer.graphics.endFill();
			iconContainer.x = width-20;
			iconContainer.y = -8;
			
			
			icon = utils.getIcon('calendar') as SpriteAsset;
			icon.buttonMode = true;
			icon.useHandCursor = true;
			
			var colorize:ColorTransform = new ColorTransform();
			colorize.color = 0x1e1e1e;
			icon.transform.colorTransform = colorize;
			
			iconContainer.addChild(icon);
			
			icon.x = iconContainer.width/2 - icon.width/2;
			icon.y = iconContainer.height/2 - icon.height/2;
			
			this.addChild(inputBox);
			this.addChild(iconContainer);
			this.addChild(txtInput);
			
			addEventListeners();
		}
		
		private function addEventListeners():void
		{
			icon.addEventListener(MouseEvent.CLICK,openCalendar,false,0,true);
			$stage.addEventListener(MouseEvent.CLICK, closeCalendar,false, 0, true);
		}
		
		private function openCalendar(e:Event):void
		{
			var bg:Sprite = new Sprite();
			bg.graphics.beginFill(0xf7f7f7,1);
			bg.graphics.lineStyle(1,0x1e1e1e,1);
			bg.graphics.drawRoundRect(0,0,180,140,5,5);
			bg.graphics.endFill();
			bg.x = this.x;
			bg.y = this.y;
			
			var calendar:Calendar = new Calendar();
			calendar.x = 20;
			calendar.y = 0;
			bg.addChild(calendar);
			$stage.addChild(bg);
			
			calendar.name = 'calendar';
			var _data:Date = new Date();
			calendar.month = _data.getMonth();
			calendar.year = _data.getFullYear();
			calendar.Render();
		}
		
		private function closeCalendar(e:Event):void
		{
			
		}
		
		private function wasteland():Boolean{
			
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