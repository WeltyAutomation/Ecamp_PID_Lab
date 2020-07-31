
PROGRAM _CYCLIC

	CASE gMainState OF
		MAIN_INIT:
			gMainState := MAIN_IDLE;			
		MAIN_IDLE:
			IF gRecipeCtrl.Cmd.SaveAutotune THEN
				gMainState := MAIN_AUTOTUNE;
			END_IF
			
		MAIN_HEAT:			
		MAIN_AUTOTUNE:
			IF gMainCtrl.Status.AutotuneDone THEN
				gMainCtrl.Status.AutotuneInProgress := FALSE;
				gRecipeCtrl.Cmd.SaveAutotune        := TRUE;
			ELSE
				gMainCtrl.Status.AutotuneInProgress := TRUE;
			END_IF
			
			
				
			IF gMainCtrl.Status.AutotuneDone AND NOT gRecipeCtrl.Status.SaveInProgress THEN				
				gRecipeCtrl.Status.CommandDone      := FALSE;
				gMainCtrl.Status.AutotuneDone       := FALSE;
				gMainState := MAIN_IDLE;
			ELSE
				
			END_IF;						
		MAIN_ERROR:
	END_CASE;
	 
END_PROGRAM
