(*********************************************************************************
 * Copyright:   
 * Author:    TylerWoodley 
 * Created:   July 31, 2020/3:31 PM 
 *********************************************************************************)

(* Updates Control Parameters *)
FUNCTION UpdateControlParameters
	
	ControllerPar.PID.Heat.DerivativeTime   := NewParValues.PIDParameters.Heat.DerivativeTime;
	ControllerPar.PID.Heat.FilterTime       := NewParValues.PIDParameters.Heat.FilterTime;
	ControllerPar.PID.Heat.IntegrationTime  := NewParValues.PIDParameters.Heat.IntegrationTime;
	ControllerPar.PID.Heat.ProportionalGain := NewParValues.PIDParameters.Heat.ProportionalGain;
	
	ControllerPar.PID.Cool.DerivativeTime   := NewParValues.PIDParameters.Cool.DerivativeTime;
	ControllerPar.PID.Cool.FilterTime       := NewParValues.PIDParameters.Cool.FilterTime;
	ControllerPar.PID.Cool.IntegrationTime  := NewParValues.PIDParameters.Cool.IntegrationTime;
	ControllerPar.PID.Cool.ProportionalGain := NewParValues.PIDParameters.Cool.ProportionalGain;
	
	ControllerPar.Profile.Heat.DelayTime    := NewParValues.ProfileParameters.Heat.DelayTime;
	ControllerPar.Profile.Heat.FilterTime   := NewParValues.ProfileParameters.Heat.FilterTime;
	ControllerPar.Profile.Heat.SlewRate     := NewParValues.ProfileParameters.Heat.SlewRate;
	
	ControllerPar.Profile.Heat.DelayTime    := NewParValues.ProfileParameters.Heat.DelayTime;
	ControllerPar.Profile.Heat.FilterTime   := NewParValues.ProfileParameters.Heat.FilterTime;
	ControllerPar.Profile.Heat.SlewRate     := NewParValues.ProfileParameters.Heat.SlewRate;

END_FUNCTION
