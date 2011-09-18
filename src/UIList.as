package
{
	import flash.display.DisplayObjectContainer;
	
	import com.greensock.*; 
	import com.greensock.easing.*;
	import com.greensock.plugins.*;
	import flash.geom.Rectangle;
	import flash.utils.getTimer;
	import flash.events.MouseEvent;
	import flash.text.*;
	import flash.display.*;
	import flash.events.Event;
	
	TweenPlugin.activate([ThrowPropsPlugin]);
	
	public class UIList extends DisplayObjectContainer
	{
		var t1:uint, t2:uint, y1:Number, y2:Number;
		var bounds:Rectangle = new Rectangle(30, 30, 250, 230);
		var mc:Sprite = new Sprite();
		public function UIList()
		{
			super();
		}
	
	function createList()
	{
		
		
		
		addChild(mc);
		setupTextField(mc, bounds);
		
		
		
		mc.addEventListener(MouseEvent.MOUSE_DOWN, mouseDownHandler);
	}
	
	function mouseDownHandler(event:MouseEvent):void {
		TweenLite.killTweensOf(mc);
		y1 = y2 = mc.y;
		t1 = t2 = getTimer();
		mc.startDrag(false, new Rectangle(bounds.x, -99999, 0, 99999999));
		mc.addEventListener(Event.ENTER_FRAME, enterFrameHandler);
		mc.stage.addEventListener(MouseEvent.MOUSE_UP, mouseUpHandler);
	}
	
	function enterFrameHandler(event:Event):void {
		y2 = y1;
		t2 = t1;
		y1 = mc.y;
		t1 = getTimer();
	}
	
	function mouseUpHandler(event:MouseEvent):void {
		mc.stopDrag();
		mc.stage.removeEventListener(MouseEvent.MOUSE_UP, mouseUpHandler);
		mc.removeEventListener(Event.ENTER_FRAME, enterFrameHandler);
		var time:Number = (getTimer() - t2) / 1000;
		var yVelocity:Number = (mc.y - y2) / time;
		var yOverlap:Number = Math.max(0, mc.height - bounds.height);
		ThrowPropsPlugin.to(mc, {throwProps:{
			y:{velocity:yVelocity, max:bounds.top, min:bounds.top - yOverlap, resistance:100}
		}, ease:Cubic.easeOut
		}, 9, 0.2, 1);
	}
	
	function setupTextField(container:Sprite, bounds:Rectangle, padding:Number=20):void {
		var tf:TextField = new TextField();
		tf.width = bounds.width - padding;
		tf.x = tf.y = padding / 2;
		tf.defaultTextFormat = new TextFormat("_sans", 12);
		tf.text = "Click and drag this content and then let go as you're dragging to throw it. Notice how it smoothly glides into place, respecting the initial velocity and the maximum/minimum coordinates.\n\nThrowPropsPlugin allows you to simply define an initial velocity for a property (or multiple properties) as well as optional maximum and/or minimum end values and then it will calculate the appropriate landing position and plot a smooth course based on the easing equation you define (Quad.easeOut by default, as set in TweenLite). This is perfect for flick-scrolling or animating things as though they are being thrown.\n\nFor example, let's say a user clicks and drags a ball and you track its velocity using an ENTER_FRAME handler and then when the user releases the mouse button, you'd determine the velocity but you can't do a normal tween because you don't know exactly where it should land or how long the tween should last (faster initial velocity would mean a longer duration). You need the tween to pick up exactly where the user left off so that it appears to smoothly continue moving at the same velocity they were dragging and then decelerate based on whatever ease you define in your tween.\n\nAs demonstrated here, maybe the final resting value needs to lie within a particular range so that the content doesn't land outside a particular area. But you don't want it to suddenly jerk to a stop when it hits the edge; instead, you want it to ease gently into place even if that means going past the landing spot briefly and easing back (if the initial velocity is fast enough to require that). The whole point is to make it look smooth.\n\nThrowPropsPlugin isn't just for tweening x and y coordinates. It works with any numeric property, so you could use it for spinning the rotation of an object as well. Or the scaleX/scaleY properties. Maybe the user drags to spin a wheel and lets go and you want it to continue increasing the rotation at that velocity, decelerating smoothly until it stops.\n\nOne of the trickiest parts of creating a throwProps tween that looks fluid and natural, particularly if you're applying maximum and/or minimum values, is determining its duration. Typically it's best to have a relatively consistent level of resistance so that if the initial velocity is very fast, it takes longer for the object to come to rest compared to when the initial velocity is slower. You also may want to impose some restrictions on how long a tween can last (if the user drags incredibly fast, you might not want the tween to last 200 seconds). The duration will also affect how far past a max/min boundary the property can potentially go, so you might want to only allow a certain amount of overshoot tolerance. That's why ThrowPropsPlugin has a few static helper methods that make managing all these variables much easier. The one you'll probably use most often is the to() method which is very similar to TweenLite.to() except that it doesn't have a duration parameter and it adds several other optional parameters.\n\nA unique convenience of ThrowPropsPlugin compared to most other solutions out there which use ENTER_FRAME loops is that everything is reverseable and you can jump to any spot in the tween immediately. So if you create several throwProps tweens, for example, and dump them into a TimelineLite, you could simply call reverse() on the timeline to watch the objects retrace their steps right back to the beginning.\n\nThe overshootTolerance parameter sets a maximum number of seconds that can be added to the tween's duration (if necessary) to accommodate temporarily overshooting the end value before smoothly returning to it at the end of the tween. This can happen in situations where the initial velocity would normally cause it to exceed the max or min values. An example of this would be in the iOS (iPhone or iPad) when you flick-scroll so quickly that the content would shoot past the end of the scroll area. Instead of jerking to a sudden stop when it reaches the edge, the content briefly glides past the max/min position and gently eases back into place. The larger the overshootTolerance the more leeway the tween has to temporarily shoot past the max/min if necessary.";
		tf.multiline = tf.wordWrap = true;
		tf.selectable = false;
		tf.autoSize = TextFieldAutoSize.LEFT;
		container.addChild(tf);
		
		container.graphics.beginFill(0xFFFFFF, 1);
		container.graphics.drawRect(0, 0, tf.width + padding, tf.textHeight + padding);
		container.graphics.endFill();
		container.x = bounds.x;
		container.y = bounds.y;
		
		var crop:Shape = new Shape();
		crop.graphics.beginFill(0xFF0000, 1);
		crop.graphics.drawRect(bounds.x, bounds.y, bounds.width, bounds.height);
		crop.graphics.endFill();
		container.parent.addChild(crop);
		container.mask = crop;
	};

	
	}
	
}