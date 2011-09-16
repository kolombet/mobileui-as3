package Utils
{
	public class Utils
	{
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
		
		public function gcd (a, b) {
			return (b == 0) ? a : gcd (b, a%b);
		}

	}
}