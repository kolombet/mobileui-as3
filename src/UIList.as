package
{
	import Utils.Utils;
	
	import com.greensock.*;
	import com.greensock.easing.*;
	import com.greensock.plugins.*;
	
	import flash.display.*;
	import flash.display.CapsStyle;
	import flash.display.DisplayObjectContainer;
	import flash.display.GradientType;
	import flash.display.JointStyle;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;
	import flash.text.*;
	import flash.utils.getTimer;
	
	TweenPlugin.activate([ThrowPropsPlugin]);
	
	public class UIList extends Sprite
	{
		private var t1:uint;
		private var t2:uint; 
		private var y1:Number;
		private var y2:Number;
		private var bounds:Rectangle;
		private var mc:Sprite;
		private var utils:Utils = new Utils();
		public function UIList()
		{
			super();
		}
	
	public function createList(x:Number,y:Number,width:Number=200,height:Number=200,data:Object=null):void
	{
		//mainContainer
		mc = new Sprite();
		mc.graphics.beginFill(0xf8f8f8,1);
		mc.graphics.lineStyle(1,0xcccccc,1);
		mc.graphics.drawRect(x,y,width,height);
		mc.graphics.endFill();
		
		if(data is String)
		{
			utils.dataLoad(data);
			utils.loader.addEventListener(Event.COMPLETE,dataLoaded,false,0,true);
		}
		else{
			
			dataLoaded('ready',data);
		}
		bounds = new Rectangle(x, y, width, height);
		addChild(mc);
		
		var crop:Shape = new Shape();
		crop.graphics.beginFill(0xFF0000, 1);
		crop.graphics.drawRect(bounds.x, bounds.y, bounds.width, bounds.height);
		crop.graphics.endFill();
		mc.parent.addChild(crop);
		mc.y = y;
		mc.mask = crop;
		//setupTextField(mc, bounds);
		
		
		registerListeners();
		
	}
	
	private function registerListeners():void
	{
		mc.addEventListener(MouseEvent.MOUSE_DOWN, mouseDownHandler, false, 0, true);
	}
	
	private function dataLoaded(e,data:Object=null):void
	{
		if(e!='ready'){
			var items:XMLList;
			// this property holds the loaded xml data
			data = new XML(e.target.data);
			// the items property holds all the repeating item elements
			items = data.item;
			
			data = items;
		}
			
		var gradientColor_:Array = [0xf7f7f7,0xf1f1f1,0xf0f0f0];
		
		//little ones
		var gradientBoxMatrix:Matrix = new Matrix();
		gradientBoxMatrix.createGradientBox(width, height, Math.PI/2, 0, 0);  
		var obj:Sprite;
		
		
		var tfl:TextField;
		var tf:TextFormat = new TextFormat(null,22,0x000000);
		var i:int = 0;
		
		for each(var item:Object in data)
		{
			obj = new Sprite();
			tfl = new TextField();
			obj.graphics.beginGradientFill(GradientType.LINEAR,gradientColor_,[1,1,1],[0,128,255],gradientBoxMatrix);
			obj.graphics.lineStyle(1,0x1e1e1e,1);
			obj.graphics.drawRect(x,0,width,50);
			obj.graphics.endFill();
			obj.x = 0;
			obj.height = 50;
			obj.width = width;
			obj.y = 50*i;
			
			// Create Text
			tfl.text = item[0].toString();
			tfl.width = width;
			tfl.height = 40;
			tfl.textColor = 0x000000;
			tfl.embedFonts = false;
			tfl.selectable = false;
			tfl.setTextFormat(tf);
			tfl.x = 20;
			tfl.y = 15;
			
			obj.addChild(tfl);
			mc.addChild(obj);
			i += 1;
		}
	}
	
	private function mouseDownHandler(event:MouseEvent):void {
		TweenLite.killTweensOf(mc);
		y1 = y2 = mc.y;
		t1 = t2 = getTimer();
		mc.startDrag(false, new Rectangle(bounds.x, -99999, 0, 99999999));
		mc.addEventListener(Event.ENTER_FRAME, enterFrameHandler,false,0,true);
		mc.stage.addEventListener(MouseEvent.MOUSE_UP, mouseUpHandler, false, 0, true);
	}
	
	private function enterFrameHandler(event:Event):void {
		y2 = y1;
		t2 = t1;
		y1 = mc.y;
		t1 = getTimer();
	}
	
	private function mouseUpHandler(event:MouseEvent):void {
		mc.stopDrag();
		mc.stage.removeEventListener(MouseEvent.MOUSE_UP, mouseUpHandler);
		mc.removeEventListener(Event.ENTER_FRAME, enterFrameHandler);
		var time:Number = (getTimer() - t2) / 1000;
		var yVelocity:Number = (mc.y - y2) / time;
		var yOverlap:Number = Math.max(0, mc.height - bounds.height+120);
		ThrowPropsPlugin.to(mc, {throwProps:{
			y:{velocity:yVelocity, max:bounds.top, min:bounds.top - yOverlap, resistance:300}
		}, ease:Strong.easeOut
		}, 8, 0.3, 1);
	}
	
	
	private function wasteland():Boolean
	{
		mc.removeEventListener(Event.ENTER_FRAME,enterFrameHandler,false);
		mc.removeEventListener(MouseEvent.MOUSE_DOWN, mouseDownHandler, false);
		mc.removeEventListener(MouseEvent.MOUSE_UP, mouseUpHandler, false);
		
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