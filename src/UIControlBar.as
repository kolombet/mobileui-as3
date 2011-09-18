package
{
	import com.somerandomdude.iconic.*;
	
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
	
	import mx.core.SpriteAsset;

	
	public class UIControlBar extends Sprite
	{
		
		
		public var play:SpriteAsset;
		public var pause:SpriteAsset;
		public var volume:SpriteAsset;
		public var mute:SpriteAsset;
		public var fullScreen:SpriteAsset;
		
		private var bar:Sprite;
		
		
		public function UIControlBar()
		{
			super();
		}
		
		
		
		public function createControlBar(width:Number=200, height:Number=30, x:Number=0, y:Number=300, bgColor:Array=null, fullscreenEnabled:Boolean=true, isMusicPlayer:Boolean=false):void
		{
			
			bar = new Sprite();
			var gradientBoxMatrix:Matrix = new Matrix();
			gradientBoxMatrix.createGradientBox(width, height, Math.PI/2, 0, 0);  
			play = new Iconic.play() as SpriteAsset;
			
			pause = new SpriteAsset();
			var pauseBG:Sprite = new Sprite();
			
			pauseBG.graphics.beginGradientFill(GradientType.LINEAR,[0xcccccc,0xf8f8f8],[1,1],[0,255],gradientBoxMatrix);
			pauseBG.graphics.drawRoundRect(0,0,32,32,0);
			pauseBG.graphics.endFill();
			pauseBG.addChild(new Iconic.pause() as SpriteAsset);
			pause.addChild(pauseBG);
			//pause = new Iconic.pause() as SpriteAsset;
			volume = new Iconic.volume() as SpriteAsset;
			
			
			
			bar.graphics.beginGradientFill(GradientType.LINEAR,[0xcccccc,0xf8f8f8],[1,1],[0,255],gradientBoxMatrix);
			//bar.graphics.lineStyle(2,0x1e1e1e,1,true);
			bar.graphics.drawRoundRect(0,0,width,height,0);
			bar.graphics.endFill();
			
			bar.x = x;
			bar.y = y;
			
			var lineTop:Shape = new Shape();
			lineTop.graphics.lineStyle(1,0x333333,1);
			lineTop.graphics.moveTo(0,0);
			lineTop.graphics.lineTo(width, 0);
			lineTop.graphics.endFill();
			lineTop.x = 0;
			lineTop.y = 0;
			lineTop.width = width;
			
			var lineBot:Shape = new Shape();
			lineBot.graphics.lineStyle(1,0x333333,1);
			lineBot.graphics.moveTo(0,height);
			lineBot.graphics.lineTo(width, height);
			lineBot.graphics.endFill();
			
			lineBot.width = width;
			
			/// END OF CREATING THE MAIN BAR
			play.x = 20;
			play.y = height/2 - play.height/2;
			
			pause.buttonMode = true;
			pause.mouseEnabled = true;
			pause.cacheAsBitmap = true;
			
			pause.x = play.x + play.width+20;
			pause.y = height/2 - pause.height/2;
			
			volume.x = width - volume.width - 20;
			volume.y = height/2 - volume.height/2;
			volume.buttonMode = true;
			volume.mouseEnabled = true;
			volume.cacheAsBitmap = true;
			
			bar.addChild(lineTop);
			bar.addChild(lineBot);
			bar.addChild(play);
			bar.addChild(pause);
			bar.addChild(volume);
			this.addChild(bar);
			
		}
		
		
		private function registerListeners():void
		{
			
		}
		
		private function wasteland():Boolean
		{
			bar.graphics.clear();
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