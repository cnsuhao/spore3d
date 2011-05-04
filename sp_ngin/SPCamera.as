package sp_ngin {
	

	public class SPCamera {
		
		//投影坐标系原点
		private var m_vViewPoint:SPVector;
		//注视点
		private var m_vLookAtPoint:SPVector;

		//投影坐标系x,y,z轴单位向量
		//x轴单位向量
		private var m_vU:SPVector;
		//y轴单位向量
		private var m_vV:SPVector;
		//z轴单位向量
		private var m_vN:SPVector;
		
		//投影平面到model的z轴距
		private var m_fPrpZ:Number;
		
		
		public function SPCamera(_fX:Number = 0.0,_fY:Number = 0.0,_fZ:Number = 0.0)
		{
			// constructor code
			m_vViewPoint = new SPVector(_fX,_fY,_fZ);
			m_vLookAtPoint = new SPVector(0.0,0.0,0.0);
			setUVNViewCoordinate();
			m_fPrpZ = 500;
		}
		
		public function init(_conf:String):void
		{
			//通过配置文件设置当前Camera
			var loader:SPResLoader = new SPResLoader(_conf);
			
		}
		
		public function get prpz():Number
		{
			return m_fPrpZ;
		}
		
		public function set prpz(_prpz:Number)
		{
			m_fPrpZ = _prpz;
		}
		
		public function get u():SPVector
		{
			var tempv:SPVector = new SPVector();
			tempv.clone(m_vU);
			return tempv;
		}
		
		public function get v():SPVector
		{
			var tempv:SPVector = new SPVector();
			tempv.clone(m_vV);
			return tempv;
		}
		
		public function get n():SPVector
		{
			var tempv:SPVector = new SPVector();
			tempv.clone(m_vN);
			return tempv;
		}
		
		public function setViewPointV(_v:SPVector):void
		{
			m_vViewPoint.clone(_v);
		}
		
		public function setViewPointF(_fX:Number = 0.0,_fY:Number = 0.0,_fZ:Number = 0.0):void
		{
			m_vViewPoint.x = _fX;
			m_vViewPoint.y = _fY;
			m_vViewPoint.z = _fZ;
			setUVNViewCoordinate();
		}
		
		public function setLookAtPointV(_v:SPVector):void
		{
			m_vLookAtPoint.clone(_v);
			setUVNViewCoordinate();
		}
		
		public function setLookAtPointF(_fX:Number,_fY:Number,_fZ:Number):void
		{
			m_vLookAtPoint.x = _fX;
			m_vLookAtPoint.y = _fY;
			m_vLookAtPoint.z = _fZ;
			setUVNViewCoordinate();
		}
		
		
		
		//世界坐标系到观察坐标系
		public function setModelWorldToView(_model:SPModelUnit):void
		{
				var _vNum:int = _model.getVerticeNum();
				for(var _index:int = 0;_index < _vNum;_index++)
				{
					setWorldToView(_model.getWorldVerticesAt(_index),_model.getViewVerticesAt(_index));
				}
		}
		public function setWorldToView(_vw:SPVector,_vv:SPVector):void
		{
			
			_vv.x = m_vU.x*_vw.x + m_vU.y*_vw.y + m_vU.z*_vw.z - m_vViewPoint.x*m_vU.x - m_vViewPoint.y*m_vU.y - m_vViewPoint.z*m_vU.z;
			_vv.y = m_vV.x*_vw.x + m_vV.y*_vw.y + m_vV.z*_vw.z - m_vViewPoint.x*m_vV.x - m_vViewPoint.y*m_vV.y - m_vViewPoint.z*m_vV.z;
			_vv.z = m_vN.x*_vw.x + m_vN.y*_vw.y + m_vN.z*_vw.z - m_vViewPoint.x*m_vN.x - m_vViewPoint.y*m_vN.y - m_vViewPoint.z*m_vN.z;
	 
		}
		
		
		//投影变换
		public function setModelProjection(_model:SPModelUnit):void
		{
			var _vNum:int = _model.getVerticeNum();
			for(var _index:int = 0;_index < _vNum;_index++)
			{
				//setWorldToView(_model.getWorldVerticesAt(_index),_model.getViewVerticesAt(_index));
				projection(_model.getViewVerticesAt(_index),_model.getVPVerticesAt(_index));
			}
		}
		public function projection(_vv:SPVector,_vp:SPVector):Number
		{
			var tempz:Number;
			tempz = m_fPrpZ/(m_fPrpZ + _vv.z );
			_vp.x = _vv.x * tempz;
			_vp.y = _vv.y * tempz;
			return tempz;
		}
		
		//设置camera的uvn观察坐标参考系
		private function setUVNViewCoordinate():void
		{
			var tempUp:SPVector = new SPVector(0,1,0);
			tempUp.normaliz();
			m_vN = new SPVector(m_vViewPoint.x-m_vLookAtPoint.x,m_vViewPoint.y-m_vLookAtPoint.y,m_vViewPoint.z-m_vLookAtPoint.z);
			m_vN.normaliz();
			m_vU = tempUp.crossProductV(m_vN);
			//m_vU = m_vN.crossProductV(tempUp);
			m_vU.normaliz();
			m_vV = m_vN.crossProductV(m_vU);
			//m_vV =m_vU.crossProductV(m_vN);
			m_vV.normaliz();
		}
		
	}
	
}
