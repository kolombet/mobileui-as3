package
{
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.filters.*;
	
	public class MobileUI extends Sprite
	{
		public function MobileUI()
		{
			super();
			
			// support autoOrients
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			
			var button:UIButton = new UIButton();
			button.createButton([button.getHEX(255,255,255),button.getHEX(237,237,237),button.getHEX(255,255,255)],[button.getHEX(246,248,249),button.getHEX(229,235,238),button.getHEX(215,222,227)],120,60,10,10,'E','EMail','left',0x000000);
			button.registerListeners();
			
			var checkbox:UICheckbox = new UICheckbox();
			checkbox.createCheckbox(40,40,250,100,null,0x000000,'=');
			checkbox.registerListeners();
			
			var searchInput:UISearchInput = new UISearchInput();
			searchInput.createSearchInput(150,40,300,200,'');
		
			var glow:filtering = new filtering();
			glow.GlowFilterExample();
			
			addChild(glow);
			addChild(checkbox);
			addChild(button);
			addChild(searchInput);
		
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