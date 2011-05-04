package sp_ngin
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	public class SPModelUnit extends Sprite
	{
		//模型资源文件
		private var m_objModelRes:SPModelRes;
		
		public function SPModelUnit(_confFileUrl:String,_x:Number,_y:Number,_z:Number)
		{
			m_objModelRes = new SPModelRes(_confFileUrl,_x,_y,_z);
			//this.addEventListener(MouseEvent.CLICK,test);
		}
		
		//public function test(_event:MouseEvent):void
		//{
			//trace("mouse test");
		//	rotateX(0.5);
		//	rotateY(0.2);
		//}
		
		//饶模型自身x轴旋转
		public function rotateX(_angle:Number):void
		{
			//var tempL:int = m_objModelRes.mVertices.length;
			for(var _index:int = 0;_index < m_objModelRes.mVertices.length;_index++)
			{
				SPTransformer.rotateX(m_objModelRes.mVertices[_index],_angle);
			}
		}
		//绕模型自身y轴旋转
		public function rotateY(_angle:Number):void
		{
			//var tempL:int = m_objModelRes.mVertices.length;
			for(var _index:int = 0;_index < m_objModelRes.mVertices.length;_index++)
			{
				SPTransformer.rotateY(m_objModelRes.mVertices[_index],_angle);	
			}
		}
		//饶模型自身z轴旋转
		public function rotateZ(_angle:Number):void
		{
			//var tempL:int = m_objModelRes.mVertices.length;
			for(var _index:int = 0;_index < m_objModelRes.mVertices.length;_index++)
			{
				SPTransformer.rotateZ(m_objModelRes.mVertices[_index],_angle);
			}
		}
		
		//生成世界坐标
		public function setWorldVertices():void
		{
			m_objModelRes.setWorldVertices();
		}
		//获得model的UV数量
		public function getUVTNum():int
		{
			return m_objModelRes.uvtArray.length;
		}
		
		public function getUVTAt(_index:int):SPUVT
		{
			return m_objModelRes.uvtArray[_index];
		}
		
		//获得贴图位图对象
		public function getBitmapAt(_index:int):Bitmap
		{
			return m_objModelRes.imgs[_index];	
		}
		
		//获得模型某点投影坐标向量
		public function getVPVerticesAt(_index:int):SPVector
		{
			return m_objModelRes.vpVertices[_index];
		}
		
		//获得模型顶点数量
		public function getVerticeNum():int
		{
			return m_objModelRes.mVertices.length;
		}
		public function getWorldVerticesAt(_index:int):SPVector
		{
			return m_objModelRes.wVertices[_index];	
		}
		public function getViewVerticesAt(_index:int):SPVector
		{
			return m_objModelRes.vVertices[_index];
		}
		//
		public function getIndiceAt(_index:int):SPIndice
		{
			return m_objModelRes.indices[_index];
		}
		
		//
		public function setLoadCompHandle(_handle:Function):void
		{
			m_objModelRes.addEventListener(SPEvent.MODEL_INIT_DONE,_handle);
		}
	}
}