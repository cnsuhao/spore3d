package sp_ngin {
	
	public class SPTransformer { 
		
		public function SPTransformer() {
			// constructor code
		}
		
		//移动
		public static function Move(_v:SPVector,_fX:Number,_fY:Number,_fZ:Number):void {
			_v.x += _fX;
			_v.y += _fY;
			_v.z += _fZ;
		}
		
		
		
		//绕x轴旋转
		public static function rotateX(_v:SPVector,_angle:Number):void {
			var tempy:Number;
			var tempz:Number;
			
			tempy = _v.y * Math.cos(_angle) - _v.z * Math.sin(_angle);
			tempz = _v.y * Math.sin(_angle) + _v.z * Math.cos(_angle);

			_v.y = tempy;
			_v.z = tempz;
		}
		
		//绕y轴旋转
		public static function rotateY(_v:SPVector,_angle:Number):void {
			var tempx:Number;
			var tempz:Number;
			
			tempx = _v.z * Math.sin(_angle) + _v.x * Math.cos(_angle);
			tempz = _v.z * Math.cos(_angle) - _v.x * Math.sin(_angle);
			
			_v.x = tempx;
			_v.z = tempz;
		}
		
		//绕Z轴旋转
		public static function rotateZ(_v:SPVector,_angle:Number):void {
			var tempx:Number;
			var tempy:Number;
			
			tempx = _v.x * Math.cos(_angle) - _v.y * Math.sin(_angle);
			tempy = _v.x * Math.sin(_angle) + _v.y * Math.cos(_angle);
			
			_v.x = tempx;
			_v.y = tempy;
		}
	}
	
}
