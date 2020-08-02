(*********************************************************************************
 * Copyright:   
 * Author:    TylerWoodley 
 * Created:   July 28, 2020/1:57 PM 
 *********************************************************************************)

PROGRAM _CYCLIC
	
	gStateInfo.Temp := TempState;
	
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
	
	gMainCtrl.Status.AutotuneInProgress := TempStatus.TuningInProgress;
	
	FOR index := 0 TO 2 DO
		
		IF gTuneRecipe.Update THEN
			TempGroup.MpZones[index].In.Update := TRUE;
			UpdateControlParameters(gTuneRecipe.ControlTune[index], ADR(TempGroup.MpZones[index].In.Parameters));
		END_IF;
	  
		TempStatus.CurrentTemp[index]                   := gDio.ZoneTemps[index] / 10;
		TempStatus.SetTemp[index]                       := TempGroup.MpZones[index].Out.Info.SetTemperature;
		TempStatus.HeatOn[index]                        := TempGroup.MpZones[index].Out.Heat;
		TempStatus.CoolOn[index]                        := TempGroup.MpZones[index].Out.Cool;
		
		TempGroup.MpZones[index].In.ActualTemperature   := TempStatus.CurrentTemp[index];
		TempStatus.AtTemp[index]                        := (TempGroup.MpZones[index].In.ActualTemperature = TARGET_TEMP);
	
		TempControllerFBs[index].Enable                 := gTempInterface.Enables[index];
		TempControllerFBs[index].ErrorReset             := TempGroup.Cmd.ErrorReset;
		TempControllerFBs[index].Parameters             := ADR(TempGroup.MpZones[index].In.Parameters);
		TempControllerFBs[index].Update                 := TempGroup.MpZones[index].In.Update;
		TempControllerFBs[index].SetTemperature         := TempGroup.MpZones[index].In.SetTemperature;
		TempControllerFBs[index].ActualTemperature      := TempGroup.MpZones[index].In.ActualTemperature;
		TempControllerFBs[index].Control                := TempGroup.MpZones[index].In.Control;
		TempControllerFBs[index].Tune                   := TempGroup.MpZones[index].In.Tune;	
		
		TempGroup.MpZones[index].Out.Active             := TempControllerFBs[index].Active;
		TempGroup.MpZones[index].Out.ControlActive      := TempControllerFBs[index].ControlActive;
		TempGroup.MpZones[index].Out.Error              := TempControllerFBs[index].Error;
		TempGroup.MpZones[index].Out.Heat               := TempControllerFBs[index].Heat;
		TempGroup.MpZones[index].Out.Cool               := TempControllerFBs[index].Cool;
		TempGroup.MpZones[index].Out.Info               := TempControllerFBs[index].Info;
		TempGroup.MpZones[index].Out.StatusID           := TempControllerFBs[index].StatusID;
		TempGroup.MpZones[index].Out.UpdateDone         := TempControllerFBs[index].UpdateDone;	
		TempGroup.MpZones[index].Out.TuningDone         := TempControllerFBs[index].TuningDone;		
		
		gTempInterface.Status[index].ControlActive      := TempGroup.MpZones[index].Out.Active;
		gTempInterface.Status[index].FanOn              := TempGroup.MpZones[index].Out.Cool;
		gTempInterface.Status[index].HeatOn             := TempGroup.MpZones[index].Out.Heat;
		gTempInterface.Status[index].TuningInProgress   := TempGroup.MpZones[index].In.Tune;
		
		gTempInterface.Trends[index].ActualTemp         := TempStatus.CurrentTemp[index];
		gTempInterface.Trends[index].SetTemp            := TempStatus.SetTemp[index];
	END_FOR;
	
	IF gTuneRecipe.Update AND TempGroup.MpZones[ZONE_1_INDEX].Out.UpdateDone AND TempGroup.MpZones[ZONE_2_INDEX].Out.UpdateDone AND TempGroup.MpZones[ZONE_3_INDEX].Out.UpdateDone THEN
	  gTuneRecipe.Update := FALSE;
	END_IF;
	
	CASE TempState OF
		TEMP_INIT:
			TempState := TEMP_IDLE;
		TEMP_IDLE:			
			IF gMainCtrl.Cmd.HeatOn THEN
				TempState                               := TEMP_ON;
			ELSIF gMainCtrl.Cmd.AutotuneHeaters THEN				
				TempStatus.TuningInProgress         := TRUE;
				TempState                           := TEMP_AUTOTUNE;
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
END_PROGRAM
