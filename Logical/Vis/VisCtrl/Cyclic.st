(*********************************************************************************
 * Copyright:   
 * Author:    TylerWoodley 
 * Created:   July 30, 2020/11:50 AM 
 *********************************************************************************)

PROGRAM _CYCLIC
	
	FOR index := 0 TO 2 DO
		Vis.Temp.Trends[index] := gTempInterface.Trends[index];
		Vis.Temp.Status[index] := gTempInterface.Status[index];
		
		gTuneRecipe.ControlTune[index].PIDParameters := Vis.Temp.PID[index];
	END_FOR;
	//Page := ChangePage;
	
	IF Page = PAGE_START AND gMainState = MAIN_IDLE THEN 
		ChangePage := PAGE_MAIN;
	END_IF	
	 
END_PROGRAM
