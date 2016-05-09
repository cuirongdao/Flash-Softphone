package connector
{
	import flash.errors.EOFError;
	import flash.errors.IOError;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.TimerEvent;
	import flash.net.Socket;
	import flash.utils.ByteArray;
	import flash.utils.Timer;
	
	import json.*;
	
	import mx.collections.ArrayList;
	import mx.controls.Alert;
	import mx.controls.List;
	
	
	public class TCPconnector 
	{
		public function TCPconnector()
		{
			
		}
		
		var nowtime:String = "";
		var request:String = "";
		var sessionId:String = "";
		
		
		
		private var socket:Socket = new Socket();
		private var socketback:Socket = new Socket();
		
		private var timer:Timer = new Timer(60000,0);
		
		
		
		var message:String = "";
		var RserverAddress:String = "";
		var Rport:int = 0;
		
		
		public function initApp(ServerAddress:String,port:int):void{
			
			
			RserverAddress = ServerAddress;
			Rport = port;
			
			try
			{  
				
				socket.connect(ServerAddress,port);
				socket.addEventListener(Event.CONNECT,OnEventfunConnect);
				socket.addEventListener(Event.CLOSE,OnEventfunClose);	
				socket.addEventListener(ProgressEvent.SOCKET_DATA,onSocketData);
				
				//				//Alert.show(ServerAddress +"---"+port);
				//				timer.addEventListener(TimerEvent.TIMER , sendHeartBeat);
				//				timer.start();
			} 
			catch(error:Error) 
			{
				sft.OnTCPclose();
				Alert.show("error=" + error.message);
			}
			
			
		}
		
		
		
		public function initAppback(ServerAddress:String,port:int):void{
			
			RserverAddress = ServerAddress;
			Rport = port;
			
			try
			{
				socketback.connect(ServerAddress,port);
				socketback.addEventListener(Event.CONNECT,OnEventfunConnect);
				socketback.addEventListener(Event.CLOSE,OnEventfunClose);	
				socketback.addEventListener(ProgressEvent.SOCKET_DATA,onSocketData);
				
				if(socket!=null){
					
					socket.close();
					
				}
				
				socket = socketback;
				
				//				//Alert.show(ServerAddress +"---"+port);
				//				timer.addEventListener(TimerEvent.TIMER , sendHeartBeat);
				//				timer.start();
			} 
			catch(error:Error) 
			{
				sft.OnTCPclose();
				Alert.show("error==========");
			}
			
			
		}
		
		
		internal function sendMessage(msg:String):void{
			trace("---------------------"+msg);
			if(ani==""){
				
			}else{
				sft.remotingSayHello(ani,"Request    "+msg);
			}
			
			var Smessage:ByteArray = new ByteArray();
			
			try
			{	
				
				
				Smessage.writeUTFBytes(msg);
				
				socket.writeBytes(Smessage);
				
				socket.flush();
			} 
			catch(error:Error) 
			{
				
				Alert.show(error.message+"==="+error.getStackTrace()+error.toString());
			}
			
			
		}
		
		var heartbeat:int = 0;
		
		public  function sendHeartBeat(event:TimerEvent):void{
			
			var jsonobj = new Object();
			jsonobj.method = "heartbeat";
			jsonobj.object = "cti";
			jsonobj.params = null;
			
			requestbody = json.JSON.encode(jsonobj);
			datalength = requestbody.length;
			request ="CT4001" + getdatalength(datalength)+ getInvokeID()+"                                          "+ requestbody ;
			sendMessage(request);
			//			
			//			datalength = sessionId.length +67;
			//			request ="CT4001" + getdatalength(datalength) + getInvokeID() + "\r\n                                            HeartBeat\r\n"+ sessionId +"\r\n";
			heartbeat ++;
			//sendMessage(request);
			if(heartbeat>1){
				sft.OnTCPclose();
			}
			
		}
		
		
		public function OnEventfunConnect(event:Event):void{
			message = "初始化连接成功";
			sft.OninitServer();
			
			
			
		}
		public function OnEventfunClose(event:Event):void{
			message = "连接已关闭";
			sft.OnTCPclose();
		}
		
		public function socketclose():void{
			socket.close();
		}
		
		
		public function getdata():String{
			
			var dt:Date = new Date();
			nowtime = dt.fullYear.toString()+"-"+(dt.month+1).toString()+"-"+dt.date.toString()+"|"+dt.hours.toString()+":"+dt.minutes.toString()+":"+dt.seconds.toString()+":"+dt.milliseconds.toString();
			
			return nowtime;
		}
		
		
		var invokeid:int = 1;
		var invokeNo:String ="";
		public function getInvokeID():String{
			
			if(invokeid<10){
				invokeNo = "0000000"+ invokeid.toString();
			}else if(invokeid>=10&&invokeid<100){
				invokeNo = "000000"+ invokeid.toString();
			}else if(invokeid>=100&&invokeid<1000){
				invokeNo = "00000" + invokeid.toString();
			}else if(invokeid>=1000&&invokeid<10000){
				invokeNo = "0000" + invokeid.toString();
			}else if(invokeid>=10000&&invokeid<100000){
				invokeNo = "000" + invokeid.toString();
			}else if(invokeid>=100000&&invokeid<1000000){
				invokeNo = "00" + invokeid.toString();
			}else if(invokeid>=1000000&&invokeid<10000000){
				invokeNo = "0" + invokeid.toString();
			}else if(invokeid>=10000000&&invokeid<100000000){
				invokeNo = invokeid.toString();
			}else{
				invokeid = 1;
				invokeNo = "00000001";
			}
			invokeid++;
			
			return invokeNo;
		}
		
		
		var datalength:int = 0;
		var datalengths:String="";
		
		private function getdatalength(datalength:int):String{
			
			
			if(datalength<10){
				datalengths = "0000000"+ datalength.toString();
			}else if(datalength>=10&&datalength<100){
				datalengths = "000000"+ datalength.toString();
			}else if(datalength>=100&&datalength<1000){
				datalengths = "00000" + datalength.toString();
			}else if(datalength>=1000&&datalength<10000){
				datalengths = "0000" + datalength.toString();
			}else if(datalength>=10000&&datalength<100000){
				datalengths = "000" + datalength.toString();
			}else if(datalength>=100000&&datalength<1000000){
				datalengths = "00" + datalength.toString();
			}else if(datalength>=1000000&&datalength<10000000){
				datalengths = "0" + datalength.toString();
			}else if(datalength>=10000000&&datalength<100000000){
				datalengths = datalength.toString();
			}
			
			
			return datalengths;
		}
		
		
		var requestbody:String = "";
		
		public function initCTI():void{
			var jsonobj = new Object();
			jsonobj.method = "initSession";
			jsonobj.object = "cti";
			var sendarray:Array = new Array();
			sendarray[0] = "";
			sendarray[1] = "Client" + getdata();
			sendarray[2] = "172.16.0.142";
			sendarray[3] = "Async";
			jsonobj.params = sendarray;
			
			requestbody = json.JSON.encode(jsonobj);
			datalength = requestbody.length;
			request ="CT4001" + getdatalength(datalength)+ getInvokeID()+"                                          "+ requestbody ;
			
			//request ="CT4001" + getdatalength(datalength)+ getInvokeID() + "\r\n                                            initSession\r\nClient" + getdata() + "\r\nAdmin\r\nAdmin\r\nAsync\r\n";
			sendMessage(request);
		}
		
		var ani:String = "";
		
		public function monitorDevice(DeviceId:String):void{
			ani = DeviceId;
			var jsonobj = new Object();
			jsonobj.method = "monitorDevice";
			jsonobj.object = "cti";
			var sendarray:Array = new Array();
			sendarray[0] = DeviceId ; 
			jsonobj.params = sendarray;
			requestbody = json.JSON.encode(jsonobj);
			datalength = requestbody.length;
			request ="CT4001" + getdatalength(datalength)+ getInvokeID()+"                                          "+ requestbody;
			//request ="CT4001" + getdatalength(datalength) + getInvokeID() + "\r\n                                            monitorDevice\r\n"+ sessionId +"\r\n" + DeviceId + "\r\n" +"station\r\n";
			sendMessage(request);
		}
		
		public function stopMonitorDevice(DeviceId:String):void{
			var jsonobj = new Object();
			jsonobj.method = "stopMonitorDevice";
			jsonobj.object = "cti";
			var sendarray:Array = new Array();
			sendarray[0] = DeviceId ;
			jsonobj.params =sendarray;
			requestbody = json.JSON.encode(jsonobj);
			datalength = requestbody.length;
			request ="CT4001" + getdatalength(datalength)+ getInvokeID()+"                                          "+ requestbody;
			sendMessage(request);
		}
		
		public function setAgentState(requestName:String,deviceId:String,username:String,password:String,skill:String,AgentMode:String,func:String,Suspendreason:String):void{
			var jsonobj = new Object();
			jsonobj.method = requestName;
			jsonobj.object = "cti";
			var sendarray:Array = new Array();
			var jsonobj1 = new Object();
			jsonobj1.agentId = username;
			jsonobj1.agentMode = AgentMode;
			jsonobj1.deviceId = deviceId;
			jsonobj1.func = func;
			jsonobj1.group = skill;
			jsonobj1.password = password;
			jsonobj1.reason = Suspendreason;
			//var requestbody1:String = json.JSON.encode(jsonobj1);
			sendarray[0] = jsonobj1;
			jsonobj.params=sendarray;
			requestbody = json.JSON.encode(jsonobj);
			datalength = requestbody.length;
			request ="CT4001" + getdatalength(datalength)+ getInvokeID()+"                                          "+ requestbody;
			sendMessage(request);
			//datalength = sessionId.length + deviceId.length + username.length + password.length + skill.length + stat.length + Suspendreason.length + 86;
			//request = "CT4001" + getdatalength(datalength) + getInvokeID() + "\r\n                                            setAgentState\r\n" + sessionId + "\r\n" + deviceId +  "\r\n" + username + "\r\n" + password + "\r\n" + skill + "\r\n" + stat +"\r\n"+ Suspendreason + "\r\n" + "1" + "\r\n";
			//	Alert.show(request);
			
		}
		
		
		public function initDesktop(deviceId:String, agentId:String):void{
			var jsonobj = new Object;
			jsonobj.method = "initDesktop";
			jsonobj.object = "cti";
			var sendarray:Array = new Array();
			//			var jsonobj1 = new Object;
			//			jsonobj1.agentId = agentId;
			//			jsonobj1.deviceId = deviceId;
			sendarray[0] = agentId;
			sendarray[1] = deviceId;
			jsonobj.params = sendarray;
			requestbody = json.JSON.encode(jsonobj);
			datalength = requestbody.length;
			request ="CT4001" + getdatalength(datalength)+ getInvokeID()+"                                          "+ requestbody;
			sendMessage(request);
			//			Alert.show("initDesktop发送成功！");
			
			//			datalength =  sessionId.length + deviceId.length + CallId.length + 70;
			//			request = "CT4001" + getdatalength(datalength) + getInvokeID() +"\r\n                                            holdCall\r\n" + sessionId	+ "\r\n" + deviceId + "\r\n" + CallId + "\r\n";
			//			sendMessage(request);
		}
		
		public function makecall(deviceId:String,dnis:String,uui:String):void{
			
			var jsona = new Object;
			var map = new Object;
			map.uui = uui;
			jsona.map = map;
			
			var jsonobj = new Object();
			jsonobj.method = "makeCall";
			jsonobj.object = "cti";
			var sendarray:Array = new Array();
			var jsonobj1 = new Object();
			jsonobj1.dest=dnis;
			jsonobj1.deviceId=deviceId;
			jsonobj1.orgin=deviceId;
			//var requestbody1:String = json.JSON.encode(jsonobj1);
			sendarray[0] = jsonobj1;
			jsonobj.params=sendarray;
			//	Alert.show(sessionId+"=============");
			requestbody = json.JSON.encode(jsonobj);
			datalength = requestbody.length;
			request ="CT4001" + getdatalength(datalength)+ getInvokeID()+"                                          "+ requestbody;
			sendMessage(request);
		}
		
		public function answerCall(deviceId:String,CallId:String):void{
			var jsonobj = new Object;
			jsonobj.method = "answerCall";
			jsonobj.object = "cti";
			var sendarray:Array = new Array();
			var jsonobj1 = new Object;
			jsonobj1.callId = CallId;
			jsonobj1.deviceId = deviceId;
			//var requestbody1:String = json.JSON.encode(jsonobj1);
			sendarray[0] = jsonobj1;
			jsonobj.params=sendarray;
			requestbody = json.JSON.encode(jsonobj);
			datalength = requestbody.length;
			request ="CT4001" + getdatalength(datalength)+ getInvokeID()+"                                          "+ requestbody;
			sendMessage(request);
			
			//			    datalength =  sessionId.length + deviceId.length + CallId.length + 72;
			//				request = "CT4001" + getdatalength(datalength) + getInvokeID() +"\r\n                                            answerCall\r\n" + sessionId	+ "\r\n" + deviceId + "\r\n" + CallId + "\r\n";
			//				sendMessage(request);
		}
		
		public function DisconnectCall(deviceId:String,CallId:String):void{
			var jsonobj = new Object;
			jsonobj.method = "clearConnection";
			jsonobj.object = "cti";
			var sendarray:Array = new Array();
			var jsonobj1 = new Object;
			jsonobj1.callId = CallId;
			jsonobj1.deviceId = deviceId;
			//var requestbody1:String = json.JSON.encode(jsonobj1);
			sendarray[0] = jsonobj1;
			jsonobj.params=sendarray;
			requestbody = json.JSON.encode(jsonobj);
			datalength = requestbody.length;
			request ="CT4001" + getdatalength(datalength)+ getInvokeID()+"                                          "+ requestbody;
			sendMessage(request);
			
			//			datalength =  sessionId.length + deviceId.length + CallId.length + 73;
			//			request = "CT4001" + getdatalength(datalength) + getInvokeID() +"\r\n                                            DisconnCall\r\n" + sessionId	+ "\r\n" + deviceId + "\r\n" + CallId + "\r\n";
			//			sendMessage(request);
		}
		
		public function holdCall(deviceId:String,CallId:String):void{
			var jsonobj = new Object;
			jsonobj.method = "holdCall";
			jsonobj.object = "cti";
			var sendarray:Array = new Array();
			var jsonobj1 = new Object;
			jsonobj1.callId = CallId;
			jsonobj1.deviceId = deviceId;
			//var requestbody1:String = json.JSON.encode(jsonobj1);
			sendarray[0] = jsonobj1;
			jsonobj.params=sendarray;
			requestbody = json.JSON.encode(jsonobj);
			datalength = requestbody.length;
			request ="CT4001" + getdatalength(datalength)+ getInvokeID()+"                                          "+ requestbody;
			sendMessage(request);
			
			
			//			datalength =  sessionId.length + deviceId.length + CallId.length + 70;
			//			request = "CT4001" + getdatalength(datalength) + getInvokeID() +"\r\n                                            holdCall\r\n" + sessionId	+ "\r\n" + deviceId + "\r\n" + CallId + "\r\n";
			//			sendMessage(request);
		}
		
		public function RetrieveCall(deviceId:String,CallId:String):void{
			var jsonobj = new Object;
			jsonobj.method = "retrieveCall";
			jsonobj.object = "cti";
			var sendarray:Array = new Array();
			var jsonobj1 = new Object;
			jsonobj1.callId = CallId;
			jsonobj1.deviceId = deviceId;
			//var requestbody1:String = json.JSON.encode(jsonobj1);
			sendarray[0] = jsonobj1;
			jsonobj.params=sendarray;
			requestbody = json.JSON.encode(jsonobj);
			datalength = requestbody.length;
			request ="CT4001" + getdatalength(datalength)+ getInvokeID()+"                                          "+ requestbody;
			sendMessage(request);
			
			//			datalength =  sessionId.length + deviceId.length + CallId.length + 74;
			//			request = "CT4001" + getdatalength(datalength) + getInvokeID() +"\r\n                                            RetrieveCall\r\n" + sessionId	+ "\r\n" + deviceId + "\r\n" + CallId + "\r\n";
			//			sendMessage(request);
		}
		
		public function consultationCall(deviceId:String,ActiveCallID:String,ConsultationDeviceId:String,UUI:String):void{
			
			var jsona = new Object;
			var map = new Object;
			map.uui = UUI;
			jsona.map = map;
			
			var jsonobj = new Object;
			jsonobj.method = "consultationCall";
			jsonobj.object = "cti";
			var sendarray:Array = new Array();
			var jsonobj1 = new Object;
			jsonobj1.consultedDevice = ConsultationDeviceId;
			jsonobj1.deviceId = deviceId;
			jsonobj1.existingCall = ActiveCallID;
			jsonobj1.userData = jsona;
			//var requestbody1:String = json.JSON.encode(jsonobj1);
			sendarray[0] = jsonobj1;
			jsonobj.params=sendarray;
			requestbody = json.JSON.encode(jsonobj);
			datalength = requestbody.length;
			request ="CT4001" + getdatalength(datalength)+ getInvokeID()+"                                          "+ requestbody;
			sendMessage(request);
			
			//			datalength =  sessionId.length + deviceId.length + ActiveCallID.length + ConsultationDeviceId.length + CallType.length + UUI.length +84 ;
			//			request = "CT4001" + getdatalength(datalength) + getInvokeID() +"\r\n                                            consultationCall\r\n" + sessionId + "\r\n" + deviceId + "\r\n" + ActiveCallID + "\r\n" + ConsultationDeviceId + "\r\n" + CallType + "\r\n" + UUI + "\r\n"; 
			//			sendMessage(request);
		}
		
		public function SingleStepTransferCall(deviceId:String,CallId:String,Transferdeivce:String,UUI:String):void{
			
			//			var map1:Object = (json.JSON.decode(UUI) as Object);
			
			var jsona = new Object;
			var map = new Object;
			map.uui = UUI;
			jsona.map = map;
			
			var jsonobj = new Object;
			jsonobj.method = "singleStepTransferCall";
			jsonobj.object = "cti";
			var sendarray:Array = new Array();
			var jsonobj1 = new Object;
			jsonobj1.activeCall=CallId;
			jsonobj1.deviceId = deviceId;
			jsonobj1.transferredTo = Transferdeivce;
			jsonobj1.userData = jsona;
			//var requestbody1:String = json.JSON.encode(jsonobj1);
			sendarray[0] = jsonobj1;
			jsonobj.params=sendarray;
			requestbody = json.JSON.encode(jsonobj);
			datalength = requestbody.length;
			request ="CT4001" + getdatalength(datalength)+ getInvokeID()+"                                          "+ requestbody;
			sendMessage(request);
			
			//			datalength =  sessionId.length + deviceId.length + CallId.length + Transferdeivce.length + CallType.length + UUI.length + 86;
			//			request = "CT4001" + getdatalength(datalength) + getInvokeID() +"\r\n                                            SingleStepTransfer\r\n" + sessionId	+ "\r\n" + deviceId + "\r\n" + CallId + "\r\n" + Transferdeivce +"\r\n"+ CallType + "\r\n" + UUI + "\r\n";
			//			sendMessage(request);	
		}
		
		public function transferCall(KeepdeviceId:String,KeepCallId:String,NowCallId:String):void{
			var jsonobj = new Object;
			jsonobj.method = "transferCall";
			jsonobj.object = "cti";
			var sendarray:Array = new Array();
			var jsonobj1 = new Object;
			jsonobj1.activeCall = NowCallId;
			jsonobj1.deviceId = KeepdeviceId;
			jsonobj1.heldCall = KeepCallId;
			//var requestbody1:String = json.JSON.encode(jsonobj1);
			sendarray[0] = jsonobj1;
			jsonobj.params=sendarray;
			requestbody = json.JSON.encode(jsonobj);
			datalength = requestbody.length;
			request ="CT4001" + getdatalength(datalength)+ getInvokeID()+"                                          "+ requestbody;
			sendMessage(request);
			
			
			//			datalength = sessionId.length + KeepdeviceId.length + KeepCallId.length + NowdeviceId.length + NowCallId.length +78;
			//			request = "CT4001" + getdatalength(datalength) + getInvokeID() +"\r\n                                            transferCall\r\n" + sessionId	+ "\r\n" + KeepdeviceId + "\r\n" + KeepCallId + "\r\n" + NowdeviceId + "\r\n" + NowCallId + "\r\n";
			//			sendMessage(request);
		}
		
		public function conferenceCall(KeepdeviceId:String,KeepCallId:String,NowCallId:String):void{
			
			var jsonobj = new Object;
			jsonobj.method = "conferenceCall";
			jsonobj.object = "cti";
			var sendarray:Array = new Array();
			var jsonobj1 = new Object;
			jsonobj1.activeCall = NowCallId;
			jsonobj1.deviceId = KeepdeviceId;
			jsonobj1.heldCall = KeepCallId;
			//var requestbody1:String = json.JSON.encode(jsonobj1);
			sendarray[0] = jsonobj1;
			jsonobj.params=sendarray;
			requestbody = json.JSON.encode(jsonobj);
			datalength = requestbody.length;
			request ="CT4001" + getdatalength(datalength)+ getInvokeID()+"                                          "+ requestbody;
			sendMessage(request);
			
			
			
			//			datalength = sessionId.length + KeepdeviceId.length + KeepCallId.length + NowdeviceId.length + NowCallId.length +80;
			//			request = "CT4001" + getdatalength(datalength) + getInvokeID() +"\r\n                                            conferenceCall\r\n" + sessionId	+ "\r\n" + KeepdeviceId + "\r\n" + KeepCallId + "\r\n" + NowdeviceId + "\r\n" + NowCallId + "\r\n";
			//			sendMessage(request);
			
		}
		
		
		
		public function alternateCall(KeepdeviceId:String,KeepCallId:String,NowdeviceId:String,NowCallId:String):void{  //切换
			datalength = sessionId.length + KeepdeviceId.length + KeepCallId.length + NowdeviceId.length + NowCallId.length +79;
			request = "CT4001" + getdatalength(datalength) + getInvokeID() +"\r\n                                            alternateCall\r\n" + sessionId	+ "\r\n" + KeepdeviceId + "\r\n" + KeepCallId + "\r\n" + NowdeviceId + "\r\n" + NowCallId + "\r\n";
			sendMessage(request);
			
		}
		
		public function reconnectCall(KeepdeviceId:String,KeepCallId:String,NowdeviceId:String,NowCallId:String):void{ //重连
			
			var jsonobj = new Object;
			jsonobj.method = "reconnectCall";
			jsonobj.object = "cti";
			var sendarray:Array = new Array();
			var jsonobj1 = new Object;
			jsonobj1.activeCallId = NowCallId;
			jsonobj1.deviceId = KeepdeviceId;
			jsonobj1.heldCallId = KeepCallId;
			//var requestbody1:String = json.JSON.encode(jsonobj1);
			sendarray[0] = jsonobj1;
			jsonobj.params=sendarray;
			requestbody = json.JSON.encode(jsonobj);
			datalength = requestbody.length;
			request ="CT4001" + getdatalength(datalength)+ getInvokeID()+"                                          "+ requestbody;
			sendMessage(request);
			
			//			datalength = sessionId.length + KeepdeviceId.length + KeepCallId.length + NowdeviceId.length + NowCallId.length +79;
			//			request = "CT4001" + getdatalength(datalength) + getInvokeID() +"\r\n                                            reconnectCall\r\n" + sessionId	+ "\r\n" + KeepdeviceId + "\r\n" + KeepCallId + "\r\n" + NowdeviceId + "\r\n" + NowCallId + "\r\n";
			//			sendMessage(request);
		}
		
		public function SingleStepConference(ConferenceDevice:String,ConferencedDevice:String,NowCallId:String,UUI:String):void{
			
			var jsona = new Object;
			var map = new Object;
			map.uui = UUI;
			jsona.map = map;
			
			var jsonobj = new Object;
			jsonobj.method = "singleStepConferenceCall";
			jsonobj.object = "cti";
			var sendarray:Array = new Array();
			var jsonobj1 = new Object;
			jsonobj1.activeCall = NowCallId;
			jsonobj1.deviceId = ConferenceDevice;
			jsonobj1.deviceToJoin = ConferencedDevice;
			//jsonobj1.userData = UUI;
			//var requestbody1:String = json.JSON.encode(jsonobj1);
			sendarray[0] = jsonobj1;
			jsonobj.params=sendarray;
			requestbody = json.JSON.encode(jsonobj);
			datalength = requestbody.length;
			request ="CT4001" + getdatalength(datalength)+ getInvokeID()+"                                          "+ requestbody;
			sendMessage(request);
			
			
			//			datalength = sessionId.length + ConferenceDevice.length + ConferencedDevice.length+  ConferenceType.length + 84 ;
			//			request = "CT4001" + getdatalength(datalength) + getInvokeID() +"\r\n                                            SingleStepConference\r\n" + sessionId	+ "\r\n" + ConferenceDevice + "\r\n" + ConferencedDevice + "\r\n" + ConferenceType + "\r\n" ;
			//			sendMessage(request);
			
		}
		
		public function QueryAgentState(deviceID:String,agentid:String):void{
			datalength = sessionId.length +deviceID.length +agentid.length + 75;
			request = "CT4001" + getdatalength(datalength) + getInvokeID() +"\r\n                                            QueryAgentState\r\n" + sessionId + "\r\n" +deviceID+"\r\n" +agentid +"\r\n";
			sendMessage(request);
		}
		
		
		public function monitorGroup():void{
			
		}
		
		
		var sft:ClientFunction;
		
		public function AddClient(client:ClientFunction):void{
			
			
			sft=client; 
			
			
		}
		
		var setagentfailed:Boolean = true;
		var a:String = "";
		
		
		public function DealwithResponse(responsename:String,messagetype:String):void{
			
			//Alert.show("responsename : "+responsename + " messagetype : " + messagetype);
			
			if(ani==""){
				
			}else{
				sft.remotingSayHello(ani,"response    "+responsename+  "  message "+messagetype);
			}
			
			var arrs:Array = responsename.split("\r\n");
			for(var i:int=0;i<arrs.length;i++){
				trace(arrs[i]);
				a += arrs[i]+"\r\n";
			}
			
			var container:Object = (json.JSON.decode(responsename) as Object);
			
			
			
			if(messagetype=="10"){
				//Alert.show("messagebody : "+responsename + " messagetype : " + messagetype);
				
				if(container.method=="initSession"){
					sessionId=container.ret.sessionId;
					sft.OninitApp(sessionId);
					timer.addEventListener(TimerEvent.TIMER , sendHeartBeat);
					timer.start();
				}
				
				if(container.method=="monitorDevice"){
					
					sft.OnMonitorDevice(ani);
					
				}
				
				if(arrs[2]=="stopMonitorDevice"){
					//				   sft.OnstopMonitorDevice(arrs[3],arrs[4],arrs[5],arrs[6]);
					
				}
				
				if(arrs[2]=="setAgentState"){
					
					//Alert.show("loginsuccessed-------------");
					//						if(arrs[7]=="0"){
				}
				
				if(container.method=="heartbeat"){  //2016.3.8 孙璐 修改内容（arrs[2]->container.method  HeartBeat-> heartbeat）
					heartbeat --;
					//Alert.show("心跳成功！");
				}
				
				if(arrs[2]=="QueryAgentState"){
					//sft.OnQueryAgentState(arrs[3],arrs[4],arrs[5],arrs[6],arrs[7],arrs[8]);
				}
				
				
			}
			
			if(messagetype=="99"){
				//Alert.show("messagebody : "+responsename + " messagetype : " + messagetype);
				
				if(container.name=="serviceInitiated"){  //摘机
					sft.OnSeizedEvt(container.source,container.timestamp,container.properties.initiatedDevice,container.properties.contactId,container.properties.callId,container.properties.deviceId,container.properties.connectionState,container.properties.srcDeviceId,container.properties._sessionId);
				}
				
				if(container.name=="connectionCleared"){  //清除连接--挂断
					
					sft.OnConnectionCleared(container.source,container.timestamp,container.properties.releasingDevice,container.properties.contactId,container.properties.callId,container.properties.deviceId,container.properties.connectionState,container.properties.srcDeviceId,container.properties._sessionId);
				}
				
				if(container.name=="agentNotReady"){  //离席
					
					sft.OnagentNotReady(container.source,container.timestamp,container.properties.reason,container.properties.deviceId,container.properties.agentId,container.properties.agentMode,container.properties.srcDeviceId,container.properties._sessionId);
					setagentfailed=false;
				}
				
				if(container.name=="agentWorkingAfterCall"){  //话后处理
					
					sft.OnagentWorkingAfterCall(container.source,container.timestamp,container.properties.deviceId,container.properties.agentId,container.properties.agentMode,container.properties.srcDeviceId,container.properties._sessionId);
					//					setagentfailed=false;
				}
				
				if(container.name=="agentLoggedOn"){  //登录
					
					sft.OnagentLoggedOn(container.source,container.timestamp,container.properties.groupId,container.properties.deviceId,container.properties.agentId,container.properties.agentMode,container.properties.srcDeviceId,container.properties._sessionId);
					//setagentfailed=false;
				}
				
				if(container.name=="agentReady"){  //就绪
					
					sft.OnagentReady(container.source,container.timestamp,container.properties.deviceId,container.properties.agentId,container.properties.agentMode,container.properties.srcDeviceId,container.properties._sessionId);
					//setagentfailed=false;
				}
				
				if(container.name=="agentLoggedOff"){  //退出
					
					sft.OnagentLoggedOff(container.source,container.timestamp,container.properties.deviceId,container.properties.agentId,container.properties.agentMode,container.properties.srcDeviceId,container.properties._sessionId);
					//setagentfailed=false;
				}
				
				if(container.name=="delivered"){  //振铃
					var userData:String = "";
					userData = json.JSON.encode(container.properties.userData);
					//					Alert.show(userData);
					sft.OnDelivered(container.source,container.timestamp,container.properties.alertingDevice,container.properties.callingDevice,container.properties.calledDevice,container.properties.originalContactId,container.properties.contactId,container.properties.callId,container.properties.deviceId,container.properties.connectionState,container.properties.srcDeviceId,userData);
				}
				
				if(container.name=="established"){  //电话接通
					var userData:String = "";
					userData = json.JSON.encode(container.properties.userData);
					
					sft.OnEstablished(container.source,container.timestamp,container.properties.answeringDevice,container.properties.callingDevice,container.properties.calledDevice,container.properties.contactId,container.properties.callId,container.properties.deviceId,container.properties.connectionState,container.properties.srcDeviceId,userData);
				}
				
				if(container.name=="held"){ //保持
					
					sft.OnHold(container.source,container.timestamp,container.properties.holdingDevice,container.properties.contactId,container.properties.callId,container.properties.deviceId,container.properties.connectionState,container.properties.srcDeviceId,container.properties._sessionId);
				}
				
				if(container.name=="retrieved"){  //取回保持
					sft.OnRetrieved(container.source,container.timestamp,container.properties.retrievingDevice,container.properties.contactId,container.properties.callId,container.properties.deviceId,container.properties.connectionState,container.properties.srcDeviceId,container.properties._sessionId);
				}
				
				if(container.name=="transferred"){  //转接
					sft.OnTransfered(container.source,container.timestamp,container.properties.primaryOldCall,container.properties.secondaryOldCall,container.properties.transferringDevice,container.properties.transferredToDevice,container.properties.newCall,container.properties.contactId,container.properties.callId,container.properties.deviceId,container.properties.connectionState,container.properties.srcDeviceId,container.properties._sessionId);
				}
				
				if(container.name=="conferenced"){  //会议
					sft.OnConferenced(container.source,container.timestamp,container.properties.primaryOldCall,container.properties.secondaryOldCall,container.properties.conferencingDevice,container.properties.addedParty,container.properties.newCall,container.properties.contactId,container.properties.callId,container.properties.deviceId,container.properties.connectionState,container.properties.srcDeviceId,container.properties._sessionId);
				}
				
				if(container.name=="originated"){  //外拨
					sft.OnOrginated(container.source,container.timestamp,container.properties.callingDevice,container.properties.calledDevice,container.properties.contactId,container.properties.callId,container.properties.deviceId,container.properties.connectionState,container.properties.srcDeviceId,container.properties._sessionId);
				}
				
				if(arrs[2]=="Failured"){
					
				}
				
				
			}
			
			
			if(messagetype=="11"){
				Alert.show("messagebody : "+responsename + " messagetype : " + messagetype);
				//Alert.show("--------------------Exception");
				if(arrs[2]=="setAgentState"){
					
					if(setagentfailed==true){
						sft.faillogin(arrs[7]);
					}
					
				}
				if(arrs[2]=="monitorDevice"){
					//sft.backlogin(arrs[7]);	
					Alert.show("初始化分机失败 failure reason"+ arrs[6]);
				}
				if(arrs[2]=="stopMonitorDevice"){
					//sft.backlogin(arrs[7]);	
					Alert.show("failure reason"+ arrs[6]);
				}
				if(arrs[2]=="makeCall"){
					//sft.backlogin(arrs[7]);	
					Alert.show("外拨失败  failure reason"+ arrs[6]);
				}
				if(arrs[2]=="answerCall"){
					//sft.backlogin(arrs[7]);	
					Alert.show("接听失败 failure reason"+ arrs[6]);
				}
				if(arrs[2]=="DisconnCall"){
					//sft.backlogin(arrs[7]);	
					Alert.show("挂断失败 failure reason"+ arrs[6]);
				}
				if(arrs[2]=="holdCall"){
					//sft.backlogin(arrs[7]);	
					Alert.show("保持失败 failure reason"+ arrs[6]);
				}
				if(arrs[2]=="RetrieveCall"){
					//sft.backlogin(arrs[7]);	
					Alert.show("重连失败 failure reason"+ arrs[6]);
				}
				if(arrs[2]=="consultationCall"){
					//sft.backlogin(arrs[7]);	
					Alert.show("磋商失败 failure reason"+ arrs[6]);
				}
				if(arrs[2]=="SingleStepTransfer"){
					//sft.backlogin(arrs[7]);	
					Alert.show("单步转接 failure reason"+ arrs[6]);
				}
				if(arrs[2]=="transferCall"){
					//sft.backlogin(arrs[7]);	
					Alert.show("后转失败 failure reason"+ arrs[6]);
				}
				if(arrs[2]=="conferenceCall"){
					//sft.backlogin(arrs[7]);	
					Alert.show("会议失败 failure reason"+ arrs[6]);
				}
				if(arrs[2]=="alternateCall"){
					//sft.backlogin(arrs[7]);	
					Alert.show("切换失败  failure reason"+ arrs[6]);
				}
				if(arrs[2]=="reconnectCall"){
					//sft.backlogin(arrs[7]);	
					Alert.show("重连失败 failure reason"+ arrs[6]);
				}
				if(arrs[2]=="SingleStepConference"){
					//sft.backlogin(arrs[7]);	
					Alert.show("单步会议失败 failure reason"+ arrs[6]);
				}
				
			}
			
			
		}
		
		
		var bufferArray:ByteArray = new ByteArray();
		
		private function judgemessage(messages:ByteArray):void{
			
			
			
			var messagelengths:int  = 0;
			var bodylengths:int = 0;
			var messagetypes:String = "";
			
			var messagehead:ByteArray = new ByteArray();
			var messagebody:ByteArray = new ByteArray();
			
			
			
			if(messages.length>=64){
				
				
				for(var i:int = 0;i<64;i++){
					messagehead[i] = messages[i];
				}
				
				var b:int = 0;
				
				for(var j:int = 64;j<messages.length;j++){
					
					messagebody[b] = messages[j];
					b++;
				}
				
				messagelengths = Number( messagehead.toString().substring(6,14));
				
				messagetypes = messagehead.toString().substring(4,6);
				
				bodylengths = messagebody.length;
				
				//Alert.show(messagebody.toString());
				
				
				if(bodylengths<messagelengths){
					
					
					
					bufferArray = new ByteArray();
					for(var i:int =0;i<messages.length;i++){
						bufferArray[i] = messages[i];
					}
					
				}
				
				var handlemessage:ByteArray = new ByteArray();
				var longmessage:ByteArray = new ByteArray();
				
				
				if(bodylengths>messagelengths){
					
					
					
					for(var i:int=0;i<messagelengths;i++){
						handlemessage[i] =  messages[i+64];
						
					}
					//Alert.show("  handlemessage length :" + handlemessage.length);
					for(var j:int=0;j<bodylengths-messagelengths;j++){
						longmessage[j] = messages[64+messagelengths+j];
						
					}
					//Alert.show("  longmessage length : " + longmessage.length);
					
					
					DealwithResponse(handlemessage.toString(),messagetypes);
					
					bufferArray = new ByteArray();
					
					for(var n:int = 0;n<longmessage.length;n++){
						bufferArray[n] = longmessage[n]; 
					}
					
					judgemessage(bufferArray);
					
				}
				
				
				
				if(messagelengths==bodylengths){
					
					
					for(var i:int=0;i<messagelengths;i++){
						handlemessage[i] = messages[64+i];
					}
					
					try
					{
						
						DealwithResponse(handlemessage.toString(),messagetypes);
						//Alert.show("Handlemessage : " + handlemessage.toString());
					} 
					catch(error:Error) 
					{
						bufferArray = new ByteArray();
					}
					
					bufferArray = new ByteArray();
					
				}
				
				
			}else{
				
				bufferArray = new ByteArray();
				for(var i:int =0;i<messages.length;i++){
					bufferArray[i] = messages[i];
				}
				
			}
			
		}
		
		
		
		
		private function onSocketData( eventrogressEvent ):void {
			
			try
				
			{
				
				
				//var string:String = socket.readUTFBytes(socket.bytesAvailable);
				
				//Alert.show(string);
				
				var buf:ByteArray = new ByteArray();
				
				
				socket.readBytes(buf,0,socket.bytesAvailable);
				//Alert.show(buf.toString());
				
				
			} 
			catch(error:IOError) 
			{
				Alert.show("socket error :" + error.message);
			}
			
			
			
			for(var j:int=0;j<buf.length; j++){
				
				bufferArray[bufferArray.length] = buf[j];
				
			}
			
			var eventStr:String = new String(bufferArray);
			trace("****************************");
			trace(eventStr);
			
			
			var headbuf:ByteArray = new ByteArray();
			
			var head:String ="";
			
			if(bufferArray.length>=64){
				
				for(var i:int = 0; i<64; i++){
					headbuf[i] = bufferArray[i];
				}
				
				
				head = headbuf.toString().substring(0,4);
				
				
				if(head=="CT40"){
					
					judgemessage(bufferArray);
					
				}else{
					
					Alert.show("TCP Information Error");
					
				}
				
			}
			
		}
		
	}
	
}