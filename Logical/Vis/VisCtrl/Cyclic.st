(*********************************************************************************
 * Copyright:   
 * Author:    TylerWoodley 
 * Created:   July 30, 2020/11:50 AM 
 *********************************************************************************)

PROGRAM _CYCLIC
	FOR index := 0 TO 2 DO
		Vis.Temp.Trends[index] := gTempInterface.Trends[index];
		Vis.Temp.Status[index] := gTempInterface.Status[index];
	END_FOR;
	
	Vis.States := gStateInfo;	
	
	IF (Page = PAGE_START) THEN
		IF EDGEPOS(gMainState = MAIN_IDLE) THEN
			ChangePage := PAGE_MAIN;
		END_IF;	
	ELSE
	END_IF;

END_PROGRAM
