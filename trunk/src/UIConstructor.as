package
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	
	public class UIConstructor extends Sprite
	{
		public function UIConstructor()
		{
			//nothing much...
			super();
		}
		
		/**
		 * This is where UIMobile framework users construct their view. 
		 * This environment is ideal for adding components and then adding them to UINavigator
		 * 
		 * TODO: add functions for removal, add functions for rotation, add attributes such as top, bot, left, right,
		 * expose components into public by naming components and then getters and setters
		 * 
		**/
		public function constructView(bgColor:uint=0xffffff,width:Number = 480,height:Number=800,items:Array = null):void
		{
		
			var mainRect:Sprite = new Sprite();
			mainRect.graphics.beginFill(bgColor,1);
			mainRect.graphics.drawRect(0,0,width,height);
			mainRect.graphics.endFill();
			mainRect.x = 0;
			mainRect.y = 0;
			mainRect.name = 'container';
			mainRect.width = width;
			mainRect.height = height;
				
			for each(var item:* in items)
			{
				mainRect.addChild(item);
			}
				
			this.addChild(mainRect);
			
		}
		
		private function wasteland():Boolean
		{
			var num:Number = this.numChildren-1;
			//search and destroy
			for (var i:int = num;i >= 0;i--)
			{
				var item = this.getChildAt(i);
				//all outside children are in here
				if(item.name=='container')
				{
					var internalItems:Number = item.numChildren-1;
					//internal removal
					for(var j:int = internalItems;j>=0;j--)
					{
						item.getChildAt(j).remove();
						item.removeChildAt(j);
					}
				}
				
				this.removeChildAt(i);
				
				
			}
			return true;
		}
			
		public function remove():void
		{
			var result:Boolean = wasteland();
				
		}	
		
		
		//example
		public function getComponent(name:String):DisplayObject
		{
			return this.getChildByName(name);
		}
		
	}
}