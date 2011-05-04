package sp_ngin
{
	public class SPUVT
	{
		private var m_uvtData:Array=[];
		private var m_imgID:int;
		private var m_indData:Array=[];
		
		public function SPUVT(_imgID:int)
		{
			m_imgID = _imgID;
			//m_uvtData = new Vector.<Number>;
		}
		public function get imgID():int
		{
			return m_imgID;
		}
		public function set imgID(_num:int):void
		{
			m_imgID = _num;
		}
		
		public function getUVData(_i:int):SPUVData
		{
			return m_uvtData[_i];
		}
		public function getIndData(_i:int):int
		{
			return m_indData[_i];
		}
		public function getUVNum():int
		{
			return m_uvtData.length;	
		}
		public function getIndNum():int
		{
			return m_indData.length;
		}
		public function addUV(_id:int,_u:Number,_v:Number):void
		{
			m_uvtData.push(new SPUVData(_id,_u,_v));
		}
		public function addInd(_i:int):void
		{
			m_indData.push(_i);
		}
	}
}