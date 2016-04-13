package connector
{
	import mx.controls.Alert;
	
	import spark.components.List;

	public class CallManager
	{
		public function CallManager()
		{
		}
		
		
///		var calls : Array = new Array();	
//		
//		var i:int = 0;
		
		var callarray:Array = new Array;
		
		var call:Call = new Call();
		
		var _call1:Call = new Call();
		var _call2:Call = new Call();
		var _call3:Call = new Call();
		
		public function addNewCall(call:Call):void{
			
			//Alert.show(call.getState()+"   call-----id :" + call.getCallid()+" --> callid111 :"+_call1.getCallid());
			
			if(_call1.getCallid()=="" || _call1.getCallid()==call.getCallid()){
				_call1 = call;
				//Alert.show(_call1.getState()+" === update calld1 : " + _call1.getCallid());
				clearcall(_call1);
			//	Alert.show("after clear call1d" + _call1.getCallid() );
				return;
			}
		
			//	Alert.show("Call already exist callId = "+call.getCallid());
		
			if(_call2.getCallid()=="" || _call2.getCallid()==call.getCallid()){
				_call2 = call;
				//Alert.show("calld2 : " + _call2.getCallid());
				clearcall(_call2);
				return;
			}
		
			if(_call3.getCallid()=="" || _call3.getCallid()==call.getCallid()){
				_call3 = call;
			
				clearcall(_call3);
				return;
			}
		}
		
		

		
		public function clearcall(call:Call):void{
			
			if(call.getState()=="电话挂断"){
				
				if(call.getCallid()==_call1.getCallid()){
					_call1 = new Call();
					
				}
				if(call.getCallid()==_call2.getCallid()){
					_call2 = new Call();
				}
				if(call.getCallid()==_call3.getCallid()){
					_call3 = new Call();
				}
			}
			
			if(call.getState()=="已转接"){
				
				if(call.getCallid()==_call1.getCallid()){
					_call1 = new Call();
				}
				if(call.getCallid()==_call2.getCallid()){
					_call2 = new Call();
				}
				if(call.getCallid()==_call3.getCallid()){
					_call3 = new Call();
				}
			}
	
		}
		
//		public function getCallState():Call{
//			
//		}
//		
//		public function getCall():Call{
//			
//		}
		
		public function getcall1():Call{
			
			return _call1;
		}
		
		public function getcall2():Call{
			
			return _call2;
		}
		
		public function getcall3():Call{
			
			return _call3;
		}
		
		
	
	}
}