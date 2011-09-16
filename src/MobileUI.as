package
{
	import Utils.Utils;
	
	import com.greensock.*;
	
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.MouseEvent;
	import flash.filters.*;
	import flash.system.Capabilities;
	
	public class MobileUI extends Sprite
	{
		var util:Utils = new Utils();
		public function MobileUI()
		{
			super();
			
			// support autoOrients
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			//get dimentions from stage
			var st:Stage  = stage;
			var SGwidth:Number = st.fullScreenWidth;
			var SGheight:Number = st.fullScreenHeight;
			
			var button:UIButton = new UIButton();
			button.createButton([util.getHEX(255,255,255),util.getHEX(237,237,237),util.getHEX(255,255,255)],[util.getHEX(246,248,249),util.getHEX(229,235,238),util.getHEX(215,222,227)],80,50,200,400,'cog','','left',0x000000,32);
			button.registerListeners();
			
			var checkbox:UICheckbox = new UICheckbox();
			checkbox.createCheckbox(40,40,250,100,null,0x000000,'=');
			checkbox.registerListeners();
			
			var searchInput:UISearchInput = new UISearchInput();
			searchInput.createSearchInput('search',150,40,300,200,'',null,null);
	
			button.addEventListener(MouseEvent.CLICK,function(){
				
				TweenLite.to(nav,1,{x:SGwidth*-1,y:0,onComplete:function(){
					
					nav.remove();
				}});
				//TweenLite.to(nav1, 1, {x:0, y:0});
			
			});
			
			// player
			//var pl:UIMediaPlayer = new UIMediaPlayer();
			//pl.initPlayer(400,300,10,470);
			
			//slider
			var slider:UISlider = new UISlider();
			slider._stage = stage;
			slider.createSlider(20,100,10,200);
			
			var mediaPlayer:UIMediaPlayer = new UIMediaPlayer();
			mediaPlayer.initPlayer(SGwidth,400,0,SGheight-400,true);
			
			trace(mediaPlayer.height);
			// Navigator
			var nav:UINavigator = new UINavigator();
			
			nav.createTopBar(SGwidth,80,null,false,false,'Page #1');
			nav.createNavigator(0xcccccc,SGwidth,SGheight,[checkbox,button,searchInput,slider,mediaPlayer]);
			nav.x = 0;
			nav.y = 0;
			
			//////////////
		/*	var searchInput2:UISearchInput = new UISearchInput();
			searchInput2.createSearchInput('password',150,40,300,200,'');
			
			var nav1:UINavigator = new UINavigator();
			nav1.createTopBar(SGwidth,80,null,true,false,'Page #2');
			nav1.createNavigator(0x419141,SGwidth,SGheight,[searchInput2]);
			nav1.x = SGwidth;
			nav1.y = 0;
		*/	
			addChild(nav);
			//addChild(nav1);
			//addChild(checkbox);
			//addChild(button);
			//addChild(searchInput);
		
		}
		
		
		
		private function getBitmapFilter():BitmapFilter {
			var color:Number = 0x000000;
			var alpha:Number = 0.8;
			var blurX:Number = 24;
			var blurY:Number = 24;
			var strength:Number = 2;
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