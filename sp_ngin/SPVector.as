package sp_ngin {
	
	public class SPVector {
		
		private var m_fX:Number;
		private var m_fY:Number;
		private var m_fZ:Number;
		private var m_fW:Number;
		
		//private var m_fViewX:Number;
		//private var m_fViewY:Number;
		//private var m_fViewZ:Number;
		
		//private var m_fProX:Number;
		//private var m_fProY:Number;
		
		public function SPVector(_fX:Number = 0.0, _fY:Number = 0.0, _fZ:Number = 0.0) {
			// constructor code
			m_fX = _fX;
			m_fY = _fY;
			m_fZ = _fZ;
			m_fW = 1.0;
			
			//m_fViewX = 0.0;
			//m_fViewY = 0.0;
			//m_fViewZ = 0.0;
			
			//m_fProX = 0.0;
			//m_fProY = 0.0;
		}
			
		public function normaliz():void {
			var fModule:Number;
			fModule = Math.sqrt(m_fX*m_fX + m_fY*m_fY + m_fZ*m_fZ);
			m_fX /= fModule;
			m_fY /= fModule;
			m_fZ /= fModule;
		}
			
		public function clone(_v:SPVector):void {
			m_fX = _v.x;
			m_fY = _v.y;
			m_fZ = _v.z;
			//m_fViewX = _v.xView;
			//m_fViewY = _v.yView;
			//m_fViewZ = _v.zView;
			//m_fProX = _v.xPro;
			//m_fProY = _v.yPro;
		}
			
		//点乘
		public function dotProduct(_v:SPVector):Number {
			return m_fX*_v.x + m_fY*_v.y + m_fZ*_v.z;
		}
			
		//叉乘
		//public static function crossProduct2V():SPVector {
		//}
		public function crossProductV(_v:SPVector):SPVector {
			var _tempv:SPVector = new SPVector(m_fY*_v.z - m_fZ*_v.y,m_fZ*_v.x - m_fX*_v.z,m_fX*_v.y - m_fY*_v.x);
			return _tempv;
		}
		
		//public function get xView():Number {
		//	return m_fViewX;
		//}
		//public function set xView(_xv:Number):void {
		//	m_fViewX = _xv;
		//}
		//public function get yView():Number {
		//	return m_fViewY;
		//}
		//public function set yView(_yv:Number):void {
		//	m_fViewY = _yv;
		//}
		//public function get zView():Number {
		//	return m_fViewZ;
		//}
		//public function set zView(_zv:Number):void {
		//	m_fViewZ = _zv;
		//}
		
		//public function get xPro():Number {
		//	return m_fProX;
		//}
		//public function set xPro(_xp:Number):void {
		//	m_fProX = _xp;
		//}
		//public function get yPro():Number {
		//	return m_fProY;
		//}
		//public function set yPro(_yp:Number):void {
		//	m_fProY = _yp;
		//}
		
		public function toString():String
		{
			return new String("("+m_fX+","+m_fY+","+m_fZ+")");
		}
		
		public function get x():Number
		{
			return m_fX;
		}
		public function set x(_fX:Number):void
		{
			m_fX = _fX;
		}
		public function get y():Number
		{
			return m_fY;
		}
		public function set y(_fY:Number):void
		{
			m_fY = _fY;
		}
		public function get z():Number
		{
			return m_fZ;
		}
		public function set z(_fZ:Number):void
		{
			m_fZ = _fZ;
		}
	}	
}
