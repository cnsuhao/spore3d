package sp_ngin {
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.events.*;
	
	public class SPModelRes extends EventDispatcher{
		
		//模型定点坐标
		public var mVertices:Array=[];
		//模型最后变换的世界坐标
		public var wVertices:Array=[];
		//观察标系坐标
		public var vVertices:Array=[];
		//投影坐标
		public var vpVertices:Array=[];
		//面顶点向量
		public var indices:Array=[];
		//uvt
		public var uvtArray:Array=[];
		//题图对象数组
		public var imgs:Array=[];
		private var m_imgLoaders:Array=[];
		private var m_imgLoadNum:int;
		//xml模型对象
		private var m_objXMLModel:XML;
		//在世界坐标中的位置
		private var m_worldPos:SPVector;
		
		public function SPModelRes(_modelFile:String,_wx:Number = 0.0,_wy:Number = 0.0,_wz:Number = 0.0)
		{
			// constructor code
			m_objXMLModel = new XML(_modelFile);
			//m_img = new Object();
			m_imgLoadNum = 0;
			m_worldPos = new SPVector();
			
			initModelVertices();
			initIndices();
			initImgs();
			initUVT();
			//initWorldPos(_wx,_wy,_wz);
			setWorldPos(_wx,_wy,_wz);
			setWorldVertices();
		}
		
		public function setWorldPos(_wx:Number,_wy:Number,_wz:Number):void
		{
			m_worldPos.x = _wx;
			m_worldPos.y = _wy;
			m_worldPos.z = _wz;
		}
		//private function initWorldPos(_wx:Number,_wy:Number,_wz:Number):void
		//{
			//设置模型的世界坐标
			//var _tempWV:SPVector;
			//var _tempMV:SPVector;
			
			//m_worldPos.x = _wx;
			//m_worldPos.y = _wy;
			//m_worldPos.z = _wz;
			
			//for(var _index:int = 0;_index < m_objXMLModel.vertices.@num;_index++)
			//{
			//	_tempWV = wVertices[_index];
			//	_tempMV = mVertices[_index];
			//	_tempWV.x = _tempMV.x + _wx;
			//	_tempWV.y = _tempMV.y + _wy;
			//	_tempWV.z = _tempMV.z + _wz;
			//}
		//}
		
		public function setWorldVertices():void
		{
			var _tempWV:SPVector;
			var _tempMV:SPVector;
			for(var _index:int = 0;_index < m_objXMLModel.vertices.@num;_index++)
			{
				_tempWV = wVertices[_index];
				_tempMV = mVertices[_index];
				_tempWV.x = _tempMV.x + m_worldPos.x;
				_tempWV.y = _tempMV.y + m_worldPos.y;
				_tempWV.z = _tempMV.z + m_worldPos.z;
			}
		}
		
		public function get worldPosX():Number
		{
			return m_worldPos.x;
		}
		public function get worldPosY():Number
		{
			return m_worldPos.y;
		}
		public function get worldPosZ():Number
		{
			return m_worldPos.z;
		}
		
		private function initModelVertices():void
		{
			for(var _index:int = 0;_index < m_objXMLModel.vertices.@num;_index++)
			{
				mVertices.push(new SPVector(m_objXMLModel.vertices.vt[_index].x,m_objXMLModel.vertices.vt[_index].y,m_objXMLModel.vertices.vt[_index].z));
				wVertices.push(new SPVector());
				vVertices.push(new SPVector());
				vpVertices.push(new SPVector());
			}
		}
		private function initIndices():void
		{
			for(var _index:int = 0;_index < m_objXMLModel.indices.@num;_index++)
			{
				//var _tempind:SPIndice = new SPIndice(m_objXMLModel.indices.ind[_indexi].v1,m_objXMLModel.indices.ind[_indexi].v2,m_objXMLModel.indices.ind[_indexi].v3,m_objXMLModel.indices.ind[_indexi].uimg);
				//for(var _indexj:int = 0;_indexj < 3;_indexj++)
				//{
				//	_tempind.addUVT(m_objXMLModel.indices.ind[_indexi].uvtData[_indexj].u,m_objXMLModel.indices.ind[_indexi].uvtData[_indexj].v);
				//}
				indices.push(new SPIndice(m_objXMLModel.indices.ind[_index].v1,m_objXMLModel.indices.ind[_index].v2,m_objXMLModel.indices.ind[_index].v3));
			}
		}
		private function initUVT():void
		{
			/*for(var _index:int = 0;_index < m_objXMLModel.uvts.@num;_index++)
			{
				
				var _tempUVT:SPUVT = new SPUVT(m_objXMLModel.uvts.uvt[_index].imgid);
				for(var _i:int = 0;_i < m_objXMLModel.uvts.uvt[_index].@vtnum;_i++)
				{
					_tempUVT.addUV(m_objXMLModel.uvts.uvt[_index].vt[_i].u,m_objXMLModel.uvts.uvt[_index].vt[_i].v);
				}
				uvtArray.push(_tempUVT);
			}*/
			for(var _index:int = 0;_index < m_objXMLModel.uvts.@num;_index++)
			{
				var _tempUVT:SPUVT = new SPUVT(m_objXMLModel.uvts.uvt[_index].@imgid);
				for(var _indexi:int = 0;_indexi < m_objXMLModel.uvts.uvt[_index].@vtnum;_indexi++)
				{
					_tempUVT.addUV(m_objXMLModel.uvts.uvt[_index].vt[_indexi].@id,m_objXMLModel.uvts.uvt[_index].vt[_indexi].u,m_objXMLModel.uvts.uvt[_index].vt[_indexi].v);
				}
				for(var _indexj:int = 0;_indexj < m_objXMLModel.uvts.uvt[_index].@indnum;_indexj++)
				{
					_tempUVT.addInd(m_objXMLModel.uvts.uvt[_index].ind[_indexj].@id);
				}
				uvtArray.push(_tempUVT);
			}
		}
		private function initImgs():void
		{
			//贴图加载
			var _imgLoader:SPListLoader = new SPListLoader();
			for(var _index:int = 0;_index < m_objXMLModel.imgs.@num;_index++)
			{
				_imgLoader.add(m_objXMLModel.imgs.img[_index].@id,m_objXMLModel.imgs.img[_index].url,SPResItem.DATATYPE_BIN);
			}
			_imgLoader.addEventListener(SPEvent.LOAD_DONE,downloadImgComplete);
			_imgLoader.startLoad();
		}
		private function downloadImgComplete(_event:Event):void
		{
			var _tempLoader:SPListLoader = _event.target as SPListLoader;
			for(var _index:int = 0;_index < m_objXMLModel.imgs.@num;_index++)
			{
				var _tempImgLoader:Loader = new Loader();
				m_imgLoaders.push(_tempImgLoader);
				_tempImgLoader.contentLoaderInfo.addEventListener(Event.COMPLETE,loadImgComplete);
				_tempImgLoader.loadBytes(_tempLoader.getItem(m_objXMLModel.imgs.img[_index].@id).binData);
			}
		}
		private function loadImgComplete(_event:Event):void
		{
			m_imgLoadNum++;
			if(m_imgLoadNum == m_objXMLModel.imgs.@num)
			{
				//如果所有贴图都加载完成，则存储
				for each(var l in m_imgLoaders)
				{
					//var image:Bitmap = new Bitmap((l as Loader).content as Bitmap);
					imgs.push((l as Loader).content as Bitmap);
				}
				dispatchEvent(new SPEvent(SPEvent.MODEL_INIT_DONE));
			}
		}
		public function getBitmap(_index:int):Bitmap
		{
			return imgs[_index];
		}

	}
	
}
