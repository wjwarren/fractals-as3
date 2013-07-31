package nl.ansuz.fractals {
	import flash.display.StageScaleMode;
	import flash.display.StageAlign;
	import flash.display.Sprite;

	/**
	 * @author Wijnand
	 */
	public class Main extends Sprite {
		
		/**
		 * 
		 */
		public function Main() {
			init();
		}

		/**
		 * 
		 */
		private function init():void {
			
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			
//			var snowFlake:KochSnowflake = new KochSnowflake(400, 8);
//			snowFlake.x = 10;
//			snowFlake.y = 10;
//			addChild(snowFlake);
			
//			var carpet:SierpinskiCarpet = new SierpinskiCarpet(400, 5);
//			carpet.x = 10;
//			carpet.y = 10;
//			addChild(carpet);
			
//			var dragon:DragonCurve = new DragonCurve();
//			dragon.draw(360, 240, 12);
//			dragon.x = 250;
//			dragon.y = 125;
//			addChild(dragon);

			var triangle:SierpinskiTriangle = new SierpinskiTriangle();
			triangle.draw(400, 400, -1);
			triangle.x = triangle.y = 10;
			addChild(triangle);
			
		}
	}
}
