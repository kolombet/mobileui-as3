package 
{
	import com.greensock.*;
	
	import flash.display.DisplayObject;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import org.osmf.events.MediaPlayerStateChangeEvent;
	import org.osmf.events.TimeEvent;
	import org.osmf.layout.LayoutMetadata;
	import org.osmf.layout.ScaleMode;
	import org.osmf.media.MediaPlayerSprite;
	import org.osmf.media.MediaPlayerState;
	import org.osmf.media.URLResource;
	
	public class UIMediaPlayer extends Sprite
	{
		public var $playerInstance:MediaPlayerSprite;
		public var controlBar:UIControlBar;
		private var _stage:Stage;
		private var _parameters:Object;
		private var ControlTimer:Timer;
		public var HideControlTimerDelay:Number = 5000;
		public var $stage:Stage;
		private var $height:Number;
		private var $width:Number;
		private var loaderExists:Boolean = true;
		private var loader:UILoader;
		public function UIMediaPlayer()
		{
			
		}
		
		public function initPlayer(width:Number=200,height:Number=200,x:Number=0, y:Number=0,enableControls:Boolean = true,docked:Boolean=false,fullScreen:Boolean=false):void
		{
			init(width,height,x,y,enableControls,docked,fullScreen);
		}
		
		protected function init(w:Number,h:Number,x:Number,y:Number,controls:Boolean,docked:Boolean,fullScreen:Boolean):void
		{	
			$playerInstance = new MediaPlayerSprite(); 
			$width = w;
			$height = h;
			if(fullScreen)
			{
				this.x = 0;
				this.y = -80;
			}
			else{
				this.x = x;
				this.y = y-80;
			}
			
			//create controls
			if(controls)
			{
				controlBar = new UIControlBar();
				controlBar.createControlBar(w,40,0,h-40,null,false,false);
				
				controlBar.x = 0;
				controlBar.y = 0;
			}
			
			// create BG
			var bg:Shape = new Shape();
			bg.graphics.beginFill(0x000000,1);
			bg.graphics.drawRect(0,0,w,h-40);
			bg.graphics.endFill();
			
			// Assign the resource to play. This generates the appropriate 
			// MediaElement and passes it to the MediaPlayer. Because the MediaPlayer 
			// autoPlay property defaults to true, playback begins immediately. 
			$playerInstance.resource = new URLResource("http://osmf.org/dev/videos/cathy1_SD.mp4"); 
			$playerInstance.width = w;
			$playerInstance.height = h;
			$playerInstance.mediaContainer.height = h;
			$playerInstance.addChild(controlBar);
			
			//$playerInstance.scaleMode= ScaleMode.STRETCH;
			LayoutMetadata
			($playerInstance.media.getMetadata(LayoutMetadata.LAYOUT_NAMESPACE))
			.scaleMode
				= ScaleMode.STRETCH;
			$playerInstance.mediaPlayer.autoPlay = false;
			$playerInstance.mediaPlayer.pause();
			
			this.addChild(bg);
			this.addChild($playerInstance);
			
			if(controls)
			{
				//this.addChild(controlBar);
				
			}
			loader = new UILoader();
			loader.createLoader();
			
			loader.x = $width/2-200/2;
			loader.y = $height/2-100/2;
			loader.name = 'loader';
			this.addChild(loader);
			loaderExists = true;
			registerListeners(controls,docked);
		}
		
		private function registerListeners(bar:Boolean = true,docked:Boolean=true):void
		{
			if(bar){
				controlBar.play.addEventListener(MouseEvent.CLICK,goPlay,false,0,true);
				controlBar.pause.addEventListener(MouseEvent.CLICK,goPause,false,0,true);
				$playerInstance.mediaPlayer.addEventListener(MediaPlayerStateChangeEvent.MEDIA_PLAYER_STATE_CHANGE,checkState,false,0,true);
				$playerInstance.mediaPlayer.addEventListener(TimeEvent.DURATION_CHANGE,checkState,false,0,true);
				if(!docked)
				{
					autoHide();
				}
			}
		}
		
		private function checkState(e):void
		{
			//if it is a time event
			if(e.type!==undefined){
				if(e.type=='durationChange')
				{
					var result = this.getChildByName('loader');
					
					if(result!==undefined && result!==null)
					{
						this.removeChild(result);
						loaderExists = false;
					}
				}
			}
			else{  //else it is a state change event
				if(e.state==MediaPlayerState.BUFFERING||e.state==MediaPlayerState.LOADING)
				{
					//chech to see if the loader already exists, we don't want duplicates
					if(loaderExists==true){
						loader = new UILoader();
						loader.createLoader();
						
						loader.x = $width/2-200/2;
						loader.y = $height/2-100/2;
						loader.name = 'loader';
						this.addChild(loader);
						loaderExists = true;
					}
				}
				else{
					
					var result = this.getChildByName('loader');
					
					if(result!==undefined && result!==null)
					{
						this.removeChild(result);
						loaderExists = false;
					}
				}
			}
		}
		
		private function autoHide():void
		{
			// start timer for detecting for mouse movements/clicks to hide the controls
			ControlTimer = new Timer(HideControlTimerDelay, 1);
			ControlTimer.addEventListener(TimerEvent.TIMER_COMPLETE, 
				HideControlTimer_timerCompleteHandler, false, 0, true);
			
			// use stage or systemManager?
			$stage.addEventListener(MouseEvent.MOUSE_DOWN, resetControlTimer,false,0,true);
			$stage.addEventListener(MouseEvent.MOUSE_MOVE, resetControlTimer,false,0,true);
			$stage.addEventListener(MouseEvent.MOUSE_WHEEL, resetControlTimer,false,0,true);
			
			// keyboard events don't happen when in fullScreen mode, but could be in fullScreen and interactive mode
			$stage.addEventListener(KeyboardEvent.KEY_DOWN, resetControlTimer);
			
			ControlTimer.start();
			
		}
		
		private function HideControlTimer_timerCompleteHandler(event):void
		{
			TweenLite.to(controlBar,2,{x:0,y:$stage.height});
			ControlTimer.removeEventListener(TimerEvent.TIMER_COMPLETE,HideControlTimer_timerCompleteHandler,false);
			
		}
		
		private function resetControlTimer(event:Event):void
		{
			$stage.removeEventListener(MouseEvent.MOUSE_DOWN, resetControlTimer,false);
			$stage.removeEventListener(MouseEvent.MOUSE_MOVE, resetControlTimer,false);
			$stage.removeEventListener(MouseEvent.MOUSE_WHEEL, resetControlTimer,false);
			
			TweenLite.to(controlBar,1.8,{x:0,y:0});
			if(ControlTimer.running)
			{
				ControlTimer.reset();
				ControlTimer.start();
			}
			else{
				
				ControlTimer = new Timer(HideControlTimerDelay, 1);
				ControlTimer.addEventListener(TimerEvent.TIMER_COMPLETE, 
					HideControlTimer_timerCompleteHandler, false, 0, true);
				ControlTimer.start();
			}
			
			$stage.addEventListener(MouseEvent.MOUSE_DOWN, resetControlTimer,false,0,true);
			$stage.addEventListener(MouseEvent.MOUSE_MOVE, resetControlTimer,false,0,true);
			$stage.addEventListener(MouseEvent.MOUSE_WHEEL, resetControlTimer,false,0,true);
		}
		
		/*  CONTROL FUNCTIONS */ 
		
		public function goPlay(e:MouseEvent):void
		{
			var state:String = MediaPlayerState.READY;
			if($playerInstance.mediaPlayer.paused||$playerInstance.mediaPlayer.state==state)
			{
				$playerInstance.mediaPlayer.play();
			}
			else
				$playerInstance.mediaPlayer.pause();
		}
		
		public function goPause(e:MouseEvent):void
		{
			var state:String = MediaPlayerState.PLAYING;
			if($playerInstance.mediaPlayer.playing||$playerInstance.mediaPlayer.state==state)
			{
				$playerInstance.mediaPlayer.pause();
			}
		}
		
		private function wasteland():Boolean
		{
			
			return true;
		}
		
		public function remove():void
		{
			
		}
		
		
	}
}