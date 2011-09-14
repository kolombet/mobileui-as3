package 
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	
	import org.osmf.media.MediaPlayerSprite;
	import org.osmf.media.URLResource;
	

	public class UIMediaPlayer extends Sprite
	{
		public var $playerInstance:MediaPlayerSprite;
		
		private var _stage:Stage;
		private var _parameters:Object;
		
		public function UIMediaPlayer()
		{
			
		}
		
		public function initPlayer(width:Number=200,height:Number=200,x:Number=0, y:Number=0)
		{
			init(width,height,x,y);
		}
		
		protected function init(w,h,x,y):void
		{	
			//this.width = w;
			//this.height = h;
			this.x = x;
			this.y = y;
			
			$playerInstance = new MediaPlayerSprite(); 
			
			
			// Assign the resource to play. This generates the appropriate 
			// MediaElement and passes it to the MediaPlayer. Because the MediaPlayer 
			// autoPlay property defaults to true, playback begins immediately. 
			$playerInstance.resource = new URLResource("http://osmf.org/dev/videos/cathy1_SD.mp4"); 
			$playerInstance.width = w;
			$playerInstance.height = h;
			$playerInstance.mediaPlayer.autoPlay = true;
			
			this.addChild($playerInstance);
			
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