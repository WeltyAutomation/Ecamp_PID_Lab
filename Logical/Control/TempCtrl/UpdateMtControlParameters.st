(*********************************************************************************
 * Copyright:   
 * Author:    TylerWoodley 
 * Created:   August 1, 2020/11:20 AM 
 *********************************************************************************)

(* TODO: Add your comment here *)
FUNCTION UpdateMtControlParameters
	
	ControllerPar.Heating.DerivativeTime  := NewParValues.PIDParameters.Heat.DerivativeTime;
	ControllerPar.Heating.FilterTime      := NewParValues.PIDParameters.Heat.FilterTime;
	ControllerPar.Heating.IntegrationTime := NewParValues.PIDParameters.Heat.IntegrationTime;
	ControllerPar.Heating.Gain            := NewParValues.PIDParameters.Heat.ProportionalGain;
	
	ControllerPar.Cooling.DerivativeTime  := NewParValues.PIDParameters.Cool.DerivativeTime;
	ControllerPar.Cooling.FilterTime      := NewParValues.PIDParameters.Cool.FilterTime;
	ControllerPar.Cooling.IntegrationTime := NewParValues.PIDParameters.Cool.IntegrationTime;
	ControllerPar.Cooling.Gain            := NewParValues.PIDParameters.Cool.ProportionalGain;
	
END_FUNCTION
