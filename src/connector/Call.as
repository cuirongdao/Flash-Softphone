package connector
{
	public class Call
	{
		public function Call()
		{
		}
		private var _Callid:String = "";
		private var _Ani:String = "";
		private var _Dnis:String = "";
		private var _CallType:String = "";
		private var _State:String = "";
		private var _UUI:String = "";
		


		public function getUUI():String
		{
			return _UUI;
		}

		public function setUUI(value:String):void
		{
			_UUI = value;
		}

		public function getState():String
		{
			return _State;
		}

		public function setState(value:String):void
		{
			_State = value;
		}

		public function getCallType():String
		{
			return _CallType;
		}

		public function setCallType(value:String):void
		{
			_CallType = value;
		}

		public function getDnis():String
		{
			return _Dnis;
		}

		public function setDnis(value:String):void
		{
			_Dnis = value;
		}

		public function getAni():String
		{
			return _Ani;
		}

		public function setAni(value:String):void
		{
			_Ani = value;
		}

		public function getCallid():String
		{
			return _Callid;
		}

		public function setCallid(value:String):void
		{
			_Callid = value;
		}

	}
}