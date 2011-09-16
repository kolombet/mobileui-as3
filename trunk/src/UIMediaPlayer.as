package 
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.MouseEvent;
	
	import org.osmf.media.MediaPlayerSprite;
	import org.osmf.media.MediaPlayerState;
	import org.osmf.media.URLResource;

	public class UIMediaPlayer extends Sprite
	{
		public var $playerInstance:MediaPlayerSprite;
		public var controlBar:UIControlBar;
		private var _stage:Stage;
		private var _parameters:Object;
		
		public function UIMediaPlayer()
		{
			
		}
		
		public function initPlayer(width:Number=200,height:Number=200,x:Number=0, y:Number=0,enableControls:Boolean = true)
		{
			init(width,height,x,y,true);
		}
		
		protected function init(w:Number,h:Number,x:Number,y:Number,controls:Boolean):void
		{	
			//this.width = w;
			//this.height = h;
			this.x = x;
			this.y = y-80;
			
			$playerInstance = new MediaPlayerSprite(); 
			
			if(controls)
			{
				controlBar = new UIControlBar();
				controlBar.createControlBar(w,40,0,h-40,null,false,false);
				
				controlBar.x = 0;
				controlBar.y = 0;
			}
			
			// Assign the resource to play. This generates the appropriate 
			// MediaElement and passes it to the MediaPlayer. Because the MediaPlayer 
			// autoPlay property defaults to true, playback begins immediately. 
			$playerInstance.resource = new URLResource("http://osmf.org/dev/videos/cathy1_SD.mp4"); 
			$playerInstance.width = w;
			$playerInstance.height = h;
			$playerInstance.mediaContainer.height = h;
			$playerInstance.addChild(controlBar);
			trace(h-controlBar.height+"<<<<");
			//$playerInstance.scaleMode = 'stretch';
			$playerInstance.mediaPlayer.autoPlay = false;
			$playerInstance.mediaPlayer.pause();
			
			
			this.addChild($playerInstance);
			
			if(controls)
			{
				//this.addChild(controlBar);
				
			}
			
			registerListeners(controls);
		}
		
		private function registerListeners(bar:Boolean = true)
		{
			if(bar){
			controlBar.play.addEventListener(MouseEvent.CLICK,goPlay,false,0,true);
			controlBar.pause.addEventListener(MouseEvent.CLICK,goPause,false,0,true);
			}
		}
		
		/*  CONTROL FUNCTIONS */ 
		
		public function goPlay(e:MouseEvent)
		{
			var state = MediaPlayerState.READY;
			if($playerInstance.mediaPlayer.paused||$playerInstance.mediaPlayer.state==state)
			{
				$playerInstance.mediaPlayer.play();
			}
			else
				$playerInstance.mediaPlayer.pause();
		}
		
		public function goPause(e:MouseEvent)
		{
			var state = MediaPlayerState.PLAYING;
			if($playerInstance.mediaPlayer.playing||$playerInstance.mediaPlayer.state==state)
			{
				$playerInstance.mediaPlayer.pause();
			}
		}
		
		private function wasteland()
		{
			
			return true;
		}
		
		public function remove()
		{
			
		}
		
		
	}
}