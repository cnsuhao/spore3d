package sp_ngin {
	
	public class SPTransformer { 
		
		public function SPTransformer() {
			// constructor code
		}
		
		//绕x轴旋转
		public static function RotateX(_v:SPVector,_angle:Number):void {
			//var tempx:Number;
			var tempy:Number;
			var tempz:Number;
			
			tempy = _v.y * Math.cos(_angle) - _v.z * Math.sin(_angle);
			tempz = _v.y * Math.sin(_angle) + _v.z * Math.cos(_angle);

			_v.y = tempy;
			_v.z = 

		}
		
	}
	
}
