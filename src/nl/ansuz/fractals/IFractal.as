package nl.ansuz.fractals {
	
	/**
	 * @author Wijnand
	 */
	public interface IFractal {
		
		/**
		 * Draws the fractal.
		 * 
		 * @param width The width of the fractal to draw.
		 * @param height The height of the fractal to draw.
		 * @param steps The number of steps to draw this fractal.
		 */
		function draw(width:int, height:int, steps:int):void;
		
	}
}
