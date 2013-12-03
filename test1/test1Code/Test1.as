package test1Code {
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.BitmapData;
	import flash.display.BitmapDataChannel;
	import flash.display.Bitmap;
	import flash.display.*;
	import flash.display.IBitmapDrawable;
	import flash.events.MouseEvent;
	import flash.events.Event;
	import flash.display.DisplayObject;
	import flash.geom.*;
	import flash.text.TextField;
	
	public class Test1 extends MovieClip {
		public var myBall:Ball;
		public var swirl:Swirl;
		private var bdat1:BitmapData, bdat2:BitmapData;
		private var t1:TextField;
	
		
		
		public function Test1() {
			// constructor code
			
			swirl = new Swirl(); 
			addChildAt(swirl, numChildren - 1);
			swirl.x=stage.width / 2;
			swirl.y=stage.height /2;
			bdat1 = new BitmapData(300, 300, true, 0x00000000);
			bdat1.draw(swirl);
			
			addChild(myBall);
			bdat2 = new BitmapData(50, 50, true, 0x00000000);
			bdat2.draw(myBall);
			
			myBall.addEventListener(MouseEvent.MOUSE_DOWN, startD);
			myBall.addEventListener(MouseEvent.MOUSE_UP, endD);
			
			t1 = new TextField(); addChild(t1);
			t1.x = stage.stageWidth * 0.2; t1.y = stage.stageHeight * 0.8; 
			t1.width = 300; t1. height = 100;
			
			stage.addEventListener(Event.ENTER_FRAME, checkC);


			
			
			
			//END Const.
		}
		private function startD(e:MouseEvent):void 
			{
				e.target.startDrag();
			}
		
		private function endD(e:MouseEvent):void 
			{
				e.target.stopDrag();
			}
		
		private function checkC(e:Event):void 
			{
				var closeEnough:Boolean = myBall.hitTestObject(swirl)
				if(closeEnough){
					var point1:Point = new Point(swirl.x, swirl.y);
					var point2:Point = new Point(myBall.x, myBall.y);
					if (bdat1.hitTest(point1, 255, bdat2, point2, 255)) {
						t1.text = "At least one pixel has collided"
						
					}
					else {
						t1.text = "No collision"
					}
				}
			}
		
	}
	
}

