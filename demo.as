package
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.display.TriangleCulling;
	import flash.events.Event;
	import flash.utils.ByteArray;
	
	import sp_ngin.*;
	
	public class demo extends Sprite
	{
		//配置文件加载器
		private var m_objListLoader:SPListLoader = new SPListLoader();
		
		//配置文件xml对象
		private var m_xml:XML;
		
		//主摄像机对象
		private var m_objCamera:SPCamera;
		
		//主渲染器对象
		private var m_objRender:SPRender;
		
		//主投影面对象
		private var m_objViewPort:SPViewport;
		
		//主场景对象
		private var m_objScene:SPScene;
		
		public function demo()
		{
			//加载配置文件
			m_objListLoader.add("conf","http://127.0.0.1/conf/conf.xml",SPResItem.DATATYPE_TXT);
			m_objListLoader.addEventListener(SPEvent.LOAD_DONE,init);
			m_objListLoader.startLoad();
			
		}
		private function init(_event:Event):void
		{
			m_xml = new XML(m_objListLoader.getItem("conf").txtData);
			m_objCamera = new SPCamera(m_xml.camera.viewpoint.x,m_xml.camera.viewpoint.y,m_xml.camera.viewpoint.z);
			m_objViewPort = new SPViewport(m_xml.viewport.width,m_xml.viewport.height);
			m_objRender = new SPRender();
			m_objScene = new SPScene(m_objCamera,m_objViewPort,m_objRender,m_xml.modellist.url);
			m_objScene.init();
			this.addChild(m_objScene);
		}
	}
}
