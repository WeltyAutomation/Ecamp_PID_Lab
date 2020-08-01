(*********************************************************************************
 * Copyright:   
 * Author:    TylerWoodley 
 * Created:   August 1, 2020/11:42 AM 
 *********************************************************************************)

(* Update Global Parameters from control info *)
FUNCTION UpdateGlobalParameters
	
	FOR index := 0 TO 2 DO
		TuneRecipe.ControlTune[index].PIDParameters.Heat.DerivativeTime   := TempGroup.MpZones[index].Out.Info.Tuning.PIDParameters.Heat.DerivativeTime;
		TuneRecipe.ControlTune[index].PIDParameters.Heat.FilterTime       := TempGroup.MpZones[index].Out.Info.Tuning.PIDParameters.Heat.FilterTime;
		TuneRecipe.ControlTune[index].PIDParameters.Heat.IntegrationTime  := TempGroup.MpZones[index].Out.Info.Tuning.PIDParameters.Heat.IntegrationTime;
		TuneRecipe.ControlTune[index].PIDParameters.Heat.ProportionalGain := TempGroup.MpZones[index].Out.Info.Tuning.PIDParameters.Heat.ProportionalGain;
		
		TuneRecipe.ControlTune[index].PIDParameters.Cool.DerivativeTime   := TempGroup.MpZones[index].Out.Info.Tuning.PIDParameters.Cool.DerivativeTime;
		TuneRecipe.ControlTune[index].PIDParameters.Cool.FilterTime       := TempGroup.MpZones[index].Out.Info.Tuning.PIDParameters.Cool.FilterTime;
		TuneRecipe.ControlTune[index].PIDParameters.Cool.IntegrationTime  := TempGroup.MpZones[index].Out.Info.Tuning.PIDParameters.Cool.IntegrationTime;
		TuneRecipe.ControlTune[index].PIDParameters.Cool.ProportionalGain := TempGroup.MpZones[index].Out.Info.Tuning.PIDParameters.Cool.ProportionalGain;
		
		TuneRecipe.ControlTune[index].ProfileParameters.Heat.DelayTime    := TempGroup.MpZones[index].Out.Info.Tuning.ProfileParameters.Heat.DelayTime;
		TuneRecipe.ControlTune[index].ProfileParameters.Heat.FilterTime   := TempGroup.MpZones[index].Out.Info.Tuning.ProfileParameters.Heat.FilterTime;
		TuneRecipe.ControlTune[index].ProfileParameters.Heat.SlewRate     := TempGroup.MpZones[index].Out.Info.Tuning.ProfileParameters.Heat.SlewRate;
				
		TuneRecipe.ControlTune[index].ProfileParameters.Cool.DelayTime    := TempGroup.MpZones[index].Out.Info.Tuning.ProfileParameters.Cool.DelayTime;
		TuneRecipe.ControlTune[index].ProfileParameters.Cool.FilterTime   := TempGroup.MpZones[index].Out.Info.Tuning.ProfileParameters.Cool.FilterTime;
		TuneRecipe.ControlTune[index].ProfileParameters.Cool.SlewRate     := TempGroup.MpZones[index].Out.Info.Tuning.ProfileParameters.Cool.SlewRate;
	END_FOR;

	TuneRecipe.ControlTune[3].PIDParameters.Heat.DerivativeTime           := TempGroup.MtZone.Tuning.Out.PIDParameters.Heating.DerivativeTime;
	TuneRecipe.ControlTune[3].PIDParameters.Heat.FilterTime               := TempGroup.MtZone.Tuning.Out.PIDParameters.Heating.FilterTime;
	TuneRecipe.ControlTune[3].PIDParameters.Heat.IntegrationTime          := TempGroup.MtZone.Tuning.Out.PIDParameters.Heating.IntegrationTime;
	TuneRecipe.ControlTune[3].PIDParameters.Heat.ProportionalGain         := TempGroup.MtZone.Tuning.Out.PIDParameters.Heating.Gain;
	
	TuneRecipe.ControlTune[3].PIDParameters.Cool.DerivativeTime           := TempGroup.MtZone.Tuning.Out.PIDParameters.Cooling.DerivativeTime;
	TuneRecipe.ControlTune[3].PIDParameters.Cool.FilterTime               := TempGroup.MtZone.Tuning.Out.PIDParameters.Cooling.FilterTime;
	TuneRecipe.ControlTune[3].PIDParameters.Cool.IntegrationTime          := TempGroup.MtZone.Tuning.Out.PIDParameters.Cooling.IntegrationTime;
	TuneRecipe.ControlTune[3].PIDParameters.Cool.ProportionalGain         := TempGroup.MtZone.Tuning.Out.PIDParameters.Cooling.Gain;
	
END_FUNCTION
