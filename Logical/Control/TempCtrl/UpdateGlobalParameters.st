
(* Update Global Parameters from control info *)
FUNCTION UpdateGlobalParameters
		
	TuneValues.PIDParameters.Heat.DerivativeTime   := ControllerInfo.Tuning.PIDParameters.Heat.DerivativeTime;
	TuneValues.PIDParameters.Heat.FilterTime       := ControllerInfo.Tuning.PIDParameters.Heat.FilterTime;
	TuneValues.PIDParameters.Heat.IntegrationTime  := ControllerInfo.Tuning.PIDParameters.Heat.IntegrationTime;
	TuneValues.PIDParameters.Heat.ProportionalGain := ControllerInfo.Tuning.PIDParameters.Heat.ProportionalGain;
	
	TuneValues.PIDParameters.Cool.DerivativeTime   := ControllerInfo.Tuning.PIDParameters.Cool.DerivativeTime;
	TuneValues.PIDParameters.Cool.FilterTime       := ControllerInfo.Tuning.PIDParameters.Cool.FilterTime;
	TuneValues.PIDParameters.Cool.IntegrationTime  := ControllerInfo.Tuning.PIDParameters.Cool.IntegrationTime;
	TuneValues.PIDParameters.Cool.ProportionalGain := ControllerInfo.Tuning.PIDParameters.Cool.ProportionalGain;
	
	TuneValues.ProfileParameters.Heat.DelayTime    := ControllerInfo.Tuning.ProfileParameters.Heat.DelayTime;
	TuneValues.ProfileParameters.Heat.FilterTime   := ControllerInfo.Tuning.ProfileParameters.Heat.FilterTime;
	TuneValues.ProfileParameters.Heat.SlewRate     := ControllerInfo.Tuning.ProfileParameters.Heat.SlewRate;
	
	TuneValues.ProfileParameters.Cool.DelayTime    := ControllerInfo.Tuning.ProfileParameters.Cool.DelayTime;
	TuneValues.ProfileParameters.Cool.FilterTime   := ControllerInfo.Tuning.ProfileParameters.Cool.FilterTime;
	TuneValues.ProfileParameters.Cool.SlewRate     := ControllerInfo.Tuning.ProfileParameters.Cool.SlewRate;
	
END_FUNCTION
