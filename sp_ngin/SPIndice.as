package sp_ngin
{
	public class SPIndice
	{
		private var m_uintV1:int;
		private var m_uintV2:int;
		private var m_uintV3:int;
		
		public function SPIndice(_v1:int,_v2:int,_v3:int)
		{
			m_uintV1 = _v1;
			m_uintV2 = _v2;
			m_uintV3 = _v3;
		}
		
		public function get v1():int
		{
			return m_uintV1;
		}
		public function get v2():int
		{
			return m_uintV2;
		}
		public function get v3():int
		{
			return m_uintV3;
		}
	}
}