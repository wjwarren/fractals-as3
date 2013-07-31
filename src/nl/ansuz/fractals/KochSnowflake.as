package nl.ansuz.fractals {
	import flash.display.Sprite;
	import flash.geom.Point;

	/**
	 * @author Wijnand
	 */
	public class KochSnowflake extends AbstractFractal implements IFractal {
		
		private var vertices:Vector.<Point>;
		
		private var partOne:Sprite;
		private var partTwo:Sprite;
		private var partThree:Sprite;
		
		/**
		 * CONSTRUCTOR
		 */
		public function KochSnowflake(w:int, steps:int) {
			init();
			draw(w, w, steps);
		}

		/**
		 * 
		 */
		private function init():void {
			vertices = new Vector.<Point>();
		}
		
		/**
		 * @inheritDoc
		 */
		override public function draw(width:int, height:int, steps:int):void {
			if(width > height) width = height;
			else if(height > width) height = width;
			super.draw(width, height, steps);
			
			var maxDrawingWidth:Number = fractalHeight * 0.75;
			vertices.push(new Point(0, 0));
			vertices.push(new Point(maxDrawingWidth, 0));
			calculateSegment(2);
			plotSnowflake();
		}

		private function plotSnowflake():void {
			trace("KochSnowflake.plotSnowflake()");
			trace(vertices[int(vertices.length*0.5)]);
			
			var topOffset:int = -vertices[int(vertices.length*0.5)].y;
			
			partOne = new Sprite();
			partTwo = new Sprite();
			partThree = new Sprite();
			
			partOne.graphics.lineStyle(0.1, 0x00ff00);
			partTwo.graphics.lineStyle(0.1, 0x00ff00);
			partThree.graphics.lineStyle(0.1, 0x00ff00);
			
			for(var i:int = 0; i < vertices.length; i++) {
				partOne.graphics.lineTo(vertices[i].x, vertices[i].y);
				partTwo.graphics.lineTo(vertices[i].x, vertices[i].y);
				partThree.graphics.lineTo(vertices[i].x, vertices[i].y);
			}
			
			
			partOne.y = topOffset;
			
			partTwo.scaleY = -1;
			partTwo.rotation = 60;
			partTwo.x = 0;
			partTwo.y = topOffset;
			
			partThree.rotation = 120;
			partThree.x = fractalWidth*0.75;
			partThree.y = topOffset;
			
			addChild(partOne);
			addChild(partTwo);
			addChild(partThree);
		}

		/**
		 * 
		 */
		private function calculateSegment(step:int):void {
			trace("KochSnowflake.calculateSegment(step)", step);
			
			var newVertices:Vector.<Point> = new Vector.<Point>();
			var moreVertices:Vector.<Point> = null;
			
			for(var i:int = 1; i < vertices.length; i++) {
				newVertices.push( vertices[i-1] );
				moreVertices = interpolate(vertices[i-1], vertices[i]);
				
				for(var k:int = 0; k < moreVertices.length; k++) {
					newVertices.push(moreVertices[k]);
				}
			}
			
			newVertices.push( vertices[vertices.length-1] );
			vertices = newVertices;
			
			if(step < totalSteps) calculateSegment(++step);
		}

		/**
		 * Adds an extra triangle between two points.
		 * "---" will become "-^-"
		 * TODO: Optimize!!!
		 * 
		 * @param a
		 * @param b
		 */
		private function interpolate(a:Point, b:Point):Vector.<Point> {
			var newVertices:Vector.<Point> = new Vector.<Point>();
			var point:Point = new Point;
			
			var deltaX:Number = (b.x - a.x);
			var deltaY:Number = (b.y - a.y);
			var segmentLength:Number = Math.sqrt( deltaX*deltaX + deltaY*deltaY ) / 3;
			
			// 1
			point = new Point(a.x + deltaX/3, a.y + deltaY/3);
			newVertices.push(point);
			
			// 2
			var triangleHeight:Number = segmentLength*segmentLength - (segmentLength*0.5)*(segmentLength*0.5);
			triangleHeight = Math.sqrt(triangleHeight);
			point = new Point( a.x + deltaX*0.5, a.y + deltaY*0.5 );
			var angle:Number = Math.atan(deltaY/deltaX);
			var angleDeg:Number = angle * 180 / Math.PI;
			var flipped:Boolean = false;
			var flippedForZero:Boolean = false;
			
			// Deal with some oddities to make sure we always have a convex shape.
			if(angleDeg < -59.99999 && angleDeg > -60.00001) {
				if(deltaX < 0 && deltaY > 0) {
					angle += Math.PI;
					flipped = true;
				}
			}
			else if(angleDeg > -0.0001 && angleDeg < 0.00001) {
				if(deltaX < 0 ) {
					flipped = true;
					flippedForZero = true;
				}
			}
			else if(angleDeg > 59.99999 && angleDeg < 60.00001) {
				if(deltaX < 0 && deltaY < 0) {
					angle += Math.PI;
					flipped = true;
				}
			}
			
			var xOffset:Number = triangleHeight * Math.tan(angle) * 0.5;
			var yOffset:Number = -triangleHeight * Math.cos(angle);

			if(flipped){
				point.x += -xOffset;
				point.y += flippedForZero ? -yOffset : yOffset;
			} else {
				point.x += xOffset;
				point.y += yOffset;
			}
			newVertices.push(point);

			// 3
			point = new Point(a.x + deltaX/3*2, a.y + deltaY/3*2);
			newVertices.push(point);
			
			return newVertices;
		}
	}
}
