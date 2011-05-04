package sp_ngin {
	
	import flash.display.TriangleCulling;
	
	public class SPRender {

		public function SPRender() {
			// constructor code
		}
		
		//渲染容器中所有模型
		public function renderAll(_obj:Object):void
		{
			for each(var _o in _obj)
			{
				renderModel(_o);
			}
		}
		
		//渲染模型
		public function renderModel(_model:SPModelUnit,_useMap:Boolean = true):void
		{	
			//清除前一帧数据
			_model.graphics.clear();
			
			//渲染模型
			var uvtNum:int = _model.getUVTNum();
			for(var _index:int = 0;_index < uvtNum;_index++)
			{
				var v:Vector.<Number> = new Vector.<Number>();
				var i:Vector.<int> = new Vector.<int>();
				var uvt:Vector.<Number> = new Vector.<Number>();
				
				
				
				var _tempUV:SPUVT = _model.getUVTAt(_index);
				for(var _i:int = 0;_i < _tempUV.getUVNum();_i++)
				{
					var _tempuvdata:SPUVData = _tempUV.getUVData(_i);
					
					var _tempv:SPVector = _model.getVPVerticesAt(_tempuvdata.id);
					
					v.push(_tempv.x,_tempv.y);
					uvt.push(_tempuvdata.u,_tempuvdata.v,0.5);
				}
				for(var _j:int = 0;_j < _tempUV.getIndNum();_j++)
				{
					var _tempInd:SPIndice = _model.getIndiceAt(_tempUV.getIndData(_j));
					i.push(_tempInd.v1,_tempInd.v2,_tempInd.v3);
				}
				
				
				if(_useMap)
				{
					_model.graphics.beginBitmapFill(_model.getBitmapAt(_tempUV.imgID).bitmapData);
					_model.graphics.drawTriangles(v,i,uvt,TriangleCulling.NEGATIVE);
					_model.graphics.endFill();
				}
				else
				{
					_model.graphics.lineStyle(0,0,.5);
					_model.graphics.drawTriangles(v,i);
				}
			}
		}
		
	}
	
}
