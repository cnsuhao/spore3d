package sp_ngin
{
	public class SPUVData
	{
		private var m_u:Number;
		private var m_v:Number;
		private var m_id:int;
		public function SPUVData(_id:int,_u:Number,_v:Number)
		{
			m_id = _id;
			m_u = _u;
			m_v = _v;
		}
		public function get u():Number
		{
			return m_u;
		}
		public function get v():Number
		{
			return m_v;
		}
		public function get id():int
		{
			return m_id;
		}
	}
}