package sp_ngin
{
	import flash.utils.ByteArray;

	public class SPResItem
	{
		public static const DATATYPE_TXT:int = 0;
		public static const DATATYPE_BIN:int = 1;
		
		private var m_strUrl:String;
		private var m_uintDataType:int;
		
		private var m_strTxtData:String;
		private var m_baBinData:ByteArray;
		
		private var m_bLoadComplete:Boolean;
		
		public function SPResItem(_url:String,_type:int = 0)
		{
			m_strUrl = _url;
			m_uintDataType = _type;
			m_bLoadComplete = false;
			if(DATATYPE_BIN == _type)
				m_baBinData = new ByteArray();
		}
		
		public function get txtData():String
		{
			return m_strTxtData;
		}
		public function set txtData(_s:String):void
		{
			m_strTxtData = _s;
		}
		
		public function get binData():ByteArray
		{
			return m_baBinData;	
		}
		public function set binData(_b:ByteArray):void
		{
			m_baBinData.writeBytes(_b);
		}
		
		public function get dataType():int
		{
			return m_uintDataType;
		}
		
		public function get url():String
		{
			return m_strUrl;
		}
		
		public function set loadComplete(_lc:Boolean):void
		{
			m_bLoadComplete = _lc;
		}
		
		public function get loadComplete():Boolean
		{
			return m_bLoadComplete;
		}
	}
}