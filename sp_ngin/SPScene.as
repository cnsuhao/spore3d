package sp_ngin {
	
	import flash.display.Sprite;
	import flash.events.Event;
	
	public class SPScene extends Sprite  {
		
		private var m_mainCamera:SPCamera;
		private var m_mainViewport:SPViewport;
		private var m_mainRender:SPRender;
		
		private var m_modelListUrl:String;
		
		//成功加载模型数量
		private var m_loadModelNum:int;
		//资源加载器
		private var m_loader:SPListLoader;
		//模型加载器
		private var m_modelLoader:SPListLoader;
		//模型列表xml解析器
		private var m_modelListXml:XML;
		
		//模型文件url
		private var m_modelNameList:Array;
		
		//模型容器
		private var m_modelVector:Object;
		
		public function SPScene(_c:SPCamera,_v:SPViewport,_r:SPRender,_ml:String)
		{
			// constructor code
			m_mainCamera = _c;
			m_mainViewport = _v;
			m_mainRender = _r;
			m_modelListUrl = _ml;
			m_loadModelNum = 0;
			m_loader = new SPListLoader();
			m_modelLoader = new SPListLoader();
			m_modelNameList = new Array();
			m_modelVector = new Object();
			this.addChild(m_mainViewport);
		}
		
		//初始化
		public function init():void
		{
			//加载modellist文件
			m_loader.add("modelList",m_modelListUrl,SPResItem.DATATYPE_TXT);
			m_loader.setLoadCompHandle(modelListHandle);
			m_loader.startLoad();
			
		}
		
		//主过程
		private function _run(_event:Event):void
		{
			//游戏逻辑处理
			runProc();
			
			//变换，投影
			for each(var _o in m_modelVector)
			{
				var tempobj:SPModelUnit = _o as SPModelUnit;
				tempobj.setWorldVertices();
				m_mainCamera.setModelWorldToView(tempobj);
				m_mainCamera.setModelProjection(tempobj);
			}
			//渲染
			m_mainRender.renderAll(m_modelVector);
			//绘制
			m_mainViewport.draw(m_modelVector);
		}
		
		//modelList加载结束处理句柄
		private function modelListHandle(_event:Event):void
		{
			m_modelListXml = new XML(m_loader.getItem("modelList").txtData);
			//获取模型xml文件
			for(var _index:int = 0;_index < m_modelListXml.modelfiles.@num;_index++)
			{
				m_modelNameList.push(m_modelListXml.modelfiles.mfile[_index].name);
				m_modelLoader.add(m_modelListXml.modelfiles.mfile[_index].name,m_modelListXml.modelfiles.mfile[_index].url,SPResItem.DATATYPE_TXT);
			}
			//设置处理函数
			m_modelLoader.setLoadCompHandle(modelXmlHandle);
			m_modelLoader.startLoad();
		}
		
		//model xml加载结束处理句柄
		private function modelXmlHandle(_event:Event):void
		{
			for(var _index:int = 0;_index < m_modelListXml.modelobjs.@num;_index++)
			{
				var tempResItem:SPResItem = m_modelLoader.getItem(m_modelNameList[m_modelListXml.modelobjs.obj[_index].@mfileid]);
				var tempX:Number = m_modelListXml.modelobjs.obj[_index].wx;
				var tempY:Number = m_modelListXml.modelobjs.obj[_index].wy;
				var tempZ:Number = m_modelListXml.modelobjs.obj[_index].wz;
				var tempObj:SPModelUnit = new SPModelUnit(tempResItem.txtData,tempX,tempY,tempZ);
				tempObj.setLoadCompHandle(modelLoadCompHandle);
				m_modelVector[m_modelListXml.modelobjs.obj[_index].name] = tempObj;
			}
		}
		
		//model 初始化结束处理句柄
		private function modelLoadCompHandle(_event:Event):void
		{
			m_loadModelNum++;
			if(m_loadModelNum == m_modelListXml.modelobjs.@num)
			{
				//模型初始化结束，进入主过程
				this.addEventListener(Event.ENTER_FRAME,_run);
			}
		}
		
		//游戏逻辑接口
		public function runProc():void
		{
			//用户需要继承该类并重载该接口，并添加相应的游戏或业务逻辑	
			(m_modelVector['zft0'] as SPModelUnit).rotateX(0.01);
			(m_modelVector['zft1'] as SPModelUnit).rotateY(0.05);
			(m_modelVector['zft2'] as SPModelUnit).rotateZ(0.03);
		}

	}
	
}
