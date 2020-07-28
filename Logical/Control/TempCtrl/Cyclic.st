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
	  
		TempGroup.MpZones[index].In.ActualTemperature := gDio.ZoneTemps[index] / 10;
		TempStatus.AtTemp[index]                      := (TempGroup.MpZones[index].In.ActualTemperature = TARGET_TEMP);
	
		TempControllerFBs[index].Enable               := TRUE;
	
		TempControllerFBs[index].ErrorReset           := TempGroup.MpZones[index].In.ErrorReset;
		TempControllerFBs[index].Parameters           := ADR(TempGroup.MpZones[index].In.Parameters);
		TempControllerFBs[index].Update               := TempGroup.MpZones[index].In.Update;
		TempControllerFBs[index].SetTemperature       := TempGroup.MpZones[index].In.SetTemperature;
		TempControllerFBs[index].ActualTemperature    := TempGroup.MpZones[index].In.ActualTemperature;
		TempControllerFBs[index].Control              := TempGroup.MpZones[index].In.Control;
	
		TempGroup.MpZones[index].Out.Active           := TempControllerFBs[index].Active;
		TempGroup.MpZones[index].Out.ControlActive    := TempControllerFBs[index].ControlActive;
		TempGroup.MpZones[index].Out.Cool             := TempControllerFBs[index].Cool;
		TempGroup.MpZones[index].Out.Error            := TempControllerFBs[index].Error;
		TempGroup.MpZones[index].Out.Heat             := TempControllerFBs[index].Heat;
		TempGroup.MpZones[index].Out.Info             := TempControllerFBs[index].Info;
		TempGroup.MpZones[index].Out.StatusID         := TempControllerFBs[index].StatusID;
		TempGroup.MpZones[index].Out.UpdateDone       := TempControllerFBs[index].UpdateDone;
	
		CASE TempState OF
			TEMP_INIT:
				TempState := TEMP_IDLE;
			TEMP_IDLE:
				IF gMainCtrl.Cmd.HeatOn THEN
					TempState := TEMP_ON;
				END_IF
			
			TEMP_ON:
				IF gMainCtrl.Cmd.HeatOn  AND NOT TempStatus.AtTemp[index] THEN 
					TempGroup.MpZones[index].In.SetTemperature := TARGET_TEMP;
					TempGroup.MpZones[index].In.Control        := TRUE;
					gDio.HeatOn[index]                         := TempGroup.MpZones[index].Out.Heat;
					gDio.ZoneFans[index]                       := TempGroup.MpZones[index].Out.Cool;
				ELSE
					TempGroup.MpZones[index].In.Control        := FALSE;
					gDio.HeatOn[index]                         := FALSE;
					gDio.ZoneFans[index]                       := FALSE;
					TempState                                  := TEMP_IDLE;
				END_IF
				
			TEMP_ERROR:
		END_CASE;
		
		TempControllerFBs[index]();
	END_FOR;	

END_PROGRAM
