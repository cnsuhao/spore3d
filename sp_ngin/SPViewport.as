package sp_ngin {
	import flash.display.Sprite;
	public class SPViewport extends Sprite {
		
		private var m_fWidth:Number;
		private var m_fHeight:Number;
		
		public function SPViewport(_width:Number,_height:Number)
		{
			// constructor code
			m_fWidth = _width;
			m_fHeight = _height;
			this.x = _width / 2;
			this.y = _height / 2;
		}
		
		public function draw(_obj:Object):void
		{
			//空间排序
			//绘制
			for each(var _o in _obj)
			{
				this.addChild(_o as SPModelUnit);
			}
		}
	}
}
