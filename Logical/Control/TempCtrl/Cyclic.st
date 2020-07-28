
PROGRAM _CYCLIC
	TempControllerFBs[0].MpLink := ADR(gTempController_1);
	TempControllerFBs[1].MpLink := ADR(gTempController_2);
	TempControllerFBs[2].MpLink := ADR(gTempController_3);
	
	FOR CurrentTempController := 0 TO (SIZEOF(TempGroup.MpZones)/SIZEOF(TempGroup.MpZones[0])) DO
		
		TempControllerFBs[CurrentTempController].Enable            := TempGroup.MpZones[CurrentTempController].In.Enable;
		TempControllerFBs[CurrentTempController].ErrorReset        := TempGroup.MpZones[CurrentTempController].In.ErrorReset;
		TempControllerFBs[CurrentTempController].Parameters        := ADR(TempGroup.MpZones[CurrentTempController].In.Parameters);
		TempControllerFBs[CurrentTempController].Update            := TempGroup.MpZones[CurrentTempController].In.Update;
		TempControllerFBs[CurrentTempController].SetTemperature    := TempGroup.MpZones[CurrentTempController].In.SetTemperature;
		TempControllerFBs[CurrentTempController].ActualTemperature := TempGroup.MpZones[CurrentTempController].In.ActualTemperature;
		TempControllerFBs[CurrentTempController].Control           := TempGroup.MpZones[CurrentTempController].In.Control;
		
		TempGroup.MpZones[CurrentTempController].Out.Active        := TempControllerFBs[CurrentTempController].Active;
		TempGroup.MpZones[CurrentTempController].Out.Error         := TempControllerFBs[CurrentTempController].Active;
		TempGroup.MpZones[CurrentTempController].Out.StatusID      := TempControllerFBs[CurrentTempController].Active;
		TempGroup.MpZones[CurrentTempController].Out.UpdateDone    := TempControllerFBs[CurrentTempController].Active;
		TempGroup.MpZones[CurrentTempController].Out.Heat          := TempControllerFBs[CurrentTempController].Active;
		TempGroup.MpZones[CurrentTempController].Out.Cool          := TempControllerFBs[CurrentTempController].Active;
		TempGroup.MpZones[CurrentTempController].Out.ControlActive := TempControllerFBs[CurrentTempController].Active;
		TempGroup.MpZones[CurrentTempController].Out.Info          := TempControllerFBs[CurrentTempController].Info;
		
		CASE TempState OF
			TEMP_INIT:
			TEMP_IDLE:
			TEMP_ON:
				IF gMainCtrl.Cmd.HeatOn THEN 
					TempGroup.MpZones[CurrentTempController].In.SetTemperature := TARGET_TEMP;
					TempGroup.MpZones[CurrentTempController].In.Enable         := TRUE;					
				ELSE
					TempState := TEMP_IDLE;
				END_IF
				
			TEMP_ERROR:
		END_CASE;
		
	END_FOR;
	
	
	CASE TempState OF
		TEMP_INIT:
		TEMP_IDLE:
		TEMP_ON:			
		TEMP_ERROR:	  

	END_CASE;
	
	TempControllerFBs[0]();
	TempControllerFBs[1]();
	TempControllerFBs[2]();
END_PROGRAM
