﻿package actionscript {		import flash.display.MovieClip;	import flash.display.Sprite;	import flash.display.Loader;	import flash.display.Bitmap;	import flash.display.BitmapData;		import flash.events.*;	import flash.utils.*;	import flash.net.*;	import flash.geom.Rectangle;		//Easy Framework	import com.danzen.frameworks.Easy;		//Greensock	import com.greensock.*;			public class FlashTest2 extends MovieClip {				//Private variables used class wide start here				//mazeBall dimensions		private var mazeBall_w:Number;		private var mazeBall_h:Number;				private var mazeBall_hw:Number;		private var mazeBall_hh:Number;				private var mazeBall_x:Number;		private var mazeBall_y:Number;				//Ball collision assignments		private var uL:Array = new Array(); //Upper left		private var uM:Array = new Array(); //Upper Middle		private var uR:Array = new Array(); //Upper right		private var rM:Array = new Array(); //right middle		private var rB:Array = new Array(); //right botton		private var lM:Array = new Array(); //lower middle		private var lL:Array = new Array(); //lower left		private var mL:Array = new Array(); //middle left				private var masterCoord:Array = new Array(); // Master coordinate holder				//loading of background maze image		private var myLoader:Loader;		private var bitmapData:BitmapData;		private var bmVis:Bitmap;				//color investigation				private var colorPoint:uint;				private var solidColor:uint;				//Private variables end here				public function FlashTest2() {			// constructor code						//Determine mazeBall height and width			mazeBall_w = mazeBall.width;			mazeBall_h = mazeBall.height;						//determine half of mazeBall height and width			mazeBall_hw = mazeBall.width / 2;			mazeBall_hh = mazeBall.height / 2;						//initialize mazeBall center point calculation			mazeBall_x:Number;			mazeBall_y:Number;						myLoader = new Loader();			myLoader.load(new URLRequest("base_image.gif"));			myLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, startMaze);					}//end of constructor				private function startMaze(e:Event):void {						trace("Arrived at startMaze");			bitmapData = e.target.content.bitmapData;			bmVis = new Bitmap(bitmapData);			addChildAt(bmVis, numChildren - 1);						solidColor = bitmapData.getPixel(0, 0);			//trace(solidColor);						mazeBall.addEventListener(MouseEvent.MOUSE_OVER, guideBall);//event listener for moving mazeBall		}//end of startMaze				private function guideBall(e:MouseEvent){			addEventListener(Event.ENTER_FRAME, followCursor); //make mazeBall follow cursor						var damp:Number = .05;			var differenceX:Number;			var differenceY:Number;						function followCursor(e:Event) {				//Determining mazeBall x and y based on mouse position				differenceX = mouseX - mazeBall.x;				differenceY = mouseY - mazeBall.y;				mazeBall.x = mazeBall.x + differenceX * damp;				mazeBall.y = mazeBall.y + differenceY * damp;								//Finding mazeBall x and y				mazeBall_x = mazeBall.x;				mazeBall_y = mazeBall.y;								//storing coordinate arryas				uL = [(mazeBall_x - mazeBall_hw),(mazeBall_y - mazeBall_hh)];				uM = [(mazeBall_x),(mazeBall_y - mazeBall_hh)];				uR = [(mazeBall_x + mazeBall_hw),(mazeBall_y - mazeBall_hh)];				rM = [(mazeBall_x + mazeBall_hw),(mazeBall_y)];				rB = [(mazeBall_x + mazeBall_hw),(mazeBall_y + mazeBall_hh)];				lM = [(mazeBall_x),(mazeBall_y + mazeBall_hh)];				lL = [(mazeBall_x - mazeBall_hw),(mazeBall_y + mazeBall_hh)];				mL = [(mazeBall_x - mazeBall_hw),(mazeBall_y)];								//Storing coordinates in master array for checking				masterCoord = [uL, uM, uR, rM, rB, lM, lL, mL];								for (var i:uint = 0; i < masterCoord.length; i++) {					trace("Checking point: " + (i+1));					var currentMonitor:Array = masterCoord[i];					var currentMonitorX:Number = currentMonitor[0];					var currentMonitorY:Number = currentMonitor[1];										colorPoint = bitmapData.getPixel(currentMonitorX, currentMonitorY);					trace(currentMonitorX, currentMonitorY);										if (colorPoint == solidColor){						if (i == 0 || i == 2 || i == 4 || i == 6){							trace("Corner point hit!");							if (i == 0){								mazeBall.x = mazeBall_x + 5;								mazeBall.y = mazeBall_y + 5;							} else if (i == 2){								mazeBall.x = mazeBall_x - 5;								mazeBall.y = mazeBall_y + 5;							} else if (i == 4){								mazeBall.x = mazeBall_x - 5;								mazeBall.y = mazeBall_y - 5;							} else {								mazeBall.x = mazeBall_x + 5;								mazeBall.y = mazeBall_y - 5;							}						} else {							trace("Side Point hit!");							}					}					else {trace ("Not hitting");					}				}								/*				colorPoint = bitmapData.getPixel(mazeBall_x, mazeBall_y);				//trace(colorPoint);								if (colorPoint == solidColor){					trace("hit!");					mazeBall.x = mazeBall_x;					mazeBall.y = mazeBall_y - 5;				} else {trace ("Not hitting");}				*/							}//end of follow cursor		}//end of guideBall	}//end of class}//end of package