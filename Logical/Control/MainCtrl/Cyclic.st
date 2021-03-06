(*********************************************************************************
 * Copyright:   
 * Author:    TylerWoodley 
 * Created:   August 2, 2020/3:50 PM 
 *********************************************************************************)

PROGRAM _CYCLIC
	
	gStateInfo.Main := gMainState;
	
	gTuneRecipe     := gTempInterface.Recipe;

	CASE gMainState OF
		MAIN_INIT:
			gRecipeCtrl.Par.RecipeSaveIndex := gIndexOfLastLoadedTune;
			gRecipeCtrl.Cmd.LoadRecipe := TRUE;
			IF gRecipeCtrl.Status.CommandDone THEN
				gRecipeCtrl.Status.CommandDone := FALSE;
				gMainState := MAIN_IDLE;
			END_IF;						
		MAIN_IDLE:
			IF gRecipeCtrl.Cmd.SaveAutotune THEN
				gMainState := MAIN_AUTOTUNE;
			END_IF			
		MAIN_HEAT:			
		MAIN_AUTOTUNE:
			IF gMainCtrl.Status.AutotuneDone THEN
				IF gRecipeCtrl.Status.CommandDone THEN
					gRecipeCtrl.Status.CommandDone      := FALSE;
					gMainCtrl.Status.AutotuneDone       := FALSE;
					gMainState := MAIN_IDLE;
				ELSE
					gMainCtrl.Status.AutotuneInProgress := FALSE;
					gRecipeCtrl.Cmd.SaveAutotune        := TRUE;
				END_IF
			ELSE
				gMainCtrl.Status.AutotuneInProgress     := TRUE;
			END_IF					
		MAIN_ERROR:
	END_CASE;
	 
END_PROGRAM
