(*********************************************************************************
 * Copyright:   
 * Author:    TylerWoodley 
 * Created:   July 28, 2020/1:57 PM 
 *********************************************************************************)

PROGRAM _CYCLIC
	TempControllerFBs[0].MpLink := ADR(gTempController_1);
	TempControllerFBs[1].MpLink := ADR(gTempController_2);
	TempControllerFBs[2].MpLink := ADR(gTempController_3);
	
	FOR index := 0 TO 2 DO
	  
		TempStatus.CurrentTemp[index]                 := gDio.ZoneTemps[index] / 10;
		TempStatus.SetTemp[index]                     := TempControllerFBs[index].Info.SetTemperature;
		TempStatus.HeatOn[index]                      := TempGroup.MpZones[index].Out.Heat;
		TempStatus.CoolOn[index]                      := TempGroup.MpZones[index].Out.Cool;
		
		TempGroup.MpZones[index].In.ActualTemperature := TempStatus.CurrentTemp[index];
		TempStatus.AtTemp[index]                      := (TempGroup.MpZones[index].In.ActualTemperature = TARGET_TEMP);
	
		TempControllerFBs[index].Enable               := TRUE;
	
		TempControllerFBs[index].ErrorReset           := TempGroup.MpZones[index].In.ErrorReset;
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
	
	CASE TempState OF
		TEMP_INIT:
			TempState := TEMP_IDLE;
		TEMP_IDLE:			
			IF gMainCtrl.Cmd.HeatOn THEN
				TempState                           := TEMP_ON;
			ELSIF gMainCtrl.Cmd.AutotuneHeaters THEN
				TempStatus.TuningInProgress         := TRUE;
				TempState                           := TEMP_AUTOTUNE;				
			END_IF
			
		TEMP_ON:
			IF gMainCtrl.Cmd.HeatOn  AND NOT (TempStatus.AtTemp[0] AND TempStatus.AtTemp[1] AND TempStatus.AtTemp[2]) THEN
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
				gMainCtrl.Status.AutotuneDone        := TRUE;
				TempState                            := TEMP_IDLE;
			END_IF;

			
		TEMP_ERROR:
	END_CASE;

	TempControllerFBs[0]();
	TempControllerFBs[1]();
	TempControllerFBs[2]();
	
END_PROGRAM
