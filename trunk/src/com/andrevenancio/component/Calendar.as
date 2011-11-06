package com.andrevenancio.component
{
    import flash.display.Sprite;
    import flash.events.MouseEvent;
    import flash.text.TextField;
    import flash.text.TextFormat;
    
    public class Calendar extends Sprite
    {
    	/** TEXT FORMAT */
    	private var month_tf:TextFormat;
		private var week_tf:TextFormat;
    	private var days_tf:TextFormat;
		private var button_tf:TextFormat;
      	
      	/** LANGUAGE CONFIG */
    	private var _months:Array = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
		private var _days:Array = ["S", "M", "T", "W", "T", "F", "S"]
		
		/** DAYS PER MONTH */
		private var _monthTotal:Array = new Array(31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31);
		
		/** CALENDAR */
		private var _today:Date = new Date();
   		private var _targetMonth:uint = _today.getMonth();
        private var _targetYear:uint = _today.getFullYear();
        
        /** VISUAL ASSETS */
        private var _selectedMonth:TextField;
        private var _daysWeek:Sprite = new Sprite();
        
        private var _nextBT:Sprite = new Sprite();
        private var _prevBT:Sprite = new Sprite();
        
        /** HOLDER FOR DAYS OF THE MONTH */
		private var _holder:Sprite = new Sprite();
        
        public function Calendar()
        {
           configStyle();
           build();
        }
        
        
        /**
        * Style Configurations
        * */
        private function configStyle():void
        {
        	month_tf = new TextFormat("Arial", 14, 0x333333, true);
           	month_tf.align = "center";
			
			week_tf = new TextFormat("Arial", 10, 0x666666, true); 
          	week_tf.align = "center";
		   
           	days_tf = new TextFormat("Arial", 10, 0x666666);
           	days_tf.align = "center";
           	
           	button_tf = new TextFormat("Arial", 10, 0xFFFFFF); 
           	button_tf.align = "center";
        }
        
        
        /**
        * Builds interface
        * */
        private function build():void
        {
        	/** Month and Year TextField */
        	_selectedMonth = new TextField();
        	_selectedMonth.text = "";
        	_selectedMonth.border = _selectedMonth.selectable = false;
        	_selectedMonth.width = 140;
        	_selectedMonth.height = 20;
			_selectedMonth.defaultTextFormat = TextFormat(month_tf);
        	addChild(_selectedMonth);
        
        	/** Days of the week */
        	addChild(_daysWeek);
        	for(var i:uint = 0; i<7;++i)
        	{
        		var temp:Sprite = new Sprite();
        			temp.graphics.beginFill(0,0);
        			temp.graphics.drawRect(0,0, 20, 20);
        			temp.graphics.endFill();
        			
        			temp.x = 20 * i;
        			temp.y = _selectedMonth.y + _selectedMonth.height;
        		addChild(temp);
        		writeText(_days[i], week_tf, temp);
        	}
        	
        	/** Buttons */
        	_prevBT.graphics.beginFill(1);
       		_prevBT.graphics.drawRect(0, 0, 16, 16);
       		_prevBT.graphics.endFill();
       		
       		_nextBT.graphics.beginFill(0);
       		_nextBT.graphics.drawRect(0, 0, 16, 16);
       		_nextBT.graphics.endFill();
      		
       		addChild(_prevBT);
       		addChild(_nextBT);
       		
       		writeText("<<", button_tf, _prevBT);
       		writeText(">>", button_tf, _nextBT);

       		_prevBT.x = -_prevBT.width;
       		_prevBT.y = 5;
       		
       		_nextBT.x = _selectedMonth.width;
       		_nextBT.y = 5;
       		
       		_nextBT.buttonMode = _prevBT.buttonMode = true;
       		
       		_prevBT.addEventListener(MouseEvent.CLICK, prevMonth);
       		_nextBT.addEventListener(MouseEvent.CLICK, nextMonth);
       		
       		/** Holder for days of the month */
			addChild(_holder);
			_holder.y = _selectedMonth.y + _selectedMonth.height;
        }
        
        
        /**
        * decreases current month and year if necessary
        * */
        private function prevMonth(e:MouseEvent):void
        {
        	_targetMonth = _targetMonth == 0 ? 12 : _targetMonth % 12;
        	_targetMonth--
        	_targetMonth % 12 == 11 ? _targetYear-- : null;
        	Render();
        }
        
        
        /**
        * increments current month and year if necessary
        * */
        private function nextMonth(e:MouseEvent):void
        {
        	_targetMonth++
        	_targetMonth = _targetMonth == 12 ? 0 : _targetMonth % 12;
        	_targetMonth % 12 == 0 ? _targetYear++ : null;
        	Render();
        }
        
        
        /**
        * Write Text in some sprite
        * */
        private function writeText(_text:String, _textFormat:TextFormat, _target:Sprite):void
        {
            var label_txt:TextField = new TextField();
            	label_txt.text = _text;
            	label_txt.border = label_txt.selectable = label_txt.mouseEnabled = false;
            	label_txt.autoSize = "left";
            	label_txt.defaultTextFormat = TextFormat(_textFormat);
            	label_txt.setTextFormat(_textFormat);
            _target.addChild(label_txt);
        }
        
        
        /**
        * remove all month days (sprites)
        * */
        private function cleanGraphics():void
        {
        	var total:uint = _holder.numChildren;
        	for(var i:uint = 0; i < total;++i)
        	{
        		_holder.removeChildAt(0);
        	}
        }
        
        
        /**
        * Renders Calendar info
        * */
        public function Render():void
        {
			/** removes all unnecessary assets */
        	cleanGraphics();
        	
        	
        	/** changes calendar month and year */
        	_selectedMonth.text = _months[_targetMonth % 12] + " " + _targetYear;
        	
        	
        	/** draws calendar based on year and month */
        	var daysNo:uint = (_targetYear % 4 == 0 && _targetMonth % 12 == 1 ? 29 : _monthTotal[_targetMonth % 12]);
           
           
           /** gets 1 day of the week in current selected month */
			var temp:Date = new Date(_targetYear, _targetMonth);
			var startDay:uint = temp.getDay();
           
           
           /** Adds sprite with days */
            var row:Number = 0;
            for (var i:uint = 1; i < daysNo+1; i++)
            {
            	var sp:Sprite = new Sprite();
                	sp.x = startDay * 20;
                	sp.y = (row+1) * 20;
                _holder.addChild(sp);
                
                writeText(i.toString(), days_tf, sp);
                startDay++;
                
                /** changes row on saturdays */
                if(startDay >= 7)
                {
                    startDay = 0;
                    row++;
                }
            }
        }
                
        
        /**
		 * SETTERS GETTERS
		 * */        
        public function set month(_value:uint):void {_targetMonth = _value;}
        
        public function set year(_value:uint):void {_targetYear = _value;}
        
        public function get month():uint {return _targetMonth;}
        
        public function get year():uint {return _targetYear;}
    }
}