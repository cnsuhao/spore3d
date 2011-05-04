package sp_ngin
{
	import flash.events.Event;
	import flash.events.ProgressEvent;
	import flash.net.*;
	import flash.utils.ByteArray;
	
	public class SPResLoader
	{
		public static var DATATYPE_TXT:int = 0;
		public static var DATATYPE_BIN:int = 1;
		
		private var m_strTxtData:String;
		private var m_baBinData:ByteArray;
		
		private var m_strUrl:String;
		private var m_uintDataType:int;
		private var m_bProgHandle:Boolean;
		
		private var m_bIsLoadComplate:Boolean;
		private var m_objLoader:URLLoader;
		
		public function SPResLoader(_url:String,_type:int = 0,_prog:Boolean = false)
		{
			m_strUrl = _url;
			m_uintDataType = _type;
			m_bProgHandle = _prog;
			m_objLoader = new URLLoader();
			loadData();
		}
		
		public function get txtData():String
		{
			return m_strTxtData;
		}
		public function get binData():ByteArray
		{
			return m_baBinData;
		}
		public function get isLoadComplate():Boolean
		{
			return m_bIsLoadComplate;
		}
		
		private function loadData():void
		{
			
			m_bIsLoadComplate = false;
			if(DATATYPE_TXT == m_uintDataType)
				m_objLoader.dataFormat = URLLoaderDataFormat.BINARY;
			else if(DATATYPE_BIN == m_uintDataType)
				m_objLoader.dataFormat = URLLoaderDataFormat.TEXT;
			
			if(m_bProgHandle)
			{
				//监听progress事件，检查下载进度
				m_objLoader.addEventListener(ProgressEvent.PROGRESS,handleProgress);
			}
			//注册事件处理器，当数据完成下载时可用ProgressEvent.PROGRESS
			m_objLoader.addEventListener(Event.COMPLETE,handleComplete);
			
			m_objLoader.load(new URLRequest(m_strUrl));
		}
		
		public function handleComplete(_event:Event):void
		{
			var loader:URLLoader = URLLoader(_event.target);
			if(DATATYPE_TXT == m_uintDataType)
				m_strTxtData = loader.data;
			else if(DATATYPE_BIN == m_uintDataType)
				m_baBinData = loader.data;
			m_bIsLoadComplate = true;
			trace(m_strTxtData);
		}
		
		public function handleProgress(_event:Event):void
		{
			
		}
		
	}
}