package nl.ansuz.fractals {

	/**
	 * Creates a Sierpinski Carpet.
	 * 
	 * @author Wijnand
	 */
	public class SierpinskiCarpet extends AbstractFractal implements IFractal {
		
		/**
		 * 
		 */
		public function SierpinskiCarpet(w:int, steps:int) {
			draw(w, w, steps);
		}
		
		/**
		 * @inheritDoc
		 */
		override public function draw(width:int, height:int, steps:int):void {
			// Make sure it is square
			if(width > height) width = height;
			else if(height > width) height = width;
			
			super.draw(width, width, steps);
			
			drawHoles(1);
		}

		/**
		 * Draws the holes in the carpet.
		 */
		private function drawHoles(step:int):void {
			var rows:int = Math.pow(3, step);
			var partWidth:Number = fractalWidth / rows;
			
			for(var i:int = 0; i < rows; i++) {
				for(var k:int = 0; k < rows; k++){
					if(i%3 == 1 && k%3 == 1) {
						// draw
						graphics.beginFill(0x00ff00);
						graphics.drawRect(partWidth * i, partWidth * k, partWidth, partWidth);
						graphics.endFill();
					}
				}
			}
			
			if(step < totalSteps) drawHoles(++step);
		}
	}
}
