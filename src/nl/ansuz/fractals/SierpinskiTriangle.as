package nl.ansuz.fractals {
	import flash.utils.getTimer;
	import flash.display.BitmapData;
	import flash.display.Bitmap;
	import flash.geom.Point;

	/**
	 * @author Wijnand
	 */
	public class SierpinskiTriangle extends AbstractFractal implements IFractal {
		
		private var currentPosition:Point;
		private var bitmap:Bitmap;
		private var bitmapData:BitmapData;
		
		/**
		 * CONSTRUCTOR
		 */
		public function SierpinskiTriangle() {
			init();
		}
		
		/**
		 * Initializes this class.
		 */
		private function init():void {
			currentPosition = new Point();
		}
		
		/**
		 * Draws the Sierpenski Triangle using the chaos game method.
		 * @inheritDoc
		 */
		override public function draw(width:int, height:int, steps:int):void {
			
			getStart(width, height);
			plot(width, height);
			addChild(bitmap);
			
		}

		/**
		 * Plots the triangle using the chaos game method.
		 */
		private function plot(width:int, height:int):void {
			trace("SierpinskiTriangle.plot(width, height)", getTimer());
			bitmapData = new BitmapData(width, height, false, 0x0);
			bitmap = new Bitmap(bitmapData);
			
			var totalRuns:int = width * height * 0.5;
			var cornerPoint:Point;
			var cornerA:Point = new Point(0, height);
			var cornerB:Point = new Point(width, height);
			var cornerC:Point = new Point(width*0.5, 0);
			var halfwayPoint:Point = new Point();
			var cornerId:int;
			
			
			for(var i:int = totalRuns; i >= 0; i--) {
				// pick random corner point
				cornerId = Math.random()*3;
				if(cornerId == 0) cornerPoint = cornerA;
				else if(cornerId == 1) cornerPoint = cornerB;
				else cornerPoint = cornerC;
				
				// Move to half way point
				halfwayPoint.x = currentPosition.x + (cornerPoint.x - currentPosition.x) * 0.5;
				halfwayPoint.y = currentPosition.y + (cornerPoint.y - currentPosition.y) * 0.5;
				
				// draw pixel
				bitmapData.setPixel(halfwayPoint.x, halfwayPoint.y, 0x00ff00);
				
				// Update current position
				currentPosition.x = halfwayPoint.x;
				currentPosition.y = halfwayPoint.y;
			}
			trace(" - end:", getTimer());
		}

		/**
		 * Makes a random point within the triangle the start position.
		 */
		private function getStart(width:int, height:int):void {
			trace("SierpinskiTriangle.getStart(width, height)");
			var tanHalfAngle:Number = 0.5 * width / height;
			var startFound:Boolean = false;
			while(!startFound) {
				currentPosition.x = Math.random() * width;
				currentPosition.y = Math.random() * height;
				if(currentPosition.y <= currentPosition.x / tanHalfAngle) {
					startFound = true;
				}
			}
			trace(" - start:", currentPosition);
		}
	}
}
