package connector
{
	public interface ClientFunction
	{
		function OninitServer():void;
		
		function OnQueryAgentState(agentid:String,result:String,agentstat:String,logindevice:String,skilllist:String,failNO:String):void;
		
		function OnTCPclose():void;
		
		function remotingSayHello(deviceId:String,logMessage:String):void;
		
		function OninitApp(sessionId:String):void;
		
		function OnMonitorDevice(deviceID:String):void;
		
		function OnstopMonitorDevice(sessionId:String,deviceId:String,Result:String,Code:String):void;
		
		function OnSeizedEvt(source:String,timestamp:String,initiatedDevice:String,contactId:String,callId:String,deviceId:String,connectionState:String,srcDeviceId:String,_sessionId:String):void;
		
		function OnConnectionCleared(source:String,timestamp:String,releasingDevice:String,contactId:String,callId:String,deviceId:String,connectionState:String,srcDeviceId:String,_sessionId:String):void;
	
		function OnagentNotReady(source:String,timestamp:String,reason:String,deviceId:String,agentId:String,agentMode:String,srcDeviceId:String,_sessionId:String):void;
		
		function OnagentWorkingAfterCall(source:String,timestamp:String,deviceId:String,agentId:String,agentMode:String,srcDeviceId:String,_sessionId:String):void;
		
		function OnagentLoggedOn(source:String,timestamp:String,groupId:String,deviceId:String,agentId:String,agentMode:String,srcDeviceId:String,_sessionId:String):void;

		function OnagentReady(source:String,timestamp:String,deviceId:String,agentId:String,agentMode:String,srcDeviceId:String,_sessionId:String):void;
		
		function OnagentLoggedOff(source:String,timestamp:String,deviceId:String,agentId:String,agentMode:String,srcDeviceId:String,_sessionId:String):void;
		
		function OnDelivered(source:String,timestamp:String,alertingDevice:String,callingDevice:String,calledDevice:String,originalContactId:String,contactId:String,callId:String,deviceId:String,connectionState:String,srcDeviceId:String,_sessionId:String):void;
	
		function OnEstablished(source:String,timestamp:String,answeringDevice:String,callingDevice:String,calledDevice:String,contactId:String,callId:String,deviceId:String,connectionState:String,srcDeviceId:String,_sessionId:String):void;
					
		function OnHold(source:String,timestamp:String,holdingDevice:String,contactId:String,callId:String,deviceId:String,connectionState:String,srcDeviceId:String,_sessionId:String):void;
		
		function OnRetrieved(source:String,timestamp:String,retrievingDevice:String,contactId:String,callId:String,deviceId:String,connectionState:String,srcDeviceId:String,_sessionId:String):void;
		
		function OnTransfered(source:String,timestamp:String,primaryOldCall:String,secondaryOldCall:String,transferringDevice:String,transferredToDevice:String,newCall:String,contactId:String,callId:String,deviceId:String,connectionState:String,srcDeviceId:String,_sessionId:String):void;
			
		function OnConferenced(source:String,timestamp:String,primaryOldCall:String,secondaryOldCall:String,conferencingDevice:String,addedParty:String,newCall:String,contactId:String,callId:String,deviceId:String,connectionState:String,srcDeviceId:String,_sessionId:String):void;
	
		function OnOrginated(source:String,timestamp:String,callingDevice:String,calledDevice:String,contactId:String,callId:String,deviceId:String,connectionState:String,srcDeviceId:String,_sessionId:String):void;
			
		function faillogin(reason:String):void;
	
	}
	
}