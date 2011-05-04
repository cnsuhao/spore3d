package sp_ngin
{
	import flash.events.*;
	import flash.net.*;
	import flash.utils.ByteArray;

	public class SPListLoader extends EventDispatcher
	{
		private var m_aResList:Array;
		private var m_oKeyList:Object;
		
		private var m_uintItemNum:int;
		private var m_uintCurrLoadItem:int;
		private var m_bLoading:Boolean;
		
		private var m_objLoader:URLLoader;
		
		public function SPListLoader()
		{
			m_aResList = new Array();
			m_oKeyList = new Object();
			m_uintItemNum = 0;
			m_uintCurrLoadItem = 0;
			m_bLoading = false;
		}
		
		public function add(_key:String,_url:String,_type:int):void
		{
			m_oKeyList[_key] = m_uintItemNum;
			m_uintItemNum++;
			m_aResList.push(new SPResItem(_url,_type));	
		}
		
		public function getItem(_key:String):SPResItem
		{
			var index:int = m_oKeyList[_key];
			return m_aResList[index];
		}
		
		public function setLoadCompHandle(_handle:Function):void
		{
			this.addEventListener(SPEvent.LOAD_DONE,_handle);	
		}
		
		public function isAllLoadComplete():Boolean
		{
			return m_uintCurrLoadItem == m_uintItemNum ? true : false;	
		}
		
		public function startLoad():void
		{
			if(!m_bLoading && !isAllLoadComplete())
			{
				var _tempItem:SPResItem = m_aResList[m_uintCurrLoadItem] as SPResItem;
				m_bLoading = true;
				m_objLoader = new URLLoader();

				if(SPResItem.DATATYPE_TXT == _tempItem.dataType)
				{
					m_objLoader.dataFormat = URLLoaderDataFormat.TEXT;
				}
				else if(SPResItem.DATATYPE_BIN == _tempItem.dataType)
				{
					m_objLoader.dataFormat = URLLoaderDataFormat.BINARY;
				}
				
				m_objLoader.addEventListener(Event.COMPLETE,completeHandler);
				try
				{
					m_objLoader.load(new URLRequest(_tempItem.url));
				}
				catch(error:Error)
				{
					trace("load error1:"+error);
				}
			}
		}
		
		private function completeHandler(event:Event):void
		{
			var _tempLoader:URLLoader = event.target as URLLoader;
			var _tempItem:SPResItem = m_aResList[m_uintCurrLoadItem] as SPResItem;
			//保存当前数据
			if(SPResItem.DATATYPE_BIN == _tempItem.dataType)
			{
				_tempItem.binData = _tempLoader.data as ByteArray;
			}
			else if(SPResItem.DATATYPE_TXT == _tempItem.dataType)
			{
				_tempItem.txtData = _tempLoader.data;
			}
			_tempItem.loadComplete = true;
			
			m_uintCurrLoadItem++;

			//如果加载未完成，继续加载
			if(!isAllLoadComplete())
			{
				
				_tempItem = m_aResList[m_uintCurrLoadItem] as SPResItem;
				try
				{
					_tempLoader.load(new URLRequest(_tempItem.url));
				}
				catch(error:Error)
				{
					trace("load error2:"+error);
				}
			}
			else
			{
				dispatchEvent(new SPEvent(SPEvent.LOAD_DONE));
			}
		}
	}
}