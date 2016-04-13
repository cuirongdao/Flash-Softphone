
	
	//request
	function initSession(ServerAddress,port){
	JsConnector.initSession(ServerAddress,port);
	}
	
	JsConnector.initCTI();
	}
	
	function monitorDevice(DeviceId){
	JsConnector.monitorDevice(DeviceId);
	}
	
	function stopMonitorDevice(DeviceId){
	JsConnector.stopMonitorDevice(DeviceId);
	}
	
	function setAgentState(requestName,deviceId,username,password,skill,AgentMode,func,Suspendreason){
	JsConnector.setAgentState(requestName,deviceId,username,password,skill,AgentMode,func,Suspendreason);
	}
	
	function makecall(deviceId,dnis,uui){
	JsConnector.stopMonitorDevice(deviceId,dnis,uui);
	}
	
	function answerCall(deviceId,CallId){
	JsConnector.answerCall(deviceId,CallId);
	}
	
	function DisconnectCall(deviceId,CallId){
	JsConnector.DisconnectCall(deviceId,CallId)
	}
	
	function holdCall(deviceId,CallId){
	JsConnector.holdCall(deviceId,CallId)
	}
	
	function RetrieveCall(deviceId,CallId){
	JsConnector.RetrieveCall(deviceId,CallId)
	}
	
	function SingleStepTransferCall(deviceId,CallId,Transferdeivce,UUI){
	JsConnector.SingleStepTransferCall(deviceId,CallId,Transferdeivce,UUI)
	}
	
	function transferCall(KeepdeviceId,KeepCallId,NowCallId){
	JsConnector.transferCall(KeepdeviceId,KeepCallId,NowCallId);
	}
	
	function conferenceCall(KeepdeviceId,KeepCallId,NowCallId){
	JsConnector.conferenceCall(KeepdeviceId,KeepCallId,NowCallId);
	}
	
	function reconnectCall(KeepdeviceId,KeepCallId,NowdeviceId,NowCallId){
	JsConnector.reconnectCall(KeepdeviceId,KeepCallId,NowdeviceId,NowCallId);
	}
	
	function SingleStepConference(ConferenceDevice,ConferencedDevice,NowCallId,UUI){
	JsConnector.SingleStepConference(ConferenceDevice,ConferencedDevice,NowCallId,UUI);
	}
	
	
	
	
	//response&&&Event
	
			function OninitServer(){ 
			
			}
			
			function OnQueryAgentState(agentid,result,agentstat,logindevice,skilllist,failNO){
				
			}
			
			function OnTCPclose(){
				
			}
			
			function remotingSayHello(deviceId,logMessage){
				
			}
			
			
			function Makecall(dnis){
				
			}
			
			function OninitApp(sessionId){
				
			}
			
			function OnMonitorDevice(deviceID){
				
			}
			
			function OnstopMonitorDevice(sessionId,deviceId,Result,Code){
				
			}
			
			function OnSeizedEvt(source,timestamp,initiatedDevice,contactId,callId,deviceId,connectionState,srcDeviceId,_sessionId){
				
			}
			
			function OnConnectionCleared(source,timestamp,releasingDevice,contactId,callId,deviceId,connectionState,srcDeviceId,_sessionId){
				
			}
			
			function OnagentNotReady(source,timestamp,reason,deviceId,agentId,agentMode,srcDeviceId,_sessionId){
				
			}
			
			function OnagentLoggedOn(source,timestamp,groupId,deviceId,agentId,agentMode,srcDeviceId,_sessionId){
				
			}
			
			function OnagentReady(source,timestamp,deviceId,agentId,agentMode,srcDeviceId,_sessionId){
				
			}
			
			function OnagentLoggedOff(source,timestamp,deviceId,agentId,agentMode,srcDeviceId,_sessionId){
				
			}
			
			function OnDelivered(source,timestamp,alertingDevice,callingDevice,calledDevice,originalContactId,contactId,callId,deviceId,connectionState,srcDeviceId,_sessionId){
				
			}
			
			function OnEstablished(source,timestamp,answeringDevice,callingDevice,calledDevice,contactId,callId,deviceId,connectionState,srcDeviceId,_sessionId){
				
			}
			
			function OnHold(source,timestamp,holdingDevice,contactId,callId,deviceId,connectionState,srcDeviceId,_sessionId){
				
			}
			
			function OnRetrieved(source,timestamp,retrievingDevice,contactId,callId,deviceId,connectionState,srcDeviceId,_sessionId){
				
			}
			
			function OnTransfered(source,timestamp,primaryOldCall,secondaryOldCall,transferringDevice,transferredToDevice,newCall,contactId,callId,deviceId,connectionState,srcDeviceId,_sessionId){
				
			}
			
			function OnConferenced(source,timestamp,primaryOldCall,secondaryOldCall,conferencingDevice,addedParty,newCall,contactId,callId,deviceId,connectionState,srcDeviceId,_sessionId){
				
			}
			
			function OnOrginated(source,timestamp,callingDevice,calledDevice,contactId,callId,deviceId,connectionState,srcDeviceId,_sessionId){
				
			}
			
			function faillogin(reason){
				
			}