(*********************************************************************************
 * Copyright:   
 * Author:    TylerWoodley 
 * Created:   July 28, 2020/1:57 PM 
 *********************************************************************************)

PROGRAM _CYCLIC
	TempControllerFBs[ZONE_1_INDEX].MpLink := ADR(gTempController_1);
	TempControllerFBs[ZONE_2_INDEX].MpLink := ADR(gTempController_2);
	TempControllerFBs[ZONE_3_INDEX].MpLink := ADR(gTempController_3);
	
	TempGroup.Cmd.ErrorReset               := gMainCtrl.Cmd.ErrorReset;
	
	TempStatus.Error                       := TempGroup.MpZones[ZONE_1_INDEX].Out.Error OR
						                      TempGroup.MpZones[ZONE_2_INDEX].Out.Error OR
						                      TempGroup.MpZones[ZONE_3_INDEX].Out.Error;
	
	IF TempStatus.Error THEN 
		IF TempStatus.TuningInProgress THEN 
			TempState                      := TEMP_AUTOTUNE_ABORT;
		ELSE
			TempState                      := TEMP_ERROR;
		END_IF
	END_IF
	
	
	FOR index := 0 TO 2 DO
		
		IF gTuneRecipe.Update THEN
			TempGroup.MpZones[index].In.Update := TRUE;
			UpdateControlParameters(gTuneRecipe.ControlTune[index], ADR(TempGroup.MpZones[index].In.Parameters));
			gTuneRecipe.Update := FALSE;
		END_IF;
	  
		TempStatus.CurrentTemp[index]                 := gDio.ZoneTemps[index] / 10;
		TempStatus.SetTemp[index]                     := TempGroup.MpZones[index].Out.Info.SetTemperature;
		TempStatus.HeatOn[index]                      := TempGroup.MpZones[index].Out.Heat;
		TempStatus.CoolOn[index]                      := TempGroup.MpZones[index].Out.Cool;
		
		TempGroup.MpZones[index].In.ActualTemperature := TempStatus.CurrentTemp[index];
		TempStatus.AtTemp[index]                      := (TempGroup.MpZones[index].In.ActualTemperature = TARGET_TEMP);
	
		TempControllerFBs[index].Enable               := TRUE;
		TempControllerFBs[index].ErrorReset           := TempGroup.Cmd.ErrorReset;
		TempControllerFBs[index].Parameters           := ADR(TempGroup.MpZones[index].In.Parameters);
		TempControllerFBs[index].Update               := TempGroup.MpZones[index].In.Update;
		TempControllerFBs[index].SetTemperature       := TempGroup.MpZones[index].In.SetTemperature;
		TempControllerFBs[index].ActualTemperature    := TempGroup.MpZones[index].In.ActualTemperature;
		TempControllerFBs[index].Control              := TempGroup.MpZones[index].In.Control;
		TempControllerFBs[index].Tune                 := TempGroup.MpZones[index].In.Tune;	
		
		TempGroup.MpZones[index].Out.Active           := TempControllerFBs[index].Active;
		TempGroup.MpZones[index].Out.ControlActive    := TempControllerFBs[index].ControlActive;
		TempGroup.MpZones[index].Out.Error            := TempControllerFBs[index].Error;
		TempGroup.MpZones[index].Out.Heat             := TempControllerFBs[index].Heat;
		TempGroup.MpZones[index].Out.Cool             := TempControllerFBs[index].Cool;
		TempGroup.MpZones[index].Out.Info             := TempControllerFBs[index].Info;
		TempGroup.MpZones[index].Out.StatusID         := TempControllerFBs[index].StatusID;
		TempGroup.MpZones[index].Out.UpdateDone       := TempControllerFBs[index].UpdateDone;	
		TempGroup.MpZones[index].Out.TuningDone       := TempControllerFBs[index].TuningDone;		
		
	END_FOR;
	
	(*IF TempGroup.MtZone.Profile.Out.Error THEN 
		TempState := TEMP_ERROR;
	END_IF
	
	TempStatus.CurrentTemp[ZONE_4_INDEX]            := gDio.ZoneTemps[ZONE_4_INDEX] / 10;
	
	MtTempProfileFB.Enable                          := FALSE;
	MtTempProfileFB.AmbientTemperature              := gAmbientTemperature;
	MtTempProfileFB.MaxHeatOut                      := TempGroup.MtZone.Profile.In.MaxHeatOut;
	MtTempProfileFB.Mode                            := TempGroup.MtZone.Profile.In.Mode;
	MtTempProfileFB.Update                          := TempGroup.MtZone.Profile.In.Update;
	MtTempProfileFB.AmbientTemperature              := gAmbientTemperature;
	MtTempProfileFB.SetPointTemperature             := TempGroup.MtZone.Profile.In.SetPointTemperature;
	MtTempProfileFB.Start                           := TempGroup.MtZone.Profile.In.Start;
	MtTempProfileFB.Abort                           := TempGroup.MtZone.Profile.In.Abort;
	MtTempProfileFB.InitTemperature                 := gAmbientTemperature;
	MtTempProfileFB.Init                            := TempGroup.MtZone.Profile.In.Init;
	
	MtTempControllerFB.Enable                       := TempGroup.MtZone.Controller.In.Enable;
	MtTempControllerFB.PIDParameters                := TempGroup.MtZone.Controller.In.PIDParameters;
	MtTempControllerFB.MaxHeatOut                   := TempGroup.MtZone.Controller.In.MaxHeatOut;
	MtTempControllerFB.Update                       := TempGroup.MtZone.Controller.In.Update;
	MtTempControllerFB.SetTemperature               := TempGroup.MtZone.Controller.In.SetTemperature;
	MtTempControllerFB.ActTemperature               := TempGroup.MtZone.Controller.In.ActTemperature;
	MtTempControllerFB.FeedForwardHeat              := TempGroup.MtZone.Controller.In.FeedForwardHeat;
	MtTempControllerFB.ControlStatusIn              := TempGroup.MtZone.Controller.In.ControlStatusIn;
	
	MtTempTuningFB.Enable                           := TRUE;
	MtTempTuningFB.AmbientTemperature               := gAmbientTemperature;
	MtTempTuningFB.ActTemperature                   := TempGroup.MtZone.Tuning.In.ActTemperature;
	MtTempTuningFB.HeatIn                           := TempGroup.MtZone.Tuning.In.HeatIn;
	MtTempTuningFB.Mode                             := TempGroup.MtZone.Tuning.In.Mode;
	MtTempTuningFB.SetPointTemperature              := TempGroup.MtZone.Tuning.In.SetPointTemperature;
	MtTempTuningFB.StartSingleZone                  := TempGroup.MtZone.Tuning.In.StartSingleZone;
	MtTempTuningFB.Abort                            := TempGroup.MtZone.Cmd.Abort;
	
	TempGroup.MtZone.Profile.Out.Active             := MtTempProfileFB.Active;
	TempGroup.MtZone.Profile.Out.Error              := MtTempProfileFB.Error;
	TempGroup.MtZone.Profile.Out.StatusID           := MtTempProfileFB.StatusID;
	TempGroup.MtZone.Profile.Out.UpdateDone         := MtTempProfileFB.UpdateDone;
	TempGroup.MtZone.Profile.Out.SetTemperature     := MtTempProfileFB.SetTemperature;
	TempGroup.MtZone.Profile.Out.FeedForwardHeat    := MtTempProfileFB.FeedForwardHeat;
	TempGroup.MtZone.Profile.Out.FeedForwardCool    := MtTempProfileFB.FeedForwardCool;
	TempGroup.MtZone.Profile.Out.State              := MtTempProfileFB.State;
	TempGroup.MtZone.Profile.Out.InSetPoint         := MtTempProfileFB.InSetPoint;
	TempGroup.MtZone.Profile.Out.InitDone           := MtTempProfileFB.InitDone;
	
	TempGroup.MtZone.Controller.Out.Active          := MtTempControllerFB.Active;
	TempGroup.MtZone.Controller.Out.Error           := MtTempControllerFB.Error;
	TempGroup.MtZone.Controller.Out.StatusID        := MtTempControllerFB.StatusID;
	TempGroup.MtZone.Controller.Out.UpdateDone      := MtTempControllerFB.UpdateDone;
	TempGroup.MtZone.Controller.Out.HeatOut         := MtTempControllerFB.HeatOut;
	
	TempGroup.MtZone.Tuning.Out.Active              := MtTempTuningFB.Active;
	TempGroup.MtZone.Tuning.Out.Error               := MtTempTuningFB.Error;
	TempGroup.MtZone.Tuning.Out.StatusID            := MtTempTuningFB.StatusID;
	TempGroup.MtZone.Tuning.Out.SetTemperature      := MtTempTuningFB.SetTemperature;
	TempGroup.MtZone.Tuning.Out.FeedForwardHeat     := MtTempTuningFB.FeedForwardHeat;
	TempGroup.MtZone.Tuning.Out.TuningActive        := MtTempTuningFB.TuningActive;
	TempGroup.MtZone.Tuning.Out.TuningDone          := MtTempTuningFB.TuningDone;
	TempGroup.MtZone.Tuning.Out.State               := MtTempTuningFB.State;
	TempGroup.MtZone.Tuning.Out.PIDParameters       := MtTempTuningFB.PIDParameters;
	TempGroup.MtZone.Tuning.Out.PIDParametersValid  := MtTempTuningFB.PIDParametersValid;
	TempGroup.MtZone.Tuning.Out.ControlStatusOut    := MtTempTuningFB.ControlStatusOut;*)

	
	CASE TempState OF
		TEMP_INIT:
			(*TempGroup.MtZone.Profile.In.Init := TRUE;
			IF EDGEPOS(TempGroup.MtZone.Profile.Out.InitDone) THEN 
				TempState := TEMP_IDLE;
			END_IF	*)
			TempState := TEMP_IDLE;
		TEMP_IDLE:			
			IF gMainCtrl.Cmd.HeatOn THEN
				TempState                               := TEMP_ON;
			ELSIF gMainCtrl.Cmd.AutotuneHeaters THEN				
				TempStatus.TuningInProgress         := TRUE;
				TempState                           := TEMP_AUTOTUNE;
			ELSIF gMainCtrl.Cmd.AutotuneMtHeater THEN
				TempStatus.TuningInProgress         := TRUE;
				TempState                           := TEMP_AUTOTUNE_MTZONE;
			END_IF
			
		TEMP_ON:
			IF gMainCtrl.Cmd.HeatOn THEN
				FOR index := 0 TO 2 DO					
					TempGroup.MpZones[index].In.SetTemperature := TARGET_TEMP;
					TempGroup.MpZones[index].In.Control        := TRUE;
					gDio.HeatOn[index]                         := TempGroup.MpZones[index].Out.Heat;
					gDio.ZoneFans[index]                       := TempGroup.MpZones[index].Out.Cool;
				END_FOR;
			ELSE
				FOR index := 0 TO 2 DO
					TempGroup.MpZones[index].In.Control        := FALSE;
					gDio.HeatOn[index]                         := FALSE;
					gDio.ZoneFans[index]                       := FALSE;
				END_FOR;
				
				TempState                                      := TEMP_IDLE;
			END_IF
		(*TEMP_ON_MTZONE:
			TempGroup.MtZone.Controller.In.Enable          := TRUE;
			TempGroup.MtZone.Controller.In.SetTemperature  := TempGroup.MtZone.Profile.Out.SetTemperature;
			TempGroup.MtZone.Controller.In.FeedForwardHeat := TempGroup.MtZone.Profile.Out.FeedForwardHeat;
			gDio.HeatOn[ZONE_4_INDEX]                      := (TempGroup.MtZone.Controller.Out.HeatOut > 0);*)
		TEMP_AUTOTUNE:		
			
			IF gMainCtrl.Cmd.AbortTune THEN
				TempState                                := TEMP_AUTOTUNE_ABORT;
			ELSE
				gMainCtrl.Cmd.AutotuneHeaters            := FALSE;
				
				IF TempStatus.TuningInProgress THEN
				
					FOR index := 0 TO 2 DO
						TempGroup.MpZones[index].In.Tune := TRUE;
						gDio.HeatOn[index]               := TempGroup.MpZones[index].Out.Heat;
						gDio.ZoneFans[index]             := TempGroup.MpZones[index].Out.Cool;
					END_FOR;
					TempStatus.TuningInProgress          := NOT (TempGroup.MpZones[0].Out.TuningDone AND 
					TempGroup.MpZones[1].Out.TuningDone AND
					TempGroup.MpZones[2].Out.TuningDone);				
				ELSE
					FOR index := 0 TO 2 DO
						TempGroup.MpZones[index].In.Tune := FALSE;
						gDio.HeatOn[index]               := FALSE;
						gDio.ZoneFans[index]             := FALSE;					
					END_FOR;
					UpdateGlobalParameters(ADR(gTuneRecipe), TempGroup);
					gMainCtrl.Status.AutotuneDone        := TRUE;
					TempState                            := TEMP_IDLE;
				END_IF;
			END_IF;
			

			
		TEMP_AUTOTUNE_ABORT:
			FOR index := 0 TO 2 DO
				TempGroup.MpZones[index].In.Tune := FALSE;
				gDio.HeatOn[index]               := FALSE;
				gDio.ZoneFans[index]             := FALSE;					
			END_FOR;
			gMainCtrl.Status.AutotuneDone        := TRUE;
			
			IF TempStatus.Error THEN 
				TempState                        := TEMP_ERROR;
			ELSE
				TempState                        := TEMP_IDLE;
			END_IF
			
		(*TEMP_AUTOTUNE_MTZONE:
			IF NOT EDGEPOS(TempGroup.MtZone.Tuning.Out.TuningDone) THEN
				TempGroup.MtZone.Tuning.In.SetPointTemperature := TARGET_TEMP;
				TempGroup.MtZone.Tuning.In.StartSingleZone     := TRUE;
				TempGroup.MtZone.Tuning.In.ActTemperature      := TempStatus.CurrentTemp[ZONE_4_INDEX];
				TempGroup.MtZone.Tuning.In.HeatIn              := TempGroup.MtZone.Controller.Out.HeatOut;
				
				TempGroup.MtZone.Controller.In.Enable          := TempGroup.MtZone.Tuning.Out.Active;
				TempGroup.MtZone.Controller.In.SetTemperature  := TempGroup.MtZone.Tuning.Out.SetTemperature;
				TempGroup.MtZone.Controller.In.ActTemperature  := TempStatus.CurrentTemp[ZONE_4_INDEX];
				TempGroup.MtZone.Controller.In.FeedForwardHeat := TempGroup.MtZone.Tuning.Out.FeedForwardHeat;
				TempGroup.MtZone.Controller.In.ControlStatusIn := TempGroup.MtZone.Tuning.Out.ControlStatusOut;
				
				TempGroup.MtZone.Controller.In.PIDParameters   := TempGroup.MtZone.Tuning.Out.PIDParameters;
				TempGroup.MtZone.Controller.In.Update          := TempGroup.MtZone.Tuning.Out.PIDParametersValid;
				
				gDio.HeatOn[ZONE_4_INDEX]                      := (TempGroup.MtZone.Controller.Out.HeatOut > 0); 
			ELSE
				UpdateGlobalParameters(ADR(gTuneRecipe), TempGroup);
				gDio.HeatOn[ZONE_4_INDEX]                      := FALSE;
				TempGroup.MtZone.Tuning.In.StartSingleZone     := FALSE;
				gMainCtrl.Status.AutotuneDone                  := TRUE;
				TempState                                      := TEMP_IDLE;
			END_IF*)
			
		TEMP_ERROR:
			FOR index := 0 TO 2 DO
				TempGroup.MpZones[index].In.Tune     := FALSE;
			END_FOR;		
			FOR index := 0 TO 3 DO
				gDio.HeatOn[index]                   := FALSE;
				gDio.ZoneFans[index]                 := FALSE;
			END_FOR;
			TempGroup.MtZone.Cmd.Abort               := TRUE;
			TempStatus.TuningInProgress              := FALSE;
			IF TempGroup.Cmd.ErrorReset THEN
				TempStatus.Error                     := FALSE;
				TempGroup.MtZone.Cmd.Abort           := FALSE;
	  			TempState                            := TEMP_IDLE;
			END_IF;
	END_CASE;

	TempControllerFBs[ZONE_1_INDEX]();
	TempControllerFBs[ZONE_2_INDEX]();
	TempControllerFBs[ZONE_3_INDEX]();
	//MtTempControllerFB();
	//MtTempProfileFB();
	//MtTempTuningFB();
END_PROGRAM
