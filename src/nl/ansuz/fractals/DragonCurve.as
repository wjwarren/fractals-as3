package nl.ansuz.fractals {
	import flash.geom.Point;

	/**
	 * Creates a Dragon Curve fractal.
	 * http://en.wikipedia.org/wiki/Dragon_curve
	 * 
	 * @author Wijnand
	 */
	public class DragonCurve extends AbstractFractal implements IFractal {
		
		private static const LEFT:String = "l";
		private static const RIGHT:String = "r";
		
		private var path:String;
		
		/**
		 * 
		 */
		public function DragonCurve() {
			init();
		}

		/**
		 * 
		 */
		private function init():void {
			path = "";
		}
		
		/**
		 * Draws the dragon curve fractal.
		 * @inheritDoc
		 */
		override public function draw(width:int, height:int, steps:int):void {
			trace("DragonCurve.draw(width, height, steps)");
			super.draw(width, height, steps);
			path = getPath(RIGHT, 1);
			plotPath();
			
			trace(" - path:", path);
		}

		/**
		 * Plots the path.
		 */
		private function plotPath():void {
			// start at 45 degrees
			var angle:Number = -Math.PI*0.25;
			var angleIncrement:Number = Math.PI*0.5;
			var segmentLength:Number = calculateSegmentLength(fractalWidth, fractalHeight);
			var previousX:Number = 0;
			var previousY:Number = 0;
			var currentX:Number = 0;
			var currentY:Number = 0;
			var steps:Array = path.split("");
			
			graphics.lineStyle(0.2, 0x00ff00);
			
			for(var i:int = 0; i < steps.length; i++) {
				angle += steps[i] == RIGHT ? -angleIncrement : angleIncrement;
				
				currentX = segmentLength * Math.cos(angle);
				currentX += previousX;
				currentY = segmentLength * Math.sin(angle);
				currentY += previousY;
				
				graphics.lineTo(currentX, currentY);
				
				previousX = currentX;
				previousY = currentY;
			}
			
			trace(" - segmentLength:", segmentLength);
		}
		
		/**
		 * Calculates the largest segment length that will fit in the specified bounding box.
		 * 
		 * @param width The maximum width.
		 * @param height The maximum height.
		 */
		public function calculateSegmentLength(width:Number, height:Number):Number {
			if(width / height < 1.5) {
				width = height / 2 * 3;
			}
			
			var length:Number = width / Math.pow( Math.sqrt(2), totalSteps+1 );
			return length;
		}
		
		/**
		 * Calculates the width / height of the dragon curve.
		 * 
		 * @param segmentLength The length of a single segment.
		 */
		public function getDimensions(segmentLength:int):Point {
			var dimensions:Point = new Point();
			
			var dragonWidth:Number = Math.pow( Math.sqrt(2), totalSteps+1 ) * segmentLength;
			var dragonHeight:Number = dragonWidth / 3 * 2;
			dimensions.x = dragonWidth;
			dimensions.y = dragonHeight;
			
			return dimensions;
		}

		/**
		 * Calculates the path to take.
		 * 
		 * @param path The path to extend.
		 * @param step The step we're in.
		 * 
		 * @return A String defining the path for the Dragon Curve, will look like "rrlrrllrrrll"
		 */
		private function getPath(path:String, step:int):String {
			var newPath:String = path + RIGHT;
			var origs:Array = path.split("");
			for(var i:int = origs.length-1; i >= 0; i--) {
				newPath += (origs[i] == RIGHT) ? LEFT : RIGHT;
			}
			
			if (step < totalSteps) path = getPath(newPath, ++step);
			
			return path;
		}
	}
}
