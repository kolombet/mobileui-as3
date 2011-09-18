package Utils
{
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.events.Event;
	
	import mx.core.SpriteAsset;

	public class Utils
	{
		import com.somerandomdude.iconic.*;
		
		public var loader:URLLoader;
		public var data:XML;
		public var items:XMLList;
		
		public function Utils()
		{
			//nothing much
		}
		
		public function getHEX(r:Number, g:Number, b:Number):String{
			
			return "0x"+displayInHex(combineRGB(r,g,b));
		}
		
		private function extractRed(c:uint):uint {
			
			return (( c >> 16 ) & 0xFF);
			
		}
		
		
		private function extractGreen(c:uint):uint {
			
			return ( (c >> 8) & 0xFF );
			
		}
		
		
		private function extractBlue(c:uint):uint {
			
			return ( c & 0xFF );
			
		}
		
		private function combineRGB(r:uint,g:uint,b:uint):uint {
			
			return ( ( r << 16 ) | ( g << 8 ) | b );
			
		}
		
		private function displayInHex(c:uint):String {
			
			var r:String=extractRed(c).toString(16).toUpperCase();
			
			var g:String=extractGreen(c).toString(16).toUpperCase();
			
			var b:String=extractBlue(c).toString(16).toUpperCase();
			
			var hs:String="";
			
			var zero:String="0";
			
			if(r.length==1){
				
				r=zero.concat(r);
				
			}
			
			if(g.length==1){
				
				g=zero.concat(g);
				
			}
			
			if(b.length==1){
				
				b=zero.concat(b);
				
			}
			
			hs=r+g+b;
			
			return hs;
		}
		
		public function gcd (a:Number, b:Number):Number {
			return (b == 0) ? a : gcd (b, a%b);
		}
		
		public function getIcon(resource:String):SpriteAsset
		{
			var result:SpriteAsset;
			switch(resource){
				
				case 'mail':
					result = new Iconic.mail() as SpriteAsset;
					break;
				case 'home':
					result = new Iconic.home() as SpriteAsset;
					break;
				case 'plus':
					result = new Iconic.plus() as SpriteAsset;
					break;
				case 'cog':
					result = new Iconic.cogAlt() as SpriteAsset;
					break;
				case 'minus':
					result = new Iconic.minus() as SpriteAsset;
					break;
				case 'link':
					result = new Iconic.link() as SpriteAsset;
					break;
				case 'close':
					result = new Iconic.x() as SpriteAsset;
					break;
				case 'user':
					result = new Iconic.user() as SpriteAsset;
					break;
				case 'image':
					result = new Iconic.image() as SpriteAsset;
					break;
				case 'info':
					result = new Iconic.lightbulb() as SpriteAsset;
					break;
				default:
					result = new Iconic.denied() as SpriteAsset;
					break;
				
			}
			
			return result;
		}
		
		public function dataLoad(src:String):void {
			loader = new URLLoader();
			loader.load(new URLRequest(src));
		}
		
		private function dataLoaded(event:Event):void {
			trace("Data Loaded.");
		}

	}
}