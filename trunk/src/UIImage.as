package
{
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.net.URLRequest;
	
	public class UIImage extends DisplayObjectContainer
	{
		public function UIImage()
		{
			super();
			
		}
		
		
		public function createImage(w:Number=100,h:Number=100,value:Object)
		{
			if (value is Class)
			{
				var cls:Class = Class(value);
				value = new cls();
			}
			else if (value is String || value is URLRequest)
			{
				loadExternal(value);
			}
		}
		
		private function loadExternal(url:String)
		{
			
		 
		}
		
		
	}
}