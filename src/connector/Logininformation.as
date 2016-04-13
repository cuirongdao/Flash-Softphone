package connector
{
	public class Logininformation
	{
		public function Logininformation()
		{
		}
		var txtUsername:String = "";
		var txtPassword:String = "";
		var deviceId:String = "";
		var CTIServer1:String = "";
		var port1:int = 0;
		var CTIServer2:String = "";
		var port2:int = 0;
		var ReportnumberIVR:String = "";
		var satisfactionIVR:String = "";
		var UUI:String = "";
		var skillNo:String = "";
		var logpath:String="";
		var ServerAdress:String = "";
		
		
		public function settxtUsername(value:String):void
		{
			txtUsername = value;
		}
		
		public function settxtPassword(value:String):void
		{
			txtPassword = value;
		}
		
		public function setdeviceId(value:String):void
		{
			deviceId = value;
		}
		
		public function setCTIServer1(value:String):void
		{
			CTIServer1 = value;
		}
		
		public function setport1(value:int):void
		{
			port1 = value;
		}
		
		public function setCTIServer2(value:String):void
		{
			CTIServer2 = value;
		}
		
		public function setport2(value:int):void
		{
			port2 = value;
		}
		
		public function setReportnumberIVR(value:String):void
		{
			ReportnumberIVR = value;
		}
		
		public function setsatisfactionIVR(value:String):void
		{
			satisfactionIVR = value;
		}
		
		public function setskillNo(value:String):void
		{
			skillNo = value;
		}
		
		public function setUUI(value:String):void
		{
			UUI = value;
		}
		
		public function setLogpath(value:String):void{
			logpath = value;
		}
		
		public function setServerAdress(value:String):void{
			ServerAdress = value;
		}
		
		
		
		public function getAgentId():String{
			return txtUsername;
		}
		
		public function getpassword():String{
			return txtPassword;
		}
		
		public function getDeviceId():String{
			return deviceId;
		}
		
		public function getCTIServer1():String{
			return CTIServer1;
		}
		
		public function getport1():int{
			return Number(port1);
		}
		
		public function getCTIServer2():String{
			return CTIServer2;
		}
		
		public function getport2():int{
			return Number(port2);
		}
		
		public function getReportnumberIVR():String{
			return ReportnumberIVR;
		}
		
		public function getsatisfactionIVR():String{
			return satisfactionIVR;
		}
		
		public function getUUI():String{
			return UUI;
		}
		
		public function getskillNo():String{
			return skillNo;
		}
		
		public function getLogpath():String{
			return logpath;
		}
		
		public function getServerAdress():String{
			return ServerAdress;
		}
		
		
		
	}
}