package nl.ansuz.fractals {
	import flash.display.Sprite;

	/**
	 * @author Wijnand
	 */
	public class AbstractFractal extends Sprite implements IFractal {
		
		protected var fractalWidth:int;
		protected var fractalHeight:int;
		protected var totalSteps:int;
		protected var currentStep:int;
		
		/**
		 * @inheritDoc
		 */
		public function draw(width:int, height:int, steps:int):void {
			fractalWidth = width;
			fractalHeight = height;
			totalSteps = steps;
			currentStep = 0;
		}
	}
}
