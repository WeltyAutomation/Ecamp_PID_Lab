
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
				gRecipeCtrl.Cmd.SaveAutotune := TRUE;
				
			ELSIF gMainCtrl.Status.AutotuneDone AND gRecipeCtrl.Status.CommandDone THEN				
				gRecipeCtrl.Status.CommandDone := FALSE;
				gMainCtrl.Status.AutotuneDone  := FALSE;
				gMainState := MAIN_IDLE;
			END_IF;						
		MAIN_ERROR:
	END_CASE;
	 
END_PROGRAM
